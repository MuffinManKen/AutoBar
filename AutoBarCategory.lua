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

local spellNameList = AutoBar.spellNameList
local spellIconList = AutoBar.spellIconList


AutoBarCategoryList = {}

local L = AutoBar.locale
local PT = LibStub("LibPeriodicTable-3.1")
local AceOO = AceLibrary("AceOO-2.0")
local _

-- List of categoryKey, category.description pairs for button categories
AutoBar.categoryValidateList = {}

	--All
	spellNameList["Revive Battle Pets"] = AutoBar:LoggedGetSpellInfo(125439)

	--DeathKnight
	spellNameList["Path of Frost"] = AutoBar:LoggedGetSpellInfo(3714)
	spellNameList["Dark Transformation"] = AutoBar:LoggedGetSpellInfo(63560)
	spellNameList["Chains of Ice"] = AutoBar:LoggedGetSpellInfo(45524)
	spellNameList["Anti-Magic Shell"] = AutoBar:LoggedGetSpellInfo(48707)
	spellNameList["Icebound Fortitude"] = AutoBar:LoggedGetSpellInfo(48792)
	spellNameList["Mind Freeze"] = AutoBar:LoggedGetSpellInfo(47528)

	--DemonHunter
	spellNameList["Fel Rush"] = AutoBar:LoggedGetSpellInfo(195072)
	spellNameList["Vengeful Retreat"] = AutoBar:LoggedGetSpellInfo(198793)
	spellNameList["Blur"] = AutoBar:LoggedGetSpellInfo(198589)
	spellNameList["Darkness"] = AutoBar:LoggedGetSpellInfo(196718)
	spellNameList["Sigil of Flame"] = AutoBar:LoggedGetSpellInfo(204596)
	spellNameList["Sigil of Misery"] = AutoBar:LoggedGetSpellInfo(207684)
	spellNameList["Sigil of Silence"] = AutoBar:LoggedGetSpellInfo(202137)
	spellNameList["Consume Magic"] = AutoBar:LoggedGetSpellInfo(183752)


	--Druid
	spellNameList["Barkskin"], _, spellIconList["Barkskin"] = AutoBar:LoggedGetSpellInfo(22812)
	spellNameList["Disorienting Roar"] = AutoBar:LoggedGetSpellInfo(99)
	spellNameList["Ironbark"] = AutoBar:LoggedGetSpellInfo(102342)
	spellNameList["Prowl"] = AutoBar:LoggedGetSpellInfo(5215)
	spellNameList["Frenzied Regeneration"], _, spellIconList["Frenzied Regeneration"] = AutoBar:LoggedGetSpellInfo(22842)
	spellNameList["Wild Charge"], _, spellIconList["Wild Charge"] = AutoBar:LoggedGetSpellInfo(102401)
	spellNameList["Bear Form"], _, spellIconList["Bear Form"] = AutoBar:LoggedGetSpellInfo(5487)
	spellNameList["Mangle"], _, spellIconList["Mangle"] = AutoBar:LoggedGetSpellInfo(33917)
	spellNameList["Cat Form"], _, spellIconList["Cat Form"] = AutoBar:LoggedGetSpellInfo(768)

	--Hunter
	spellNameList["Aspect of the Chameleon"]= AutoBar:LoggedGetSpellInfo(61648)
	spellNameList["Aspect of the Cheetah"], _, spellIconList["Aspect of the Cheetah"] = AutoBar:LoggedGetSpellInfo(186257)
	spellNameList["Aspect of the Eagle"]= AutoBar:LoggedGetSpellInfo(186289)
	spellNameList["Aspect of the Turtle"]= AutoBar:LoggedGetSpellInfo(186265)
	spellNameList["Aspect of the Wild"]= AutoBar:LoggedGetSpellInfo(193530)
	spellNameList["Beast Lore"] = AutoBar:LoggedGetSpellInfo(1462)
	spellNameList["Bestial Wrath"] = AutoBar:LoggedGetSpellInfo(19574)
	spellNameList["Binding Shot"] = AutoBar:LoggedGetSpellInfo(109248)
	spellNameList["Call Pet 1"], _, spellCallPet1Icon = AutoBar:LoggedGetSpellInfo(883)
	spellNameList["Call Pet 2"] = AutoBar:LoggedGetSpellInfo(83242)
	spellNameList["Call Pet 3"] = AutoBar:LoggedGetSpellInfo(83243)
	spellNameList["Call Pet 4"] = AutoBar:LoggedGetSpellInfo(83244)
	spellNameList["Call Pet 5"] = AutoBar:LoggedGetSpellInfo(83245)
	spellNameList["Camouflage"] = AutoBar:LoggedGetSpellInfo(199483)
	spellNameList["Concussive Shot"] = AutoBar:LoggedGetSpellInfo(5116)
	spellNameList["Counter Shot"] = AutoBar:LoggedGetSpellInfo(147362)
	spellNameList["Dire Beast"] = AutoBar:LoggedGetSpellInfo(120679)
	spellNameList["Dire Frenzy"] = AutoBar:LoggedGetSpellInfo(217200)
	spellNameList["Disengage"], _, spellIconList["Disengage"] = AutoBar:LoggedGetSpellInfo(781)
	spellNameList["Dismiss Pet"] = AutoBar:LoggedGetSpellInfo(2641)
	spellNameList["Eagle Eye"] = AutoBar:LoggedGetSpellInfo(6197)
	spellNameList["Feed Pet"], _, spellIconList["Feed Pet"] = AutoBar:LoggedGetSpellInfo(6991)
	spellNameList["Feign Death"], _, spellIconList["Feign Death"] = AutoBar:LoggedGetSpellInfo(5384)
	spellNameList["Fetch"] = AutoBar:LoggedGetSpellInfo(125050)
	spellNameList["Harpoon"], _, spellIconList["Harpoon"]  = AutoBar:LoggedGetSpellInfo(190925)
	spellNameList["Intimidation"] = AutoBar:LoggedGetSpellInfo(7093)
	spellNameList["Kill Command"] = AutoBar:LoggedGetSpellInfo(34026)
	spellNameList["Master's Call"] = AutoBar:LoggedGetSpellInfo(53271)
	spellNameList["Mend Pet"] = AutoBar:LoggedGetSpellInfo(136)
	spellNameList["Play Dead"] = AutoBar:LoggedGetSpellInfo(209997)
	spellNameList["Ranger's Net"] = AutoBar:LoggedGetSpellInfo(200108)
	spellNameList["Revive Pet"] = AutoBar:LoggedGetSpellInfo(982)
	spellNameList["Sentinel"] = AutoBar:LoggedGetSpellInfo(206817)
	spellNameList["Tame Beast"] = AutoBar:LoggedGetSpellInfo(1515)
	spellNameList["Wake Up"] = AutoBar:LoggedGetSpellInfo(210000)
	spellNameList["Wing Clip"] = AutoBar:LoggedGetSpellInfo(195645)



	--Mage
	spellNameList["Ice Barrier"], _, spellIconList["Ice Barrier"] = AutoBar:LoggedGetSpellInfo(11426)
	spellNameList["Prismatic Barrier"] = AutoBar:LoggedGetSpellInfo(235450)
	spellNameList["Blazing Barrier"] = AutoBar:LoggedGetSpellInfo(235313)
	spellNameList["Temporal Shield"] = AutoBar:LoggedGetSpellInfo(198111)
	spellNameList["Slow Fall"] = AutoBar:LoggedGetSpellInfo(130)
	spellNameList["Conjure Refreshment"], _, spellIconList["Conjure Refreshment"] = AutoBar:LoggedGetSpellInfo(42955)
	spellNameList["Conjure Refreshment Table"] = AutoBar:LoggedGetSpellInfo(43987)
	spellNameList["Invisibility"], _, spellIconList["Invisibility"] = AutoBar:LoggedGetSpellInfo(66)
	spellNameList["Greater Invisibility"], _, spellIconList["Greater Invisibility"] = AutoBar:LoggedGetSpellInfo(110959)
	spellNameList["Ice Block"], _, spellIconList["Ice Block"] = AutoBar:LoggedGetSpellInfo(27619)

	--Monk
	spellNameList["Zen Pilgrimage"] = AutoBar:LoggedGetSpellInfo(126892)
	spellNameList["Zen Pilgrimage: Return"] = AutoBar:LoggedGetSpellInfo(126895)
	spellNameList["Fortifying Brew"] = AutoBar:LoggedGetSpellInfo(115203)
	
	--Paladin
	spellNameList["Ardent Defender"] = AutoBar:LoggedGetSpellInfo(31850) 
	spellNameList["Divine Shield"] = AutoBar:LoggedGetSpellInfo(642) 
	spellNameList["Blessing of Freedom"] = AutoBar:LoggedGetSpellInfo(1044) 
	spellNameList["Blessing of Protection"] = AutoBar:LoggedGetSpellInfo(1022) 
	spellNameList["Blessing of Sacrifice"] = AutoBar:LoggedGetSpellInfo(6940) 
	spellNameList["Blessing of Spellwarding"] = AutoBar:LoggedGetSpellInfo(204018) 
	spellNameList["Blessing of Salvation"] = AutoBar:LoggedGetSpellInfo(204013) 
	spellNameList["Greater Blessing of Kings"] = AutoBar:LoggedGetSpellInfo(203538) 
	spellNameList["Greater Blessing of Wisdom"] = AutoBar:LoggedGetSpellInfo(203539) 
	spellNameList["Hand of Hindrance"] = AutoBar:LoggedGetSpellInfo(183218)
	spellNameList["Rebuke"] = AutoBar:LoggedGetSpellInfo(96231)

	--Priest
	spellNameList["Power Word: Shield"] = AutoBar:LoggedGetSpellInfo(17)
	spellNameList["Shadowfiend"] = AutoBar:LoggedGetSpellInfo(34433)
	spellNameList["Dispersion"] = AutoBar:LoggedGetSpellInfo(47585)
	spellNameList["Guardian Spirit"] = AutoBar:LoggedGetSpellInfo(47788)
	spellNameList["Pain Suppression"] = AutoBar:LoggedGetSpellInfo(33206)

	--Rogue
	spellNameList["Agonizing Poison"] = AutoBar:LoggedGetSpellInfo(200802)
	spellNameList["Crippling Poison"], _, spellIconList["Crippling Poison"]  = AutoBar:LoggedGetSpellInfo(3408)
	spellNameList["Deadly Poison"], _, spellIconList["Deadly Poison"] = AutoBar:LoggedGetSpellInfo(2823)
	spellNameList["Evasion"] = AutoBar:LoggedGetSpellInfo(4086)
	spellNameList["Kick"] = AutoBar:LoggedGetSpellInfo(1766)
	spellNameList["Leeching Poison"] = AutoBar:LoggedGetSpellInfo(108211)
	spellNameList["Riposte"] = AutoBar:LoggedGetSpellInfo(199754)
	spellNameList["Shadowstep"], _, spellIconList["Shadowstep"] = AutoBar:LoggedGetSpellInfo(36554)
	spellNameList["Stealth"], _, spellIconList["Stealth"] = AutoBar:LoggedGetSpellInfo(1784)
	spellNameList["Vanish"], _, spellIconList["Vanish"] = AutoBar:LoggedGetSpellInfo(1856)
	spellNameList["Wound Poison"] = AutoBar:LoggedGetSpellInfo(8679)

	--Shaman
	spellNameList["Earthbind Totem"] = AutoBar:LoggedGetSpellInfo(2484)
	spellNameList["Earthgrab Totem"], _, spellIconList["Earthgrab Totem"] = AutoBar:LoggedGetSpellInfo(51485)
	spellNameList["Feral Spirit"] = AutoBar:LoggedGetSpellInfo(51533)
	spellNameList["Water Walking"] = AutoBar:LoggedGetSpellInfo(546)
	spellNameList["Wind Rush Totem"], _, spellIconList["Wind Rush Totem"] = AutoBar:LoggedGetSpellInfo(192077)


	--Warlock
	spellNameList["Call Dreadstalkers"] = AutoBar:LoggedGetSpellInfo(104316) 
	spellNameList["Command Demon"] = AutoBar:LoggedGetSpellInfo(119898) 
	spellNameList["Curse of Fragility"] = AutoBar:LoggedGetSpellInfo(199954) 
	spellNameList["Curse of Tongues"] = AutoBar:LoggedGetSpellInfo(199890) 
	spellNameList["Curse of Weakness"] = AutoBar:LoggedGetSpellInfo(199892) 
	spellNameList["Dark Pact"], _, spellIconList["Dark Pact"]  = AutoBar:LoggedGetSpellInfo(108416)
	spellNameList["Demonic Empowerment"] = AutoBar:LoggedGetSpellInfo(193396) 
	spellNameList["Demonwrath"] = AutoBar:LoggedGetSpellInfo(193440) 
	spellNameList["Grimoire of Sacrifice"] = AutoBar:LoggedGetSpellInfo(108503) 
	spellNameList["Grimoire: Felhunter"] = AutoBar:LoggedGetSpellInfo(111897) 
	spellNameList["Soulstone"] = AutoBar:LoggedGetSpellInfo(20707) 
	spellNameList["Summon Darkglare"] = AutoBar:LoggedGetSpellInfo(205180) 
	spellNameList["Unending Breath"] = AutoBar:LoggedGetSpellInfo(5697)
	spellNameList["Unending Resolve"] = AutoBar:LoggedGetSpellInfo(104773)


	--Warrior
	spellNameList["Shield Block"] = AutoBar:LoggedGetSpellInfo(2565) 
	spellNameList["Shield Wall"] = AutoBar:LoggedGetSpellInfo(871) 
	spellNameList["Demoralizing Shout"] = AutoBar:LoggedGetSpellInfo(1160)
	spellNameList["Commanding Shout"] = AutoBar:LoggedGetSpellInfo(97462)
	spellNameList["Defensive Stance"] = AutoBar:LoggedGetSpellInfo(197690)
	spellNameList["Charge"], _, spellIconList["Charge"] = AutoBar:LoggedGetSpellInfo(100)
	spellNameList["Intercept"], _, spellIconList["Intercept"] = AutoBar:LoggedGetSpellInfo(198304)

	--Other
	spellNameList["Shadowmeld"], _, spellIconList["Shadowmeld"] = AutoBar:LoggedGetSpellInfo(58984)

	--Skills
	spellNameList["First Aid"], _, spellIconList["First Aid"] = AutoBar:LoggedGetSpellInfo(27028)
	spellNameList["Alchemy"] = AutoBar:LoggedGetSpellInfo(28596)
	spellNameList["BasicCampfire"] = AutoBar:LoggedGetSpellInfo(818)
	spellNameList["Blacksmithing"] = AutoBar:LoggedGetSpellInfo(29844)
	spellNameList["Cooking"] = AutoBar:LoggedGetSpellInfo(33359)
	if (GetLocale() == "deDE") then
		spellNameList["Kochen"] = AutoBar:LoggedGetSpellInfo(51296)
		spellNameList["Alchemie"] = AutoBar:LoggedGetSpellInfo(51304)
	end
	spellNameList["Archaeology"], _, spellIconList["Archaeology"] = AutoBar:LoggedGetSpellInfo(78670)
	spellNameList["Disenchant"] = AutoBar:LoggedGetSpellInfo(13262)
	spellNameList["Enchanting"] = AutoBar:LoggedGetSpellInfo(28029)
	spellNameList["Engineering"] = AutoBar:LoggedGetSpellInfo(30350)
	spellNameList["Inscription"] = AutoBar:LoggedGetSpellInfo(45357)
	spellNameList["Jewelcrafting"] = AutoBar:LoggedGetSpellInfo(28897)
	spellNameList["Leatherworking"] = AutoBar:LoggedGetSpellInfo(32549)
	spellNameList["Milling"] = AutoBar:LoggedGetSpellInfo(51005)
	spellNameList["Prospecting"] = AutoBar:LoggedGetSpellInfo(31252)
	spellNameList["Runeforging"] = AutoBar:LoggedGetSpellInfo(53428)
	spellNameList["Smelting"] = AutoBar:LoggedGetSpellInfo(2656)
	spellNameList["Survey"] = AutoBar:LoggedGetSpellInfo(80451)
	spellNameList["Tailoring"] = AutoBar:LoggedGetSpellInfo(26790)



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




local spellFeedPet = AutoBar:LoggedGetSpellInfo(6991)

-- Category consisting of regular items
AutoBarPetFood = AceOO.Class(AutoBarItems)

-- ptItems, ptPriorityItems are PeriodicTable sets
-- priorityItems sort higher than items at the same value
function AutoBarPetFood.prototype:init(description, shortTexture, ptItems, ptPriorityItems)
	AutoBarPetFood.super.prototype.init(self, description, "Interface\\Icons\\" .. shortTexture, ptItems, ptPriorityItems)

	self.castSpell = spellFeedPet
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

	for _, toy_id in ipairs(self.all_items) do
		if (toy_id and PlayerHasToy(toy_id) and C_ToyBox.IsToyUsable(toy_id)) then
			AutoBarSearch:RegisterToy(toy_id)
			self.items[list_index] = ABGCS:ToyGUID(toy_id)
			list_index = list_index + 1
		end
	end

	--trim any missing ones of the end. You never forget Toys, so is this needed?
	for i = list_index, # self.items, 1 do
		self.items[i] = nil
	end
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
		_,_,_,_,_,_,_,_,_, texture = GetItemInfo(tonumber(itemId))
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



	local spellCreateHealthstone, spellCreateHealthstoneIcon, spellRitualOfSouls
	spellCreateHealthstone, _, spellCreateHealthstoneIcon = AutoBar:LoggedGetSpellInfo(6201)
	spellRitualOfSouls = AutoBar:LoggedGetSpellInfo(29893)
	AutoBarCategoryList["Spell.Warlock.Create Healthstone"] = AutoBarSpells:new( "Spell.Warlock.Create Healthstone", spellCreateHealthstoneIcon, nil,
	{
		"WARLOCK", spellCreateHealthstone, spellRitualOfSouls,
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

	

	--Shaman
	local spellEarthElemental = AutoBar:LoggedGetSpellInfo(198103)
	local spellFireElemental = AutoBar:LoggedGetSpellInfo(198067)
	local spellStormElemental = AutoBar:LoggedGetSpellInfo(192249)

	--Mage
	local spellSummonWaterElemental = AutoBar:LoggedGetSpellInfo(31687)

	--Monk
	local spellStormEarthFire = AutoBar:LoggedGetSpellInfo(137639)

	--Warlock
	local spellEyeOfKilrogg = AutoBar:LoggedGetSpellInfo(126)
	local spellSummonFelguard = AutoBar:LoggedGetSpellInfo(30146)
	local spellSummonFelhunter = AutoBar:LoggedGetSpellInfo(691)
	local spellSummonImp = AutoBar:LoggedGetSpellInfo(688)
	local spellSummonSuccubus = AutoBar:LoggedGetSpellInfo(712)
	local spellSummonVoidwalker = AutoBar:LoggedGetSpellInfo(697)
	local spellSummonInfernal = AutoBar:LoggedGetSpellInfo(1122)
	local spellSummonDoomguard = AutoBar:LoggedGetSpellInfo(18540)
	
	--DeathKnight
	local spellRuneWeapon = AutoBar:LoggedGetSpellInfo(49028)
	local spellRaiseDead = AutoBar:LoggedGetSpellInfo(46584)
	local spellSummonGargoyle = AutoBar:LoggedGetSpellInfo(49206)
	local spellArmyoftheDead =  AutoBar:LoggedGetSpellInfo(42650)

	AutoBarCategoryList["Spell.Class.Pet"] = AutoBarSpells:new( "Spell.Class.Pet", spellCallPet1Icon,
	{
			"DEATHKNIGHT", spellArmyoftheDead,
			"DEATHKNIGHT", spellRuneWeapon,
			"DEATHKNIGHT", spellRaiseDead,
			"DEATHKNIGHT", spellSummonGargoyle,			
		"HUNTER", AutoBar:GetSpellNameByName("Call Pet 1"), 
		"HUNTER", AutoBar:GetSpellNameByName("Call Pet 2"), 
		"HUNTER", AutoBar:GetSpellNameByName("Call Pet 3"), 
		"HUNTER", AutoBar:GetSpellNameByName("Call Pet 4"), 
		"HUNTER", AutoBar:GetSpellNameByName("Call Pet 5"), 
			"MAGE", spellSummonWaterElemental,
			"MONK", spellStormEarthFire,
		"PRIEST", AutoBar:GetSpellNameByName("Shadowfiend"), 
			"SHAMAN", spellEarthElemental,
			"SHAMAN", spellFireElemental,
			"SHAMAN", spellStormElemental,
			"SHAMAN", spellNameList["Feral Spirit"],
		"WARLOCK", spellSummonDoomguard,
		"WARLOCK", spellEyeOfKilrogg,
		"WARLOCK", spellSummonInfernal,
		"WARLOCK", spellSummonFelguard,
		"WARLOCK", spellSummonFelhunter,
		"WARLOCK", spellSummonImp,
		"WARLOCK", spellSummonSuccubus,
		"WARLOCK", spellSummonVoidwalker,
	})

	AutoBarCategoryList["Spell.Class.Pets2"] = AutoBarSpells:new( "Spell.Class.Pets2", spellCallPet1Icon, 
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
	spellNameList["Death Gate"] = AutoBar:LoggedGetSpellInfo(50977)
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

	spellNameList["Liquid Magma Totem"], _, spellIconList["Liquid Magma Totem"] = AutoBar:LoggedGetSpellInfo(192222) --*
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

	spellNameList["Silence"] = AutoBar:LoggedGetSpellInfo(15487)
	spellNameList["Blind"] = AutoBar:LoggedGetSpellInfo(2094)
	spellNameList["Sap"] = AutoBar:LoggedGetSpellInfo(6770)
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

	spellNameList["Fishing"], _, spellIconList["Fishing"] = AutoBar:LoggedGetSpellInfo(131474)
	spellNameList["Undercurrent"] = AutoBar:LoggedGetSpellInfo(201891)
	AutoBarCategoryList["Spell.Fishing"] = AutoBarSpells:new("Spell.Fishing", spellIconList["Fishing"],
	{
		"*", AutoBar:GetSpellNameByName("Fishing"),
		"*", AutoBar:GetSpellNameByName("Undercurrent"),
	})


	spellNameList["Freezing Trap"] = AutoBar:LoggedGetSpellInfo(187650)
	spellNameList["Explosive Trap"], _, spellIconList["Explosive Trap"] = AutoBar:LoggedGetSpellInfo(191433)
	spellNameList["Tar Trap"] = AutoBar:LoggedGetSpellInfo(187698)
	spellNameList["Caltrops"] = AutoBar:LoggedGetSpellInfo(194277)
	spellNameList["Steel Trap"] = AutoBar:LoggedGetSpellInfo(162488)

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

	spellNameList["Flight Form"] = AutoBar:LoggedGetSpellInfo(33943)
	spellNameList["Swift Flight Form"] = AutoBar:LoggedGetSpellInfo(40120)
	spellNameList["Travel Form"], _, spellIconList["Travel Form"] = AutoBar:LoggedGetSpellInfo(783)
	spellNameList["GhostWolf"] = AutoBar:LoggedGetSpellInfo(2645)
	spellNameList["Running Wild"] = AutoBar:LoggedGetSpellInfo(87840)
	
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


