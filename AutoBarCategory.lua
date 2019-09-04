--
-- AutoBarProfile
-- Copyright 2007+ Toadkiller of Proudmoore.
--
-- Categories for AutoBar
-- A Category encapsulates a list of items / spells etc. along with metadata describing their use.
-- http://muffinmangames.com
--

--	PeriodicGroup
--		description
--		texture
--		targeted
--		nonCombat
--		battleground
--		flying

--	AutoBar
--		spell
--		limit

local AutoBar = AutoBar
local ABGCS = AutoBarGlobalCodeSpace

local ABGData = AutoBarGlobalDataObject
local spellIconList = ABGData.spell_icon_list


AutoBarCategoryList = {}

local L = AutoBarGlobalDataObject.locale
local PT = LibStub("LibPeriodicTable-3.1")
local AceOO = AceLibrary("AceOO-2.0")
local _

-- List of categoryKey, category.description pairs for button categories
AutoBar.categoryValidateList = {}

local function sortList(a, b)
	local x = tonumber(a[2]);
	local y = tonumber(b[2]);

	if (x == y) then
		if (a[3]) then
			return false;
		else
			if (b[3]) then
				return true;
			else
				return false;
			end
		end
	else
		return x < y;
	end
end

-- Add items from set to rawList
-- If priority is true, the items will have priority over non-priority items with the same values
local function AddSetToRawItems(p_raw_list, p_set, p_priority)
	if (not p_raw_list) then
		p_raw_list = {}
	end
	if (p_set) then
		local cache_set = PT:GetSetTable(p_set)
		if (cache_set) then
			local index = # p_raw_list + 1
			for itemId, value in PT:IterateSet(p_set) do
				if (not value or type(value) == "boolean") then
					value = 0;
				end
				value = tonumber(value)
				p_raw_list[index] = {itemId, value, p_priority}
				index = index + 1
			end
		else
			print("AutoBar could not find the PT3.1 p_set ", p_set, ".  Make sure you have all the libraries AutoBar needs to function.")
		end
	end
	return p_raw_list
end

-- Convert rawList to a simple array of itemIds, ordered by their value in the set, and priority if any
local function RawListToItemIDList(p_raw_list)
	local itemArray = {}
	table.sort(p_raw_list, sortList)
	for i, j in ipairs(p_raw_list) do
		itemArray[i] = j[1]
	end
	return itemArray
end


-- Convert list of negative numbered spellId to spellName.
function PTSpellIDsToSpellName(p_cast_list)
--print("PTSpellIDsToSpellName castList " .. tostring(p_cast_list))

	for i = 1, # p_cast_list do
		local spellId = p_cast_list[i] * -1
		p_cast_list[i] = GetSpellInfo(spellId)
	end
	return p_cast_list
end



-- Add a spell to the list.
-- spellNameRight specifies a separate spell to cast on right click
-- If the spell is known (or noSpellCheck is active), copy it to the items list
local function AddSpellToCategory(p_category, p_spell_name_left, spellNameRight, itemsIndex)
	local noSpellCheck = p_category.noSpellCheck
	local spellNameLeft = nil
	local left_spell_id = nil
	local right_spell_id = nil
	--local tracked_spells = {["Swift Stormsaber"] = true, ["White Ram"] = true}
	--local debug_me = tracked_spells[p_spell_name_left]
--if (debug_me) then print(p_category.categoryKey,"(", p_spell_name_left, ",", spellNameRight, ",", itemsIndex,")", noSpellCheck) end

	--If the spells are not known by the player, their names are replaced with nil
	if (p_spell_name_left) then
		if (not noSpellCheck) then
			spellNameLeft, _, _, _, _, _, left_spell_id = GetSpellInfo(p_spell_name_left)
		else
			spellNameLeft = p_spell_name_left
		end
		if (not p_category.items) then
			p_category.items = {}
		end
	end
	if (spellNameRight) then
		if (not noSpellCheck) then
			spellNameRight, _, _, _, _, _, right_spell_id  = GetSpellInfo(spellNameRight)
		end
		if (not p_category.itemsRightClick) then
			p_category.itemsRightClick = {}
		end
	end

	--if (debug_me) then print("   AddSpellToCategory - spellname:", spellNameLeft) end


	if (spellNameLeft) then
		AutoBarSearch:RegisterSpell(p_spell_name_left, left_spell_id, noSpellCheck)
		p_category.items[itemsIndex] = p_spell_name_left
		if (spellNameRight) then
			AutoBarSearch:RegisterSpell(spellNameRight, right_spell_id, noSpellCheck)
			p_category.itemsRightClick[p_spell_name_left] = spellNameRight
--if (debug_me) then AutoBar:Print("AddSpellToCategory castable p_spellNameLeft " .. tostring(p_spell_name_left) .. " spellNameRight " .. tostring(spellNameRight)) end
		else
--			p_category.itemsRightClick[p_spell_name_left] = p_spell_name_left
--if (debug_me) then AutoBar:Print("AddSpellToCategory castable p_spellNameLeft " .. tostring(p_spell_name_left)) end
		end
		itemsIndex = itemsIndex + 1
	elseif (spellNameRight) then
		AutoBarSearch:RegisterSpell(spellNameRight, right_spell_id, noSpellCheck)
		p_category.items[itemsIndex] = spellNameRight
		p_category.itemsRightClick[spellNameRight] = spellNameRight
		itemsIndex = itemsIndex + 1
	end
	return itemsIndex
end



-- Mandatory attributes:
--		description - localized description
--		texture - display icon texture
-- Optional attributes:
--		targeted, nonCombat, battleground
AutoBarCategory = AceOO.Class()
AutoBarCategory.virtual = true

function AutoBarCategory.prototype:init(description, texture)
	AutoBarCategory.super.prototype.init(self) -- Mandatory init.

	self.categoryKey = description
	self.description = L[description]
	self.texture = texture

end

-- True if items can be targeted
function AutoBarCategory.prototype:SetTargeted(targeted)
	self.targeted = targeted
end

-- True if only usable outside combat
function AutoBarCategory.prototype:SetNonCombat(nonCombat)
	self.nonCombat = nonCombat
end


-- True if item is for battlegrounds only
function AutoBarCategory.prototype:SetBattleground(battleground)
	self.battleground = battleground
end


-- True if item the spell check should be skipped, used for things like Mounts(?) where the spell check would otherwise fail
function AutoBarCategory.prototype:SetNoSpellCheck(noSpellCheck)
	self.noSpellCheck = noSpellCheck
end







-- Return nil or list of spells matching player class
-- itemsPerLine defaults to 2 (class type, spell).
-- Only supports 2 & 3 for now.
function AutoBarCategory:FilterClass(castList, p_items_per_line)
	local spellName, index, filteredList2, filteredList3
	local items_per_line = p_items_per_line or 2


	-- Filter out CLASS spells from castList
	index = 1
	for i = 1, # castList, items_per_line do
		if (AutoBar.CLASS == castList[i] or "*" == castList[i]) then
			spellName = castList[i + 1]
			if (not filteredList2) then
				filteredList2 = {}
			end
			if (items_per_line == 3 and not filteredList3) then
				filteredList3 = {}
			end
			filteredList2[index] = spellName
			if (items_per_line == 3) then
				spellName = castList[i + 2]
				filteredList3[index] = spellName
			end
			index = index + 1
		end
	end
	return filteredList2, filteredList3
end



-- Reset the item list based on changed settings.
-- So pet change, Spellbook changed for spells, etc.
function AutoBarCategory.prototype:Refresh()
end




-- Category consisting of regular items, defined by PeriodicTable sets
AutoBarItems = AceOO.Class(AutoBarCategory)

-- ptItems, ptPriorityItems are PeriodicTable sets
-- priorityItems sort higher than items at the same value
function AutoBarItems.prototype:init(description, shortTexture, ptItems, ptPriorityItems)
	AutoBarItems.super.prototype.init(self, description, "Interface\\Icons\\" .. shortTexture) -- Mandatory init.
	self.ptItems = ptItems
	self.ptPriorityItems = ptPriorityItems

	local rawList = nil
	rawList = AddSetToRawItems(rawList, ptItems, false)
	if (ptPriorityItems) then
		rawList = AddSetToRawItems(rawList, ptPriorityItems, true)
	end
	self.items = RawListToItemIDList(rawList)
end

-- Reset the item list based on changed settings.
function AutoBarItems.prototype:Refresh()
end




-- Category consisting of regular items
AutoBarPetFood = AceOO.Class(AutoBarItems)

-- ptItems, ptPriorityItems are PeriodicTable sets
-- priorityItems sort higher than items at the same value
function AutoBarPetFood.prototype:init(description, shortTexture, ptItems, ptPriorityItems)
	AutoBarPetFood.super.prototype.init(self, description, "Interface\\Icons\\" .. shortTexture, ptItems, ptPriorityItems)

	self.castSpell = AutoBar:LoggedGetSpellInfo(6991, "Feed Pet")
end

-- Reset the item list based on changed settings.
function AutoBarPetFood.prototype:Refresh()
end


AutoBarMacroTextCategory = AceOO.Class(AutoBarCategory)

function AutoBarMacroTextCategory.prototype:init(description, shortTexture)
	AutoBarMacroTextCategory.super.prototype.init(self, description, shortTexture) -- Mandatory init.
	self.is_macro_text = true

	-- Current active items
	self.items = {}

	self:Refresh()

end

function AutoBarMacroTextCategory.prototype:Refresh()

	--Nothing to do

end

function AutoBarMacroTextCategory.prototype:AddMacroText(p_macro_text, p_macro_icon_override, p_tooltip_override, p_hyperlink_override)

	local next_index = #self.items + 1
	local guid = ABGCS:MacroTextGUID(p_macro_text)
	AutoBarSearch:RegisterMacroText(guid, p_macro_text, p_macro_icon_override, p_tooltip_override, p_hyperlink_override)
	self.items[next_index] = guid
end


-- Category consisting of spells
AutoBarSpells = AceOO.Class(AutoBarCategory)

-- castList, is of the form:
-- { "DRUID", "Flight Form", "DRUID", "Swift Flight Form", ["<class>", "<localized spell name>",] ... }
-- rightClickList, is of the form:
-- { "DRUID", "Mark of the Wild", "Gift of the Wild", ["<class>", "<localized spell name left click>", "<localized spell name right click>",] ... }
-- Pass in only one of castList, rightClickList
-- Icon from castList is used unless not available but rightClickList is
function AutoBarSpells.prototype:init(description, texture, castList, rightClickList, p_pt_set)
	AutoBarSpells.super.prototype.init(self, description, texture) -- Mandatory init.

--	if(p_pt_set) then
--	AutoBar:StupidLogEnable(true)
--	AutoBar:StupidLog("\nAutoBarSpells.prototype:init " .. description  .. "\n")
--	AutoBar:StupidLog(AutoBar:Dump(castList))
--	AutoBar:StupidLog(AutoBar:Dump(rightClickList))
--	AutoBar:StupidLog(AutoBar:Dump(p_pt_set))
--	end

	-- Filter out non CLASS spells from castList and rightClickList
	if (castList) then
		self.castList = AutoBarCategory:FilterClass(castList)
	end
	if (rightClickList) then
		self.castList, self.rightClickList = AutoBarCategory:FilterClass(rightClickList, 3)
	end

	--Convert a PT set to a list of localized spell names
	if (p_pt_set) then
		local rawList = nil
		rawList = AddSetToRawItems(rawList, p_pt_set, false)
		local id_list = RawListToItemIDList(rawList)
		self.castList = PTSpellIDsToSpellName(id_list)
	end

	-- Populate items based on currently castable spells
	self.items = {}
	if (self.rightClickList and not self.itemsRightClick) then
		self.itemsRightClick = {}
	end
	self:Refresh()

--		AutoBar:StupidLogEnable(false)

end

-- Reset the item list based on changed settings.
function AutoBarSpells.prototype:Refresh()
assert(self.items, "AutoBarSpells.prototype:Refresh wtf")

	local itemsIndex = 1

	if (self.castList and self.rightClickList) then
		for spellName in pairs(self.itemsRightClick) do
			self.itemsRightClick[spellName] = nil
		end

		for i = 1, # self.castList, 1 do
			local spellNameLeft, spellNameRight = self.castList[i], self.rightClickList[i]
--AutoBar:Print("AutoBarSpells.prototype:Refresh spellNameLeft " .. tostring(spellNameLeft) .. " spellNameRight " .. tostring(spellNameRight))
			itemsIndex = AddSpellToCategory(self, spellNameLeft, spellNameRight, itemsIndex)
		end
		for i = itemsIndex, # self.items, 1 do
			self.items[i] = nil
		end
	elseif (self.castList) then
		for _, spellName in ipairs(self.castList) do
			if (spellName) then
				itemsIndex = AddSpellToCategory(self, spellName, nil, itemsIndex)
			end
		end

		for i = itemsIndex, # self.items, 1 do
			self.items[i] = nil
		end
	end
end


-- Custom Category
AutoBarCustom = AceOO.Class(AutoBarCategory)

-- Return a unique key to use
function AutoBarCustom:GetCustomKey(customCategoryName)
	local newKey = "Custom" .. customCategoryName
	return newKey
end

-- Select an Icon to use
-- Add description verbatim to localization
function AutoBarCustom.prototype:init(customCategoriesDB)
	local description = customCategoriesDB.name
	if (not L[description]) then
		L[description] = description
	end

	-- Icon is first item found that is not an invalid spell
	local itemList = customCategoriesDB.items
	local itemType, itemId, itemInfo, spellName, spellClass, texture
	for index = # itemList, 1, -1 do
		local itemDB = itemList[index]
		itemType = itemDB.itemType
		itemId = itemDB.itemId
		itemInfo = itemDB.itemInfo
		spellName = itemDB.spellName
		spellClass = itemDB.spellClass
		texture = itemDB.texture
		if ((not spellClass) or (spellClass == AutoBar.CLASS)) then
			break
		end
	end
	if (itemType == "item") then
		texture = ABGCS:GetIconForItemID(tonumber(itemId))
	elseif (itemType == "spell") then
		if (spellName) then
			_, _, texture = GetSpellInfo(spellName)
		end
	elseif (itemType == "macro") then
		if (itemId) then
			_, texture = GetMacroInfo(itemId)
		end
	elseif (itemType == "macroCustom") then
		texture = texture or "Interface\\Icons\\INV_Misc_Gift_05"
	else
		texture = "Interface\\Icons\\INV_Misc_Gift_01"
	end

	AutoBarCustom.super.prototype.init(self, description, texture)
	self.customCategoriesDB = customCategoriesDB

--AutoBar:Print("AutoBarCustom.prototype:init customCategoriesDB " .. tostring(customCategoriesDB) .. " self.customCategoriesDB " .. tostring(self.customCategoriesDB))
	self.customKey = AutoBarCustom:GetCustomKey(description)
--AutoBar:Print("AutoBarCustom.prototype:init description " .. tostring(description) .. " customKey " .. tostring(self.customKey))
	self.items = {}
	self:Refresh()
end

-- If not used yet, change name to newName
-- Return the name in use either way
function AutoBarCustom.prototype:ChangeName(newName)
	local newCategoryKey = AutoBarCustom:GetCustomKey(newName)
	if (not AutoBarCategoryList[newCategoryKey]) then
		local oldCustomKey = self.customKey
		self.customKey = newCategoryKey
--AutoBar:Print("AutoBarCustom.prototype:ChangeName oldCustomKey " .. tostring(oldCustomKey) .. " newCategoryKey " .. tostring(newCategoryKey))
		AutoBarCategoryList[newCategoryKey] = AutoBarCategoryList[oldCustomKey]
		AutoBarCategoryList[oldCustomKey] = nil
		-- Update categoryValidateList
		AutoBar.categoryValidateList[newCategoryKey] = self.description
		AutoBar.categoryValidateList[oldCustomKey] = nil

		self.customCategoriesDB.name = newName
		self.customCategoriesDB.desc = newName
		self.customCategoriesDB.categoryKey = newCategoryKey
		self.description = newName
		self.categoryKey = newCategoryKey

		local customCategories = AutoBar.db.account.customCategories
		customCategories[newCategoryKey] = customCategories[oldCustomKey]
		customCategories[oldCustomKey] = nil
	end
	return self.customCategoriesDB.name
end
-- /dump AutoBarCategoryList["Custom.Custom"]
-- /dump AutoBarCategoryList["Custom.XXX"]


-- Return the unique name to use
function AutoBarCustom:GetNewName(baseName, index)
	local newName = baseName .. index
	local newKey = AutoBarCustom:GetCustomKey(newName)
	local customCategories = AutoBar.db.account.customCategories
	while (customCategories[newKey] or AutoBarCategoryList[newKey]) do
		index = index + 1
		newName = baseName .. index
		newKey = AutoBarCustom:GetCustomKey(newName)
	end
	return newName, newKey
end


-- Reset the item list based on changed settings.
function AutoBarCustom.prototype:Refresh()
	local itemList = self.customCategoriesDB.items
	local itemType, itemId
	local itemsIndex = 1

	for _, itemDB in ipairs(itemList) do
		itemType = itemDB.itemType
		itemId = itemDB.itemId
		if (itemType == "item") then
			self.items[itemsIndex] = itemId
			itemsIndex = itemsIndex + 1
		elseif (itemType == "spell" and itemDB.spellName) then
			if (itemDB.spellClass == AutoBar.CLASS) then
				itemsIndex = AddSpellToCategory(self, itemDB.spellName, nil, itemsIndex)
			end
		elseif (itemType == "macro") then
--AutoBar:Print("AutoBarCustom.prototype:Refresh --> itemDB.itemInfo " .. tostring(itemDB.itemInfo) .. " itemDB.itemId " .. tostring(itemDB.itemId))
			if (not itemDB.itemInfo) then
				itemDB.itemInfo = GetMacroInfo(itemId)
			end
			if (itemDB.itemInfo) then
				itemDB.itemId = GetMacroIndexByName(itemDB.itemInfo)
				itemId = itemDB.itemId
			end
--AutoBar:Print("AutoBarCustom.prototype:Refresh <-- itemDB.itemInfo " .. tostring(itemDB.itemInfo) .. " itemDB.itemId " .. tostring(itemDB.itemId))
			local macroId = "macro" .. itemId
			self.items[itemsIndex] = macroId
			itemsIndex = itemsIndex + 1
			AutoBarSearch:RegisterMacro(macroId, itemId)
		elseif (itemType == "macroCustom" and itemDB.itemInfo) then
			local macroId = "macroCustom" .. self.customCategoriesDB.categoryKey .. itemId
			self.items[itemsIndex] = macroId
			itemsIndex = itemsIndex + 1
			AutoBarSearch:RegisterMacro(macroId, nil, itemId, itemDB.itemInfo)
		end
	end

	-- Trim excess
	for index = itemsIndex, # self.items, 1 do
		self.items[index] = nil
	end
end
-- /dump AutoBarCategoryList["CustomArrangeTest"]


-- Create category list using PeriodicTable data.
function AutoBarCategory:Initialize()

	AutoBarCategoryList["Macro.Mount.SummonRandomFave"] = AutoBarMacroTextCategory:new( "Macro.Mount.SummonRandomFave", "achievement_guildperk_mountup")
	AutoBarCategoryList["Macro.Mount.SummonRandomFave"]:AddMacroText("/run C_MountJournal.SummonByID(0)",  "Interface/Icons/achievement_guildperk_mountup", L["Summon A Random Favourite Mount"])

	AutoBarCategoryList["Macro.Raid Target"] = AutoBarMacroTextCategory:new( "Raid Target", "Spell_BrokenHeart")
	for index = 1, 8 do
		AutoBarCategoryList["Macro.Raid Target"]:AddMacroText('/run SetRaidTarget("target", ' .. index .. ')',  "Interface/targetingframe/UI-RaidTargetingIcon_" .. index, L["Raid " .. index])
	end


	AutoBarCategoryList["Dynamic.Quest"] = AutoBarItems:new("Dynamic.Quest", "INV_Misc_Rune_01", nil)


	AutoBarCategoryList["Misc.Hearth"] = AutoBarItems:new("Misc.Hearth", "INV_Misc_Rune_01", "Misc.Hearth")

	AutoBarCategoryList["Consumable.Buff.Free Action"] = AutoBarItems:new( "Consumable.Buff.Free Action", "INV_Potion_04", "Consumable.Buff.Free Action")

	AutoBarCategoryList["Consumable.Anti-Venom"] = AutoBarItems:new( "Consumable.Anti-Venom", "INV_Drink_14", "Consumable.Anti-Venom")
	AutoBarCategoryList["Consumable.Anti-Venom"]:SetTargeted(true)

	AutoBarCategoryList["Misc.Battle Standard.Guild"] = AutoBarItems:new( "Misc.Battle Standard.Guild", "INV_BannerPVP_01", "Misc.Battle Standard.Guild")

	AutoBarCategoryList["Misc.Battle Standard.Battleground"] = AutoBarItems:new( "Misc.Battle Standard.Battleground", "INV_BannerPVP_01", "Misc.Battle Standard.Battleground")
	AutoBarCategoryList["Misc.Battle Standard.Battleground"]:SetBattleground(true)

	AutoBarCategoryList["Misc.Battle Standard.Alterac Valley"] = AutoBarItems:new( "Misc.Battle Standard.Alterac Valley", "INV_BannerPVP_02", "Misc.Battle Standard.Alterac Valley")

	AutoBarCategoryList["Muffin.Explosives"] = AutoBarItems:new( "Muffin.Explosives", "INV_Misc_Bomb_08", "Muffin.Explosives")
	AutoBarCategoryList["Muffin.Explosives"]:SetTargeted(true)

	AutoBarCategoryList["Misc.Engineering.Fireworks"] = AutoBarItems:new( "Misc.Engineering.Fireworks", "INV_Misc_MissileSmall_Red", "Misc.Engineering.Fireworks")

	AutoBarCategoryList["Tradeskill.Tool.Fishing.Bait"] = AutoBarItems:new( "Tradeskill.Tool.Fishing.Bait", "INV_Misc_Food_26", "Tradeskill.Tool.Fishing.Bait")

	AutoBarCategoryList["Tradeskill.Gather.Herbalism"] = AutoBarItems:new( "Tradeskill.Gather.Herbalism", "INV_Misc_HERB_01", "Tradeskill.Gather.Herbalism")

	AutoBarCategoryList["Tradeskill.Tool.Fishing.Gear"] = AutoBarItems:new( "Tradeskill.Tool.Fishing.Gear", "INV_Helmet_31", "Tradeskill.Tool.Fishing.Gear")

	AutoBarCategoryList["Tradeskill.Tool.Fishing.Lure"] = AutoBarItems:new( "Tradeskill.Tool.Fishing.Lure", "INV_Misc_Food_26", "Tradeskill.Tool.Fishing.Lure")
	AutoBarCategoryList["Tradeskill.Tool.Fishing.Lure"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Tradeskill.Tool.Fishing.Other"] = AutoBarItems:new( "Tradeskill.Tool.Fishing.Other", "INV_Drink_03", "Tradeskill.Tool.Fishing.Other")

	AutoBarCategoryList["Tradeskill.Tool.Fishing.Tool"] = AutoBarItems:new( "Tradeskill.Tool.Fishing.Tool", "INV_Fishingpole_01", "Tradeskill.Tool.Fishing.Tool")

	AutoBarCategoryList["Muffin.Skill.Fishing.Lure"] = AutoBarItems:new( "Muffin.Skill.Fishing.Lure", "INV_Misc_Food_26", "Muffin.Skill.Fishing.Lure")
	AutoBarCategoryList["Muffin.Skill.Fishing.Misc"] = AutoBarItems:new( "Muffin.Skill.Fishing.Misc", "INV_Misc_Food_26", "Muffin.Skill.Fishing.Misc")
	AutoBarCategoryList["Muffin.Skill.Fishing.Rare Fish"] = AutoBarItems:new( "Muffin.Skill.Fishing.Rare Fish", "INV_Misc_Food_26", "Muffin.Skill.Fishing.Rare Fish")

	AutoBarCategoryList["Consumable.Cooldown.Stone.Mana.Other"] = AutoBarItems:new( "Consumable.Cooldown.Stone.Mana.Other", "Spell_Shadow_SealOfKings", "Consumable.Cooldown.Stone.Mana.Other")

	AutoBarCategoryList["Consumable.Cooldown.Stone.Health.Other"] = AutoBarItems:new( "Consumable.Cooldown.Stone.Health.Other", "INV_Misc_Food_55", "Consumable.Cooldown.Stone.Health.Other")

	AutoBarCategoryList["Consumable.Bandage.Basic"] = AutoBarItems:new( "Consumable.Bandage.Basic", "INV_Misc_Bandage_Netherweave_Heavy", "Consumable.Bandage.Basic")
	AutoBarCategoryList["Consumable.Bandage.Basic"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Bandage.Battleground.Alterac Valley"] = AutoBarItems:new( "Consumable.Bandage.Battleground.Alterac Valley", "INV_Misc_Bandage_12", "Consumable.Bandage.Battleground.Alterac Valley")
	AutoBarCategoryList["Consumable.Bandage.Battleground.Alterac Valley"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Bandage.Battleground.Arathi Basin"] = AutoBarItems:new( "Consumable.Bandage.Battleground.Arathi Basin", "INV_Misc_Bandage_12", "Consumable.Bandage.Battleground.Arathi Basin")
	AutoBarCategoryList["Consumable.Bandage.Battleground.Arathi Basin"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Bandage.Battleground.Warsong Gulch"] = AutoBarItems:new( "Consumable.Bandage.Battleground.Warsong Gulch", "INV_Misc_Bandage_12", "Consumable.Bandage.Battleground.Warsong Gulch")
	AutoBarCategoryList["Consumable.Bandage.Battleground.Warsong Gulch"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Food.Edible.Basic.Non-Conjured"] = AutoBarItems:new( "Consumable.Food.Edible.Basic.Non-Conjured", "INV_Misc_Food_23", "Consumable.Food.Edible.Basic.Non-Conjured")
	AutoBarCategoryList["Consumable.Food.Edible.Basic.Non-Conjured"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Edible.Basic.Non-Conjured"] = AutoBarItems:new( "Consumable.Food.Edible.Basic.Non-Conjured", "INV_Misc_Food_23", "Consumable.Food.Edible.Basic.Non-Conjured")
	AutoBarCategoryList["Consumable.Food.Edible.Basic.Non-Conjured"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Food.Health.Basic"] = AutoBarItems:new( "Muffin.Food.Health.Basic", "INV_Misc_Food_23", "Muffin.Food.Health.Basic")
	AutoBarCategoryList["Muffin.Food.Health.Basic"]:SetNonCombat(true)


	AutoBarCategoryList["Consumable.Food.Edible.Battleground.Arathi Basin.Basic"] = AutoBarItems:new( "Consumable.Food.Edible.Battleground.Arathi Basin.Basic", "INV_Misc_Food_33", "Consumable.Food.Edible.Battleground.Arathi Basin.Basic")
	AutoBarCategoryList["Consumable.Food.Edible.Battleground.Arathi Basin.Basic"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Edible.Battleground.Warsong Gulch.Basic"] = AutoBarItems:new( "Consumable.Food.Edible.Battleground.Warsong Gulch.Basic", "INV_Misc_Food_33", "Consumable.Food.Edible.Battleground.Warsong Gulch.Basic")
	AutoBarCategoryList["Consumable.Food.Edible.Battleground.Warsong Gulch.Basic"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Combo Health"] = AutoBarItems:new( "Consumable.Food.Combo Health", "INV_Misc_Food_33", "Consumable.Food.Combo Health")
	AutoBarCategoryList["Consumable.Food.Combo Health"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Edible.Combo.Non-Conjured"] = AutoBarItems:new( "Consumable.Food.Edible.Combo.Non-Conjured", "INV_Misc_Food_95_Grainbread", "Consumable.Food.Edible.Combo.Non-Conjured")
	AutoBarCategoryList["Consumable.Food.Edible.Combo.Non-Conjured"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Food.Combo.Basic"] = AutoBarItems:new( "Muffin.Food.Combo.Basic", "INV_Misc_Food_95_Grainbread", "Muffin.Food.Combo.Basic")
	AutoBarCategoryList["Muffin.Food.Combo.Basic"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Food.Health.Buff"] = AutoBarItems:new( "Muffin.Food.Health.Buff", "INV_Misc_Food_95_Grainbread", "Muffin.Food.Health.Buff")
	AutoBarCategoryList["Muffin.Food.Health.Buff"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Food.Mana.Buff"] = AutoBarItems:new( "Muffin.Food.Mana.Buff", "INV_Misc_Food_95_Grainbread", "Muffin.Food.Mana.Buff")
	AutoBarCategoryList["Muffin.Food.Mana.Buff"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Food.Combo.Buff"] = AutoBarItems:new("Muffin.Food.Combo.Buff", "INV_Misc_Food_95_Grainbread", "Muffin.Food.Combo.Buff")
	AutoBarCategoryList["Muffin.Food.Combo.Buff"]:SetNonCombat(true)



	AutoBarCategoryList["Consumable.Food.Edible.Combo.Conjured"] = AutoBarItems:new( "Consumable.Food.Edible.Combo.Conjured", "inv_misc_food_73cinnamonroll", "Consumable.Food.Edible.Combo.Conjured")
	AutoBarCategoryList["Consumable.Food.Edible.Combo.Conjured"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Feast"] = AutoBarItems:new("Consumable.Food.Feast", "INV_Misc_Fish_52", "Consumable.Food.Feast")
	AutoBarCategoryList["Consumable.Food.Feast"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Percent.Basic"] = AutoBarItems:new("Consumable.Food.Percent.Basic", "INV_Misc_Food_60", "Consumable.Food.Percent.Basic")
	AutoBarCategoryList["Consumable.Food.Percent.Basic"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Percent.Bonus"] = AutoBarItems:new("Consumable.Food.Percent.Bonus", "INV_Misc_Food_62", "Consumable.Food.Percent.Bonus")
	AutoBarCategoryList["Consumable.Food.Percent.Bonus"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Combo Percent"] = AutoBarItems:new("Consumable.Food.Combo Percent", "INV_Food_ChristmasFruitCake_01", "Consumable.Food.Combo Percent")
	AutoBarCategoryList["Consumable.Food.Combo Percent"]:SetNonCombat(true)


	AutoBarCategoryList["Consumable.Food.Bread"] = AutoBarPetFood:new("Consumable.Food.Bread", "INV_Misc_Food_35", "Consumable.Food.Edible.Bread.Basic", "Consumable.Food.Edible.Basic.Conjured")
	AutoBarCategoryList["Consumable.Food.Bread"]:SetNonCombat(true)


	AutoBarCategoryList["Consumable.Food.Cheese"] = AutoBarPetFood:new( "Consumable.Food.Cheese", "INV_Misc_Food_37", "Consumable.Food.Edible.Cheese.Basic")
	AutoBarCategoryList["Consumable.Food.Cheese"]:SetNonCombat(true)


	AutoBarCategoryList["Consumable.Food.Fish"] = AutoBarPetFood:new("Consumable.Food.Fish", "INV_Misc_Fish_22", "Consumable.Food.Inedible.Fish", "Consumable.Food.Edible.Fish.Basic")
	AutoBarCategoryList["Consumable.Food.Fish"]:SetNonCombat(true)


	AutoBarCategoryList["Consumable.Food.Fruit"] = AutoBarPetFood:new( "Consumable.Food.Fruit", "INV_Misc_Food_19", "Consumable.Food.Edible.Fruit.Basic")
	AutoBarCategoryList["Consumable.Food.Fruit"]:SetNonCombat(true)


	AutoBarCategoryList["Consumable.Food.Fungus"] = AutoBarPetFood:new("Consumable.Food.Fungus", "INV_Mushroom_05", "Consumable.Food.Edible.Fungus.Basic")
	AutoBarCategoryList["Consumable.Food.Fungus"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Meat"] = AutoBarPetFood:new("Consumable.Food.Meat", "INV_Misc_Food_14", "Consumable.Food.Inedible.Meat", "Consumable.Food.Edible.Meat.Basic")
	AutoBarCategoryList["Consumable.Food.Meat"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Buff Pet"] = AutoBarPetFood:new("Consumable.Buff Pet", "INV_Misc_Food_87_SporelingSnack", "Consumable.Buff Pet")
	AutoBarCategoryList["Consumable.Buff Pet"]:SetTargeted("PET")

	AutoBarCategoryList["Consumable.Food.Bonus"] = AutoBarItems:new("Consumable.Food.Bonus", "INV_Misc_Food_47", "Consumable.Food.Bonus")
	AutoBarCategoryList["Consumable.Food.Bonus"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Agility"] = AutoBarItems:new( "Consumable.Food.Buff.Agility", "INV_Misc_Fish_13", "Consumable.Food.Buff.Agility")
	AutoBarCategoryList["Consumable.Food.Buff.Agility"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Attack Power"] = AutoBarItems:new( "Consumable.Food.Buff.Attack Power", "INV_Misc_Fish_13", "Consumable.Food.Buff.Attack Power")
	AutoBarCategoryList["Consumable.Food.Buff.Attack Power"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Healing"] = AutoBarItems:new( "Consumable.Food.Buff.Healing", "INV_Misc_Fish_13", "Consumable.Food.Buff.Healing")
	AutoBarCategoryList["Consumable.Food.Buff.Healing"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.HP Regen"] = AutoBarItems:new( "Consumable.Food.Buff.HP Regen", "INV_Misc_Fish_19", "Consumable.Food.Buff.HP Regen")
	AutoBarCategoryList["Consumable.Food.Buff.HP Regen"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Intellect"] = AutoBarItems:new( "Consumable.Food.Buff.Intellect", "INV_Misc_Food_63", "Consumable.Food.Buff.Intellect")
	AutoBarCategoryList["Consumable.Food.Buff.Intellect"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Mana Regen"] = AutoBarItems:new( "Consumable.Food.Buff.Mana Regen", "INV_Drink_17", "Consumable.Food.Buff.Mana Regen")
	AutoBarCategoryList["Consumable.Food.Buff.Mana Regen"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Spell Damage"] = AutoBarItems:new( "Consumable.Food.Buff.Spell Damage", "INV_Misc_Food_65", "Consumable.Food.Buff.Spell Damage")
	AutoBarCategoryList["Consumable.Food.Buff.Spell Damage"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Spirit"] = AutoBarItems:new( "Consumable.Food.Buff.Spirit", "INV_Misc_Fish_03", "Consumable.Food.Buff.Spirit")
	AutoBarCategoryList["Consumable.Food.Buff.Spirit"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Stamina"] = AutoBarItems:new( "Consumable.Food.Buff.Stamina", "INV_Misc_Food_65", "Consumable.Food.Buff.Stamina")
	AutoBarCategoryList["Consumable.Food.Buff.Stamina"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Strength"] = AutoBarItems:new( "Consumable.Food.Buff.Strength", "INV_Misc_Food_41", "Consumable.Food.Buff.Strength")
	AutoBarCategoryList["Consumable.Food.Buff.Strength"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Other"] = AutoBarItems:new( "Consumable.Food.Buff.Other", "INV_Drink_17", "Consumable.Food.Buff.Other")
	AutoBarCategoryList["Consumable.Food.Buff.Other"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Cooldown.Potion.Combat"] = AutoBarItems:new("Consumable.Cooldown.Potion.Combat", "INV_Potion_54", "Consumable.Cooldown.Potion.Combat")

	AutoBarCategoryList["Muffin.Potion.Health"] = AutoBarItems:new("Muffin.Potion.Health", "INV_Potion_54", "Muffin.Potion.Health")

	AutoBarCategoryList["Muffin.Potion.Mana"] = AutoBarItems:new("Muffin.Potion.Mana", "INV_Potion_76", "Muffin.Potion.Mana")

	AutoBarCategoryList["Muffin.Potion.Combo"] = AutoBarItems:new("Muffin.Potion.Combo", "INV_Potion_76", "Muffin.Potion.Combo")


	AutoBarCategoryList["Muffin.Misc.Reputation"] = AutoBarItems:new("Muffin.Misc.Reputation", "archaeology_5_0_mogucoin", "Muffin.Misc.Reputation")


	AutoBarCategoryList["Consumable.Cooldown.Potion.Health.Anywhere"] = AutoBarItems:new("Consumable.Cooldown.Potion.Health.Anywhere", "INV_Alchemy_EndlessFlask_06", "Consumable.Cooldown.Potion.Health.Anywhere")

	AutoBarCategoryList["Consumable.Cooldown.Potion.Health.Basic"] = AutoBarItems:new("Consumable.Cooldown.Potion.Health.Basic", "INV_Potion_54", "Consumable.Cooldown.Potion.Health.Basic")

	AutoBarCategoryList["Consumable.Cooldown.Potion.Health.PvP"] = AutoBarItems:new("Consumable.Cooldown.Potion.Health.PvP", "INV_Potion_39", "Consumable.Cooldown.Potion.Health.PvP")
	AutoBarCategoryList["Consumable.Cooldown.Potion.Health.PvP"]:SetBattleground(true)


	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Anywhere"] = AutoBarItems:new("Consumable.Cooldown.Potion.Mana.Anywhere", "INV_Alchemy_EndlessFlask_04", "Consumable.Cooldown.Potion.Mana.Anywhere")

	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Basic"] = AutoBarItems:new("Consumable.Cooldown.Potion.Mana.Basic", "INV_Potion_76", "Consumable.Cooldown.Potion.Mana.Basic")

	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Pvp"] = AutoBarItems:new("Consumable.Cooldown.Potion.Mana.Pvp", "INV_Potion_81", "Consumable.Cooldown.Potion.Mana.Pvp")
	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Pvp"]:SetBattleground(true)


	AutoBarCategoryList["Consumable.Cooldown.Stone.Health.Warlock"] = AutoBarItems:new("Consumable.Cooldown.Stone.Health.Warlock", "INV_Stone_04", "Consumable.Cooldown.Stone.Health.Warlock")

	AutoBarCategoryList["Misc.Booze"] = AutoBarItems:new("Misc.Booze", "INV_Drink_03", "Misc.Booze")
	AutoBarCategoryList["Misc.Booze"]:SetNonCombat(true)


	AutoBarCategoryList["Muffin.Misc.Openable"] = AutoBarItems:new("Muffin.Misc.Openable", "INV_Misc_Bag_17", "Muffin.Misc.Openable")

	AutoBarCategoryList["Consumable.Cooldown.Potion.Rejuvenation"] = AutoBarItems:new("Consumable.Cooldown.Potion.Rejuvenation", "INV_Potion_47", "Consumable.Cooldown.Potion.Rejuvenation")

	AutoBarCategoryList["Consumable.Cooldown.Stone.Health.Statue"] = AutoBarItems:new("Consumable.Cooldown.Stone.Health.Statue", "INV_Misc_Statue_10", "Consumable.Cooldown.Stone.Health.Statue")

	AutoBarCategoryList["Consumable.Cooldown.Drums"] = AutoBarItems:new("Consumable.Cooldown.Drums", "INV_Misc_Drum_05", "Consumable.Cooldown.Drums")

	AutoBarCategoryList["Consumable.Cooldown.Potion"] = AutoBarItems:new("Consumable.Cooldown.Potion", "INV_Potion_47", "Consumable.Cooldown.Potion")

	AutoBarCategoryList["Consumable.Cooldown.Stone"] = AutoBarItems:new("Consumable.Cooldown.Stone", "INV_Misc_Statue_10", "Consumable.Cooldown.Stone")


	AutoBarCategoryList["Consumable.Tailor.Net"] = AutoBarItems:new("Consumable.Tailor.Net", "INV_Misc_Net_01", "Consumable.Tailor.Net")

	AutoBarCategoryList["Consumable.Cooldown.Potion.Rejuvenation.Dreamless Sleep"] = AutoBarItems:new("Consumable.Cooldown.Potion.Rejuvenation.Dreamless Sleep", "INV_Potion_83", "Consumable.Cooldown.Potion.Rejuvenation.Dreamless Sleep")

	AutoBarCategoryList["Consumable.Cooldown.Stone.Mana.Mana Stone"] = AutoBarItems:new("Consumable.Cooldown.Stone.Mana.Mana Stone", "INV_Misc_Gem_Sapphire_02", "Consumable.Cooldown.Stone.Mana.Mana Stone")

	AutoBarCategoryList["Consumable.Buff.Rage"] = AutoBarItems:new("Consumable.Buff.Rage", "INV_Potion_24", "Consumable.Buff.Rage")

	AutoBarCategoryList["Muffin.Potion.Rage"] = AutoBarItems:new("Muffin.Potion.Rage", "INV_Potion_24", "Muffin.Potion.Rage")

	AutoBarCategoryList["Consumable.Buff.Energy"] = AutoBarItems:new("Consumable.Buff.Energy", "INV_Drink_Milk_05", "Consumable.Buff.Energy")

	AutoBarCategoryList["Consumable.Water.Basic"] = AutoBarItems:new("Consumable.Water.Basic", "INV_Drink_10", "Consumable.Water.Basic", "Consumable.Water.Conjured")
	AutoBarCategoryList["Consumable.Water.Basic"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Food.Mana.Basic"] = AutoBarItems:new("Muffin.Food.Mana.Basic", "INV_Drink_10", "Muffin.Food.Mana.Basic")
	AutoBarCategoryList["Muffin.Food.Mana.Basic"]:SetNonCombat(true)


	AutoBarCategoryList["Consumable.Water.Conjure"] = AutoBarSpells:new("Consumable.Water.Conjure", spellIconList["Conjure Refreshment"], {
--			"MAGE", ABGCS:GetSpellNameByName("Conjure Refreshment"),
			})

	AutoBarCategoryList["Consumable.Food.Conjure"] = AutoBarSpells:new("Consumable.Food.Conjure", spellIconList["Conjure Refreshment"], {
--			"MAGE", ABGCS:GetSpellNameByName("Conjure Refreshment"),
			})

	AutoBarCategoryList["Consumable.Water.Percentage"] = AutoBarItems:new("Consumable.Water.Percentage", "INV_Drink_04", "Consumable.Water.Percentage")
	AutoBarCategoryList["Consumable.Water.Percentage"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Water.Buff.Spirit"] = AutoBarItems:new("Consumable.Water.Buff.Spirit", "INV_Drink_16", "Consumable.Water.Buff.Spirit")
	AutoBarCategoryList["Consumable.Water.Buff.Spirit"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Water.Buff"] = AutoBarItems:new("Consumable.Water.Buff", "INV_Drink_08", "Consumable.Water.Buff")
	AutoBarCategoryList["Consumable.Water.Buff"]:SetNonCombat(true)


	AutoBarCategoryList["Consumable.Weapon Buff.Oil.Mana"] = AutoBarItems:new("Consumable.Weapon Buff.Oil.Mana", "INV_Potion_100", "Consumable.Weapon Buff.Oil.Mana")
	AutoBarCategoryList["Consumable.Weapon Buff.Oil.Mana"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Weapon Buff.Oil.Wizard"] = AutoBarItems:new("Consumable.Weapon Buff.Oil.Wizard", "INV_Potion_105", "Consumable.Weapon Buff.Oil.Wizard")
	AutoBarCategoryList["Consumable.Weapon Buff.Oil.Wizard"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Weapon Buff.Stone.Sharpening Stone"] = AutoBarItems:new("Consumable.Weapon Buff.Stone.Sharpening Stone", "INV_Stone_SharpeningStone_01", "Consumable.Weapon Buff.Stone.Sharpening Stone")
	AutoBarCategoryList["Consumable.Weapon Buff.Stone.Sharpening Stone"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Weapon Buff.Stone.Weight Stone"] = AutoBarItems:new("Consumable.Weapon Buff.Stone.Weight Stone", "INV_Stone_WeightStone_02", "Consumable.Weapon Buff.Stone.Weight Stone")
	AutoBarCategoryList["Consumable.Weapon Buff.Stone.Weight Stone"]:SetTargeted("WEAPON")


	AutoBarCategoryList["Consumable.Buff Group.General.Self"] = AutoBarItems:new("Consumable.Buff Group.General.Self", "INV_Potion_80", "Consumable.Buff Group.General.Self")

	AutoBarCategoryList["Consumable.Buff Group.General.Target"] = AutoBarItems:new("Consumable.Buff Group.General.Target", "INV_Potion_80", "Consumable.Buff Group.General.Target")
	AutoBarCategoryList["Consumable.Buff Group.General.Target"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff Group.Caster.Self"] = AutoBarItems:new("Consumable.Buff Group.Caster.Self", "INV_Potion_66", "Consumable.Buff Group.Caster.Self")

	AutoBarCategoryList["Consumable.Buff Group.Caster.Target"] = AutoBarItems:new("Consumable.Buff Group.Caster.Target", "INV_Potion_66", "Consumable.Buff Group.Caster.Target")
	AutoBarCategoryList["Consumable.Buff Group.Caster.Target"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff Group.Melee.Self"] = AutoBarItems:new("Consumable.Buff Group.Melee.Self", "INV_Potion_43", "Consumable.Buff Group.Melee.Self")

	AutoBarCategoryList["Consumable.Buff Group.Melee.Target"] = AutoBarItems:new("Consumable.Buff Group.Melee.Target", "INV_Potion_43", "Consumable.Buff Group.Melee.Target")
	AutoBarCategoryList["Consumable.Buff Group.Melee.Target"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Other.Self"] = AutoBarItems:new("Consumable.Buff.Other.Self", "INV_Potion_80", "Consumable.Buff.Other.Self")

	AutoBarCategoryList["Consumable.Buff.Water Breathing"] = AutoBarItems:new("Consumable.Buff.Water Breathing", "INV_Potion_80", "Consumable.Buff.Water Breathing")

	AutoBarCategoryList["Muffin.Potion.Water Breathing"] = AutoBarItems:new("Muffin.Potion.Water Breathing", "INV_Potion_80", "Muffin.Potion.Water Breathing")

--[[
	AutoBarCategoryList["Consumable.Buff.Other.Target"] = AutoBarItems:new("Consumable.Buff.Other.Target", "INV_Potion_80", "Consumable.Buff.Other.Target")
	AutoBarCategoryList["Consumable.Buff.Other.Target"]:SetTargeted(true)
--]]

	AutoBarCategoryList["Consumable.Buff.Chest"] = AutoBarItems:new("Consumable.Buff.Chest", "INV_Misc_Rune_10", "Consumable.Buff.Chest")
	AutoBarCategoryList["Consumable.Buff.Chest"]:SetTargeted("CHEST")

	AutoBarCategoryList["Consumable.Buff.Shield"] = AutoBarItems:new("Consumable.Buff.Shield", "INV_Misc_Rune_13", "Consumable.Buff.Shield")
	AutoBarCategoryList["Consumable.Buff.Shield"]:SetTargeted("SHIELD")

	AutoBarCategoryList["Consumable.Weapon Buff"] = AutoBarItems:new("Consumable.Weapon Buff", "INV_Misc_Rune_13", "Consumable.Weapon Buff")
	AutoBarCategoryList["Consumable.Weapon Buff"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Buff.Health"] = AutoBarItems:new("Consumable.Buff.Health", "INV_Potion_43", "Consumable.Buff.Health")

	AutoBarCategoryList["Consumable.Buff.Armor"] = AutoBarItems:new("Consumable.Buff.Armor", "INV_Potion_66", "Consumable.Buff.Armor")

	AutoBarCategoryList["Consumable.Buff.Regen Health"] = AutoBarItems:new("Consumable.Buff.Regen Health", "INV_Potion_80", "Consumable.Buff.Regen Health")

	AutoBarCategoryList["Consumable.Buff.Agility"] = AutoBarItems:new("Consumable.Buff.Agility", "INV_Scroll_02", "Consumable.Buff.Agility")
	AutoBarCategoryList["Consumable.Buff.Agility"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Intellect"] = AutoBarItems:new("Consumable.Buff.Intellect", "INV_Scroll_01", "Consumable.Buff.Intellect")
	AutoBarCategoryList["Consumable.Buff.Intellect"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Spirit"] = AutoBarItems:new("Consumable.Buff.Spirit", "INV_Scroll_01", "Consumable.Buff.Spirit")
	AutoBarCategoryList["Consumable.Buff.Spirit"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Stamina"] = AutoBarItems:new("Consumable.Buff.Stamina", "INV_Scroll_07", "Consumable.Buff.Stamina")
	AutoBarCategoryList["Consumable.Buff.Stamina"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Strength"] = AutoBarItems:new("Consumable.Buff.Strength", "INV_Scroll_02", "Consumable.Buff.Strength")
	AutoBarCategoryList["Consumable.Buff.Strength"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Attack Power"] = AutoBarItems:new("Consumable.Buff.Attack Power", "INV_Misc_MonsterScales_07", "Consumable.Buff.Attack Power")
	AutoBarCategoryList["Consumable.Buff.Attack Power"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Attack Speed"] = AutoBarItems:new("Consumable.Buff.Attack Speed", "INV_Misc_MonsterScales_17", "Consumable.Buff.Attack Speed")
	AutoBarCategoryList["Consumable.Buff.Attack Speed"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Dodge"] = AutoBarItems:new("Consumable.Buff.Dodge", "INV_Misc_MonsterScales_17", "Consumable.Buff.Dodge")
	AutoBarCategoryList["Consumable.Buff.Dodge"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Resistance.Self"] = AutoBarItems:new("Consumable.Buff.Resistance", "INV_Misc_MonsterScales_15", "Consumable.Buff.Resistance.Self")

	AutoBarCategoryList["Consumable.Buff.Resistance.Target"] = AutoBarItems:new("Consumable.Buff.Resistance", "INV_Misc_MonsterScales_15", "Consumable.Buff.Resistance.Target")
	AutoBarCategoryList["Consumable.Buff.Resistance.Target"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Speed"] = AutoBarItems:new("Consumable.Buff.Speed", "INV_Potion_95", "Consumable.Buff.Speed")

	AutoBarCategoryList["Consumable.Buff Type.Battle"] = AutoBarItems:new("Consumable.Buff Type.Battle", "INV_Potion_111", "Consumable.Buff Type.Battle")

	AutoBarCategoryList["Consumable.Buff Type.Guardian"] = AutoBarItems:new("Consumable.Buff Type.Guardian", "INV_Potion_155", "Consumable.Buff Type.Guardian")

	AutoBarCategoryList["Consumable.Buff Type.Flask"] = AutoBarItems:new("Consumable.Buff Type.Flask", "INV_Potion_118", "Consumable.Buff Type.Flask")

	AutoBarCategoryList["Muffin.Flask"] = AutoBarItems:new("Muffin.Flask", "INV_Potion_118", "Muffin.Flask")

	AutoBarCategoryList["Muffin.Elixir.Guardian"] = AutoBarItems:new("Muffin.Elixir.Guardian", "INV_Potion_118", "Muffin.Elixir.Guardian")

	AutoBarCategoryList["Muffin.Elixir.Battle"] = AutoBarItems:new("Muffin.Elixir.Battle", "INV_Potion_118", "Muffin.Elixir.Battle")

	AutoBarCategoryList["Muffin.Potion.Buff"] = AutoBarItems:new("Muffin.Potion.Buff", "INV_Potion_118", "Muffin.Potion.Buff")

	AutoBarCategoryList["Muffin.Gear.Trinket"] = AutoBarItems:new("Muffin.Gear.Trinket", "INV_Misc_OrnateBox", "Muffin.Gear.Trinket")

	AutoBarCategoryList["Misc.Lockboxes"] = AutoBarItems:new("Misc.Lockboxes", "INV_Trinket_Naxxramas06", "Misc.Lockboxes")

	AutoBarCategoryList["Misc.Usable.BossItem"] = AutoBarItems:new("Misc.Usable.BossItem", "INV_BannerPVP_02", "Misc.Usable.BossItem")

	AutoBarCategoryList["Misc.Usable.Fun"] = AutoBarItems:new("Misc.Usable.Fun", "INV_Misc_Toy_10", "Misc.Usable.Fun")

	AutoBarCategoryList["Misc.Usable.Permanent"] = AutoBarItems:new("Misc.Usable.Permanent", "INV_BannerPVP_02", "Misc.Usable.Permanent")

	AutoBarCategoryList["Misc.Usable.Quest"] = AutoBarItems:new("Misc.Usable.Quest", "INV_BannerPVP_02", "Misc.Usable.Quest")

	AutoBarCategoryList["Misc.Usable.StartsQuest"] = AutoBarItems:new("Misc.Usable.StartsQuest", "INV_Staff_20", "Misc.Usable.StartsQuest")

	AutoBarCategoryList["Muffin.Misc.StartsQuest"] = AutoBarItems:new("Muffin.Misc.StartsQuest", "INV_Staff_20", "Muffin.Misc.StartsQuest")

	AutoBarCategoryList["Muffin.Misc.Quest"] = AutoBarItems:new("Muffin.Misc.Quest", "INV_BannerPVP_02", "Muffin.Misc.Quest")

	AutoBarCategoryList["Misc.Usable.Replenished"] = AutoBarItems:new("Misc.Usable.Replenished", "INV_BannerPVP_02", "Misc.Usable.Replenished")


	AutoBarCategoryList["Spell.Warlock.Create Healthstone"] = AutoBarSpells:new( "Spell.Warlock.Create Healthstone", spellIconList["Create Healthstone"],
	{
		"WARLOCK", ABGCS:GetSpellNameByName("Create Healthstone"),
	})

	AutoBarCategoryList["Spell.Mage.Conjure Food"] = AutoBarSpells:new( "Spell.Mage.Conjure Food", spellIconList["Conjure Refreshment"], nil, {
--		"MAGE", ABGCS:GetSpellNameByName("Conjure Refreshment"), ABGCS:GetSpellNameByName("Conjure Refreshment Table"),
	})


	AutoBarCategoryList["Spell.Stealth"] = AutoBarSpells:new("Spell.Stealth", spellIconList["Stealth"],
	{
		"DRUID", ABGCS:GetSpellNameByName("Prowl"),
		"MAGE", ABGCS:GetSpellNameByName("Invisibility"),
		"MAGE", ABGCS:GetSpellNameByName("Lesser Invisibility"),
		"ROGUE", ABGCS:GetSpellNameByName("Stealth"),	--y
		"*", ABGCS:GetSpellNameByName("Shadowmeld"),	--y
	})

	AutoBarCategoryList["Spell.Aspect"] = AutoBarSpells:new("Spell.Aspect", spellIconList["Aspect of the Cheetah"],
	{
		"HUNTER", ABGCS:GetSpellNameByName("Aspect of the Cheetah"),
		"HUNTER", ABGCS:GetSpellNameByName("Aspect of the Hawk"),
		"HUNTER", ABGCS:GetSpellNameByName("Aspect of the Monkey"),
		"HUNTER", ABGCS:GetSpellNameByName("Aspect of the Wild"),
	})


	AutoBarCategoryList["Spell.Poison.Lethal"] = AutoBarSpells:new( "Spell.Poison.Lethal", spellIconList["Deadly Poison"], {
		"ROGUE", ABGCS:GetSpellNameByName("Instant Poison"),
		"ROGUE", ABGCS:GetSpellNameByName("Deadly Poison"),
		"ROGUE", ABGCS:GetSpellNameByName("Wound Poison"),
	})

	AutoBarCategoryList["Spell.Poison.Nonlethal"] = AutoBarSpells:new( "Spell.Poison.Nonlethal", spellIconList["Crippling Poison"],
	{
		"ROGUE", ABGCS:GetSpellNameByName("Crippling Poison"),
		"ROGUE", ABGCS:GetSpellNameByName("Mind-numbing Poison"),
	})



	AutoBarCategoryList["Spell.Class.Buff"] = AutoBarSpells:new( "Spell.Class.Buff", spellIconList["Barkskin"],
	{
		"MAGE", ABGCS:GetSpellNameByName("Slow Fall"),
		"PALADIN", ABGCS:GetSpellNameByName("Blessing of Might"),	--y
		"PALADIN", ABGCS:GetSpellNameByName("Blessing of Protection"),
		"PALADIN", ABGCS:GetSpellNameByName("Blessing of Sacrifice"),
		"PALADIN", ABGCS:GetSpellNameByName("Blessing of Salvation"),
		"PALADIN", ABGCS:GetSpellNameByName("Greater Blessing of Kings"),
		"PALADIN", ABGCS:GetSpellNameByName("Greater Blessing of Wisdom"),
		"SHAMAN", ABGCS:GetSpellNameByName("Water Walking"),
		"WARLOCK", ABGCS:GetSpellNameByName("Unending Breath"),
		"WARLOCK", ABGCS:GetSpellNameByName("Soulstone"),
		"WARRIOR", ABGCS:GetSpellNameByName("Demoralizing Shout"),
	})

	AutoBarCategoryList["Spell.Class.Pet"] = AutoBarSpells:new( "Spell.Class.Pet", spellIconList["Call Pet 1"],
	{
		"HUNTER", ABGCS:GetSpellNameByName("Call Pet"),
--		"SHAMAN", ABGCS:GetSpellNameByName("Earth Elemental"),
--		"SHAMAN", ABGCS:GetSpellNameByName("Fire Elemental"),
--		"SHAMAN", ABGCS:GetSpellNameByName("Storm Elemental"),
--		"SHAMAN", ABGCS:GetSpellNameByName("Feral Spirit"),
		"WARLOCK", ABGCS:GetSpellNameByName("Eye of Kilrogg"),
		"WARLOCK", ABGCS:GetSpellNameByName("Summon Infernal"),
		"WARLOCK", ABGCS:GetSpellNameByName("Summon Felhunter"),
		"WARLOCK", ABGCS:GetSpellNameByName("Summon Imp"),
		"WARLOCK", ABGCS:GetSpellNameByName("Summon Succubus"),
		"WARLOCK", ABGCS:GetSpellNameByName("Summon Voidwalker"),
	})



	AutoBarCategoryList["Spell.Class.Pets2"] = AutoBarSpells:new( "Spell.Class.Pets2", spellIconList["Call Pet 1"],
	{
		"HUNTER", ABGCS:GetSpellNameByName("Bestial Wrath"),
		"HUNTER", ABGCS:GetSpellNameByName("Mend Pet"),
		"HUNTER", ABGCS:GetSpellNameByName("Intimidation"),
	})

	--Misc pet abilities
	AutoBarCategoryList["Spell.Class.Pets3"] = AutoBarSpells:new(	"Spell.Class.Pets3", spellIconList["Feed Pet"],
	{
		"HUNTER", ABGCS:GetSpellNameByName("Dismiss Pet"),
		"HUNTER", ABGCS:GetSpellNameByName("Eagle Eye"),
		"HUNTER", ABGCS:GetSpellNameByName("Feed Pet"),
		"HUNTER", ABGCS:GetSpellNameByName("Revive Pet"),
		"HUNTER", ABGCS:GetSpellNameByName("Tame Beast"),
		"HUNTER", ABGCS:GetSpellNameByName("Beast Lore"),
	})

	AutoBarCategoryList["Spell.Portals"] = AutoBarSpells:new( "Spell.Portals", spellPortalShattrathIcon, nil,
	{
		"DRUID", ABGCS:GetSpellNameByName("Teleport: Moonglade"), ABGCS:GetSpellNameByName("Teleport: Moonglade"),
		"MAGE", ABGCS:GetSpellNameByName("Teleport: Undercity"), ABGCS:GetSpellNameByName("Portal: Undercity"),
		"MAGE", ABGCS:GetSpellNameByName("Teleport: Thunder Bluff"), ABGCS:GetSpellNameByName("Portal: Thunder Bluff"),
		"MAGE", ABGCS:GetSpellNameByName("Teleport: Stormwind"), ABGCS:GetSpellNameByName("Portal: Stormwind"),
		"MAGE", ABGCS:GetSpellNameByName("Teleport: Darnassus"), ABGCS:GetSpellNameByName("Portal: Darnassus"),
		"MAGE", ABGCS:GetSpellNameByName("Teleport: Ironforge"), ABGCS:GetSpellNameByName("Portal: Ironforge"),
		"MAGE", ABGCS:GetSpellNameByName("Teleport: Orgrimmar"), ABGCS:GetSpellNameByName("Portal: Orgrimmar"),
		"SHAMAN", ABGCS:GetSpellNameByName("Astral Recall"), ABGCS:GetSpellNameByName("Astral Recall"),
		"WARLOCK", ABGCS:GetSpellNameByName("Ritual of Summoning"), ABGCS:GetSpellNameByName("Ritual of Summoning"),
	})


	AutoBarCategoryList["Spell.Shields"] = AutoBarSpells:new( "Spell.Shields", spellIconList["Ice Barrier"], nil,
	{
		"DRUID", 		ABGCS:GetSpellNameByName("Barkskin"), 	ABGCS:GetSpellNameByName("Barkskin"),
		"MAGE", 			ABGCS:GetSpellNameByName("Ice Barrier"), ABGCS:GetSpellNameByName("Ice Barrier"),
		"PALADIN", 		ABGCS:GetSpellNameByName("Divine Shield"), ABGCS:GetSpellNameByName("Divine Shield"),
		"PRIEST", 		ABGCS:GetSpellNameByName("Power Word: Shield"), ABGCS:GetSpellNameByName("Power Word: Shield"),
		"ROGUE", 		ABGCS:GetSpellNameByName("Evasion"), 		ABGCS:GetSpellNameByName("Evasion"),
		"WARRIOR", 		ABGCS:GetSpellNameByName("Shield Block"), ABGCS:GetSpellNameByName("Shield Wall"),
		"WARRIOR", 		ABGCS:GetSpellNameByName("Shield Wall"), ABGCS:GetSpellNameByName("Shield Block"),


		"WARLOCK", ABGCS:GetSpellNameByName("Demon Skin"),
	})
end

-- Create category list using PeriodicTable data.
-- Split up to avoid Lua upValue limitations
function AutoBarCategory:Initialize2()
	AutoBarCategoryList["Spell.Stance"] = AutoBarSpells:new( "Spell.Stance", spellIconList["Defensive Stance"], {
		"DRUID", ABGCS:GetSpellNameByName("Bear Form"),
		"DRUID", ABGCS:GetSpellNameByName("Cat Form"),
		"DRUID", ABGCS:GetSpellNameByName("Aquatic Form"),
		"DRUID", ABGCS:GetSpellNameByName("Moonkin Form"),
		"DRUID", ABGCS:GetSpellNameByName("Tree Form"),
		"DRUID", ABGCS:GetSpellNameByName("Travel Form"),
		"WARRIOR", ABGCS:GetSpellNameByName("Defensive Stance"),
	})


	AutoBarCategoryList["Spell.Totem.Earth"] = AutoBarSpells:new("Spell.Totem.Earth", spellIconList["Earthgrab Totem"],
	{
		"SHAMAN", ABGCS:GetSpellNameByName("Earthbind Totem"),
		"SHAMAN", ABGCS:GetSpellNameByName("Stoneskin Totem"),
		"SHAMAN", ABGCS:GetSpellNameByName("Stoneclaw Totem"),
		"SHAMAN", ABGCS:GetSpellNameByName("Strength of Earth Totem"),

		"SHAMAN", ABGCS:GetSpellNameByName("Earthgrab Totem"),
		"SHAMAN", ABGCS:GetSpellNameByName("Ancestral Protection Totem"),
		"SHAMAN", ABGCS:GetSpellNameByName("Earthen Shield Totem"),
		"SHAMAN", ABGCS:GetSpellNameByName("Earthquake Totem"),
	})


	AutoBarCategoryList["Spell.Totem.Air"] = AutoBarSpells:new("Spell.Totem.Air", spellIconList["Wind Rush Totem"],
	{
--		"SHAMAN", ABGCS:GetSpellNameByName("Wind Rush Totem"),
--		"SHAMAN", ABGCS:GetSpellNameByName("Lightning Surge Totem"),
--		"SHAMAN", ABGCS:GetSpellNameByName("Voodoo Totem"),
--		"SHAMAN", ABGCS:GetSpellNameByName("Cloudburst Totem"),
	})

	AutoBarCategoryList["Spell.Totem.Fire"] = AutoBarSpells:new("Spell.Totem.Fire", spellIconList["Liquid Magma Totem"],
	{
--		"SHAMAN", ABGCS:GetSpellNameByName("Liquid Magma Totem"),
	})

	AutoBarCategoryList["Spell.Totem.Water"] = AutoBarSpells:new("Spell.Totem.Water", spellHealingStreamTotemIcon,
	{
--		"SHAMAN", ABGCS:GetSpellNameByName("Healing Stream Totem"),
--		"SHAMAN", ABGCS:GetSpellNameByName("Healing Tide Totem"),
--		"SHAMAN", ABGCS:GetSpellNameByName("Spirit Link Totem"),
	})


	AutoBarCategoryList["Spell.Buff.Weapon"] = AutoBarSpells:new("Spell.Buff.Weapon", spellIconList["Deadly Poison"],
	{
		"ROGUE", ABGCS:GetSpellNameByName("Deadly Poison"),
		"ROGUE", ABGCS:GetSpellNameByName("Wound Poison"),
		"ROGUE", ABGCS:GetSpellNameByName("Crippling Poison"),
		"ROGUE", ABGCS:GetSpellNameByName("Instant Poison"),
		"ROGUE", ABGCS:GetSpellNameByName("Mind-numbing Poison"),
		"SHAMAN", ABGCS:GetSpellNameByName("Flametongue Weapon"),
		"SHAMAN", ABGCS:GetSpellNameByName("Rockbiter Weapon"),
	})

	AutoBarCategoryList["Spell.Crafting"] = AutoBarSpells:new( "Spell.Crafting", spellIconList["First Aid"],
	{
		"*", ABGCS:GetSpellNameByName("Alchemy"),
		"*", ABGCS:GetSpellNameByName("Basic Campfire"),
		"*", ABGCS:GetSpellNameByName("Blacksmithing"),
		"*", ABGCS:GetSpellNameByName("Cooking"),
		"*", ABGCS:GetSpellNameByName("Disenchant"),
		"*", ABGCS:GetSpellNameByName("Enchanting"),
		"*", ABGCS:GetSpellNameByName("Engineering"),
		"*", ABGCS:GetSpellNameByName("First Aid"),
		"*", ABGCS:GetSpellNameByName("Leatherworking"),
		"*", ABGCS:GetSpellNameByName("Smelting"),
		"*", ABGCS:GetSpellNameByName("Tailoring"),

		"*", ABGCS:GetSpellNameByName("Find Minerals"),
		"*", ABGCS:GetSpellNameByName("Find Herbs"),
	})

	AutoBarCategoryList["Spell.Debuff.Multiple"] = AutoBarSpells:new("Spell.Debuff.Multiple", spellIconList["Slow"],
	{
		"DRUID",		ABGCS:GetSpellNameByName("Disorienting Roar"),
	})

	AutoBarCategoryList["Spell.Debuff.Single"] = AutoBarSpells:new("Spell.Debuff.Single", spellIconList["Slow"],
	{
		"HUNTER", ABGCS:GetSpellNameByName("Concussive Shot"),
		"HUNTER", ABGCS:GetSpellNameByName("Wing Clip"),
		"WARLOCK", ABGCS:GetSpellNameByName("Curse of Tongues"),
		"WARLOCK", ABGCS:GetSpellNameByName("Curse of Weakness"),	--y
	})


	AutoBarCategoryList["Spell.Fishing"] = AutoBarSpells:new("Spell.Fishing", spellIconList["Fishing"],
	{
		"*", ABGCS:GetSpellNameByName("Fishing"), --y
	})


	AutoBarCategoryList["Spell.Track"] = AutoBarSpells:new( "Spell.Track", spellIconList["Explosive Trap"],
	{
		"HUNTER", ABGCS:GetSpellNameByName("Track Humanoids"),
		"HUNTER", ABGCS:GetSpellNameByName("Track Undead"),
		"HUNTER", ABGCS:GetSpellNameByName("Track Beasts"),
	})

	AutoBarCategoryList["Spell.Trap"] = AutoBarSpells:new( "Spell.Trap", spellIconList["Explosive Trap"],
	{
		"HUNTER", ABGCS:GetSpellNameByName("Explosive Trap"),
		"HUNTER", ABGCS:GetSpellNameByName("Freezing Trap"),
		"HUNTER", ABGCS:GetSpellNameByName("Immolation Trap"),
	})


	AutoBarCategoryList["Misc.Mount.Summoned"] = AutoBarSpells:new( "Misc.Mount.Summoned", spellIconList["Summon Dreadsteed"],
	{
		"SHAMAN", ABGCS:GetSpellNameByName("Ghost Wolf"),
	})
	AutoBarCategoryList["Misc.Mount.Summoned"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Mount"] = AutoBarSpells:new("Muffin.Mount", spellIconList["Summon Dreadsteed"], nil, nil, "Muffin.Mount." .. AutoBar.NiceClass)
	AutoBarCategoryList["Muffin.Mount"]:SetNonCombat(true)

	AutoBarCategoryList["Spell.Charge"] = AutoBarSpells:new( "Spell.Charge", spellIconList["Charge"],
	{
		"WARRIOR", ABGCS:GetSpellNameByName("Charge"),
		"WARRIOR", ABGCS:GetSpellNameByName("Intercept"),
	})

	AutoBarCategoryList["Spell.ER"] = AutoBarSpells:new( "Spell.ER", spellIconList["Charge"],
	{
		"DRUID", ABGCS:GetSpellNameByName("Frenzied Regeneration"),
		"HUNTER", ABGCS:GetSpellNameByName("Feign Death"),
		"HUNTER", ABGCS:GetSpellNameByName("Disengage"),
		"MAGE", ABGCS:GetSpellNameByName("Ice Block"),
		"PALADIN", ABGCS:GetSpellNameByName("Lay on Hands"),
		"ROGUE", ABGCS:GetSpellNameByName("Vanish"),
		"WARLOCK", ABGCS:GetSpellNameByName("Dark Pact"),
		"WARRIOR", ABGCS:GetSpellNameByName("Last Stand"),
	})

	AutoBarCategoryList["Spell.Interrupt"] = AutoBarSpells:new( "Spell.Interrupt", spellIconList["Charge"],
	{
		"ROGUE", ABGCS:GetSpellNameByName("Kick"),
		"SHAMAN", ABGCS:GetSpellNameByName("Earth Shock"),
	})

	AutoBarCategoryList["Spell.CatForm"] = AutoBarSpells:new( "Spell.CatForm", spellIconList["Charge"],
	{
		"DRUID", ABGCS:GetSpellNameByName("Cat Form"),
	})

	AutoBarCategoryList["Spell.BearForm"] = AutoBarSpells:new( "Spell.BearForm", spellIconList["Charge"],
	{
		"DRUID", ABGCS:GetSpellNameByName("Bear Form"),
	})

	AutoBarCategoryList["Spell.MoonkinForm"] = AutoBarSpells:new( "Spell.MoonkinForm", spellIconList["Charge"],
	{
		"DRUID", ABGCS:GetSpellNameByName("Moonkin Form"),
	})

	AutoBarCategoryList["Spell.AquaticForm"] = AutoBarSpells:new( "Spell.MoonkinForm", spellIconList["Charge"],
	{
		"DRUID", ABGCS:GetSpellNameByName("Aquatic Form"),
	})

	AutoBarCategoryList["Spell.TreeForm"] = AutoBarSpells:new( "Spell.TreeForm", spellIconList["Charge"],
	{
		"DRUID", ABGCS:GetSpellNameByName("Tree Form"),
	})

	AutoBarCategoryList["Spell.Travel"] = AutoBarSpells:new( "Spell.Travel", spellIconList["Charge"],
	{
		"DRUID", ABGCS:GetSpellNameByName("Travel Form"),
		"SHAMAN", ABGCS:GetSpellNameByName("Ghost Wolf"),
	})

end


local customCategoriesVersion = 3
-- Learned new spells etc.  Refresh all categories
function AutoBarCategory:Upgrade()
	if (not AutoBar.db.account.customCategories) then
		AutoBar.db.account.customCategories = {}
	end
	if (not AutoBar.db.account.customCategoriesVersion) then
		local newCustomCategories = {}
		local categoryKey
		local customCategories = AutoBar.db.account.customCategories
		for _, customCategoryDB in pairs(customCategories) do
			customCategoryDB.name = customCategoryDB.name:gsub("%.", "")
			categoryKey = AutoBarCustom:GetCustomKey(customCategoryDB.name)
			customCategoryDB.categoryKey = categoryKey
			newCustomCategories[categoryKey] = customCategoryDB
		end
		AutoBar.db.account.customCategories = newCustomCategories
		AutoBar.db.account.customCategoriesVersion = 1
	end
	if (AutoBar.db.account.customCategoriesVersion < customCategoriesVersion) then
		local customCategories = AutoBar.db.account.customCategories
		local newCustomCategories = {}
		local categoryKey
		if (AutoBar.db.account.customCategoriesVersion < 3) then
			for index, customCategoryDB in pairs(customCategories) do
				customCategoryDB.name = AutoBar:GetValidatedName(customCategoryDB.name)
				categoryKey = AutoBarCustom:GetCustomKey(customCategoryDB.name)
				if (categoryKey ~= index) then
					customCategoryDB.categoryKey = categoryKey
					AutoBar.Class.Button:RenameCategory(index, categoryKey)
				end
				if (customCategoryDB.categoryKey ~= categoryKey) then
					AutoBar.Class.Button:RenameCategory(customCategoryDB.categoryKey, categoryKey)
					customCategoryDB.categoryKey = categoryKey
				end
				newCustomCategories[categoryKey] = customCategoryDB
			end
			AutoBar.db.account.customCategories = newCustomCategories
			AutoBar.db.account.customCategoriesVersion = 3
		end
	end
end

-- Learned new spells etc.  Refresh all categories
function AutoBarCategory:UpdateCategories()
	for _, categoryInfo in pairs(AutoBarCategoryList) do
		categoryInfo:Refresh()
	end
end


function AutoBarCategory:UpdateCustomCategories()
	local customCategories = AutoBar.db.account.customCategories

	for categoryKey, customCategoriesDB in pairs(customCategories) do
		assert(customCategoriesDB and (categoryKey == customCategoriesDB.categoryKey), "customCategoriesDB nil or bad categoryKey")
		if (not AutoBarCategoryList[categoryKey]) then
			AutoBarCategoryList[categoryKey] = AutoBarCustom:new(customCategoriesDB)
		end
	end

	for categoryKey, categoryInfo in pairs(AutoBarCategoryList) do
		categoryInfo:Refresh()

		if (categoryInfo.customKey and not customCategories[categoryKey]) then
			AutoBarCategoryList[categoryKey] = nil
		end
	end

	for categoryKey in pairs(AutoBar.categoryValidateList) do
		AutoBar.categoryValidateList[categoryKey] = nil
	end
	for categoryKey, categoryInfo in pairs(AutoBarCategoryList) do
		AutoBar.categoryValidateList[categoryKey] = categoryInfo.description
	end
end


--[[
/dump AutoBarCategoryList["Consumable.Cooldown.Potion.Health.PvP"]
/dump AutoBarCategoryList["Spell.Crafting"].castList
/dump AutoBarCategoryList["Consumable.Buff Group.Caster.Self"]
/dump LibStub("LibPeriodicTable-3.1"):GetSetTable("Muffin.Elixir.Guardian")
/script for itemId, value in LibStub("LibPeriodicTable-3.1"):IterateSet("Consumable.Buff Group.Caster.Self") do AutoBar:Print(itemId .. " " .. value); end
--]]


