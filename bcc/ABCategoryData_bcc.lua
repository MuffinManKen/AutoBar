local _, AB = ...

local types = AB.types	---@class ABTypes
local code = AB.code	---@class ABCode
--local AutoBar = AutoBar
local ABGData = AutoBarGlobalDataObject
local spellIconList = ABGData.spell_icon_list
--local L = AutoBarGlobalDataObject.locale
local ItemsCategory = AB.ItemsCategory
--local MacroTextCategory = AB.MacroTextCategory
local SpellsCategory = AB.SpellsCategory



function AB.InitializeCategories()

	AutoBarCategoryList["Muffin.Poison.Lethal"] = ItemsCategory:new("Muffin.Poison.Lethal", "INV_Misc_Food_95_Grainbread", "Muffin.Poison.Lethal")
	AutoBarCategoryList["Muffin.Poison.Nonlethal"] = ItemsCategory:new("Muffin.Poison.Nonlethal", "INV_Misc_Food_95_Grainbread", "Muffin.Poison.Nonlethal")

	AutoBarCategoryList["Muffin.Mounts.Item"] = ItemsCategory:new("Muffin.Mounts.Item", "ability_mount_ridinghorse", "Muffin.Mounts.Item")
	AutoBarCategoryList["Muffin.Mounts.Item"]:SetNonCombat(true)
	AutoBarCategoryList["Muffin.Mounts.Paladin"] = SpellsCategory:new("Muffin.Mounts.Paladin", "ability_mount_ridinghorse", nil, nil, "Muffin.Mounts.Paladin")
	AutoBarCategoryList["Muffin.Mounts.Paladin"]:SetNonCombat(true)
	AutoBarCategoryList["Muffin.Mounts.Warlock"] = SpellsCategory:new("Muffin.Mounts.Warlock", "ability_mount_ridinghorse", nil, nil, "Muffin.Mounts.Warlock")
	AutoBarCategoryList["Muffin.Mounts.Warlock"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Misc.Hearth"] = ItemsCategory:new("Muffin.Misc.Hearth", "INV_Misc_Rune_01", "Muffin.Misc.Hearth")
	AutoBarCategoryList["Spell.Warlock.Create Healthstone"] = SpellsCategory:new( "Spell.Warlock.Create Healthstone", spellIconList["Create Healthstone"],
	{
		"WARLOCK", code.get_spell_name_by_name("Create Healthstone (Minor)"),
		"WARLOCK", code.get_spell_name_by_name("Create Healthstone (Lesser)"),
		"WARLOCK", code.get_spell_name_by_name("Create Healthstone"),
		"WARLOCK", code.get_spell_name_by_name("Create Healthstone (Greater)"),
		"WARLOCK", code.get_spell_name_by_name("Create Healthstone (Major)"),
		"WARLOCK", code.get_spell_name_by_name("Create Healthstone (Master)"), code.get_spell_name_by_name("Ritual of Souls"),--added
	})

	AutoBarCategoryList["Spell.Warlock.Create Soulstone"] = SpellsCategory:new( "Spell.Warlock.Create Soulstone", spellIconList["Create Soulstone"],
	{
		"WARLOCK", code.get_spell_name_by_name("Create Soulstone (Minor)"),
		"WARLOCK", code.get_spell_name_by_name("Create Soulstone (Lesser)"),
		"WARLOCK", code.get_spell_name_by_name("Create Soulstone"),
		"WARLOCK", code.get_spell_name_by_name("Create Soulstone (Greater)"),
		"WARLOCK", code.get_spell_name_by_name("Create Soulstone (Major)"),
		"WARLOCK", code.get_spell_name_by_name("Create Soulstone (Master)"),

	})

	AutoBarCategoryList["Spell.Warlock.Create Firestone"] = SpellsCategory:new( "Spell.Warlock.Create Firestone", spellIconList["Create Firestone"],
	{
		"WARLOCK", code.get_spell_name_by_name("Create Firestone (Lesser)"),
		"WARLOCK", code.get_spell_name_by_name("Create Firestone"),
		"WARLOCK", code.get_spell_name_by_name("Create Firestone (Greater)"),
		"WARLOCK", code.get_spell_name_by_name("Create Firestone (Major)"),
		"WARLOCK", code.get_spell_name_by_name("Create Firestone (Master)"),
	})

	AutoBarCategoryList["Spell.Warlock.Create Spellstone"] = SpellsCategory:new( "Spell.Warlock.Create Spellstone", spellIconList["Create Spell	stone"],
	{
		"WARLOCK", code.get_spell_name_by_name("Create Spellstone"),
		"WARLOCK", code.get_spell_name_by_name("Create Spellstone (Greater)"),
		"WARLOCK", code.get_spell_name_by_name("Create Spellstone (Major)"),
		"WARLOCK", code.get_spell_name_by_name("Create Spellstone (Master)"),
	})

	AutoBarCategoryList["Spell.Mage.Create Manastone"] = SpellsCategory:new( "Spell.Mage.Create Manastone", spellIconList["Conjure Mana Jade"],
	{
		"MAGE", code.get_spell_name_by_name("Conjure Mana Jade"),
		"MAGE", code.get_spell_name_by_name("Conjure Mana Ruby"),
		"MAGE", code.get_spell_name_by_name("Conjure Mana Agate"),
		"MAGE", code.get_spell_name_by_name("Conjure Mana Citrine"),
		"MAGE", code.get_spell_name_by_name("Conjure Mana Emerald"),
	})

	AutoBarCategoryList["Spell.Mage.Conjure Food"] = SpellsCategory:new( "Spell.Mage.Conjure Food", spellIconList["Conjure Food"],
	{
		"MAGE", code.get_spell_name_by_name("Conjure Food"),code.get_spell_name_by_name("Ritual of Refreshment"), --updated
	})

	AutoBarCategoryList["Spell.Mage.Conjure Water"] = SpellsCategory:new("Spell.Mage.Conjure Water", spellIconList["Conjure Water"],
	{
		"MAGE", code.get_spell_name_by_name("Conjure Water"),code.get_spell_name_by_name("Ritual of Refreshment"), --updated
	})


	AutoBarCategoryList["Consumable.Food.Conjure"] = SpellsCategory:new("Consumable.Food.Conjure", spellIconList["Ritual of Refreshment"],
	{
		"MAGE", code.get_spell_name_by_name("Ritual of Refreshment"),
	})

	AutoBarCategoryList["Spell.Rogue.Thief"] = SpellsCategory:new("Spell.Rogue.Thief", spellIconList["Pick Pocket"],
	{
		"ROGUE", code.get_spell_name_by_name("Pick Pocket"),
		"ROGUE", code.get_spell_name_by_name("Pick Lock"),
	})

	AutoBarCategoryList["Spell.Stealth"] = SpellsCategory:new("Spell.Stealth", spellIconList["Stealth"],
	{
		"DRUID", code.get_spell_name_by_name("Prowl"),
		"MAGE", code.get_spell_name_by_name("Invisibility"),
		"MAGE", code.get_spell_name_by_name("Lesser Invisibility"),
		"ROGUE", code.get_spell_name_by_name("Stealth"),
		"*", code.get_spell_name_by_name("Shadowmeld"),
	})

	AutoBarCategoryList["Spell.Aspect"] = SpellsCategory:new("Spell.Aspect", spellIconList["Aspect of the Cheetah"],
	{
		"HUNTER", code.get_spell_name_by_name("Aspect of the Cheetah"),
		"HUNTER", code.get_spell_name_by_name("Aspect of the Hawk"),
		"HUNTER", code.get_spell_name_by_name("Aspect of the Monkey"),
		"HUNTER", code.get_spell_name_by_name("Aspect of the Wild"),
		"HUNTER", code.get_spell_name_by_name("Aspect of the Pack"),
		"HUNTER", code.get_spell_name_by_name("Aspect of the Beast"),
		"HUNTER", code.get_spell_name_by_name("Aspect of the Viper"),
	})

	AutoBarCategoryList["Spell.Class.Buff"] = SpellsCategory:new( "Spell.Class.Buff", spellIconList["Barkskin"], nil,
	{
		"DRUID", code.get_spell_name_by_name("Mark of the Wild"), code.get_spell_name_by_name("Gift of the Wild"),
		"DRUID", code.get_spell_name_by_name("Thorns"), code.get_spell_name_by_name("Thorns"),
		"DRUID", code.get_spell_name_by_name("Omen of Clarity"), code.get_spell_name_by_name("Omen of Clarity"),
		"DRUID", code.get_spell_name_by_name("Barkskin"), code.get_spell_name_by_name("Barkskin"),

		"HUNTER", code.get_spell_name_by_name("Thorns"), code.get_spell_name_by_name("Misdirection"),

		"MAGE", code.get_spell_name_by_name("Slow Fall"), code.get_spell_name_by_name("Slow Fall"),
		"MAGE", code.get_spell_name_by_name("Arcane Intellect"), code.get_spell_name_by_name("Arcane Brilliance"),
		"MAGE", code.get_spell_name_by_name("Amplify Magic"), code.get_spell_name_by_name("Amplify Magic"),
		"MAGE", code.get_spell_name_by_name("Dampen Magic"), code.get_spell_name_by_name("Dampen Magic"),

		"PALADIN", code.get_spell_name_by_name("Blessing of Might"), code.get_spell_name_by_name("Greater Blessing of Might"),
		"PALADIN", code.get_spell_name_by_name("Blessing of Protection"), code.get_spell_name_by_name("Blessing of Protection"),
		"PALADIN", code.get_spell_name_by_name("Blessing of Sacrifice"), code.get_spell_name_by_name("Blessing of Sacrifice"),
		"PALADIN", code.get_spell_name_by_name("Blessing of Salvation"), code.get_spell_name_by_name("Greater Blessing of Salvation"),
		"PALADIN", code.get_spell_name_by_name("Greater Blessing of Kings"), code.get_spell_name_by_name("Greater Blessing of Kings"),
		"PALADIN", code.get_spell_name_by_name("Blessing of Wisdom"), code.get_spell_name_by_name("Greater Blessing of Wisdom"),
		"PALADIN", code.get_spell_name_by_name("Blessing of Sanctuary"), code.get_spell_name_by_name("Greater Blessing of Sanctuary"),
		"PALADIN", code.get_spell_name_by_name("Avenging Wrath"), code.get_spell_name_by_name("Avenging Wrath"),

		"PRIEST", code.get_spell_name_by_name("Power Word: Fortitude"), code.get_spell_name_by_name("Prayer of Fortitude"),
		"PRIEST", code.get_spell_name_by_name("Divine Spirit"), code.get_spell_name_by_name("Prayer of Spirit"),
		"PRIEST", code.get_spell_name_by_name("Inner Fire"), code.get_spell_name_by_name("Inner Fire"),
		"PRIEST", code.get_spell_name_by_name("Shadow Protection"), code.get_spell_name_by_name("Prayer of Shadow Protection"),
		"PRIEST", code.get_spell_name_by_name("Fear Ward"), code.get_spell_name_by_name("Fear Ward"),
		"PRIEST", code.get_spell_name_by_name("Pain Suppression"), code.get_spell_name_by_name("Pain Suppression"),
		"PRIEST", code.get_spell_name_by_name("Power Infusion"), code.get_spell_name_by_name("Power Infusion"),
		"PRIEST", code.get_spell_name_by_name("Lightwell"), code.get_spell_name_by_name("Lightwell"),
		"PRIEST", code.get_spell_name_by_name("Feedback"), code.get_spell_name_by_name("Feedback"),
		"PRIEST", code.get_spell_name_by_name("Elune's Grace"), code.get_spell_name_by_name("Elune's Grace"),
		"PRIEST", code.get_spell_name_by_name("Shadowguard"), code.get_spell_name_by_name("Shadowguard"),
		"PRIEST", code.get_spell_name_by_name("Touch of Weakness"), code.get_spell_name_by_name("Touch of Weakness"),

		"ROGUE", code.get_spell_name_by_name("Preparation"), code.get_spell_name_by_name("Preparation"),

		"SHAMAN", code.get_spell_name_by_name("Water Walking"), code.get_spell_name_by_name("Water Walking"),
		"SHAMAN", code.get_spell_name_by_name("Earth Shield"), code.get_spell_name_by_name("Earth Shield"),
		"SHAMAN", code.get_spell_name_by_name("Water Breathing"), code.get_spell_name_by_name("Water Breathing"),

		"WARLOCK", code.get_spell_name_by_name("Unending Breath"), code.get_spell_name_by_name("Unending Breath"),
		"WARLOCK", code.get_spell_name_by_name("Detect Invisibility"),
		"WARLOCK", code.get_spell_name_by_name("Demonic Sacrifice"),
		"WARLOCK", code.get_spell_name_by_name("Soul Link"),

		"WARRIOR", code.get_spell_name_by_name("Battle Shout"), code.get_spell_name_by_name("Commanding Shout"),
		"WARRIOR", code.get_spell_name_by_name("Commanding Shout"), code.get_spell_name_by_name("Battle Shout"),
		})

	AutoBarCategoryList["Spell.Class.Pet"] = SpellsCategory:new( "Spell.Class.Pet", spellIconList["Call Pet 1"],
	{
		"HUNTER", code.get_spell_name_by_name("Call Pet"),

		"PRIEST", code.get_spell_name_by_name("Shadowfiend"),

		"MAGE",  code.get_spell_name_by_name("Summon Water Elemental"),

		"WARLOCK", code.get_spell_name_by_name("Eye of Kilrogg"),
		"WARLOCK", code.get_spell_name_by_name("Summon Imp"),
		"WARLOCK", code.get_spell_name_by_name("Summon Voidwalker"),
		"WARLOCK", code.get_spell_name_by_name("Summon Felhunter"),
		"WARLOCK", code.get_spell_name_by_name("Summon Incubus"),
		"WARLOCK", code.get_spell_name_by_name("Summon Succubus"),
		"WARLOCK", code.get_spell_name_by_name("Summon Felguard"),
		"WARLOCK", code.get_spell_name_by_name("Summon Infernal"),
	})



	AutoBarCategoryList["Spell.Class.Pets2"] = SpellsCategory:new( "Spell.Class.Pets2", spellIconList["Call Pet 1"],
	{
		"HUNTER", code.get_spell_name_by_name("Bestial Wrath"),
		"HUNTER", code.get_spell_name_by_name("Mend Pet"),
		"HUNTER", code.get_spell_name_by_name("Intimidation"),
		"HUNTER", code.get_spell_name_by_name("Kill Command"),
	})

	--Misc pet abilities
	AutoBarCategoryList["Spell.Class.Pets3"] = SpellsCategory:new(	"Spell.Class.Pets3", spellIconList["Feed Pet"],
	{
		"HUNTER", code.get_spell_name_by_name("Dismiss Pet"),
		"HUNTER", code.get_spell_name_by_name("Eagle Eye"),
		"HUNTER", code.get_spell_name_by_name("Feed Pet"),
		"HUNTER", code.get_spell_name_by_name("Revive Pet"),
		"HUNTER", code.get_spell_name_by_name("Tame Beast"),
		"HUNTER", code.get_spell_name_by_name("Beast Lore"),
	})

	AutoBarCategoryList["Spell.Portals"] = SpellsCategory:new( "Spell.Portals", "spell_arcane_portalironforge", nil,
	{
		"DRUID", code.get_spell_name_by_name("Teleport: Moonglade"), code.get_spell_name_by_name("Teleport: Moonglade"),

		"MAGE", code.get_spell_name_by_name("Teleport: Undercity"), code.get_spell_name_by_name("Portal: Undercity"),
		"MAGE", code.get_spell_name_by_name("Teleport: Thunder Bluff"), code.get_spell_name_by_name("Portal: Thunder Bluff"),
		"MAGE", code.get_spell_name_by_name("Teleport: Stormwind"), code.get_spell_name_by_name("Portal: Stormwind"),
		"MAGE", code.get_spell_name_by_name("Teleport: Darnassus"), code.get_spell_name_by_name("Portal: Darnassus"),
		"MAGE", code.get_spell_name_by_name("Teleport: Ironforge"), code.get_spell_name_by_name("Portal: Ironforge"),
		"MAGE", code.get_spell_name_by_name("Teleport: Orgrimmar"), code.get_spell_name_by_name("Portal: Orgrimmar"),
		"MAGE", code.get_spell_name_by_name("Teleport: Stonard"), code.get_spell_name_by_name("Portal: Stonard"),
		"MAGE", code.get_spell_name_by_name("Teleport: Theramore"), code.get_spell_name_by_name("Portal: Theramore"),
		"MAGE", code.get_spell_name_by_name("Teleport: Exodar"), code.get_spell_name_by_name("Portal: Exodar"),
		"MAGE", code.get_spell_name_by_name("Teleport: Silvermoon"), code.get_spell_name_by_name("Portal: Silvermoon"),
		"MAGE", code.get_spell_name_by_name("Teleport: Shattrath - Alliance"), code.get_spell_name_by_name("Portal: Shattrath - Alliance"),
		"MAGE", code.get_spell_name_by_name("Teleport: Shattrath - Horde"), code.get_spell_name_by_name("Portal: Shattrath - Horde"),

		"SHAMAN", code.get_spell_name_by_name("Astral Recall"), code.get_spell_name_by_name("Astral Recall"),

		"WARLOCK", code.get_spell_name_by_name("Ritual of Summoning"), code.get_spell_name_by_name("Ritual of Summoning"),
	})


	AutoBarCategoryList["Spell.Shields"] = SpellsCategory:new( "Spell.Shields", spellIconList["Ice Barrier"], nil,
	{
		"DRUID", code.get_spell_name_by_name("Barkskin"), 	code.get_spell_name_by_name("Barkskin"),

		"MAGE", code.get_spell_name_by_name("Frost Armor"), code.get_spell_name_by_name("Ice Armor"),
		"MAGE", code.get_spell_name_by_name("Mage Armor"), code.get_spell_name_by_name("Ice Barrier"),
		"MAGE", code.get_spell_name_by_name("Molten Armor"), code.get_spell_name_by_name("Ice Barrier"),
		"MAGE", code.get_spell_name_by_name("Frost Ward"), code.get_spell_name_by_name("Ice Barrier"),
		"MAGE", code.get_spell_name_by_name("Fire Ward"), code.get_spell_name_by_name("Ice Barrier"),
		"MAGE", code.get_spell_name_by_name("Ice Barrier"), code.get_spell_name_by_name("Ice Barrier"),
		"MAGE", code.get_spell_name_by_name("Mana Shield"), code.get_spell_name_by_name("Mana Shield"),

		"HUNTER", code.get_spell_name_by_name("Deterrence"), code.get_spell_name_by_name("Deterrence"),

		"PALADIN", code.get_spell_name_by_name("Divine Protection"), code.get_spell_name_by_name("Divine Shield"),
		"PALADIN", code.get_spell_name_by_name("Divine Shield"), code.get_spell_name_by_name("Divine Protection"),

		"PRIEST", code.get_spell_name_by_name("Power Word: Shield"), code.get_spell_name_by_name("Power Word: Shield"),

		"ROGUE", code.get_spell_name_by_name("Evasion"), code.get_spell_name_by_name("Evasion"),

		"SHAMAN", code.get_spell_name_by_name("Lightning Shield"), code.get_spell_name_by_name("Lightning Shield"),
		"SHAMAN", code.get_spell_name_by_name("Earth Shield"), code.get_spell_name_by_name("Earth Shield"),
		"SHAMAN", code.get_spell_name_by_name("Water Shield"), code.get_spell_name_by_name("Water Shield"),
		"SHAMAN", code.get_spell_name_by_name("Bloodlust"), code.get_spell_name_by_name("Bloodlust"),
		"SHAMAN", code.get_spell_name_by_name("Heroism"), code.get_spell_name_by_name("Heroism"),

		"WARRIOR", code.get_spell_name_by_name("Shield Wall"), code.get_spell_name_by_name("Shield Wall"),
		"WARRIOR", code.get_spell_name_by_name("Spell Reflect"), code.get_spell_name_by_name("Spell Reflect"),

		"WARLOCK", code.get_spell_name_by_name("Demon Skin"),  code.get_spell_name_by_name("Shadow Ward"),
		"WARLOCK", code.get_spell_name_by_name("Demon Armor"), code.get_spell_name_by_name("Shadow Ward"),
		"WARLOCK", code.get_spell_name_by_name("Fel Armor"), code.get_spell_name_by_name("Shadow Ward"),
		"WARLOCK", code.get_spell_name_by_name("Shadow Ward"), code.get_spell_name_by_name("Shadow Ward"),
		"WARLOCK", code.get_spell_name_by_name("Sacrifice (Voidwalker)"),code.get_spell_name_by_name("Sacrifice (Voidwalker)"),

	})

	AutoBarCategoryList["Spell.Stance"] = SpellsCategory:new( "Spell.Stance", spellIconList["Defensive Stance"],
	{
		"DRUID", code.get_spell_name_by_name("Bear Form"),
		"DRUID", code.get_spell_name_by_name("Dire Bear Form"),
		"DRUID", code.get_spell_name_by_name("Cat Form"),
		"DRUID", code.get_spell_name_by_name("Aquatic Form"),
		"DRUID", code.get_spell_name_by_name("Moonkin Form"),
		"DRUID", code.get_spell_name_by_name("Travel Form"),
		"DRUID", code.get_spell_name_by_name("Flight Form"),
		"DRUID", code.get_spell_name_by_name("Swift Flight Form"),

		"PALADIN", code.get_spell_name_by_name("Crusader Aura"),
		"PALADIN", code.get_spell_name_by_name("Devotion Aura"),
		"PALADIN", code.get_spell_name_by_name("Retribution Aura"),
		"PALADIN", code.get_spell_name_by_name("Concentration Aura"),
		"PALADIN", code.get_spell_name_by_name("Fire Resistance Aura"),
		"PALADIN", code.get_spell_name_by_name("Frost Resistance Aura"),
		"PALADIN", code.get_spell_name_by_name("Sanctity Aura"),
		"PALADIN", code.get_spell_name_by_name("Shadow Resistance Aura"),

		"WARRIOR", code.get_spell_name_by_name("Defensive Stance"),
		"WARRIOR", code.get_spell_name_by_name("Battle Stance"),
		"WARRIOR", code.get_spell_name_by_name("Berserker Stance"),
	})

	AutoBarCategoryList["Spell.Seal"] = SpellsCategory:new( "Spell.Seal", spellIconList["Seal of the Crusader"],
	{
		"PALADIN", code.get_spell_name_by_name("Seal of Command"),
		"PALADIN", code.get_spell_name_by_name("Seal of Justice"),
		"PALADIN", code.get_spell_name_by_name("Seal of Light"),
		"PALADIN", code.get_spell_name_by_name("Seal of Righteousness"),
		"PALADIN", code.get_spell_name_by_name("Seal of the Crusader"),
		"PALADIN", code.get_spell_name_by_name("Seal of the Martyr"),
		"PALADIN", code.get_spell_name_by_name("Seal of Wisdom"),
		"PALADIN", code.get_spell_name_by_name("Seal of Corruption"),
	})

	AutoBarCategoryList["Spell.Totem.Earth"] = SpellsCategory:new("Spell.Totem.Earth", spellIconList["Earthgrab Totem"],
	{
		"SHAMAN", code.get_spell_name_by_name("Earthbind Totem"),
		"SHAMAN", code.get_spell_name_by_name("Earth Elemental Totem"),
		"SHAMAN", code.get_spell_name_by_name("Stoneclaw Totem"),
		"SHAMAN", code.get_spell_name_by_name("Stoneskin Totem"),
		"SHAMAN", code.get_spell_name_by_name("Strength of Earth Totem"),
		"SHAMAN", code.get_spell_name_by_name("Tremor Totem"),
	})


	AutoBarCategoryList["Spell.Totem.Air"] = SpellsCategory:new("Spell.Totem.Air", spellIconList["Wind Rush Totem"],
	{
		"SHAMAN", code.get_spell_name_by_name("Grace of Air Totem"),
		"SHAMAN", code.get_spell_name_by_name("Grounding Totem"),
		"SHAMAN", code.get_spell_name_by_name("Nature Resistance Totem"),
		"SHAMAN", code.get_spell_name_by_name("Sentry Totem"),
		"SHAMAN", code.get_spell_name_by_name("Tranquil Air Totem"),
		"SHAMAN", code.get_spell_name_by_name("Windfury Totem"),
		"SHAMAN", code.get_spell_name_by_name("Windwall Totem"),
		"SHAMAN", code.get_spell_name_by_name("Wrath of Air Totem"),
	})

	AutoBarCategoryList["Spell.Totem.Fire"] = SpellsCategory:new("Spell.Totem.Fire", spellIconList["Liquid Magma Totem"],
	{
		"SHAMAN", code.get_spell_name_by_name("Fire Nova Totem"),
		"SHAMAN", code.get_spell_name_by_name("Flametongue Totem"),
		"SHAMAN", code.get_spell_name_by_name("Frost Resistance Totem"),
		"SHAMAN", code.get_spell_name_by_name("Magma Totem"),
		"SHAMAN", code.get_spell_name_by_name("Searing Totem"),
		"SHAMAN", code.get_spell_name_by_name("Totem of Wrath"),
		"SHAMAN", code.get_spell_name_by_name("Fire Elemental Totem"),
	})

	AutoBarCategoryList["Spell.Totem.Water"] = SpellsCategory:new("Spell.Totem.Water", spellIconList["Healing Stream Totem"],
	{
		"SHAMAN", code.get_spell_name_by_name("Disease Cleansing Totem"),
		"SHAMAN", code.get_spell_name_by_name("Fire Resistance Totem"),
		"SHAMAN", code.get_spell_name_by_name("Healing Stream Totem"),
		"SHAMAN", code.get_spell_name_by_name("Mana Spring Totem"),
		"SHAMAN", code.get_spell_name_by_name("Mana Tide Totem"),
		"SHAMAN", code.get_spell_name_by_name("Poison Cleansing Totem"),
	})


	AutoBarCategoryList["Spell.Buff.Weapon"] = SpellsCategory:new("Spell.Buff.Weapon", spellIconList["Deadly Poison"],
	{
		"SHAMAN", code.get_spell_name_by_name("Flametongue Weapon"),
		"SHAMAN", code.get_spell_name_by_name("Frostbrand Weapon"),
		"SHAMAN", code.get_spell_name_by_name("Rockbiter Weapon"),
		"SHAMAN", code.get_spell_name_by_name("Windfury Weapon"),
	})

	AutoBarCategoryList["Spell.Crafting"] = SpellsCategory:new( "Spell.Crafting", spellIconList["First Aid"],
	{
		"*", code.get_spell_name_by_name("Alchemy"),
		"*", code.get_spell_name_by_name("Basic Campfire"),
		"*", code.get_spell_name_by_name("Blacksmithing"),
		"*", code.get_spell_name_by_name("Cooking"),
		"*", code.get_spell_name_by_name("Disenchant"),
		"*", code.get_spell_name_by_name("Enchanting"),
		"*", code.get_spell_name_by_name("Engineering"),
		"*", code.get_spell_name_by_name("Jewelcrafting"),
		"*", code.get_spell_name_by_name("Prospecting"),
		"*", code.get_spell_name_by_name("First Aid"),
		"*", code.get_spell_name_by_name("Leatherworking"),
		"*", code.get_spell_name_by_name("Smelting"),
		"*", code.get_spell_name_by_name("Tailoring"),

		"*", code.get_spell_name_by_name("Find Minerals"),
		"*", code.get_spell_name_by_name("Find Herbs"),
	})

	AutoBarCategoryList["Spell.Debuff.Multiple"] = SpellsCategory:new("Spell.Debuff.Multiple", spellIconList["Slow"],
	{
		"DRUID", code.get_spell_name_by_name("Disorienting Roar"),
		"WARRIOR", code.get_spell_name_by_name("Demoralizing Shout"),
		"WARRIOR", code.get_spell_name_by_name("Thunder Clap"),
	})

	AutoBarCategoryList["Spell.Debuff.Single"] = SpellsCategory:new("Spell.Debuff.Single", spellIconList["Slow"],
	{
		"HUNTER", code.get_spell_name_by_name("Concussive Shot"),
		"HUNTER", code.get_spell_name_by_name("Wing Clip"),
		"MAGE", code.get_spell_name_by_name("Slow"),
		"MAGE", code.get_spell_name_by_name("Spellsteal"),
		"PRIEST", code.get_spell_name_by_name("Silence"),
		"PRIEST", code.get_spell_name_by_name("Mind Soothe"),
		"PRIEST", code.get_spell_name_by_name("Hex of Weakness"),
		"SHAMAN", code.get_spell_name_by_name("Frost Shock"),
		"WARLOCK", code.get_spell_name_by_name("Curse of Tongues"),
		"WARLOCK", code.get_spell_name_by_name("Curse of Recklessness"),
		"WARLOCK", code.get_spell_name_by_name("Curse of Shadow"),
		"WARLOCK", code.get_spell_name_by_name("Curse of the Elements"),
		"WARLOCK", code.get_spell_name_by_name("Curse of Weakness"),
		"WARLOCK", code.get_spell_name_by_name("Curse of Exhaustion"),
		"WARLOCK", code.get_spell_name_by_name("Devour Magic"),
	})


	AutoBarCategoryList["Spell.Fishing"] = SpellsCategory:new("Spell.Fishing", spellIconList["Fishing"],
	{
		"*", code.get_spell_name_by_name("Fishing"),
	})


	AutoBarCategoryList["Spell.Track"] = SpellsCategory:new( "Spell.Track", spellIconList["Track Beasts"],
	{
		"HUNTER", code.get_spell_name_by_name("Track Humanoids"),
		"HUNTER", code.get_spell_name_by_name("Track Undead"),
		"HUNTER", code.get_spell_name_by_name("Track Beasts"),
		"HUNTER", code.get_spell_name_by_name("Track Hidden"),
		"HUNTER", code.get_spell_name_by_name("Track Elementals"),
		"HUNTER", code.get_spell_name_by_name("Track Demons"),
		"HUNTER", code.get_spell_name_by_name("Track Dragonkin"),
		"HUNTER", code.get_spell_name_by_name("Track Giants"),
		"PALADIN", code.get_spell_name_by_name("Sense Undead"),
		"WARLOCK", code.get_spell_name_by_name("Sense Demons"),
	})

	AutoBarCategoryList["Spell.Trap"] = SpellsCategory:new( "Spell.Trap", spellIconList["Explosive Trap"],
	{
		"HUNTER", code.get_spell_name_by_name("Explosive Trap"),
		"HUNTER", code.get_spell_name_by_name("Freezing Trap"),
		"HUNTER", code.get_spell_name_by_name("Frost Trap"),
		"HUNTER", code.get_spell_name_by_name("Immolation Trap"),
		"HUNTER", code.get_spell_name_by_name("Snake Trap"),
		"ROGUE",  code.get_spell_name_by_name("Disarm Trap"),
	})


	AutoBarCategoryList["Misc.Mount.Summoned"] = SpellsCategory:new( "Misc.Mount.Summoned", spellIconList["Summon Dreadsteed"],
	{
		"SHAMAN", code.get_spell_name_by_name("Ghost Wolf"),
	})
	AutoBarCategoryList["Misc.Mount.Summoned"]:SetNonCombat(true)


	AutoBarCategoryList["Spell.Charge"] = SpellsCategory:new( "Spell.Charge", spellIconList["Charge"],
	{
		"DRUID", code.get_spell_name_by_name("Feral Charge"),
		"ROGUE", code.get_spell_name_by_name("Shadowstep"),
		"WARRIOR", code.get_spell_name_by_name("Charge"),
		"WARRIOR", code.get_spell_name_by_name("Intercept"),
		"WARRIOR", code.get_spell_name_by_name("Intervene"),
	})

	AutoBarCategoryList["Spell.ER"] = SpellsCategory:new( "Spell.ER", spellIconList["Ice Block"],
	{
		"DRUID", code.get_spell_name_by_name("Natures Grasp"),
		"DRUID", code.get_spell_name_by_name("Frenzied Regeneration"),
		"DRUID", code.get_spell_name_by_name("Rebirth"),
		"HUNTER", code.get_spell_name_by_name("Feign Death"),
		"HUNTER", code.get_spell_name_by_name("Disengage"),
		"MAGE", code.get_spell_name_by_name("Ice Block"),
		"PALADIN", code.get_spell_name_by_name("Lay on Hands"),
		"PRIEST", code.get_spell_name_by_name("Lightwell"),
		"PRIEST", code.get_spell_name_by_name("Mass Dispell"),
		"ROGUE", code.get_spell_name_by_name("Vanish"),
		"ROGUE", code.get_spell_name_by_name("Cloak of Shadows"),
		"WARLOCK", code.get_spell_name_by_name("Dark Pact"),
		"WARLOCK", code.get_spell_name_by_name("Soulshatter"),
		"WARRIOR", code.get_spell_name_by_name("Last Stand"),
		"WARRIOR", code.get_spell_name_by_name("Shield Wall"),
	})

	AutoBarCategoryList["Spell.Interrupt"] = SpellsCategory:new( "Spell.Interrupt", spellIconList["Kick"],
	{
		"DRUID", code.get_spell_name_by_name("Maim"),
		"HUNTER", code.get_spell_name_by_name("Wyvern Sting"),
		"HUNTER", code.get_spell_name_by_name("Scatter Shot"),
		"HUNTER", code.get_spell_name_by_name("Tranquilizing Shot"),
		"MAGE", code.get_spell_name_by_name("Counterspell"),
		"PRIEST", code.get_spell_name_by_name("Silence"),
		"ROGUE", code.get_spell_name_by_name("Kick"),
		"SHAMAN", code.get_spell_name_by_name("Earth Shock"),
		"WARLOCK", code.get_spell_name_by_name("Shadowfury"),
		"WARLOCK", code.get_spell_name_by_name("Intercept (Felguard)"),
		"WARRIOR", code.get_spell_name_by_name("Shield Bash"),
	})

	AutoBarCategoryList["Spell.CatForm"] = SpellsCategory:new( "Spell.CatForm", spellIconList["Cat Form"],
	{
		"DRUID", code.get_spell_name_by_name("Cat Form"),
	})

	AutoBarCategoryList["Spell.BearForm"] = SpellsCategory:new( "Spell.BearForm", spellIconList["Bear Form"],
	{
		"DRUID", code.get_spell_name_by_name("Bear Form"),
		"DRUID", code.get_spell_name_by_name("Dire Bear Form"),
	})

	AutoBarCategoryList["Spell.MoonkinForm"] = SpellsCategory:new( "Spell.MoonkinForm", spellIconList["Moonkin form"],
	{
		"DRUID", code.get_spell_name_by_name("Moonkin Form"),
	})

	AutoBarCategoryList["Spell.AquaticForm"] = SpellsCategory:new( "Spell.AquaticForm", spellIconList["Aquatic Form"],
	{
		"DRUID", code.get_spell_name_by_name("Aquatic Form"),
	})

	AutoBarCategoryList["Spell.Travel"] = SpellsCategory:new( "Spell.Travel", spellIconList["Travel Form"],
	{
		"DRUID", code.get_spell_name_by_name("Travel Form"),
		"SHAMAN", code.get_spell_name_by_name("Ghost Wolf"),
	})

end