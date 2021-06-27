--
-- AutoBar
-- http://muffinmangames.com
-- Various Artists
--

if (GetLocale() == "enUS") then
	AutoBarGlobalDataObject.locale = {
		["CONFIG_WINDOW"] = "Configuration Window",
		["SLASHCMD_LONG"] = "autobar",
		["SLASHCMD_SHORT"] = "atb",
		["Button"] = "Button",
		["Toggle the config panel"] = "Toggle the config panel",

		-- Config
		["Alpha"] = "Alpha",
		["Change the alpha of the bar."] = "Change the alpha of the bar.",
		["Add Button"] = "Add Button",
		["Align Buttons"] = "Align Buttons",
		["Always Popup"] = "Always Popup";
		["Always keep Popups open for %s"] = "Always keep Popups open for %s";
		["Always Show"] = "Always Show";
		["Always Show %s, even if empty."] = "Always Show %s, even if empty.";
		["Bar Location"] = "Bar Location",
		["Bar the Button is located on"] = "Bar the Button is located on",
		["Bars"] = "Bars",
		["Battlegrounds only"] = "Battlegrounds only",
		["Button Width"] = "Button Width",
		["Change the button width."] = "Change the button width.",
		["Button Height"] = "Button Height",
		["Change the button height."] = "Change the button height.",
		["Category"] = "Category",
		["Categories"] = "Categories",
		["Categories for %s"] = "Categories for %s",
		["Clamp Bars to screen"] = "Clamp Bars to screen",
		["Clamped Bars can not be positioned off screen"] = "Clamped Bars can not be positioned off screen",
		["Collapse Buttons"] = "Collapse Buttons",
		["Collapse Buttons that have nothing in them."] = "Collapse Buttons that have nothing in them.",
		["Configuration for %s"] = "Configuration for %s",
		["Delete this Custom Button completely"] = "Delete this Custom Button completely",
		["Dialog"] = "Dialog",
		["Disable Conjure Button"] = "Disable Conjure Button",
		["Docked to"] = "Docked to",
		["Done"] = "Done";
		["Drag"] = "Drag",
		["Drag to move items, spells or macros using the Cursor"] = "Drag to move items, spells or macros using the Cursor",
		["Drop"] = "Drop";
		["Drop items, spells or macros onto Button to add them to its top Custom Category"] = "Drop items, spells or macros onto Button to add them to its top Custom Category";
		["Enabled"] = "Enabled",
		["Enable %s."] = "Enable %s.",
		["FadeOut"] = "Fade Out",
		["Fade out the Bar when not hovering over it."] = "Fade out the Bar when not hovering over it.",
		["FadeOut Time"] = "FadeOut Time",
		["FadeOut takes this amount of time."] = "FadeOut takes this amount of time",
		["FadeOut Alpha"] = "FadeOut Alpha",
		["FadeOut stops at this Alpha level."] = "FadeOut stops at this Alpha level.",
		["FadeOut Cancels in combat"] = "FadeOut Cancels in combat",
		["FadeOut is cancelled when entering combat."] = "FadeOut is cancelled when entering combat.",
		["FadeOut Cancels on Shift"] = "FadeOut Cancels on Shift",
		["FadeOut is cancelled when holding down the Shift key."] = "FadeOut is cancelled when holding down the Shift key.",
		["FadeOut Cancels on Ctrl"] = "FadeOut Cancels on Ctrl",
		["FadeOut is cancelled when holding down the Ctrl key."] = "FadeOut is cancelled when holding down the Ctrl key.",
		["FadeOut Cancels on Alt"] = "FadeOut Cancels on Alt",
		["FadeOut is cancelled when holding down the Alt key."] = "FadeOut is cancelled when holding down the Alt key.",
		["FadeOut Delay"] = "FadeOut Delay",
		["FadeOut starts after this amount of time."] = "FadeOut starts after this amount of time.",
		["Frame Level"] = "Frame Level",
		["Adjust the Frame Level of the Bar and its Popup Buttons so they apear above or below other UI objects"] = "Adjust the Frame Level of the Bar and its Popup Buttons so they apear above or below other UI objects",
		["General"] = "General",
		["Hide"] = "Hide",
		["Hide %s"] = "Hide %s",
		["Items"] = "Items",
		["Location"] = "Location",
		["Macro Text"] = "Macro Text",
		["Show the button Macro Text"] = "Show the button Macro Text",
		["Medium"] = "Medium",
		["Name"] = "Name",
		["New"] = "New",
		["New Macro"] = "New Macro",
		["No Popup"] = "No Popup";
		["No Popup for %s"] = "No Popup for %s";
		["Non Combat Only"] = "Non Combat Only",
		["Number of columns for %s"] = "Number of columns for %s",
		["Dropdown UI"] = "Dropdown UI",
		["Options GUI"] = "Options GUI",
		["Skin the Buttons"] = "Skin the Buttons",
		["Order"] = "Order",
		["Change the order of %s in the Bar"] = "Change the order of %s in the Bar",
		["Padding"] = "Padding",
		["Change the padding of the bar."] = "Change the padding of the bar.",
		["Popup Direction"] = "Popup Direction",
		["Popup on Shift Key"] = "Popup on Shift Key";
		["Popup while Shift key is pressed for %s"] = "Popup while Shift key is pressed for %s";
		["Rearrange Order on Use"] = "Rearrange Order on Use";
		["Rearrange Order on Use for %s"] = "Rearrange Order on Use for %s";
		["Right Click Targets Pet"] = "Right Click Targets Pet";
		["None"] = "None";
		["Refresh"] = "Refresh",
		["Refresh all the bars & buttons"] = "Refresh all the bars & buttons",
		["Remove"] = "Remove",
		["Remove this Button from the Bar"] = "Remove this Button from the Bar",
		["Reset"] = "Reset",
		["Reset Bars"] = "Reset Bars",
		["Reset everything to default values for all characters.  Custom Bars, Buttons and Categories remain unchanged."] = "Reset everything to default values for all characters.  Custom Bars, Buttons and Categories remain unchanged.",
		["Reset the Bars to default Bar settings"] = "Reset the Bars to default Bar settings",
		["Revert"] = "Revert";
		["Right Click casts "] = "Right Click casts ",
		["Rows"] = "Rows",
		["Number of rows for %s"] = "Number of rows for %s",
		["RightClick SelfCast"] = "RightClick SelfCast",
		["SelfCast using Right click"] = "SelfCast using Right click",
		["Assign Bindings for Buttons on your Bars."] = "Assign Bindings for Buttons on your Bars.",
		["Scale"] = "Scale",
		["Change the scale of the bar."] = "Change the scale of the bar.",
		["Shared Layout"] = "Shared Layout",
		["Share the Bar Visual Layout"] = "Share the Bar Visual Layout",
		["Shared Buttons"] = "Shared Buttons",
		["Share the Bar Button List"] = "Share the Bar Button List",
		["Shared Position"] = "Shared Position",
		["Share the Bar Position"] = "Share the Bar Position",
		["Shift Dock Left/Right"] = "Shift Dock Left/Right",
		["Shift Dock Up/Down"] = "Shift Dock Up/Down",
		["Show Count Text"] = "Show Count Text";
		["Show Count Text for %s"] = "Show Count Text for %s";
		["Show Empty Buttons"] = "Show Empty Buttons";
		["Show Empty Buttons for %s"] = "Show Empty Buttons for %s";
		["Show Extended Tooltips"] = "Show Extended Tooltips";
		["Show Hotkey Text"] = "Show Hotkey Text",
		["Show Hotkey Text for %s"] = "Show Hotkey Text for %s",
		["Show Minimap Icon"] = "Show Minimap Icon";
		["Show Tooltips"] = "Show Tooltips";
		["Show Tooltips for %s"] = "Show Tooltips for %s";
		["Show Tooltips in Combat"] = "Show Tooltips in Combat";
		["Shuffle"] = "Shuffle",
		["Shuffle replaces depleted items during combat with the next best item"] = "Shuffle replaces depleted items during combat with the next best item",
		["Snap Bars while moving"] = "Snap Bars while moving",
		["Sticky Frames"] = "Sticky Frames",
		["Style"] = "Style",
		["Targeted"] = "Targeted",
		["<Any String>"] = "<Any String>",
		["Move the Bars"] = "Move the Bars",
		["Drag a bar to move it, left click to hide (red) or show (green) the bar, right click to configure the bar."] = "Drag a bar to move it, left click to hide (red) or show (green) the bar, right click to configure the bar.",
		["Move the Buttons"] = "Move the Buttons",
		["Drag a Button to move it, right click to configure the Button."] = "Drag a Button to move it, right click to configure the Button.",

		["{star}"] = "{rt1}",
		["{circle}"] = "{rt2}",
		["{diamond}"] = "{rt3}",
		["{triangle}"] = "{rt4}",
		["{moon}"] = "{rt5}",
		["{square}"] = "{rt6}",
		["{x}"] = "{rt7}",
		["{skull}"] = "{rt8}",

		["TOPLEFT"] = "Top Left",
		["LEFT"] = "Left",
		["BOTTOMLEFT"] = "Bottom Left",
		["TOP"] = "Top",
		["CENTER"] = "Center",
		["BOTTOM"] = "Bottom",
		["TOPRIGHT"] = "Top Right",
		["RIGHT"] = "Right",
		["BOTTOMRIGHT"] = "Bottom Right",

		["Left-Click"] = "Left-Click",
		["Right-Click"] = "Right-Click",
		["Alt-Click"] = "Alt-Click",
		["Ctrl-Click"] = "Ctrl-Click",
		["Shift-Click"] = "Shift-Click",
		["Ctrl-Shift-Click"] = "Ctrl-Shift-Click",

		-- Bar Names
		["AutoBarClassBarBasic"] = "Basic",
		["AutoBarClassBarExtras"] = "Extras",

		-- Button Names
		["Buttons"] = "Buttons",
		["AutoBarButtonHeader"] = "AutoBar Named Buttons",
		["AutoBarCooldownHeader"] = "Potion & Stone Cooldown",
		["AutoBarClassBarHeader"] = "Class bar",

		["AutoBarButtonAspect"] = "Aspect",
		["AutoBarButtonPoisonLethal"] = "Poison: Lethal",
		["AutoBarButtonPoisonNonlethal"] = "Poison: Nonlethal",
		["AutoBarButtonBandages"] = "Bandages",
		["AutoBarButtonBattleStandards"] = "Battle Standards",
		["AutoBarButtonBuff"] = "Buff",
		["AutoBarButtonBuffWeapon1"] = "Buff Weapon",
		["AutoBarButtonCharge"] = "Charge",
		["AutoBarButtonClassBuff"] = "Class Buff",
		["AutoBarButtonClassPet"] = "Class Pet",
		["AutoBarButtonClassPets2"] = "Pet Combat",
		["AutoBarButtonClassPets3"] = "Pet Misc",
		["AutoBarButtonConjure"] = "Conjure",
		["AutoBarButtonOpenable"] = "Openable",
		["AutoBarButtonCooldownDrums"] = "Cooldown: Drums",
		["AutoBarButtonCooldownPotionCombat"] = "Potion Cooldown: Combat",
		["AutoBarButtonCooldownPotionHealth"] = "Potion Cooldown: Health",
		["AutoBarButtonCooldownPotionMana"] = "Potion Cooldown: Mana",
		["AutoBarButtonCooldownPotionRejuvenation"] = "Potion Cooldown: Rejuvenation",
		["AutoBarButtonCooldownStoneHealth"] = "Stone Cooldown: Health",
		["AutoBarButtonCooldownStoneMana"] = "Stone Cooldown: Mana",
		["AutoBarButtonCooldownStoneRejuvenation"] = "Stone Cooldown: Rejuvenation",
		["AutoBarButtonCrafting"] = "Crafting",
		["AutoBarButtonDebuff"] = "Debuff",
		["AutoBarButtonElixirBattle"] = "Battle Elixir",
		["AutoBarButtonElixirGuardian"] = "Guardian Elixir",
		["AutoBarButtonElixirBoth"] = "Flask",
		["AutoBarButtonER"] = "ER",
		["AutoBarButtonExplosive"] = "Explosive",
		["AutoBarButtonFishing"] = "Fishing",
		["AutoBarButtonFood"] = "Food",
		["AutoBarButtonFoodBuff"] = "Food Buff",
		["AutoBarButtonFoodCombo"] = "Food Combo",
		["AutoBarButtonFoodPet"] = "Pet Food",
		["AutoBarButtonFreeAction"] = "Free Action",
		["AutoBarButtonHeal"] = "Heal",
		["AutoBarButtonHearth"] = "Hearth",
		["AutoBarButtonPickLock"] = "Pick Lock",
		["AutoBarButtonMount"] = "Mount",
		["AutoBarButtonPets"] = "Pets",
		["AutoBarButtonQuest"] = "Quest",
		["AutoBarButtonMiscFun"] = "Misc, Fun",
		["AutoBarButtonGuildSpell"] = "Guild Spells",
		["AutobarSunsongRanch"] = "Sunsong Ranch",
		["AutoBarButtonRecovery"] = "Mana / Rage / Energy",
		["AutoBarButtonRotationDrums"] = "Rotation: Drums",
		["AutoBarButtonShields"] = "Shields",
		["AutoBarButtonSpeed"] = "Speed",
		["AutoBarButtonStance"] = "Stance",
		["AutoBarButtonStealth"] = "Stealth",
		["AutoBarButtonSting"] = "Sting",
		["AutoBarButtonSeal"] = "Seal",
		["AutoBarButtonTotemEarth"] = "Earth Totem",
		["AutoBarButtonTotemAir"] = "Air Totem",
		["AutoBarButtonTotemFire"] = "Fire Totem",
		["AutoBarButtonTotemWater"] = "Water Totem",
		["AutoBarButtonTrap"] = "Trap",
		["AutoBarButtonTrinket1"] = "Trinket 1",
		["AutoBarButtonTrinket2"] = "Trinket 2",
		["AutoBarButtonWater"] = "Water",
		["AutoBarButtonWaterBuff"] = "Water Buff",


		["AutoBarButtonBear"] = "Bear",
		["AutoBarButtonBoomkinTree"] = "Tree of Life / Boomkin",
		["AutoBarButtonCat"] = "Cat",
		["AutoBarButtonTravel"] = "Travel",

		-- AutoBarClassButton.lua
		["Spacebar"] = KEY_SPACE,
		["Up Arrow"] = KEY_UP,
		["Right Arrow"] = KEY_RIGHT,
		["|c00FF9966C|r"] = "|c00FF9966C|r",
		["|c00CCCC00S|r"] = "|c00CCCC00S|r",
		["|c009966CCA|r"] = "|c009966CCA|r",
		["Sp"] = "Sp",
		["U"] = "U",

		--  AutoBarConfig.lua
		["Default"] = "Default",
		["Zoomed"] = "Zoomed",
		["Columns"] = "Columns";
		["AUTOBAR_CONFIG_BT3BAR"] = "BarTender3 Bar";
		["AUTOBAR_CONFIG_DOCKTOMAIN"] = "Main Menu";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAME"] = "Chat Frame";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"] = "Chat Frame Menu";
		["AUTOBAR_CONFIG_DOCKTOACTIONBAR"] = "Action Bar";
		["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"] = "Menu Buttons";
		["Shared"] = "Shared";
		["Account"] = "Account";
		["Class"] = "Class";
		["Log Events"] = "Log Events";
		["Log Memory"] = "Log Memory";
		["Log Performance"] = "Log Performance";
		["Share the config"] = "Share the config";

		-- AutoBarCategory
		["Misc.Engineering.Fireworks"] = "Fireworks",
		["Tradeskill.Tool.Fishing.Lure"] = "Fishing Lures",
		["Tradeskill.Tool.Fishing.Gear"] = "Fishing Gear",
		["Tradeskill.Tool.Fishing.Other"] = "Fishing Stuff",
		["Tradeskill.Tool.Fishing.Tool"] = "Fishing Poles",

		["Consumable.Food.Bonus"] = "Food: All Bonus Foods";
		["Consumable.Food.Buff.Strength"] = "Food: Strength Bonus";
		["Consumable.Food.Buff.Agility"] = "Food: Agility Bonus";
		["Consumable.Food.Buff.Attack Power"] = "Food: Attack Power Bonus";
		["Consumable.Food.Buff.Healing"] = "Food: Healing Bonus";
		["Consumable.Food.Buff.Spell Damage"] = "Food: Spell Damage Bonus";
		["Consumable.Food.Buff.Stamina"] = "Food: Stamina Bonus";
		["Consumable.Food.Buff.Intellect"] = "Food: Intelligence Bonus";
		["Consumable.Food.Buff.Spirit"] = "Food: Spirit Bonus";
		["Consumable.Food.Buff.Mana Regen"] = "Food: Mana Regen Bonus";
		["Consumable.Food.Buff.HP Regen"] = "Food: HP Regen Bonus";
		["Consumable.Food.Buff.Other"] = "Food: Other";

		["Consumable.Buff.Health"] = "Buff: Health";
		["Consumable.Buff.Armor"] = "Buff: Armor";
		["Consumable.Buff.Regen Health"] = "Buff: Regen Health";
		["Consumable.Buff.Agility"] = "Buff: Agility";
		["Consumable.Buff.Intellect"] = "Buff: Intellect";
		["Consumable.Buff.Protection"] = "Buff: Protection";
		["Consumable.Buff.Spirit"] = "Buff: Spirit";
		["Consumable.Buff.Stamina"] = "Buff: Stamina";
		["Consumable.Buff.Strength"] = "Buff: Strength";
		["Consumable.Buff.Attack Power"] = "Buff: Attack Power";
		["Consumable.Buff.Attack Speed"] = "Buff: Attack Speed";
		["Consumable.Buff.Dodge"] = "Buff: Dodge";
		["Consumable.Buff.Resistance"] = "Buff: Resistance";

		["Consumable.Buff Group.General.Self"] = "Buff: General";
		["Consumable.Buff Group.General.Target"] = "Buff: General Target";
		["Consumable.Buff Group.Caster.Self"] = "Buff: Caster";
		["Consumable.Buff Group.Caster.Target"] = "Buff: Caster Target";
		["Consumable.Buff Group.Melee.Self"] = "Buff: Melee";
		["Consumable.Buff Group.Melee.Target"] = "Buff: Melee Target";
		["Consumable.Buff.Other.Self"] = "Buff: Other";
		["Consumable.Buff.Chest"] = "Buff: Chest";
		["Consumable.Buff.Shield"] = "Buff: Shield";
		["Consumable.Weapon Buff"] = "Buff: Weapon";

		["Misc.Usable.BossItem"] = "Boss Items";
		["Misc.Usable.Fun"] = "Fun Items";
		["Misc.Usable.Permanent"] = "Permanently Usable Items";
		["Misc.Usable.Quest"] = "Usable Quest Items";
		["Misc.Usable.StartsQuest"] = "Starts Quest";
		["Misc.Usable.Replenished"] = "Replenished Items";

		["Consumable.Cooldown.Potion.Health.Anywhere"] = "Heal Potions: Anywhere";
		["Consumable.Cooldown.Potion.Health.Basic"] = "Heal Potions";
		["Consumable.Cooldown.Potion.Health.Blades Edge"] = "Heal Potions: Blades Edge";
		["Consumable.Cooldown.Potion.Health.Coilfang"] = "Heal Potions: Coilfang Reservoir";
		["Consumable.Cooldown.Potion.Health.PvP"] = "Heal Potions: Battleground";
		["Consumable.Cooldown.Potion.Health.Tempest Keep"] = "Heal Potions: Tempest Keep";
		["Consumable.Cooldown.Potion.Mana.Anywhere"] = "Mana Potions: Anywhere";
		["Consumable.Cooldown.Potion.Mana.Basic"] = "Mana Potions";
		["Consumable.Cooldown.Potion.Mana.Blades Edge"] = "Mana Potions: Blades Edge";
		["Consumable.Cooldown.Potion.Mana.Coilfang"] = "Mana Potions: Coilfang Reservoir";
		["Consumable.Cooldown.Potion.Mana.Pvp"] = "Mana Potions: Battleground";
		["Consumable.Cooldown.Potion.Mana.Tempest Keep"] = "Mana Potions: Tempest Keep";

		["Consumable.Weapon Buff.Poison.Crippling"] = "Crippling Poison";
		["Consumable.Weapon Buff.Poison.Deadly"] = "Deadly Poison";
		["Consumable.Weapon Buff.Poison.Instant"] = "Instant Poison";
		["Consumable.Weapon Buff.Poison.Mind Numbing"] = "Mind-Numbing Poison";
		["Consumable.Weapon Buff.Poison.Wound"] = "Wounding Poison";
		["Consumable.Weapon Buff.Oil.Mana"] = "Mana Oil";
		["Consumable.Weapon Buff.Oil.Wizard"] = "Wizard Oil";
		["Consumable.Weapon Buff.Stone.Sharpening Stone"] = "Sharpening Stone";
		["Consumable.Weapon Buff.Stone.Weight Stone"] = "Weight Stone";

		["Consumable.Bandage.Basic"] = "Bandages";
		["Consumable.Bandage.Battleground.Alterac Valley"] = "Alterac Bandages";
		["Consumable.Bandage.Battleground.Warsong Gulch"] = "Warsong Bandages";
		["Consumable.Bandage.Battleground.Arathi Basin"] = "Arathi Bandages";

		["Consumable.Food.Edible.Basic.Non-Conjured"] = "Food: No Bonus";
		["Consumable.Food.Percent.Basic"] = "Food: % health gain";
		["Consumable.Food.Percent.Bonus"] = "Food: % HP Regen (well fed buff)";
		["Consumable.Food.Edible.Combo.Non-Conjured"] = "Food: combo health & mana gain, non-conjured";
		["Consumable.Food.Edible.Combo.Conjured"] = "Food: combo health & mana gain, conjured";
		["Consumable.Food.Combo Percent"] = "Food: % health & mana gain";
		["Consumable.Food.Combo Health"] = "Food & Water Combo";
		["Consumable.Food.Edible.Bread.Conjured"] = "Food: Mage Conjured";
		["Consumable.Food.Conjure"] = "Conjure Food";
		["Consumable.Food.Edible.Battleground.Arathi Basin.Basic"] = "Food: Arathi Basin";
		["Consumable.Food.Edible.Battleground.Warsong Gulch.Basic"] = "Food: Warsong Gulch";
		["Consumable.Food.Feast"] = "Food: Feast";

		["Consumable.Food.Pet.Bread"] = "Food: Pet Bread";
		["Consumable.Food.Pet.Cheese"] = "Food: Pet Cheese";
		["Consumable.Food.Pet.Fish"] = "Food: Pet Fish";
		["Consumable.Food.Pet.Fruit"] = "Food: Pet Fruit";
		["Consumable.Food.Pet.Fungus"] = "Food: Pet Fungus";
		["Consumable.Food.Pet.Meat"] = "Food: Pet Meat";

		["Consumable.Buff Pet"] = "Buff: Pet";

		["Custom"] = "Custom";
		["Misc.Minipet.Normal"] = "Pet";
		["Misc.Minipet.Snowball"] = "Holiday Pet";

		["Consumable.Anti-Venom"] = "Anti-Venom";

		["Consumable.Warlock.Soulstone"] = "Soulstone";
		["Consumable.Cooldown.Stone.Health.Warlock"] = "Healthstone";
		["Spell.Warlock.Create Healthstone"] = "Create Healthstone";
		["Spell.Warlock.Create Soulstone"] = "Create Soulstone";
		["Consumable.Cooldown.Stone.Mana.Mana Stone"] = "Mana Gem";
		["Consumable.Cooldown.Stone.Rejuvenation.Dreamless Sleep"] = "Dreamless Sleep";
		["Consumable.Cooldown.Potion.Rejuvenation"] = "Rejuvenation Potions";
		["Consumable.Cooldown.Stone.Health.Statue"] = "Stone Statues";
		["Consumable.Cooldown.Drums"] = "Cooldown: Drums";
		["Consumable.Cooldown.Potion"] = "Cooldown: Potion";
		["Consumable.Cooldown.Potion.Combat"] = "Cooldown: Potion - Combat";
		["Consumable.Cooldown.Stone"] = "Cooldown: Stone";
		["Consumable.Leatherworking.Drums"] = "Drums";
		["Consumable.Tailor.Net"] = "Nets";

		["Misc.Battle Standard.Guild"] = "Guild Standard";
		["Misc.Battle Standard.Battleground"] = "Battle Standard";
		["Misc.Battle Standard.Alterac Valley"] = "Battle Standard AV";
		["Consumable.Cooldown.Stone.Health.Other"] = "Heal Items: Other";
		["Consumable.Cooldown.Stone.Mana.Other"] = "Demonic and Dark Runes";
		["Consumable.Buff.Free Action"] = "Buff: Free Action";

		["Misc.Lockboxes"] = "Lockboxes";

		["Spell.Guild"] = "Guild Spells";
		["Autobar.SunsongRanch"] = "Sunsong Ranch";

		["Spell.Aspect"] = "Aspect";
		["Spell.Poison.Lethal"] = "Poison: Lethal";
		["Spell.Poison.Nonlethal"] = "Poison Nonlethal";
		["Spell.Buff.Weapon"] = "Buff Spells: Weapon";
		["Spell.Class.Buff"] = "Class Buff";
		["Spell.Class.Pet"] = "Class Pet";
		["Spell.Class.Pets2"] = "Pet Combat";
		["Spell.Class.Pets3"] = "Pet Misc";
		["Spell.Crafting"] = "Crafting";
		["Spell.Critter"] = "Pet Spells";
		["Spell.Debuff.Multiple"] = "Debuff: Multiple";
		["Spell.Debuff.Single"] = "Debuff: Single";
		["Spell.Fishing"] = "Fishing";
		["Spell.Portals"] = "Portals and Teleports";
		["Spell.Shields"] = "Shields";
		["Spell.Sting"] = "Sting";
		["Spell.Stance"] = "Stance";
		["Spell.Totem.Earth"] = "Earth Totem";
		["Spell.Totem.Air"] = "Air Totem";
		["Spell.Totem.Fire"] = "Fire Totem";
		["Spell.Totem.Water"] = "Water Totem";
		["Spell.Seal"] = "Seal";
		["Spell.Trap"] = "Trap";
		["Misc.Booze"] = "Booze";
		["Misc.Hearth"] = "Hearthstone";
		["Misc.Openable"] = "Openable";
		["Consumable.Water.Basic"] = "Water";
		["Consumable.Water.Percentage"] = "Water: % mana gain";
		["Consumable.Water.Conjure"] = "Conjure Water";
		["Consumable.Water.Buff.Spirit"] = "Water: Spirit Bonus";
		["Consumable.Water.Buff"] = "Water: Bonus";
		["Consumable.Buff.Rage"] = "Rage Potions";
		["Consumable.Buff.Energy"] = "Energy Potions";
		["Consumable.Buff.Speed"] = "Buff: Swiftness";
		["Consumable.Buff Type.Battle"] = "Buff: Battle Elixir";
		["Consumable.Buff Type.Guardian"] = "Buff: Guardian Elixir";
		["Consumable.Buff Type.Flask"] = "Buff: Flask";
		["Muffin.Explosives"] = "Explosives";

		["Misc.Spell.Mount.Ahn'Qiraj"]="Mounts: Qiraji",
		["Misc.Spell.Mount.Flying.Fast"]="Mounts: Fast Flying",
		["Misc.Spell.Mount.Flying.Slow"]="Mounts: Slow Flying",
		["Misc.Spell.Mount.Ground.Fast"]="Mounts: Fast",
		["Misc.Spell.Mount.Ground.Slow"]="Mounts: Slow",

		["Spell.Mount"] = "Mount Spells";

		["Misc.Mount.Normal"] = "Mounts";
		["Misc.Mount.Summoned"] = "Mounts: Summoned";
		["Misc.Mount.Ahn'Qiraj"] = "Mounts: Qiraji";
		["Misc.Mount.Flying"] = "Mounts: Flying";
	}


end
