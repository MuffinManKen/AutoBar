local AutoBar = AutoBar
local ABGCode = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject
local spellIconList = ABGData.spell_icon_list
local L = AutoBarGlobalDataObject.locale
local ItemsCategory = ABGCode.ItemsCategory
local MacroTextCategory = ABGCode.MacroTextCategory
local SpellsCategory = ABGCode.SpellsCategory



function ABGCode.InitializeCategories()

	AutoBarCategoryList["Muffin.Poison.Lethal"] = ItemsCategory:new("Muffin.Poison.Lethal", "INV_Misc_Food_95_Grainbread", "Muffin.Poison.Lethal")
	AutoBarCategoryList["Muffin.Poison.Nonlethal"] = ItemsCategory:new("Muffin.Poison.Nonlethal", "INV_Misc_Food_95_Grainbread", "Muffin.Poison.Nonlethal")

	AutoBarCategoryList["Muffin.Mounts.Item"] = ItemsCategory:new("Muffin.Mounts.Item", "ability_mount_ridinghorse", "Muffin.Mounts.Item")
	AutoBarCategoryList["Muffin.Mounts.Item"]:SetNonCombat(true)
	AutoBarCategoryList["Muffin.Mounts.Paladin"] = SpellsCategory:new("Muffin.Mounts.Paladin", "ability_mount_ridinghorse", "Muffin.Mounts.Paladin")
	AutoBarCategoryList["Muffin.Mounts.Paladin"]:SetNonCombat(true)
	AutoBarCategoryList["Muffin.Mounts.Warlock"] = SpellsCategory:new("Muffin.Mounts.Warlock", "ability_mount_ridinghorse", "Muffin.Mounts.Warlock")
	AutoBarCategoryList["Muffin.Mounts.Warlock"]:SetNonCombat(true)


	AutoBarCategoryList["Spell.Warlock.Create Healthstone"] = SpellsCategory:new( "Spell.Warlock.Create Healthstone", spellIconList["Create Healthstone"],
	{
		"WARLOCK", ABGCode.GetSpellNameByName("Create Healthstone (Minor)"),
		"WARLOCK", ABGCode.GetSpellNameByName("Create Healthstone (Lesser)"),
		"WARLOCK", ABGCode.GetSpellNameByName("Create Healthstone"),
		"WARLOCK", ABGCode.GetSpellNameByName("Create Healthstone (Greater)"),
		"WARLOCK", ABGCode.GetSpellNameByName("Create Healthstone (Major)"),
	})

	AutoBarCategoryList["Spell.Warlock.Create Soulstone"] = SpellsCategory:new( "Spell.Warlock.Create Soulstone", spellIconList["Create Soulstone"],
	{
		"WARLOCK", ABGCode.GetSpellNameByName("Create Soulstone (Minor)"),
		"WARLOCK", ABGCode.GetSpellNameByName("Create Soulstone (Lesser)"),
		"WARLOCK", ABGCode.GetSpellNameByName("Create Soulstone"),
		"WARLOCK", ABGCode.GetSpellNameByName("Create Soulstone (Greater)"),
		"WARLOCK", ABGCode.GetSpellNameByName("Create Soulstone (Major)"),
	})

	AutoBarCategoryList["Spell.Mage.Create Manastone"] = SpellsCategory:new( "Spell.Mage.Create Manastone", spellIconList["Conjure Mana Jade"],
	{
		"MAGE", ABGCode.GetSpellNameByName("Conjure Mana Jade"),
		"MAGE", ABGCode.GetSpellNameByName("Conjure Mana Ruby"),
		"MAGE", ABGCode.GetSpellNameByName("Conjure Mana Agate"),
		"MAGE", ABGCode.GetSpellNameByName("Conjure Mana Citrine"),
	})


	AutoBarCategoryList["Spell.Mage.Conjure Food"] = SpellsCategory:new( "Spell.Mage.Conjure Food", spellIconList["Conjure Refreshment"], {
		"MAGE", ABGCode.GetSpellNameByName("Conjure Food"),
	})

	AutoBarCategoryList["Spell.Mage.Conjure Water"] = SpellsCategory:new("Spell.Mage.Conjure Water", spellIconList["Conjure Refreshment"], {
		"MAGE", ABGCode.GetSpellNameByName("Conjure Water"),
	})

	AutoBarCategoryList["Consumable.Food.Conjure"] = SpellsCategory:new("Consumable.Food.Conjure", spellIconList["Conjure Refreshment"], {
--			"MAGE", ABGCode.GetSpellNameByName("Conjure Refreshment"),
			})


	AutoBarCategoryList["Spell.Stealth"] = SpellsCategory:new("Spell.Stealth", spellIconList["Stealth"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Prowl"),
		"MAGE", ABGCode.GetSpellNameByName("Invisibility"),
		"MAGE", ABGCode.GetSpellNameByName("Lesser Invisibility"),
		"ROGUE", ABGCode.GetSpellNameByName("Stealth"),	--y
		"*", ABGCode.GetSpellNameByName("Shadowmeld"),	--y
	})

	AutoBarCategoryList["Spell.Aspect"] = SpellsCategory:new("Spell.Aspect", spellIconList["Aspect of the Cheetah"],
	{
		"HUNTER", ABGCode.GetSpellNameByName("Aspect of the Cheetah"),
		"HUNTER", ABGCode.GetSpellNameByName("Aspect of the Hawk"),
		"HUNTER", ABGCode.GetSpellNameByName("Aspect of the Monkey"),
		"HUNTER", ABGCode.GetSpellNameByName("Aspect of the Wild"),
		"HUNTER", ABGCode.GetSpellNameByName("Aspect of the Pack"),
		"HUNTER", ABGCode.GetSpellNameByName("Aspect of the Beast"),
	})

	AutoBarCategoryList["Spell.Class.Buff"] = SpellsCategory:new( "Spell.Class.Buff", spellIconList["Barkskin"],
	{
		"MAGE", ABGCode.GetSpellNameByName("Slow Fall"),
		"MAGE", ABGCode.GetSpellNameByName("Arcane Intellect"),
		"MAGE", ABGCode.GetSpellNameByName("Arcane Brilliance"),
		"MAGE", ABGCode.GetSpellNameByName("Amplify Magic"),
		"MAGE", ABGCode.GetSpellNameByName("Dampen Magic"),
		"DRUID", ABGCode.GetSpellNameByName("Mark of the Wild"),
		"DRUID", ABGCode.GetSpellNameByName("Gift of the Wild"),
		"DRUID", ABGCode.GetSpellNameByName("Thorns"),
		"PALADIN", ABGCode.GetSpellNameByName("Blessing of Might"),
		"PALADIN", ABGCode.GetSpellNameByName("Blessing of Protection"),
		"PALADIN", ABGCode.GetSpellNameByName("Blessing of Sacrifice"),
		"PALADIN", ABGCode.GetSpellNameByName("Blessing of Salvation"),
		"PALADIN", ABGCode.GetSpellNameByName("Greater Blessing of Kings"),
		"PALADIN", ABGCode.GetSpellNameByName("Greater Blessing of Wisdom"),
		"PRIEST", ABGCode.GetSpellNameByName("Power Word: Fortitude");
		"SHAMAN", ABGCode.GetSpellNameByName("Water Walking"),
		"WARLOCK", ABGCode.GetSpellNameByName("Unending Breath"),
		"WARRIOR", ABGCode.GetSpellNameByName("Battle Shout"),
	})

	AutoBarCategoryList["Spell.Class.Pet"] = SpellsCategory:new( "Spell.Class.Pet", spellIconList["Call Pet 1"],
	{
		"HUNTER", ABGCode.GetSpellNameByName("Call Pet"),
		"WARLOCK", ABGCode.GetSpellNameByName("Eye of Kilrogg"),
		"WARLOCK", ABGCode.GetSpellNameByName("Summon Infernal"),
		"WARLOCK", ABGCode.GetSpellNameByName("Summon Felhunter"),
		"WARLOCK", ABGCode.GetSpellNameByName("Summon Imp"),
		"WARLOCK", ABGCode.GetSpellNameByName("Summon Succubus"),
		"WARLOCK", ABGCode.GetSpellNameByName("Summon Voidwalker"),
	})



	AutoBarCategoryList["Spell.Class.Pets2"] = SpellsCategory:new( "Spell.Class.Pets2", spellIconList["Call Pet 1"],
	{
		"HUNTER", ABGCode.GetSpellNameByName("Bestial Wrath"),
		"HUNTER", ABGCode.GetSpellNameByName("Mend Pet"),
		"HUNTER", ABGCode.GetSpellNameByName("Intimidation"),
	})

	--Misc pet abilities
	AutoBarCategoryList["Spell.Class.Pets3"] = SpellsCategory:new(	"Spell.Class.Pets3", spellIconList["Feed Pet"],
	{
		"HUNTER", ABGCode.GetSpellNameByName("Dismiss Pet"),
		"HUNTER", ABGCode.GetSpellNameByName("Eagle Eye"),
		"HUNTER", ABGCode.GetSpellNameByName("Feed Pet"),
		"HUNTER", ABGCode.GetSpellNameByName("Revive Pet"),
		"HUNTER", ABGCode.GetSpellNameByName("Tame Beast"),
		"HUNTER", ABGCode.GetSpellNameByName("Beast Lore"),
	})

	AutoBarCategoryList["Spell.Portals"] = SpellsCategory:new( "Spell.Portals", "spell_arcane_portalironforge", nil,
	{
		"DRUID", ABGCode.GetSpellNameByName("Teleport: Moonglade"), ABGCode.GetSpellNameByName("Teleport: Moonglade"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Undercity"), ABGCode.GetSpellNameByName("Portal: Undercity"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Thunder Bluff"), ABGCode.GetSpellNameByName("Portal: Thunder Bluff"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Stormwind"), ABGCode.GetSpellNameByName("Portal: Stormwind"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Darnassus"), ABGCode.GetSpellNameByName("Portal: Darnassus"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Ironforge"), ABGCode.GetSpellNameByName("Portal: Ironforge"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Orgrimmar"), ABGCode.GetSpellNameByName("Portal: Orgrimmar"),
		"SHAMAN", ABGCode.GetSpellNameByName("Astral Recall"), ABGCode.GetSpellNameByName("Astral Recall"),
		"WARLOCK", ABGCode.GetSpellNameByName("Ritual of Summoning"), ABGCode.GetSpellNameByName("Ritual of Summoning"),
	})


	AutoBarCategoryList["Spell.Shields"] = SpellsCategory:new( "Spell.Shields", spellIconList["Ice Barrier"], nil,
	{
		"DRUID", 		ABGCode.GetSpellNameByName("Barkskin"), 	ABGCode.GetSpellNameByName("Barkskin"),
		"MAGE", 			ABGCode.GetSpellNameByName("Frost Armor"), ABGCode.GetSpellNameByName("Ice Barrier"),
		"MAGE", 			ABGCode.GetSpellNameByName("Ice Armor"), ABGCode.GetSpellNameByName("Ice Barrier"),
		"MAGE", 			ABGCode.GetSpellNameByName("Mage Armor"), ABGCode.GetSpellNameByName("Ice Barrier"),
		"PALADIN", 		ABGCode.GetSpellNameByName("Divine Protection"), ABGCode.GetSpellNameByName("Divine Shield"),
		"PALADIN", 		ABGCode.GetSpellNameByName("Divine Shield"), ABGCode.GetSpellNameByName("Divine Protection"),
		"PRIEST", 		ABGCode.GetSpellNameByName("Power Word: Shield"), ABGCode.GetSpellNameByName("Power Word: Shield"),
		"ROGUE", 		ABGCode.GetSpellNameByName("Evasion"), 		ABGCode.GetSpellNameByName("Evasion"),
		"WARRIOR", 		ABGCode.GetSpellNameByName("Shield Block"), ABGCode.GetSpellNameByName("Shield Wall"),
		"WARRIOR", 		ABGCode.GetSpellNameByName("Shield Wall"), ABGCode.GetSpellNameByName("Shield Block"),


		"WARLOCK", ABGCode.GetSpellNameByName("Demon Skin"),  ABGCode.GetSpellNameByName("Shadow Ward"),
		"WARLOCK", ABGCode.GetSpellNameByName("Demon Armor"), ABGCode.GetSpellNameByName("Shadow Ward"),
		"WARLOCK", ABGCode.GetSpellNameByName("Shadow Ward"), ABGCode.GetSpellNameByName("Shadow Ward"),

	})

	AutoBarCategoryList["Spell.Stance"] = SpellsCategory:new( "Spell.Stance", spellIconList["Defensive Stance"], {
		"DRUID", ABGCode.GetSpellNameByName("Bear Form"),
		"DRUID", ABGCode.GetSpellNameByName("Dire Bear Form"),
		"DRUID", ABGCode.GetSpellNameByName("Cat Form"),
		"DRUID", ABGCode.GetSpellNameByName("Aquatic Form"),
		"DRUID", ABGCode.GetSpellNameByName("Moonkin Form"),
		"DRUID", ABGCode.GetSpellNameByName("Tree Form"),
		"DRUID", ABGCode.GetSpellNameByName("Travel Form"),
		"PALADIN", ABGCode.GetSpellNameByName("Devotion Aura"),
		"PALADIN", ABGCode.GetSpellNameByName("Retribution Aura"),
		"PALADIN", ABGCode.GetSpellNameByName("Concentration Aura"),
		"PALADIN", ABGCode.GetSpellNameByName("Fire Resistance Aura"),
		"PALADIN", ABGCode.GetSpellNameByName("Frost Resistance Aura"),
		"PALADIN", ABGCode.GetSpellNameByName("Sanctity Aura"),
		"PALADIN", ABGCode.GetSpellNameByName("Shadow Resistance Aura"),
		"WARRIOR", ABGCode.GetSpellNameByName("Defensive Stance"),
		"WARRIOR", ABGCode.GetSpellNameByName("Battle Stance"),
		"WARRIOR", ABGCode.GetSpellNameByName("Berserker Stance"),
	})

	AutoBarCategoryList["Spell.Seal"] = SpellsCategory:new( "Spell.Seal", spellIconList["Seal of the Crusader"], {
		"PALADIN", ABGCode.GetSpellNameByName("Seal of Command"),
		"PALADIN", ABGCode.GetSpellNameByName("Seal of Justice"),
		"PALADIN", ABGCode.GetSpellNameByName("Seal of Light"),
		"PALADIN", ABGCode.GetSpellNameByName("Seal of Righteousness"),
		"PALADIN", ABGCode.GetSpellNameByName("Seal of the Crusader"),
		"PALADIN", ABGCode.GetSpellNameByName("Seal of Wisdom"),
	})

	AutoBarCategoryList["Spell.Totem.Earth"] = SpellsCategory:new("Spell.Totem.Earth", spellIconList["Earthgrab Totem"],
	{
		"SHAMAN", ABGCode.GetSpellNameByName("Earthbind Totem"),
		"SHAMAN", ABGCode.GetSpellNameByName("Stoneclaw Totem"),
		"SHAMAN", ABGCode.GetSpellNameByName("Stoneskin Totem"),
		"SHAMAN", ABGCode.GetSpellNameByName("Strength of Earth Totem"),
		"SHAMAN", ABGCode.GetSpellNameByName("Tremor Totem");
	})


	AutoBarCategoryList["Spell.Totem.Air"] = SpellsCategory:new("Spell.Totem.Air", spellIconList["Wind Rush Totem"],
	{
		"SHAMAN", ABGCode.GetSpellNameByName("Grace of Air Totem");
		"SHAMAN", ABGCode.GetSpellNameByName("Grounding Totem");
		"SHAMAN", ABGCode.GetSpellNameByName("Nature Resistance Totem");
		"SHAMAN", ABGCode.GetSpellNameByName("Sentry Totem");
		"SHAMAN", ABGCode.GetSpellNameByName("Tranquil Air Totem");
		"SHAMAN", ABGCode.GetSpellNameByName("Windfury Totem");
		"SHAMAN", ABGCode.GetSpellNameByName("Windwall Totem");
	})

	AutoBarCategoryList["Spell.Totem.Fire"] = SpellsCategory:new("Spell.Totem.Fire", spellIconList["Liquid Magma Totem"],
	{
		"SHAMAN", ABGCode.GetSpellNameByName("Fire Nova Totem");
		"SHAMAN", ABGCode.GetSpellNameByName("Flametongue Totem");
		"SHAMAN", ABGCode.GetSpellNameByName("Frost Resistance Totem");
		"SHAMAN", ABGCode.GetSpellNameByName("Magma Totem");
		"SHAMAN", ABGCode.GetSpellNameByName("Searing Totem");
	})

	AutoBarCategoryList["Spell.Totem.Water"] = SpellsCategory:new("Spell.Totem.Water", spellIconList["Healing Stream Totem"],
	{
		"SHAMAN", ABGCode.GetSpellNameByName("Disease Cleansing Totem");
		"SHAMAN", ABGCode.GetSpellNameByName("Fire Resistance Totem");
		"SHAMAN", ABGCode.GetSpellNameByName("Healing Stream Totem");
		"SHAMAN", ABGCode.GetSpellNameByName("Mana Spring Totem");
		"SHAMAN", ABGCode.GetSpellNameByName("Poison Cleansing Totem");
	})


	AutoBarCategoryList["Spell.Buff.Weapon"] = SpellsCategory:new("Spell.Buff.Weapon", spellIconList["Deadly Poison"],
	{
		"SHAMAN", ABGCode.GetSpellNameByName("Flametongue Weapon"),
		"SHAMAN", ABGCode.GetSpellNameByName("Frostbrand Weapon"),
		"SHAMAN", ABGCode.GetSpellNameByName("Rockbiter Weapon"),
		"SHAMAN", ABGCode.GetSpellNameByName("Windfury Weapon"),
	})

	AutoBarCategoryList["Spell.Crafting"] = SpellsCategory:new( "Spell.Crafting", spellIconList["First Aid"],
	{
		"*", ABGCode.GetSpellNameByName("Alchemy"),
		"*", ABGCode.GetSpellNameByName("Basic Campfire"),
		"*", ABGCode.GetSpellNameByName("Blacksmithing"),
		"*", ABGCode.GetSpellNameByName("Cooking"),
		"*", ABGCode.GetSpellNameByName("Disenchant"),
		"*", ABGCode.GetSpellNameByName("Enchanting"),
		"*", ABGCode.GetSpellNameByName("Engineering"),
		"*", ABGCode.GetSpellNameByName("First Aid"),
		"*", ABGCode.GetSpellNameByName("Leatherworking"),
		"*", ABGCode.GetSpellNameByName("Smelting"),
		"*", ABGCode.GetSpellNameByName("Tailoring"),

		"*", ABGCode.GetSpellNameByName("Find Minerals"),
		"*", ABGCode.GetSpellNameByName("Find Herbs"),
	})

	AutoBarCategoryList["Spell.Debuff.Multiple"] = SpellsCategory:new("Spell.Debuff.Multiple", spellIconList["Slow"],
	{
		"DRUID",		ABGCode.GetSpellNameByName("Disorienting Roar"),
	})

	AutoBarCategoryList["Spell.Debuff.Single"] = SpellsCategory:new("Spell.Debuff.Single", spellIconList["Slow"],
	{
		"HUNTER", ABGCode.GetSpellNameByName("Concussive Shot"),
		"HUNTER", ABGCode.GetSpellNameByName("Wing Clip"),
		"WARLOCK", ABGCode.GetSpellNameByName("Curse of Tongues"),
		"WARLOCK", ABGCode.GetSpellNameByName("Curse of Recklessness"),
		"WARLOCK", ABGCode.GetSpellNameByName("Curse of Shadow"),
		"WARLOCK", ABGCode.GetSpellNameByName("Curse of the Elements"),
		"WARLOCK", ABGCode.GetSpellNameByName("Curse of Weakness"),	--y
	})


	AutoBarCategoryList["Spell.Fishing"] = SpellsCategory:new("Spell.Fishing", spellIconList["Fishing"],
	{
		"*", ABGCode.GetSpellNameByName("Fishing"), --y
	})


	AutoBarCategoryList["Spell.Track"] = SpellsCategory:new( "Spell.Track", spellIconList["Track Beasts"],
	{
		"HUNTER", ABGCode.GetSpellNameByName("Track Humanoids"),
		"HUNTER", ABGCode.GetSpellNameByName("Track Undead"),
		"HUNTER", ABGCode.GetSpellNameByName("Track Beasts"),
		"HUNTER", ABGCode.GetSpellNameByName("Track Hidden"),
		"HUNTER", ABGCode.GetSpellNameByName("Track Elementals"),
		"HUNTER", ABGCode.GetSpellNameByName("Track Demons"),
		"HUNTER", ABGCode.GetSpellNameByName("Track Dragonkin"),
		"HUNTER", ABGCode.GetSpellNameByName("Track Giants"),
		"PALADIN", ABGCode.GetSpellNameByName("Sense Undead"),
		"WARLOCK", ABGCode.GetSpellNameByName("Sense Demons"),
	})

	AutoBarCategoryList["Spell.Trap"] = SpellsCategory:new( "Spell.Trap", spellIconList["Explosive Trap"],
	{
		"HUNTER", ABGCode.GetSpellNameByName("Explosive Trap"),
		"HUNTER", ABGCode.GetSpellNameByName("Freezing Trap"),
		"HUNTER", ABGCode.GetSpellNameByName("Frost Trap"),
		"HUNTER", ABGCode.GetSpellNameByName("Immolation Trap"),
		"ROGUE",  ABGCode.GetSpellNameByName("Disarm Trap"),
	})


	AutoBarCategoryList["Misc.Mount.Summoned"] = SpellsCategory:new( "Misc.Mount.Summoned", spellIconList["Summon Dreadsteed"],
	{
		"SHAMAN", ABGCode.GetSpellNameByName("Ghost Wolf"),
	})
	AutoBarCategoryList["Misc.Mount.Summoned"]:SetNonCombat(true)


	AutoBarCategoryList["Spell.Charge"] = SpellsCategory:new( "Spell.Charge", spellIconList["Charge"],
	{
		"WARRIOR", ABGCode.GetSpellNameByName("Charge"),
		"WARRIOR", ABGCode.GetSpellNameByName("Intercept"),
	})

	AutoBarCategoryList["Spell.ER"] = SpellsCategory:new( "Spell.ER", spellIconList["Charge"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Frenzied Regeneration"),
		"HUNTER", ABGCode.GetSpellNameByName("Feign Death"),
		"HUNTER", ABGCode.GetSpellNameByName("Disengage"),
		"MAGE", ABGCode.GetSpellNameByName("Ice Block"),
		"PALADIN", ABGCode.GetSpellNameByName("Lay on Hands"),
		"ROGUE", ABGCode.GetSpellNameByName("Vanish"),
		"WARLOCK", ABGCode.GetSpellNameByName("Dark Pact"),
		"WARRIOR", ABGCode.GetSpellNameByName("Last Stand"),
	})

	AutoBarCategoryList["Spell.Interrupt"] = SpellsCategory:new( "Spell.Interrupt", spellIconList["Charge"],
	{
		"ROGUE", ABGCode.GetSpellNameByName("Kick"),
		"SHAMAN", ABGCode.GetSpellNameByName("Earth Shock"),
	})

	AutoBarCategoryList["Spell.CatForm"] = SpellsCategory:new( "Spell.CatForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Cat Form"),
	})

	AutoBarCategoryList["Spell.BearForm"] = SpellsCategory:new( "Spell.BearForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Bear Form"),
		"DRUID", ABGCode.GetSpellNameByName("Dire Bear Form"),
	})

	AutoBarCategoryList["Spell.MoonkinForm"] = SpellsCategory:new( "Spell.MoonkinForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Moonkin Form"),
	})

	AutoBarCategoryList["Spell.AquaticForm"] = SpellsCategory:new( "Spell.MoonkinForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Aquatic Form"),
	})

	AutoBarCategoryList["Spell.TreeForm"] = SpellsCategory:new( "Spell.TreeForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Tree Form"),
	})

	AutoBarCategoryList["Spell.Travel"] = SpellsCategory:new( "Spell.Travel", spellIconList["Charge"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Travel Form"),
		"SHAMAN", ABGCode.GetSpellNameByName("Ghost Wolf"),
	})

end

