local AutoBar = AutoBar
local ABGCode = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject
local spellIconList = ABGData.spell_icon_list
local L = AutoBarGlobalDataObject.locale



function ABGCode:InitializeCategories()

	AutoBarCategoryList["Muffin.Poison.Lethal"] = AutoBarItems:new("Muffin.Poison.Lethal", "INV_Misc_Food_95_Grainbread", "Muffin.Poison.Lethal")
	AutoBarCategoryList["Muffin.Poison.Nonlethal"] = AutoBarItems:new("Muffin.Poison.Nonlethal", "INV_Misc_Food_95_Grainbread", "Muffin.Poison.Nonlethal")

	AutoBarCategoryList["Muffin.Mounts"] = AutoBarItems:new("Muffin.Mounts", "ability_mount_ridinghorse", "Muffin.Mounts")
	AutoBarCategoryList["Muffin.Mounts"]:SetNonCombat(true)


	AutoBarCategoryList["Spell.Warlock.Create Healthstone"] = AutoBarSpells:new( "Spell.Warlock.Create Healthstone", spellIconList["Create Healthstone"],
	{
		"WARLOCK", ABGCode:GetSpellNameByName("Create Healthstone (Minor)"),
		"WARLOCK", ABGCode:GetSpellNameByName("Create Healthstone (Lesser)"),
		"WARLOCK", ABGCode:GetSpellNameByName("Create Healthstone"),
		"WARLOCK", ABGCode:GetSpellNameByName("Create Healthstone (Greater)"),
		"WARLOCK", ABGCode:GetSpellNameByName("Create Healthstone (Major)"),
	})

	AutoBarCategoryList["Spell.Warlock.Create Soulstone"] = AutoBarSpells:new( "Spell.Warlock.Create Soulstone", spellIconList["Create Soulstone (Minor)"],
	{
		"WARLOCK", ABGCode:GetSpellNameByName("Create Soulstone (Minor)"),
		"WARLOCK", ABGCode:GetSpellNameByName("Create Soulstone (Lesser)"),
		"WARLOCK", ABGCode:GetSpellNameByName("Create Soulstone"),
		"WARLOCK", ABGCode:GetSpellNameByName("Create Soulstone (Greater)"),
		"WARLOCK", ABGCode:GetSpellNameByName("Create Soulstone (Major)"),
	})


	AutoBarCategoryList["Spell.Mage.Conjure Food"] = AutoBarSpells:new( "Spell.Mage.Conjure Food", spellIconList["Conjure Refreshment"], {
		"MAGE", ABGCode:GetSpellNameByName("Conjure Food"),
	})

	AutoBarCategoryList["Spell.Mage.Conjure Water"] = AutoBarSpells:new("Spell.Mage.Conjure Water", spellIconList["Conjure Refreshment"], {
		"MAGE", ABGCode:GetSpellNameByName("Conjure Water"),
	})

	AutoBarCategoryList["Consumable.Food.Conjure"] = AutoBarSpells:new("Consumable.Food.Conjure", spellIconList["Conjure Refreshment"], {
--			"MAGE", ABGCode:GetSpellNameByName("Conjure Refreshment"),
			})


	AutoBarCategoryList["Spell.Stealth"] = AutoBarSpells:new("Spell.Stealth", spellIconList["Stealth"],
	{
		"DRUID", ABGCode:GetSpellNameByName("Prowl"),
		"MAGE", ABGCode:GetSpellNameByName("Invisibility"),
		"MAGE", ABGCode:GetSpellNameByName("Lesser Invisibility"),
		"ROGUE", ABGCode:GetSpellNameByName("Stealth"),	--y
		"*", ABGCode:GetSpellNameByName("Shadowmeld"),	--y
	})

	AutoBarCategoryList["Spell.Aspect"] = AutoBarSpells:new("Spell.Aspect", spellIconList["Aspect of the Cheetah"],
	{
		"HUNTER", ABGCode:GetSpellNameByName("Aspect of the Cheetah"),
		"HUNTER", ABGCode:GetSpellNameByName("Aspect of the Hawk"),
		"HUNTER", ABGCode:GetSpellNameByName("Aspect of the Monkey"),
		"HUNTER", ABGCode:GetSpellNameByName("Aspect of the Wild"),
	})

	AutoBarCategoryList["Spell.Class.Buff"] = AutoBarSpells:new( "Spell.Class.Buff", spellIconList["Barkskin"],
	{
		"MAGE", ABGCode:GetSpellNameByName("Slow Fall"),
		"MAGE", ABGCode:GetSpellNameByName("Arcane Intellect"),
		"DRUID", ABGCode:GetSpellNameByName("Mark of the Wild"),
		"DRUID", ABGCode:GetSpellNameByName("Gift of the Wild"),
		"DRUID", ABGCode:GetSpellNameByName("Thorns"),
		"PALADIN", ABGCode:GetSpellNameByName("Blessing of Might"),
		"PALADIN", ABGCode:GetSpellNameByName("Blessing of Protection"),
		"PALADIN", ABGCode:GetSpellNameByName("Blessing of Sacrifice"),
		"PALADIN", ABGCode:GetSpellNameByName("Blessing of Salvation"),
		"PALADIN", ABGCode:GetSpellNameByName("Greater Blessing of Kings"),
		"PALADIN", ABGCode:GetSpellNameByName("Greater Blessing of Wisdom"),
		"SHAMAN", ABGCode:GetSpellNameByName("Water Walking"),
		"WARLOCK", ABGCode:GetSpellNameByName("Unending Breath"),
		"WARRIOR", ABGCode:GetSpellNameByName("Battle Shout"),
	})

	AutoBarCategoryList["Spell.Class.Pet"] = AutoBarSpells:new( "Spell.Class.Pet", spellIconList["Call Pet 1"],
	{
		"HUNTER", ABGCode:GetSpellNameByName("Call Pet"),
		"WARLOCK", ABGCode:GetSpellNameByName("Eye of Kilrogg"),
		"WARLOCK", ABGCode:GetSpellNameByName("Summon Infernal"),
		"WARLOCK", ABGCode:GetSpellNameByName("Summon Felhunter"),
		"WARLOCK", ABGCode:GetSpellNameByName("Summon Imp"),
		"WARLOCK", ABGCode:GetSpellNameByName("Summon Succubus"),
		"WARLOCK", ABGCode:GetSpellNameByName("Summon Voidwalker"),
	})



	AutoBarCategoryList["Spell.Class.Pets2"] = AutoBarSpells:new( "Spell.Class.Pets2", spellIconList["Call Pet 1"],
	{
		"HUNTER", ABGCode:GetSpellNameByName("Bestial Wrath"),
		"HUNTER", ABGCode:GetSpellNameByName("Mend Pet"),
		"HUNTER", ABGCode:GetSpellNameByName("Intimidation"),
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
	})

	AutoBarCategoryList["Spell.Portals"] = AutoBarSpells:new( "Spell.Portals", "spell_arcane_portalironforge", nil,
	{
		"DRUID", ABGCode:GetSpellNameByName("Teleport: Moonglade"), ABGCode:GetSpellNameByName("Teleport: Moonglade"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Undercity"), ABGCode:GetSpellNameByName("Portal: Undercity"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Thunder Bluff"), ABGCode:GetSpellNameByName("Portal: Thunder Bluff"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Stormwind"), ABGCode:GetSpellNameByName("Portal: Stormwind"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Darnassus"), ABGCode:GetSpellNameByName("Portal: Darnassus"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Ironforge"), ABGCode:GetSpellNameByName("Portal: Ironforge"),
		"MAGE", ABGCode:GetSpellNameByName("Teleport: Orgrimmar"), ABGCode:GetSpellNameByName("Portal: Orgrimmar"),
		"SHAMAN", ABGCode:GetSpellNameByName("Astral Recall"), ABGCode:GetSpellNameByName("Astral Recall"),
		"WARLOCK", ABGCode:GetSpellNameByName("Ritual of Summoning"), ABGCode:GetSpellNameByName("Ritual of Summoning"),
	})


	AutoBarCategoryList["Spell.Shields"] = AutoBarSpells:new( "Spell.Shields", spellIconList["Ice Barrier"], nil,
	{
		"DRUID", 		ABGCode:GetSpellNameByName("Barkskin"), 	ABGCode:GetSpellNameByName("Barkskin"),
		"MAGE", 			ABGCode:GetSpellNameByName("Frost Armor"), ABGCode:GetSpellNameByName("Ice Barrier"),
		"PALADIN", 		ABGCode:GetSpellNameByName("Divine Protection"), ABGCode:GetSpellNameByName("Divine Shield"),
		"PALADIN", 		ABGCode:GetSpellNameByName("Divine Shield"), ABGCode:GetSpellNameByName("Divine Protection"),
		"PRIEST", 		ABGCode:GetSpellNameByName("Power Word: Shield"), ABGCode:GetSpellNameByName("Power Word: Shield"),
		"ROGUE", 		ABGCode:GetSpellNameByName("Evasion"), 		ABGCode:GetSpellNameByName("Evasion"),
		"WARRIOR", 		ABGCode:GetSpellNameByName("Shield Block"), ABGCode:GetSpellNameByName("Shield Wall"),
		"WARRIOR", 		ABGCode:GetSpellNameByName("Shield Wall"), ABGCode:GetSpellNameByName("Shield Block"),


		"WARLOCK", ABGCode:GetSpellNameByName("Demon Skin"),  ABGCode:GetSpellNameByName("Shadow Ward"),
		"WARLOCK", ABGCode:GetSpellNameByName("Demon Armor"), ABGCode:GetSpellNameByName("Shadow Ward"),
		"WARLOCK", ABGCode:GetSpellNameByName("Shadow Ward"), ABGCode:GetSpellNameByName("Shadow Ward"),

	})

	AutoBarCategoryList["Spell.Stance"] = AutoBarSpells:new( "Spell.Stance", spellIconList["Defensive Stance"], {
		"DRUID", ABGCode:GetSpellNameByName("Bear Form"),
		"DRUID", ABGCode:GetSpellNameByName("Cat Form"),
		"DRUID", ABGCode:GetSpellNameByName("Aquatic Form"),
		"DRUID", ABGCode:GetSpellNameByName("Moonkin Form"),
		"DRUID", ABGCode:GetSpellNameByName("Tree Form"),
		"DRUID", ABGCode:GetSpellNameByName("Travel Form"),
		"PALADIN", ABGCode:GetSpellNameByName("Devotion Aura"),
		"WARRIOR", ABGCode:GetSpellNameByName("Defensive Stance"),
		"WARRIOR", ABGCode:GetSpellNameByName("Battle Stance"),
		"WARRIOR", ABGCode:GetSpellNameByName("Berserker Stance"),

	})


	AutoBarCategoryList["Spell.Totem.Earth"] = AutoBarSpells:new("Spell.Totem.Earth", spellIconList["Earthgrab Totem"],
	{
		"SHAMAN", ABGCode:GetSpellNameByName("Earthbind Totem"),
		"SHAMAN", ABGCode:GetSpellNameByName("Stoneclaw Totem"),
		"SHAMAN", ABGCode:GetSpellNameByName("Stoneskin Totem"),
		"SHAMAN", ABGCode:GetSpellNameByName("Strength of Earth Totem"),
		"SHAMAN", ABGCode:GetSpellNameByName("Tremor Totem");
	})


	AutoBarCategoryList["Spell.Totem.Air"] = AutoBarSpells:new("Spell.Totem.Air", spellIconList["Wind Rush Totem"],
	{
		"SHAMAN", ABGCode:GetSpellNameByName("Grace of Air Totem");
		"SHAMAN", ABGCode:GetSpellNameByName("Grounding Totem");
		"SHAMAN", ABGCode:GetSpellNameByName("Nature Resistance Totem");
		"SHAMAN", ABGCode:GetSpellNameByName("Sentry Totem");
		"SHAMAN", ABGCode:GetSpellNameByName("Tranquil Air Totem");
		"SHAMAN", ABGCode:GetSpellNameByName("Windfury Totem");
		"SHAMAN", ABGCode:GetSpellNameByName("Windwall Totem");
	})

	AutoBarCategoryList["Spell.Totem.Fire"] = AutoBarSpells:new("Spell.Totem.Fire", spellIconList["Liquid Magma Totem"],
	{
		"SHAMAN", ABGCode:GetSpellNameByName("Fire Nova Totem");
		"SHAMAN", ABGCode:GetSpellNameByName("Flametongue Totem");
		"SHAMAN", ABGCode:GetSpellNameByName("Frost Resistance Totem");
		"SHAMAN", ABGCode:GetSpellNameByName("Magma Totem");
		"SHAMAN", ABGCode:GetSpellNameByName("Searing Totem");
	})

	AutoBarCategoryList["Spell.Totem.Water"] = AutoBarSpells:new("Spell.Totem.Water", spellIconList["Healing Stream Totem"],
	{
		"SHAMAN", ABGCode:GetSpellNameByName("Disease Cleansing Totem");
		"SHAMAN", ABGCode:GetSpellNameByName("Fire Resistance Totem");
		"SHAMAN", ABGCode:GetSpellNameByName("Healing Stream Totem");
		"SHAMAN", ABGCode:GetSpellNameByName("Mana Spring Totem");
		"SHAMAN", ABGCode:GetSpellNameByName("Poison Cleansing Totem");
	})


	AutoBarCategoryList["Spell.Buff.Weapon"] = AutoBarSpells:new("Spell.Buff.Weapon", spellIconList["Deadly Poison"],
	{
		"SHAMAN", ABGCode:GetSpellNameByName("Flametongue Weapon"),
		"SHAMAN", ABGCode:GetSpellNameByName("Frostbrand Weapon"),
		"SHAMAN", ABGCode:GetSpellNameByName("Rockbiter Weapon"),
		"SHAMAN", ABGCode:GetSpellNameByName("Windfury Weapon"),
	})

	AutoBarCategoryList["Spell.Crafting"] = AutoBarSpells:new( "Spell.Crafting", spellIconList["First Aid"],
	{
		"*", ABGCode:GetSpellNameByName("Alchemy"),
		"*", ABGCode:GetSpellNameByName("Basic Campfire"),
		"*", ABGCode:GetSpellNameByName("Blacksmithing"),
		"*", ABGCode:GetSpellNameByName("Cooking"),
		"*", ABGCode:GetSpellNameByName("Disenchant"),
		"*", ABGCode:GetSpellNameByName("Enchanting"),
		"*", ABGCode:GetSpellNameByName("Engineering"),
		"*", ABGCode:GetSpellNameByName("First Aid"),
		"*", ABGCode:GetSpellNameByName("Leatherworking"),
		"*", ABGCode:GetSpellNameByName("Smelting"),
		"*", ABGCode:GetSpellNameByName("Tailoring"),

		"*", ABGCode:GetSpellNameByName("Find Minerals"),
		"*", ABGCode:GetSpellNameByName("Find Herbs"),
	})

	AutoBarCategoryList["Spell.Debuff.Multiple"] = AutoBarSpells:new("Spell.Debuff.Multiple", spellIconList["Slow"],
	{
		"DRUID",		ABGCode:GetSpellNameByName("Disorienting Roar"),
	})

	AutoBarCategoryList["Spell.Debuff.Single"] = AutoBarSpells:new("Spell.Debuff.Single", spellIconList["Slow"],
	{
		"HUNTER", ABGCode:GetSpellNameByName("Concussive Shot"),
		"HUNTER", ABGCode:GetSpellNameByName("Wing Clip"),
		"WARLOCK", ABGCode:GetSpellNameByName("Curse of Tongues"),
		"WARLOCK", ABGCode:GetSpellNameByName("Curse of Recklessness"),
		"WARLOCK", ABGCode:GetSpellNameByName("Curse of Shadow"),
		"WARLOCK", ABGCode:GetSpellNameByName("Curse of the Elements"),
		"WARLOCK", ABGCode:GetSpellNameByName("Curse of Weakness"),	--y
	})


	AutoBarCategoryList["Spell.Fishing"] = AutoBarSpells:new("Spell.Fishing", spellIconList["Fishing"],
	{
		"*", ABGCode:GetSpellNameByName("Fishing"), --y
	})


	AutoBarCategoryList["Spell.Track"] = AutoBarSpells:new( "Spell.Track", spellIconList["Explosive Trap"],
	{
		"HUNTER", ABGCode:GetSpellNameByName("Track Humanoids"),
		"HUNTER", ABGCode:GetSpellNameByName("Track Undead"),
		"HUNTER", ABGCode:GetSpellNameByName("Track Beasts"),
		"HUNTER", ABGCode:GetSpellNameByName("Track Hidden"),
		"HUNTER", ABGCode:GetSpellNameByName("Track Elementals"),

		"WARLOCK", ABGCode:GetSpellNameByName("Sense Demons"),
	})

	AutoBarCategoryList["Spell.Trap"] = AutoBarSpells:new( "Spell.Trap", spellIconList["Explosive Trap"],
	{
		"HUNTER", ABGCode:GetSpellNameByName("Explosive Trap"),
		"HUNTER", ABGCode:GetSpellNameByName("Freezing Trap"),
		"HUNTER", ABGCode:GetSpellNameByName("Immolation Trap"),
		"ROGUE",  ABGCode:GetSpellNameByName("Disarm Trap"),
	})


	AutoBarCategoryList["Misc.Mount.Summoned"] = AutoBarSpells:new( "Misc.Mount.Summoned", spellIconList["Summon Dreadsteed"],
	{
		"SHAMAN", ABGCode:GetSpellNameByName("Ghost Wolf"),
	})
	AutoBarCategoryList["Misc.Mount.Summoned"]:SetNonCombat(true)


	AutoBarCategoryList["Spell.Charge"] = AutoBarSpells:new( "Spell.Charge", spellIconList["Charge"],
	{
		"WARRIOR", ABGCode:GetSpellNameByName("Charge"),
		"WARRIOR", ABGCode:GetSpellNameByName("Intercept"),
	})

	AutoBarCategoryList["Spell.ER"] = AutoBarSpells:new( "Spell.ER", spellIconList["Charge"],
	{
		"DRUID", ABGCode:GetSpellNameByName("Frenzied Regeneration"),
		"HUNTER", ABGCode:GetSpellNameByName("Feign Death"),
		"HUNTER", ABGCode:GetSpellNameByName("Disengage"),
		"MAGE", ABGCode:GetSpellNameByName("Ice Block"),
		"PALADIN", ABGCode:GetSpellNameByName("Lay on Hands"),
		"ROGUE", ABGCode:GetSpellNameByName("Vanish"),
		"WARLOCK", ABGCode:GetSpellNameByName("Dark Pact"),
		"WARRIOR", ABGCode:GetSpellNameByName("Last Stand"),
	})

	AutoBarCategoryList["Spell.Interrupt"] = AutoBarSpells:new( "Spell.Interrupt", spellIconList["Charge"],
	{
		"ROGUE", ABGCode:GetSpellNameByName("Kick"),
		"SHAMAN", ABGCode:GetSpellNameByName("Earth Shock"),
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

	AutoBarCategoryList["Spell.AquaticForm"] = AutoBarSpells:new( "Spell.MoonkinForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode:GetSpellNameByName("Aquatic Form"),
	})

	AutoBarCategoryList["Spell.TreeForm"] = AutoBarSpells:new( "Spell.TreeForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode:GetSpellNameByName("Tree Form"),
	})

	AutoBarCategoryList["Spell.Travel"] = AutoBarSpells:new( "Spell.Travel", spellIconList["Charge"],
	{
		"DRUID", ABGCode:GetSpellNameByName("Travel Form"),
		"SHAMAN", ABGCode:GetSpellNameByName("Ghost Wolf"),
	})

end

