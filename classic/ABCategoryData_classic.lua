local _ADDON_NAME, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

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
		"WARLOCK", AB.GetSpellNameByName("Create Healthstone (Minor)"),
		"WARLOCK", AB.GetSpellNameByName("Create Healthstone (Lesser)"),
		"WARLOCK", AB.GetSpellNameByName("Create Healthstone"),
		"WARLOCK", AB.GetSpellNameByName("Create Healthstone (Greater)"),
		"WARLOCK", AB.GetSpellNameByName("Create Healthstone (Major)"),
	})

	AutoBarCategoryList["Spell.Warlock.Create Soulstone"] = SpellsCategory:new( "Spell.Warlock.Create Soulstone", spellIconList["Create Soulstone"],
	{
		"WARLOCK", AB.GetSpellNameByName("Create Soulstone (Minor)"),
		"WARLOCK", AB.GetSpellNameByName("Create Soulstone (Lesser)"),
		"WARLOCK", AB.GetSpellNameByName("Create Soulstone"),
		"WARLOCK", AB.GetSpellNameByName("Create Soulstone (Greater)"),
		"WARLOCK", AB.GetSpellNameByName("Create Soulstone (Major)"),
	})

	AutoBarCategoryList["Spell.Mage.Create Manastone"] = SpellsCategory:new( "Spell.Mage.Create Manastone", spellIconList["Conjure Mana Jade"],
	{
		"MAGE", AB.GetSpellNameByName("Conjure Mana Jade"),
		"MAGE", AB.GetSpellNameByName("Conjure Mana Ruby"),
		"MAGE", AB.GetSpellNameByName("Conjure Mana Agate"),
		"MAGE", AB.GetSpellNameByName("Conjure Mana Citrine"),
	})


	AutoBarCategoryList["Spell.Mage.Conjure Food"] = SpellsCategory:new( "Spell.Mage.Conjure Food", spellIconList["Conjure Refreshment"], {
		"MAGE", AB.GetSpellNameByName("Conjure Food"),
	})

	AutoBarCategoryList["Spell.Mage.Conjure Water"] = SpellsCategory:new("Spell.Mage.Conjure Water", spellIconList["Conjure Refreshment"], {
		"MAGE", AB.GetSpellNameByName("Conjure Water"),
	})

	AutoBarCategoryList["Consumable.Food.Conjure"] = SpellsCategory:new("Consumable.Food.Conjure", spellIconList["Conjure Refreshment"], {
--			"MAGE", AB.GetSpellNameByName("Conjure Refreshment"),
			})


	AutoBarCategoryList["Spell.Stealth"] = SpellsCategory:new("Spell.Stealth", spellIconList["Stealth"],
	{
		"DRUID", AB.GetSpellNameByName("Prowl"),
		"MAGE", AB.GetSpellNameByName("Invisibility"),
		"MAGE", AB.GetSpellNameByName("Lesser Invisibility"),
		"ROGUE", AB.GetSpellNameByName("Stealth"),	--y
		"*", AB.GetSpellNameByName("Shadowmeld"),	--y
	})

	AutoBarCategoryList["Spell.Aspect"] = SpellsCategory:new("Spell.Aspect", spellIconList["Aspect of the Cheetah"],
	{
		"HUNTER", AB.GetSpellNameByName("Aspect of the Cheetah"),
		"HUNTER", AB.GetSpellNameByName("Aspect of the Hawk"),
		"HUNTER", AB.GetSpellNameByName("Aspect of the Monkey"),
		"HUNTER", AB.GetSpellNameByName("Aspect of the Wild"),
		"HUNTER", AB.GetSpellNameByName("Aspect of the Pack"),
		"HUNTER", AB.GetSpellNameByName("Aspect of the Beast"),
	})

	AutoBarCategoryList["Spell.Class.Buff"] = SpellsCategory:new( "Spell.Class.Buff", spellIconList["Barkskin"],
	{
		"MAGE", AB.GetSpellNameByName("Slow Fall"),
		"MAGE", AB.GetSpellNameByName("Arcane Intellect"),
		"MAGE", AB.GetSpellNameByName("Arcane Brilliance"),
		"MAGE", AB.GetSpellNameByName("Amplify Magic"),
		"MAGE", AB.GetSpellNameByName("Dampen Magic"),
		"DRUID", AB.GetSpellNameByName("Mark of the Wild"),
		"DRUID", AB.GetSpellNameByName("Gift of the Wild"),
		"DRUID", AB.GetSpellNameByName("Thorns"),
		"PALADIN", AB.GetSpellNameByName("Blessing of Might"),
		"PALADIN", AB.GetSpellNameByName("Blessing of Protection"),
		"PALADIN", AB.GetSpellNameByName("Blessing of Sacrifice"),
		"PALADIN", AB.GetSpellNameByName("Blessing of Salvation"),
		"PALADIN", AB.GetSpellNameByName("Greater Blessing of Kings"),
		"PALADIN", AB.GetSpellNameByName("Greater Blessing of Wisdom"),
		"PRIEST", AB.GetSpellNameByName("Power Word: Fortitude");
		"PRIEST", AB.GetSpellNameByName("Inner Fire");
		"PRIEST", AB.GetSpellNameByName("Shadow Protection");
		"PRIEST", AB.GetSpellNameByName("Prayer of Shadow Protection");
		"SHAMAN", AB.GetSpellNameByName("Water Walking"),
		"WARLOCK", AB.GetSpellNameByName("Unending Breath"),
		"WARRIOR", AB.GetSpellNameByName("Battle Shout"),
	})

	AutoBarCategoryList["Spell.Class.Pet"] = SpellsCategory:new( "Spell.Class.Pet", spellIconList["Call Pet 1"],
	{
		"HUNTER", AB.GetSpellNameByName("Call Pet"),
		"WARLOCK", AB.GetSpellNameByName("Eye of Kilrogg"),
		"WARLOCK", AB.GetSpellNameByName("Summon Infernal"),
		"WARLOCK", AB.GetSpellNameByName("Summon Felhunter"),
		"WARLOCK", AB.GetSpellNameByName("Summon Imp"),
		"WARLOCK", AB.GetSpellNameByName("Summon Succubus"),
		"WARLOCK", AB.GetSpellNameByName("Summon Voidwalker"),
	})



	AutoBarCategoryList["Spell.Class.Pets2"] = SpellsCategory:new( "Spell.Class.Pets2", spellIconList["Call Pet 1"],
	{
		"HUNTER", AB.GetSpellNameByName("Bestial Wrath"),
		"HUNTER", AB.GetSpellNameByName("Mend Pet"),
		"HUNTER", AB.GetSpellNameByName("Intimidation"),
	})

	--Misc pet abilities
	AutoBarCategoryList["Spell.Class.Pets3"] = SpellsCategory:new(	"Spell.Class.Pets3", spellIconList["Feed Pet"],
	{
		"HUNTER", AB.GetSpellNameByName("Dismiss Pet"),
		"HUNTER", AB.GetSpellNameByName("Eagle Eye"),
		"HUNTER", AB.GetSpellNameByName("Feed Pet"),
		"HUNTER", AB.GetSpellNameByName("Revive Pet"),
		"HUNTER", AB.GetSpellNameByName("Tame Beast"),
		"HUNTER", AB.GetSpellNameByName("Beast Lore"),
	})

	AutoBarCategoryList["Spell.Portals"] = SpellsCategory:new( "Spell.Portals", "spell_arcane_portalironforge", nil,
	{
		"DRUID", AB.GetSpellNameByName("Teleport: Moonglade"), AB.GetSpellNameByName("Teleport: Moonglade"),
		"MAGE", AB.GetSpellNameByName("Teleport: Undercity"), AB.GetSpellNameByName("Portal: Undercity"),
		"MAGE", AB.GetSpellNameByName("Teleport: Thunder Bluff"), AB.GetSpellNameByName("Portal: Thunder Bluff"),
		"MAGE", AB.GetSpellNameByName("Teleport: Stormwind"), AB.GetSpellNameByName("Portal: Stormwind"),
		"MAGE", AB.GetSpellNameByName("Teleport: Darnassus"), AB.GetSpellNameByName("Portal: Darnassus"),
		"MAGE", AB.GetSpellNameByName("Teleport: Ironforge"), AB.GetSpellNameByName("Portal: Ironforge"),
		"MAGE", AB.GetSpellNameByName("Teleport: Orgrimmar"), AB.GetSpellNameByName("Portal: Orgrimmar"),
		"SHAMAN", AB.GetSpellNameByName("Astral Recall"), AB.GetSpellNameByName("Astral Recall"),
		"WARLOCK", AB.GetSpellNameByName("Ritual of Summoning"), AB.GetSpellNameByName("Ritual of Summoning"),
	})


	AutoBarCategoryList["Spell.Shields"] = SpellsCategory:new( "Spell.Shields", spellIconList["Ice Barrier"], nil,
	{
		"DRUID", 		AB.GetSpellNameByName("Barkskin"), 	AB.GetSpellNameByName("Barkskin"),
		"MAGE", 			AB.GetSpellNameByName("Frost Armor"), AB.GetSpellNameByName("Ice Barrier"),
		"MAGE", 			AB.GetSpellNameByName("Ice Armor"), AB.GetSpellNameByName("Ice Barrier"),
		"MAGE", 			AB.GetSpellNameByName("Mage Armor"), AB.GetSpellNameByName("Ice Barrier"),
		"PALADIN", 		AB.GetSpellNameByName("Divine Protection"), AB.GetSpellNameByName("Divine Shield"),
		"PALADIN", 		AB.GetSpellNameByName("Divine Shield"), AB.GetSpellNameByName("Divine Protection"),
		"PRIEST", 		AB.GetSpellNameByName("Power Word: Shield"), AB.GetSpellNameByName("Power Word: Shield"),
		"ROGUE", 		AB.GetSpellNameByName("Evasion"), 		AB.GetSpellNameByName("Evasion"),
		"WARRIOR", 		AB.GetSpellNameByName("Shield Block"), AB.GetSpellNameByName("Shield Wall"),
		"WARRIOR", 		AB.GetSpellNameByName("Shield Wall"), AB.GetSpellNameByName("Shield Block"),


		"WARLOCK", AB.GetSpellNameByName("Demon Skin"),  AB.GetSpellNameByName("Shadow Ward"),
		"WARLOCK", AB.GetSpellNameByName("Demon Armor"), AB.GetSpellNameByName("Shadow Ward"),
		"WARLOCK", AB.GetSpellNameByName("Shadow Ward"), AB.GetSpellNameByName("Shadow Ward"),

	})

	AutoBarCategoryList["Spell.Stance"] = SpellsCategory:new( "Spell.Stance", spellIconList["Defensive Stance"], {
		"DRUID", AB.GetSpellNameByName("Bear Form"),
		"DRUID", AB.GetSpellNameByName("Dire Bear Form"),
		"DRUID", AB.GetSpellNameByName("Cat Form"),
		"DRUID", AB.GetSpellNameByName("Aquatic Form"),
		"DRUID", AB.GetSpellNameByName("Moonkin Form"),
		"DRUID", AB.GetSpellNameByName("Tree Form"),
		"DRUID", AB.GetSpellNameByName("Travel Form"),
		"PALADIN", AB.GetSpellNameByName("Devotion Aura"),
		"PALADIN", AB.GetSpellNameByName("Retribution Aura"),
		"PALADIN", AB.GetSpellNameByName("Concentration Aura"),
		"PALADIN", AB.GetSpellNameByName("Fire Resistance Aura"),
		"PALADIN", AB.GetSpellNameByName("Frost Resistance Aura"),
		"PALADIN", AB.GetSpellNameByName("Sanctity Aura"),
		"PALADIN", AB.GetSpellNameByName("Shadow Resistance Aura"),
		"WARRIOR", AB.GetSpellNameByName("Defensive Stance"),
		"WARRIOR", AB.GetSpellNameByName("Battle Stance"),
		"WARRIOR", AB.GetSpellNameByName("Berserker Stance"),
	})

	AutoBarCategoryList["Spell.Seal"] = SpellsCategory:new( "Spell.Seal", spellIconList["Seal of the Crusader"], {
		"PALADIN", AB.GetSpellNameByName("Seal of Command"),
		"PALADIN", AB.GetSpellNameByName("Seal of Justice"),
		"PALADIN", AB.GetSpellNameByName("Seal of Light"),
		"PALADIN", AB.GetSpellNameByName("Seal of Righteousness"),
		"PALADIN", AB.GetSpellNameByName("Seal of the Crusader"),
		"PALADIN", AB.GetSpellNameByName("Seal of Wisdom"),
	})

	AutoBarCategoryList["Spell.Totem.Earth"] = SpellsCategory:new("Spell.Totem.Earth", spellIconList["Earthgrab Totem"],
	{
		"SHAMAN", AB.GetSpellNameByName("Earthbind Totem"),
		"SHAMAN", AB.GetSpellNameByName("Stoneclaw Totem"),
		"SHAMAN", AB.GetSpellNameByName("Stoneskin Totem"),
		"SHAMAN", AB.GetSpellNameByName("Strength of Earth Totem"),
		"SHAMAN", AB.GetSpellNameByName("Tremor Totem");
	})


	AutoBarCategoryList["Spell.Totem.Air"] = SpellsCategory:new("Spell.Totem.Air", spellIconList["Wind Rush Totem"],
	{
		"SHAMAN", AB.GetSpellNameByName("Grace of Air Totem");
		"SHAMAN", AB.GetSpellNameByName("Grounding Totem");
		"SHAMAN", AB.GetSpellNameByName("Nature Resistance Totem");
		"SHAMAN", AB.GetSpellNameByName("Sentry Totem");
		"SHAMAN", AB.GetSpellNameByName("Tranquil Air Totem");
		"SHAMAN", AB.GetSpellNameByName("Windfury Totem");
		"SHAMAN", AB.GetSpellNameByName("Windwall Totem");
	})

	AutoBarCategoryList["Spell.Totem.Fire"] = SpellsCategory:new("Spell.Totem.Fire", spellIconList["Liquid Magma Totem"],
	{
		"SHAMAN", AB.GetSpellNameByName("Fire Nova Totem");
		"SHAMAN", AB.GetSpellNameByName("Flametongue Totem");
		"SHAMAN", AB.GetSpellNameByName("Frost Resistance Totem");
		"SHAMAN", AB.GetSpellNameByName("Magma Totem");
		"SHAMAN", AB.GetSpellNameByName("Searing Totem");
	})

	AutoBarCategoryList["Spell.Totem.Water"] = SpellsCategory:new("Spell.Totem.Water", spellIconList["Healing Stream Totem"],
	{
		"SHAMAN", AB.GetSpellNameByName("Disease Cleansing Totem");
		"SHAMAN", AB.GetSpellNameByName("Fire Resistance Totem");
		"SHAMAN", AB.GetSpellNameByName("Healing Stream Totem");
		"SHAMAN", AB.GetSpellNameByName("Mana Spring Totem");
		"SHAMAN", AB.GetSpellNameByName("Mana Tide Totem");
		"SHAMAN", AB.GetSpellNameByName("Poison Cleansing Totem");
	})


	AutoBarCategoryList["Spell.Buff.Weapon"] = SpellsCategory:new("Spell.Buff.Weapon", spellIconList["Deadly Poison"],
	{
		"SHAMAN", AB.GetSpellNameByName("Flametongue Weapon"),
		"SHAMAN", AB.GetSpellNameByName("Frostbrand Weapon"),
		"SHAMAN", AB.GetSpellNameByName("Rockbiter Weapon"),
		"SHAMAN", AB.GetSpellNameByName("Windfury Weapon"),
	})

	AutoBarCategoryList["Spell.Crafting"] = SpellsCategory:new( "Spell.Crafting", spellIconList["First Aid"],
	{
		"*", AB.GetSpellNameByName("Alchemy"),
		"*", AB.GetSpellNameByName("Basic Campfire"),
		"*", AB.GetSpellNameByName("Blacksmithing"),
		"*", AB.GetSpellNameByName("Cooking"),
		"*", AB.GetSpellNameByName("Disenchant"),
		"*", AB.GetSpellNameByName("Enchanting"),
		"*", AB.GetSpellNameByName("Engineering"),
		"*", AB.GetSpellNameByName("First Aid"),
		"*", AB.GetSpellNameByName("Leatherworking"),
		"*", AB.GetSpellNameByName("Smelting"),
		"*", AB.GetSpellNameByName("Tailoring"),

		"*", AB.GetSpellNameByName("Find Minerals"),
		"*", AB.GetSpellNameByName("Find Herbs"),
	})

	AutoBarCategoryList["Spell.Debuff.Multiple"] = SpellsCategory:new("Spell.Debuff.Multiple", spellIconList["Slow"],
	{
		"DRUID",		AB.GetSpellNameByName("Disorienting Roar"),
	})

	AutoBarCategoryList["Spell.Debuff.Single"] = SpellsCategory:new("Spell.Debuff.Single", spellIconList["Slow"],
	{
		"HUNTER", AB.GetSpellNameByName("Concussive Shot"),
		"HUNTER", AB.GetSpellNameByName("Wing Clip"),
		"WARLOCK", AB.GetSpellNameByName("Curse of Tongues"),
		"WARLOCK", AB.GetSpellNameByName("Curse of Recklessness"),
		"WARLOCK", AB.GetSpellNameByName("Curse of Shadow"),
		"WARLOCK", AB.GetSpellNameByName("Curse of the Elements"),
		"WARLOCK", AB.GetSpellNameByName("Curse of Weakness"),	--y
	})


	AutoBarCategoryList["Spell.Fishing"] = SpellsCategory:new("Spell.Fishing", spellIconList["Fishing"],
	{
		"*", AB.GetSpellNameByName("Fishing"),
	})


	AutoBarCategoryList["Spell.Track"] = SpellsCategory:new( "Spell.Track", spellIconList["Track Beasts"],
	{
		"HUNTER", AB.GetSpellNameByName("Track Humanoids"),
		"HUNTER", AB.GetSpellNameByName("Track Undead"),
		"HUNTER", AB.GetSpellNameByName("Track Beasts"),
		"HUNTER", AB.GetSpellNameByName("Track Hidden"),
		"HUNTER", AB.GetSpellNameByName("Track Elementals"),
		"HUNTER", AB.GetSpellNameByName("Track Demons"),
		"HUNTER", AB.GetSpellNameByName("Track Dragonkin"),
		"HUNTER", AB.GetSpellNameByName("Track Giants"),
		"PALADIN", AB.GetSpellNameByName("Sense Undead"),
		"WARLOCK", AB.GetSpellNameByName("Sense Demons"),
	})

	AutoBarCategoryList["Spell.Trap"] = SpellsCategory:new( "Spell.Trap", spellIconList["Explosive Trap"],
	{
		"HUNTER", AB.GetSpellNameByName("Explosive Trap"),
		"HUNTER", AB.GetSpellNameByName("Freezing Trap"),
		"HUNTER", AB.GetSpellNameByName("Frost Trap"),
		"HUNTER", AB.GetSpellNameByName("Immolation Trap"),
		"ROGUE",  AB.GetSpellNameByName("Disarm Trap"),
	})


	AutoBarCategoryList["Misc.Mount.Summoned"] = SpellsCategory:new( "Misc.Mount.Summoned", spellIconList["Summon Dreadsteed"],
	{
		"SHAMAN", AB.GetSpellNameByName("Ghost Wolf"),
	})
	AutoBarCategoryList["Misc.Mount.Summoned"]:SetNonCombat(true)


	AutoBarCategoryList["Spell.Charge"] = SpellsCategory:new( "Spell.Charge", spellIconList["Charge"],
	{
		"WARRIOR", AB.GetSpellNameByName("Charge"),
		"WARRIOR", AB.GetSpellNameByName("Intercept"),
	})

	AutoBarCategoryList["Spell.ER"] = SpellsCategory:new( "Spell.ER", spellIconList["Charge"],
	{
		"DRUID", AB.GetSpellNameByName("Frenzied Regeneration"),
		"HUNTER", AB.GetSpellNameByName("Feign Death"),
		"HUNTER", AB.GetSpellNameByName("Disengage"),
		"MAGE", AB.GetSpellNameByName("Ice Block"),
		"PALADIN", AB.GetSpellNameByName("Lay on Hands"),
		"ROGUE", AB.GetSpellNameByName("Vanish"),
		"WARLOCK", AB.GetSpellNameByName("Dark Pact"),
		"WARRIOR", AB.GetSpellNameByName("Last Stand"),
	})

	AutoBarCategoryList["Spell.Interrupt"] = SpellsCategory:new( "Spell.Interrupt", spellIconList["Charge"],
	{
		"ROGUE", AB.GetSpellNameByName("Kick"),
		"SHAMAN", AB.GetSpellNameByName("Earth Shock"),
	})

	AutoBarCategoryList["Spell.CatForm"] = SpellsCategory:new( "Spell.CatForm", spellIconList["Charge"],
	{
		"DRUID", AB.GetSpellNameByName("Cat Form"),
	})

	AutoBarCategoryList["Spell.BearForm"] = SpellsCategory:new( "Spell.BearForm", spellIconList["Charge"],
	{
		"DRUID", AB.GetSpellNameByName("Bear Form"),
		"DRUID", AB.GetSpellNameByName("Dire Bear Form"),
	})

	AutoBarCategoryList["Spell.MoonkinForm"] = SpellsCategory:new( "Spell.MoonkinForm", spellIconList["Charge"],
	{
		"DRUID", AB.GetSpellNameByName("Moonkin Form"),
	})

	AutoBarCategoryList["Spell.AquaticForm"] = SpellsCategory:new( "Spell.MoonkinForm", spellIconList["Charge"],
	{
		"DRUID", AB.GetSpellNameByName("Aquatic Form"),
	})

	AutoBarCategoryList["Spell.TreeForm"] = SpellsCategory:new( "Spell.TreeForm", spellIconList["Charge"],
	{
		"DRUID", AB.GetSpellNameByName("Tree Form"),
	})

	AutoBarCategoryList["Spell.Travel"] = SpellsCategory:new( "Spell.Travel", spellIconList["Charge"],
	{
		"DRUID", AB.GetSpellNameByName("Travel Form"),
		"SHAMAN", AB.GetSpellNameByName("Ghost Wolf"),
	})

end

