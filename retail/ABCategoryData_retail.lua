local _ADDON_NAME, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

local AutoBar = AutoBar
local ABGData = AutoBarGlobalDataObject
local spellIconList = ABGData.spell_icon_list
local L = AutoBarGlobalDataObject.locale
local ItemsCategory = AB.ItemsCategory
local MacroTextCategory = AB.MacroTextCategory
local SpellsCategory = AB.SpellsCategory

AB.ToyCategory = CreateFromMixins(AB.CategoryClass)
local ToyCategory = AB.ToyCategory

function ToyCategory:new(p_description, p_short_texture, p_pt_name)
	assert(type(p_description) == "string")
	assert(type(p_short_texture) == "string")

	local obj = CreateFromMixins(self)
	obj:init(p_description, "Interface\\Icons\\" .. p_short_texture)

	obj.is_toy = true

	--All items in the category
	obj.all_items = {}

	if(p_pt_name) then
		--print("pt_name", p_pt_name);
		local raw_list = AB.AddPTSetToRawList({}, p_pt_name, false)
		obj.all_items = AB.RawListToItemIDList(raw_list)
		--print("all_items", AB.Dump(obj.all_items))
	end

	obj:Refresh()

	return obj
end

-- Reset the item list in case the player learned new toys
function ToyCategory:Refresh()
	local list_index = 1
	local debug = false --(self.categoryKey == "Muffin.Toys.Hearth")
	if(debug) then AB.LogWarning("Refreshing Toy Category", self.categoryKey, "Items:", #self.items, "All:", #self.all_items); end

	wipe(self.items)

	if(self.only_favourites == nil) then
		if(debug) then AB.LogWarning("Exiting Toy Refresh, button settings aren't loaded|n"); end
		return
	end
	local DEBUG_IDS = AB.MakeSet({182773, 172179})

	for _, toy_id in ipairs(self.all_items) do
		local toy_info = AutoBarSearch:RegisterToy(toy_id)
		local user_selected = (self.only_favourites and toy_info.is_fave) or not self.only_favourites
		if(debug and DEBUG_IDS[toy_id]) then AB.LogWarning(toy_id, toy_info.name, "HasToy:", AB.PlayerHasToy(toy_id), "Usable:", AB.IsToyUsable(toy_id), "fave:", toy_info.is_fave, "select:", user_selected, "OnlyFave:", self.only_favourites); end
		if (toy_id and AB.PlayerHasToy(toy_id) and AB.IsToyUsable(toy_id) and user_selected) then
			self.items[list_index] = AB.ToyGUID(toy_id)
			list_index = list_index + 1
		end
	end



	if(debug) then AB.LogWarning("After Refreshing Toy Category", self.categoryKey, "Items:", #self.items, "All:", #self.all_items, "|n"); end

end

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
		"*", AB.GetSpellNameByName("Revive Battle Pets"),
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
		"WARLOCK", AB.GetSpellNameByName("Create Healthstone"), AB.GetSpellNameByName("Create Soulwell"),
	})

	AutoBarCategoryList["Spell.Mage.Conjure Food"] = SpellsCategory:new( "Spell.Mage.Conjure Food", spellIconList["Conjure Refreshment"], {
		"MAGE", AB.GetSpellNameByName("Conjure Refreshment"),
	})

	AutoBarCategoryList["Consumable.Water.Conjure"] = SpellsCategory:new("Consumable.Water.Conjure", spellIconList["Conjure Refreshment"], {
		"MAGE", AB.GetSpellNameByName("Conjure Refreshment"),
	})

	AutoBarCategoryList["Consumable.Food.Conjure"] = SpellsCategory:new("Consumable.Food.Conjure", spellIconList["Conjure Refreshment"], {
		"MAGE", AB.GetSpellNameByName("Conjure Refreshment"),
	})

	AutoBarCategoryList["Spell.Mage.Create Manastone"] = SpellsCategory:new( "Spell.Mage.Create Manastone", "inv_misc_gem_sapphire_02",
	{
		"MAGE", AB.GetSpellNameByName("Conjure Mana Gem"),
	})


	AutoBarCategoryList["Spell.Stealth"] = SpellsCategory:new("Spell.Stealth", spellIconList["Stealth"],
	{
		"DRUID", AB.GetSpellNameByName("Prowl"),
		"HUNTER", AB.GetSpellNameByName("Camouflage"),
		"MAGE", AB.GetSpellNameByName("Greater Invisibility"),
		"MAGE", AB.GetSpellNameByName("Invisibility"),
		"ROGUE", AB.GetSpellNameByName("Stealth"),
		"*", AB.GetSpellNameByName("Shadowmeld"),
	})


	AutoBarCategoryList["Spell.Aspect"] = SpellsCategory:new("Spell.Aspect", spellIconList["Aspect of the Cheetah"],
	{
		"HUNTER", AB.GetSpellNameByName("Aspect of the Cheetah"),
		"HUNTER", AB.GetSpellNameByName("Aspect of the Chameleon"),
		"HUNTER", AB.GetSpellNameByName("Aspect of the Turtle"),
		"HUNTER", AB.GetSpellNameByName("Aspect of the Eagle"),
		"HUNTER", AB.GetSpellNameByName("Aspect of the Wild"),
	})


	AutoBarCategoryList["Spell.Poison.Lethal"] = SpellsCategory:new( "Spell.Poison.Lethal", spellIconList["Deadly Poison"], {
		"ROGUE", AB.GetSpellNameByName("Amplifying Poison"),
		"ROGUE", AB.GetSpellNameByName("Deadly Poison"),
		"ROGUE", AB.GetSpellNameByName("Instant Poison"),
		"ROGUE", AB.GetSpellNameByName("Wound Poison"),
	})

	AutoBarCategoryList["Spell.Poison.Nonlethal"] = SpellsCategory:new( "Spell.Poison.Nonlethal", spellIconList["Crippling Poison"],
	{
		"ROGUE", AB.GetSpellNameByName("Atrophic Poison"),
		"ROGUE", AB.GetSpellNameByName("Crippling Poison"),
		"ROGUE", AB.GetSpellNameByName("Numbing Poison"),
	})



	AutoBarCategoryList["Spell.Class.Buff"] = SpellsCategory:new( "Spell.Class.Buff", spellIconList["Barkskin"],
	{
		"DEATHKNIGHT", AB.GetSpellNameByName("Path of Frost"),
		"DRUID", AB.GetSpellNameByName("Ironbark"),
		"DRUID", AB.GetSpellNameByName("Mark of the Wild"),
		"EVOKER", AB.GetSpellNameByName("Blessing of the Bronze"),
		"MAGE", AB.GetSpellNameByName("Slow Fall"),
		"MAGE", AB.GetSpellNameByName("Arcane Intellect"),
		"PALADIN", AB.GetSpellNameByName("Blessing of Freedom"),
		"PALADIN", AB.GetSpellNameByName("Blessing of Protection"),
		"PALADIN", AB.GetSpellNameByName("Blessing of Sacrifice"),
		"PALADIN", AB.GetSpellNameByName("Blessing of Spellwarding"),
		"PRIEST", AB.GetSpellNameByName("Levitate"),
		"PRIEST", AB.GetSpellNameByName("Power Word: Fortitude"),
		"SHAMAN", AB.GetSpellNameByName("Water Walking"),
		"WARLOCK", AB.GetSpellNameByName("Unending Breath"),
		"WARLOCK", AB.GetSpellNameByName("Soulstone"),
		"WARRIOR", AB.GetSpellNameByName("Battle Shout"),
		"WARRIOR", AB.GetSpellNameByName("Rallying Cry"),
	})

	AutoBarCategoryList["Spell.Class.Pet"] = SpellsCategory:new( "Spell.Class.Pet", spellIconList["Call Pet 1"],
	{
		"DEATHKNIGHT", AB.GetSpellNameByName("Dancing Rune Weapon"),
		"DEATHKNIGHT", AB.GetSpellNameByName("Raise Dead"),
		"DEATHKNIGHT", AB.GetSpellNameByName("Army of the Dead"),
		"DEATHKNIGHT", AB.GetSpellNameByName("Summon Gargoyle"),
		"HUNTER", AB.GetSpellNameByName("Call Pet 1"),
		"HUNTER", AB.GetSpellNameByName("Call Pet 2"),
		"HUNTER", AB.GetSpellNameByName("Call Pet 3"),
		"HUNTER", AB.GetSpellNameByName("Call Pet 4"),
		"HUNTER", AB.GetSpellNameByName("Call Pet 5"),
		"MAGE", AB.GetSpellNameByName("Summon Water Elemental"),
		"MONK", AB.GetSpellNameByName("Storm, Earth, and Fire"),
		"PRIEST", AB.GetSpellNameByName("Shadowfiend"),
		"SHAMAN", AB.GetSpellNameByName("Earth Elemental"),
		"SHAMAN", AB.GetSpellNameByName("Fire Elemental"),
		"SHAMAN", AB.GetSpellNameByName("Storm Elemental"),
		"SHAMAN", AB.GetSpellNameByName("Feral Spirit"),
		"WARLOCK", AB.GetSpellNameByName("Summon Felguard"),
		"WARLOCK", AB.GetSpellNameByName("Summon Felhunter"),
		"WARLOCK", AB.GetSpellNameByName("Summon Imp"),
		"WARLOCK", AB.GetSpellNameByName("Summon Succubus"),
		"WARLOCK", AB.GetSpellNameByName("Summon Voidwalker"),
	})



	AutoBarCategoryList["Spell.Class.Pets2"] = SpellsCategory:new( "Spell.Class.Pets2", spellIconList["Call Pet 1"],
	{
		"DEATHKNIGHT", AB.GetSpellNameByName("Dark Transformation"),
		"HUNTER", AB.GetSpellNameByName("Kill Command"),
		"HUNTER", AB.GetSpellNameByName("Bestial Wrath"),
		"HUNTER", AB.GetSpellNameByName("Dire Beast"),
		"HUNTER", AB.GetSpellNameByName("Master's Call"),
		"HUNTER", AB.GetSpellNameByName("Mend Pet"),
		"HUNTER", AB.GetSpellNameByName("Intimidation"),
		"WARLOCK", AB.GetSpellNameByName("Command Demon"),
		"WARLOCK", AB.GetSpellNameByName("Eye of Kilrogg"),
		"WARLOCK", AB.GetSpellNameByName("Summon Infernal"),
		"WARLOCK", AB.GetSpellNameByName("Call Dreadstalkers"),
		"WARLOCK", AB.GetSpellNameByName("Grimoire of Sacrifice"),
		"WARLOCK", AB.GetSpellNameByName("Summon Darkglare"),
		"WARLOCK", AB.GetSpellNameByName("Summon Demonic Tyrant"),
	})

	--Misc pet abilities
	AutoBarCategoryList["Spell.Class.Pets3"] = SpellsCategory:new(	"Spell.Class.Pets3", spellIconList["Feed Pet"],
	{
		"HUNTER", AB.GetSpellNameByName("Dismiss Pet"),
		"HUNTER", AB.GetSpellNameByName("Eagle Eye"),
		"HUNTER", AB.GetSpellNameByName("Eyes of the Beast"),
		"HUNTER", AB.GetSpellNameByName("Feed Pet"),
		"HUNTER", AB.GetSpellNameByName("Revive Pet"),
		"HUNTER", AB.GetSpellNameByName("Tame Beast"),
		"HUNTER", AB.GetSpellNameByName("Beast Lore"),
		"HUNTER", AB.GetSpellNameByName("Fetch"),
		"HUNTER", AB.GetSpellNameByName("Play Dead"),
		"HUNTER", AB.GetSpellNameByName("Wake Up"),
	})



	AutoBarCategoryList["Spell.Portals"] = SpellsCategory:new( "Spell.Portals", "spell_arcane_portalironforge", nil,
	{
		"DRUID", AB.GetSpellNameByName("Teleport: Moonglade"), AB.GetSpellNameByName("Teleport: Moonglade"),
		"DRUID", AB.GetSpellNameByName("Dreamwalk"), AB.GetSpellNameByName("Dreamwalk"),
		"MAGE", AB.GetSpellNameByName("Teleport: Stonard"), AB.GetSpellNameByName("Portal: Stonard"),
		"MAGE", AB.GetSpellNameByName("Teleport: Theramore"), AB.GetSpellNameByName("Portal: Theramore"),
		"MAGE", AB.GetSpellNameByName("Teleport: Undercity"), AB.GetSpellNameByName("Portal: Undercity"),
		"MAGE", AB.GetSpellNameByName("Teleport: Thunder Bluff"), AB.GetSpellNameByName("Portal: Thunder Bluff"),
		"MAGE", AB.GetSpellNameByName("Teleport: Stormwind"), AB.GetSpellNameByName("Portal: Stormwind"),
		"MAGE", AB.GetSpellNameByName("Teleport: Silvermoon"), AB.GetSpellNameByName("Portal: Silvermoon"),
		"MAGE", AB.GetSpellNameByName("Teleport: Exodar"), AB.GetSpellNameByName("Portal: Exodar"),
		"MAGE", AB.GetSpellNameByName("Teleport: Darnassus"), AB.GetSpellNameByName("Portal: Darnassus"),
		"MAGE", AB.GetSpellNameByName("Teleport: Ironforge"), AB.GetSpellNameByName("Portal: Ironforge"),
		"MAGE", AB.GetSpellNameByName("Teleport: Orgrimmar"), AB.GetSpellNameByName("Portal: Orgrimmar"),
		"MAGE", AB.GetSpellNameByName("Teleport: Shattrath"), AB.GetSpellNameByName("Portal: Shattrath"),
		"MAGE", AB.GetSpellNameByName("Teleport: Dalaran"), AB.GetSpellNameByName("Portal: Dalaran"),
		"MAGE", AB.GetSpellNameByName("Teleport: Dalaran - Broken Isles"), AB.GetSpellNameByName("Portal: Dalaran - Broken Isles"),
		"MAGE", AB.GetSpellNameByName("Teleport: Tol Barad - Horde"), AB.GetSpellNameByName("Portal: Tol Barad - Horde"),
		"MAGE", AB.GetSpellNameByName("Teleport: Tol Barad - Alliance"), AB.GetSpellNameByName("Portal: Tol Barad - Alliance"),
		"MAGE", AB.GetSpellNameByName("Teleport: Vale of Eternal Blossoms - Alliance"), AB.GetSpellNameByName("Portal: Vale of Eternal Blossoms - Alliance"),
		"MAGE", AB.GetSpellNameByName("Teleport: Vale of Eternal Blossoms - Horde"), AB.GetSpellNameByName("Portal: Vale of Eternal Blossoms - Horde"),
		"MAGE", AB.GetSpellNameByName("Teleport: Stormshield"), AB.GetSpellNameByName("Portal: Stormshield"),
		"MAGE", AB.GetSpellNameByName("Teleport: Warspear"), AB.GetSpellNameByName("Portal: Warspear"),
		"MAGE", AB.GetSpellNameByName("Teleport: Hall of the Guardian"), AB.GetSpellNameByName("Teleport: Hall of the Guardian"),
		"MAGE", AB.GetSpellNameByName("Teleport: Boralus"), AB.GetSpellNameByName("Portal: Boralus"),
		"MAGE", AB.GetSpellNameByName("Teleport: Dazar'alor"), AB.GetSpellNameByName("Portal: Dazar'alor"),
		"MAGE", AB.GetSpellNameByName("Teleport: Oribos"), AB.GetSpellNameByName("Portal: Oribos"),
		"MAGE", AB.GetSpellNameByName("Teleport: Valdrakken"), AB.GetSpellNameByName("Portal: Valdrakken"),
		"MONK", AB.GetSpellNameByName("Zen Pilgrimage"), AB.GetSpellNameByName("Zen Pilgrimage"),
		"MONK", AB.GetSpellNameByName("Zen Pilgrimage: Return"), AB.GetSpellNameByName("Zen Pilgrimage: Return"),
		"DEATHKNIGHT", AB.GetSpellNameByName("Death Gate"), AB.GetSpellNameByName("Death Gate"),
		"SHAMAN", AB.GetSpellNameByName("Astral Recall"), AB.GetSpellNameByName("Astral Recall"),
		"WARLOCK", AB.GetSpellNameByName("Ritual of Summoning"), AB.GetSpellNameByName("Ritual of Summoning"),
		"*", AB.GetSpellNameByName("Mole Machine"), AB.GetSpellNameByName("Mole Machine"),
	})

	AutoBarCategoryList["Spell.ChallengePortals"] = SpellsCategory:new("Spell.ChallengePortals", "spell_arcane_portalironforge", nil,
	{
		"*", AB.GetSpellNameByName("Path of the Jade Serpent"), AB.GetSpellNameByName("Path of the Jade Serpent"),
		"*", AB.GetSpellNameByName("Path of the Stout Brew"), AB.GetSpellNameByName("Path of the Stout Brew"),
		"*", AB.GetSpellNameByName("Path of the Shado-Pan"), AB.GetSpellNameByName("Path of the Shado-Pan"),
		"*", AB.GetSpellNameByName("Path of the Mogu King"), AB.GetSpellNameByName("Path of the Mogu King"),
		"*", AB.GetSpellNameByName("Path of the Setting Sun"), AB.GetSpellNameByName("Path of the Setting Sun"),
		"*", AB.GetSpellNameByName("Path of the Scarlet Blade"), AB.GetSpellNameByName("Path of the Scarlet Blade"),
		"*", AB.GetSpellNameByName("Path of the Scarlet Mitre"), AB.GetSpellNameByName("Path of the Scarlet Mitre"),
		"*", AB.GetSpellNameByName("Path of the Necromancer"), AB.GetSpellNameByName("Path of the Necromancer"),
		"*", AB.GetSpellNameByName("Path of the Black Ox"), AB.GetSpellNameByName("Path of the Black Ox"),
	})

	AutoBarCategoryList["Spell.AncientDalaranPortals"] = SpellsCategory:new("Spell.AncientDalaranPortals", spellIconList["Portal: Ancient Dalaran"], nil,
	{
		"MAGE", AB.GetSpellNameByName("Teleport: Ancient Dalaran"), AB.GetSpellNameByName("Portal: Ancient Dalaran"),
	})

	AutoBarCategoryList["Spell.Shields"] = SpellsCategory:new( "Spell.Shields", spellIconList["Ice Barrier"], nil,
	{
		"DEMONHUNTER",	 AB.GetSpellNameByName("Blur"), 	AB.GetSpellNameByName("Darkness"),
		"DEATHKNIGHT", AB.GetSpellNameByName("Anti-Magic Shell"), 	AB.GetSpellNameByName("Icebound Fortitude"),
		"DEATHKNIGHT", AB.GetSpellNameByName("Icebound Fortitude"), 	AB.GetSpellNameByName("Anti-Magic Shell"),
		"DRUID", 		AB.GetSpellNameByName("Barkskin"), 	AB.GetSpellNameByName("Barkskin"),
		"HUNTER", 		AB.GetSpellNameByName("Aspect of the Turtle"), 	AB.GetSpellNameByName("Aspect of the Turtle"),
		"MAGE", 			AB.GetSpellNameByName("Ice Barrier"), AB.GetSpellNameByName("Ice Barrier"),
		"MAGE", 			AB.GetSpellNameByName("Temporal Shield"), AB.GetSpellNameByName("Temporal Shield"),
		"MAGE", 			AB.GetSpellNameByName("Blazing Barrier"), AB.GetSpellNameByName("Blazing Barrier"),
		"MAGE", 			AB.GetSpellNameByName("Prismatic Barrier"), AB.GetSpellNameByName("Prismatic Barrier"),
		"MONK", 			AB.GetSpellNameByName("Fortifying Brew"), AB.GetSpellNameByName("Fortifying Brew"),
		"PALADIN", 		AB.GetSpellNameByName("Ardent Defender"), AB.GetSpellNameByName("Ardent Defender"),
		"PALADIN", 		AB.GetSpellNameByName("Divine Shield"), AB.GetSpellNameByName("Divine Shield"),
		"PRIEST", 		AB.GetSpellNameByName("Power Word: Shield"), AB.GetSpellNameByName("Power Word: Barrier"),
		"ROGUE", 		AB.GetSpellNameByName("Evasion"), 		AB.GetSpellNameByName("Evasion"),
		"WARLOCK", 		AB.GetSpellNameByName("Unending Resolve"), AB.GetSpellNameByName("Unending Resolve"),
		"WARRIOR", 		AB.GetSpellNameByName("Shield Block"), AB.GetSpellNameByName("Shield Wall"),
		"WARRIOR", 		AB.GetSpellNameByName("Shield Wall"), AB.GetSpellNameByName("Shield Block"),
	})

	AutoBarCategoryList["Spell.Stance"] = SpellsCategory:new( "Spell.Stance", spellIconList["Defensive Stance"], {
		"PALADIN", AB.GetSpellNameByName("Concentration Aura"),
		"PALADIN", AB.GetSpellNameByName("Crusader Aura"),
		"PALADIN", AB.GetSpellNameByName("Devotion Aura"),
		"PALADIN", AB.GetSpellNameByName("Retribution Aura"),
		"WARRIOR", AB.GetSpellNameByName("Defensive Stance"),
	})



	AutoBarCategoryList["Spell.Guild"] = SpellsCategory:new("Spell.Guild", spellIconList["Mobile Banking"],
	{
		"*", AB.GetSpellNameByName("Mobile Banking"),
	})


	AutoBarCategoryList["Spell.Totem.Earth"] = SpellsCategory:new("Spell.Totem.Earth", spellIconList["Earthgrab Totem"],
	{
		"SHAMAN", AB.GetSpellNameByName("Ancestral Protection Totem"),
		"SHAMAN", AB.GetSpellNameByName("Earthgrab Totem"),
		"SHAMAN", AB.GetSpellNameByName("Earthbind Totem"),
		"SHAMAN", AB.GetSpellNameByName("Earthen Wall Totem"),
	})


	AutoBarCategoryList["Spell.Totem.Air"] = SpellsCategory:new("Spell.Totem.Air", spellIconList["Wind Rush Totem"],
	{
		"SHAMAN", AB.GetSpellNameByName("Cloudburst Totem"),
		"SHAMAN", AB.GetSpellNameByName("Wind Rush Totem"),
	})

	AutoBarCategoryList["Spell.Totem.Fire"] = SpellsCategory:new("Spell.Totem.Fire", spellIconList["Liquid Magma Totem"],
	{
		"SHAMAN", AB.GetSpellNameByName("Liquid Magma Totem"),
	})

	AutoBarCategoryList["Spell.Totem.Water"] = SpellsCategory:new("Spell.Totem.Water", spellIconList["Healing Stream Totem"],
	{
		"SHAMAN", AB.GetSpellNameByName("Healing Stream Totem"),
		"SHAMAN", AB.GetSpellNameByName("Healing Tide Totem"),
		"SHAMAN", AB.GetSpellNameByName("Mana Tide Totem"),
		"SHAMAN", AB.GetSpellNameByName("Spirit Link Totem"),
	})


	AutoBarCategoryList["Spell.Buff.Weapon"] = SpellsCategory:new("Spell.Buff.Weapon", spellIconList["Deadly Poison"],
	{
		"ROGUE", AB.GetSpellNameByName("Deadly Poison"),
		"ROGUE", AB.GetSpellNameByName("Wound Poison"),
		"ROGUE", AB.GetSpellNameByName("Crippling Poison"),
	})

	AutoBarCategoryList["Spell.Crafting"] = SpellsCategory:new( "Spell.Crafting", spellIconList["First Aid"],
	{
		"*", AB.GetSpellNameByName("Alchemy"),
		"*", AB.GetSpellNameByName("Archaeology"),
		"*", AB.GetSpellNameByName("Cooking Fire"),
		"*", AB.GetSpellNameByName("Blacksmithing"),
		"*", AB.GetSpellNameByName("Cooking"),
		"*", AB.GetSpellNameByName("Disenchant"),
		"*", AB.GetSpellNameByName("Enchanting"),
		"*", AB.GetSpellNameByName("Engineering"),
		"*", AB.GetSpellNameByName("Inscription"),
		"*", AB.GetSpellNameByName("Jewelcrafting"),
		"*", AB.GetSpellNameByName("Leatherworking"),
		"*", AB.GetSpellNameByName("Milling"),
		"*", AB.GetSpellNameByName("Prospecting"),
		"*", AB.GetSpellNameByName("Smelting"),
		"*", AB.GetSpellNameByName("Survey"),
		"*", AB.GetSpellNameByName("Tailoring"),
		"*", AB.GetSpellNameByName("Skinning Journal"),
		"*", AB.GetSpellNameByName("Fishing Journal"),
		"*", AB.GetSpellNameByName("Herbalism Journal"),
		"*", AB.GetSpellNameByName("Mining Journal"),
		"DEATHKNIGHT", AB.GetSpellNameByName("Runeforging"),
	})

	AutoBarCategoryList["Spell.Archaeology"] = SpellsCategory:new("Spell.Archaeology", spellIconList["Archaeology"], nil,
	{
		"*",	AB.GetSpellNameByName("Survey"), AB.GetSpellNameByName("Archaeology"),
	})


	AutoBarCategoryList["Spell.Debuff.Multiple"] = SpellsCategory:new("Spell.Debuff.Multiple", spellIconList["Slow"],
	{
		"DRUID",		AB.GetSpellNameByName("Incapacitating Roar"),
		"HUNTER",	AB.GetSpellNameByName("Binding Shot"),
		"WARRIOR", AB.GetSpellNameByName("Demoralizing Shout"),
	})

	AutoBarCategoryList["Spell.Debuff.Single"] = SpellsCategory:new("Spell.Debuff.Single", spellIconList["Slow"],
	{
		"DEATHKNIGHT", AB.GetSpellNameByName("Chains of Ice"),
		"DRUID",	AB.GetSpellNameByName("Entangling Roots"),
		"HUNTER", AB.GetSpellNameByName("Concussive Shot"),
		"HUNTER", AB.GetSpellNameByName("Wing Clip"),
		"PALADIN", AB.GetSpellNameByName("Hand of Hindrance"),
		"WARLOCK", AB.GetSpellNameByName("Curse of Tongues"),
		"WARLOCK", AB.GetSpellNameByName("Curse of Weakness"),
		"WARLOCK", AB.GetSpellNameByName("Curse of Exhaustion"),
	})


	AutoBarCategoryList["Spell.Fishing"] = SpellsCategory:new("Spell.Fishing", spellIconList["Fishing"],
	{
		"*", AB.GetSpellNameByName("Fishing"),
		"*", AB.GetSpellNameByName("Undercurrent"),
	})



	AutoBarCategoryList["Spell.Trap"] = SpellsCategory:new( "Spell.Trap", spellIconList["Explosive Trap"],
	{
		"DEMONHUNTER", AB.GetSpellNameByName("Sigil of Flame"),
		"DEMONHUNTER", AB.GetSpellNameByName("Sigil of Misery"),
		"DEMONHUNTER", AB.GetSpellNameByName("Sigil of Silence"),
		"HUNTER", AB.GetSpellNameByName("Freezing Trap"),
		"HUNTER", AB.GetSpellNameByName("Tar Trap"),
		"HUNTER", AB.GetSpellNameByName("Steel Trap"),
	})


	AutoBarCategoryList["Misc.Mount.Summoned"] = SpellsCategory:new( "Misc.Mount.Summoned", spellIconList["Summon Dreadsteed"],
	{
		"DRUID", AB.GetSpellNameByName("Travel Form"),
		"SHAMAN", AB.GetSpellNameByName("Ghost Wolf"),
		"*", AB.GetSpellNameByName("Running Wild"),
	})
	AutoBarCategoryList["Misc.Mount.Summoned"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Mounts"] = SpellsCategory:new("Muffin.Mounts", spellIconList["Summon Dreadsteed"], nil, nil, "Muffin.Mounts." .. AutoBar.NiceClass)
	AutoBarCategoryList["Muffin.Mounts"]:SetNonCombat(true)

	AutoBarCategoryList["Spell.Charge"] = SpellsCategory:new( "Spell.Charge", spellIconList["Charge"],
	{
		"DEMONHUNTER", AB.GetSpellNameByName("Fel Rush"),
		"DRUID", AB.GetSpellNameByName("Wild Charge"),
		"HUNTER", AB.GetSpellNameByName("Harpoon"),
		"ROGUE", AB.GetSpellNameByName("Shadowstep"),
		"ROGUE", AB.GetSpellNameByName("Blade Rush"),
		"WARRIOR", AB.GetSpellNameByName("Charge"),
		"WARRIOR", AB.GetSpellNameByName("Intervene"),
	})

	AutoBarCategoryList["Spell.ER"] = SpellsCategory:new( "Spell.ER", spellIconList["Charge"],
	{
		"DEMONHUNTER", AB.GetSpellNameByName("Vengeful Retreat"),
		"DEATHKNIGHT", AB.GetSpellNameByName("Rune Tap"),
		"DRUID", AB.GetSpellNameByName("Frenzied Regeneration"),
		"HUNTER", AB.GetSpellNameByName("Feign Death"),
		"HUNTER", AB.GetSpellNameByName("Disengage"),
		"MAGE", AB.GetSpellNameByName("Ice Block"),
		"PALADIN", AB.GetSpellNameByName("Lay on Hands"),
		"PRIEST", AB.GetSpellNameByName("Dispersion"),
		"PRIEST", AB.GetSpellNameByName("Guardian Spirit"),
		"PRIEST", AB.GetSpellNameByName("Pain Suppression"),
		"ROGUE", AB.GetSpellNameByName("Vanish"),
		"WARLOCK", AB.GetSpellNameByName("Dark Pact"),
		"WARRIOR", AB.GetSpellNameByName("Last Stand"),
		"WARRIOR", AB.GetSpellNameByName("Enraged Regeneration"),
	})

	AutoBarCategoryList["Spell.Interrupt"] = SpellsCategory:new( "Spell.Interrupt", spellIconList["Charge"],
	{
		"DEATHKNIGHT", AB.GetSpellNameByName("Mind Freeze"),
		"DEMONHUNTER", AB.GetSpellNameByName("Disrupt"),
		"DRUID", AB.GetSpellNameByName("Skull Bash"),
		"HUNTER", AB.GetSpellNameByName("Counter Shot"),
		"MAGE", AB.GetSpellNameByName("Counterspell"),
		"MONK", AB.GetSpellNameByName("Spear Hand Strike"),
		"PALADIN", AB.GetSpellNameByName("Rebuke"),
		"PRIEST", AB.GetSpellNameByName("Silence"),
		"ROGUE", AB.GetSpellNameByName("Kick"),
		"SHAMAN", AB.GetSpellNameByName("Wind Shear"),
		"WARRIOR", AB.GetSpellNameByName("Pummel"),
	})

	AutoBarCategoryList["Spell.CatForm"] = SpellsCategory:new( "Spell.CatForm", spellIconList["Charge"],
	{
		"DRUID", AB.GetSpellNameByName("Cat Form"),
	})

	AutoBarCategoryList["Spell.BearForm"] = SpellsCategory:new( "Spell.BearForm", spellIconList["Charge"],
	{
		"DRUID", AB.GetSpellNameByName("Bear Form"),
	})

	AutoBarCategoryList["Spell.MoonkinForm"] = SpellsCategory:new( "Spell.MoonkinForm", spellIconList["Charge"],
	{
		"DRUID", AB.GetSpellNameByName("Moonkin Form"),
	})

	AutoBarCategoryList["Spell.TreeForm"] = SpellsCategory:new( "Spell.TreeForm", spellIconList["Charge"],
	{
		"DRUID", AB.GetSpellNameByName("Treant Form"),
	})

	AutoBarCategoryList["Spell.StagForm"] = SpellsCategory:new( "Spell.StagForm", spellIconList["Charge"],
	{
		"DRUID", AB.GetSpellNameByName("Mount Form"),
	})

	AutoBarCategoryList["Spell.Travel"] = SpellsCategory:new( "Spell.Travel", spellIconList["Charge"],
	{
		"DRUID", AB.GetSpellNameByName("Travel Form"),
		"SHAMAN", AB.GetSpellNameByName("Ghost Wolf"),
	})

end

