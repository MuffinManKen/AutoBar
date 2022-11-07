local AutoBar = AutoBar
local ABGCode = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject
local spellIconList = ABGData.spell_icon_list
local L = AutoBarGlobalDataObject.locale
local ItemsCategory = ABGCode.ItemsCategory
local MacroTextCategory = ABGCode.MacroTextCategory
local SpellsCategory = ABGCode.SpellsCategory

ABGCode.ToyCategory = CreateFromMixins(ABGCode.CategoryClass)
local ToyCategory = ABGCode.ToyCategory

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
		local raw_list = ABGCode.AddPTSetToRawList({}, p_pt_name, false)
		obj.all_items = ABGCode.RawListToItemIDList(raw_list)
		--print("all_items", AB.Dump(obj.all_items))
	end

	obj:Refresh()

	return obj
end

-- Reset the item list in case the player learned new toys
function ToyCategory:Refresh()
	local list_index = 1

--	if(self.categoryKey == "Muffin.Toys.Hearth") then
--		print("Refreshing Toy Category", self.categoryKey, #self.items, #self.all_items);
--	end

	for _, toy_id in ipairs(self.all_items) do
--		if(self.categoryKey == "Muffin.Toys.Hearth") then print(toy_id, ABGCode.PlayerHasToy(toy_id), C_ToyBox.IsToyUsable(toy_id)); end
		local _, _toy_name, _toy_icon, toy_is_fave = C_ToyBox.GetToyInfo(toy_id)
		local user_selected = (self.only_favourites and toy_is_fave) or not self.only_favourites
		if (toy_id and ABGCode.PlayerHasToy(toy_id) and C_ToyBox.IsToyUsable(toy_id) and user_selected) then
			AutoBarSearch:RegisterToy(toy_id)
			self.items[list_index] = ABGCode.ToyGUID(toy_id)
			list_index = list_index + 1
		end
	end

	for i = list_index, # self.items, 1 do
		self.items[i] = nil
	end
end

function ABGCode.InitializeCategories()

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
		"*", ABGCode.GetSpellNameByName("Revive Battle Pets"),
	})

	AutoBarCategoryList["Muffin.Drum"] = ItemsCategory:new("Muffin.Drum", "INV_Misc_Drum_05", "Muffin.Drum")

	AutoBarCategoryList["Muffin.Misc.Repair"] = ItemsCategory:new( "Muffin.Misc.Repair", "INV_Misc_HERB_01", "Muffin.Misc.Repair")

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



	AutoBarCategoryList["Spell.Warlock.Create Healthstone"] = SpellsCategory:new( "Spell.Warlock.Create Healthstone", spellIconList["Create Healthstone"], nil,
	{
		"WARLOCK", ABGCode.GetSpellNameByName("Create Healthstone"), ABGCode.GetSpellNameByName("Create Soulwell"),
	})

	AutoBarCategoryList["Spell.Mage.Conjure Food"] = SpellsCategory:new( "Spell.Mage.Conjure Food", spellIconList["Conjure Refreshment"], {
		"MAGE", ABGCode.GetSpellNameByName("Conjure Refreshment"),
	})

	AutoBarCategoryList["Consumable.Water.Conjure"] = SpellsCategory:new("Consumable.Water.Conjure", spellIconList["Conjure Refreshment"], {
		"MAGE", ABGCode.GetSpellNameByName("Conjure Refreshment"),
	})

	AutoBarCategoryList["Consumable.Food.Conjure"] = SpellsCategory:new("Consumable.Food.Conjure", spellIconList["Conjure Refreshment"], {
		"MAGE", ABGCode.GetSpellNameByName("Conjure Refreshment"),
	})

	AutoBarCategoryList["Spell.Mage.Create Manastone"] = SpellsCategory:new( "Spell.Mage.Create Manastone", "inv_misc_gem_sapphire_02",
	{
		"MAGE", ABGCode.GetSpellNameByName("Conjure Mana Gem"),
	})


	AutoBarCategoryList["Spell.Stealth"] = SpellsCategory:new("Spell.Stealth", spellIconList["Stealth"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Prowl"),
		"HUNTER", ABGCode.GetSpellNameByName("Camouflage"),
		"MAGE", ABGCode.GetSpellNameByName("Greater Invisibility"),
		"MAGE", ABGCode.GetSpellNameByName("Invisibility"),
		"ROGUE", ABGCode.GetSpellNameByName("Stealth"),
		"*", ABGCode.GetSpellNameByName("Shadowmeld"),
	})


	AutoBarCategoryList["Spell.Aspect"] = SpellsCategory:new("Spell.Aspect", spellIconList["Aspect of the Cheetah"],
	{
		"HUNTER", ABGCode.GetSpellNameByName("Aspect of the Cheetah"),
		"HUNTER", ABGCode.GetSpellNameByName("Aspect of the Chameleon"),
		"HUNTER", ABGCode.GetSpellNameByName("Aspect of the Turtle"),
		"HUNTER", ABGCode.GetSpellNameByName("Aspect of the Eagle"),
		"HUNTER", ABGCode.GetSpellNameByName("Aspect of the Wild"),
	})


	AutoBarCategoryList["Spell.Poison.Lethal"] = SpellsCategory:new( "Spell.Poison.Lethal", spellIconList["Deadly Poison"], {
		"ROGUE", ABGCode.GetSpellNameByName("Deadly Poison"),
		"ROGUE", ABGCode.GetSpellNameByName("Instant Poison"),
		"ROGUE", ABGCode.GetSpellNameByName("Wound Poison"),
	})

	AutoBarCategoryList["Spell.Poison.Nonlethal"] = SpellsCategory:new( "Spell.Poison.Nonlethal", spellIconList["Crippling Poison"],
	{
		"ROGUE", ABGCode.GetSpellNameByName("Atrophic Poison"),
		"ROGUE", ABGCode.GetSpellNameByName("Crippling Poison"),
		"ROGUE", ABGCode.GetSpellNameByName("Numbing Poison"),
	})



	AutoBarCategoryList["Spell.Class.Buff"] = SpellsCategory:new( "Spell.Class.Buff", spellIconList["Barkskin"],
	{
		"DEATHKNIGHT", ABGCode.GetSpellNameByName("Path of Frost"),
		"DRUID", ABGCode.GetSpellNameByName("Ironbark"),
		"MAGE", ABGCode.GetSpellNameByName("Slow Fall"),
		"MAGE", ABGCode.GetSpellNameByName("Arcane Intellect"),
		"PALADIN", ABGCode.GetSpellNameByName("Blessing of Freedom"),
		"PALADIN", ABGCode.GetSpellNameByName("Blessing of Protection"),
		"PALADIN", ABGCode.GetSpellNameByName("Blessing of Sacrifice"),
		"PALADIN", ABGCode.GetSpellNameByName("Blessing of Spellwarding"),
		"PRIEST", ABGCode.GetSpellNameByName("Levitate"),
		"PRIEST", ABGCode.GetSpellNameByName("Power Word: Fortitude"),
		"SHAMAN", ABGCode.GetSpellNameByName("Water Walking"),
		"WARLOCK", ABGCode.GetSpellNameByName("Unending Breath"),
		"WARLOCK", ABGCode.GetSpellNameByName("Soulstone"),
		"WARRIOR", ABGCode.GetSpellNameByName("Battle Shout"),
		"WARRIOR", ABGCode.GetSpellNameByName("Rallying Cry"),
	})

	AutoBarCategoryList["Spell.Class.Pet"] = SpellsCategory:new( "Spell.Class.Pet", spellIconList["Call Pet 1"],
	{
		"DEATHKNIGHT", ABGCode.GetSpellNameByName("Dancing Rune Weapon"),
		"DEATHKNIGHT", ABGCode.GetSpellNameByName("Raise Dead"),
		"DEATHKNIGHT", ABGCode.GetSpellNameByName("Army of the Dead"),
		"DEATHKNIGHT", ABGCode.GetSpellNameByName("Summon Gargoyle"),
		"HUNTER", ABGCode.GetSpellNameByName("Call Pet 1"),
		"HUNTER", ABGCode.GetSpellNameByName("Call Pet 2"),
		"HUNTER", ABGCode.GetSpellNameByName("Call Pet 3"),
		"HUNTER", ABGCode.GetSpellNameByName("Call Pet 4"),
		"HUNTER", ABGCode.GetSpellNameByName("Call Pet 5"),
		"MAGE", ABGCode.GetSpellNameByName("Summon Water Elemental"),
		"MONK", ABGCode.GetSpellNameByName("Storm, Earth, and Fire"),
		"PRIEST", ABGCode.GetSpellNameByName("Shadowfiend"),
		"SHAMAN", ABGCode.GetSpellNameByName("Earth Elemental"),
		"SHAMAN", ABGCode.GetSpellNameByName("Fire Elemental"),
		"SHAMAN", ABGCode.GetSpellNameByName("Storm Elemental"),
		"SHAMAN", ABGCode.GetSpellNameByName("Feral Spirit"),
		"WARLOCK", ABGCode.GetSpellNameByName("Summon Felguard"),
		"WARLOCK", ABGCode.GetSpellNameByName("Summon Felhunter"),
		"WARLOCK", ABGCode.GetSpellNameByName("Summon Imp"),
		"WARLOCK", ABGCode.GetSpellNameByName("Summon Succubus"),
		"WARLOCK", ABGCode.GetSpellNameByName("Summon Voidwalker"),
	})



	AutoBarCategoryList["Spell.Class.Pets2"] = SpellsCategory:new( "Spell.Class.Pets2", spellIconList["Call Pet 1"],
	{
		"DEATHKNIGHT", ABGCode.GetSpellNameByName("Dark Transformation"),
		"HUNTER", ABGCode.GetSpellNameByName("Kill Command"),
		"HUNTER", ABGCode.GetSpellNameByName("Bestial Wrath"),
		"HUNTER", ABGCode.GetSpellNameByName("Dire Beast"),
		"HUNTER", ABGCode.GetSpellNameByName("Master's Call"),
		"HUNTER", ABGCode.GetSpellNameByName("Mend Pet"),
		"HUNTER", ABGCode.GetSpellNameByName("Intimidation"),
		"WARLOCK", ABGCode.GetSpellNameByName("Command Demon"),
		"WARLOCK", ABGCode.GetSpellNameByName("Eye of Kilrogg"),
		"WARLOCK", ABGCode.GetSpellNameByName("Summon Infernal"),
		"WARLOCK", ABGCode.GetSpellNameByName("Call Dreadstalkers"),
		"WARLOCK", ABGCode.GetSpellNameByName("Grimoire of Sacrifice"),
		"WARLOCK", ABGCode.GetSpellNameByName("Summon Darkglare"),
		"WARLOCK", ABGCode.GetSpellNameByName("Summon Demonic Tyrant"),
	})

	--Misc pet abilities
	AutoBarCategoryList["Spell.Class.Pets3"] = SpellsCategory:new(	"Spell.Class.Pets3", spellIconList["Feed Pet"],
	{
		"HUNTER", ABGCode.GetSpellNameByName("Dismiss Pet"),
		"HUNTER", ABGCode.GetSpellNameByName("Eagle Eye"),
		"HUNTER", ABGCode.GetSpellNameByName("Eyes of the Beast"),
		"HUNTER", ABGCode.GetSpellNameByName("Feed Pet"),
		"HUNTER", ABGCode.GetSpellNameByName("Revive Pet"),
		"HUNTER", ABGCode.GetSpellNameByName("Tame Beast"),
		"HUNTER", ABGCode.GetSpellNameByName("Beast Lore"),
		"HUNTER", ABGCode.GetSpellNameByName("Fetch"),
		"HUNTER", ABGCode.GetSpellNameByName("Play Dead"),
		"HUNTER", ABGCode.GetSpellNameByName("Wake Up"),
	})



	AutoBarCategoryList["Spell.Portals"] = SpellsCategory:new( "Spell.Portals", "spell_arcane_portalironforge", nil,
	{
		"DRUID", ABGCode.GetSpellNameByName("Teleport: Moonglade"), ABGCode.GetSpellNameByName("Teleport: Moonglade"),
		"DRUID", ABGCode.GetSpellNameByName("Dreamwalk"), ABGCode.GetSpellNameByName("Dreamwalk"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Stonard"), ABGCode.GetSpellNameByName("Portal: Stonard"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Theramore"), ABGCode.GetSpellNameByName("Portal: Theramore"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Undercity"), ABGCode.GetSpellNameByName("Portal: Undercity"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Thunder Bluff"), ABGCode.GetSpellNameByName("Portal: Thunder Bluff"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Stormwind"), ABGCode.GetSpellNameByName("Portal: Stormwind"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Silvermoon"), ABGCode.GetSpellNameByName("Portal: Silvermoon"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Exodar"), ABGCode.GetSpellNameByName("Portal: Exodar"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Darnassus"), ABGCode.GetSpellNameByName("Portal: Darnassus"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Ironforge"), ABGCode.GetSpellNameByName("Portal: Ironforge"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Orgrimmar"), ABGCode.GetSpellNameByName("Portal: Orgrimmar"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Shattrath"), ABGCode.GetSpellNameByName("Portal: Shattrath"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Dalaran"), ABGCode.GetSpellNameByName("Portal: Dalaran"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Dalaran - Broken Isles"), ABGCode.GetSpellNameByName("Portal: Dalaran - Broken Isles"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Tol Barad - Horde"), ABGCode.GetSpellNameByName("Portal: Tol Barad - Horde"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Tol Barad - Alliance"), ABGCode.GetSpellNameByName("Portal: Tol Barad - Alliance"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Vale of Eternal Blossoms - Alliance"), ABGCode.GetSpellNameByName("Portal: Vale of Eternal Blossoms - Alliance"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Vale of Eternal Blossoms - Horde"), ABGCode.GetSpellNameByName("Portal: Vale of Eternal Blossoms - Horde"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Stormshield"), ABGCode.GetSpellNameByName("Portal: Stormshield"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Warspear"), ABGCode.GetSpellNameByName("Portal: Warspear"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Hall of the Guardian"), ABGCode.GetSpellNameByName("Teleport: Hall of the Guardian"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Boralus"), ABGCode.GetSpellNameByName("Portal: Boralus"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Dazar'alor"), ABGCode.GetSpellNameByName("Portal: Dazar'alor"),
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Oribos"), ABGCode.GetSpellNameByName("Portal: Oribos"),
		"MONK", ABGCode.GetSpellNameByName("Zen Pilgrimage"), ABGCode.GetSpellNameByName("Zen Pilgrimage"),
		"MONK", ABGCode.GetSpellNameByName("Zen Pilgrimage: Return"), ABGCode.GetSpellNameByName("Zen Pilgrimage: Return"),
		"DEATHKNIGHT", ABGCode.GetSpellNameByName("Death Gate"), ABGCode.GetSpellNameByName("Death Gate"),
		"SHAMAN", ABGCode.GetSpellNameByName("Astral Recall"), ABGCode.GetSpellNameByName("Astral Recall"),
		"WARLOCK", ABGCode.GetSpellNameByName("Ritual of Summoning"), ABGCode.GetSpellNameByName("Ritual of Summoning"),
		"*", ABGCode.GetSpellNameByName("Mole Machine"), ABGCode.GetSpellNameByName("Mole Machine"),
	})

	AutoBarCategoryList["Spell.ChallengePortals"] = SpellsCategory:new("Spell.ChallengePortals", "spell_arcane_portalironforge", nil,
	{
		"*", ABGCode.GetSpellNameByName("Path of the Jade Serpent"), ABGCode.GetSpellNameByName("Path of the Jade Serpent"),
		"*", ABGCode.GetSpellNameByName("Path of the Stout Brew"), ABGCode.GetSpellNameByName("Path of the Stout Brew"),
		"*", ABGCode.GetSpellNameByName("Path of the Shado-Pan"), ABGCode.GetSpellNameByName("Path of the Shado-Pan"),
		"*", ABGCode.GetSpellNameByName("Path of the Mogu King"), ABGCode.GetSpellNameByName("Path of the Mogu King"),
		"*", ABGCode.GetSpellNameByName("Path of the Setting Sun"), ABGCode.GetSpellNameByName("Path of the Setting Sun"),
		"*", ABGCode.GetSpellNameByName("Path of the Scarlet Blade"), ABGCode.GetSpellNameByName("Path of the Scarlet Blade"),
		"*", ABGCode.GetSpellNameByName("Path of the Scarlet Mitre"), ABGCode.GetSpellNameByName("Path of the Scarlet Mitre"),
		"*", ABGCode.GetSpellNameByName("Path of the Necromancer"), ABGCode.GetSpellNameByName("Path of the Necromancer"),
		"*", ABGCode.GetSpellNameByName("Path of the Black Ox"), ABGCode.GetSpellNameByName("Path of the Black Ox"),
	})

	AutoBarCategoryList["Spell.AncientDalaranPortals"] = SpellsCategory:new("Spell.AncientDalaranPortals", spellIconList["Portal: Ancient Dalaran"], nil,
	{
		"MAGE", ABGCode.GetSpellNameByName("Teleport: Ancient Dalaran"), ABGCode.GetSpellNameByName("Portal: Ancient Dalaran"),
	})

	AutoBarCategoryList["Spell.Shields"] = SpellsCategory:new( "Spell.Shields", spellIconList["Ice Barrier"], nil,
	{
		"DEMONHUNTER",	 ABGCode.GetSpellNameByName("Blur"), 	ABGCode.GetSpellNameByName("Darkness"),
		"DEATHKNIGHT", ABGCode.GetSpellNameByName("Anti-Magic Shell"), 	ABGCode.GetSpellNameByName("Icebound Fortitude"),
		"DEATHKNIGHT", ABGCode.GetSpellNameByName("Icebound Fortitude"), 	ABGCode.GetSpellNameByName("Anti-Magic Shell"),
		"DRUID", 		ABGCode.GetSpellNameByName("Barkskin"), 	ABGCode.GetSpellNameByName("Barkskin"),
		"HUNTER", 		ABGCode.GetSpellNameByName("Aspect of the Turtle"), 	ABGCode.GetSpellNameByName("Aspect of the Turtle"),
		"MAGE", 			ABGCode.GetSpellNameByName("Ice Barrier"), ABGCode.GetSpellNameByName("Ice Barrier"),
		"MAGE", 			ABGCode.GetSpellNameByName("Temporal Shield"), ABGCode.GetSpellNameByName("Temporal Shield"),
		"MAGE", 			ABGCode.GetSpellNameByName("Blazing Barrier"), ABGCode.GetSpellNameByName("Blazing Barrier"),
		"MAGE", 			ABGCode.GetSpellNameByName("Prismatic Barrier"), ABGCode.GetSpellNameByName("Prismatic Barrier"),
		"MONK", 			ABGCode.GetSpellNameByName("Fortifying Brew"), ABGCode.GetSpellNameByName("Fortifying Brew"),
		"PALADIN", 		ABGCode.GetSpellNameByName("Ardent Defender"), ABGCode.GetSpellNameByName("Ardent Defender"),
		"PALADIN", 		ABGCode.GetSpellNameByName("Divine Shield"), ABGCode.GetSpellNameByName("Divine Shield"),
		"PRIEST", 		ABGCode.GetSpellNameByName("Power Word: Shield"), ABGCode.GetSpellNameByName("Power Word: Barrier"),
		"ROGUE", 		ABGCode.GetSpellNameByName("Evasion"), 		ABGCode.GetSpellNameByName("Evasion"),
		"WARLOCK", 		ABGCode.GetSpellNameByName("Unending Resolve"), ABGCode.GetSpellNameByName("Unending Resolve"),
		"WARRIOR", 		ABGCode.GetSpellNameByName("Shield Block"), ABGCode.GetSpellNameByName("Shield Wall"),
		"WARRIOR", 		ABGCode.GetSpellNameByName("Shield Wall"), ABGCode.GetSpellNameByName("Shield Block"),
	})

	AutoBarCategoryList["Spell.Stance"] = SpellsCategory:new( "Spell.Stance", spellIconList["Defensive Stance"], {
		"PALADIN", ABGCode.GetSpellNameByName("Concentration Aura"),
		"PALADIN", ABGCode.GetSpellNameByName("Crusader Aura"),
		"PALADIN", ABGCode.GetSpellNameByName("Devotion Aura"),
		"PALADIN", ABGCode.GetSpellNameByName("Retribution Aura"),
		"WARRIOR", ABGCode.GetSpellNameByName("Defensive Stance"),
	})



	AutoBarCategoryList["Spell.Guild"] = SpellsCategory:new("Spell.Guild", spellIconList["Mobile Banking"],
	{
		"*", ABGCode.GetSpellNameByName("Mobile Banking"),
	})


	AutoBarCategoryList["Spell.Totem.Earth"] = SpellsCategory:new("Spell.Totem.Earth", spellIconList["Earthgrab Totem"],
	{
		"SHAMAN", ABGCode.GetSpellNameByName("Ancestral Protection Totem"),
		"SHAMAN", ABGCode.GetSpellNameByName("Earthgrab Totem"),
		"SHAMAN", ABGCode.GetSpellNameByName("Earthbind Totem"),
		"SHAMAN", ABGCode.GetSpellNameByName("Earthen Wall Totem"),
	})


	AutoBarCategoryList["Spell.Totem.Air"] = SpellsCategory:new("Spell.Totem.Air", spellIconList["Wind Rush Totem"],
	{
		"SHAMAN", ABGCode.GetSpellNameByName("Cloudburst Totem"),
		"SHAMAN", ABGCode.GetSpellNameByName("Wind Rush Totem"),
	})

	AutoBarCategoryList["Spell.Totem.Fire"] = SpellsCategory:new("Spell.Totem.Fire", spellIconList["Liquid Magma Totem"],
	{
		"SHAMAN", ABGCode.GetSpellNameByName("Liquid Magma Totem"),
	})

	AutoBarCategoryList["Spell.Totem.Water"] = SpellsCategory:new("Spell.Totem.Water", spellIconList["Healing Stream Totem"],
	{
		"SHAMAN", ABGCode.GetSpellNameByName("Healing Stream Totem"),
		"SHAMAN", ABGCode.GetSpellNameByName("Healing Tide Totem"),
		"SHAMAN", ABGCode.GetSpellNameByName("Mana Tide Totem"),
		"SHAMAN", ABGCode.GetSpellNameByName("Spirit Link Totem"),
	})


	AutoBarCategoryList["Spell.Buff.Weapon"] = SpellsCategory:new("Spell.Buff.Weapon", spellIconList["Deadly Poison"],
	{
		"ROGUE", ABGCode.GetSpellNameByName("Deadly Poison"),
		"ROGUE", ABGCode.GetSpellNameByName("Wound Poison"),
		"ROGUE", ABGCode.GetSpellNameByName("Crippling Poison"),
	})

	AutoBarCategoryList["Spell.Crafting"] = SpellsCategory:new( "Spell.Crafting", spellIconList["First Aid"],
	{
		"*", ABGCode.GetSpellNameByName("Alchemy"),
		"*", ABGCode.GetSpellNameByName("Archaeology"),
		"*", ABGCode.GetSpellNameByName("Cooking Fire"),
		"*", ABGCode.GetSpellNameByName("Blacksmithing"),
		"*", ABGCode.GetSpellNameByName("Cooking"),
		"*", ABGCode.GetSpellNameByName("Disenchant"),
		"*", ABGCode.GetSpellNameByName("Enchanting"),
		"*", ABGCode.GetSpellNameByName("Engineering"),
		"*", ABGCode.GetSpellNameByName("Inscription"),
		"*", ABGCode.GetSpellNameByName("Jewelcrafting"),
		"*", ABGCode.GetSpellNameByName("Leatherworking"),
		"*", ABGCode.GetSpellNameByName("Milling"),
		"*", ABGCode.GetSpellNameByName("Prospecting"),
		"*", ABGCode.GetSpellNameByName("Smelting"),
		"*", ABGCode.GetSpellNameByName("Survey"),
		"*", ABGCode.GetSpellNameByName("Tailoring"),
		"DEATHKNIGHT", ABGCode.GetSpellNameByName("Runeforging"),
	})

	AutoBarCategoryList["Spell.Archaeology"] = SpellsCategory:new("Spell.Archaeology", spellIconList["Archaeology"], nil,
	{
		"*",	ABGCode.GetSpellNameByName("Survey"), ABGCode.GetSpellNameByName("Archaeology"),
	})


	AutoBarCategoryList["Spell.Debuff.Multiple"] = SpellsCategory:new("Spell.Debuff.Multiple", spellIconList["Slow"],
	{
		"DRUID",		ABGCode.GetSpellNameByName("Incapacitating Roar"),
		"HUNTER",	ABGCode.GetSpellNameByName("Binding Shot"),
		"WARRIOR", ABGCode.GetSpellNameByName("Demoralizing Shout"),
	})

	AutoBarCategoryList["Spell.Debuff.Single"] = SpellsCategory:new("Spell.Debuff.Single", spellIconList["Slow"],
	{
		"DEATHKNIGHT", ABGCode.GetSpellNameByName("Chains of Ice"),
		"DRUID",	ABGCode.GetSpellNameByName("Entangling Roots"),
		"HUNTER", ABGCode.GetSpellNameByName("Concussive Shot"),
		"HUNTER", ABGCode.GetSpellNameByName("Wing Clip"),
		"PALADIN", ABGCode.GetSpellNameByName("Hand of Hindrance"),
		"WARLOCK", ABGCode.GetSpellNameByName("Curse of Tongues"),
		"WARLOCK", ABGCode.GetSpellNameByName("Curse of Weakness"),
		"WARLOCK", ABGCode.GetSpellNameByName("Curse of Exhaustion"),
	})


	AutoBarCategoryList["Spell.Fishing"] = SpellsCategory:new("Spell.Fishing", spellIconList["Fishing"],
	{
		"*", ABGCode.GetSpellNameByName("Fishing"),
		"*", ABGCode.GetSpellNameByName("Undercurrent"),
	})



	AutoBarCategoryList["Spell.Trap"] = SpellsCategory:new( "Spell.Trap", spellIconList["Explosive Trap"],
	{
		"DEMONHUNTER", ABGCode.GetSpellNameByName("Sigil of Flame"),
		"DEMONHUNTER", ABGCode.GetSpellNameByName("Sigil of Misery"),
		"DEMONHUNTER", ABGCode.GetSpellNameByName("Sigil of Silence"),
		"HUNTER", ABGCode.GetSpellNameByName("Freezing Trap"),
		"HUNTER", ABGCode.GetSpellNameByName("Tar Trap"),
		"HUNTER", ABGCode.GetSpellNameByName("Steel Trap"),
	})


	AutoBarCategoryList["Misc.Mount.Summoned"] = SpellsCategory:new( "Misc.Mount.Summoned", spellIconList["Summon Dreadsteed"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Travel Form"),
		"SHAMAN", ABGCode.GetSpellNameByName("Ghost Wolf"),
		"*", ABGCode.GetSpellNameByName("Running Wild"),
	})
	AutoBarCategoryList["Misc.Mount.Summoned"]:SetNonCombat(true)

	AutoBarCategoryList["Muffin.Mounts"] = SpellsCategory:new("Muffin.Mounts", spellIconList["Summon Dreadsteed"], nil, nil, "Muffin.Mounts." .. AutoBar.NiceClass)
	AutoBarCategoryList["Muffin.Mounts"]:SetNonCombat(true)

	AutoBarCategoryList["Spell.Charge"] = SpellsCategory:new( "Spell.Charge", spellIconList["Charge"],
	{
		"DEMONHUNTER", ABGCode.GetSpellNameByName("Fel Rush"),
		"DRUID", ABGCode.GetSpellNameByName("Wild Charge"),
		"HUNTER", ABGCode.GetSpellNameByName("Harpoon"),
		"ROGUE", ABGCode.GetSpellNameByName("Shadowstep"),
		"ROGUE", ABGCode.GetSpellNameByName("Blade Rush"),
		"WARRIOR", ABGCode.GetSpellNameByName("Charge"),
		"WARRIOR", ABGCode.GetSpellNameByName("Intervene"),
	})

	AutoBarCategoryList["Spell.ER"] = SpellsCategory:new( "Spell.ER", spellIconList["Charge"],
	{
		"DEMONHUNTER", ABGCode.GetSpellNameByName("Vengeful Retreat"),
		"DEATHKNIGHT", ABGCode.GetSpellNameByName("Rune Tap"),
		"DRUID", ABGCode.GetSpellNameByName("Frenzied Regeneration"),
		"HUNTER", ABGCode.GetSpellNameByName("Feign Death"),
		"HUNTER", ABGCode.GetSpellNameByName("Disengage"),
		"MAGE", ABGCode.GetSpellNameByName("Ice Block"),
		"PALADIN", ABGCode.GetSpellNameByName("Lay on Hands"),
		"PRIEST", ABGCode.GetSpellNameByName("Dispersion"),
		"PRIEST", ABGCode.GetSpellNameByName("Guardian Spirit"),
		"PRIEST", ABGCode.GetSpellNameByName("Pain Suppression"),
		"ROGUE", ABGCode.GetSpellNameByName("Vanish"),
		"WARLOCK", ABGCode.GetSpellNameByName("Dark Pact"),
		"WARRIOR", ABGCode.GetSpellNameByName("Last Stand"),
		"WARRIOR", ABGCode.GetSpellNameByName("Enraged Regeneration"),
	})

	AutoBarCategoryList["Spell.Interrupt"] = SpellsCategory:new( "Spell.Interrupt", spellIconList["Charge"],
	{
		"DEATHKNIGHT", ABGCode.GetSpellNameByName("Mind Freeze"),
		"DEMONHUNTER", ABGCode.GetSpellNameByName("Disrupt"),
		"DRUID", ABGCode.GetSpellNameByName("Skull Bash"),
		"HUNTER", ABGCode.GetSpellNameByName("Counter Shot"),
		"MAGE", ABGCode.GetSpellNameByName("Counterspell"),
		"MONK", ABGCode.GetSpellNameByName("Spear Hand Strike"),
		"PALADIN", ABGCode.GetSpellNameByName("Rebuke"),
		"PRIEST", ABGCode.GetSpellNameByName("Silence"),
		"ROGUE", ABGCode.GetSpellNameByName("Kick"),
		"SHAMAN", ABGCode.GetSpellNameByName("Wind Shear"),
		"WARRIOR", ABGCode.GetSpellNameByName("Pummel"),
	})

	AutoBarCategoryList["Spell.CatForm"] = SpellsCategory:new( "Spell.CatForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Cat Form"),
	})

	AutoBarCategoryList["Spell.BearForm"] = SpellsCategory:new( "Spell.BearForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Bear Form"),
	})

	AutoBarCategoryList["Spell.MoonkinForm"] = SpellsCategory:new( "Spell.MoonkinForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Moonkin Form"),
	})

	AutoBarCategoryList["Spell.TreeForm"] = SpellsCategory:new( "Spell.TreeForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Treant Form"),
	})

	AutoBarCategoryList["Spell.StagForm"] = SpellsCategory:new( "Spell.StagForm", spellIconList["Charge"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Mount Form"),
	})

	AutoBarCategoryList["Spell.Travel"] = SpellsCategory:new( "Spell.Travel", spellIconList["Charge"],
	{
		"DRUID", ABGCode.GetSpellNameByName("Travel Form"),
		"SHAMAN", ABGCode.GetSpellNameByName("Ghost Wolf"),
	})

end

