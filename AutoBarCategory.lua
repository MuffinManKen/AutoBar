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
local spellNameList = ABGData.spell_name_list
local spellIconList = ABGData.spell_icon_list


AutoBarCategoryList = {}

local L = AutoBarGlobalDataObject.locale
local PT = LibStub("LibPeriodicTable-3.1")
local AceOO = AceLibrary("AceOO-2.0")
local _

-- List of categoryKey, category.description pairs for button categories
AutoBar.categoryValidateList = {}

	--All
	ABGCS:CacheSpellData(125439, "Revive Battle Pets");

	--DeathKnight
	ABGCS:CacheSpellData(3714, "Path of Frost");
	ABGCS:CacheSpellData(63560, "Dark Transformation");
	ABGCS:CacheSpellData(45524, "Chains of Ice");
	ABGCS:CacheSpellData(48707, "Anti-Magic Shell");
	ABGCS:CacheSpellData(48792, "Icebound Fortitude");
	ABGCS:CacheSpellData(47528, "Mind Freeze");
	ABGCS:CacheSpellData(194679, "Rune Tap");
	ABGCS:CacheSpellData(49028, "Rune Weapon");
	ABGCS:CacheSpellData(46584, "Raise Dead");
	ABGCS:CacheSpellData(49206, "Summon Gargoyle");
	ABGCS:CacheSpellData(42650, "Army of the Dead");

	--DemonHunter
	ABGCS:CacheSpellData(195072, "Fel Rush");
	ABGCS:CacheSpellData(198793, "Vengeful Retreat");
	ABGCS:CacheSpellData(198589, "Blur");
	ABGCS:CacheSpellData(196718, "Darkness");
	ABGCS:CacheSpellData(204596, "Sigil of Flame");
	ABGCS:CacheSpellData(207684, "Sigil of Misery");
	ABGCS:CacheSpellData(202137, "Sigil of Silence");
	ABGCS:CacheSpellData(183752, "Consume Magic");


	--Druid
	ABGCS:CacheSpellData(22812, "Barkskin");
	ABGCS:CacheSpellData(99, "Disorienting Roar");
	ABGCS:CacheSpellData(102342, "Ironbark");
	ABGCS:CacheSpellData(5215, "Prowl");
	ABGCS:CacheSpellData(22842, "Frenzied Regeneration");
	ABGCS:CacheSpellData(102401, "Wild Charge");
	ABGCS:CacheSpellData(5487, "Bear Form");
	ABGCS:CacheSpellData(33917, "Mangle");
	ABGCS:CacheSpellData(768, "Cat Form");
	ABGCS:CacheSpellData(197625, "Moonkin Form");
	ABGCS:CacheSpellData(114282, "Treant Form");
	ABGCS:CacheSpellData(210053, "Stag Form");
	ABGCS:CacheSpellData(33943, "Flight Form");
	ABGCS:CacheSpellData(40120, "Swift Flight Form");
	ABGCS:CacheSpellData(783, "Travel Form");

	--Hunter
	ABGCS:CacheSpellData(61648, "Aspect of the Chameleon");
	ABGCS:CacheSpellData(186257, "Aspect of the Cheetah");
	ABGCS:CacheSpellData(186289, "Aspect of the Eagle");
	ABGCS:CacheSpellData(186265, "Aspect of the Turtle");
	ABGCS:CacheSpellData(193530, "Aspect of the Wild");
	ABGCS:CacheSpellData(1462, "Beast Lore");
	ABGCS:CacheSpellData(19574, "Bestial Wrath");
	ABGCS:CacheSpellData(109248, "Binding Shot");
	ABGCS:CacheSpellData(883, "Call Pet 1"); 
	ABGCS:CacheSpellData(83242, "Call Pet 2");
	ABGCS:CacheSpellData(83243, "Call Pet 3");
	ABGCS:CacheSpellData(83244, "Call Pet 4");
	ABGCS:CacheSpellData(83245, "Call Pet 5");
	ABGCS:CacheSpellData(199483, "Camouflage");
	ABGCS:CacheSpellData(5116, "Concussive Shot");
	ABGCS:CacheSpellData(147362, "Counter Shot");
	ABGCS:CacheSpellData(120679, "Dire Beast");
	ABGCS:CacheSpellData(217200, "Dire Frenzy");
	ABGCS:CacheSpellData(781, "Disengage");
	ABGCS:CacheSpellData(2641, "Dismiss Pet");
	ABGCS:CacheSpellData(6197, "Eagle Eye");
	ABGCS:CacheSpellData(6991, "Feed Pet");
	ABGCS:CacheSpellData(5384, "Feign Death");
	ABGCS:CacheSpellData(125050, "Fetch");
	ABGCS:CacheSpellData(190925, "Harpoon");
	ABGCS:CacheSpellData(7093, "Intimidation");
	ABGCS:CacheSpellData(34026, "Kill Command");
	ABGCS:CacheSpellData(53271, "Master's Call");
	ABGCS:CacheSpellData(136, "Mend Pet");
	ABGCS:CacheSpellData(209997, "Play Dead");
	ABGCS:CacheSpellData(200108, "Ranger's Net");
	ABGCS:CacheSpellData(982, "Revive Pet");
	ABGCS:CacheSpellData(206817, "Sentinel");
	ABGCS:CacheSpellData(1515, "Tame Beast");
	ABGCS:CacheSpellData(210000, "Wake Up");
	ABGCS:CacheSpellData(195645, "Wing Clip");
	ABGCS:CacheSpellData(187650, "Freezing Trap");
	ABGCS:CacheSpellData(191433, "Explosive Trap");
	ABGCS:CacheSpellData(187698, "Tar Trap");
	ABGCS:CacheSpellData(194277, "Caltrops");
	ABGCS:CacheSpellData(162488, "Steel Trap");


	--Mage
	ABGCS:CacheSpellData(11426, "Ice Barrier");
	ABGCS:CacheSpellData(235450, "Prismatic Barrier");
	ABGCS:CacheSpellData(235313, "Blazing Barrier");
	ABGCS:CacheSpellData(198111, "Temporal Shield");
	ABGCS:CacheSpellData(130, "Slow Fall");
	ABGCS:CacheSpellData(42955, "Conjure Refreshment");
	ABGCS:CacheSpellData(43987, "Conjure Refreshment Table");
	ABGCS:CacheSpellData(66, "Invisibility");
	ABGCS:CacheSpellData(110959, "Greater Invisibility");
	ABGCS:CacheSpellData(27619, "Ice Block");
	ABGCS:CacheSpellData(31687, "Summon Water Elemental");

	--Monk
	ABGCS:CacheSpellData(126892, "Zen Pilgrimage");
	ABGCS:CacheSpellData(126895, "Zen Pilgrimage: Return");
	ABGCS:CacheSpellData(115203, "Fortifying Brew");
	ABGCS:CacheSpellData(137639, "Storm, Earth, and Fire");

	--Paladin
	ABGCS:CacheSpellData(31850, "Ardent Defender"); 
	ABGCS:CacheSpellData(642, "Divine Shield"); 
	ABGCS:CacheSpellData(1044, "Blessing of Freedom"); 
	ABGCS:CacheSpellData(1022, "Blessing of Protection"); 
	ABGCS:CacheSpellData(6940, "Blessing of Sacrifice"); 
	ABGCS:CacheSpellData(204018, "Blessing of Spellwarding"); 
	ABGCS:CacheSpellData(204013, "Blessing of Salvation"); 
	ABGCS:CacheSpellData(203538, "Greater Blessing of Kings"); 
	ABGCS:CacheSpellData(203539, "Greater Blessing of Wisdom"); 
	ABGCS:CacheSpellData(183218, "Hand of Hindrance");
	ABGCS:CacheSpellData(96231, "Rebuke");
	ABGCS:CacheSpellData(633, "Lay on Hands");

	--Priest
	ABGCS:CacheSpellData(17, "Power Word: Shield");
	ABGCS:CacheSpellData(34433, "Shadowfiend");
	ABGCS:CacheSpellData(47585, "Dispersion");
	ABGCS:CacheSpellData(47788, "Guardian Spirit");
	ABGCS:CacheSpellData(33206, "Pain Suppression");

	--Rogue
	ABGCS:CacheSpellData(200802, "Agonizing Poison");
	ABGCS:CacheSpellData(3408, "Crippling Poison");
	ABGCS:CacheSpellData(2823, "Deadly Poison");
	ABGCS:CacheSpellData(4086, "Evasion");
	ABGCS:CacheSpellData(1766, "Kick");
	ABGCS:CacheSpellData(108211, "Leeching Poison");
	ABGCS:CacheSpellData(199754, "Riposte");
	ABGCS:CacheSpellData(36554, "Shadowstep");
	ABGCS:CacheSpellData(1784, "Stealth");
	ABGCS:CacheSpellData(1856, "Vanish");
	ABGCS:CacheSpellData(8679, "Wound Poison");

	--Shaman
	ABGCS:CacheSpellData(2484, "Earthbind Totem");
	ABGCS:CacheSpellData(51485, "Earthgrab Totem");
	ABGCS:CacheSpellData(51533, "Feral Spirit");
	ABGCS:CacheSpellData(546, "Water Walking");
	ABGCS:CacheSpellData(192077, "Wind Rush Totem");
	ABGCS:CacheSpellData(2645, "Ghost Wolf");
	ABGCS:CacheSpellData(198103, "Earth Elemental");
	ABGCS:CacheSpellData(198067, "Fire Elemental");
	ABGCS:CacheSpellData(192249, "Storm Elemental");


	--Warlock
	ABGCS:CacheSpellData(104316, "Call Dreadstalkers"); 
	ABGCS:CacheSpellData(119898, "Command Demon"); 
	ABGCS:CacheSpellData(199954, "Curse of Fragility"); 
	ABGCS:CacheSpellData(199890, "Curse of Tongues"); 
	ABGCS:CacheSpellData(199892, "Curse of Weakness"); 
	ABGCS:CacheSpellData(108416, "Dark Pact");
	ABGCS:CacheSpellData(193396, "Demonic Empowerment"); 
	ABGCS:CacheSpellData(193440, "Demonwrath"); 
	ABGCS:CacheSpellData(108503, "Grimoire of Sacrifice"); 
	ABGCS:CacheSpellData(111897, "Grimoire: Felhunter"); 
	ABGCS:CacheSpellData(20707, "Soulstone"); 
	ABGCS:CacheSpellData(205180, "Summon Darkglare"); 
	ABGCS:CacheSpellData(5697, "Unending Breath");
	ABGCS:CacheSpellData(104773, "Unending Resolve");
	ABGCS:CacheSpellData(6201, "Create Healthstone");
	ABGCS:CacheSpellData(29893, "Ritual of Souls");
	ABGCS:CacheSpellData(126, "RitualSouls");
	ABGCS:CacheSpellData(30146, "Eye of Kilrogg");
	ABGCS:CacheSpellData(691, "Summon Felhunter");
	ABGCS:CacheSpellData(688, "Summon Imp");
	ABGCS:CacheSpellData(712, "Summon Succubus");
	ABGCS:CacheSpellData(697, "Summon Voidwalker");
	ABGCS:CacheSpellData(1122, "Summon Infernal");
	ABGCS:CacheSpellData(30146, "Summon Felguard");


	--Warrior
	ABGCS:CacheSpellData(100, "Charge");
	ABGCS:CacheSpellData(97462, "Commanding Shout");
	ABGCS:CacheSpellData(197690, "Defensive Stance");
	ABGCS:CacheSpellData(1160, "Demoralizing Shout");
	ABGCS:CacheSpellData(184364, "Enraged Regeneration");
	ABGCS:CacheSpellData(198304, "Intercept");
	ABGCS:CacheSpellData(2565, "Shield Block"); 
	ABGCS:CacheSpellData(871, "Shield Wall"); 
	ABGCS:CacheSpellData(12975, "Last Stand");

	--Other
	ABGCS:CacheSpellData(58984, "Shadowmeld");

	--Skills
	ABGCS:CacheSpellData(27028, "First Aid");
	ABGCS:CacheSpellData(28596, "Alchemy");
	ABGCS:CacheSpellData(818, "BasicCampfire");
	ABGCS:CacheSpellData(29844, "Blacksmithing");
	ABGCS:CacheSpellData(33359, "Cooking");
	if (GetLocale() == "deDE") then
		ABGCS:CacheSpellData(51296, "Kochen");
		ABGCS:CacheSpellData(51304, "Alchemie");
	end
	ABGCS:CacheSpellData(78670, "Archaeology");
	ABGCS:CacheSpellData(13262, "Disenchant");
	ABGCS:CacheSpellData(28029, "Enchanting");
	ABGCS:CacheSpellData(30350, "Engineering");
	ABGCS:CacheSpellData(45357, "Inscription");
	ABGCS:CacheSpellData(28897, "Jewelcrafting");
	ABGCS:CacheSpellData(32549, "Leatherworking");
	ABGCS:CacheSpellData(51005, "Milling");
	ABGCS:CacheSpellData(31252, "Prospecting");
	ABGCS:CacheSpellData(53428, "Runeforging");
	ABGCS:CacheSpellData(2656, "Smelting");
	ABGCS:CacheSpellData(80451, "Survey");
	ABGCS:CacheSpellData(26790, "Tailoring");



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

AutoBarToyCategory = AceOO.Class(AutoBarCategory)

function AutoBarToyCategory.prototype:init(description, shortTexture, p_pt_name)
	AutoBarToyCategory.super.prototype.init(self, description, shortTexture) -- Mandatory init.
	self.is_toy = true
	
	-- Current active items
	self.items = {}
	--All items in the category
	self.all_items = {}

	if(p_pt_name) then
		--print("pt_name", p_pt_name);
		local rawList = nil
		rawList = AddSetToRawItems(rawList, p_pt_name, false)
		self.all_items = RawListToItemIDList(rawList)
		--print("all_items", AutoBar:Dump(self.all_items))
	end

	self:Refresh()

end

-- Reset the item list in case the player learned new toys
function AutoBarToyCategory.prototype:Refresh()
	local list_index = 1

--	if(self.categoryKey == "Muffin.Toys.Hearth") then 
--		print("Refreshing Toy Category", self.categoryKey, #self.items, #self.all_items);
--	end

	for _, toy_id in ipairs(self.all_items) do
--		if(self.categoryKey == "Muffin.Toys.Hearth") then print(toy_id, PlayerHasToy(toy_id), C_ToyBox.IsToyUsable(toy_id)); end
		if (toy_id and PlayerHasToy(toy_id) and C_ToyBox.IsToyUsable(toy_id)) then
			AutoBarSearch:RegisterToy(toy_id)
			self.items[list_index] = ABGCS:ToyGUID(toy_id)
			list_index = list_index + 1
		end
	end

	--trim any missing ones of the end. You never forget Toys, so is this needed?
	--Nope.  WoW API sometimes says existing items aren't there, so this would then trim them.  If we've ever seen it, keep it.
	--for i = list_index, # self.items, 1 do
	--	self.items[i] = nil
	--end
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

	AutoBarCategoryList["Muffin.Toys.Hearth"] = AutoBarToyCategory:new( "Muffin.Toys.Hearth", spellIconList["Puntable Marmot"], "Muffin.Toys.Hearth")
	AutoBarCategoryList["Muffin.Toys.Pet Battle"] = AutoBarToyCategory:new( "Muffin.Toys.Pet Battle", spellIconList["Puntable Marmot"], "Muffin.Toys.Pet Battle")
	AutoBarCategoryList["Muffin.Toys.Companion Pet.Ornamental"] = AutoBarToyCategory:new( "Muffin.Toys.Companion Pet.Ornamental", spellIconList["Puntable Marmot"], "Muffin.Toys.Companion Pet.Ornamental")
	AutoBarCategoryList["Muffin.Toys.Portal"] = AutoBarToyCategory:new( "Muffin.Toys.Portal", "ability_siege_engineer_pattern_recognition", "Muffin.Toys.Portal")
	AutoBarCategoryList["Muffin.Toys.Fishing"] = AutoBarToyCategory:new( "Muffin.Toys.Fishing", "INV_Fishingpole_01", "Muffin.Toys.Fishing")


	AutoBarCategoryList["Macro.BattlePet.SummonRandom"] = AutoBarMacroTextCategory:new( "Macro.BattlePet.SummonRandom", "INV_MISC_QUESTIONMARK")
	AutoBarCategoryList["Macro.BattlePet.SummonRandom"]:AddMacroText("/randompet",  "Interface/Icons/INV_MISC_QUESTIONMARK", L["Summon A Random Pet"])

	AutoBarCategoryList["Macro.BattlePet.SummonRandomFave"] = AutoBarMacroTextCategory:new( "Macro.BattlePet.SummonRandomFave", "PetBattle_Health")
	AutoBarCategoryList["Macro.BattlePet.SummonRandomFave"]:AddMacroText("/randomfavoritepet",  "Interface/Icons/PetBattle_Health", L["Summon A Random Fave Pet"])

	AutoBarCategoryList["Macro.BattlePet.DismissPet"] = AutoBarMacroTextCategory:new( "Macro.BattlePet.DismissPet", "Spell_BrokenHeart")
	AutoBarCategoryList["Macro.BattlePet.DismissPet"]:AddMacroText("/dismisspet",  "Interface/Icons/Spell_BrokenHeart", L["Dismiss Battle Pet"])

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

	AutoBarCategoryList["Muffin.Skill.Archaeology.Crate"] = AutoBarItems:new( "Muffin.Skill.Archaeology.Crate", "INV_Misc_Food_26", "Muffin.Skill.Archaeology.Crate")
	AutoBarCategoryList["Muffin.Skill.Archaeology.Mission"] = AutoBarItems:new( "Muffin.Skill.Archaeology.Mission", "INV_Misc_Food_26", "Muffin.Skill.Archaeology.Mission")

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



	AutoBarCategoryList["Consumable.Food.Edible.Combo.Conjured"] = AutoBarItems:new( "Consumable.Food.Edible.Combo.Conjured", spellIconList["Conjure Refreshment"], "Consumable.Food.Edible.Combo.Conjured")
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

	AutoBarCategoryList["Muffin.SunSongRanch"] = AutoBarItems:new("Muffin.SunSongRanch", "INV_Potion_76", "Muffin.SunSongRanch")

	AutoBarCategoryList["Muffin.Garrison"] = AutoBarItems:new("Muffin.Garrison", "INV_Potion_76", "Muffin.Garrison")

	AutoBarCategoryList["Muffin.Order Hall.Artifact Power"] = AutoBarItems:new("Muffin.Order Hall.Artifact Power", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Artifact Power")
	AutoBarCategoryList["Muffin.Order Hall.Nethershard"] = AutoBarItems:new("Muffin.Order Hall.Nethershard", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Nethershard")
	AutoBarCategoryList["Muffin.Order Hall.Troop Recruit"] = AutoBarItems:new("Muffin.Order Hall.Troop Recruit", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Troop Recruit")
	AutoBarCategoryList["Muffin.Order Hall.Buff"] = AutoBarItems:new("Muffin.Order Hall.Buff", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Buff")
	AutoBarCategoryList["Muffin.Order Hall.Champion"] = AutoBarItems:new("Muffin.Order Hall.Champion", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Champion")
	AutoBarCategoryList["Muffin.Order Hall.Ancient Mana"] = AutoBarItems:new("Muffin.Order Hall.Ancient Mana", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Ancient Mana")
	AutoBarCategoryList["Muffin.Order Hall.Order Resources"] = AutoBarItems:new("Muffin.Order Hall.Order Resources", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Order Resources")

	AutoBarCategoryList["Muffin.Reputation"] = AutoBarItems:new("Muffin.Reputation", "archaeology_5_0_mogucoin", "Muffin.Reputation")


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
			"MAGE", spellNameList["Conjure Refreshment"],
			})

	AutoBarCategoryList["Consumable.Food.Conjure"] = AutoBarSpells:new("Consumable.Food.Conjure", spellIconList["Conjure Refreshment"], {
			"MAGE", spellNameList["Conjure Refreshment"],
			})

	AutoBarCategoryList["Spell.Pet Battle"] = AutoBarSpells:new("Spell.Pet Battle", spellIconList["Conjure Refreshment"],
	{
		"*", spellNameList["Revive Battle Pets"],
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

	AutoBarCategoryList["Muffin.Misc.Quest"] = AutoBarItems:new("Muffin.Misc.Quest", "INV_BannerPVP_02", "Muffin.Misc.Quest")

	AutoBarCategoryList["Misc.Usable.Replenished"] = AutoBarItems:new("Misc.Usable.Replenished", "INV_BannerPVP_02", "Misc.Usable.Replenished")

	AutoBarCategoryList["Muffin.Battle Pet Items.Upgrade"] = AutoBarItems:new("Muffin.Battle Pet Items.Upgrade", "INV_BannerPVP_02", "Muffin.Battle Pet Items.Upgrade")

	AutoBarCategoryList["Muffin.Battle Pet Items.Level"] = AutoBarItems:new("Muffin.Battle Pet Items.Level", "INV_BannerPVP_02", "Muffin.Battle Pet Items.Level")

	AutoBarCategoryList["Muffin.Battle Pet Items.Bandages"] = AutoBarItems:new("Muffin.Battle Pet Items.Bandages", "INV_BannerPVP_02", "Muffin.Battle Pet Items.Bandages")

	AutoBarCategoryList["Muffin.Battle Pet Items.Pet Treat"] = AutoBarItems:new("Muffin.Battle Pet Items.Pet Treat", "INV_BannerPVP_02", "Muffin.Battle Pet Items.Pet Treat")



	AutoBarCategoryList["Spell.Warlock.Create Healthstone"] = AutoBarSpells:new( "Spell.Warlock.Create Healthstone", spellIconList["Create Healthstone"], nil,
	{
		"WARLOCK", AutoBar:GetSpellNameByName("Create Healthstone"), AutoBar:GetSpellNameByName("Ritual of Souls"),
	})

	AutoBarCategoryList["Spell.Mage.Conjure Food"] = AutoBarSpells:new( "Spell.Mage.Conjure Food", spellIconList["Conjure Refreshment"], nil, {
			"MAGE", spellNameList["Conjure Refreshment"], spellNameList["Conjure Refreshment Table"],
			})


	AutoBarCategoryList["Spell.Stealth"] = AutoBarSpells:new("Spell.Stealth", spellIconList["Stealth"],
	{
			"DRUID", spellNameList["Prowl"],
			"MAGE", spellNameList["Invisibility"],
			"MAGE", spellNameList["Greater Invisibility"],
		"HUNTER", AutoBar:GetSpellNameByName("Camouflage"),
		"ROGUE", AutoBar:GetSpellNameByName("Stealth"),
		"*", spellNameList["Shadowmeld"],
	})


	AutoBarCategoryList["Spell.Aspect"] = AutoBarSpells:new("Spell.Aspect", spellIconList["Aspect of the Cheetah"],
	{
		"HUNTER", AutoBar:GetSpellNameByName("Aspect of the Cheetah"), 
		"HUNTER", AutoBar:GetSpellNameByName("Aspect of the Chameleon"), 
		"HUNTER", AutoBar:GetSpellNameByName("Aspect of the Turtle"),
		"HUNTER", AutoBar:GetSpellNameByName("Aspect of the Eagle"), 
		"HUNTER", AutoBar:GetSpellNameByName("Aspect of the Wild"), 
	})
	
		
	AutoBarCategoryList["Spell.Poison.Lethal"] = AutoBarSpells:new( "Spell.Poison.Lethal", spellIconList["Deadly Poison"], {
		"ROGUE", AutoBar:GetSpellNameByName("Agonizing Poison"), 
		"ROGUE", AutoBar:GetSpellNameByName("Deadly Poison"), 
		"ROGUE", AutoBar:GetSpellNameByName("Wound Poison"), 
	})

	AutoBarCategoryList["Spell.Poison.Nonlethal"] = AutoBarSpells:new(
			"Spell.Poison.Nonlethal", spellIconList["Crippling Poison"], {
			"ROGUE", AutoBar:GetSpellNameByName("Crippling Poison"), 
			"ROGUE", AutoBar:GetSpellNameByName("Leeching Poison"), 
			})



	AutoBarCategoryList["Spell.Class.Buff"] = AutoBarSpells:new( "Spell.Class.Buff", spellIconList["Barkskin"],
	{
		"DEATHKNIGHT", AutoBar:GetSpellNameByName("Path of Frost"),
			"DRUID", spellNameList["Ironbark"],
			"MAGE", spellNameList["Slow Fall"],
		"PALADIN", AutoBar:GetSpellNameByName("Blessing of Freedom"),
		"PALADIN", AutoBar:GetSpellNameByName("Blessing of Protection"),
		"PALADIN", AutoBar:GetSpellNameByName("Blessing of Sacrifice"),
		"PALADIN", AutoBar:GetSpellNameByName("Blessing of Spellwarding"),
		"PALADIN", AutoBar:GetSpellNameByName("Blessing of Salvation"),
		"PALADIN", AutoBar:GetSpellNameByName("Greater Blessing of Kings"),
		"PALADIN", AutoBar:GetSpellNameByName("Greater Blessing of Wisdom"),
			"SHAMAN", spellNameList["Water Walking"],
		"WARLOCK", AutoBar:GetSpellNameByName("Unending Breath"),
		"WARLOCK", AutoBar:GetSpellNameByName("Soulstone"),
			"WARRIOR", spellNameList["Commanding Shout"],
			"WARRIOR", spellNameList["Demoralizing Shout"],
	})

	AutoBarCategoryList["Spell.Class.Pet"] = AutoBarSpells:new( "Spell.Class.Pet", spellIconList["Call Pet 1"],
	{
		"DEATHKNIGHT", AutoBar:GetSpellNameByName("Rune Weapon"),
		"DEATHKNIGHT", AutoBar:GetSpellNameByName("Raise Dead"),
		"DEATHKNIGHT", AutoBar:GetSpellNameByName("Army of the Dead"),
		"DEATHKNIGHT", AutoBar:GetSpellNameByName("Summon Gargoyle"),
		"HUNTER", AutoBar:GetSpellNameByName("Call Pet 1"), 
		"HUNTER", AutoBar:GetSpellNameByName("Call Pet 2"), 
		"HUNTER", AutoBar:GetSpellNameByName("Call Pet 3"), 
		"HUNTER", AutoBar:GetSpellNameByName("Call Pet 4"), 
		"HUNTER", AutoBar:GetSpellNameByName("Call Pet 5"), 
		"MAGE", AutoBar:GetSpellNameByName("Summon Water Elemental"),
		"MONK", AutoBar:GetSpellNameByName("Storm, Earth, and Fire"),
		"PRIEST", AutoBar:GetSpellNameByName("Shadowfiend"), 
		"SHAMAN", AutoBar:GetSpellNameByName("Earth Elemental"),
		"SHAMAN", AutoBar:GetSpellNameByName("Fire Elemental"),
		"SHAMAN", AutoBar:GetSpellNameByName("Storm Elemental"),
		"SHAMAN", AutoBar:GetSpellNameByName("Feral Spirit"),
		"WARLOCK", AutoBar:GetSpellNameByName("Eye of Kilrogg"),
		"WARLOCK", AutoBar:GetSpellNameByName("Summon Infernal"),
		"WARLOCK", AutoBar:GetSpellNameByName("Summon Felguard"),
		"WARLOCK", AutoBar:GetSpellNameByName("Summon Felhunter"),
		"WARLOCK", AutoBar:GetSpellNameByName("Summon Imp"),
		"WARLOCK", AutoBar:GetSpellNameByName("Summon Succubus"),
		"WARLOCK", AutoBar:GetSpellNameByName("Summon Voidwalker"),
	})



	AutoBarCategoryList["Spell.Class.Pets2"] = AutoBarSpells:new( "Spell.Class.Pets2", spellIconList["Call Pet 1"], 
	{
		"DEATHKNIGHT", AutoBar:GetSpellNameByName("Dark Transformation"),
		"HUNTER", AutoBar:GetSpellNameByName("Kill Command"),
		"HUNTER", AutoBar:GetSpellNameByName("Bestial Wrath"),
		"HUNTER", AutoBar:GetSpellNameByName("Dire Beast"),
		"HUNTER", AutoBar:GetSpellNameByName("Dire Frenzy"),
		"HUNTER", AutoBar:GetSpellNameByName("Master's Call"),
		"HUNTER", AutoBar:GetSpellNameByName("Mend Pet"),
		"HUNTER", AutoBar:GetSpellNameByName("Intimidation"),
		"WARLOCK", AutoBar:GetSpellNameByName("Command Demon"),
		"WARLOCK", AutoBar:GetSpellNameByName("Call Dreadstalkers"),
		"WARLOCK", AutoBar:GetSpellNameByName("Grimoire of Sacrifice"),
		"WARLOCK", AutoBar:GetSpellNameByName("Demonic Empowerment"),
		"WARLOCK", AutoBar:GetSpellNameByName("Demonwrath"),
		"WARLOCK", AutoBar:GetSpellNameByName("Summon Darkglare"),
	})

	--Misc pet abilities
	AutoBarCategoryList["Spell.Class.Pets3"] = AutoBarSpells:new(	"Spell.Class.Pets3", spellIconList["Feed Pet"], 
	{
		"HUNTER", AutoBar:GetSpellNameByName("Dismiss Pet"),
		"HUNTER", AutoBar:GetSpellNameByName("Eagle Eye"),
		"HUNTER", AutoBar:GetSpellNameByName("Feed Pet"),
		"HUNTER", AutoBar:GetSpellNameByName("Revive Pet"),
		"HUNTER", AutoBar:GetSpellNameByName("Tame Beast"),
		"HUNTER", AutoBar:GetSpellNameByName("Beast Lore"),
		"HUNTER", AutoBar:GetSpellNameByName("Fetch"),
		"HUNTER", AutoBar:GetSpellNameByName("Play Dead"),
		"HUNTER", AutoBar:GetSpellNameByName("Wake Up"),
	})


	local spellPortalShattrath, spellPortalShattrathIcon
	spellPortalShattrath, _, spellPortalShattrathIcon = AutoBar:LoggedGetSpellInfo(33691)
	local spellTeleportStonard = AutoBar:LoggedGetSpellInfo(49358)
	local spellPortalStonard = AutoBar:LoggedGetSpellInfo(49361)
	local spellTeleportTheramore = AutoBar:LoggedGetSpellInfo(49359)
	local spellPortalTheramore = AutoBar:LoggedGetSpellInfo(49360)
	local spellTeleportUndercity = AutoBar:LoggedGetSpellInfo(3563)
	local spellPortalUndercity = AutoBar:LoggedGetSpellInfo(11418)
	local spellTeleportThunderBluff = AutoBar:LoggedGetSpellInfo(3566)
	local spellPortalThunderBluff = AutoBar:LoggedGetSpellInfo(11420)
	local spellTeleportStormwind = AutoBar:LoggedGetSpellInfo(3561)
	local spellPortalStormwind = AutoBar:LoggedGetSpellInfo(10059)
	local spellTeleportSilvermoon = AutoBar:LoggedGetSpellInfo(32272)
	local spellPortalSilvermoon = AutoBar:LoggedGetSpellInfo(32267)
	local spellTeleportExodar = AutoBar:LoggedGetSpellInfo(32271)
	local spellPortalExodar = AutoBar:LoggedGetSpellInfo(32266)
	local spellTeleportDarnassus = AutoBar:LoggedGetSpellInfo(3565)
	local spellPortalDarnassus = AutoBar:LoggedGetSpellInfo(11419)
	local spellTeleportIronforge = AutoBar:LoggedGetSpellInfo(3562)
	local spellPortalIronforge = AutoBar:LoggedGetSpellInfo(11416)
	local spellTeleportOrgrimmar = AutoBar:LoggedGetSpellInfo(3567)
	local spellPortalOrgrimmar = AutoBar:LoggedGetSpellInfo(11417)
	local spellTeleportShattrath = AutoBar:LoggedGetSpellInfo(35715)
	spellNameList["Teleport: Dalaran"] = AutoBar:LoggedGetSpellInfo(53140)
	spellNameList["Portal: Dalaran"] = AutoBar:LoggedGetSpellInfo(53142)
	ABGCS:CacheSpellData(50977, "Death Gate");
	local spellTeleportBrokenDalaran = AutoBar:LoggedGetSpellInfo(224869)
	local spellPortalBrokenDalaran = AutoBar:LoggedGetSpellInfo(224871)
	local spellTeleportHallofGuardian = AutoBar:LoggedGetSpellInfo(204287)
	
	local spellTeleportMoonglade = AutoBar:LoggedGetSpellInfo(18960)
	local spellTeleportDreamway = AutoBar:LoggedGetSpellInfo(193753)
	local spellAstralRecall = AutoBar:LoggedGetSpellInfo(556)
	local spellRitualOfSummoning = AutoBar:LoggedGetSpellInfo(698)
	local spellTeleportTolBaradH = AutoBar:LoggedGetSpellInfo(88344)
	local spellTeleportTolBaradA = AutoBar:LoggedGetSpellInfo(88342)
	local spellPortalTolBaradH = AutoBar:LoggedGetSpellInfo(88346)
	local spellPortalTolBaradA = AutoBar:LoggedGetSpellInfo(88345)
	local spellTeleportValeofEternalBlossomsA = AutoBar:LoggedGetSpellInfo(132621)
	local spellPortalValeofEternalBlossomsA = AutoBar:LoggedGetSpellInfo(132620)
	local spellTeleportValeofEternalBlossomsH = AutoBar:LoggedGetSpellInfo(132627)
	local spellPortalValeofEternalBlossomsH = AutoBar:LoggedGetSpellInfo(132626)
	local spellTeleportStormshield = AutoBar:LoggedGetSpellInfo(176248)
	local spellPortalStormshield = AutoBar:LoggedGetSpellInfo(176246)
	local spellTeleportWarspear = AutoBar:LoggedGetSpellInfo(176242)
	local spellPortalWarspear = AutoBar:LoggedGetSpellInfo(176244)
	AutoBarCategoryList["Spell.Portals"] = AutoBarSpells:new( "Spell.Portals", spellPortalShattrathIcon, nil,
	{
		"DRUID", spellTeleportMoonglade, spellTeleportMoonglade,
		"DRUID", spellTeleportDreamway, spellTeleportDreamway,
			"MAGE", spellTeleportStonard, spellPortalStonard,
			"MAGE", spellTeleportTheramore, spellPortalTheramore,
			"MAGE", spellTeleportUndercity, spellPortalUndercity,
			"MAGE", spellTeleportThunderBluff, spellPortalThunderBluff,
			"MAGE", spellTeleportStormwind, spellPortalStormwind,
			"MAGE", spellTeleportSilvermoon, spellPortalSilvermoon,
			"MAGE", spellTeleportExodar, spellPortalExodar,
			"MAGE", spellTeleportDarnassus, spellPortalDarnassus,
			"MAGE", spellTeleportIronforge, spellPortalIronforge,
			"MAGE", spellTeleportOrgrimmar, spellPortalOrgrimmar,
			"MAGE", spellTeleportShattrath, spellPortalShattrath,
			"MAGE", spellTeleportTolBaradH, spellPortalTolBaradH,
			"MAGE", spellTeleportTolBaradA, spellPortalTolBaradA,
			"MAGE", spellTeleportValeofEternalBlossomsA, spellPortalValeofEternalBlossomsA,
			"MAGE", spellTeleportValeofEternalBlossomsH, spellPortalValeofEternalBlossomsH,
			"MAGE", spellTeleportStormshield, spellPortalStormshield,
			"MAGE", spellTeleportWarspear, spellPortalWarspear,
			"MAGE", spellTeleportHallofGuardian, spellTeleportHallofGuardian,
			"MAGE", spellTeleportBrokenDalaran, spellPortalBrokenDalaran,
			"MAGE", spellNameList["Teleport: Dalaran"], spellNameList["Portal: Dalaran"],
			"MONK", AutoBar:GetSpellNameByName("Zen Pilgrimage"), nil,
			"MONK", AutoBar:GetSpellNameByName("Zen Pilgrimage: Return"), nil,
		"DEATHKNIGHT", spellNameList["Death Gate"], spellNameList["Death Gate"],	
			"SHAMAN", spellAstralRecall, spellAstralRecall,
		"WARLOCK", spellRitualOfSummoning, spellRitualOfSummoning,
			})
			
	local spellTeleportAncientDalaran = AutoBar:LoggedGetSpellInfo(120145)
	local spellPortalAncientDalaran = AutoBar:LoggedGetSpellInfo(121848)
	AutoBarCategoryList["Spell.AncientDalaranPortals"] = AutoBarSpells:new(
			"Spell.AncientDalaranPortals", spellPortalShattrathIcon, nil, {
			"MAGE", spellTeleportAncientDalaran, spellPortalAncientDalaran,
			})

	AutoBarCategoryList["Spell.Shields"] = AutoBarSpells:new( "Spell.Shields", spellIconList["Ice Barrier"], nil,
	{
		"DEMONHUNTER",	 AutoBar:GetSpellNameByName("Blur"), 	AutoBar:GetSpellNameByName("Darkness"),
		"DEATHKNIGHT", AutoBar:GetSpellNameByName("Anti-Magic Shell"), 	AutoBar:GetSpellNameByName("Icebound Fortitude"),
		"DEATHKNIGHT", AutoBar:GetSpellNameByName("Icebound Fortitude"), 	AutoBar:GetSpellNameByName("Anti-Magic Shell"),
			"DRUID", 		spellNameList["Barkskin"], 	spellNameList["Barkskin"],
		"HUNTER", 		AutoBar:GetSpellNameByName("Aspect of the Turtle"), 	AutoBar:GetSpellNameByName("Aspect of the Turtle"),
			"MAGE", 			AutoBar:GetSpellNameByName("Ice Barrier"), AutoBar:GetSpellNameByName("Ice Barrier"),
			"MAGE", 			AutoBar:GetSpellNameByName("Temporal Shield"), AutoBar:GetSpellNameByName("Temporal Shield"),
			"MAGE", 			AutoBar:GetSpellNameByName("Blazing Barrier"), AutoBar:GetSpellNameByName("Blazing Barrier"),
			"MAGE", 			AutoBar:GetSpellNameByName("Prismatic Barrier"), AutoBar:GetSpellNameByName("Prismatic Barrier"),
			"MONK", 			spellNameList["Fortifying Brew"], spellNameList["Fortifying Brew"],
		"PALADIN", 		spellNameList["Ardent Defender"], spellNameList["Ardent Defender"],
		"PALADIN", 		spellNameList["Divine Shield"], spellNameList["Divine Shield"],
			"PRIEST", 		spellNameList["Power Word: Shield"], spellNameList["Power Word: Shield"],
		"ROGUE", 		spellNameList["Evasion"], 		spellNameList["Evasion"],
		"ROGUE", 		spellNameList["Riposte"], 		spellNameList["Riposte"],
		"WARLOCK", 		spellNameList["Unending Resolve"], spellNameList["Unending Resolve"],
			"WARRIOR", 		spellNameList["Shield Block"], spellNameList["Shield Wall"],
			"WARRIOR", 		spellNameList["Shield Wall"], spellNameList["Shield Block"],
	})
end

-- Create category list using PeriodicTable data.
-- Split up to avoid Lua upValue limitations
function AutoBarCategory:Initialize2()
	AutoBarCategoryList["Spell.Stance"] = AutoBarSpells:new(
			"Spell.Stance", spellIconList["Defensive Stance"], {
			"WARRIOR", spellNameList["Defensive Stance"],
			})


			
	local spellMobileBanking, _, iconMobileBanking  = AutoBar:LoggedGetSpellInfo(83958)
	AutoBarCategoryList["Spell.Guild"] = AutoBarSpells:new(
			"Spell.Guild", iconMobileBanking, {
			"*", spellMobileBanking,
	})


	local spellAncestralProtectionTotem = AutoBar:LoggedGetSpellInfo(207399)
	local spellEarthenShieldTotem = AutoBar:LoggedGetSpellInfo(198838)
	local spellEarthquakeTotem = AutoBar:LoggedGetSpellInfo(61882)
	AutoBarCategoryList["Spell.Totem.Earth"] = AutoBarSpells:new(
			"Spell.Totem.Earth", spellIconList["Earthgrab Totem"], {
			"SHAMAN", spellNameList["Earthgrab Totem"],
			"SHAMAN", spellNameList["Earthbind Totem"],
			"SHAMAN", spellAncestralProtectionTotem,
			"SHAMAN", spellEarthenShieldTotem,
			"SHAMAN", spellEarthquakeTotem,
			})
			

	local spellLightningSurgeTotem = AutoBar:LoggedGetSpellInfo(192058)
	local spellVoodooTotem = AutoBar:LoggedGetSpellInfo(196932)
	local spellCloudburstTotem = AutoBar:LoggedGetSpellInfo(157153)
	AutoBarCategoryList["Spell.Totem.Air"] = AutoBarSpells:new(
			"Spell.Totem.Air", spellIconList["Wind Rush Totem"], {
			"SHAMAN", spellNameList["Wind Rush Totem"], 	--*
			"SHAMAN", spellLightningSurgeTotem, 			--*
			"SHAMAN", spellVoodooTotem, --*
			"SHAMAN", spellCloudburstTotem, --*
			})

	ABGCS:CacheSpellData(192222, "Liquid Magma Totem"); --*
	AutoBarCategoryList["Spell.Totem.Fire"] = AutoBarSpells:new(
			"Spell.Totem.Fire", spellIconList["Liquid Magma Totem"], {
			"SHAMAN", spellNameList["Liquid Magma Totem"], --*
			})

	local spellHealingStreamTotem, _,  spellHealingStreamTotemIcon = AutoBar:LoggedGetSpellInfo(5394)
	local spellHealingTideTotem = AutoBar:LoggedGetSpellInfo(108280)
	local spellSpiritLinkTotem = AutoBar:LoggedGetSpellInfo(98008)
	AutoBarCategoryList["Spell.Totem.Water"] = AutoBarSpells:new(
			"Spell.Totem.Water", spellHealingStreamTotemIcon, {
			"SHAMAN", spellHealingStreamTotem, --*
			"SHAMAN", spellHealingTideTotem,   --*
			"SHAMAN", spellSpiritLinkTotem, --*
			})


	AutoBarCategoryList["Spell.Buff.Weapon"] = AutoBarSpells:new(
			"Spell.Buff.Weapon", spellIconList["Deadly Poison"], {
			"ROGUE", spellNameList["Deadly Poison"],
			"ROGUE", spellNameList["Wound Poison"],
			"ROGUE", spellNameList["Crippling Poison"],
			"ROGUE", spellNameList["Leeching Poison"],
			})

	local craftList = {
		"*", spellNameList["Alchemy"],
		"*", spellNameList["Archaeology"],
		"*", spellNameList["BasicCampfire"],
		"*", spellNameList["Blacksmithing"],
		"*", spellNameList["Cooking"],
		"*", spellNameList["Disenchant"],
		"*", spellNameList["Enchanting"],
		"*", spellNameList["Engineering"],
		"*", spellNameList["First Aid"],
		"*", spellNameList["Inscription"],
		"*", spellNameList["Jewelcrafting"],
		"*", spellNameList["Leatherworking"],
		"*", spellNameList["Milling"],
		"*", spellNameList["Prospecting"],
		"*", spellNameList["Smelting"],
		"*", spellNameList["Survey"],
		"*", spellNameList["Tailoring"],
		"DEATHKNIGHT", spellNameList["Runeforging"],
	}
	if (GetLocale() == "deDE") then
		tinsert(craftList, "*")
		tinsert(craftList, spellNameList["Alchemie"])
		tinsert(craftList, "*")
		tinsert(craftList, spellNameList["Kochen"])
	end

	AutoBarCategoryList["Spell.Crafting"] = AutoBarSpells:new( "Spell.Crafting", spellIconList["First Aid"], craftList)
			
	AutoBarCategoryList["Spell.Archaeology"] = AutoBarSpells:new("Spell.Archaeology", spellIconList["Archaeology"],
	{
		"*",	AutoBar:GetSpellNameByName("Archaeology"),
		"*",	AutoBar:GetSpellNameByName("Survey"),
	})


	AutoBarCategoryList["Spell.Debuff.Multiple"] = AutoBarSpells:new("Spell.Debuff.Multiple", spellIconList["Slow"],
	{
		"DRUID",		AutoBar:GetSpellNameByName("Disorienting Roar"),
		"HUNTER",	AutoBar:GetSpellNameByName("Binding Shot"),
		"HUNTER",	AutoBar:GetSpellNameByName("Sentinel"),
	})

	ABGCS:CacheSpellData(15487, "Silence");
	ABGCS:CacheSpellData(2094, "Blind");
	ABGCS:CacheSpellData(6770, "Sap");
	AutoBarCategoryList["Spell.Debuff.Single"] = AutoBarSpells:new("Spell.Debuff.Single", spellIconList["Slow"],
	{
		"DEATHKNIGHT", AutoBar:GetSpellNameByName("Chains of Ice"),
		"HUNTER", AutoBar:GetSpellNameByName("Concussive Shot"),
		"HUNTER", AutoBar:GetSpellNameByName("Wing Clip"),
		"HUNTER", AutoBar:GetSpellNameByName("Ranger's Net"),
		"PALADIN", AutoBar:GetSpellNameByName("Hand of Hindrance"),
		"WARLOCK", AutoBar:GetSpellNameByName("Curse of Tongues"),
		"WARLOCK", AutoBar:GetSpellNameByName("Curse of Weakness"),
		"WARLOCK", AutoBar:GetSpellNameByName("Curse of Fragility"),
	})

	ABGCS:CacheSpellData(131474, "Fishing");
	ABGCS:CacheSpellData(201891, "Undercurrent");
	AutoBarCategoryList["Spell.Fishing"] = AutoBarSpells:new("Spell.Fishing", spellIconList["Fishing"],
	{
		"*", AutoBar:GetSpellNameByName("Fishing"),
		"*", AutoBar:GetSpellNameByName("Undercurrent"),
	})



	AutoBarCategoryList["Spell.Trap"] = AutoBarSpells:new( "Spell.Trap", spellIconList["Explosive Trap"],
	{
		"DEMONHUNTER", AutoBar:GetSpellNameByName("Sigil of Flame"),
		"DEMONHUNTER", AutoBar:GetSpellNameByName("Sigil of Misery"),
		"DEMONHUNTER", AutoBar:GetSpellNameByName("Sigil of Silence"),
		"HUNTER", AutoBar:GetSpellNameByName("Explosive Trap"),
		"HUNTER", AutoBar:GetSpellNameByName("Freezing Trap"),
		"HUNTER", AutoBar:GetSpellNameByName("Caltrops"),
		"HUNTER", AutoBar:GetSpellNameByName("Tar Trap"),
		"HUNTER", AutoBar:GetSpellNameByName("Steel Trap"),
	})

	ABGCS:CacheSpellData(2645, "GhostWolf");
	ABGCS:CacheSpellData(87840, "Running Wild");
	
	AutoBarCategoryList["Misc.Mount.Summoned"] = AutoBarSpells:new(
			"Misc.Mount.Summoned", spellIconList["Summon Dreadsteed"], {
			"DRUID", spellNameList["Flight Form"],
			"DRUID", spellNameList["Swift Flight Form"],
			"SHAMAN", spellNameList["GhostWolf"],
			"*",spellNameList["Running Wild"],
			})
	AutoBarCategoryList["Misc.Mount.Summoned"]:SetNonCombat(true)
	
	AutoBarCategoryList["Muffin.Mount"] = AutoBarSpells:new("Muffin.Mount", spellIconList["Summon Dreadsteed"], nil, nil, "Muffin.Mount." .. AutoBar.NiceClass)
	AutoBarCategoryList["Muffin.Mount"]:SetNonCombat(true)

	AutoBarCategoryList["Spell.Charge"] = AutoBarSpells:new( "Spell.Charge", spellIconList["Charge"],
	{
		"DEMONHUNTER", AutoBar:GetSpellNameByName("Fel Rush"),
		"DRUID", AutoBar:GetSpellNameByName("Wild Charge"),
		"HUNTER", AutoBar:GetSpellNameByName("Harpoon"),
		"ROGUE", AutoBar:GetSpellNameByName("Shadowstep"),
		"WARRIOR", AutoBar:GetSpellNameByName("Charge"),
		"WARRIOR", AutoBar:GetSpellNameByName("Intercept"),
	})

	AutoBarCategoryList["Spell.ER"] = AutoBarSpells:new( "Spell.ER", spellIconList["Charge"],
	{
		"DEMONHUNTER", AutoBar:GetSpellNameByName("Vengeful Retreat"),
		"DEATHKNIGHT", AutoBar:GetSpellNameByName("Rune Tap"),
		"DRUID", AutoBar:GetSpellNameByName("Frenzied Regeneration"),
		"HUNTER", AutoBar:GetSpellNameByName("Feign Death"),
		"HUNTER", AutoBar:GetSpellNameByName("Disengage"),
		"MAGE", AutoBar:GetSpellNameByName("Ice Block"),
		"PALADIN", AutoBar:GetSpellNameByName("Lay on Hands"),
		"PRIEST", AutoBar:GetSpellNameByName("Dispersion"),
		"PRIEST", AutoBar:GetSpellNameByName("Guardian Spirit"),
		"PRIEST", AutoBar:GetSpellNameByName("Pain Suppression"),
		"ROGUE", AutoBar:GetSpellNameByName("Vanish"),
		"WARLOCK", AutoBar:GetSpellNameByName("Dark Pact"),
		"WARRIOR", AutoBar:GetSpellNameByName("Last Stand"),
		"WARRIOR", AutoBar:GetSpellNameByName("Enraged Regeneration"),
	})

	AutoBarCategoryList["Spell.Interrupt"] = AutoBarSpells:new( "Spell.Interrupt", spellIconList["Charge"],
	{
		"DEATHKNIGHT", AutoBar:GetSpellNameByName("Mind Freeze"),
		"DEMONHUNTER", AutoBar:GetSpellNameByName("Consume Magic"),
		"HUNTER", AutoBar:GetSpellNameByName("Counter Shot"),
		"PALADIN", AutoBar:GetSpellNameByName("Rebuke"),
		"ROGUE", AutoBar:GetSpellNameByName("Kick"),
		"WARLOCK", AutoBar:GetSpellNameByName("Grimoire: Felhunter"),
	})

	AutoBarCategoryList["Spell.CatForm"] = AutoBarSpells:new( "Spell.CatForm", spellIconList["Charge"],
	{
		"DRUID", AutoBar:GetSpellNameByName("Cat Form"),
	})

	AutoBarCategoryList["Spell.BearForm"] = AutoBarSpells:new( "Spell.BearForm", spellIconList["Charge"],
	{
		"DRUID", AutoBar:GetSpellNameByName("Bear Form"),
	})

	AutoBarCategoryList["Spell.MoonkinForm"] = AutoBarSpells:new( "Spell.MoonkinForm", spellIconList["Charge"],
	{
		"DRUID", AutoBar:GetSpellNameByName("Moonkin Form"),
	})

	AutoBarCategoryList["Spell.TreeForm"] = AutoBarSpells:new( "Spell.TreeForm", spellIconList["Charge"],
	{
		"DRUID", AutoBar:GetSpellNameByName("Treant Form"),
	})

	AutoBarCategoryList["Spell.StagForm"] = AutoBarSpells:new( "Spell.StagForm", spellIconList["Charge"],
	{
		"DRUID", AutoBar:GetSpellNameByName("Stag Form"),
	})

	AutoBarCategoryList["Spell.Travel"] = AutoBarSpells:new( "Spell.Travel", spellIconList["Charge"],
	{
		"DRUID", AutoBar:GetSpellNameByName("Travel Form"),
		"SHAMAN", AutoBar:GetSpellNameByName("Ghost Wolf"),
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


