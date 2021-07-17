
local L = AutoBarGlobalDataObject.locale

local function atl(key, name)
	L[key] = L[key] or name;
end

local function atld(key)
	L[key] = L[key] or key;
end

local function atl_table(p_table)
	for i,v in ipairs(p_table) do
		L[v] = L[v] or v;
	end

end

local function get_class_name(p_class_id)

	local class_info = C_CreatureInfo.GetClassInfo(p_class_id)
	if(class_info) then
		return class_info.className
	end

	return ""
end

atl("Delete", KEY_DELETE)
atl("Key Bindings", KEY_BINDINGS)


L["AutoBarClassBarDeathKnight"] = get_class_name(6)
L["AutoBarClassBarDemonHunter"] = get_class_name(12)
L["AutoBarClassBarMonk"] = get_class_name(10)
L["AutoBarClassBarDruid"] = get_class_name(11)
L["AutoBarClassBarHunter"] = get_class_name(3)
L["AutoBarClassBarMage"] = get_class_name(8)
L["AutoBarClassBarPaladin"] = get_class_name(2)
L["AutoBarClassBarPriest"] = get_class_name(5)
L["AutoBarClassBarRogue"] = get_class_name(4)
L["AutoBarClassBarShaman"] = get_class_name(7)
L["AutoBarClassBarWarlock"] = get_class_name(9)
L["AutoBarClassBarWarrior"] = get_class_name(1)

atl("ResetCategoryDescription", "Removes ALL custom categories")

atl("AutoBar.Food.Health.Basic", L["Consumable.Food.Edible.Basic.Non-Conjured"]);
atl("AutoBar.Food.Mana.Basic", L["Consumable.Water.Basic"]);
atl("AutoBar.Food.Combo.Basic", L["Consumable.Food.Edible.Combo.Non-Conjured"]);
atl("AutoBar.SunsongRanch", "Sunsong Ranch");
atl("AutoBarButtonSunsongRanch", "Sunsong Ranch");
atl("Muffin.Potion.Buff","Muffin.Potion.Buff");
atl("Muffin.Potion.Rage","Muffin.Potion.Rage");
atl("Muffin.Potion.Water Breathing","Muffin.Potion.Water Breathing");
atl("Muffin.Potion.Health", "Muffin.Potion.Health");
atl("Muffin.Elixir.Battle", "Muffin.Elixir.Battle");
atl("Muffin.Elixir.Guardian", "Muffin.Elixir.Guardian");
atl("Muffin.Flask", "Muffin.Flask");

atl("AutoBar.Garrison", "Garrison");
atl("AutoBarButtonGarrison", "Garrison");
atl("AutoBarButtonToyBox", "Toy Box");
atl("AutoBarButtonDrums", "Drums");
atl("Spell.Stealth", "Spell.Stealth");
atl("Spell.Track", "Spell.Track");
atl("AutoBarButtonInterrupt", "Interrupts");

atl("AutoBarButtonMillHerbs", "Milling");
atl("AutoBarButtonTrack", "Track");

atl("MountShowQiraji", "Show Qiraji");
atl("MountShowFavourites", "Show Favourites");
atl("MountShowNonFavourites", "Show Non-Favourites");
atl("MountShowClass", "Show Class");
atl("MountReverseSort", "Reverse the Sorting Order");
atl("MountShowSummonRandom", "Summon a Random Favourite Mount");
atl("ToyBoxOnlyFavourites", "Only Show Favourites");
atl("Muffin.Toys.Pet Battle_ShowOrnamental", "Show Ornamental" );
atl("ArchBtnShowSpells", "Show Spells")

atl("Muffin.Misc.Quest", "Muffin.Misc.Quest");
atl("Muffin.Mounts", "Muffin.Mounts");

atl("AutoBarButtonRaidTarget", "Raid Targets")

atl("AutoBarButtonMoonkin", "Moonkin")
atl("AutoBarButtonTreeForm", "Tree")
atl("AutoBarButtonStagForm", "Stag")

atl("Spell.Travel", "Spell.Travel")
atl("Spell.CatForm", "Spell.CatForm")
atl("Spell.TreeForm", "Spell.TreeForm")
atl("Spell.MoonkinForm", "Spell.MoonkinForm")
atl("Spell.BearForm", "Spell.BearForm")
atl("Spell.StagForm", "Spell.StagForm")


atl("Muffin.Skill.Fishing.Lure", "Muffin.Skill.Fishing.Lure");
atl("AutoBarButtonArchaeology", "Archaeology")

atl("Spell.AncientDalaranPortals", "Spell.AncientDalaranPortals");
atl("Spell.ChallengePortals", "Spell.ChallengePortals");

atl("HearthIncludeAncientDalaran", "Include Ancient Dalaran");
atl("HearthIncludeChallengePortals", "Include Challenge Portals");

atl("Include Basic Combo Food", "Include Basic Combo Food");

atl("Supporters", "Supporters");

atl("Spell.Class.Pet", "Class Pet");
atl("Spell.Class.Pets2", "Pet Combat");
atl("Spell.Class.Pets3", "Pet Misc");

atl("AutoBarButtonClassPet", "Class Pet");
atl("AutoBarButtonClassPets2", "Pet Combat");
atl("AutoBarButtonClassPets3", "Pet Misc");

atl("AutoBarClassBarDemonHunter", "Demon Hunter")
atl("AutoBarButtonBattlePetItems", "Battle Pet Items")

atl("Max Popup Height", "Max Popup Height")
atl("Max Popup Height Desc", "Maximum Number of button rows for a popup")

atl("Muffin.Gear.Trinket", "Muffin.Gear.Trinket")

atl("Muffin.Food.Health.Basic", "Muffin.Food.Health.Basic")
atl("Consumable.Cooldown.Potion.Rejuvenation.Dreamless Sleep", "Consumable.Cooldown.Potion.Rejuvenation.Dreamless Sleep")
atl("Muffin.Food.Combo", "Muffin.Food.Combo")
atl("Muffin.Potion.Combo", "Muffin.Potion.Combo")
atl("Consumable.Buff.Water Breathing", "Consumable.Buff.Water Breathing")

atl("AutoBarButtonOrderHallResource", "Order Hall Resources")
atl("AutoBarButtonOrderHallTroop", "Order Hall Troops")
atl("AutoBarButtonReputation", "Reputation")

atl("AutoBarButtonBuffWeapon", "Buff Weapon")
atl("AutoBarButtonAquatic", "Aquatic")

atl("NewButton", "New Button")
atl("NewButtonTooltip", "Create a new custom button")

atl("Square Popups", "Square Popups")
atl("Square Popups Desc", "Try to organize popups into more of a square shape")


atl("Summon A Random Pet", "Summon Random Pet|n|cFFFFD100Summon a random pet from your pet journal|r")
atl("Summon A Random Fave Pet", "Summon Favourite Pet|n|cFFFFD100Summon a random pet from your list of favourites in the pet journal|r")
atl("Dismiss Battle Pet", "Dismiss Battle Pet|n|cFFFFD100Dismiss your current battle pet|r")
atl("Summon A Random Favourite Mount", "Summon Favourite Mount|n|cFFFFD100Summon a random mount from your list of favourites in the mount journal|r")

atl("Raid 1","Raid Star")
atl("Raid 2","Raid Circle")
atl("Raid 3","Raid Diamond")
atl("Raid 4","Raid Triangle")
atl("Raid 5","Raid Moon")
atl("Raid 6","Raid Square")
atl("Raid 7","Raid X")
atl("Raid 8","Raid Skull")

atl("OnlyFavouriteHearth", "Only show favourite Hearth toys")
local quick_sets =
{
	--Categories
	"Battle Pet.Favourites",
	"Consumable.Buff.Resistance.Self",
	"Consumable.Buff.Resistance.Target",
	"Consumable.Food.Bread",
	"Consumable.Food.Cheese",
	"Consumable.Food.Fish",
	"Consumable.Food.Fruit",
	"Consumable.Food.Fungus",
	"Consumable.Food.Meat",
	"Macro.BattlePet.SummonRandom",
	"Macro.BattlePet.DismissPet",
	"Macro.BattlePet.SummonRandomFave",
	"Macro.Raid Target",
	"Muffin.Battle Pet Items.Bandages",
	"Muffin.Battle Pet Items.Level",
	"Muffin.Battle Pet Items.Pet Treat",
	"Muffin.Battle Pet Items.Upgrade",
	"Muffin.Drum",
	"Muffin.Food.Combo.Basic",
	"Muffin.Food.Combo.Buff",
	"Muffin.Food.Health.Buff",
	"Muffin.Food.Mana.Basic",
	"Muffin.Food.Mana.Buff",
	"Muffin.Garrison",
	"Muffin.Misc.Openable",
	"Muffin.Order Hall.Ancient Mana",
	"Muffin.Order Hall.Artifact Power",
	"Muffin.Order Hall.Buff",
	"Muffin.Order Hall.Champion",
	"Muffin.Order Hall.Troop Recruit",
	"Muffin.Order Hall.Order Resources",
	"Muffin.Potion.Mana",
	"Muffin.Misc.Reputation",
	"Muffin.Misc.Repair",
	"Muffin.Skill.Fishing.Misc",
	"Muffin.Skill.Fishing.Rare Fish",
	"Muffin.SunSongRanch",
	"Muffin.Toys.Fishing",
	"Muffin.Toys.Hearth",
	"Muffin.Toys.Pet Battle",
	"Muffin.Toys.Portal",
	"Muffin.Toys.Companion Pet.Ornamental",
	"Spell.Charge",
	"Spell.ER",
	"Spell.Interrupt",
	"Spell.Mage.Conjure Food",
	"Spell.Mage.Conjure Water",
	"Spell.Pet Battle",
	"Toys.ToyBox",
	"Tradeskill.Tool.Fishing.Bait",
	"Muffin.Skill.Archaeology.Crate",
	"Muffin.Skill.Archaeology.Mission",
	"Spell.Archaeology",
	"Dynamic.Quest",
	"Macro.Mount.SummonRandomFave",
	"Muffin.Order Hall.Nethershard",
	"Spell.AquaticForm",
	"Muffin.Misc.StartsQuest",
	"Muffin.Stones.Mana",
	"Muffin.Stones.Health",
	"Muffin.Poison.Nonlethal",
	"Muffin.Poison.Lethal",
	"Spell.Warlock.Create Soulstone",
	"Spell.Mage.Create Manastone",
	"Muffin.Mounts.Warlock",
	"Muffin.Mounts.Item",
	"Muffin.Mounts.Paladin",
	"Muffin.Skill.Archaeology.Lodestone",
	"Muffin.Skill.Archaeology.Map",
	"Muffin.Skill.Fishing.Bait",
	"Muffin.Skill.Fishing.Pole",
	"Muffin.Herbs.Millable",
	"Muffin.Covenant.Anima",
	"Muffin.Covenant.Conduit",
	"Muffin.Covenant.Wildseed",
}

atl_table(quick_sets);
