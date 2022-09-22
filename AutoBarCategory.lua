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

-- GLOBALS: GetSpellInfo, GetMacroInfo, GetMacroIndexByName
-- GLOBALS: C_ToyBox

local AutoBar = AutoBar
local ABGCode = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject

--TODO: Move AutoBarCategoryList into AutoBarGlobalDataObject
AutoBarCategoryList = {}

local L = ABGData.locale
local PT = LibStub("LibPeriodicTable-3.1")
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
function ABGCode.AddPTSetToRawList(p_raw_list, p_set, p_priority)
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
			print("AutoBar could not find the PT3.1 p_set ", p_set, "  Make sure you have all the libraries AutoBar needs to function.")
		end
	end
	return p_raw_list
end

-- Convert rawList to a simple array of itemIds, ordered by their value in the set, and priority if any
function ABGCode.RawListToItemIDList(p_raw_list)
	local itemArray = {}
	table.sort(p_raw_list, sortList)
	for i, j in ipairs(p_raw_list) do
		itemArray[i] = j[1]
	end
	return itemArray
end


-- Convert list of negative numbered spellId to spellName.
local function PTSpellIDsToSpellName(p_cast_list)
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

	if (spellNameLeft) then
		AutoBarSearch:RegisterSpell(p_spell_name_left, left_spell_id, noSpellCheck)
		p_category.items[itemsIndex] = p_spell_name_left
		if (spellNameRight) then
			AutoBarSearch:RegisterSpell(spellNameRight, right_spell_id, noSpellCheck)
			p_category.itemsRightClick[p_spell_name_left] = spellNameRight
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


-- Return nil or list of spells matching player class
-- itemsPerLine defaults to 2 (class type, spell).
-- Only supports 2 & 3 for now.
local function FilterByClass(castList, p_items_per_line)
	local spellName, index, filteredList2, filteredList3
	local items_per_line = p_items_per_line or 2

	--TODO: verify that each entry starts with either a proper class name or a "*"
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

-- Learned new spells etc.  Refresh all categories
function ABGCode.RefreshCategories()
	for _, categoryInfo in pairs(AutoBarCategoryList) do
		categoryInfo:Refresh()
	end
end



-- Mandatory attributes:
--		description - localized description
--		texture - display icon texture
-- Optional attributes:
--		targeted, nonCombat, battleground
---@class CategoryClass
ABGCode.CategoryClass = {}
local CategoryClass = ABGCode.CategoryClass

---@param description string
---@param texture string
function CategoryClass:init(description, texture)
	self.categoryKey = description
	self.description = L[description]
	self.texture = texture
	self.targeted = false
	self.nonCombat = false
	self.battleground = false
	self.noSpellCheck = false
	self.items = {}
end

-- True if items can be targeted
function CategoryClass:SetTargeted(p_targeted)
	assert(type(p_targeted) == "boolean" or type(p_targeted) == "string")
	self.targeted = p_targeted
end

-- True if only usable outside combat
function CategoryClass:SetNonCombat(p_non_combat)
	assert(type(p_non_combat) == "boolean")
	self.nonCombat = p_non_combat
end

-- True if item is for battlegrounds only
function CategoryClass:SetBattleground(p_battleground)
	assert(type(p_battleground) == "boolean")
	self.battleground = p_battleground
end

-- True if item the spell check should be skipped, used for things like Mounts(?) where the spell check would otherwise fail
function CategoryClass:SetNoSpellCheck(p_no_spell_check)
	assert(type(p_no_spell_check) == "boolean")
	self.noSpellCheck = p_no_spell_check
end

-- Sets an override castSpell value
function CategoryClass:SetCastSpell(p_cast_spell)
	self.castSpell = p_cast_spell
end


-- Reset the item list based on changed settings.
-- So pet change, Spellbook changed for spells, etc.
function CategoryClass:Refresh() -- luacheck: no unused args
end


-- Category consisting of regular items, defined by PeriodicTable sets
ABGCode.ItemsCategory = CreateFromMixins(CategoryClass)
local ItemsCategory = ABGCode.ItemsCategory

-- p_pt_items, p_pt_priority_items are PeriodicTable sets
-- p_pt_priority_items sort higher than items at the same value
function ItemsCategory:new(p_description, p_short_texture, p_pt_items, p_pt_priority_items)
	assert(type(p_description) == "string")
	assert(type(p_short_texture) == "string")
	assert(type(p_pt_items) == "string" or (p_pt_items == nil and p_description == "Dynamic.Quest"), "p_pt_items is a " .. type(p_pt_items) .. " " .. p_description)
	--TODO: The above handling of dynamic categories is fugly

	local obj = CreateFromMixins(self)
	obj:init(p_description, "Interface\\Icons\\" .. p_short_texture)

	obj.pt_items = p_pt_items
	obj.ptPriorityItems = p_pt_priority_items

	local raw_list = ABGCode.AddPTSetToRawList({}, p_pt_items, false)
	if (p_pt_priority_items) then
		raw_list = ABGCode.AddPTSetToRawList(raw_list, p_pt_priority_items, true)
	end
	obj.items = ABGCode.RawListToItemIDList(raw_list)

	return obj
end


ABGCode.MacroTextCategory = CreateFromMixins(CategoryClass)
local MacroTextCategory = ABGCode.MacroTextCategory

function MacroTextCategory:new(p_description, p_short_texture)
	assert(type(p_description) == "string")
	assert(type(p_short_texture) == "string")

	local obj = CreateFromMixins(self)
	obj:init(p_description, "Interface\\Icons\\" .. p_short_texture)

	return obj
end

function MacroTextCategory:AddMacroText(p_macro_text, p_macro_icon_override, p_tooltip_override, p_hyperlink_override)
	assert(type(p_macro_text) == "string")

	local guid = ABGCode.MacroTextGUID(p_macro_text)
	AutoBarSearch:RegisterMacroText(guid, p_macro_text, p_macro_icon_override, p_tooltip_override, p_hyperlink_override)

	local next_index = #self.items + 1
	self.items[next_index] = guid
end


-- Category consisting of spells
ABGCode.SpellsCategory = CreateFromMixins(CategoryClass)
local SpellsCategory = ABGCode.SpellsCategory

-- castList, is of the form:
-- { "DRUID", "Flight Form", "DRUID", "Swift Flight Form", ["<class>", "<localized spell name>",] ... }
-- rightClickList, is of the form:
-- { "DRUID", "Mark of the Wild", "Gift of the Wild", ["<class>", "<localized spell name left click>", "<localized spell name right click>",] ... }
-- Pass in only one of castList, rightClickList
-- Icon from castList is used unless not available but rightClickList is
-- NOTE: Muffin.Mounts is the only SpellsCategory with a PT Set
---@param p_description string
---@param p_cast_list table
function SpellsCategory:new(p_description, p_texture, p_cast_list, rightClickList, p_pt_set)

	if(type(p_cast_list) ~= "table" and p_cast_list ~= nil) then
		ABGCode:LogWarning("Category:", p_description, " is passing a bad cast_list:", p_cast_list)
	end
	if(type(rightClickList) ~= "table" and rightClickList ~= nil) then
		ABGCode:LogWarning("Category:", p_description, " is passing a bad rightClickList:", rightClickList)
	end

	local obj = CreateFromMixins(self)

	obj:init(p_description, p_texture)

	-- Filter out non CLASS spells from castList and rightClickList
	if (rightClickList) then
		if (#rightClickList % 3 ~= 0) then
			ABGCode:LogWarning("Category:", p_description, " rightClickList should be divisible by 3, but isn't.")
		end
		obj.castList, obj.rightClickList = FilterByClass(rightClickList, 3)
	elseif (p_cast_list) then
		obj.castList = FilterByClass(p_cast_list)
	end

	--Convert a PT set to a list of localized spell names
	if (p_pt_set) then
		assert(p_cast_list == nil)
		assert(rightClickList == nil)
		local raw_list = ABGCode.AddPTSetToRawList({}, p_pt_set, false)
		local id_list = ABGCode.RawListToItemIDList(raw_list)
		obj.castList = PTSpellIDsToSpellName(id_list)
	end

	if (obj.rightClickList and not obj.itemsRightClick) then
		obj.itemsRightClick = {}
	end

	obj:Refresh()

	return obj
end

-- Reset the item list based on changed settings.
function SpellsCategory:Refresh()

	local itemsIndex = 1

	if (self.castList and self.rightClickList) then
		self.itemsRightClick = {}

		for i = 1, # self.castList, 1 do
			local spellNameLeft, spellNameRight = self.castList[i], self.rightClickList[i]
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
ABGCode.CustomCategory = CreateFromMixins(CategoryClass)
local CustomCategory = ABGCode.CustomCategory

-- Return a unique key to use
---@param p_custom_category_name string
function ABGCode.GetCustomCategoryKey(p_custom_category_name)
	assert(type(p_custom_category_name) =="string")
	local newKey = "Custom" .. p_custom_category_name
	return newKey
end

-- Return the unique name to use
function ABGCode.GetNewCustomCategoryName(baseName, index)
	local newName = baseName .. index
	local newKey = ABGCode.GetCustomCategoryKey(newName)
	local customCategories = AutoBarDB2.custom_categories
	while (customCategories[newKey] or AutoBarCategoryList[newKey]) do
		index = index + 1
		newName = baseName .. index
		newKey = ABGCode.GetCustomCategoryKey(newName)
	end
	return newName, newKey
end

-- Select an Icon to use
-- Add description verbatim to localization
function CustomCategory:new(customCategoriesDB)
	local description = customCategoriesDB.name
	if (not L[description]) then
		L[description] = description
	end

	-- Icon is first item found that is not an invalid spell
	local itemList = customCategoriesDB.items
	local itemType, itemId, spellName, spellClass, texture--, itemInfo
	for index = # itemList, 1, -1 do
		local itemDB = itemList[index]
		itemType = itemDB.itemType
		itemId = itemDB.itemId
		--itemInfo = itemDB.itemInfo
		spellName = itemDB.spellName
		spellClass = itemDB.spellClass
		texture = itemDB.texture
		if ((not spellClass) or (spellClass == AutoBar.CLASS)) then
			break
		end
	end
	if (itemType == "item") then
		texture = ABGCode.GetIconForItemID(tonumber(itemId))
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

	local obj = CreateFromMixins(self)

	obj:init(description, texture)

	obj.customCategoriesDB = customCategoriesDB

	obj.customKey = ABGCode.GetCustomCategoryKey(description)

	obj:Refresh()

	return obj
end

-- If not used yet, change name to newName
-- Return the name in use either way
function CustomCategory:ChangeName(newName)
	local newCategoryKey = ABGCode.GetCustomCategoryKey(newName)
	if (not AutoBarCategoryList[newCategoryKey]) then
		local oldCustomKey = self.customKey
		self.customKey = newCategoryKey
--AutoBar:Print("CustomCategory:ChangeName oldCustomKey " .. tostring(oldCustomKey) .. " newCategoryKey " .. tostring(newCategoryKey))
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

		local customCategories = AutoBarDB2.custom_categories
		customCategories[newCategoryKey] = customCategories[oldCustomKey]
		customCategories[oldCustomKey] = nil
	end
	return self.customCategoriesDB.name
end
-- /dump AutoBarCategoryList["Custom.Custom"]
-- /dump AutoBarCategoryList["Custom.XXX"]

-- Reset the item list based on changed settings.
function CustomCategory:Refresh()
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
--AutoBar:Print("CustomCategory:Refresh --> itemDB.itemInfo " .. tostring(itemDB.itemInfo) .. " itemDB.itemId " .. tostring(itemDB.itemId))
			if (not itemDB.itemInfo) then
				itemDB.itemInfo = GetMacroInfo(itemId)
			end
			if (itemDB.itemInfo) then
				itemDB.itemId = GetMacroIndexByName(itemDB.itemInfo)
				itemId = itemDB.itemId
			end
--AutoBar:Print("CustomCategory:Refresh <-- itemDB.itemInfo " .. tostring(itemDB.itemInfo) .. " itemDB.itemId " .. tostring(itemDB.itemId))
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
function ABGCode.InitializeAllCategories()

	--Init Classic vs Mainline categories
	ABGCode.InitializeCategories()


	AutoBarCategoryList["Macro.Raid Target"] = MacroTextCategory:new( "Raid Target", "Spell_BrokenHeart")
	for index = 1, 8 do
		AutoBarCategoryList["Macro.Raid Target"]:AddMacroText('/run SetRaidTarget("target", ' .. index .. ')',  "Interface/targetingframe/UI-RaidTargetingIcon_" .. index, L["Raid " .. index])
	end

	AutoBarCategoryList["Battle Pet.Favourites"] = ABGCode.MacroTextCategory:new( "Battle Pet.Favourites", "inv_misc_pheonixpet_01")


	AutoBarCategoryList["Misc.Hearth"] = ItemsCategory:new("Misc.Hearth", "INV_Misc_Rune_01", "Misc.Hearth")
	AutoBarCategoryList["Muffin.Misc.Hearth"] = ItemsCategory:new("Muffin.Misc.Hearth", "INV_Misc_Rune_01", "Muffin.Misc.Hearth")

	AutoBarCategoryList["Consumable.Buff.Free Action"] = ItemsCategory:new( "Consumable.Buff.Free Action", "INV_Potion_04", "Consumable.Buff.Free Action")

	AutoBarCategoryList["Consumable.Anti-Venom"] = ItemsCategory:new( "Consumable.Anti-Venom", "INV_Drink_14", "Consumable.Anti-Venom")
	AutoBarCategoryList["Consumable.Anti-Venom"]:SetTargeted(true)

	AutoBarCategoryList["Misc.Battle Standard.Guild"] = ItemsCategory:new( "Misc.Battle Standard.Guild", "INV_BannerPVP_01", "Misc.Battle Standard.Guild")

	AutoBarCategoryList["Misc.Battle Standard.Battleground"] = ItemsCategory:new( "Misc.Battle Standard.Battleground", "INV_BannerPVP_01", "Misc.Battle Standard.Battleground")
	AutoBarCategoryList["Misc.Battle Standard.Battleground"]:SetBattleground(true)

	AutoBarCategoryList["Misc.Battle Standard.Alterac Valley"] = ItemsCategory:new( "Misc.Battle Standard.Alterac Valley", "INV_BannerPVP_02", "Misc.Battle Standard.Alterac Valley")

	AutoBarCategoryList["Muffin.Explosives"] = ItemsCategory:new( "Muffin.Explosives", "INV_Misc_Bomb_08", "Muffin.Explosives")
	AutoBarCategoryList["Muffin.Explosives"]:SetTargeted(true)

	AutoBarCategoryList["Misc.Engineering.Fireworks"] = ItemsCategory:new( "Misc.Engineering.Fireworks", "INV_Misc_MissileSmall_Red", "Misc.Engineering.Fireworks")

	AutoBarCategoryList["Tradeskill.Tool.Fishing.Bait"] = ItemsCategory:new( "Tradeskill.Tool.Fishing.Bait", "INV_Misc_Food_26", "Tradeskill.Tool.Fishing.Bait")

	AutoBarCategoryList["Tradeskill.Tool.Fishing.Gear"] = ItemsCategory:new( "Tradeskill.Tool.Fishing.Gear", "INV_Helmet_31", "Tradeskill.Tool.Fishing.Gear")

	AutoBarCategoryList["Tradeskill.Tool.Fishing.Lure"] = ItemsCategory:new( "Tradeskill.Tool.Fishing.Lure", "INV_Misc_Food_26", "Tradeskill.Tool.Fishing.Lure")
	AutoBarCategoryList["Tradeskill.Tool.Fishing.Lure"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Tradeskill.Tool.Fishing.Other"] = ItemsCategory:new( "Tradeskill.Tool.Fishing.Other", "INV_Drink_03", "Tradeskill.Tool.Fishing.Other")

	AutoBarCategoryList["Tradeskill.Tool.Fishing.Tool"] = ItemsCategory:new( "Tradeskill.Tool.Fishing.Tool", "INV_Fishingpole_01", "Tradeskill.Tool.Fishing.Tool")

	AutoBarCategoryList["Muffin.Skill.Fishing.Bait"] = ItemsCategory:new( "Muffin.Skill.Fishing.Bait", "INV_Misc_Food_26", "Muffin.Skill.Fishing.Bait")
	AutoBarCategoryList["Muffin.Skill.Fishing.Bait"]:SetTargeted("WEAPON")
	AutoBarCategoryList["Muffin.Skill.Fishing.Lure"] = ItemsCategory:new( "Muffin.Skill.Fishing.Lure", "INV_Misc_Food_26", "Muffin.Skill.Fishing.Lure")
	AutoBarCategoryList["Muffin.Skill.Fishing.Lure"]:SetTargeted("WEAPON")
	AutoBarCategoryList["Muffin.Skill.Fishing.Misc"] = ItemsCategory:new( "Muffin.Skill.Fishing.Misc", "INV_Misc_Food_26", "Muffin.Skill.Fishing.Misc")
	AutoBarCategoryList["Muffin.Skill.Fishing.Pole"] = ItemsCategory:new( "Muffin.Skill.Fishing.Pole", "INV_Fishingpole_01", "Muffin.Skill.Fishing.Pole")
	AutoBarCategoryList["Muffin.Skill.Fishing.Rare Fish"] = ItemsCategory:new( "Muffin.Skill.Fishing.Rare Fish", "INV_Misc_Food_26", "Muffin.Skill.Fishing.Rare Fish")


	AutoBarCategoryList["Consumable.Cooldown.Stone.Mana.Other"] = ItemsCategory:new( "Consumable.Cooldown.Stone.Mana.Other", "Spell_Shadow_SealOfKings", "Consumable.Cooldown.Stone.Mana.Other")

	AutoBarCategoryList["Consumable.Bandage.Basic"] = ItemsCategory:new( "Consumable.Bandage.Basic", "INV_Misc_Bandage_Netherweave_Heavy", "Consumable.Bandage.Basic")
	AutoBarCategoryList["Consumable.Bandage.Basic"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Bandage.Battleground.Alterac Valley"] = ItemsCategory:new( "Consumable.Bandage.Battleground.Alterac Valley", "INV_Misc_Bandage_12", "Consumable.Bandage.Battleground.Alterac Valley")
	AutoBarCategoryList["Consumable.Bandage.Battleground.Alterac Valley"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Bandage.Battleground.Arathi Basin"] = ItemsCategory:new( "Consumable.Bandage.Battleground.Arathi Basin", "INV_Misc_Bandage_12", "Consumable.Bandage.Battleground.Arathi Basin")
	AutoBarCategoryList["Consumable.Bandage.Battleground.Arathi Basin"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Bandage.Battleground.Warsong Gulch"] = ItemsCategory:new( "Consumable.Bandage.Battleground.Warsong Gulch", "INV_Misc_Bandage_12", "Consumable.Bandage.Battleground.Warsong Gulch")
	AutoBarCategoryList["Consumable.Bandage.Battleground.Warsong Gulch"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Food.Edible.Basic.Non-Conjured"] = ItemsCategory:new( "Consumable.Food.Edible.Basic.Non-Conjured", "INV_Misc_Food_23", "Consumable.Food.Edible.Basic.Non-Conjured")
	AutoBarCategoryList["Consumable.Food.Edible.Basic.Non-Conjured"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Edible.Basic.Non-Conjured"] = ItemsCategory:new( "Consumable.Food.Edible.Basic.Non-Conjured", "INV_Misc_Food_23", "Consumable.Food.Edible.Basic.Non-Conjured")
	AutoBarCategoryList["Consumable.Food.Edible.Basic.Non-Conjured"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Food.Health.Basic"] = ItemsCategory:new( "Muffin.Food.Health.Basic", "INV_Misc_Food_23", "Muffin.Food.Health.Basic")
	AutoBarCategoryList["Muffin.Food.Health.Basic"]:SetNonCombat(true)


	AutoBarCategoryList["Consumable.Food.Edible.Battleground.Arathi Basin.Basic"] = ItemsCategory:new( "Consumable.Food.Edible.Battleground.Arathi Basin.Basic", "INV_Misc_Food_33", "Consumable.Food.Edible.Battleground.Arathi Basin.Basic")
	AutoBarCategoryList["Consumable.Food.Edible.Battleground.Arathi Basin.Basic"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Edible.Battleground.Warsong Gulch.Basic"] = ItemsCategory:new( "Consumable.Food.Edible.Battleground.Warsong Gulch.Basic", "INV_Misc_Food_33", "Consumable.Food.Edible.Battleground.Warsong Gulch.Basic")
	AutoBarCategoryList["Consumable.Food.Edible.Battleground.Warsong Gulch.Basic"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Combo Health"] = ItemsCategory:new( "Consumable.Food.Combo Health", "INV_Misc_Food_33", "Consumable.Food.Combo Health")
	AutoBarCategoryList["Consumable.Food.Combo Health"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Edible.Combo.Non-Conjured"] = ItemsCategory:new( "Consumable.Food.Edible.Combo.Non-Conjured", "INV_Misc_Food_95_Grainbread", "Consumable.Food.Edible.Combo.Non-Conjured")
	AutoBarCategoryList["Consumable.Food.Edible.Combo.Non-Conjured"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Food.Combo.Basic"] = ItemsCategory:new( "Muffin.Food.Combo.Basic", "INV_Misc_Food_95_Grainbread", "Muffin.Food.Combo.Basic")
	AutoBarCategoryList["Muffin.Food.Combo.Basic"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Food.Health.Buff"] = ItemsCategory:new( "Muffin.Food.Health.Buff", "INV_Misc_Food_95_Grainbread", "Muffin.Food.Health.Buff")
	AutoBarCategoryList["Muffin.Food.Health.Buff"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Food.Mana.Buff"] = ItemsCategory:new( "Muffin.Food.Mana.Buff", "INV_Misc_Food_95_Grainbread", "Muffin.Food.Mana.Buff")
	AutoBarCategoryList["Muffin.Food.Mana.Buff"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Food.Combo.Buff"] = ItemsCategory:new("Muffin.Food.Combo.Buff", "INV_Misc_Food_95_Grainbread", "Muffin.Food.Combo.Buff")
	AutoBarCategoryList["Muffin.Food.Combo.Buff"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Stones.Mana"] = ItemsCategory:new("Muffin.Stones.Mana", "INV_Misc_Food_95_Grainbread", "Muffin.Stones.Mana")
	AutoBarCategoryList["Muffin.Stones.Health"] = ItemsCategory:new("Muffin.Stones.Health", "INV_Misc_Food_95_Grainbread", "Muffin.Stones.Health")


	AutoBarCategoryList["Consumable.Food.Edible.Combo.Conjured"] = ItemsCategory:new( "Consumable.Food.Edible.Combo.Conjured", "inv_misc_food_73cinnamonroll", "Consumable.Food.Edible.Combo.Conjured")
	AutoBarCategoryList["Consumable.Food.Edible.Combo.Conjured"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Feast"] = ItemsCategory:new("Consumable.Food.Feast", "INV_Misc_Fish_52", "Consumable.Food.Feast")
	AutoBarCategoryList["Consumable.Food.Feast"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Percent.Basic"] = ItemsCategory:new("Consumable.Food.Percent.Basic", "INV_Misc_Food_60", "Consumable.Food.Percent.Basic")
	AutoBarCategoryList["Consumable.Food.Percent.Basic"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Percent.Bonus"] = ItemsCategory:new("Consumable.Food.Percent.Bonus", "INV_Misc_Food_62", "Consumable.Food.Percent.Bonus")
	AutoBarCategoryList["Consumable.Food.Percent.Bonus"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Combo Percent"] = ItemsCategory:new("Consumable.Food.Combo Percent", "INV_Food_ChristmasFruitCake_01", "Consumable.Food.Combo Percent")
	AutoBarCategoryList["Consumable.Food.Combo Percent"]:SetNonCombat(true)


	AutoBarCategoryList["Consumable.Food.Bread"] = ItemsCategory:new("Consumable.Food.Bread", "INV_Misc_Food_35", "Consumable.Food.Edible.Bread.Basic", "Consumable.Food.Edible.Basic.Conjured")
	AutoBarCategoryList["Consumable.Food.Bread"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Food.Bread"]:SetCastSpell(AutoBar:LoggedGetSpellInfo(6991, "Feed Pet"))

	AutoBarCategoryList["Consumable.Food.Cheese"] = ItemsCategory:new( "Consumable.Food.Cheese", "INV_Misc_Food_37", "Consumable.Food.Edible.Cheese.Basic")
	AutoBarCategoryList["Consumable.Food.Cheese"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Food.Cheese"]:SetCastSpell(AutoBar:LoggedGetSpellInfo(6991, "Feed Pet"))


	AutoBarCategoryList["Consumable.Food.Fish"] = ItemsCategory:new("Consumable.Food.Fish", "INV_Misc_Fish_22", "Consumable.Food.Inedible.Fish", "Consumable.Food.Edible.Fish.Basic")
	AutoBarCategoryList["Consumable.Food.Fish"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Food.Fish"]:SetCastSpell(AutoBar:LoggedGetSpellInfo(6991, "Feed Pet"))


	AutoBarCategoryList["Consumable.Food.Fruit"] = ItemsCategory:new( "Consumable.Food.Fruit", "INV_Misc_Food_19", "Consumable.Food.Edible.Fruit.Basic")
	AutoBarCategoryList["Consumable.Food.Fruit"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Food.Fruit"]:SetCastSpell(AutoBar:LoggedGetSpellInfo(6991, "Feed Pet"))


	AutoBarCategoryList["Consumable.Food.Fungus"] = ItemsCategory:new("Consumable.Food.Fungus", "INV_Mushroom_05", "Consumable.Food.Edible.Fungus.Basic")
	AutoBarCategoryList["Consumable.Food.Fungus"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Food.Fungus"]:SetCastSpell(AutoBar:LoggedGetSpellInfo(6991, "Feed Pet"))

	AutoBarCategoryList["Consumable.Food.Meat"] = ItemsCategory:new("Consumable.Food.Meat", "INV_Misc_Food_14", "Consumable.Food.Inedible.Meat", "Consumable.Food.Edible.Meat.Basic")
	AutoBarCategoryList["Consumable.Food.Meat"]:SetNonCombat(true)
	AutoBarCategoryList["Consumable.Food.Meat"]:SetCastSpell(AutoBar:LoggedGetSpellInfo(6991, "Feed Pet"))

	AutoBarCategoryList["Consumable.Buff Pet"] = ItemsCategory:new("Consumable.Buff Pet", "INV_Misc_Food_87_SporelingSnack", "Consumable.Buff Pet")
	AutoBarCategoryList["Consumable.Buff Pet"]:SetTargeted("PET")
	AutoBarCategoryList["Consumable.Buff Pet"]:SetCastSpell(AutoBar:LoggedGetSpellInfo(6991, "Feed Pet"))

	AutoBarCategoryList["Consumable.Food.Bonus"] = ItemsCategory:new("Consumable.Food.Bonus", "INV_Misc_Food_47", "Consumable.Food.Bonus")
	AutoBarCategoryList["Consumable.Food.Bonus"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Agility"] = ItemsCategory:new( "Consumable.Food.Buff.Agility", "INV_Misc_Fish_13", "Consumable.Food.Buff.Agility")
	AutoBarCategoryList["Consumable.Food.Buff.Agility"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Attack Power"] = ItemsCategory:new( "Consumable.Food.Buff.Attack Power", "INV_Misc_Fish_13", "Consumable.Food.Buff.Attack Power")
	AutoBarCategoryList["Consumable.Food.Buff.Attack Power"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Healing"] = ItemsCategory:new( "Consumable.Food.Buff.Healing", "INV_Misc_Fish_13", "Consumable.Food.Buff.Healing")
	AutoBarCategoryList["Consumable.Food.Buff.Healing"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.HP Regen"] = ItemsCategory:new( "Consumable.Food.Buff.HP Regen", "INV_Misc_Fish_19", "Consumable.Food.Buff.HP Regen")
	AutoBarCategoryList["Consumable.Food.Buff.HP Regen"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Intellect"] = ItemsCategory:new( "Consumable.Food.Buff.Intellect", "INV_Misc_Food_63", "Consumable.Food.Buff.Intellect")
	AutoBarCategoryList["Consumable.Food.Buff.Intellect"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Mana Regen"] = ItemsCategory:new( "Consumable.Food.Buff.Mana Regen", "INV_Drink_17", "Consumable.Food.Buff.Mana Regen")
	AutoBarCategoryList["Consumable.Food.Buff.Mana Regen"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Spell Damage"] = ItemsCategory:new( "Consumable.Food.Buff.Spell Damage", "INV_Misc_Food_65", "Consumable.Food.Buff.Spell Damage")
	AutoBarCategoryList["Consumable.Food.Buff.Spell Damage"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Spirit"] = ItemsCategory:new( "Consumable.Food.Buff.Spirit", "INV_Misc_Fish_03", "Consumable.Food.Buff.Spirit")
	AutoBarCategoryList["Consumable.Food.Buff.Spirit"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Stamina"] = ItemsCategory:new( "Consumable.Food.Buff.Stamina", "INV_Misc_Food_65", "Consumable.Food.Buff.Stamina")
	AutoBarCategoryList["Consumable.Food.Buff.Stamina"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Strength"] = ItemsCategory:new( "Consumable.Food.Buff.Strength", "INV_Misc_Food_41", "Consumable.Food.Buff.Strength")
	AutoBarCategoryList["Consumable.Food.Buff.Strength"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Food.Buff.Other"] = ItemsCategory:new( "Consumable.Food.Buff.Other", "INV_Drink_17", "Consumable.Food.Buff.Other")
	AutoBarCategoryList["Consumable.Food.Buff.Other"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Cooldown.Potion.Combat"] = ItemsCategory:new("Consumable.Cooldown.Potion.Combat", "INV_Potion_54", "Consumable.Cooldown.Potion.Combat")

	AutoBarCategoryList["Muffin.Potion.Health"] = ItemsCategory:new("Muffin.Potion.Health", "INV_Potion_54", "Muffin.Potion.Health")

	AutoBarCategoryList["Muffin.Potion.Mana"] = ItemsCategory:new("Muffin.Potion.Mana", "INV_Potion_76", "Muffin.Potion.Mana")

	AutoBarCategoryList["Muffin.Potion.Combo"] = ItemsCategory:new("Muffin.Potion.Combo", "INV_Potion_76", "Muffin.Potion.Combo")


	AutoBarCategoryList["Muffin.Misc.Reputation"] = ItemsCategory:new("Muffin.Misc.Reputation", "archaeology_5_0_mogucoin", "Muffin.Misc.Reputation")


	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Anywhere"] = ItemsCategory:new("Consumable.Cooldown.Potion.Mana.Anywhere", "INV_Alchemy_EndlessFlask_04", "Consumable.Cooldown.Potion.Mana.Anywhere")

	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Basic"] = ItemsCategory:new("Consumable.Cooldown.Potion.Mana.Basic", "INV_Potion_76", "Consumable.Cooldown.Potion.Mana.Basic")

	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Pvp"] = ItemsCategory:new("Consumable.Cooldown.Potion.Mana.Pvp", "INV_Potion_81", "Consumable.Cooldown.Potion.Mana.Pvp")
	AutoBarCategoryList["Consumable.Cooldown.Potion.Mana.Pvp"]:SetBattleground(true)


	AutoBarCategoryList["Misc.Booze"] = ItemsCategory:new("Misc.Booze", "INV_Drink_03", "Misc.Booze")
	AutoBarCategoryList["Misc.Booze"]:SetNonCombat(true)


	AutoBarCategoryList["Muffin.Misc.Openable"] = ItemsCategory:new("Muffin.Misc.Openable", "INV_Misc_Bag_17", "Muffin.Misc.Openable")

	AutoBarCategoryList["Consumable.Cooldown.Potion.Rejuvenation"] = ItemsCategory:new("Consumable.Cooldown.Potion.Rejuvenation", "INV_Potion_47", "Consumable.Cooldown.Potion.Rejuvenation")

	AutoBarCategoryList["Consumable.Cooldown.Stone.Health.Statue"] = ItemsCategory:new("Consumable.Cooldown.Stone.Health.Statue", "INV_Misc_Statue_10", "Consumable.Cooldown.Stone.Health.Statue")

	AutoBarCategoryList["Consumable.Cooldown.Potion"] = ItemsCategory:new("Consumable.Cooldown.Potion", "INV_Potion_47", "Consumable.Cooldown.Potion")

	AutoBarCategoryList["Consumable.Cooldown.Stone"] = ItemsCategory:new("Consumable.Cooldown.Stone", "INV_Misc_Statue_10", "Consumable.Cooldown.Stone")


	AutoBarCategoryList["Consumable.Tailor.Net"] = ItemsCategory:new("Consumable.Tailor.Net", "INV_Misc_Net_01", "Consumable.Tailor.Net")

	AutoBarCategoryList["Consumable.Cooldown.Potion.Rejuvenation.Dreamless Sleep"] = ItemsCategory:new("Consumable.Cooldown.Potion.Rejuvenation.Dreamless Sleep", "INV_Potion_83", "Consumable.Cooldown.Potion.Rejuvenation.Dreamless Sleep")

	AutoBarCategoryList["Consumable.Cooldown.Stone.Mana.Mana Stone"] = ItemsCategory:new("Consumable.Cooldown.Stone.Mana.Mana Stone", "INV_Misc_Gem_Sapphire_02", "Consumable.Cooldown.Stone.Mana.Mana Stone")

	AutoBarCategoryList["Consumable.Buff.Rage"] = ItemsCategory:new("Consumable.Buff.Rage", "INV_Potion_24", "Consumable.Buff.Rage")

	AutoBarCategoryList["Muffin.Potion.Rage"] = ItemsCategory:new("Muffin.Potion.Rage", "INV_Potion_24", "Muffin.Potion.Rage")

	AutoBarCategoryList["Consumable.Buff.Energy"] = ItemsCategory:new("Consumable.Buff.Energy", "INV_Drink_Milk_05", "Consumable.Buff.Energy")

	AutoBarCategoryList["Consumable.Water.Basic"] = ItemsCategory:new("Consumable.Water.Basic", "INV_Drink_10", "Consumable.Water.Basic", "Consumable.Water.Conjured")
	AutoBarCategoryList["Consumable.Water.Basic"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Food.Mana.Basic"] = ItemsCategory:new("Muffin.Food.Mana.Basic", "INV_Drink_10", "Muffin.Food.Mana.Basic")
	AutoBarCategoryList["Muffin.Food.Mana.Basic"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Water.Percentage"] = ItemsCategory:new("Consumable.Water.Percentage", "INV_Drink_04", "Consumable.Water.Percentage")
	AutoBarCategoryList["Consumable.Water.Percentage"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Water.Buff.Spirit"] = ItemsCategory:new("Consumable.Water.Buff.Spirit", "INV_Drink_16", "Consumable.Water.Buff.Spirit")
	AutoBarCategoryList["Consumable.Water.Buff.Spirit"]:SetNonCombat(true)

	AutoBarCategoryList["Consumable.Water.Buff"] = ItemsCategory:new("Consumable.Water.Buff", "INV_Drink_08", "Consumable.Water.Buff")
	AutoBarCategoryList["Consumable.Water.Buff"]:SetNonCombat(true)


	AutoBarCategoryList["Consumable.Weapon Buff.Oil.Mana"] = ItemsCategory:new("Consumable.Weapon Buff.Oil.Mana", "INV_Potion_100", "Consumable.Weapon Buff.Oil.Mana")
	AutoBarCategoryList["Consumable.Weapon Buff.Oil.Mana"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Weapon Buff.Oil.Wizard"] = ItemsCategory:new("Consumable.Weapon Buff.Oil.Wizard", "INV_Potion_105", "Consumable.Weapon Buff.Oil.Wizard")
	AutoBarCategoryList["Consumable.Weapon Buff.Oil.Wizard"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Weapon Buff.Stone.Sharpening Stone"] = ItemsCategory:new("Consumable.Weapon Buff.Stone.Sharpening Stone", "INV_Stone_SharpeningStone_01", "Consumable.Weapon Buff.Stone.Sharpening Stone")
	AutoBarCategoryList["Consumable.Weapon Buff.Stone.Sharpening Stone"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Weapon Buff.Stone.Weight Stone"] = ItemsCategory:new("Consumable.Weapon Buff.Stone.Weight Stone", "INV_Stone_WeightStone_02", "Consumable.Weapon Buff.Stone.Weight Stone")
	AutoBarCategoryList["Consumable.Weapon Buff.Stone.Weight Stone"]:SetTargeted("WEAPON")


	AutoBarCategoryList["Consumable.Buff Group.General.Self"] = ItemsCategory:new("Consumable.Buff Group.General.Self", "INV_Potion_80", "Consumable.Buff Group.General.Self")

	AutoBarCategoryList["Consumable.Buff Group.General.Target"] = ItemsCategory:new("Consumable.Buff Group.General.Target", "INV_Potion_80", "Consumable.Buff Group.General.Target")
	AutoBarCategoryList["Consumable.Buff Group.General.Target"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff Group.Caster.Self"] = ItemsCategory:new("Consumable.Buff Group.Caster.Self", "INV_Potion_66", "Consumable.Buff Group.Caster.Self")

	AutoBarCategoryList["Consumable.Buff Group.Caster.Target"] = ItemsCategory:new("Consumable.Buff Group.Caster.Target", "INV_Potion_66", "Consumable.Buff Group.Caster.Target")
	AutoBarCategoryList["Consumable.Buff Group.Caster.Target"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff Group.Melee.Self"] = ItemsCategory:new("Consumable.Buff Group.Melee.Self", "INV_Potion_43", "Consumable.Buff Group.Melee.Self")

	AutoBarCategoryList["Consumable.Buff Group.Melee.Target"] = ItemsCategory:new("Consumable.Buff Group.Melee.Target", "INV_Potion_43", "Consumable.Buff Group.Melee.Target")
	AutoBarCategoryList["Consumable.Buff Group.Melee.Target"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Other.Self"] = ItemsCategory:new("Consumable.Buff.Other.Self", "INV_Potion_80", "Consumable.Buff.Other.Self")

	AutoBarCategoryList["Consumable.Buff.Water Breathing"] = ItemsCategory:new("Consumable.Buff.Water Breathing", "INV_Potion_80", "Consumable.Buff.Water Breathing")

	AutoBarCategoryList["Muffin.Potion.Water Breathing"] = ItemsCategory:new("Muffin.Potion.Water Breathing", "INV_Potion_80", "Muffin.Potion.Water Breathing")

	AutoBarCategoryList["Consumable.Buff.Chest"] = ItemsCategory:new("Consumable.Buff.Chest", "INV_Misc_Rune_10", "Consumable.Buff.Chest")
	AutoBarCategoryList["Consumable.Buff.Chest"]:SetTargeted("CHEST")

	AutoBarCategoryList["Consumable.Buff.Shield"] = ItemsCategory:new("Consumable.Buff.Shield", "INV_Misc_Rune_13", "Consumable.Buff.Shield")
	AutoBarCategoryList["Consumable.Buff.Shield"]:SetTargeted("SHIELD")

	AutoBarCategoryList["Consumable.Weapon Buff"] = ItemsCategory:new("Consumable.Weapon Buff", "INV_Misc_Rune_13", "Consumable.Weapon Buff")
	AutoBarCategoryList["Consumable.Weapon Buff"]:SetTargeted("WEAPON")

	AutoBarCategoryList["Consumable.Buff.Health"] = ItemsCategory:new("Consumable.Buff.Health", "INV_Potion_43", "Consumable.Buff.Health")

	AutoBarCategoryList["Consumable.Buff.Armor"] = ItemsCategory:new("Consumable.Buff.Armor", "INV_Potion_66", "Consumable.Buff.Armor")

	AutoBarCategoryList["Consumable.Buff.Regen Health"] = ItemsCategory:new("Consumable.Buff.Regen Health", "INV_Potion_80", "Consumable.Buff.Regen Health")

	AutoBarCategoryList["Consumable.Buff.Agility"] = ItemsCategory:new("Consumable.Buff.Agility", "INV_Scroll_02", "Consumable.Buff.Agility")
	AutoBarCategoryList["Consumable.Buff.Agility"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Intellect"] = ItemsCategory:new("Consumable.Buff.Intellect", "INV_Scroll_01", "Consumable.Buff.Intellect")
	AutoBarCategoryList["Consumable.Buff.Intellect"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Spirit"] = ItemsCategory:new("Consumable.Buff.Spirit", "INV_Scroll_01", "Consumable.Buff.Spirit")
	AutoBarCategoryList["Consumable.Buff.Spirit"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Stamina"] = ItemsCategory:new("Consumable.Buff.Stamina", "INV_Scroll_07", "Consumable.Buff.Stamina")
	AutoBarCategoryList["Consumable.Buff.Stamina"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Strength"] = ItemsCategory:new("Consumable.Buff.Strength", "INV_Scroll_02", "Consumable.Buff.Strength")
	AutoBarCategoryList["Consumable.Buff.Strength"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Attack Power"] = ItemsCategory:new("Consumable.Buff.Attack Power", "INV_Misc_MonsterScales_07", "Consumable.Buff.Attack Power")
	AutoBarCategoryList["Consumable.Buff.Attack Power"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Attack Speed"] = ItemsCategory:new("Consumable.Buff.Attack Speed", "INV_Misc_MonsterScales_17", "Consumable.Buff.Attack Speed")
	AutoBarCategoryList["Consumable.Buff.Attack Speed"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Dodge"] = ItemsCategory:new("Consumable.Buff.Dodge", "INV_Misc_MonsterScales_17", "Consumable.Buff.Dodge")
	AutoBarCategoryList["Consumable.Buff.Dodge"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Resistance.Self"] = ItemsCategory:new("Consumable.Buff.Resistance", "INV_Misc_MonsterScales_15", "Consumable.Buff.Resistance.Self")

	AutoBarCategoryList["Consumable.Buff.Resistance.Target"] = ItemsCategory:new("Consumable.Buff.Resistance", "INV_Misc_MonsterScales_15", "Consumable.Buff.Resistance.Target")
	AutoBarCategoryList["Consumable.Buff.Resistance.Target"]:SetTargeted(true)

	AutoBarCategoryList["Consumable.Buff.Speed"] = ItemsCategory:new("Consumable.Buff.Speed", "INV_Potion_95", "Consumable.Buff.Speed")

	AutoBarCategoryList["Consumable.Buff Type.Battle"] = ItemsCategory:new("Consumable.Buff Type.Battle", "INV_Potion_111", "Consumable.Buff Type.Battle")

	AutoBarCategoryList["Consumable.Buff Type.Guardian"] = ItemsCategory:new("Consumable.Buff Type.Guardian", "INV_Potion_155", "Consumable.Buff Type.Guardian")

	AutoBarCategoryList["Consumable.Buff Type.Flask"] = ItemsCategory:new("Consumable.Buff Type.Flask", "INV_Potion_118", "Consumable.Buff Type.Flask")

	AutoBarCategoryList["Muffin.Flask"] = ItemsCategory:new("Muffin.Flask", "INV_Potion_118", "Muffin.Flask")

	AutoBarCategoryList["Muffin.Elixir.Guardian"] = ItemsCategory:new("Muffin.Elixir.Guardian", "INV_Potion_118", "Muffin.Elixir.Guardian")

	AutoBarCategoryList["Muffin.Elixir.Battle"] = ItemsCategory:new("Muffin.Elixir.Battle", "INV_Potion_118", "Muffin.Elixir.Battle")

	AutoBarCategoryList["Muffin.Potion.Buff"] = ItemsCategory:new("Muffin.Potion.Buff", "INV_Potion_118", "Muffin.Potion.Buff")

	AutoBarCategoryList["Muffin.Gear.Trinket"] = ItemsCategory:new("Muffin.Gear.Trinket", "INV_Misc_OrnateBox", "Muffin.Gear.Trinket")

	AutoBarCategoryList["Misc.Lockboxes"] = ItemsCategory:new("Misc.Lockboxes", "INV_Trinket_Naxxramas06", "Misc.Lockboxes")

	AutoBarCategoryList["Misc.Usable.BossItem"] = ItemsCategory:new("Misc.Usable.BossItem", "INV_BannerPVP_02", "Misc.Usable.BossItem")

	AutoBarCategoryList["Misc.Usable.Fun"] = ItemsCategory:new("Misc.Usable.Fun", "INV_Misc_Toy_10", "Misc.Usable.Fun")

	AutoBarCategoryList["Misc.Usable.Permanent"] = ItemsCategory:new("Misc.Usable.Permanent", "INV_BannerPVP_02", "Misc.Usable.Permanent")

	AutoBarCategoryList["Misc.Usable.Quest"] = ItemsCategory:new("Misc.Usable.Quest", "INV_BannerPVP_02", "Misc.Usable.Quest")

	AutoBarCategoryList["Misc.Usable.StartsQuest"] = ItemsCategory:new("Misc.Usable.StartsQuest", "INV_Staff_20", "Misc.Usable.StartsQuest")

	AutoBarCategoryList["Muffin.Misc.StartsQuest"] = ItemsCategory:new("Muffin.Misc.StartsQuest", "INV_Staff_20", "Muffin.Misc.StartsQuest")

	AutoBarCategoryList["Muffin.Misc.Quest"] = ItemsCategory:new("Muffin.Misc.Quest", "INV_BannerPVP_02", "Muffin.Misc.Quest")

	AutoBarCategoryList["Misc.Usable.Replenished"] = ItemsCategory:new("Misc.Usable.Replenished", "INV_BannerPVP_02", "Misc.Usable.Replenished")






end



function ABGCode.UpdateCustomCategories()
	local customCategories = AutoBarDB2.custom_categories

	for categoryKey, customCategoriesDB in pairs(customCategories) do
		assert(customCategoriesDB and (categoryKey == customCategoriesDB.categoryKey), "customCategoriesDB nil or bad categoryKey")
		if (not AutoBarCategoryList[categoryKey]) then
			AutoBarCategoryList[categoryKey] = CustomCategory:new(customCategoriesDB)
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
