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

local _, AB = ... -- Pulls back the Addon-Local Variables and store them locally.


local AutoBar = AutoBar
local ABGCS = AutoBarGlobalCodeSpace	--TODO: Replace all with ABGCocde, or just the global AB
local ABGCode = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject

local AceOO = MMGHACKAceLibrary("AceOO-2.0")

AutoBarSearch = {

	---@type table<string, ABSpellInfo >
	registered_spells = {},	-- The "master list" of spells that are deemed relevant to the character

	---@type table<string, ABToyInfo >
	registered_toys = {},

	registered_macros = {},
	registered_macro_text = {},

	--This tracks the player's current inventory to filter out uneeded item changes
	---@type integer[]
	inventory_cache = {},

	bag_cache = {},

	--Flag structure to track dirty state of things
	dirty = {
		---@type boolean[]
		bags = {}
	},

	found = {
		dataList = {}
	}
}

local METHOD_DEBUG = false
local DEBUG_IDS = ABGCode.MakeSet({182773, 172179})
local DEBUG_GUIDS = ABGCode.MakeSet({ABGCode.ToyGUID(182773), ABGCode.ToyGUID(172179)})


-- Remove itemId from bag, slot, spell
local function delete_found_item(p_item_id, p_bag, p_slot, p_spell)

	if (p_bag) then
		local this_bag = AutoBarSearch.bag_cache[p_bag]
		this_bag[p_slot] = nil
	end

	AutoBarSearch.found:Delete(p_item_id, p_bag, p_slot, p_spell)
end


local function delete_inventory_item(p_item_id, p_slot)

	AutoBarSearch.found:Delete(p_item_id, nil, p_slot, nil)
	delete_found_item(p_item_id, nil, p_slot)
	AutoBarSearch.inventory_cache[p_slot] = nil

end


---Returns the ABSpellInfo for a given spell
---@param p_spell_name string
---@return ABSpellInfo
function AutoBarSearch.GetRegisteredSpellInfo(p_spell_name)

	local spell_info = AutoBarSearch.registered_spells[p_spell_name]

	return spell_info
end


-- -- Returns true if a spell can be cast at all
-- -- Therefore returns true if IsUsableSpell returns true or only mana is lacking or it exists in the spellbook
-- ---@param p_spell_name string
-- ---@return boolean
-- local function can_cast_spell(p_spell_name)
-- 	local spell_info = AutoBarSearch.registered_spells[p_spell_name]
-- 	if (not spell_info or not spell_info.can_cast) then
-- 		return false
-- 	else
-- 		return true
-- 	end
-- end


-- Recycle lists will avoid garbage collection and memory thrashing but potentially grow over time
-- A simple 2 list aproach that recycles objects specific to that type of list so the bulk of operations should be only initing recycled objects.
local Recycle = AceOO.Class()
Recycle.virtual = true
Recycle.prototype.dataList = 0

function Recycle.prototype:init()
	Recycle.super.prototype.init(self) -- Mandatory init.
	self.dataList = {}
end


-- The search space with all items to look for
-- Tracks client buttons that are looking (for proper deletion)
--		{ itemId = {buttonKey, ...} }
--#region SearchSpace
local SearchSpace = AceOO.Class(Recycle)

-- Add a list of itemIds for the given buttonKey
function SearchSpace.prototype:Add(itemId, buttonKey)
	local clientButtons = self.dataList[itemId]
	if (not clientButtons) then
		clientButtons = {}
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
		self.dataList[itemId] = nil
	end
end

-- Remove and Recycle all items
function SearchSpace.prototype:Reset()
	for itemId, clientButtons in pairs(self.dataList) do
		for _i, buttonKey in pairs(clientButtons) do
			clientButtons[buttonKey] = nil
		end
		self.dataList[itemId] = nil
	end
end


-- Return the search space list.
-- Do not manipulate the list.  It is only for performance when checking if an itemId is searched for
function SearchSpace.prototype:GetList()
	return self.dataList
end

--#endregion SearchSpace


-- List of items to search for per slot.  No duplicates, highest priority overwrites.
-- Synced to SearchSpace.  All SearchSpace changes are via Items
-- Should only be changed via Config, or hunter pet food switches
-- Priority is slotIndex.categoryIndex
--		{ itemId = {category, slotIndex, categoryIndex} }
--#region Items
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
			itemData = {}
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
function Items.prototype:Delete(itemList, buttonKey, _category, slotIndex)
	for _i, itemId in pairs(itemList) do
		local buttonItems = self.dataList[buttonKey]
		local itemData = buttonItems[itemId]
		if (itemData and slotIndex == itemData.slotIndex) then
			buttonItems[itemId] = nil
			AutoBarSearch.space:Delete(itemId, buttonKey)
		end
	end
end

-- Remove and Recycle all items
function Items.prototype:Reset()
	for buttonKey, buttonItems in pairs(self.dataList) do
		for item_id, _item_data in pairs(buttonItems) do
			buttonItems[item_id] = nil
		end
		if (not AutoBar.buttonList[buttonKey]) then
			self.dataList[buttonKey] = nil
		end
	end
end


local function get_items(p_category)
	---@class CategoryClass
	local categoryInfo = AutoBarCategoryList[p_category]
	if (categoryInfo) then
		return p_category, categoryInfo.items
	end

	return nil, nil

end

-- Populate all the buttons
function Items.prototype:Populate()
	if(METHOD_DEBUG) then ABGCode.LogWarning("Items:Populate"); end
	for buttonKey, button in pairs(AutoBar.buttonList) do
		if (button and button[1]) then
			for category_index = 1, # button, 1 do
				local category, item_list = get_items(button[category_index])
				--if(button[category_index] == "Muffin.Toys.Hearth") then ABGCode.LogWarning("   ", category, AB.Dump(item_list)) end
				if (item_list) then
					self:Add(item_list, buttonKey, category, category_index)
				end
			end
		end
	end

end

-- Re-Populate a  button
function Items.prototype:RePopulate(p_button_key)
	if(METHOD_DEBUG) then ABGCode.LogWarning("Items:RePopulate", p_button_key); end
	local button = AutoBar.buttonList[p_button_key]
	if (button and button[1]) then
		for slotIndex = 1, # button, 1 do
			local category, itemList = get_items(button[slotIndex])
			if(button[slotIndex] == "Muffin.Toys.Hearth") then ABGCode.LogWarning("   ", category, AB.Dump(itemList)) end
			if (itemList) then
				self:Add(itemList, p_button_key, category, slotIndex)
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

--#endregion Items



-- Found is a list of the different items found in bags & inventory
-- Syncs to Stuff and Current
-- itemId = { [bag, slot, spell], ... }
--#region Found

-- Add itemId to bag, slot
function AutoBarSearch.found:Add(itemId, bag, slot, spell)
	local searchSpace = AutoBarSearch.space:GetList()
	local debug = false --(DEBUG_GUIDS[itemId])
	if (debug) then ABGCode.LogWarning("Found:Add", itemId, bag, slot, spell, "-->foundData:", AB.Dump(self.dataList[itemId], 1), "space:", searchSpace[itemId]); end

	local itemData = self.dataList[itemId]
--AutoBar:Print("Found.prototype:Add    itemId " .. tostring(itemId) .. " bag " .. tostring(bag) .. " slot " .. tostring(slot) .. " spell ")
	if (not itemData) then
		if (debug) then ABGCode.LogWarning("   no itemData", searchSpace[itemId]); end
		itemData = {}
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
function AutoBarSearch.found:Delete(itemId, bag, slot, spell)
	local searchSpace = AutoBarSearch.space:GetList()
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

			if (searchSpace[itemId]) then
				AutoBarSearch.current:Purge(itemId)
			end
		end
	end
end

-- Remove and Recycle all items
function AutoBarSearch.found:Reset()
	for itemId, _itemData in pairs(self.dataList) do
		self.dataList[itemId] = nil
		-- Clearing out itemData handled in Add
	end
end

-- Return number of slots for the itemId
function AutoBarSearch.found:GetTotalSlots(itemId)
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
function AutoBarSearch.found:GetItemData(itemId, index)
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
function AutoBarSearch.found:ClearItemData(itemId, index)
	local itemData = self.dataList[itemId]
	if (index) then
		local offset = index * 3
		itemData[offset - 2] = nil
		itemData[offset - 1] = nil
		itemData[offset] = nil
	end
end



-- Return the buttons found list.
-- Do not manipulate the list.  It is only for performance.
function AutoBarSearch.found:GetList()
	return self.dataList
end

--#endregion Found

-- list of found items for the button
-- bag, slot synced to Stuff
-- { itemId, ... }
--#region Current
local Current = AceOO.Class()

function Current.prototype:init()
	Current.super.prototype.init(self)
	self.dataList = {}
end

-- Add the brand new item to any interested buttons
function Current.prototype:Merge(itemId)
	local debug = false --(DEBUG_GUIDS[itemId])
	if (debug) then ABGCode.LogWarning("Current:Merge", itemId); end

	local items = AutoBarSearch.items:GetList()
	for buttonKey, searchItems in pairs(items) do
		if (searchItems and searchItems[itemId]) then
			local itemData = searchItems[itemId]
			self:Add(buttonKey, itemId)
			--print("Current.prototype:Merge    itemId " .. tostring(itemId) .. " buttonKey " .. tostring(buttonKey), itemData.slotIndex, itemData.categoryIndex)
			if (debug) then ABGCode.LogWarning("Current:Merge itemId:", itemId, buttonKey); end
			AutoBarSearch.sorted:Add(buttonKey, itemId, itemData.slotIndex, itemData.categoryIndex)
		end
	end
end

-- Purge the defunct item from its client buttons
function Current.prototype:Purge(itemId)
	local items = AutoBarSearch.items:GetList()
	for buttonKey, searchItems in pairs(items) do
		local debug = false --(buttonKey == "AutoBarButtonHearth")
		if (searchItems and searchItems[itemId]) then
			self:Delete(buttonKey, itemId)
			--AutoBar:Print("Current.prototype:Purge    itemId " .. tostring(itemId) .. " buttonKey " .. tostring(buttonKey))
			if (debug) then ABGCode.LogWarning("Current:Purge itemId:", itemId); end
			AutoBarSearch.sorted:Delete(buttonKey, itemId)
		end
	end
end

-- Add the found item to the list of itemIds for the given buttonKey
function Current.prototype:Add(buttonKey, itemId)
	local debug = false --(DEBUG_IDS[itemId])
	if (debug) then ABGCode.LogWarning("Current:Add", buttonKey, itemId); end

	if (not self.dataList[buttonKey]) then
		self.dataList[buttonKey] = {}
	end
	local buttonItems = self.dataList[buttonKey]
	buttonItems[itemId] = true

end

-- Remove the found item from the list of itemIds for the given buttonKey
-- ToDo: on deletion reapply lower priority ones / track them from the start?
function Current.prototype:Delete(buttonKey, itemId)
	local debug = false --(buttonKey == "AutoBarButtonHearth")
	if (not self.dataList[buttonKey]) then
		self.dataList[buttonKey] = {}
	end
	local buttonItems = self.dataList[buttonKey]
	buttonItems[itemId] = nil
	if (debug) then ABGCode.LogWarning("Current:Delete itemId:", itemId); end
end

-- Remove and Recycle all items
function Current.prototype:Reset()
	for buttonKey, buttonItems in pairs(self.dataList) do
		for itemId, _item_data in pairs(buttonItems) do
			buttonItems[itemId] = nil
		end
		if (not AutoBar.buttonList[buttonKey]) then
			self.dataList[buttonKey] = nil
		end
	end
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

--#endregion Current

-- Sorted version of Current items for each button
-- Syncs to Items and Current
-- Verify / add items
-- n = { itemId, slotIndex, categoryIndex}, ... }
--#region Sorted
local Sorted = AceOO.Class(Recycle)

function Sorted.prototype:init()
	Sorted.super.prototype.init(self)
	self.promotedList = {}	-- Location current best usable item came from
	self.dirtyList = {}		-- Which lists need sorting
	self.dirty = nil		-- True if some list needs sorting
end

-- Add the found item to the list of itemIds for the given buttonKey
function Sorted.prototype:Add(buttonKey, itemId, slotIndex, categoryIndex)
	local debug = false --(DEBUG_IDS[itemId])
	if (debug) then ABGCode.LogWarning("Sorted:Add ", buttonKey, itemId, slotIndex, categoryIndex); end

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
		local sortedItemData = {}
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
	local debug = false --(buttonKey == "AutoBarButtonHearth")
	if (debug) then ABGCode.LogWarning("Sorted:Add itemId:", itemId); end

	if (not self.dataList[buttonKey]) then
		self.dataList[buttonKey] = {}
	end
	local buttonItems = self.dataList[buttonKey]

	for i, sortedItemData in ipairs(buttonItems) do
		if (sortedItemData.itemId == itemId) then
			table.remove(buttonItems, i)
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

	for buttonKey, buttonItems in pairs(self.dataList) do
		for i, _sortedItemData in pairs(buttonItems) do
			buttonItems[i] = nil
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
	local bag, slot, spell, itemId, macroId, type_id, info_data
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
			info_data = AutoBarSearch.registered_toys[spell]
			spell = nil
		elseif(spell:find("^macrotext:")) then
			type_id = ABGData.TYPE_MACRO_TEXT
			info_data = AutoBarSearch.registered_macro_text[spell]
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
	local itemId, category, categoryInfo

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
	local buttonData = AutoBar.char.buttonDataList[buttonKey]

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
				good = false
			else
				if (categoryInfo.nonCombat and AutoBar.inCombat) then
					good = false
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

--#endregion Current


-- Register a spell, and figure out its spellbook index for use in tooltip
-- Multiple calls refresh current state of the spell
-- {spellName = {can_cast, spell_link, no_spell_check, spell_id}}
---@param p_spell_name string
---@param p_spell_id integer
---@param p_no_spell_check boolean|nil
---@param p_spell_link string|nil
---@return boolean
function AutoBarSearch:RegisterSpell(p_spell_name, p_spell_id, p_no_spell_check, p_spell_link)

	if (p_no_spell_check == nil) then p_no_spell_check = false; end

	---@type ABSpellInfo
	local spellInfo = AutoBarSearch.registered_spells[p_spell_name]

	--local debug = (p_spell_name == "Wild Charge")
	--if (debug) then print("AutoBarSearch:RegisterSpell", "Name:",p_spell_name, p_no_spell_check, p_spell_link, GetSpellLink(p_spell_name)); end

	if (not spellInfo) then
		spellInfo = {}
		AutoBarSearch.registered_spells[p_spell_name] = spellInfo
	end

	if (p_spell_link) then
		spellInfo.spell_link = p_spell_link
	else
		spellInfo.spell_link = GetSpellLink(p_spell_name)
	end

	if (p_spell_id) then
		spellInfo.spell_id = p_spell_id
	else
		spellInfo.spell_id = select(7, GetSpellInfo(p_spell_name))
	end

	spellInfo.no_spell_check = p_no_spell_check

	spellInfo.can_cast = (spellInfo.spell_link ~= nil) or spellInfo.no_spell_check

	return spellInfo.can_cast
end

function AutoBarSearch:RegisterMacroText(p_macro_guid, p_macro_text, p_macro_icon_override, p_tooltip_override, p_hyperlink_override)

	local debug = false; --(p_macro_guid == 127670)
	local macro_text_info = AutoBarSearch.registered_macro_text[p_macro_guid]

	if (not macro_text_info) then
		macro_text_info = {}
		AutoBarSearch.registered_macro_text[p_macro_guid] = macro_text_info
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


---@param p_toy_id integer
---@return ABToyInfo
function AutoBarSearch:RegisterToy(p_toy_id)
	assert(type(p_toy_id) == "number")
	local debug = false --(DEBUG_IDS[p_toy_id])
	local toy_guid = ABGCS.ToyGUID(p_toy_id)
	local toy_info = AutoBarSearch.registered_toys[toy_guid]

	if (not toy_info) then
		toy_info = {
			ab_type = ABGData.TYPE_TOY,
			item_id = p_toy_id,
			guid = toy_guid,
		}
		AutoBarSearch.registered_toys[toy_guid] = toy_info
	end

	local _item_id, toy_name, icon, is_fave = C_ToyBox.GetToyInfo(p_toy_id)

	toy_info.name = toy_info.name or toy_name
	toy_info.icon = toy_info.icon or icon
	if(is_fave ~= nil) then
		toy_info.is_fave = is_fave
	end

	if (debug) then ABGCode.LogWarning("RegisterToy", "ID:", p_toy_id, "Name:", toy_name); end

	return toy_info
end

-- Register a macro or customMacro
-- macroId is one of
-- 	"macro" .. macroIndex
-- 	"macroCustom" .. categoryKey .. "\n" .. macroName
-- {macroId = {macroIndex}|{macroName,macroText}}
function AutoBarSearch:RegisterMacro(macroId, macroIndex, macroName, macroText)
	local macroInfo = AutoBarSearch.registered_macros[macroId]
	if (not macroInfo) then
		macroInfo = {}
		AutoBarSearch.registered_macros[macroId] = macroInfo
	end

	macroInfo.macroIndex = macroIndex
	macroInfo.macroName = macroName
	macroInfo.macroText = macroText and strtrim(macroText) --TODO: Do this in the GUI
	if (macroInfo.macroText) then
		macroInfo.macro_action, macroInfo.macro_icon, macroInfo.macro_tooltip = ABGCode.GetActionForMacroBody(macroInfo.macroText)
	end
end


local function init_dirty_flags()

	for i = 0, NUM_BAG_SLOTS, 1 do
		AutoBarSearch.dirty.bags[i] = true
	end

	AutoBarSearch.dirty.inventory = true
	AutoBarSearch.dirty.toybox = true
	AutoBarSearch.dirty.spells = true
	AutoBarSearch.dirty.macros = true
	AutoBarSearch.dirty.macro_text = true
end

-- Call once only
function AutoBarSearch:Initialize()
	AutoBarSearch.space = SearchSpace:new()		-- All items to search for
	AutoBarSearch.items = Items:new()			-- Items to search for for each button + category etc.

	AutoBarSearch.sorted = Sorted:new()			-- Sorted version of Current items

	AutoBarSearch.current = Current:new()		-- Current items found for each button (Found intersect Items)

	init_dirty_flags()

	for bag = 0, NUM_BAG_SLOTS, 1 do
		self.bag_cache[bag] = {}
	end
end

-- Empty everything
function AutoBarSearch:Empty()
	AutoBarSearch.space:Reset()
	AutoBarSearch.items:Reset()
	AutoBarSearch.sorted:Reset()
	AutoBarSearch.current:Reset()
	AutoBarSearch.found:Reset()

	wipe(self.inventory_cache)

	for bag = 0, NUM_BAG_SLOTS, 1 do
		wipe(self.bag_cache[bag])
	end

end

-- Completely reset everything and then rescan.
function AutoBarSearch:Reset()
--AutoBar:Print("AutoBarSearch:Reset Start")

	AutoBarSearch:Empty()

	AutoBarSearch.items:Populate()

	init_dirty_flags()
	AutoBarSearch:ScanAll()
	AutoBarSearch.sorted:Update()

--AutoBar:Print("AutoBarSearch:Reset End")
end

-- Scan & sort based on current dirty lists
function AutoBarSearch:UpdateScan()
--AutoBar:Print("AutoBarSearch:Reset Start")
	-- ToDo: reimplement the dirty code and remove the below auto-dirtying stuff since it defeats the purpose
	for i = 0, NUM_BAG_SLOTS, 1 do
		AutoBarSearch.dirty.bags[i] = true
	end

	AutoBarSearch.dirty.toybox = true
	AutoBarSearch.dirty.spells = true
	AutoBarSearch.dirty.macros = true

	AutoBarSearch:ScanAll()

	AutoBarSearch.sorted:DirtyButtons()
	AutoBarSearch.sorted:Update()
--AutoBar:Print("AutoBarSearch:Reset End")
end


function AutoBarSearch:MarkBagDirty(p_bag_idx)
	self.dirty.bags[p_bag_idx] = true
end


function AutoBarSearch:MarkInventoryDirty()
	self.dirty.inventory = true
end


-- Scan all of the bags
function AutoBarSearch:ScanDirtyBags()
	for bag = 0, NUM_BAG_SLOTS, 1 do
		if (AutoBarSearch.dirty.bags[bag]) then
			self:ScanBag(bag)
			AutoBarSearch.dirty.bags[bag] = nil
		end
	end
end


-- Scan bags only to support shuffling of bag items manually added or moved during combat.
function AutoBarSearch:ScanBagsInCombat()
	ABGCode.LogEventStart("Stuff.prototype:ScanCombat")
	for bag = 0, NUM_BAG_SLOTS, 1 do
		self:ScanBag(bag)
	end
	ABGCode.LogEventEnd("Stuff.prototype:ScanCombat")
end


---Scan all registered toys, refreshing their data and adding them to Stuff
function AutoBarSearch:ScanRegisteredToys()

	if (METHOD_DEBUG) then ABGCode.LogWarning("AutoBarSearch:ScanRegisteredToys", AutoBar:tcount(self.registered_toys)); end

	for toy_guid, toy_data in pairs(self.registered_toys) do
		self:RegisterToy(toy_data.item_id);
		self.found:Add(toy_guid, nil, nil, toy_guid)
	end

end


-- Scan registered Spells
function AutoBarSearch:ScanRegisteredSpells()

	for name, info in pairs(self.registered_spells) do
		local can_cast = self:RegisterSpell(name, info.spell_id)
		if (can_cast) then
			self.found:Add(name, nil, nil, name)
		else
			delete_found_item(name, nil, nil, name)
		end
	end

end


-- Scan registered Macros
function AutoBarSearch:ScanRegisteredMacros()

	for macro_id, macroInfo in pairs(self.registered_macros) do
		local keep = false
		if (macroInfo.macroIndex) then
			local _name, _icon_texture, body = GetMacroInfo(macroInfo.macroIndex)
			keep = (body ~= nil)
		else
			keep = (macroInfo.macroText ~= nil)
		end

		if(keep) then
			self.found:Add(macro_id, nil, nil, macro_id)
		else
			delete_found_item(macro_id, nil, nil, macro_id)
		end
	end

end


function AutoBarSearch:ScanRegisteredMacroText()

	for macro_text_guid, _macro_text_data in pairs(self.registered_macro_text) do
		self.found:Add(macro_text_guid, nil, nil, macro_text_guid)
	end

end

---@param p_item_id integer
---@param p_bag integer|nil
---@param p_slot integer
-- Add itemId to bag, slot
local function add_found_item(p_item_id, p_bag, p_slot)
	assert(p_bag and p_slot)

	local slotList = AutoBarSearch.bag_cache[p_bag]
	slotList[p_slot] = p_item_id

	-- Filter out too high level items
	local itemMinLevel = select(5, GetItemInfo(p_item_id)) or 0;
	local usable = ABGCS.IsUsableItem(p_item_id);
	local item_spell = GetItemSpell(p_item_id);
	if (itemMinLevel <= AutoBar.player_level and (usable or item_spell)) then
		AutoBarSearch.found:Add(p_item_id, p_bag, p_slot, nil)
	end
--AutoBar:Print("Stuff.prototype:Add bag " .. tostring(bag) .. " slot " .. tostring(slot))
end



-- Scan equipped inventory items.
function AutoBarSearch:ScanInventory()
	local inventory = self.inventory_cache
	local item_id, old_item_id

	-- Scan equipped items
	for slot = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
		item_id = GetInventoryItemID("player", slot)
		old_item_id = inventory[slot]

		if (item_id) then
			if (old_item_id and old_item_id ~= item_id) then
				delete_inventory_item(old_item_id, slot)
			end
			self.found:Add(item_id, nil, slot )
		elseif (old_item_id) then
			delete_inventory_item(old_item_id, slot)
		end

	end
end


-- Scan the given bag.
function AutoBarSearch:ScanBag(p_bag)
	local slotList = self.bag_cache[p_bag]
	local itemId, oldItemId
	local nSlots = AB.GetContainerNumSlots(p_bag)

	-- ToDo: Clear out excess slots if bag got smaller

	for slot = 1, nSlots, 1 do
		itemId = AB.GetContainerItemID(p_bag, slot)
		oldItemId = slotList[slot]

		if (itemId) then
			if (oldItemId and oldItemId ~= itemId) then
				delete_found_item(oldItemId, p_bag, slot)
			end
			add_found_item(itemId, p_bag, slot)
		elseif (not itemId and oldItemId) then
			delete_found_item(oldItemId, p_bag, slot)
		end
	end
end




-- Scan all of the things
function AutoBarSearch:ScanAll()
	ABGCode.LogEventStart("AutoBarSearch:ScanAll")

	-- Cache player's current level.  Used by CStuff.add_item for filtering
	AutoBar.player_level = UnitLevel("player")

	self:ScanDirtyBags()

	if (AutoBarSearch.dirty.inventory) then
		self:ScanInventory()
		AutoBarSearch.dirty.inventory = false
	end

	if (AutoBarSearch.dirty.toybox) then
		self:ScanRegisteredToys()
		AutoBarSearch.dirty.toybox = false
	end

	if (AutoBarSearch.dirty.spells) then
		self:ScanRegisteredSpells()
		AutoBarSearch.dirty.spells = false
	end

	if (AutoBarSearch.dirty.macros) then
		self:ScanRegisteredMacros()
		AutoBarSearch.dirty.macros = false
	end

	if (AutoBarSearch.dirty.macro_text) then
		self:ScanRegisteredMacroText()
		AutoBarSearch.dirty.macro_text = false
	end

	ABGCode.LogEventEnd("AutoBarSearch:ScanAll")
end
