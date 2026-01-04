local _ADDON_NAME, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

local types = AB.types	---@class ABTypes
local code = AB.code	---@class ABCode

local AutoBar = AutoBar
local ABGData = AutoBarGlobalDataObject
local spellIconList = ABGData.spell_icon_list
local L = AutoBarGlobalDataObject.locale
local ItemsCategory = AB.ItemsCategory
local MacroTextCategory = AB.MacroTextCategory
local SpellsCategory = AB.SpellsCategory

--#region ToyCategory
AB.ToyCategory = CreateFromMixins(AB.CategoryClass)
local ToyCategory = AB.ToyCategory

function ToyCategory:new(p_description, p_short_texture, p_pt_name)
	assert(type(p_description) == "string")
	assert(type(p_short_texture) == "string")

	local obj = CreateFromMixins(self)
	obj:init(p_description, "Interface\\Icons\\" .. p_short_texture)

	obj.is_toy = true
	obj.only_favourites = false
	obj.all_items = {} --All items in the category
	obj.items = {}

	if(p_pt_name) then
		local raw_list = code.AddPTSetToRawList({}, p_pt_name, false)
		obj.all_items = code.RawListToItemIDList(raw_list)
	end

	obj:Refresh()

	return obj
end

-- Reset the item list in case the player learned new toys
function ToyCategory:Refresh()
	wipe(self.items)

  -- OPTIONAL (debug-only) validator to catch bad PT entries:
  -- for i, id in ipairs(self.all_items) do
  --   if type(id) ~= "number" then code.log_warning("Toy PT entry not itemID:", tostring(id)) end
  -- end

  	local only_faves = self.only_favourites == true

	local debug = false --(self.categoryKey == "Muffin.Toys.Hearth")
	if(debug) then code.log_warning("Refreshing Toy Category", self.categoryKey, "Items:", #self.items, "All:", #self.all_items, "OnlyFaves:", only_faves); end

	local DEBUG_IDS = code.make_set{182773, 172179, 141605}
	local list_index = 1

	for _, toy_id in ipairs(self.all_items) do
        local has_toy = AB.PlayerHasToy(toy_id)
		local selected = (not only_faves or AutoBarSearch:IsToyFavourite(toy_id))
		if(debug and DEBUG_IDS[toy_id]) then code.log_warning(toy_id, "HasToy:", has_toy, "Selectied:", selected); end

		if (toy_id and has_toy and selected) then
			local toy_info = AutoBarSearch:RegisterToy(toy_id)
			self.items[list_index] = toy_info.guid
			list_index = list_index + 1
		end
	end

	if AutoBarSearch.items then
		AutoBarSearch.items:RePopulateByCategory(self.categoryKey)
	end

	if(debug) then code.log_warning("After Refreshing Toy Category", self.categoryKey, "Items:", #self.items, "All:", #self.all_items, "OnlyFaves:", only_faves, "|n"); end

end

--#endregion ToyCategory

function AB.InitializeCategories()

	AutoBarCategoryList["Dynamic.Quest"] = ItemsCategory:new("Dynamic.Quest", "INV_Misc_Rune_01", nil)
	AutoBarCategoryList["Spell.Mount"] = SpellsCategory:new("Spell.Mount", "ability_druid_challangingroar", nil)

	AutoBarCategoryList["Muffin.Toys.Hearth"] = ToyCategory:new( "Muffin.Toys.Hearth", "ability_siege_engineer_pattern_recognition", "Muffin.Toys.Hearth")
	AutoBarCategoryList["Muffin.Toys.Pet Battle"] = ToyCategory:new( "Muffin.Toys.Pet Battle", "ability_siege_engineer_pattern_recognition", "Muffin.Toys.Pet Battle")
	AutoBarCategoryList["Muffin.Toys.Companion Pet.Ornamental"] = ToyCategory:new( "Muffin.Toys.Companion Pet.Ornamental", "ability_siege_engineer_pattern_recognition", "Muffin.Toys.Companion Pet.Ornamental")
	AutoBarCategoryList["Muffin.Toys.Portal"] = ToyCategory:new( "Muffin.Toys.Portal", "ability_siege_engineer_pattern_recognition", "Muffin.Toys.Portal")
	AutoBarCategoryList["Muffin.Toys.Fishing"] = ToyCategory:new( "Muffin.Toys.Fishing", "INV_Fishingpole_01", "Muffin.Toys.Fishing")

	AutoBarCategoryList["Macro.Mount.SummonRandomFave"] = MacroTextCategory:new( "Macro.Mount.SummonRandomFave", "achievement_guildperk_mountup")
	AutoBarCategoryList["Macro.Mount.SummonRandomFave"]:AddMacroText("/run C_MountJournal.SummonByID(0)",  "Interface/Icons/achievement_guildperk_mountup", L["Summon A Random Favourite Mount"])

	AutoBarCategoryList["Macro.BattlePet.SummonRandom"] = MacroTextCategory:new( "Macro.BattlePet.SummonRandom", "INV_MISC_QUESTIONMARK")
	AutoBarCategoryList["Macro.BattlePet.SummonRandom"]:AddMacroText("/randompet",  "Interface/Icons/INV_MISC_QUESTIONMARK", L["Summon A Random Pet"])

	AutoBarCategoryList["Macro.BattlePet.SummonRandomFave"] = MacroTextCategory:new( "Macro.BattlePet.SummonRandomFave", "PetBattle_Health")
	AutoBarCategoryList["Macro.BattlePet.SummonRandomFave"]:AddMacroText("/randomfavoritepet",  "Interface/Icons/PetBattle_Health", L["Summon A Random Fave Pet"])

	AutoBarCategoryList["Macro.BattlePet.DismissPet"] = MacroTextCategory:new( "Macro.BattlePet.DismissPet", "Spell_BrokenHeart")
	AutoBarCategoryList["Macro.BattlePet.DismissPet"]:AddMacroText("/dismisspet",  "Interface/Icons/Spell_BrokenHeart", L["Dismiss Battle Pet"])

	AutoBarCategoryList["Muffin.Battle Pet Items.Upgrade"] = ItemsCategory:new("Muffin.Battle Pet Items.Upgrade", "INV_BannerPVP_02", "Muffin.Battle Pet Items.Upgrade")
	AutoBarCategoryList["Muffin.Battle Pet Items.Level"] = ItemsCategory:new("Muffin.Battle Pet Items.Level", "INV_BannerPVP_02", "Muffin.Battle Pet Items.Level")
	AutoBarCategoryList["Muffin.Battle Pet Items.Bandages"] = ItemsCategory:new("Muffin.Battle Pet Items.Bandages", "INV_BannerPVP_02", "Muffin.Battle Pet Items.Bandages")
	AutoBarCategoryList["Muffin.Battle Pet Items.Pet Treat"] = ItemsCategory:new("Muffin.Battle Pet Items.Pet Treat", "INV_BannerPVP_02", "Muffin.Battle Pet Items.Pet Treat")

	AutoBarCategoryList["Spell.Pet Battle"] = SpellsCategory:new("Spell.Pet Battle", spellIconList["Conjure Refreshment"],
	{
		"*", code.get_spell_name_by_name("Revive Battle Pets"),
	})

	AutoBarCategoryList["Muffin.Drum"] = ItemsCategory:new("Muffin.Drum", "INV_Misc_Drum_05", "Muffin.Drum")

	AutoBarCategoryList["Muffin.Misc.Repair"] = ItemsCategory:new( "Muffin.Misc.Repair", "INV_Misc_HERB_01", "Muffin.Misc.Repair")

	AutoBarCategoryList["Muffin.Bandages.Basic"] = ItemsCategory:new( "Muffin.Bandages.Basic", "INV_Misc_Bandage_Netherweave_Heavy", "Muffin.Bandages.Basic")

	AutoBarCategoryList["Muffin.Skill.Archaeology.Crate"] = ItemsCategory:new( "Muffin.Skill.Archaeology.Crate", "INV_Misc_Food_26", "Muffin.Skill.Archaeology.Crate")
	AutoBarCategoryList["Muffin.Skill.Archaeology.Mission"] = ItemsCategory:new( "Muffin.Skill.Archaeology.Mission", "INV_Misc_Food_26", "Muffin.Skill.Archaeology.Mission")
	AutoBarCategoryList["Muffin.Skill.Archaeology.Lodestone"] = ItemsCategory:new("Muffin.Skill.Archaeology.Lodestone", "archaeology_5_0_mogucoin", "Muffin.Skill.Archaeology.Lodestone")
	AutoBarCategoryList["Muffin.Skill.Archaeology.Map"] = ItemsCategory:new("Muffin.Skill.Archaeology.Map", "archaeology_5_0_mogucoin", "Muffin.Skill.Archaeology.Map")

	AutoBarCategoryList["Muffin.Herbs.Millable"] = ItemsCategory:new( "Muffin.Herbs.Millable", "INV_Misc_HERB_01", "Muffin.Herbs.Millable")

	AutoBarCategoryList["Muffin.SunSongRanch"] = ItemsCategory:new("Muffin.SunSongRanch", "INV_Potion_76", "Muffin.SunSongRanch")

	AutoBarCategoryList["Muffin.Garrison"] = ItemsCategory:new("Muffin.Garrison", "INV_Potion_76", "Muffin.Garrison")

	AutoBarCategoryList["Muffin.Order Hall.Artifact Power"] = ItemsCategory:new("Muffin.Order Hall.Artifact Power", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Artifact Power")
	AutoBarCategoryList["Muffin.Order Hall.Nethershard"] = ItemsCategory:new("Muffin.Order Hall.Nethershard", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Nethershard")
	AutoBarCategoryList["Muffin.Order Hall.Troop Recruit"] = ItemsCategory:new("Muffin.Order Hall.Troop Recruit", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Troop Recruit")
	AutoBarCategoryList["Muffin.Order Hall.Buff"] = ItemsCategory:new("Muffin.Order Hall.Buff", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Buff")
	AutoBarCategoryList["Muffin.Order Hall.Champion"] = ItemsCategory:new("Muffin.Order Hall.Champion", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Champion")
	AutoBarCategoryList["Muffin.Order Hall.Ancient Mana"] = ItemsCategory:new("Muffin.Order Hall.Ancient Mana", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Ancient Mana")
	AutoBarCategoryList["Muffin.Order Hall.Order Resources"] = ItemsCategory:new("Muffin.Order Hall.Order Resources", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Order Resources")

	AutoBarCategoryList["Muffin.Covenant.Anima"] = ItemsCategory:new("Muffin.Covenant.Anima", "archaeology_5_0_mogucoin", "Muffin.Covenant.Anima")
	AutoBarCategoryList["Muffin.Covenant.Conduit"] = ItemsCategory:new("Muffin.Covenant.Conduit", "archaeology_5_0_mogucoin", "Muffin.Covenant.Conduit")
	AutoBarCategoryList["Muffin.Covenant.Wildseed"] = ItemsCategory:new("Muffin.Covenant.Wildseed", "archaeology_5_0_mogucoin", "Muffin.Covenant.Wildseed")

	AutoBarCategoryList["Muffin.ItemEnchant.Permanent"] = ItemsCategory:new("Muffin.ItemEnchant.Permanent", "archaeology_5_0_mogucoin", "Muffin.ItemEnchant.Permanent")
	AutoBarCategoryList["Muffin.ItemEnchant.Temporary"] = ItemsCategory:new("Muffin.ItemEnchant.Temporary", "archaeology_5_0_mogucoin", "Muffin.ItemEnchant.Temporary")


	AutoBarCategoryList["Spell.Warlock.Create Healthstone"] = SpellsCategory:new( "Spell.Warlock.Create Healthstone", spellIconList["Create Healthstone"], nil,
	{
		"WARLOCK", code.get_spell_name_by_name("Create Healthstone"), code.get_spell_name_by_name("Create Soulwell"),
	})

	AutoBarCategoryList["Spell.Mage.Conjure Food"] = SpellsCategory:new( "Spell.Mage.Conjure Food", spellIconList["Conjure Refreshment"], {
		"MAGE", code.get_spell_name_by_name("Conjure Refreshment"),
	})

	AutoBarCategoryList["Consumable.Water.Conjure"] = SpellsCategory:new("Consumable.Water.Conjure", spellIconList["Conjure Refreshment"], {
		"MAGE", code.get_spell_name_by_name("Conjure Refreshment"),
	})

	AutoBarCategoryList["Consumable.Food.Conjure"] = SpellsCategory:new("Consumable.Food.Conjure", spellIconList["Conjure Refreshment"], {
		"MAGE", code.get_spell_name_by_name("Conjure Refreshment"),
	})

	AutoBarCategoryList["Spell.Mage.Create Manastone"] = SpellsCategory:new( "Spell.Mage.Create Manastone", "inv_misc_gem_sapphire_02",
	{
		"MAGE", code.get_spell_name_by_name("Conjure Mana Gem"),
	})


	AutoBarCategoryList["Spell.Stealth"] = SpellsCategory:new("Spell.Stealth", spellIconList["Stealth"],
	{
		"DRUID", code.get_spell_name_by_name("Prowl"),
		"HUNTER", code.get_spell_name_by_name("Camouflage"),
		"MAGE", code.get_spell_name_by_name("Greater Invisibility"),
		"MAGE", code.get_spell_name_by_name("Invisibility"),
		"ROGUE", code.get_spell_name_by_name("Stealth"),
		"*", code.get_spell_name_by_name("Shadowmeld"),
	})


	AutoBarCategoryList["Spell.Aspect"] = SpellsCategory:new("Spell.Aspect", spellIconList["Aspect of the Cheetah"],
	{
		"HUNTER", code.get_spell_name_by_name("Aspect of the Cheetah"),
		"HUNTER", code.get_spell_name_by_name("Aspect of the Chameleon"),
		"HUNTER", code.get_spell_name_by_name("Aspect of the Turtle"),
		"HUNTER", code.get_spell_name_by_name("Aspect of the Eagle"),
		"HUNTER", code.get_spell_name_by_name("Aspect of the Wild"),
	})


	AutoBarCategoryList["Spell.Poison.Lethal"] = SpellsCategory:new( "Spell.Poison.Lethal", spellIconList["Deadly Poison"], {
		"ROGUE", code.get_spell_name_by_name("Amplifying Poison"),
		"ROGUE", code.get_spell_name_by_name("Deadly Poison"),
		"ROGUE", code.get_spell_name_by_name("Instant Poison"),
		"ROGUE", code.get_spell_name_by_name("Wound Poison"),
	})

	AutoBarCategoryList["Spell.Poison.Nonlethal"] = SpellsCategory:new( "Spell.Poison.Nonlethal", spellIconList["Crippling Poison"],
	{
		"ROGUE", code.get_spell_name_by_name("Atrophic Poison"),
		"ROGUE", code.get_spell_name_by_name("Crippling Poison"),
		"ROGUE", code.get_spell_name_by_name("Numbing Poison"),
	})



	AutoBarCategoryList["Spell.Class.Buff"] = SpellsCategory:new( "Spell.Class.Buff", spellIconList["Barkskin"],
	{
		"DEATHKNIGHT", code.get_spell_name_by_name("Path of Frost"),
		"DRUID", code.get_spell_name_by_name("Ironbark"),
		"DRUID", code.get_spell_name_by_name("Mark of the Wild"),
		"EVOKER", code.get_spell_name_by_name("Blessing of the Bronze"),
		"MAGE", code.get_spell_name_by_name("Slow Fall"),
		"MAGE", code.get_spell_name_by_name("Arcane Intellect"),
		"PALADIN", code.get_spell_name_by_name("Blessing of Freedom"),
		"PALADIN", code.get_spell_name_by_name("Blessing of Protection"),
		"PALADIN", code.get_spell_name_by_name("Blessing of Sacrifice"),
		"PALADIN", code.get_spell_name_by_name("Blessing of Spellwarding"),
		"PRIEST", code.get_spell_name_by_name("Levitate"),
		"PRIEST", code.get_spell_name_by_name("Power Word: Fortitude"),
		"SHAMAN", code.get_spell_name_by_name("Skyfury"),
		"SHAMAN", code.get_spell_name_by_name("Water Walking"),
		"WARLOCK", code.get_spell_name_by_name("Unending Breath"),
		"WARLOCK", code.get_spell_name_by_name("Soulstone"),
		"WARRIOR", code.get_spell_name_by_name("Battle Shout"),
		"WARRIOR", code.get_spell_name_by_name("Rallying Cry"),
	})

	AutoBarCategoryList["Spell.Class.Pet"] = SpellsCategory:new( "Spell.Class.Pet", spellIconList["Call Pet 1"],
	{
		"DEATHKNIGHT", code.get_spell_name_by_name("Dancing Rune Weapon"),
		"DEATHKNIGHT", code.get_spell_name_by_name("Raise Dead"),
		"DEATHKNIGHT", code.get_spell_name_by_name("Army of the Dead"),
		"DEATHKNIGHT", code.get_spell_name_by_name("Summon Gargoyle"),
		"HUNTER", code.get_spell_name_by_name("Call Pet 1"),
		"HUNTER", code.get_spell_name_by_name("Call Pet 2"),
		"HUNTER", code.get_spell_name_by_name("Call Pet 3"),
		"HUNTER", code.get_spell_name_by_name("Call Pet 4"),
		"HUNTER", code.get_spell_name_by_name("Call Pet 5"),
		"MAGE", code.get_spell_name_by_name("Summon Water Elemental"),
		"MONK", code.get_spell_name_by_name("Storm, Earth, and Fire"),
		"PRIEST", code.get_spell_name_by_name("Shadowfiend"),
		"SHAMAN", code.get_spell_name_by_name("Earth Elemental"),
		"SHAMAN", code.get_spell_name_by_name("Fire Elemental"),
		"SHAMAN", code.get_spell_name_by_name("Storm Elemental"),
		"SHAMAN", code.get_spell_name_by_name("Feral Spirit"),
		"WARLOCK", code.get_spell_name_by_name("Summon Felguard"),
		"WARLOCK", code.get_spell_name_by_name("Summon Felhunter"),
		"WARLOCK", code.get_spell_name_by_name("Summon Imp"),
		"WARLOCK", code.get_spell_name_by_name("Summon Sayaad"),
		"WARLOCK", code.get_spell_name_by_name("Summon Voidwalker"),
	})



	AutoBarCategoryList["Spell.Class.Pets2"] = SpellsCategory:new( "Spell.Class.Pets2", spellIconList["Call Pet 1"],
	{
		"DEATHKNIGHT", code.get_spell_name_by_name("Dark Transformation"),
		"HUNTER", code.get_spell_name_by_name("Kill Command"),
		"HUNTER", code.get_spell_name_by_name("Bestial Wrath"),
		"HUNTER", code.get_spell_name_by_name("Dire Beast"),
		"HUNTER", code.get_spell_name_by_name("Master's Call"),
		"HUNTER", code.get_spell_name_by_name("Mend Pet"),
		"HUNTER", code.get_spell_name_by_name("Intimidation"),
		"WARLOCK", code.get_spell_name_by_name("Command Demon"),
		"WARLOCK", code.get_spell_name_by_name("Eye of Kilrogg"),
		"WARLOCK", code.get_spell_name_by_name("Summon Infernal"),
		"WARLOCK", code.get_spell_name_by_name("Call Dreadstalkers"),
		"WARLOCK", code.get_spell_name_by_name("Grimoire of Sacrifice"),
		"WARLOCK", code.get_spell_name_by_name("Summon Darkglare"),
		"WARLOCK", code.get_spell_name_by_name("Summon Demonic Tyrant"),
	})

	--Misc pet abilities
	AutoBarCategoryList["Spell.Class.Pets3"] = SpellsCategory:new(	"Spell.Class.Pets3", spellIconList["Feed Pet"],
	{
		"HUNTER", code.get_spell_name_by_name("Dismiss Pet"),
		"HUNTER", code.get_spell_name_by_name("Eagle Eye"),
		"HUNTER", code.get_spell_name_by_name("Eyes of the Beast"),
		"HUNTER", code.get_spell_name_by_name("Feed Pet"),
		"HUNTER", code.get_spell_name_by_name("Revive Pet"),
		"HUNTER", code.get_spell_name_by_name("Tame Beast"),
		"HUNTER", code.get_spell_name_by_name("Beast Lore"),
		"HUNTER", code.get_spell_name_by_name("Fetch"),
		"HUNTER", code.get_spell_name_by_name("Play Dead"),
		"HUNTER", code.get_spell_name_by_name("Wake Up"),
	})



	AutoBarCategoryList["Spell.Portals"] = SpellsCategory:new( "Spell.Portals", "spell_arcane_portalironforge", nil,
	{
		"DRUID", code.get_spell_name_by_name("Teleport: Moonglade"), code.get_spell_name_by_name("Teleport: Moonglade"),
		"DRUID", code.get_spell_name_by_name("Dreamwalk"), code.get_spell_name_by_name("Dreamwalk"),
		"MAGE", code.get_spell_name_by_name("Teleport: Stonard"), code.get_spell_name_by_name("Portal: Stonard"),
		"MAGE", code.get_spell_name_by_name("Teleport: Theramore"), code.get_spell_name_by_name("Portal: Theramore"),
		"MAGE", code.get_spell_name_by_name("Teleport: Undercity"), code.get_spell_name_by_name("Portal: Undercity"),
		"MAGE", code.get_spell_name_by_name("Teleport: Thunder Bluff"), code.get_spell_name_by_name("Portal: Thunder Bluff"),
		"MAGE", code.get_spell_name_by_name("Teleport: Stormwind"), code.get_spell_name_by_name("Portal: Stormwind"),
		"MAGE", code.get_spell_name_by_name("Teleport: Silvermoon"), code.get_spell_name_by_name("Portal: Silvermoon"),
		"MAGE", code.get_spell_name_by_name("Teleport: Exodar"), code.get_spell_name_by_name("Portal: Exodar"),
		"MAGE", code.get_spell_name_by_name("Teleport: Darnassus"), code.get_spell_name_by_name("Portal: Darnassus"),
		"MAGE", code.get_spell_name_by_name("Teleport: Ironforge"), code.get_spell_name_by_name("Portal: Ironforge"),
		"MAGE", code.get_spell_name_by_name("Teleport: Orgrimmar"), code.get_spell_name_by_name("Portal: Orgrimmar"),
		"MAGE", code.get_spell_name_by_name("Teleport: Shattrath"), code.get_spell_name_by_name("Portal: Shattrath"),
		"MAGE", code.get_spell_name_by_name("Teleport: Dalaran"), code.get_spell_name_by_name("Portal: Dalaran"),
		"MAGE", code.get_spell_name_by_name("Teleport: Dalaran - Broken Isles"), code.get_spell_name_by_name("Portal: Dalaran - Broken Isles"),
		"MAGE", code.get_spell_name_by_name("Teleport: Tol Barad - Horde"), code.get_spell_name_by_name("Portal: Tol Barad - Horde"),
		"MAGE", code.get_spell_name_by_name("Teleport: Tol Barad - Alliance"), code.get_spell_name_by_name("Portal: Tol Barad - Alliance"),
		"MAGE", code.get_spell_name_by_name("Teleport: Vale of Eternal Blossoms - Alliance"), code.get_spell_name_by_name("Portal: Vale of Eternal Blossoms - Alliance"),
		"MAGE", code.get_spell_name_by_name("Teleport: Vale of Eternal Blossoms - Horde"), code.get_spell_name_by_name("Portal: Vale of Eternal Blossoms - Horde"),
		"MAGE", code.get_spell_name_by_name("Teleport: Stormshield"), code.get_spell_name_by_name("Portal: Stormshield"),
		"MAGE", code.get_spell_name_by_name("Teleport: Warspear"), code.get_spell_name_by_name("Portal: Warspear"),
		"MAGE", code.get_spell_name_by_name("Teleport: Hall of the Guardian"), code.get_spell_name_by_name("Teleport: Hall of the Guardian"),
		"MAGE", code.get_spell_name_by_name("Teleport: Boralus"), code.get_spell_name_by_name("Portal: Boralus"),
		"MAGE", code.get_spell_name_by_name("Teleport: Dazar'alor"), code.get_spell_name_by_name("Portal: Dazar'alor"),
		"MAGE", code.get_spell_name_by_name("Teleport: Oribos"), code.get_spell_name_by_name("Portal: Oribos"),
		"MAGE", code.get_spell_name_by_name("Teleport: Valdrakken"), code.get_spell_name_by_name("Portal: Valdrakken"),
		"MAGE", code.get_spell_name_by_name("Teleport: Dornogal"), code.get_spell_name_by_name("Portal: Dornogal"),
		"MONK", code.get_spell_name_by_name("Zen Pilgrimage"), code.get_spell_name_by_name("Zen Pilgrimage"),
		"MONK", code.get_spell_name_by_name("Zen Pilgrimage: Return"), code.get_spell_name_by_name("Zen Pilgrimage: Return"),
		"DEATHKNIGHT", code.get_spell_name_by_name("Death Gate"), code.get_spell_name_by_name("Death Gate"),
		"SHAMAN", code.get_spell_name_by_name("Astral Recall"), code.get_spell_name_by_name("Astral Recall"),
		"WARLOCK", code.get_spell_name_by_name("Ritual of Summoning"), code.get_spell_name_by_name("Ritual of Summoning"),
		"*", code.get_spell_name_by_name("Mole Machine"), code.get_spell_name_by_name("Mole Machine"),
	})

	AutoBarCategoryList["Spell.ChallengePortals"] = SpellsCategory:new("Spell.ChallengePortals", "spell_arcane_portalironforge", nil,
	{
		"*", code.get_spell_name_by_name("Path of the Jade Serpent"), code.get_spell_name_by_name("Path of the Jade Serpent"),
		"*", code.get_spell_name_by_name("Path of the Stout Brew"), code.get_spell_name_by_name("Path of the Stout Brew"),
		"*", code.get_spell_name_by_name("Path of the Shado-Pan"), code.get_spell_name_by_name("Path of the Shado-Pan"),
		"*", code.get_spell_name_by_name("Path of the Mogu King"), code.get_spell_name_by_name("Path of the Mogu King"),
		"*", code.get_spell_name_by_name("Path of the Setting Sun"), code.get_spell_name_by_name("Path of the Setting Sun"),
		"*", code.get_spell_name_by_name("Path of the Scarlet Blade"), code.get_spell_name_by_name("Path of the Scarlet Blade"),
		"*", code.get_spell_name_by_name("Path of the Scarlet Mitre"), code.get_spell_name_by_name("Path of the Scarlet Mitre"),
		"*", code.get_spell_name_by_name("Path of the Necromancer"), code.get_spell_name_by_name("Path of the Necromancer"),
		"*", code.get_spell_name_by_name("Path of the Black Ox"), code.get_spell_name_by_name("Path of the Black Ox"),
	})

	AutoBarCategoryList["Spell.AncientDalaranPortals"] = SpellsCategory:new("Spell.AncientDalaranPortals", spellIconList["Portal: Ancient Dalaran"], nil,
	{
		"MAGE", code.get_spell_name_by_name("Teleport: Ancient Dalaran"), code.get_spell_name_by_name("Portal: Ancient Dalaran"),
	})

	AutoBarCategoryList["Spell.Shields"] = SpellsCategory:new( "Spell.Shields", spellIconList["Ice Barrier"], nil,
	{
		"DEMONHUNTER",	 code.get_spell_name_by_name("Blur"), 	code.get_spell_name_by_name("Darkness"),
		"DEATHKNIGHT", code.get_spell_name_by_name("Anti-Magic Shell"), 	code.get_spell_name_by_name("Icebound Fortitude"),
		"DEATHKNIGHT", code.get_spell_name_by_name("Icebound Fortitude"), 	code.get_spell_name_by_name("Anti-Magic Shell"),
		"DRUID", 		code.get_spell_name_by_name("Barkskin"), 	code.get_spell_name_by_name("Barkskin"),
		"HUNTER", 		code.get_spell_name_by_name("Aspect of the Turtle"), 	code.get_spell_name_by_name("Aspect of the Turtle"),
		"MAGE", 			code.get_spell_name_by_name("Ice Barrier"), code.get_spell_name_by_name("Ice Barrier"),
		"MAGE", 			code.get_spell_name_by_name("Temporal Shield"), code.get_spell_name_by_name("Temporal Shield"),
		"MAGE", 			code.get_spell_name_by_name("Blazing Barrier"), code.get_spell_name_by_name("Blazing Barrier"),
		"MAGE", 			code.get_spell_name_by_name("Prismatic Barrier"), code.get_spell_name_by_name("Prismatic Barrier"),
		"MONK", 			code.get_spell_name_by_name("Fortifying Brew"), code.get_spell_name_by_name("Fortifying Brew"),
		"PALADIN", 		code.get_spell_name_by_name("Ardent Defender"), code.get_spell_name_by_name("Ardent Defender"),
		"PALADIN", 		code.get_spell_name_by_name("Divine Shield"), code.get_spell_name_by_name("Divine Shield"),
		"PRIEST", 		code.get_spell_name_by_name("Power Word: Shield"), code.get_spell_name_by_name("Power Word: Barrier"),
		"ROGUE", 		code.get_spell_name_by_name("Evasion"), 		code.get_spell_name_by_name("Evasion"),
		"SHAMAN", 		code.get_spell_name_by_name("Lightning Shield"),		code.get_spell_name_by_name("Earth Shield"),
		"SHAMAN", 		code.get_spell_name_by_name("Earth Shield"),		code.get_spell_name_by_name("Lightning Shield"),
		"SHAMAN", 		code.get_spell_name_by_name("Water Shield"),		code.get_spell_name_by_name("Water Shield"),
		"WARLOCK", 		code.get_spell_name_by_name("Unending Resolve"), code.get_spell_name_by_name("Unending Resolve"),
		"WARRIOR", 		code.get_spell_name_by_name("Shield Block"), code.get_spell_name_by_name("Shield Wall"),
		"WARRIOR", 		code.get_spell_name_by_name("Shield Wall"), code.get_spell_name_by_name("Shield Block"),
	})

	AutoBarCategoryList["Spell.Stance"] = SpellsCategory:new( "Spell.Stance", spellIconList["Defensive Stance"], {
		"PALADIN", code.get_spell_name_by_name("Concentration Aura"),
		"PALADIN", code.get_spell_name_by_name("Crusader Aura"),
		"PALADIN", code.get_spell_name_by_name("Devotion Aura"),
		"PALADIN", code.get_spell_name_by_name("Retribution Aura"),
	})



	AutoBarCategoryList["Spell.Guild"] = SpellsCategory:new("Spell.Guild", spellIconList["Mobile Banking"],
	{
		"*", code.get_spell_name_by_name("Mobile Banking"),
	})


	AutoBarCategoryList["Spell.Totem.Earth"] = SpellsCategory:new("Spell.Totem.Earth", spellIconList["Earthgrab Totem"],
	{
		"SHAMAN", code.get_spell_name_by_name("Ancestral Protection Totem"),
		"SHAMAN", code.get_spell_name_by_name("Earthgrab Totem"),
		"SHAMAN", code.get_spell_name_by_name("Earthbind Totem"),
		"SHAMAN", code.get_spell_name_by_name("Earthen Wall Totem"),
	})


	AutoBarCategoryList["Spell.Totem.Air"] = SpellsCategory:new("Spell.Totem.Air", spellIconList["Wind Rush Totem"],
	{
		"SHAMAN", code.get_spell_name_by_name("Cloudburst Totem"),
		"SHAMAN", code.get_spell_name_by_name("Wind Rush Totem"),
	})

	AutoBarCategoryList["Spell.Totem.Fire"] = SpellsCategory:new("Spell.Totem.Fire", spellIconList["Liquid Magma Totem"],
	{
		"SHAMAN", code.get_spell_name_by_name("Liquid Magma Totem"),
	})

	AutoBarCategoryList["Spell.Totem.Water"] = SpellsCategory:new("Spell.Totem.Water", spellIconList["Healing Stream Totem"],
	{
		"SHAMAN", code.get_spell_name_by_name("Healing Stream Totem"),
		"SHAMAN", code.get_spell_name_by_name("Healing Tide Totem"),
		"SHAMAN", code.get_spell_name_by_name("Mana Tide Totem"),
		"SHAMAN", code.get_spell_name_by_name("Spirit Link Totem"),
	})


	AutoBarCategoryList["Spell.Buff.Weapon"] = SpellsCategory:new("Spell.Buff.Weapon", spellIconList["Deadly Poison"],
	{
		"ROGUE", code.get_spell_name_by_name("Deadly Poison"),
		"ROGUE", code.get_spell_name_by_name("Wound Poison"),
		"ROGUE", code.get_spell_name_by_name("Crippling Poison"),
		"SHAMAN", code.get_spell_name_by_name("Flametongue Weapon"),
		"SHAMAN", code.get_spell_name_by_name("Thunderstrike Ward"),
		"SHAMAN", code.get_spell_name_by_name("Windfury Weapon"),
	})

	AutoBarCategoryList["Spell.Crafting"] = SpellsCategory:new( "Spell.Crafting", spellIconList["First Aid"],
	{
		"*", code.get_spell_name_by_name("Alchemy"),
		"*", code.get_spell_name_by_name("Archaeology"),
		"*", code.get_spell_name_by_name("Cooking Fire"),
		"*", code.get_spell_name_by_name("Blacksmithing"),
		"*", code.get_spell_name_by_name("Cooking"),
		"*", code.get_spell_name_by_name("Disenchant"),
		"*", code.get_spell_name_by_name("Enchanting"),
		"*", code.get_spell_name_by_name("Engineering"),
		"*", code.get_spell_name_by_name("Inscription"),
		"*", code.get_spell_name_by_name("Jewelcrafting"),
		"*", code.get_spell_name_by_name("Leatherworking"),
		"*", code.get_spell_name_by_name("Milling"),
		"*", code.get_spell_name_by_name("Prospecting"),
		"*", code.get_spell_name_by_name("Smelting"),
		"*", code.get_spell_name_by_name("Survey"),
		"*", code.get_spell_name_by_name("Tailoring"),
		"*", code.get_spell_name_by_name("Skinning Journal"),
		"*", code.get_spell_name_by_name("Fishing Journal"),
		"*", code.get_spell_name_by_name("Herbalism Journal"),
		"*", code.get_spell_name_by_name("Mining Journal"),
		"DEATHKNIGHT", code.get_spell_name_by_name("Runeforging"),
	})

	AutoBarCategoryList["Spell.Archaeology"] = SpellsCategory:new("Spell.Archaeology", spellIconList["Archaeology"], nil,
	{
		"*",	code.get_spell_name_by_name("Survey"), code.get_spell_name_by_name("Archaeology"),
	})


	AutoBarCategoryList["Spell.Debuff.Multiple"] = SpellsCategory:new("Spell.Debuff.Multiple", spellIconList["Slow"],
	{
		"DRUID",		code.get_spell_name_by_name("Incapacitating Roar"),
		"HUNTER",	code.get_spell_name_by_name("Binding Shot"),
		"WARRIOR", code.get_spell_name_by_name("Demoralizing Shout"),
	})

	AutoBarCategoryList["Spell.Debuff.Single"] = SpellsCategory:new("Spell.Debuff.Single", spellIconList["Slow"],
	{
		"DEATHKNIGHT", code.get_spell_name_by_name("Chains of Ice"),
		"DRUID",	code.get_spell_name_by_name("Entangling Roots"),
		"HUNTER", code.get_spell_name_by_name("Concussive Shot"),
		"HUNTER", code.get_spell_name_by_name("Wing Clip"),
		"PALADIN", code.get_spell_name_by_name("Hand of Hindrance"),
		"WARLOCK", code.get_spell_name_by_name("Curse of Tongues"),
		"WARLOCK", code.get_spell_name_by_name("Curse of Weakness"),
		"WARLOCK", code.get_spell_name_by_name("Curse of Exhaustion"),
	})


	AutoBarCategoryList["Spell.Fishing"] = SpellsCategory:new("Spell.Fishing", spellIconList["Fishing"],
	{
		"*", code.get_spell_name_by_name("Fishing"),
		"*", code.get_spell_name_by_name("Undercurrent"),
	})



	AutoBarCategoryList["Spell.Trap"] = SpellsCategory:new( "Spell.Trap", spellIconList["Explosive Trap"],
	{
		"DEMONHUNTER", code.get_spell_name_by_name("Sigil of Flame"),
		"DEMONHUNTER", code.get_spell_name_by_name("Sigil of Misery"),
		"DEMONHUNTER", code.get_spell_name_by_name("Sigil of Silence"),
		"HUNTER", code.get_spell_name_by_name("Freezing Trap"),
		"HUNTER", code.get_spell_name_by_name("Tar Trap"),
		"HUNTER", code.get_spell_name_by_name("Steel Trap"),
	})


	AutoBarCategoryList["Misc.Mount.Summoned"] = SpellsCategory:new( "Misc.Mount.Summoned", spellIconList["Summon Dreadsteed"],
	{
		"DRUID", code.get_spell_name_by_name("Travel Form"),
		"SHAMAN", code.get_spell_name_by_name("Ghost Wolf"),
		"*", code.get_spell_name_by_name("Running Wild"),
	})
	AutoBarCategoryList["Misc.Mount.Summoned"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Mounts"] = SpellsCategory:new("Muffin.Mounts", spellIconList["Summon Dreadsteed"], nil, nil, "Muffin.Mounts." .. AutoBar.NiceClass)
	AutoBarCategoryList["Muffin.Mounts"]:SetNonCombat(true)

	AutoBarCategoryList["Spell.Charge"] = SpellsCategory:new( "Spell.Charge", spellIconList["Charge"],
	{
		"DEMONHUNTER", code.get_spell_name_by_name("Fel Rush"),
		"DRUID", code.get_spell_name_by_name("Wild Charge"),
		"HUNTER", code.get_spell_name_by_name("Harpoon"),
		"ROGUE", code.get_spell_name_by_name("Shadowstep"),
		"ROGUE", code.get_spell_name_by_name("Blade Rush"),
		"WARRIOR", code.get_spell_name_by_name("Charge"),
		"WARRIOR", code.get_spell_name_by_name("Intervene"),
	})

	AutoBarCategoryList["Spell.ER"] = SpellsCategory:new( "Spell.ER", spellIconList["Charge"],
	{
		"DEMONHUNTER", code.get_spell_name_by_name("Vengeful Retreat"),
		"DEATHKNIGHT", code.get_spell_name_by_name("Rune Tap"),
		"DRUID", code.get_spell_name_by_name("Frenzied Regeneration"),
		"HUNTER", code.get_spell_name_by_name("Feign Death"),
		"HUNTER", code.get_spell_name_by_name("Disengage"),
		"MAGE", code.get_spell_name_by_name("Ice Block"),
		"PALADIN", code.get_spell_name_by_name("Lay on Hands"),
		"PRIEST", code.get_spell_name_by_name("Dispersion"),
		"PRIEST", code.get_spell_name_by_name("Guardian Spirit"),
		"PRIEST", code.get_spell_name_by_name("Pain Suppression"),
		"ROGUE", code.get_spell_name_by_name("Vanish"),
		"WARLOCK", code.get_spell_name_by_name("Dark Pact"),
		"WARRIOR", code.get_spell_name_by_name("Last Stand"),
		"WARRIOR", code.get_spell_name_by_name("Enraged Regeneration"),
	})

	AutoBarCategoryList["Spell.Interrupt"] = SpellsCategory:new( "Spell.Interrupt", spellIconList["Charge"],
	{
		"DEATHKNIGHT", code.get_spell_name_by_name("Mind Freeze"),
		"DEMONHUNTER", code.get_spell_name_by_name("Disrupt"),
		"DRUID", code.get_spell_name_by_name("Skull Bash"),
		"HUNTER", code.get_spell_name_by_name("Counter Shot"),
		"MAGE", code.get_spell_name_by_name("Counterspell"),
		"MONK", code.get_spell_name_by_name("Spear Hand Strike"),
		"PALADIN", code.get_spell_name_by_name("Rebuke"),
		"PRIEST", code.get_spell_name_by_name("Silence"),
		"ROGUE", code.get_spell_name_by_name("Kick"),
		"SHAMAN", code.get_spell_name_by_name("Wind Shear"),
		"WARRIOR", code.get_spell_name_by_name("Pummel"),
	})

	AutoBarCategoryList["Spell.CatForm"] = SpellsCategory:new( "Spell.CatForm", spellIconList["Charge"],
	{
		"DRUID", code.get_spell_name_by_name("Cat Form"),
	})

	AutoBarCategoryList["Spell.BearForm"] = SpellsCategory:new( "Spell.BearForm", spellIconList["Charge"],
	{
		"DRUID", code.get_spell_name_by_name("Bear Form"),
	})

	AutoBarCategoryList["Spell.MoonkinForm"] = SpellsCategory:new( "Spell.MoonkinForm", spellIconList["Charge"],
	{
		"DRUID", code.get_spell_name_by_name("Moonkin Form"),
	})

	AutoBarCategoryList["Spell.TreeForm"] = SpellsCategory:new( "Spell.TreeForm", spellIconList["Charge"],
	{
		"DRUID", code.get_spell_name_by_name("Treant Form"),
	})

	AutoBarCategoryList["Spell.StagForm"] = SpellsCategory:new( "Spell.StagForm", spellIconList["Charge"],
	{
		"DRUID", code.get_spell_name_by_name("Mount Form"),
	})

	AutoBarCategoryList["Spell.Travel"] = SpellsCategory:new( "Spell.Travel", spellIconList["Charge"],
	{
		"DRUID", code.get_spell_name_by_name("Travel Form"),
		"SHAMAN", code.get_spell_name_by_name("Ghost Wolf"),
	})

	-- Knowledge Items Category
	local KNOWLEDGE_ITEMS = {
		-- Add your knowledge item IDs here, one per line
		-- Example:
		-- 192131,  -- Item Name
		224835, --Deepgrove Roots
	}

	AB.KnowledgeCategory = CreateFromMixins(AB.CategoryClass)
	local KnowledgeCategory = AB.KnowledgeCategory

	function KnowledgeCategory:new()
		local obj = CreateFromMixins(self)
		obj:init("Knowledge", "Interface\\Icons\\INV_Misc_Book_08")
		obj.items = KNOWLEDGE_ITEMS
		return obj
	end

	AutoBarCategoryList["Knowledge"] = KnowledgeCategory:new()

	-- Crests Category
	local CRESTS_ITEMS = {
		-- Add your crest item IDs here, one per line
		-- Example:
		-- 240931,  -- Item Name
		240931, -- Triumphant Satchel of Carved Ethereal Crests
	}

	AB.CrestsCategory = CreateFromMixins(AB.CategoryClass)
	local CrestsCategory = AB.CrestsCategory

	function CrestsCategory:new()
		local obj = CreateFromMixins(self)
		obj:init("Crests", "Interface\\Icons\\INV_10_gearupgrade_awakenedseal")
		obj.items = CRESTS_ITEMS
		return obj
	end

	AutoBarCategoryList["Crests"] = CrestsCategory:new()

end

