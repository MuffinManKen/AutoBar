local AutoBar = AutoBar
local ABGCode = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject
local spellIconList = ABGData.spell_icon_list
local L = AutoBarGlobalDataObject.locale



function ABGCode:InitializeCategories()

	AutoBarCategoryList["Dynamic.Quest"] = AutoBarItems:new("Dynamic.Quest", "INV_Misc_Rune_01", nil)

	AutoBarCategoryList["Muffin.Toys.Hearth"] = AutoBarToyCategory:new( "Muffin.Toys.Hearth", spellIconList["Puntable Marmot"], "Muffin.Toys.Hearth")
	AutoBarCategoryList["Muffin.Toys.Pet Battle"] = AutoBarToyCategory:new( "Muffin.Toys.Pet Battle", spellIconList["Puntable Marmot"], "Muffin.Toys.Pet Battle")
	AutoBarCategoryList["Muffin.Toys.Companion Pet.Ornamental"] = AutoBarToyCategory:new( "Muffin.Toys.Companion Pet.Ornamental", spellIconList["Puntable Marmot"], "Muffin.Toys.Companion Pet.Ornamental")
	AutoBarCategoryList["Muffin.Toys.Portal"] = AutoBarToyCategory:new( "Muffin.Toys.Portal", "ability_siege_engineer_pattern_recognition", "Muffin.Toys.Portal")
	AutoBarCategoryList["Muffin.Toys.Fishing"] = AutoBarToyCategory:new( "Muffin.Toys.Fishing", "INV_Fishingpole_01", "Muffin.Toys.Fishing")

	AutoBarCategoryList["Macro.Mount.SummonRandomFave"] = AutoBarMacroTextCategory:new( "Macro.Mount.SummonRandomFave", "achievement_guildperk_mountup")
	AutoBarCategoryList["Macro.Mount.SummonRandomFave"]:AddMacroText("/run C_MountJournal.SummonByID(0)",  "Interface/Icons/achievement_guildperk_mountup", L["Summon A Random Favourite Mount"])

	AutoBarCategoryList["Macro.BattlePet.SummonRandom"] = AutoBarMacroTextCategory:new( "Macro.BattlePet.SummonRandom", "INV_MISC_QUESTIONMARK")
	AutoBarCategoryList["Macro.BattlePet.SummonRandom"]:AddMacroText("/randompet",  "Interface/Icons/INV_MISC_QUESTIONMARK", L["Summon A Random Pet"])

	AutoBarCategoryList["Macro.BattlePet.SummonRandomFave"] = AutoBarMacroTextCategory:new( "Macro.BattlePet.SummonRandomFave", "PetBattle_Health")
	AutoBarCategoryList["Macro.BattlePet.SummonRandomFave"]:AddMacroText("/randomfavoritepet",  "Interface/Icons/PetBattle_Health", L["Summon A Random Fave Pet"])

	AutoBarCategoryList["Macro.BattlePet.DismissPet"] = AutoBarMacroTextCategory:new( "Macro.BattlePet.DismissPet", "Spell_BrokenHeart")
	AutoBarCategoryList["Macro.BattlePet.DismissPet"]:AddMacroText("/dismisspet",  "Interface/Icons/Spell_BrokenHeart", L["Dismiss Battle Pet"])

	AutoBarCategoryList["Muffin.Battle Pet Items.Upgrade"] = AutoBarItems:new("Muffin.Battle Pet Items.Upgrade", "INV_BannerPVP_02", "Muffin.Battle Pet Items.Upgrade")
	AutoBarCategoryList["Muffin.Battle Pet Items.Level"] = AutoBarItems:new("Muffin.Battle Pet Items.Level", "INV_BannerPVP_02", "Muffin.Battle Pet Items.Level")
	AutoBarCategoryList["Muffin.Battle Pet Items.Bandages"] = AutoBarItems:new("Muffin.Battle Pet Items.Bandages", "INV_BannerPVP_02", "Muffin.Battle Pet Items.Bandages")
	AutoBarCategoryList["Muffin.Battle Pet Items.Pet Treat"] = AutoBarItems:new("Muffin.Battle Pet Items.Pet Treat", "INV_BannerPVP_02", "Muffin.Battle Pet Items.Pet Treat")

	AutoBarCategoryList["Spell.Pet Battle"] = AutoBarSpells:new("Spell.Pet Battle", spellIconList["Conjure Refreshment"],
	{
		"*", ABGCode:GetSpellNameByName("Revive Battle Pets"),
	})

	AutoBarCategoryList["Muffin.Skill.Archaeology.Crate"] = AutoBarItems:new( "Muffin.Skill.Archaeology.Crate", "INV_Misc_Food_26", "Muffin.Skill.Archaeology.Crate")
	AutoBarCategoryList["Muffin.Skill.Archaeology.Mission"] = AutoBarItems:new( "Muffin.Skill.Archaeology.Mission", "INV_Misc_Food_26", "Muffin.Skill.Archaeology.Mission")

	AutoBarCategoryList["Muffin.SunSongRanch"] = AutoBarItems:new("Muffin.SunSongRanch", "INV_Potion_76", "Muffin.SunSongRanch")

	AutoBarCategoryList["Muffin.Garrison"] = AutoBarItems:new("Muffin.Garrison", "INV_Potion_76", "Muffin.Garrison")

	AutoBarCategoryList["Muffin.Order Hall.Artifact Power"] = AutoBarItems:new("Muffin.Order Hall.Artifact Power", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Artifact Power")
	AutoBarCategoryList["Muffin.Order Hall.Nethershard"] = AutoBarItems:new("Muffin.Order Hall.Nethershard", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Nethershard")
	AutoBarCategoryList["Muffin.Order Hall.Troop Recruit"] = AutoBarItems:new("Muffin.Order Hall.Troop Recruit", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Troop Recruit")
	AutoBarCategoryList["Muffin.Order Hall.Buff"] = AutoBarItems:new("Muffin.Order Hall.Buff", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Buff")
	AutoBarCategoryList["Muffin.Order Hall.Champion"] = AutoBarItems:new("Muffin.Order Hall.Champion", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Champion")
	AutoBarCategoryList["Muffin.Order Hall.Ancient Mana"] = AutoBarItems:new("Muffin.Order Hall.Ancient Mana", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Ancient Mana")
	AutoBarCategoryList["Muffin.Order Hall.Order Resources"] = AutoBarItems:new("Muffin.Order Hall.Order Resources", "archaeology_5_0_mogucoin", "Muffin.Order Hall.Order Resources")

	AutoBarCategoryList["Spell.Warlock.Create Healthstone"] = AutoBarSpells:new( "Spell.Warlock.Create Healthstone", spellIconList["Create Healthstone"], nil,
	{
		"WARLOCK", ABGCode:GetSpellNameByName("Create Healthstone"), ABGCode:GetSpellNameByName("Ritual of Souls"),
	})

	AutoBarCategoryList["Spell.Mage.Conjure Food"] = AutoBarSpells:new( "Spell.Mage.Conjure Food", spellIconList["Conjure Refreshment"], nil, {
		"MAGE", ABGCode:GetSpellNameByName("Conjure Refreshment"), ABGCode:GetSpellNameByName("Conjure Refreshment Table"),
	})

	AutoBarCategoryList["Consumable.Water.Conjure"] = AutoBarSpells:new("Consumable.Water.Conjure", spellIconList["Conjure Refreshment"], {
			"MAGE", ABGCode:GetSpellNameByName("Conjure Refreshment"),
			})

	AutoBarCategoryList["Consumable.Food.Conjure"] = AutoBarSpells:new("Consumable.Food.Conjure", spellIconList["Conjure Refreshment"], {
			"MAGE", ABGCode:GetSpellNameByName("Conjure Refreshment"),
			})


	AutoBarCategoryList["Spell.Stealth"] = AutoBarSpells:new("Spell.Stealth", spellIconList["Stealth"],
	{
		"DRUID", ABGCode:GetSpellNameByName("Prowl"),
		"HUNTER", ABGCode:GetSpellNameByName("Camouflage"),
		"MAGE", ABGCode:GetSpellNameByName("Greater Invisibility"),
		"MAGE", ABGCode:GetSpellNameByName("Invisibility"),
		"ROGUE", ABGCode:GetSpellNameByName("Stealth"),
		"*", ABGCode:GetSpellNameByName("Shadowmeld"),
	})


	AutoBarCategoryList["Spell.Aspect"] = AutoBarSpells:new("Spell.Aspect", spellIconList["Aspect of the Cheetah"],
	{
		"HUNTER", ABGCode:GetSpellNameByName("Aspect of the Cheetah"),
		"HUNTER", ABGCode:GetSpellNameByName("Aspect of the Chameleon"),
		"HUNTER", ABGCode:GetSpellNameByName("Aspect of the Turtle"),
		"HUNTER", ABGCode:GetSpellNameByName("Aspect of the Eagle"),
		"HUNTER", ABGCode:GetSpellNameByName("Aspect of the Wild"),
	})


	AutoBarCategoryList["Spell.Poison.Lethal"] = AutoBarSpells:new( "Spell.Poison.Lethal", spellIconList["Deadly Poison"], {
		"ROGUE", ABGCode:GetSpellNameByName("Deadly Poison"),
		"ROGUE", ABGCode:GetSpellNameByName("Wound Poison"),
	})

	AutoBarCategoryList["Spell.Poison.Nonlethal"] = AutoBarSpells:new( "Spell.Poison.Nonlethal", spellIconList["Crippling Poison"],
	{
		"ROGUE", ABGCode:GetSpellNameByName("Crippling Poison"),
		"ROGUE", ABGCode:GetSpellNameByName("Leeching Poison"),
	})



	AutoBarCategoryList["Spell.Class.Buff"] = AutoBarSpells:new( "Spell.Class.Buff", spellIconList["Barkskin"],
	{
		"DEATHKNIGHT", ABGCode:GetSpellNameByName("Path of Frost"),
		"DRUID", ABGCode:GetSpellNameByName("Ironbark"),
		"MAGE", ABGCode:GetSpellNameByName("Slow Fall"),
		"PALADIN", ABGCode:GetSpellNameByName("Blessing of Freedom"),
		"PALADIN", ABGCode:GetSpellNameByName("Blessing of Protection"),
		"PALADIN", ABGCode:GetSpellNameByName("Blessing of Sacrifice"),
		"PALADIN", ABGCode:GetSpellNameByName("Blessing of Spellwarding"),
		"PALADIN", ABGCode:GetSpellNameByName("Blessing of Salvation"),
		"PALADIN", ABGCode:GetSpellNameByName("Greater Blessing of Kings"),
		"PALADIN", ABGCode:GetSpellNameByName("Greater Blessing of Wisdom"),
		"PRIEST", ABGCode:GetSpellNameByName("Levitate"),
		"PRIEST", ABGCode:GetSpellNameByName("Power Word: Fortitude"),
		"SHAMAN", ABGCode:GetSpellNameByName("Water Walking"),
		"WARLOCK", ABGCode:GetSpellNameByName("Unending Breath"),
		"WARLOCK", ABGCode:GetSpellNameByName("Soulstone"),
		"WARRIOR", ABGCode:GetSpellNameByName("Commanding Shout"),
		"WARRIOR", ABGCode:GetSpellNameByName("Demoralizing Shout"),
	})

	AutoBarCategoryList["Spell.Class.Pet"] = AutoBarSpells:new( "Spell.Class.Pet", spellIconList["Call Pet 1"],
	{
		"DEATHKNIGHT", ABGCode:GetSpellNameByName("Rune Weapon"),
		"DEATHKNIGHT", ABGCode:GetSpellNameByName("Raise Dead"),
		"DEATHKNIGHT", ABGCode:GetSpellNameByName("Army of the Dead"),
		"DEATHKNIGHT", ABGCode:GetSpellNameByName("Summon Gargoyle"),
		"HUNTER", ABGCode:GetSpellNameByName("Call Pet 1"),
		"HUNTER", ABGCode:GetSpellNameByName("Call Pet 2"),
		"HUNTER", ABGCode:GetSpellNameByName("Call Pet 3"),
		"HUNTER", ABGCode:GetSpellNameByName("Call Pet 4"),
		"HUNTER", ABGCode:GetSpellNameByName("Call Pet 5"),
		"MAGE", ABGCode:GetSpellNameByName("Summon Water Elemental"),
		"MONK", ABGCode:GetSpellNameByName("Storm, Earth, and Fire"),
		"PRIEST", ABGCode:GetSpellNameByName("Shadowfiend"),
		"SHAMAN", ABGCode:GetSpellNameByName("Earth Elemental"),
		"SHAMAN", ABGCode:GetSpellNameByName("Fire Elemental"),
		"SHAMAN", ABGCode:GetSpellNameByName("Storm Elemental"),
		"SHAMAN", ABGCode:GetSpellNameByName("Feral Spirit"),
		"WARLOCK", ABGCode:GetSpellNameByName("Eye of Kilrogg"),
		"WARLOCK", ABGCode:GetSpellNameByName("Summon Infernal"),
		"WARLOCK", ABGCode:GetSpellNameByName("Summon Felguard"),
		"WARLOCK", ABGCode:GetSpellNameByName("Summon Felhunter"),
		"WARLOCK", ABGCode:GetSpellNameByName("Summon Imp"),
		"WARLOCK", ABGCode:GetSpellNameByName("Summon Succubus"),
		"WARLOCK", ABGCode:GetSpellNameByName("Summon Voidwalker"),
	})



	AutoBarCategoryList["Spell.Class.Pets2"] = AutoBarSpells:new( "Spell.Class.Pets2", spellIconList["Call Pet 1"],
	{
		"DEATHKNIGHT", ABGCode:GetSpellNameByName("Dark Transformation"),
		"HUNTER", ABGCode:GetSpellNameByName("Kill Command"),
		"HUNTER", ABGCode:GetSpellNameByName("Bestial Wrath"),
		"HUNTER", ABGCode:GetSpellNameByName("Dire Beast"),
		"HUNTER", ABGCode:GetSpellNameByName("Dire Frenzy"),
		"HUNTER", ABGCode:GetSpellNameByName("Master's Call"),
		"HUNTER", ABGCode:GetSpellNameByName("Mend Pet"),
		"HUNTER", ABGCode:GetSpellNameByName("Intimidation"),
		"WARLOCK", ABGCode:GetSpellNameByName("Command Demon"),
		"WARLOCK", ABGCode:GetSpellNameByName("Call Dreadstalkers"),
		"WARLOCK", ABGCode:GetSpellNameByName("Grimoire of Sacrifice"),
		"WARLOCK", ABGCode:GetSpellNameByName("Demonic Empowerment"),
		"WARLOCK", ABGCode:GetSpellNameByName("Demonwrath"),
		"WARLOCK", ABGCode:GetSpellNameByName("Summon Darkglare"),
	})

	--Misc pet abilities
	AutoBarCategoryList["Spell.Class.Pets3"] = AutoBarSpells:new(	"Spell.Class.Pets3", spellIconList["Feed Pet"],
	{
		"HUNTER", ABGCode:GetSpellNameByName("Dismiss Pet"),
		"HUNTER", ABGCode:GetSpellNameByName("Eagle Eye"),
		"HUNTER", ABGCode:GetSpellNameByName("Feed Pet"),
		"HUNTER", ABGCode:GetSpellNameByName("Revive Pet"),
		"HUNTER", ABGCode:GetSpellNameByName("Tame Beast"),
		"HUNTER", ABGCode:GetSpellNameByName("Beast Lore"),
		"HUNTER", ABGCode:GetSpellNameByName("Fetch"),
		"HUNTER", ABGCode:GetSpellNameByName("Play Dead"),
		"HUNTER", ABGCode:GetSpellNameByName("Wake Up"),
	})



	AutoBarCategoryList["Spell.Portals"] = AutoBarSpells:new( "Spell.Portals", "spell_arcane_portalironforge", nil,
	{
		"DRUID", ABGCode:GetSpellNameByName("Teleport: Moonglade"), ABGCode:GetSpellNameByName("Teleport: Moonglade"),
		"DRUID", ABGCode:GetSpellNameByName("Dreamwalk"), ABGCode:GetSpellNameByName("Dreamwalk"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Stonard"), ABGCode:GetSpellNameByName("Portal: Stonard"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Theramore"), ABGCode:GetSpellNameByName("Portal: Theramore"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Undercity"), ABGCode:GetSpellNameByName("Portal: Undercity"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Thunder Bluff"), ABGCode:GetSpellNameByName("Portal: Thunder Bluff"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Stormwind"), ABGCode:GetSpellNameByName("Portal: Stormwind"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Silvermoon"), ABGCode:GetSpellNameByName("Portal: Silvermoon"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Exodar"), ABGCode:GetSpellNameByName("Portal: Exodar"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Darnassus"), ABGCode:GetSpellNameByName("Portal: Darnassus"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Ironforge"), ABGCode:GetSpellNameByName("Portal: Ironforge"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Orgrimmar"), ABGCode:GetSpellNameByName("Portal: Orgrimmar"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Shattrath"), ABGCode:GetSpellNameByName("Portal: Shattrath"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Dalaran"), ABGCode:GetSpellNameByName("Portal: Dalaran"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Dalaran - Broken Isles"), ABGCode:GetSpellNameByName("Portal: Dalaran - Broken Isles"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Tol Barad - Horde"), ABGCode:GetSpellNameByName("Portal: Tol Barad - Horde"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Tol Barad - Alliance"), ABGCode:GetSpellNameByName("Portal: Tol Barad - Alliance"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Vale of Eternal Blossoms - Alliance"), ABGCode:GetSpellNameByName("Portal: Vale of Eternal Blossoms - Alliance"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Vale of Eternal Blossoms - Horde"), ABGCode:GetSpellNameByName("Portal: Vale of Eternal Blossoms - Horde"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Stormshield"), ABGCode:GetSpellNameByName("Portal: Stormshield"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Warspear"), ABGCode:GetSpellNameByName("Portal: Warspear"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Hall of the Guardian"), ABGCode:GetSpellNameByName("Teleport: Hall of the Guardian"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Boralus"), ABGCode:GetSpellNameByName("Portal: Boralus"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Dazar'alor"), ABGCode:GetSpellNameByName("Portal: Dazar'alor"),
		"MONK", ABGCode:GetSpellNameByName("Zen Pilgrimage"), ABGCode:GetSpellNameByName("Zen Pilgrimage"),
		"MONK", ABGCode:GetSpellNameByName("Zen Pilgrimage: Return"), ABGCode:GetSpellNameByName("Zen Pilgrimage: Return"),
		"DEATHKNIGHT", ABGCode:GetSpellNameByName("Death Gate"), ABGCode:GetSpellNameByName("Death Gate"),
		"SHAMAN", ABGCode:GetSpellNameByName("Astral Recall"), ABGCode:GetSpellNameByName("Astral Recall"),
		"WARLOCK", ABGCode:GetSpellNameByName("Ritual of Summoning"), ABGCode:GetSpellNameByName("Ritual of Summoning"),
		"*", ABGCode:GetSpellNameByName("Mole Machine"), ABGCode:GetSpellNameByName("Mole Machine"),
		"*", ABGCode:GetSpellNameByName("Path of the Jade Serpent"), ABGCode:GetSpellNameByName("Path of the Jade Serpent"),
		"*", ABGCode:GetSpellNameByName("Path of the Stout Brew"), ABGCode:GetSpellNameByName("Path of the Stout Brew"),
		"*", ABGCode:GetSpellNameByName("Path of the Shado-Pan"), ABGCode:GetSpellNameByName("Path of the Shado-Pan"),
		"*", ABGCode:GetSpellNameByName("Path of the Mogu King"), ABGCode:GetSpellNameByName("Path of the Mogu King"),
		"*", ABGCode:GetSpellNameByName("Path of the Setting Sun"), ABGCode:GetSpellNameByName("Path of the Setting Sun"),
		"*", ABGCode:GetSpellNameByName("Path of the Scarlet Blade"), ABGCode:GetSpellNameByName("Path of the Scarlet Blade"),
		"*", ABGCode:GetSpellNameByName("Path of the Scarlet Mitre"), ABGCode:GetSpellNameByName("Path of the Scarlet Mitre"),
		"*", ABGCode:GetSpellNameByName("Path of the Necromancer"), ABGCode:GetSpellNameByName("Path of the Necromancer"),
		"*", ABGCode:GetSpellNameByName("Path of the Black Ox"), ABGCode:GetSpellNameByName("Path of the Black Ox"),
	})


	AutoBarCategoryList["Spell.AncientDalaranPortals"] = AutoBarSpells:new("Spell.AncientDalaranPortals", spellPortalShattrathIcon, nil,
	{
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Ancient Dalaran"), ABGCode:GetSpellNameByName("Portal: Ancient Dalaran"),
	})

	AutoBarCategoryList["Spell.Shields"] = AutoBarSpells:new( "Spell.Shields", spellIconList["Ice Barrier"], nil,
	{
		"DEMONHUNTER",	 ABGCode:GetSpellNameByName("Blur"), 	ABGCode:GetSpellNameByName("Darkness"),
		"DEATHKNIGHT", ABGCode:GetSpellNameByName("Anti-Magic Shell"), 	ABGCode:GetSpellNameByName("Icebound Fortitude"),
		"DEATHKNIGHT", ABGCode:GetSpellNameByName("Icebound Fortitude"), 	ABGCode:GetSpellNameByName("Anti-Magic Shell"),
		"DRUID", 		ABGCode:GetSpellNameByName("Barkskin"), 	ABGCode:GetSpellNameByName("Barkskin"),
		"HUNTER", 		ABGCode:GetSpellNameByName("Aspect of the Turtle"), 	ABGCode:GetSpellNameByName("Aspect of the Turtle"),
		"MAGE", 			ABGCode:GetSpellNameByName("Ice Barrier"), ABGCode:GetSpellNameByName("Ice Barrier"),
		"MAGE", 			ABGCode:GetSpellNameByName("Temporal Shield"), ABGCode:GetSpellNameByName("Temporal Shield"),
		"MAGE", 			ABGCode:GetSpellNameByName("Blazing Barrier"), ABGCode:GetSpellNameByName("Blazing Barrier"),
		"MAGE", 			ABGCode:GetSpellNameByName("Prismatic Barrier"), ABGCode:GetSpellNameByName("Prismatic Barrier"),
		"MONK", 			ABGCode:GetSpellNameByName("Fortifying Brew"), ABGCode:GetSpellNameByName("Fortifying Brew"),
		"PALADIN", 		ABGCode:GetSpellNameByName("Ardent Defender"), ABGCode:GetSpellNameByName("Ardent Defender"),
		"PALADIN", 		ABGCode:GetSpellNameByName("Divine Shield"), ABGCode:GetSpellNameByName("Divine Shield"),
		"PRIEST", 		ABGCode:GetSpellNameByName("Power Word: Shield"), ABGCode:GetSpellNameByName("Power Word: Barrier"),
		"ROGUE", 		ABGCode:GetSpellNameByName("Evasion"), 		ABGCode:GetSpellNameByName("Evasion"),
		"ROGUE", 		ABGCode:GetSpellNameByName("Riposte"), 		ABGCode:GetSpellNameByName("Riposte"),
		"WARLOCK", 		ABGCode:GetSpellNameByName("Unending Resolve"), ABGCode:GetSpellNameByName("Unending Resolve"),
		"WARRIOR", 		ABGCode:GetSpellNameByName("Shield Block"), ABGCode:GetSpellNameByName("Shield Wall"),
		"WARRIOR", 		ABGCode:GetSpellNameByName("Shield Wall"), ABGCode:GetSpellNameByName("Shield Block"),
	})

	AutoBarCategoryList["Spell.Stance"] = AutoBarSpells:new( "Spell.Stance", spellIconList["Defensive Stance"], {
		"WARRIOR", ABGCode:GetSpellNameByName("Defensive Stance"),
	})



	AutoBarCategoryList["Spell.Guild"] = AutoBarSpells:new("Spell.Guild", iconMobileBanking,
	{
		"*", ABGCode:GetSpellNameByName("Mobile Banking"),
	})


	AutoBarCategoryList["Spell.Totem.Earth"] = AutoBarSpells:new("Spell.Totem.Earth", spellIconList["Earthgrab Totem"],
	{
		"SHAMAN", ABGCode:GetSpellNameByName("Earthgrab Totem"),
		"SHAMAN", ABGCode:GetSpellNameByName("Earthbind Totem"),
		"SHAMAN", ABGCode:GetSpellNameByName("Ancestral Protection Totem"),
		"SHAMAN", ABGCode:GetSpellNameByName("Earthen Shield Totem"),
		"SHAMAN", ABGCode:GetSpellNameByName("Earthquake Totem"),
	})


	AutoBarCategoryList["Spell.Totem.Air"] = AutoBarSpells:new("Spell.Totem.Air", spellIconList["Wind Rush Totem"],
	{
		"SHAMAN", ABGCode:GetSpellNameByName("Wind Rush Totem"),
		"SHAMAN", ABGCode:GetSpellNameByName("Lightning Surge Totem"),
		"SHAMAN", ABGCode:GetSpellNameByName("Voodoo Totem"),
		"SHAMAN", ABGCode:GetSpellNameByName("Cloudburst Totem"),
	})

	AutoBarCategoryList["Spell.Totem.Fire"] = AutoBarSpells:new("Spell.Totem.Fire", spellIconList["Liquid Magma Totem"],
	{
		"SHAMAN", ABGCode:GetSpellNameByName("Liquid Magma Totem"),
	})

	AutoBarCategoryList["Spell.Totem.Water"] = AutoBarSpells:new("Spell.Totem.Water", spellIconList["Healing Stream Totem"],
	{
		"SHAMAN", ABGCode:GetSpellNameByName("Healing Stream Totem"),
		"SHAMAN", ABGCode:GetSpellNameByName("Healing Tide Totem"),
		"SHAMAN", ABGCode:GetSpellNameByName("Spirit Link Totem"),
	})


	AutoBarCategoryList["Spell.Buff.Weapon"] = AutoBarSpells:new("Spell.Buff.Weapon", spellIconList["Deadly Poison"],
	{
		"ROGUE", ABGCode:GetSpellNameByName("Deadly Poison"),
		"ROGUE", ABGCode:GetSpellNameByName("Wound Poison"),
		"ROGUE", ABGCode:GetSpellNameByName("Crippling Poison"),
		"ROGUE", ABGCode:GetSpellNameByName("Leeching Poison"),
	})

	AutoBarCategoryList["Spell.Crafting"] = AutoBarSpells:new( "Spell.Crafting", spellIconList["First Aid"],
	{
		"*", ABGCode:GetSpellNameByName("Alchemy"),
		"*", ABGCode:GetSpellNameByName("Archaeology"),
		"*", ABGCode:GetSpellNameByName("BasicCampfire"),
		"*", ABGCode:GetSpellNameByName("Blacksmithing"),
		"*", ABGCode:GetSpellNameByName("Cooking"),
		"*", ABGCode:GetSpellNameByName("Disenchant"),
		"*", ABGCode:GetSpellNameByName("Enchanting"),
		"*", ABGCode:GetSpellNameByName("Engineering"),
		"*", ABGCode:GetSpellNameByName("First Aid"),
		"*", ABGCode:GetSpellNameByName("Inscription"),
		"*", ABGCode:GetSpellNameByName("Jewelcrafting"),
		"*", ABGCode:GetSpellNameByName("Leatherworking"),
		"*", ABGCode:GetSpellNameByName("Milling"),
		"*", ABGCode:GetSpellNameByName("Prospecting"),
		"*", ABGCode:GetSpellNameByName("Smelting"),
		"*", ABGCode:GetSpellNameByName("Survey"),
		"*", ABGCode:GetSpellNameByName("Tailoring"),
		"DEATHKNIGHT", ABGCode:GetSpellNameByName("Runeforging"),
	})

	AutoBarCategoryList["Spell.Archaeology"] = AutoBarSpells:new("Spell.Archaeology", spellIconList["Archaeology"],
	{
		"*",	ABGCode:GetSpellNameByName("Archaeology"),
		"*",	ABGCode:GetSpellNameByName("Survey"),
	})


	AutoBarCategoryList["Spell.Debuff.Multiple"] = AutoBarSpells:new("Spell.Debuff.Multiple", spellIconList["Slow"],
	{
		"DRUID",		ABGCode:GetSpellNameByName("Disorienting Roar"),
		"HUNTER",	ABGCode:GetSpellNameByName("Binding Shot"),
		"HUNTER",	ABGCode:GetSpellNameByName("Sentinel"),
	})

	AutoBarCategoryList["Spell.Debuff.Single"] = AutoBarSpells:new("Spell.Debuff.Single", spellIconList["Slow"],
	{
		"DEATHKNIGHT", ABGCode:GetSpellNameByName("Chains of Ice"),
		"HUNTER", ABGCode:GetSpellNameByName("Concussive Shot"),
		"HUNTER", ABGCode:GetSpellNameByName("Wing Clip"),
		"HUNTER", ABGCode:GetSpellNameByName("Ranger's Net"),
		"PALADIN", ABGCode:GetSpellNameByName("Hand of Hindrance"),
		"WARLOCK", ABGCode:GetSpellNameByName("Curse of Tongues"),
		"WARLOCK", ABGCode:GetSpellNameByName("Curse of Weakness"),
		"WARLOCK", ABGCode:GetSpellNameByName("Curse of Fragility"),
	})


	AutoBarCategoryList["Spell.Fishing"] = AutoBarSpells:new("Spell.Fishing", spellIconList["Fishing"],
	{
		"*", ABGCode:GetSpellNameByName("Fishing"),
		"*", ABGCode:GetSpellNameByName("Undercurrent"),
	})



	AutoBarCategoryList["Spell.Trap"] = AutoBarSpells:new( "Spell.Trap", spellIconList["Explosive Trap"],
	{
		"DEMONHUNTER", ABGCode:GetSpellNameByName("Sigil of Flame"),
		"DEMONHUNTER", ABGCode:GetSpellNameByName("Sigil of Misery"),
		"DEMONHUNTER", ABGCode:GetSpellNameByName("Sigil of Silence"),
		"HUNTER", ABGCode:GetSpellNameByName("Explosive Trap"),
		"HUNTER", ABGCode:GetSpellNameByName("Freezing Trap"),
		"HUNTER", ABGCode:GetSpellNameByName("Caltrops"),
		"HUNTER", ABGCode:GetSpellNameByName("Tar Trap"),
		"HUNTER", ABGCode:GetSpellNameByName("Steel Trap"),
	})


	AutoBarCategoryList["Misc.Mount.Summoned"] = AutoBarSpells:new( "Misc.Mount.Summoned", spellIconList["Summon Dreadsteed"],
	{
		"DRUID", ABGCode:GetSpellNameByName("Flight Form"),
		"DRUID", ABGCode:GetSpellNameByName("Swift Flight Form"),
		"SHAMAN", ABGCode:GetSpellNameByName("Ghost Wolf"),
		"*", ABGCode:GetSpellNameByName("Running Wild"),
	})
	AutoBarCategoryList["Misc.Mount.Summoned"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Mounts"] = AutoBarSpells:new("Muffin.Mounts", spellIconList["Summon Dreadsteed"], nil, nil, "Muffin.Mounts." .. AutoBar.NiceClass)
	AutoBarCategoryList["Muffin.Mounts"]:SetNonCombat(true)

	AutoBarCategoryList["Spell.Charge"] = AutoBarSpells:new( "Spell.Charge", spellIconList["Charge"],
	{
		"DEMONHUNTER", ABGCode:GetSpellNameByName("Fel Rush"),
		"DRUID", ABGCode:GetSpellNameByName("Wild Charge"),
		"HUNTER", ABGCode:GetSpellNameByName("Harpoon"),
		"ROGUE", ABGCode:GetSpellNameByName("Shadowstep"),
		"WARRIOR", ABGCode:GetSpellNameByName("Charge"),
		"WARRIOR", ABGCode:GetSpellNameByName("Intercept"),
	})

	AutoBarCategoryList["Spell.ER"] = AutoBarSpells:new( "Spell.ER", spellIconList["Charge"],
	{
		"DEMONHUNTER", ABGCode:GetSpellNameByName("Vengeful Retreat"),
		"DEATHKNIGHT", ABGCode:GetSpellNameByName("Rune Tap"),
		"DRUID", ABGCode:GetSpellNameByName("Frenzied Regeneration"),
		"HUNTER", ABGCode:GetSpellNameByName("Feign Death"),
		"HUNTER", ABGCode:GetSpellNameByName("Disengage"),
		"MAGE", ABGCode:GetSpellNameByName("Ice Block"),
		"PALADIN", ABGCode:GetSpellNameByName("Lay on Hands"),
		"PRIEST", ABGCode:GetSpellNameByName("Dispersion"),
		"PRIEST", ABGCode:GetSpellNameByName("Guardian Spirit"),
		"PRIEST", ABGCode:GetSpellNameByName("Pain Suppression"),
		"ROGUE", ABGCode:GetSpellNameByName("Vanish"),
		"WARLOCK", ABGCode:GetSpellNameByName("Dark Pact"),
		"WARRIOR", ABGCode:GetSpellNameByName("Last Stand"),
		"WARRIOR", ABGCode:GetSpellNameByName("Enraged Regeneration"),
	})

	AutoBarCategoryList["Spell.Interrupt"] = AutoBarSpells:new( "Spell.Interrupt", spellIconList["Charge"],
	{
		"DEATHKNIGHT", ABGCode:GetSpellNameByName("Mind Freeze"),
		"DEMONHUNTER", ABGCode:GetSpellNameByName("Consume Magic"),
		"DRUID", ABGCode:GetSpellNameByName("Skull Bash"),
		"HUNTER", ABGCode:GetSpellNameByName("Counter Shot"),
		"MAGE", ABGCode:GetSpellNameByName("Counterspell"),
		"MONK", ABGCode:GetSpellNameByName("Spear Hand Strike"),
		"PALADIN", ABGCode:GetSpellNameByName("Rebuke"),
		"PRIEST", ABGCode:GetSpellNameByName("Silence"),
		"ROGUE", ABGCode:GetSpellNameByName("Kick"),
		"SHAMAN", ABGCode:GetSpellNameByName("Wind Shear"),
		"WARLOCK", ABGCode:GetSpellNameByName("Grimoire: Felhunter"),
		"WARRIOR", ABGCode:GetSpellNameByName("Pummel"),
	})

	AutoBarCategoryList["Spell.CatForm"] = AutoBarSpells:new( "Spell.CatForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode:GetSpellNameByName("Cat Form"),
	})

	AutoBarCategoryList["Spell.BearForm"] = AutoBarSpells:new( "Spell.BearForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode:GetSpellNameByName("Bear Form"),
	})

	AutoBarCategoryList["Spell.MoonkinForm"] = AutoBarSpells:new( "Spell.MoonkinForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode:GetSpellNameByName("Moonkin Form"),
	})

	AutoBarCategoryList["Spell.TreeForm"] = AutoBarSpells:new( "Spell.TreeForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode:GetSpellNameByName("Treant Form"),
	})

	AutoBarCategoryList["Spell.StagForm"] = AutoBarSpells:new( "Spell.StagForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode:GetSpellNameByName("Stag Form"),
	})

	AutoBarCategoryList["Spell.Travel"] = AutoBarSpells:new( "Spell.Travel", spellIconList["Charge"],
	{
		"DRUID", ABGCode:GetSpellNameByName("Travel Form"),
		"SHAMAN", ABGCode:GetSpellNameByName("Ghost Wolf"),
	})

end

