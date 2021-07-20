--[[
Name: AutoBarSearch
Author: Toadkiller of Proudmoore
Website: http://www.wowace.com/
]]
-- Copyright 2007+ Toadkiller of Proudmoore.
-- http://muffinmangames.com

-- GLOBALS: GetItemInfo, GetItemSpell, GetMacroInfo, GetContainerNumSlots, GetContainerItemID, GetInventoryItemLink, UnitLevel, GetSpellLink, GetSpellInfo
-- GLOBALS: UpdateAddOnMemoryUsage, GetAddOnMemoryUsage
-- GLOBALS: C_ToyBox

local AutoBar = AutoBar
local ABGCS = AutoBarGlobalCodeSpace	--TODO: Replace all with ABGCocde, or just the global AB
local ABGCode = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject

local _

local AceOO = MMGHACKAceLibrary("AceOO-2.0")

AutoBarSearch = {}
AutoBarSearch.spells = {}
AutoBarSearch.toys = {}
AutoBarSearch.macros = {}
AutoBarSearch.macro_text = {}

AutoBarSearch.dirtyBags = {}
local searchSpace, items

-- Recycle lists will avoid garbage collection and memory thrashing but potentially grow over time
-- A simple 2 list aproach that recycles objects specific to that type of list so the bulk of operations should be only initing recycled objects.
local Recycle = AceOO.Class()
Recycle.virtual = true
Recycle.prototype.recycleList = 0
Recycle.prototype.dataList = 0

function Recycle.prototype:init()
	Recycle.super.prototype.init(self) -- Mandatory init.
	self.recycleList = {}
	self.dataList = {}
end

-- Returns a new or recycled list object
function Recycle.prototype:Create()
	if (self.recycleList[1]) then
		local i = # self.recycleList
		local x = self.recycleList[i]
		self.recycleList[i] = nil
		return x
	else
		return {}
	end
end

-- Adds some trash to the recycle list
-- do delete trash from the original list.
function Recycle.prototype:Recycle(p_trash)
	table.insert(self.recycleList, p_trash)
end



-- The search space with all items to look for
-- Tracks client buttons that are looking (for proper deletion)
--		{ itemId = {buttonKey, ...} }
local SearchSpace = AceOO.Class(Recycle)

-- Add a list of itemIds for the given buttonKey
function SearchSpace.prototype:Add(itemId, buttonKey)
	local clientButtons = self.dataList[itemId]
	if (not clientButtons) then
		clientButtons = self:Create()
		self.dataList[itemId] = clientButtons
	end
	clientButtons[buttonKey] = true
end

-- Remove a list of itemIds for the given buttonKey
function SearchSpace.prototype:Delete(itemId, buttonKey)
	local clientButtons = self.dataList[itemId]
	if (clientButtons) then
		clientButtons[buttonKey] = nil
	end
	if (# clientButtons == 0) then
		self:Recycle(clientButtons)
		self.dataList[itemId] = nil
	end
end

-- Remove and Recycle all items
function SearchSpace.prototype:Reset()
	for itemId, clientButtons in pairs(self.dataList) do
		for _i, buttonKey in pairs(clientButtons) do
			clientButtons[buttonKey] = nil
		end
		self:Recycle(clientButtons)
		self.dataList[itemId] = nil
	end
end

-- Testing & Debug function only
function SearchSpace.prototype:Contains(id)
	for itemId, _clientButtons in pairs(self.dataList) do
		if (itemId == id) then
			if (not AutoBarSearch.trace) then
				AutoBar:Print("SearchSpace.prototype:Contains    itemId " .. tostring(itemId))
			end
			return true
		end
	end
	return false
end

-- Return the search space list.
-- Do not manipulate the list.  It is only for performance when checking if an itemId is searched for
function SearchSpace.prototype:GetList()
	return self.dataList
end



-- List of items to search for per slot.  No duplicates, highest priority overwrites.
-- Synced to SearchSpace.  All SearchSpace changes are via Items
-- Should only be changed via Config, or hunter pet food swithes
-- Priority is slotIndex.categoryIndex
--		{ itemId = {category, slotIndex, categoryIndex} }
local Items = AceOO.Class(Recycle)

function Items.prototype:init()
	Items.super.prototype.init(self)
end

-- Add a list of itemIds for the given buttonKey
function Items.prototype:Add(itemList, buttonKey, category, slotIndex)
--AutoBar:Print("Items.prototype:Add    category " .. tostring(category) .. " itemList " .. tostring(itemList))
	if (not self.dataList[buttonKey]) then
		self.dataList[buttonKey] = {}
	end
	local buttonItems = self.dataList[buttonKey]
	for i, itemId in pairs(itemList) do
		local itemData = buttonItems[itemId]
		if (not itemData) then
			itemData = self:Create()
			buttonItems[itemId] = itemData
			itemData.category = category
			itemData.slotIndex = slotIndex
			itemData.categoryIndex = i
			AutoBarSearch.space:Add(itemId, buttonKey)
		elseif (slotIndex > itemData.slotIndex or (slotIndex == itemData.slotIndex and i >= itemData.categoryIndex)) then
			itemData.category = category
			itemData.slotIndex = slotIndex
			itemData.categoryIndex = i
		end
	end
end

-- Remove a list of itemIds for the given buttonKey
-- ToDo: on deletion reapply lower priority ones / track them from the start?
function Items.prototype:Delete(itemList, buttonKey, category, slotIndex)
	for _i, itemId in pairs(itemList) do
		local buttonItems = self.dataList[buttonKey]
		local itemData = buttonItems[itemId]
		if (itemData and slotIndex == itemData.slotIndex) then
			buttonItems[itemId] = nil
			self:Recycle(itemData)
			AutoBarSearch.space:Delete(itemId, buttonKey)
		end
	end
end

-- Remove and Recycle all items
function Items.prototype:Reset()
	for buttonKey, buttonItems in pairs(self.dataList) do
		for item_id, item_data in pairs(buttonItems) do
			buttonItems[item_id] = nil
		end
		self:Recycle(item_data)	--TODO: This is out of scope. WTF?
		if (not AutoBar.buttonList[buttonKey]) then
			self.dataList[buttonKey] = nil
		end
	end
end

-- Testing & Debug function only
function Items.prototype:Contains(id)
	for _buttonKey, buttonItems in pairs(self.dataList) do
		for itemId, _itemData in pairs(buttonItems) do
			if (itemId == id) then
				if (not AutoBarSearch.trace) then
					AutoBar:Print("Items.prototype:Contains    itemId " .. tostring(itemId))
				end
				return true
			end
		end
	end
	return false
end

-- Populate all the buttons
function Items.prototype:Populate()
	local function GetItems(slotItem)
		if (type(slotItem) == "string") then
			local categoryInfo = AutoBarCategoryList[slotItem]
			if (categoryInfo) then
				if (categoryInfo.spell) then
AutoBar:Print("Items.prototype:Populate   slotItem " .. tostring(slotItem))
--DevTools_Dump(AutoBarCategoryList["Spell.Portals"])
					return slotItem, categoryInfo.items, nil
				elseif (categoryInfo.spells) then
					return slotItem, categoryInfo.items, categoryInfo.spells
				else
					return slotItem, categoryInfo.items, nil
				end
			else
				return nil, nil, nil, nil, nil
			end
		else
			AutoBar:Print("Items.prototype:Populate    GetItems unknown type " .. tostring(type(slotItem)))
		end
	end

	for buttonKey, button in pairs(AutoBar.buttonList) do
		if (button and button[1]) then
			for slotIndex = 1, # button, 1 do
				local category, itemList, spells = GetItems(button[slotIndex])
				if (itemList) then
					self:Add(itemList, buttonKey, category, slotIndex)
				end
				if (spells) then
					self:Add(spells, buttonKey, category, slotIndex)
				end
			end
		end
	end

end
--/dump AutoBarSearch.sorted["AutoBarCustomButton7"]

-- Return the buttons search list.
-- Do not manipulate the list.  It is only for performance when checking if an itemId is searched for
function Items.prototype:GetList(buttonKey)
	if (buttonKey) then
		return self.dataList[buttonKey]
	else
		return self.dataList
	end
end


-- Map of bag, inventory and spell contents
-- Changes synced to Found
-- [bag][slot] = <itemId | nil>
local Stuff = AceOO.Class()

function Stuff.prototype:init()
	Stuff.super.prototype.init(self)
	self.dataList = {}
	for bag = 0, NUM_BAG_SLOTS, 1 do
		self.dataList[bag] = {}
	end
	self.dataList.inventory = {}
	self.dataList.spells = {}
end

-- Add itemId to bag, slot, spell
function Stuff.prototype:Add(itemId, bag, slot, spell)
	local slotList
	if (bag) then
		slotList = self.dataList[bag]
		slotList[slot] = itemId
	elseif (slot) then
		slotList = self.dataList.inventory
		slotList[slot] = itemId
	else
		slotList = self.dataList.spells
		slotList[spell] = itemId
	end

	--if(spell == "toy:127670") then print("Stuff.prototype:Add    itemId " .. tostring(itemId) .. " bag " .. tostring(bag) .. " slot " .. tostring(slot) .. " spell " .. tostring(spell)) end;
	if (bag or slot) then
		-- Filter out too high level items
		local itemMinLevel = select(5, GetItemInfo(itemId)) or 0;
		local usable = ABGCS.IsUsableItem(itemId);
		local item_spell = GetItemSpell(itemId);
		if (itemMinLevel <= AutoBar.playerLevel and (usable or not item_spell)) then
			AutoBarSearch.found:Add(itemId, bag, slot)
		end
	else
		AutoBarSearch.found:Add(itemId, bag, slot, spell)
	end
--AutoBar:Print("Stuff.prototype:Add bag " .. tostring(bag) .. " slot " .. tostring(slot))
end



-- Remove itemId from bag, slot, spell
function Stuff.prototype:Delete(itemId, bag, slot, spell)
	local slotList
	if (bag) then
		slotList = self.dataList[bag]
		slotList[slot] = nil
	elseif (slot) then
		slotList = self.dataList.inventory
		slotList[slot] = nil
	else
		slotList = self.dataList.spells
		slotList[spell] = nil
		--if(spell == "Wild Charge") then print("Stuff.prototype:Delete", itemId, bag, slot, spell) end;
	end

	AutoBarSearch.found:Delete(itemId, bag, slot, spell)
--AutoBar:Print("Stuff.prototype:Delete bag " .. tostring(bag) .. " slot " .. tostring(slot))
end



-- Scan the given bag.
function Stuff.prototype:ScanBag(bag)
	local slotList = self.dataList[bag]
	local itemId, oldItemId
	local nSlots = GetContainerNumSlots(bag)

--AutoBar:Print("Stuff.prototype:Scan bag " .. tostring(bag) .. " nSlots " .. tostring(nSlots) .. " slotList " .. tostring(slotList))

	-- ToDo: Clear out excess slots if bag got smaller

	for slot = 1, nSlots, 1 do
		itemId = GetContainerItemID(bag, slot)
		oldItemId = slotList[slot]

--AutoBar:Print("Stuff.prototype:Scan  itemId " .. tostring(itemId) .. " oldItemId " .. tostring(oldItemId))
		if (itemId) then
			if (oldItemId and oldItemId ~= itemId) then
				self:Delete(oldItemId, bag, slot)
				self:Add(itemId, bag, slot)
			elseif (not oldItemId) then
				self:Add(itemId, bag, slot, nil)
			end
		elseif (not itemId and oldItemId) then
			self:Delete(oldItemId, bag, slot, nil)
		end
	end
end

--As far as I know there is no way to get rid of a toy, so we don't need to ever delete anything
function Stuff.prototype:ScanToyBox()

	for toy_guid, toy_data in pairs(AutoBarSearch.toys) do
		AutoBarSearch:RegisterToy(toy_data.item_id);
		--print("Stuff.prototype:ScanToyBox - ", toy_guid, AB.Dump(toy_data))
		self:Add(toy_guid, nil, nil, toy_guid)
	end

end

function Stuff.prototype:ScanMacroText()

	for macro_text_guid, _macro_text_data in pairs(AutoBarSearch.macro_text) do
		--AutoBarSearch:RegisterToy(toy_data.item_id, toy_data.link);	--It's already registered if it's in AutoBarSearch.macro_text
		--print("Stuff.prototype:ScanMacroText - ", macro_text_guid, AB.Dump(macro_text_data))
		self:Add(macro_text_guid, nil, nil, macro_text_guid)
	end

end

-- Scan equipped inventory items.
function Stuff.prototype:ScanInventory()
	local slotList = self.dataList.inventory
	local _name, itemId, oldItemId

	-- Scan equipped items
	for slot = 1, 19 do
		_name, itemId = AutoBar.ItemLinkDecode(GetInventoryItemLink("player", slot))
		oldItemId = slotList[slot]

		if (itemId) then
			if (oldItemId and oldItemId ~= itemId) then
				self:Delete(oldItemId, nil, slot, nil)
				self:Add(itemId, nil, slot, nil)
			elseif (not oldItemId) then
				self:Add(itemId, nil, slot, nil)
			end
		elseif (not itemId and oldItemId) then
			self:Delete(oldItemId, nil, slot, nil)
		end
	end
end


-- Scan available Spells
function Stuff.prototype:ScanSpells()
	for spellName, spellInfo in pairs(AutoBarSearch.spells) do
		--local debug = (spellName == "Wild Charge")
		--if (debug) then AutoBar:Print("Stuff.prototype:ScanSpells    spellName " .. tostring(spellName)); end
		spellInfo.canCast = AutoBarSearch:CanCastSpell(spellName)
		--if (debug) then print("Spell Info:", AB.Dump(spellInfo)); end;
		AutoBarSearch:RegisterSpell(spellName, spellInfo.spell_id)
		if (spellInfo.canCast) then
			self:Add(spellName, nil, nil, spellName)
		else
			--if (debug) then print("Deleting:", spellName); end;
			self:Delete(spellName, nil, nil, spellName)
		end
	end
end


-- Scan available Macros
function Stuff.prototype:ScanMacros()
	for macroId, macroInfo in pairs(AutoBarSearch.macros) do
		if (macroInfo.macroIndex) then
			local _name, _icon_texture, body = GetMacroInfo(macroInfo.macroIndex)
			if (body) then
				self:Add(macroId, nil, nil, macroId)
			else
				self:Delete(macroId, nil, nil, macroId)
			end
		elseif (macroInfo.macroText) then
			self:Add(macroId, nil, nil, macroId)
		else
			self:Delete(macroId, nil, nil, macroId)
		end
	end
end


-- Scan bags only to support shuffling of stuff manually added or moved during combat.
function Stuff.prototype:ScanCombat()
	ABGCode.LogEventStart("Stuff.prototype:ScanCombat")
	for bag = 0, NUM_BAG_SLOTS, 1 do
		self:ScanBag(bag)
	end
	ABGCode.LogEventEnd("Stuff.prototype:ScanCombat")
end


-- Scan the requested Stuff.
function Stuff.prototype:Scan()
	ABGCode.LogEventStart("Stuff:Scan")
	AutoBar.playerLevel = UnitLevel("player")
	for bag = 0, NUM_BAG_SLOTS, 1 do
		if (AutoBarSearch.dirtyBags[bag]) then
			ABGCode.LogEventStart("AutoBar scanned bag")
--AutoBar:Print("Stuff.prototype:Scan    scanning bag ", bag);
			self:ScanBag(bag)
			ABGCode.LogEventEnd("AutoBar scanned bag", bag)
			AutoBarSearch.dirtyBags[bag] = nil
		end
	end

	if (AutoBarSearch.dirtyBags.macro_text) then
--AutoBar:Print("Stuff.prototype:Scan    scanning macro_text ");
		self:ScanMacroText()
		AutoBarSearch.dirtyBags.macro_text = false
	end

	if (AutoBarSearch.dirtyBags.toybox) then
--AutoBar:Print("Stuff.prototype:Scan    scanning toybox ");
		self:ScanToyBox()
		AutoBarSearch.dirtyBags.toybox = false
	end

	if (AutoBarSearch.dirtyBags.inventory) then
--AutoBar:Print("Stuff.prototype:Scan    scanning inventory ");
		self:ScanInventory()
		AutoBarSearch.dirtyBags.inventory = nil
	end

	if (AutoBarSearch.dirtyBags.spells) then
--AutoBar:Print("Stuff.prototype:Scan    scanning spells ");
		self:ScanSpells()
		AutoBarSearch.dirtyBags.spells = nil
	end

	if (AutoBarSearch.dirtyBags.macros) then
--AutoBar:Print("Stuff.prototype:Scan    scanning macros ");
		self:ScanMacros()
		AutoBarSearch.dirtyBags.macros = nil
	end

	ABGCode.LogEventEnd("Stuff:Scan")
end

-- Remove and Recycle all items
function Stuff.prototype:Reset()
	local slotList
	for bag = 0, NUM_BAG_SLOTS, 1 do
		slotList = self.dataList[bag]
		for i, _item_id in pairs(slotList) do
			slotList[i] = nil
		end
	end
	slotList = self.dataList.inventory
	for i, _item_id in pairs(slotList) do
		slotList[i] = nil
	end
end

-- Testing & Debug function only
function Stuff.prototype:Contains(id)
	local slotList
	local contains = nil
	for bag = 0, NUM_BAG_SLOTS, 1 do
		slotList = self.dataList[bag]
		for i, itemId in pairs(slotList) do
			if (itemId == id) then
				contains = true
				if (not AutoBarSearch.trace) then
					AutoBar:Print("Stuff.prototype:Contains    itemId " .. tostring(itemId).." at bag/slot " .. tostring(bag).." / " .. tostring(i))
				end
			end
		end
	end
	slotList = self.dataList.inventory
	for _i, itemId in pairs(slotList) do
		if (itemId == id) then
			contains = true
			if (not AutoBarSearch.trace) then
				AutoBar:Print("Stuff.prototype:Contains inventory    itemId " .. tostring(itemId))
			end
		end
	end
	slotList = self.dataList.spells
	for _i, itemId in pairs(slotList) do
		if (itemId == id) then
			contains = true
			if (not AutoBarSearch.trace) then
				AutoBar:Print("Stuff.prototype:Contains spells    itemId " .. tostring(itemId))
			end
		end
	end
	return contains
end


-- Return the Stuff list.
-- Do not manipulate the list.  It is only for performance.
function Stuff.prototype:GetList()
	return self.dataList
end


-- Found is a list of the different items found in bags & inventory
-- Syncs to Stuff and Current
-- itemId = { [bag, slot, spell], ... }
local Found = AceOO.Class(Recycle)

function Found.prototype:init()
	Found.super.prototype.init(self)
	self.dataList = {}
end

-- Add itemId to bag, slot
function Found.prototype:Add(itemId, bag, slot, spell)
	local itemData = self.dataList[itemId]
--AutoBar:Print("Found.prototype:Add    itemId " .. tostring(itemId) .. " bag " .. tostring(bag) .. " slot " .. tostring(slot) .. " spell ")
	if (not itemData) then
		itemData = self:Create()
		self.dataList[itemId] = itemData
		itemData[1] = bag
		itemData[2] = slot
		itemData[3] = spell

		-- First time Item found so add it everywhere
		if (searchSpace[itemId]) then
			AutoBarSearch.current:Merge(itemId)
		end

		-- Remove possible old entries left over from a Reset
		for i = # itemData, 4, -1 do
			itemData[i] = nil
		end
	else
		-- Item previously found so just record additional location
		local bFound = nil
		local i = 1
		while (true) do
			if (itemData[i] == bag and itemData[i + 1] == slot and itemData[i + 2] == spell) then
				bFound = true
				break
			end
			if (not (itemData[i] or itemData[i + 1] or itemData[i + 2])) then
				break
			end
			i = i + 3
		end
		if (not bFound) then
			itemData[i] = bag
			itemData[i + 1] = slot
			itemData[i + 2] = spell
--AutoBar:Print("Found.prototype:Add    itemId " .. tostring(itemId) .. " i " .. tostring(i) .. " bag " .. tostring(itemData[i]) .. " slot " .. tostring(itemData[i + 1]) .. " spell " .. tostring(itemData[i + 2]))
		end
	end
end

-- Remove bag, slot, spell for the itemId
function Found.prototype:Delete(itemId, bag, slot, spell)
	local itemData = self.dataList[itemId]
	--if (spell == "Wild Charge") then print("Found.prototype:Delete - itemId ",itemId," bag ",bag," slot ",slot," spell ", spell, "ItemData", itemData) end
	if (itemData) then
		local i = 1
		repeat
			if (itemData[i] == bag and itemData[i + 1] == slot and itemData[i + 2] == spell) then
				--AutoBar:Print("Found.prototype:Delete    itemData[i] " .. tostring(itemData[i]) .. " itemData[i + 1] " .. tostring(itemData[i + 1]) .. " itemData[i + 2] " .. tostring(itemData[i + 2]) .. " i " .. tostring(i))
				-- Move rest back
				local j = i
				repeat
					itemData[j] = itemData[j + 3]
					itemData[j + 1] = itemData[j + 4]
					itemData[j + 2] = itemData[j + 5]
					j = j + 1
				until (not (itemData[j] or itemData[j + 1] or itemData[j + 2]))
				break
			end
			i = i + 3
		until (not (itemData[i] or itemData[i + 1] or itemData[i + 2]))

		-- Item is now totally gone so remove it everywhere
		if (not (itemData[1] or itemData[2] or itemData[3])) then
			self.dataList[itemId] = nil
			self:Recycle(itemData)

			if (searchSpace[itemId]) then
				AutoBarSearch.current:Purge(itemId)
			end
		end
	end
end

-- Remove and Recycle all items
function Found.prototype:Reset()
	for itemId, itemData in pairs(self.dataList) do
		self.dataList[itemId] = nil
		self:Recycle(itemData)
		-- Clearing out itemData handled in Add
	end
end

-- Return number of slots for the itemId
function Found.prototype:GetTotalSlots(itemId)
	local itemData = self.dataList[itemId]
	local lastIndex
	if (itemData) then
		local i = 3
		while (true) do
			if (itemData[i] or itemData[i + 1] or itemData[i + 2]) then
				i = i + 3
			else
				break
			end
		end
		lastIndex = i / 3
	end
	return lastIndex
end

-- Return bag, slot, spell at index for the itemId
function Found.prototype:GetItemData(itemId, index)
	local itemData = self.dataList[itemId]
	if (index) then
		local offset = index * 3
		return itemData[offset - 2], itemData[offset - 1], itemData[offset]
	elseif (itemData) then
		return itemData[1], itemData[2], itemData[3]
	else
		return nil, nil, nil
	end
end

-- Nil out bag, slot, spell at index for the itemId
function Found.prototype:ClearItemData(itemId, index)
	local itemData = self.dataList[itemId]
	if (index) then
		local offset = index * 3
		itemData[offset - 2] = nil
		itemData[offset - 1] = nil
		itemData[offset] = nil
	end
end

-- Testing & Debug function only
function Found.prototype:Contains(id, count)
	for itemId, itemData in pairs(self.dataList) do
		if (itemId == id) then
			if (not AutoBarSearch.trace) then
				AutoBar:Print("Found.prototype:Contains    itemId " .. tostring(itemId))
			end
			if (count) then
				local nItems = # itemData
				local found = 0
				local i = 1
				while (i <= nItems) do
					if (itemData[i] or itemData[i + 1] or itemData[i + 2]) then
						found = found + 1
					end
					i = i + 3
				end
				if (found == count) then
					return true
				else
					return false
				end
			end
			return true
		end
	end
	return false
end

-- Return the buttons found list.
-- Do not manipulate the list.  It is only for performance.
function Found.prototype:GetList()
	return self.dataList
end


-- list of found items for the button
-- bag, slot synced to Stuff
-- { itemId, ... }
local Current = AceOO.Class()

function Current.prototype:init()
	Current.super.prototype.init(self)
	self.dataList = {}
end

-- Add the brand new item to any interested buttons
function Current.prototype:Merge(itemId)
	for buttonKey, searchItems in pairs(items) do
		if (searchItems and searchItems[itemId]) then
			local itemData = searchItems[itemId]
			self:Add(buttonKey, itemId)
--print("Current.prototype:Merge    itemId " .. tostring(itemId) .. " buttonKey " .. tostring(buttonKey), itemData.slotIndex, itemData.categoryIndex)
			AutoBarSearch.sorted:Add(buttonKey, itemId, itemData.slotIndex, itemData.categoryIndex)
		end
	end
end

-- Purge the defunct item from its client buttons
function Current.prototype:Purge(itemId)
	for buttonKey, searchItems in pairs(items) do
		if (searchItems and searchItems[itemId]) then
			self:Delete(buttonKey, itemId)
--AutoBar:Print("Current.prototype:Purge    itemId " .. tostring(itemId) .. " buttonKey " .. tostring(buttonKey))
			AutoBarSearch.sorted:Delete(buttonKey, itemId)
		end
	end
end

-- Add the found item to the list of itemIds for the given buttonKey
function Current.prototype:Add(buttonKey, itemId)
	if (not self.dataList[buttonKey]) then
		self.dataList[buttonKey] = {}
	end
	local buttonItems = self.dataList[buttonKey]
	buttonItems[itemId] = true
end

-- Remove the found item from the list of itemIds for the given buttonKey
-- ToDo: on deletion reapply lower priority ones / track them from the start?
function Current.prototype:Delete(buttonKey, itemId)
	if (not self.dataList[buttonKey]) then
		self.dataList[buttonKey] = {}
	end
	local buttonItems = self.dataList[buttonKey]
	buttonItems[itemId] = nil
end

-- Remove and Recycle all items
function Current.prototype:Reset()
	for buttonKey, buttonItems in pairs(self.dataList) do
		for itemId, itemData in pairs(buttonItems) do
			buttonItems[itemId] = nil
		end
		if (not AutoBar.buttonList[buttonKey]) then
			self.dataList[buttonKey] = nil
		end
	end
end

-- Testing & Debug function only
function Current.prototype:Contains(id)
	for buttonKey, buttonItems in pairs(self.dataList) do
		for itemId, itemData in pairs(buttonItems) do
			if (itemId == id) then
				if (not AutoBarSearch.trace) then
					AutoBar:Print("Current.prototype:Contains    itemId " .. tostring(itemId).." at buttonKey " .. tostring(buttonKey))
				end
				return true
			end
		end
	end
	return false
end

-- Return the buttons found list.
-- Do not manipulate the list.  It is only for performance.
function Current.prototype:GetList(buttonKey)
	if (buttonKey) then
		return self.dataList[buttonKey]
	else
		return self.dataList
	end
end


-- Sorted version of Current items for each button
-- Syncs to Items and Current
-- Verify / add items
-- n = { itemId, slotIndex, categoryIndex}, ... }
local Sorted = AceOO.Class(Recycle)

function Sorted.prototype:init()
	Sorted.super.prototype.init(self)
	self.promotedList = {}	-- Location current best usable item came from
	self.dirtyList = {}		-- Which lists need sorting
	self.dirty = nil		-- True if some list needs sorting
end

-- Add the found item to the list of itemIds for the given buttonKey
function Sorted.prototype:Add(buttonKey, itemId, slotIndex, categoryIndex)
	if (not self.dataList[buttonKey]) then
		self.dataList[buttonKey] = {}
	end
	local buttonItems = self.dataList[buttonKey]
	local bFound = nil

if (not itemId) then
	AutoBar:Print("Sorted.prototype:Add   bad itemId  " .. tostring(itemId))
end

	for _i, sortedItemData in ipairs(buttonItems) do
		if (sortedItemData.itemId == itemId) then
			bFound = true
			if (slotIndex > sortedItemData.slotIndex) then
				sortedItemData.slotIndex = slotIndex
				sortedItemData.categoryIndex = categoryIndex
				-- Do not need a subcheck for categoryIndex, as itemId should be unique per category
			end
			break
		end
	end
	if (not bFound) then
		local sortedItemData = self:Create()
		table.insert(buttonItems, sortedItemData)
		sortedItemData.itemId = itemId
		sortedItemData.slotIndex = slotIndex
		sortedItemData.categoryIndex = categoryIndex
	end
	self.dirtyList[buttonKey] = true
	self.dirty = true
end

-- Remove the found item from the list of itemIds for the given buttonKey
-- ToDo: on deletion reapply lower priority ones / track them from the start?
function Sorted.prototype:Delete(buttonKey, itemId)
	if (not self.dataList[buttonKey]) then
		self.dataList[buttonKey] = {}
	end
	local buttonItems = self.dataList[buttonKey]

	for i, sortedItemData in ipairs(buttonItems) do
		if (sortedItemData.itemId == itemId) then
			table.remove(buttonItems, i)
			self:Recycle(sortedItemData)
			break
		end
	end
	self.dirtyList[buttonKey] = true
	self.dirty = true
end

-- Sorting is descending order as we want the highest slot / index to have precedence
local function SortBySlotCategory(a, b)
	if (a and b) then
		if (a.slotIndex == b.slotIndex and a.categoryIndex and b.categoryIndex) then
			return a.categoryIndex > b.categoryIndex;
		else
			return a.slotIndex > b.slotIndex
		end
	else
		return true
	end
end

-- Dirty buttonKey or all Buttons if buttonKey is nil.
function Sorted.prototype:DirtyButtons(p_button_key)
	self.dirty = true
	if (p_button_key) then
		self.dirtyList[p_button_key] = true
	else
		for buttonKey in pairs(self.dataList) do
			self.dirtyList[buttonKey] = true
		end
	end
end

-- Update any dirty lists.
-- If index is specified then sort it only and do not change dirty state
function Sorted.prototype:Update(p_button_key)
	local oldDirty = nil
	if (p_button_key) then
		oldDirty = self.dirty
		self.dirty = true
		self.dirtyList[p_button_key] = true
	end
	if (self.dirty) then
		for buttonKey, sortList in pairs(self.dataList) do
			if (self.dirtyList[buttonKey]) then
				if (sortList) then
					table.sort(sortList, SortBySlotCategory)
					self:SetBest(buttonKey)
				end
				self.dirtyList[buttonKey] = nil
				AutoBarButton.dirtyButton[buttonKey] = true
			end
		end
		self.dirty = oldDirty
	end
end
--/dump AutoBarSearch.sorted.dirtyList["AutoBarCustomButton7"]
--/dump AutoBarSearch.sorted.dataList["AutoBarCustomButton7"]

-- Remove and Recycle all items
function Sorted.prototype:Reset()
	self.dirty = true
	for buttonKey, buttonItems in pairs(self.dataList) do
		for i, sortedItemData in pairs(buttonItems) do
			buttonItems[i] = nil
			self:Recycle(sortedItemData)
		end
		if (not AutoBar.buttonList[buttonKey]) then
			self.dataList[buttonKey] = nil
			self.dirtyList[buttonKey] = nil
		else
			self.dirtyList[buttonKey] = true
		end
	end
	self.dirty = true
end

-- Testing & Debug function only
function Sorted.prototype:Contains(itemId)
	for buttonKey, buttonItems in pairs(self.dataList) do
		for _i, sortedItemData in ipairs(buttonItems) do
			if (itemId == sortedItemData.itemId) then
				if (not AutoBarSearch.trace) then
					AutoBar:Print("Sorted.prototype:Contains    itemId " .. tostring(itemId).." at buttonKey " .. tostring(buttonKey))
				end
				return true
			end
		end
	end
	return false
end

-- Dirty a specific button
function Sorted.prototype:SetDirty(buttonKey)
	self.dirty = true
	self.dirtyList[buttonKey] = true
end

-- Completely reset everything and then rescan.
function Sorted.prototype:GetInfo(buttonKey, index)
	local sortedItems = self.dataList[buttonKey]
	if (not sortedItems) then
		return nil, nil, nil, nil, nil, nil
	end

	local found = AutoBarSearch.found:GetList()
	local bag, slot, spell, itemId, macroId, type_id, info_data, bpet_guid
	if (sortedItems[index]) then
		itemId = sortedItems[index].itemId
		if (found[itemId]) then
			bag = found[itemId][1]
			slot = found[itemId][2]
			spell = found[itemId][3]
		end
	end
	if (spell) then
		if(spell:find("^toy")) then
			type_id = ABGData.TYPE_TOY
			info_data = AutoBarSearch.toys[spell]
			spell = nil
		elseif(spell:find("^bpet")) then
			bpet_guid = spell		--TODO: This isn't used?
			spell = nil
		elseif(spell:find("^macrotext:")) then
			type_id = ABGData.TYPE_MACRO_TEXT
			info_data = AutoBarSearch.macro_text[spell]
			spell = nil
		elseif(spell:find("^macro")) then
			macroId = spell
			spell = nil
		end
	end
	return bag, slot, spell, itemId, macroId, type_id, info_data
end
-- /dump AutoBarSearch.items.dataList["AutoBarCustomButtonPlanning Mods"]
-- /dump AutoBarSearch.found:GetList()["customMacroCustomMinnaplanaMah Macro"]
-- /dump AutoBarSearch.sorted:GetList("AutoBarCustomButtonPlanning Mods")["customMacroCustomMinnaplanaMah Macro"]

-- Return the buttons sorted list.
-- Do not manipulate the list.  It is only for performance.
function Sorted.prototype:GetList(buttonKey)
	if (buttonKey) then
		return self.dataList[buttonKey]
	else
		return self.dataList
	end
end

local function swap(list, a, b)
	if (a ~= b) then
		local temp = list[a]
		list[a] = list[b]
		list[b] = temp
	end
end

-- Swap item to front if found
function Sorted.prototype:SwapToFront(sortedItems, itemId)
	for sortedIndex, sortedItemData in ipairs(sortedItems) do
		if (itemId == sortedItemData.itemId) then
			swap(sortedItems, 1, sortedIndex)
			return true
		end
	end
	return nil
end

-- After sorting make sure first item is usable
function Sorted.prototype:SetBest(buttonKey)
	local sortedItems = AutoBarSearch.sorted:GetList(buttonKey)
	local searchItems = AutoBarSearch.items:GetList()[buttonKey]
	assert(searchItems, "Sorted.prototype:SetBest items["..tostring(buttonKey).."] is nil")
	local itemId, category, categoryInfo, found

	local buttonDB = AutoBar.buttonDBList[buttonKey]
	if (buttonDB.equipped) then
		local _name, item_id = AutoBar.ItemLinkDecode(GetInventoryItemLink("player", buttonDB.equipped))
		if (self:SwapToFront(sortedItems, item_id)) then
			return
		else
			--ToDo: handle unknown items
		end
	end

	-- Move arrangeOnUse item to front of list
	local buttonData = AutoBar.db.char.buttonDataList[buttonKey]

	if (buttonData) then
		if (buttonData.SetBest) then
			if (buttonData.SetBest(self, buttonDB, buttonData, sortedItems, searchItems)) then
				return
			end
		end

		if (buttonData.arrangeOnUse) then
			itemId = buttonData.arrangeOnUse
			if (self:SwapToFront(sortedItems, itemId)) then
				return;
			end

			-- Remove item if not found
			--buttonData.arrangeOnUse = nil
		end
	end

	-- Restore correct sorting
	if (self.promotedList[buttonKey]) then
		swap(sortedItems, 1, self.promotedList[buttonKey])
		self.promotedList[buttonKey] = nil
	end

	for sortedIndex, sortedItemData in ipairs(sortedItems) do
		local good = true
		itemId = sortedItemData.itemId
		category = searchItems[itemId].category
		categoryInfo = AutoBarCategoryList[category]
-- n = { itemId, slotIndex, categoryIndex}, ... }
		if (categoryInfo) then
			if (categoryInfo.battleground and not AutoBar.inBG) then
				good = nil
			else
				if (categoryInfo.nonCombat and AutoBar.inCombat) then
					good = nil
				end
			end
		end

		if (good) then
			-- Swap it to first spot if not already there
			if (sortedIndex ~= 1) then
				swap(sortedItems, 1, sortedIndex)
				self.promotedList[buttonKey] = sortedIndex
			end
			break
		end
	end
end


-- Returns true if a spell can be cast at all
-- Therefore returns true if IsUsableSpell returns true or only mana is lacking or it exists in the spellbook
function AutoBarSearch:CanCastSpell(spellName)
	local spellInfo = AutoBarSearch.spells[spellName]
	if (not spellInfo or not spellInfo.canCast) then
		return false
	else
		return true
	end
end


-- Register a spell, and figure out its spellbook index for use in tooltip
-- Multiple calls refresh current state of the spell
-- {spellName = {canCast, spellLink, noSpellCheck}}
function AutoBarSearch:RegisterSpell(p_spell_name, p_spell_id, noSpellCheck, p_spell_link)

	local spellInfo = AutoBarSearch.spells[p_spell_name]

	--local debug = (p_spell_name == "Wild Charge")
	--if (debug) then print("AutoBarSearch:RegisterSpell", "Name:",p_spell_name, noSpellCheck, p_spell_link, GetSpellLink(p_spell_name)); end

	if (not spellInfo) then
		spellInfo = {}
		AutoBarSearch.spells[p_spell_name] = spellInfo
	end

	if (p_spell_link) then
		spellInfo.spellLink = p_spell_link
	else
		spellInfo.spellLink = GetSpellLink(p_spell_name)
	end

	if (p_spell_id) then
		spellInfo.spell_id = p_spell_id
	else
		spellInfo.spell_id = select(7, GetSpellInfo(p_spell_name))
	end


	if (noSpellCheck) then
		spellInfo.noSpellCheck = true
	end

	spellInfo.canCast = spellInfo.spellLink or spellInfo.noSpellCheck
	return p_spell_name
end

function AutoBarSearch:RegisterMacroText(p_macro_guid, p_macro_text, p_macro_icon_override, p_tooltip_override, p_hyperlink_override)

	local debug = false; --(p_macro_guid == 127670)
	local macro_text_info = AutoBarSearch.macro_text[p_macro_guid]

	if (not macro_text_info) then
		macro_text_info = {}
		AutoBarSearch.macro_text[p_macro_guid] = macro_text_info
	end

	if (p_macro_icon_override) then
		macro_text_info.icon = p_macro_icon_override
	else
		macro_text_info.icon = nil
	end

	if (p_tooltip_override) then
		macro_text_info.tooltip = p_tooltip_override
	else
		macro_text_info.tooltip = nil
	end

	if (p_hyperlink_override) then
		macro_text_info.link = p_hyperlink_override
	else
		macro_text_info.link = nil
	end


	macro_text_info.guid = p_macro_guid
	macro_text_info.macro_text = p_macro_text
	macro_text_info.ab_type = ABGData.TYPE_MACRO_TEXT

	if (debug) then print("AutoBarSearch:RegisterMacroText", "GUID:", p_macro_guid, "icon:", p_macro_icon_override, "text:", p_macro_text); end

end

function AutoBarSearch:RegisterToy(p_toy_id)

	local debug = false; --(p_toy_id == 127670)
	local toy_guid = ABGCS.ToyGUID(p_toy_id)
	local toy_info = AutoBarSearch.toys[toy_guid]

	if (not toy_info) then
		toy_info = {}
		AutoBarSearch.toys[toy_guid] = toy_info
	end

	toy_info.guid = toy_guid
	toy_info.item_id = p_toy_id
	toy_info.ab_type = ABGData.TYPE_TOY
	toy_info.icon = select(3, C_ToyBox.GetToyInfo(tonumber(p_toy_id)))

	if (debug) then print("AutoBarSearch:RegisterToy", "ID:", p_toy_id, toy_guid); end

end

-- Register a macro or customMacro
-- macroId is one of
-- 	"macro" .. macroIndex
-- 	"macroCustom" .. categoryKey .. "\n" .. macroName
-- {macroId = {macroIndex}|{macroName,macroText}}
function AutoBarSearch:RegisterMacro(macroId, macroIndex, macroName, macroText)
	local macroInfo = AutoBarSearch.macros[macroId]
	if (not macroInfo) then
		macroInfo = {}
		AutoBarSearch.macros[macroId] = macroInfo
	end

	macroInfo.macroIndex = macroIndex
	macroInfo.macroName = macroName
	macroInfo.macroText = macroText and strtrim(macroText) --TODO: Do this in the GUI
	if (macroInfo.macroText) then
		macroInfo.macro_action, macroInfo.macro_icon, macroInfo.macro_tooltip = ABGCode.GetActionForMacroBody(macroInfo.macroText)
	end
end


-- Call once only
function AutoBarSearch:Initialize()
	AutoBarSearch.space = SearchSpace:new()		-- All items to search for
	AutoBarSearch.items = Items:new()			-- Items to search for for each button + category etc.

	AutoBarSearch.sorted = Sorted:new()			-- Sorted version of Current items

	AutoBarSearch.current = Current:new()		-- Current items found for each button (Found intersect Items)
	AutoBarSearch.found = Found:new()			-- All items found in Stuff + list of bag, slot found in

	AutoBarSearch.stuff = Stuff:new()			-- Map of bags, inventory and spells

	searchSpace = AutoBarSearch.space:GetList()
	items = AutoBarSearch.items:GetList()
end

-- Empty everything
function AutoBarSearch:Empty()
	AutoBarSearch.space:Reset()
	AutoBarSearch.items:Reset()
	AutoBarSearch.sorted:Reset()
	AutoBarSearch.current:Reset()
	AutoBarSearch.found:Reset()
	AutoBarSearch.stuff:Reset()
end

-- Completely reset everything and then rescan.
function AutoBarSearch:Reset()
--AutoBar:Print("AutoBarSearch:Reset Start")
	AutoBarSearch:Empty()

	-- Add Items
	AutoBarSearch.items:Populate()
	for i = 0, NUM_BAG_SLOTS, 1 do
		AutoBarSearch.dirtyBags[i] = true
	end
	AutoBarSearch.dirtyBags.inventory = true
	AutoBarSearch.dirtyBags.toybox = true
	AutoBarSearch.dirtyBags.spells = true
	AutoBarSearch.dirtyBags.macros = true
	AutoBarSearch.dirtyBags.macro_text = true
	AutoBarSearch.dirty = true
	AutoBarSearch.stuff:Scan()
	AutoBarSearch.sorted:Update()
--AutoBar:Print("AutoBarSearch:Reset End")
end

-- Scan & sort based on current dirty lists
function AutoBarSearch:UpdateScan()
--AutoBar:Print("AutoBarSearch:Reset Start")
	-- ToDo: reimplement the dirty code
--	for i = 0, NUM_BAG_SLOTS, 1 do
--		AutoBarSearch.dirtyBags[i] = true
--	end
	AutoBarSearch.dirtyBags.inventory = true
--	AutoBarSearch.dirtyBags.toybox = true
	AutoBarSearch.dirtyBags.spells = true
	AutoBarSearch.dirtyBags.macros = true
	AutoBarSearch.dirty = true

	AutoBarSearch.stuff:Scan()
	AutoBarSearch.sorted:DirtyButtons()
	AutoBarSearch.sorted:Update()
--AutoBar:Print("AutoBarSearch:Reset End")
end

-- Testing & Debug function only
function AutoBarSearch:Contains(itemId)
	if (not AutoBarSearch.trace) then
		AutoBar:Print("\n\n   AutoBarSearch:Contains: " .. tostring(itemId))
	end
	local contains = nil

	contains = contains or AutoBarSearch.space:Contains(itemId)
	contains = contains or AutoBarSearch.items:Contains(itemId)
	contains = contains or AutoBarSearch.sorted:Contains(itemId)
	contains = contains or AutoBarSearch.current:Contains(itemId)
	contains = contains or AutoBarSearch.found:Contains(itemId)
	contains = contains or AutoBarSearch.stuff:Contains(itemId)

	return contains
end

--[[
-- Testing & Debug function only
function AutoBarSearch:DumpSlot(buttonKey)
	print("\n\n   AutoBarSearch:DumpSlot " .. tostring(buttonKey))
	print("items ")
	dump(AutoBarSearch.items:GetList(buttonKey))
	print("current ")
	dump(AutoBarSearch.current:GetList(buttonKey))
	print("sorted ")
	dump(AutoBarSearch.sorted:GetList(buttonKey))
end


-- Test harness		/script AutoBarSearch:Test()

function AutoBarSearch:Test()
	if (true and true) then
		AutoBarSearch.trace = true
		print("\nAutoBarSearch:Test start")
		AutoBarSearch:Empty()
		AutoBar.playerLevel = UnitLevel("player")

		UpdateAddOnMemoryUsage()
		local usedKB = GetAddOnMemoryUsage("AutoBar")
		print("usedKB = " .. usedKB)

		AutoBarSearch.items:Add({4536}, 1, nil, 1)
		assert(AutoBarSearch.items:Contains(4536), "AutoBarSearch.items:Add failed")
		assert(AutoBarSearch.space:Contains(4536), "AutoBarSearch.space:Add failed")
		AutoBarSearch.items:Delete({4536}, 1, nil, 1)
		assert(not AutoBarSearch.items:Contains(4536), "AutoBarSearch.items:Delete failed")
		assert(not AutoBarSearch.space:Contains(4536), "AutoBarSearch.space:Delete failed")
		AutoBarSearch.items:Add({4536, 6948, 4757}, 1, nil, 1)
--		AutoBar:Print("\n\n Items Added [1]")
--		DevTools_Dump(AutoBarSearch.items:GetList(1))
		assert(AutoBarSearch.items:Contains(4536), "AutoBarSearch.items:Add {4536, 6948, 4757} failed")
		assert(AutoBarSearch.items:Contains(6948), "AutoBarSearch.items:Add {4536, 6948, 4757} failed")
		assert(AutoBarSearch.items:Contains(4757), "AutoBarSearch.items:Add {4536, 6948, 4757} failed")
		assert(AutoBarSearch.space:Contains(4536), "AutoBarSearch.space:Add {4536, 6948, 4757} failed")
		assert(AutoBarSearch.space:Contains(6948), "AutoBarSearch.space:Add {4536, 6948, 4757} failed")
		assert(AutoBarSearch.space:Contains(4757), "AutoBarSearch.space:Add {4536, 6948, 4757} failed")

		AutoBarSearch.items:Add({787, 2070, 159}, "AutoBarButtonQuest", nil, 2)
		assert(AutoBarSearch.items:Contains(787), "AutoBarSearch.items:Add {787, 2070, 159} failed")
		assert(AutoBarSearch.items:Contains(2070), "AutoBarSearch.items:Add {787, 2070, 159} failed")
		assert(AutoBarSearch.items:Contains(159), "AutoBarSearch.items:Add {787, 2070, 159} failed")
		assert(AutoBarSearch.space:Contains(787), "AutoBarSearch.space:Add {787, 2070, 159} failed")
		assert(AutoBarSearch.space:Contains(2070), "AutoBarSearch.space:Add {787, 2070, 159} failed")
		assert(AutoBarSearch.space:Contains(159), "AutoBarSearch.space:Add {787, 2070, 159} failed")

		AutoBarSearch.stuff:Add(6948, 0, 1)
		assert(AutoBarSearch.stuff:Contains(6948), "AutoBarSearch.stuff:Add 6948 failed")
		AutoBarSearch.stuff:Delete(6948, 0, 1)
		assert(not AutoBarSearch.stuff:Contains(6948), "AutoBarSearch.stuff:Delete 6948 failed")

		-- Add something not looked for
		AutoBarSearch.stuff:Add(2130, 0, 1)
		assert(AutoBarSearch.stuff:Contains(2130), "AutoBarSearch.stuff:Add 2130 failed")
		assert(AutoBarSearch.found:Contains(2130), "AutoBarSearch.found:Add 2130 failed")
		assert(not AutoBarSearch.current:Contains(2130), "AutoBarSearch.current 2130 incorectly added")
		assert(not AutoBarSearch.sorted:Contains(2130), "AutoBarSearch.current 2130 incorectly added")

		-- Add something looked for
		AutoBarSearch.stuff:Add(6948, 0, 2)
		assert(AutoBarSearch.stuff:Contains(6948), "AutoBarSearch.stuff:Add 6948 failed")
		assert(AutoBarSearch.found:Contains(6948), "AutoBarSearch.found:Add 6948 failed")
		assert(AutoBarSearch.current:Contains(6948), "AutoBarSearch.current 6948 failed")
		assert(AutoBarSearch.sorted:Contains(6948), "AutoBarSearch.current 6948 failed")

		AutoBarSearch.stuff:Add(2132, 0, 3)
		assert(AutoBarSearch.stuff:Contains(2132), "AutoBarSearch.stuff:Add 2132 failed")
		assert(AutoBarSearch.found:Contains(2132), "AutoBarSearch.found:Add 2132 failed")
		assert(not AutoBarSearch.current:Contains(2132), "AutoBarSearch.current 2132 incorectly added")
		assert(not AutoBarSearch.sorted:Contains(2132), "AutoBarSearch.current 2132 incorectly added")

		AutoBarSearch.stuff:Add(4536, 0, 4)
		assert(AutoBarSearch.stuff:Contains(4536), "AutoBarSearch.stuff:Add 4536 failed")
		assert(AutoBarSearch.found:Contains(4536), "AutoBarSearch.found:Add 4536 failed")
		assert(AutoBarSearch.current:Contains(4536), "AutoBarSearch.current 4536 failed")
		assert(AutoBarSearch.sorted:Contains(4536), "AutoBarSearch.current 4536 failed")

		-- Add something looked for
		AutoBarSearch.stuff:Add(2070, 4, 1)
		assert(AutoBarSearch.stuff:Contains(2070), "AutoBarSearch.stuff:Add 2070 failed")
		assert(AutoBarSearch.found:Contains(2070), "AutoBarSearch.found:Add 2070 failed")
		assert(AutoBarSearch.current:Contains(2070), "AutoBarSearch.current 2070 failed")
		assert(AutoBarSearch.sorted:Contains(2070), "AutoBarSearch.current 2070 failed")

		AutoBarSearch.stuff:Add(787, 4, 2)
		assert(AutoBarSearch.stuff:Contains(787), "AutoBarSearch.stuff:Add 787 failed")
		assert(AutoBarSearch.found:Contains(787), "AutoBarSearch.found:Add 787 failed")
		assert(AutoBarSearch.current:Contains(787), "AutoBarSearch.current 787 failed")
		assert(AutoBarSearch.sorted:Contains(787), "AutoBarSearch.current 787 failed")

		AutoBarSearch.stuff:Add(159, 4, 3)
		assert(AutoBarSearch.stuff:Contains(159), "AutoBarSearch.stuff:Add 159 failed")
		assert(AutoBarSearch.found:Contains(159), "AutoBarSearch.found:Add 159 failed")
		assert(AutoBarSearch.current:Contains(159), "AutoBarSearch.current 159 failed")
		assert(AutoBarSearch.sorted:Contains(159), "AutoBarSearch.current 159 failed")

		AutoBarSearch.stuff:Add(4757, 0, 5)
		assert(AutoBarSearch.found:Contains(4757), "AutoBarSearch.found:Add 4757 failed")
		assert(AutoBarSearch.found:Contains(4757, 1), "AutoBarSearch.found:Add 4757 failed")
		AutoBarSearch.stuff:Add(4757, 2, 5)
		assert(AutoBarSearch.found:Contains(4757, 2), "AutoBarSearch.found:Add 4757 failed")
		AutoBarSearch.stuff:Add(4757, 1, 5)
		assert(AutoBarSearch.found:Contains(4757, 3), "AutoBarSearch.found:Add 4757 failed")
		assert(AutoBarSearch.stuff:Contains(4757), "AutoBarSearch.stuff:Add 4757 3/3 failed")
		assert(AutoBarSearch.current:Contains(4757), "AutoBarSearch.current 4757 failed")
		assert(AutoBarSearch.sorted:Contains(4757), "AutoBarSearch.current 4757 failed")

		AutoBarSearch.sorted:Update()
		local sorted = AutoBarSearch.sorted:GetList(1)
		assert(sorted[1].itemId == 4757, "AutoBarSearch.sorted 4757 failed")
		assert(sorted[2].itemId == 6948, "AutoBarSearch.sorted 4757 failed")
		assert(sorted[3].itemId == 4536, "AutoBarSearch.sorted 4757 failed")

		sorted = AutoBarSearch.sorted:GetList("AutoBarButtonQuest")
		assert(sorted[1].itemId == 159, "AutoBarSearch.sorted 159 failed")
		assert(sorted[2].itemId == 2070, "AutoBarSearch.sorted 2070 failed")
		assert(sorted[3].itemId == 787, "AutoBarSearch.sorted 787 failed")

		AutoBarSearch.stuff:Delete(2130, 0, 1)
		AutoBarSearch.stuff:Delete(6948, 0, 2)
		AutoBarSearch.stuff:Delete(2132, 0, 3)
		AutoBarSearch.stuff:Delete(4536, 0, 4)
		assert(not AutoBarSearch.stuff:Contains(2130), "AutoBarSearch.stuff:Delete 2130 failed")
		assert(not AutoBarSearch.stuff:Contains(6948), "AutoBarSearch.stuff:Delete 6948 failed")
		assert(not AutoBarSearch.stuff:Contains(2132), "AutoBarSearch.stuff:Delete 2132 failed")
		assert(not AutoBarSearch.stuff:Contains(4536), "AutoBarSearch.stuff:Delete 4536 failed")

		AutoBarSearch.stuff:Delete(4757, 0, 5)
		assert(AutoBarSearch.found:Contains(4757, 2), "AutoBarSearch.found:Delete 4757 1/3 failed")
		assert(AutoBarSearch.stuff:Contains(4757), "AutoBarSearch.stuff:Delete 4757 1/3 failed")
		assert(AutoBarSearch.current:Contains(4757), "AutoBarSearch.current 4757 1/3 failed")
		assert(AutoBarSearch.sorted:Contains(4757), "AutoBarSearch.current 4757 1/3 failed")
		AutoBarSearch.stuff:Delete(4757, 1, 5)
		assert(AutoBarSearch.found:Contains(4757, 1), "AutoBarSearch.found:Delete 4757 2/3 failed")
		assert(AutoBarSearch.stuff:Contains(4757), "AutoBarSearch.stuff:Delete 4757 2/3 failed")
		assert(AutoBarSearch.current:Contains(4757), "AutoBarSearch.current 4757 2/3 failed")
		assert(AutoBarSearch.sorted:Contains(4757), "AutoBarSearch.current 4757 2/3 failed")
		AutoBarSearch.stuff:Delete(4757, 2, 5)
		assert(not AutoBarSearch.found:Contains(4757), "AutoBarSearch.found:Delete 4757 3/3 failed")
		assert(not AutoBarSearch.stuff:Contains(4757), "AutoBarSearch.stuff:Delete 4757 3/3 failed")
		assert(not AutoBarSearch.current:Contains(4757), "AutoBarSearch.current 4757 3/3 failed")
		assert(not AutoBarSearch.sorted:Contains(4757), "AutoBarSearch.current 4757 3/3 failed")

		AutoBarSearch.items:Delete({4757}, 1, nil, 1)
		assert(not AutoBarSearch.items:Contains(4757), "AutoBarSearch.items:Delete 4757 failed")
		assert(not AutoBarSearch.space:Contains(4757), "AutoBarSearch.space:Delete 4757 failed")
		AutoBarSearch.items:Add({4757}, 1, nil, 1)
		AutoBarSearch.items:Delete({4536, 4757, 6948}, 1, nil, 1)
		assert(not AutoBarSearch.items:Contains(4757), "AutoBarSearch.items:Delete {4536, 6948, 4757} failed")
		assert(not AutoBarSearch.items:Contains(4536), "AutoBarSearch.items:Delete {4536, 6948, 4757} failed")
		assert(not AutoBarSearch.items:Contains(6948), "AutoBarSearch.items:Delete {4536, 6948, 4757} failed")
		assert(not AutoBarSearch.space:Contains(4757), "AutoBarSearch.space:Delete {4536, 6948, 4757} failed")
		assert(not AutoBarSearch.space:Contains(4536), "AutoBarSearch.space:Delete {4536, 6948, 4757} failed")
		assert(not AutoBarSearch.space:Contains(6948), "AutoBarSearch.space:Delete {4536, 6948, 4757} failed")

--		AutoBarSearch.items:Populate()
--		AutoBar:Print("\n\n SearchSpace")
--		DevTools_Dump(AutoBarSearch.space:GetList())

--		AutoBarSearch.items:Add({BS["Conjure Food"]}, 24, nil, 1)
--		AutoBarSearch.stuff:ScanSpells()
--		AutoBar:Print("\n\n SearchSpace")
--		DevTools_Dump(AutoBarSearch.space:GetList())

--		local bag0, bag1, bag2, bag3, bag4 = true, true, true, true, true
--		AutoBarSearch.stuff:Scan(bag0, bag1, bag2, bag3, bag4)

--		AutoBar:Print("\n\n Stuff")
--		DevTools_Dump(AutoBarSearch.stuff:GetList())
--
--		AutoBar:Print("\n\n Found")
--		DevTools_Dump(AutoBarSearch.found:GetList())
--
--		AutoBar:Print("\n\n Current")
--		DevTools_Dump(AutoBarSearch.current:GetList(1))
--
--		AutoBarSearch.sorted:Update()
--		AutoBar:Print("\n\n Sorted")
--		DevTools_Dump(AutoBarSearch.sorted:GetList())

		AutoBar:Print("AutoBarSearch:Test successful")
		AutoBarSearch:Reset()
		UpdateAddOnMemoryUsage()
		usedKB = GetAddOnMemoryUsage("AutoBar")
		AutoBar:Print("usedKB = " .. usedKB)
	end
end
--]]

--[[
/dump AutoBarSearch:CanCastSpell("Amani War Bear")
/script AutoBarSearch:DumpSlot("AutoBarButtonMount")
/script AutoBarSearch:Contains("Travel Form")
/dump (AutoBarSearch.sorted:GetList("CustomButton33"))
/dump (AutoBarSearch.sorted:GetList("AutoBarButtonCooldownPotionMana"))
/dump (AutoBarSearch.sorted:Update("AutoBarButtonCooldownPotionMana"))
/dump AutoBarSearch.space:GetList()
/dump (AutoBarSearch.sorted:GetList())
/dump (AutoBarSearch.sorted:GetList("Custom1"))
/dump (AutoBarSearch.found:GetList()[28104])
/dump (AutoBarSearch.stuff:GetList())
/dump (AutoBarCategoryList["Spell.Portals"])
/dump (AutoBarSearch.spells)
/script AutoBarSearch:Empty()
/script AutoBarSearch:Reset()
--]]