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

	AutoBarCategoryList["Spell.Mount"] = SpellsCategory:new("Spell.Mount", "ability_druid_challangingroar", nil)

	AutoBarCategoryList["Muffin.Poison.Lethal"] = ItemsCategory:new("Muffin.Poison.Lethal", "INV_Misc_Food_95_Grainbread", "Muffin.Poison.Lethal")
	AutoBarCategoryList["Muffin.Poison.Nonlethal"] = ItemsCategory:new("Muffin.Poison.Nonlethal", "INV_Misc_Food_95_Grainbread", "Muffin.Poison.Nonlethal")

	AutoBarCategoryList["Muffin.Herbs.Millable"] = ItemsCategory:new( "Muffin.Herbs.Millable", "INV_Misc_HERB_01", "Muffin.Herbs.Millable")

	AutoBarCategoryList["Muffin.Misc.Hearth"] = ItemsCategory:new("Muffin.Misc.Hearth", "INV_Misc_Rune_01", "Muffin.Misc.Hearth")

	AutoBarCategoryList["Spell.Warlock.Create Healthstone"] = SpellsCategory:new( "Spell.Warlock.Create Healthstone", spellIconList["Create Healthstone"], nil,
	{
		"WARLOCK", code.get_spell_name_by_name("Create Healthstone"), code.get_spell_name_by_name("Ritual of Souls"),
	})

	AutoBarCategoryList["Spell.Warlock.Create Soulstone"] = SpellsCategory:new( "Spell.Warlock.Create Soulstone", spellIconList["Create Soulstone"],
	{
		"WARLOCK", code.get_spell_name_by_name("Create Soulstone (Minor)"),
	})

	AutoBarCategoryList["Spell.Mage.Create Manastone"] = SpellsCategory:new( "Spell.Mage.Create Manastone", spellIconList["Conjure Mana Gem"],
	{
		"MAGE", code.get_spell_name_by_name("Conjure Mana Gem"),
	})

	AutoBarCategoryList["Spell.Mage.Conjure Food"] = SpellsCategory:new( "Spell.Mage.Conjure Food", spellIconList["Conjure Food"], nil, {
		"MAGE", code.get_spell_name_by_name("Conjure Food"), code.get_spell_name_by_name("Ritual of Refreshment")
	})

	AutoBarCategoryList["Spell.Mage.Conjure Water"] = SpellsCategory:new("Spell.Mage.Conjure Water", spellIconList["Conjure Water"], nil, {
		"MAGE", code.get_spell_name_by_name("Conjure Water"), code.get_spell_name_by_name("Ritual of Refreshment")
	})

	AutoBarCategoryList["Spell.Stealth"] = SpellsCategory:new("Spell.Stealth", spellIconList["Stealth"],
	{
		"DRUID", code.get_spell_name_by_name("Prowl"),
		"MAGE", code.get_spell_name_by_name("Invisibility"),
		"ROGUE", code.get_spell_name_by_name("Stealth"),
		"*", code.get_spell_name_by_name("Shadowmeld"),
	})

	AutoBarCategoryList["Spell.Aspect"] = SpellsCategory:new("Spell.Aspect", spellIconList["Aspect of the Cheetah"],
	{
		"HUNTER", code.get_spell_name_by_name("Aspect of the Cheetah"),
		"HUNTER", code.get_spell_name_by_name("Aspect of the Hawk"),
		"HUNTER", code.get_spell_name_by_name("Aspect of the Wild"),
		"HUNTER", code.get_spell_name_by_name("Aspect of the Pack"),
	})

	AutoBarCategoryList["Spell.Class.Buff"] = SpellsCategory:new( "Spell.Class.Buff", spellIconList["Barkskin"], nil,
	{
		"MAGE", code.get_spell_name_by_name("Slow Fall"), code.get_spell_name_by_name("Slow Fall"),
		"MAGE", code.get_spell_name_by_name("Arcane Intellect"), code.get_spell_name_by_name("Arcane Intellect"),
		"DRUID", code.get_spell_name_by_name("Thorns"), code.get_spell_name_by_name("Thorns"),
		"DRUID", code.get_spell_name_by_name("Mark of the Wild"), code.get_spell_name_by_name("Mark of the Wild"),
		"DEATHKNIGHT", code.get_spell_name_by_name("Horn of Winter"), code.get_spell_name_by_name("Horn of Winter"),
		"PALADIN", code.get_spell_name_by_name("Hand of Salvation"), code.get_spell_name_by_name("Hand of Salvation"),
		"PALADIN", code.get_spell_name_by_name("Hand of Sacrifice"), code.get_spell_name_by_name("Hand of Sacrifice"),
		"PALADIN", code.get_spell_name_by_name("Hand of Freedom"), code.get_spell_name_by_name("Hand of Freedom"),
		"PALADIN", code.get_spell_name_by_name("Hand of Protection"), code.get_spell_name_by_name("Hand of Protection"),
		"PALADIN", code.get_spell_name_by_name("Blessing of Sanctuary"), code.get_spell_name_by_name("Blessing of Sanctuary"),
		"PALADIN", code.get_spell_name_by_name("Blessing of Might"), code.get_spell_name_by_name("Blessing of Might"),
		"PALADIN", code.get_spell_name_by_name("Blessing of Kings"), code.get_spell_name_by_name("Blessing of Kings"),
		"PRIEST", code.get_spell_name_by_name("Fear Ward"), code.get_spell_name_by_name("Fear Ward"),
		"PRIEST", code.get_spell_name_by_name("Vampiric Embrace"), code.get_spell_name_by_name("Vampiric Embrace"),
		"PRIEST", code.get_spell_name_by_name("Inner Fire"), code.get_spell_name_by_name("Inner Fire"),
		"PRIEST", code.get_spell_name_by_name("Prayer of Shadow Protection"), code.get_spell_name_by_name("Prayer of Shadow Protection"),
		"PRIEST", code.get_spell_name_by_name("Prayer of Fortitude"), code.get_spell_name_by_name("Prayer of Fortitude"),
		"SHAMAN", code.get_spell_name_by_name("Water Walking"), code.get_spell_name_by_name("Water Walking"),
		"WARLOCK", code.get_spell_name_by_name("Unending Breath"), code.get_spell_name_by_name("Unending Breath"),
		"WARRIOR", code.get_spell_name_by_name("Battle Shout"), code.get_spell_name_by_name("Commanding Shout"),
		"WARRIOR", code.get_spell_name_by_name("Commanding Shout"), code.get_spell_name_by_name("Battle Shout"),
	})

	AutoBarCategoryList["Spell.Class.Pet"] = SpellsCategory:new( "Spell.Class.Pet", spellIconList["Call Pet 1"],
	{
		"DEATHKNIGHT", code.get_spell_name_by_name("Raise Dead"),
		"DEATHKNIGHT", code.get_spell_name_by_name("Summon Gargoyle"),
		"HUNTER", code.get_spell_name_by_name("Call Pet"),
		"PRIEST", code.get_spell_name_by_name("Shadowfiend"),
		"MAGE",  code.get_spell_name_by_name("Summon Water Elemental"),
		"WARLOCK", code.get_spell_name_by_name("Eye of Kilrogg"),
		"WARLOCK", code.get_spell_name_by_name("Summon Infernal"),
		"WARLOCK", code.get_spell_name_by_name("Summon Felhunter"),
		"WARLOCK", code.get_spell_name_by_name("Summon Imp"),
		"WARLOCK", code.get_spell_name_by_name("Summon Succubus"),
		"WARLOCK", code.get_spell_name_by_name("Summon Voidwalker"),
		"WARLOCK", code.get_spell_name_by_name("Summon Felguard"),

	})

	AutoBarCategoryList["Spell.Class.Pets2"] = SpellsCategory:new( "Spell.Class.Pets2", spellIconList["Call Pet 1"],
	{
		"HUNTER", code.get_spell_name_by_name("Bestial Wrath"),
		"HUNTER", code.get_spell_name_by_name("Mend Pet"),
		"HUNTER", code.get_spell_name_by_name("Intimidation"),
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
		"DEATHKNIGHT", code.get_spell_name_by_name("Death Gate"), code.get_spell_name_by_name("Death Gate"),
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
		"MAGE", code.get_spell_name_by_name("Teleport: Dalaran"), code.get_spell_name_by_name("Portal: Dalaran"),
		"MAGE", code.get_spell_name_by_name("Teleport: Tol Barad - Alliance"), code.get_spell_name_by_name("Portal: Tol Barad - Alliance"),
		"MAGE", code.get_spell_name_by_name("Teleport: Tol Barad - Horde"), code.get_spell_name_by_name("Portal: Tol Barad - Horde"),
		"SHAMAN", code.get_spell_name_by_name("Astral Recall"), code.get_spell_name_by_name("Astral Recall"),
		"WARLOCK", code.get_spell_name_by_name("Ritual of Summoning"), code.get_spell_name_by_name("Ritual of Summoning"),

	})

	AutoBarCategoryList["Spell.Shields"] = SpellsCategory:new( "Spell.Shields", spellIconList["Ice Barrier"], nil,
	{
		"DEATHKNIGHT", code.get_spell_name_by_name("Anti-Magic Shell"), code.get_spell_name_by_name("Anti-Magic Zone"),
		"DEATHKNIGHT", code.get_spell_name_by_name("Anti-Magic Zone"), code.get_spell_name_by_name("Anti-Magic Shell"),
		"DRUID", 		code.get_spell_name_by_name("Barkskin"), 	code.get_spell_name_by_name("Barkskin"),
		"MAGE", 			code.get_spell_name_by_name("Ice Armor"), code.get_spell_name_by_name("Ice Barrier"),
		"MAGE", 			code.get_spell_name_by_name("Mage Armor"), code.get_spell_name_by_name("Ice Barrier"),
		"MAGE", 			code.get_spell_name_by_name("Molten Armor"), code.get_spell_name_by_name("Ice Barrier"),
		"PALADIN", 		code.get_spell_name_by_name("Divine Protection"), code.get_spell_name_by_name("Divine Shield"),
		"PALADIN", 		code.get_spell_name_by_name("Divine Shield"), code.get_spell_name_by_name("Divine Protection"),
		"PRIEST", 		code.get_spell_name_by_name("Power Word: Shield"), code.get_spell_name_by_name("Power Word: Shield"),
		"ROGUE", 		code.get_spell_name_by_name("Evasion"), 		code.get_spell_name_by_name("Evasion"),
		"WARRIOR", 		code.get_spell_name_by_name("Shield Block"), code.get_spell_name_by_name("Shield Wall"),
		"WARRIOR", 		code.get_spell_name_by_name("Shield Wall"), code.get_spell_name_by_name("Shield Block"),
		"WARLOCK", code.get_spell_name_by_name("Demon Skin"),  code.get_spell_name_by_name("Shadow Ward"),
		"WARLOCK", code.get_spell_name_by_name("Fel Armor"), code.get_spell_name_by_name("Shadow Ward"),
		"WARLOCK", code.get_spell_name_by_name("Shadow Ward"), code.get_spell_name_by_name("Shadow Ward"),


	})

	AutoBarCategoryList["Spell.Stance"] = SpellsCategory:new( "Spell.Stance", spellIconList["Defensive Stance"],
	{
		"DEATHKNIGHT", code.get_spell_name_by_name("Blood Presence"),
		"DEATHKNIGHT", code.get_spell_name_by_name("Frost Presence"),
		"DEATHKNIGHT", code.get_spell_name_by_name("Unholy Presence"),
		"DRUID", code.get_spell_name_by_name("Bear Form"),
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
		"WARRIOR", code.get_spell_name_by_name("Defensive Stance"),
		"WARRIOR", code.get_spell_name_by_name("Battle Stance"),
		"WARRIOR", code.get_spell_name_by_name("Berserker Stance"),

	})

	AutoBarCategoryList["Spell.Seal"] = SpellsCategory:new( "Spell.Seal", spellIconList["Seal of the Crusader"], {
		"PALADIN", code.get_spell_name_by_name("Seal of Justice"),
		"PALADIN", code.get_spell_name_by_name("Seal of Light"),
		"PALADIN", code.get_spell_name_by_name("Seal of Vengeance"),
		"PALADIN", code.get_spell_name_by_name("Seal of Righteousness"),
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
		"SHAMAN", code.get_spell_name_by_name("Grounding Totem"),
		"SHAMAN", code.get_spell_name_by_name("Windfury Totem"),
		"SHAMAN", code.get_spell_name_by_name("Wrath of Air Totem"),
	})

	AutoBarCategoryList["Spell.Totem.Fire"] = SpellsCategory:new("Spell.Totem.Fire", spellIconList["Liquid Magma Totem"],
	{
		"SHAMAN", code.get_spell_name_by_name("Magma Totem"),
		"SHAMAN", code.get_spell_name_by_name("Searing Totem"),
	})

	AutoBarCategoryList["Spell.Totem.Water"] = SpellsCategory:new("Spell.Totem.Water", spellIconList["Healing Stream Totem"],
	{
		"SHAMAN", code.get_spell_name_by_name("Healing Stream Totem"),
		"SHAMAN", code.get_spell_name_by_name("Mana Spring Totem"),
		"SHAMAN", code.get_spell_name_by_name("Mana Tide Totem"),
	})


	AutoBarCategoryList["Spell.Buff.Weapon"] = SpellsCategory:new("Spell.Buff.Weapon", spellIconList["Deadly Poison"],
	{
		"SHAMAN", code.get_spell_name_by_name("Earthliving Weapon"),
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
		"*", code.get_spell_name_by_name("Inscription"),
		"*", code.get_spell_name_by_name("Milling"),
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
		"DRUID",		code.get_spell_name_by_name("Disorienting Roar"),
	})

	AutoBarCategoryList["Spell.Debuff.Single"] = SpellsCategory:new("Spell.Debuff.Single", spellIconList["Slow"],
	{
		"HUNTER", code.get_spell_name_by_name("Concussive Shot"),
		"HUNTER", code.get_spell_name_by_name("Wing Clip"),
		"WARLOCK", code.get_spell_name_by_name("Curse of Tongues"),
		"WARLOCK", code.get_spell_name_by_name("Curse of the Elements"),
		"WARLOCK", code.get_spell_name_by_name("Curse of Weakness"),
		"WARLOCK", code.get_spell_name_by_name("Curse of Exhaustion"),
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
		"DEATHKNIGHT", code.get_spell_name_by_name("Death Grip"),
		"ROGUE", code.get_spell_name_by_name("Shadowstep"),
		"WARRIOR", code.get_spell_name_by_name("Charge"),
		"WARRIOR", code.get_spell_name_by_name("Intercept"),

	})

	AutoBarCategoryList["Spell.ER"] = SpellsCategory:new( "Spell.ER", spellIconList["Charge"],
	{
		"DRUID", code.get_spell_name_by_name("Frenzied Regeneration"),
		"HUNTER", code.get_spell_name_by_name("Feign Death"),
		"HUNTER", code.get_spell_name_by_name("Disengage"),
		"MAGE", code.get_spell_name_by_name("Ice Block"),
		"PALADIN", code.get_spell_name_by_name("Lay on Hands"),
		"ROGUE", code.get_spell_name_by_name("Vanish"),
		"WARRIOR", code.get_spell_name_by_name("Last Stand"),
	})

	AutoBarCategoryList["Spell.Interrupt"] = SpellsCategory:new( "Spell.Interrupt", spellIconList["Charge"],
	{
		"DEATHKNIGHT", code.get_spell_name_by_name("Strangulate"),
		"DEATHKNIGHT", code.get_spell_name_by_name("Mind Freeze"),
		"ROGUE", code.get_spell_name_by_name("Kick"),
		"SHAMAN", code.get_spell_name_by_name("Earth Shock"),

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

	AutoBarCategoryList["Spell.AquaticForm"] = SpellsCategory:new( "Spell.MoonkinForm", spellIconList["Charge"],
	{
		"DRUID", code.get_spell_name_by_name("Aquatic Form"),
	})

	AutoBarCategoryList["Spell.TreeForm"] = SpellsCategory:new( "Spell.TreeForm", spellIconList["Charge"],
	{
		--"DRUID", code.get_spell_name_by_name("Tree Form"),
	})

	AutoBarCategoryList["Spell.Travel"] = SpellsCategory:new( "Spell.Travel", spellIconList["Charge"],
	{
		"DRUID", code.get_spell_name_by_name("Travel Form"),
		"SHAMAN", code.get_spell_name_by_name("Ghost Wolf"),
	})

end

