--
-- AutoBarDB
-- Copyright 2008+ Toadkiller of Proudmoore.
--
-- Defaults, initialization and persistence for AutoBar
-- http://muffinmangames.com
--

-- Custom Category:
--  AutoBarDB2.custom_categories[categoryKey]
--	A separate list of Categories that is global to all players
--	Users can add their own custom Categories to the list.
--	Custom Categories can have specific items and spells dragged into their list.
--	Custom Categories can also be set to PT3 Sets, one regular Set & one priority Set
--	A priority Set item has priority over a regular Set item with the same value.
--	All common settings available to a built in Category are also available to a Custom category

-- CustomButton:
--	A separate list of Buttons that is global to all players

-- Button:
--  AutoBar.db.<account|class|char>.buttonList[buttonIndex]
--	Some Buttons like custom Buttons can have their Categories chosen from the Categories list

--  AutoBar.db.char.buttons[buttonKey]
--  Contains the defaults for Button settings & changes to the settings are stored here.
--  Enable / Disable state is recorded here
--  Only one buttonKey per button found in a Bar
--  barKey.  Defaults to default bar to place on.  Moving Button changes barKey to match.  Removing Button nils it.
--  defaultButtonIndex (#, "*" for at end, "~" for do not place, "buttonKey" to insert after a button).
--    Buttons are placed in their barKey at defaultButtonIndex on initialize.
--  deleted: false. Can be deleted by deleting from a Bar.
--  Deleted Buttons can be added back to a Bar
--  Plugin & Custom Buttons are added here & must have non-clashing names

-- Bar:
--  AutoBar.barLayoutDBList
--  AutoBar.barList
--  AutoBar.db.account.barList[buttonKey]		-- common
--  AutoBar.db.class.barList[buttonKey]		-- class
--  AutoBar.db.char.barList[buttonKey]		-- char
--  Bars contain a list of their Buttons
--  Also, resetting a Bar replaces all buttons defaulting to it.
--	Buttons can be reordered within the Bar
--	enabled: true or false
--  Plugin & Custom Bars are added here & must have non-clashing names

-- ToDo:
-- BarSettings:
--  AutoBar.db.*.barSettings[barKey]
--	Bar & Button visual settings are inherited AutoBar -> Bar -> Button
--  Plugin Buttons / Bars


local AutoBar = AutoBar
local ABGCode = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject
local L = ABGData.locale

local CLASS_COLUMN_DEFAULT = 10


local classBar = {
	DEATHKNIGHT = "AutoBarClassBarDeathKnight",
	DEMONHUNTER = "AutoBarClassBarDemonHunter",
	DRUID = "AutoBarClassBarDruid",
	HUNTER = "AutoBarClassBarHunter",
	MAGE = "AutoBarClassBarMage",
	MONK = "AutoBarClassBarMonk",
	PALADIN = "AutoBarClassBarPaladin",
	PRIEST = "AutoBarClassBarPriest",
	ROGUE = "AutoBarClassBarRogue",
	SHAMAN = "AutoBarClassBarShaman",
	WARLOCK = "AutoBarClassBarWarlock",
	WARRIOR = "AutoBarClassBarWarrior",
}

local changed_category_key_dict = {
	["Consumable.Buff Type.Both"] = "Consumable.Buff Type.Flask",
	["Muffin.Reputation"] = "Muffin.Misc.Reputation",
	["Muffin.Mount"] = "Muffin.Mounts",
	["Tradeskill.Gather.Herbalism"] = "Muffin.Herbs.Millable",
}
local function verify_db()
	-- Temporary, implement buttonKey field
	for buttonKey, buttonDB in pairs(AutoBar.db.char.buttonList) do
		buttonDB.buttonKey = buttonKey
		if (buttonDB.buttonClass ~= "AutoBarButtonCustom") then
			buttonDB.name = nil
		end
		for categoryIndex, categoryKey in ipairs(buttonDB) do
			local changedCategoryKey = changed_category_key_dict[categoryKey]
			if (changedCategoryKey) then
				buttonDB[categoryIndex] = changedCategoryKey
			end
		end
	end
	for buttonKey, buttonDB in pairs(AutoBar.db.class.buttonList) do
		buttonDB.buttonKey = buttonKey
		if (buttonDB.buttonClass ~= "AutoBarButtonCustom") then
			buttonDB.name = nil
		end
		for categoryIndex, categoryKey in ipairs(buttonDB) do
			local changedCategoryKey = changed_category_key_dict[categoryKey]
			if (changedCategoryKey) then
				buttonDB[categoryIndex] = changedCategoryKey
			end
		end
	end
	for buttonKey, buttonDB in pairs(AutoBar.db.account.buttonList) do
		buttonDB.buttonKey = buttonKey
		if (buttonDB.buttonClass ~= "AutoBarButtonCustom") then
			buttonDB.name = nil
		end
		for categoryIndex, categoryKey in ipairs(buttonDB) do
			local changedCategoryKey = changed_category_key_dict[categoryKey]
			if (changedCategoryKey) then
				buttonDB[categoryIndex] = changedCategoryKey
			end
		end
	end
end

function AutoBar.InitializeDB()
	AutoBar.classBar = classBar[AutoBar.CLASS]

	AutoBarDB2 = AutoBarDB2 or {}
	AutoBarDB2.custom_categories = AutoBarDB2.custom_categories or AutoBar.db.account.customCategories or {}
	AutoBarDB2.whatsnew_version = AutoBarDB2.whatsnew_version or AutoBarDB.whatsnew_version
	AutoBarDB2.performance_threshold = AutoBarDB2.performance_threshold or 100
	if (AutoBarDB2.performance_threshold < 20) then AutoBarDB2.performance_threshold = 100; end;

	AutoBar:UpgradeVersion()
	AutoBar:InitializeDefaults()

-- ToDo: Temporary, implement buttonKey field.  Remove sometime after beta.
	verify_db()


	AutoBar:RefreshButtonDBList()
	AutoBar:RefreshBarDBLists()
	AutoBar:BarsCompact()
	AutoBar:RemoveDuplicateButtons()
	AutoBar:RefreshUnplacedButtonList()
	AutoBar:PopulateBars()
end


-- Character specific data for a particular Button
-- For instance, the arrangeOnUse item.

local function get_bar_default_settings()

	local settings =
	{
		enabled = true,
		rows = 1,
		columns = 16,
		alignButtons = "3",
		alpha = 1,
		buttonWidth = 36,
		buttonHeight = 36,
		docking = nil,
		dockShiftX = 0,
		dockShiftY = 0,
		fadeOut = false,
		frameStrata = "LOW",
		hide = false,
		padding = 0,
		popupDirection = "1",
		scale = 1,
		showOnModifier = nil,
		posX = 300,
		posY = 200,
		DEATHKNIGHT = true,
		DEMONHUNTER = true,
		DRUID = true,
		HUNTER = true,
		MAGE = true,
		MONK = true,
		PALADIN = true,
		PRIEST = true,
		ROGUE = true,
		SHAMAN = true,
		WARLOCK = true,
		WARRIOR = true,
		buttonKeys = {},
	}

	return settings

end

local function get_class_bar_default_settings(p_class_name)

	local settings =
	{
		enabled = true,
		share = "2",
		rows = 1,
		columns = CLASS_COLUMN_DEFAULT,
		alignButtons = "3",
		alpha = 1,
		buttonWidth = 36,
		buttonHeight = 36,
		docking = nil,
		dockShiftX = 0,
		dockShiftY = 0,
		fadeOut = false,
		frameStrata = "LOW",
		hide = false,
		padding = 0,
		popupDirection = "1",
		scale = 1,
		showOnModifier = nil,
		posX = 300,
		posY = 280,
		DEMONHUNTER = true,
		buttonKeys = {},
	}

	settings[p_class_name] = true

	return settings

end

function AutoBar:InitializeDefaults()
	if (not self.defaults) then
		self.defaults = {
			name = "Spambelly",
			guiName = "Spambelly",
			alignButtons = "3",
			frameLocked = false,
			showCount = true,
			showHotkey = true,
			showTooltip = true,
			showMacrotext = true,
			performance = false,
			log_throttled_events = false,
			throttle_event_limit = 0.0,
			handle_spell_changed = true,
			hack_PetActionBarFrame = true,
			selfCastRightClick = true,
			showEmptyButtons = false,
			style = "Dreamlayout",
			barList = {},
		}
	end
	if(self.defaults.handle_spell_changed == nil) then
		self.defaults.handle_spell_changed = true
	end
	if(self.defaults.hack_PetActionBarFrame == nil) then
		self.defaults.hack_PetActionBarFrame = true
	end


	self:RegisterDefaults('account', self.defaults)

	AutoBar.Class.Bar:OptionsInitialize()
	AutoBar.Class.Bar:OptionsUpgrade()

	AutoBar.Class.Button:OptionsInitialize()
	AutoBar.Class.Button:OptionsUpgrade()

	AutoBar.db.account.stupidlog = ""

	-- Simply ascend by 1 so each session produces non-conflicting keys.
	if (not AutoBar.db.account.keySeed) then
		AutoBar.db.account.keySeed = 1
	end

	if (not AutoBar.db.account.barList["AutoBarClassBarBasic"]) then
		AutoBar.db.account.barList["AutoBarClassBarBasic"] = get_bar_default_settings();
	end
	if (not AutoBar.db.account.barList["AutoBarClassBarExtras"]) then
		AutoBar.db.account.barList["AutoBarClassBarExtras"] = get_bar_default_settings();
		AutoBar.db.account.barList["AutoBarClassBarExtras"].columns = 9
		AutoBar.db.account.barList["AutoBarClassBarExtras"].posX = 300
		AutoBar.db.account.barList["AutoBarClassBarExtras"].posY = 360
	end

--#region ClassBars
	--
	-- Create the various class bars
	--

	--TODO: This is a duplicate of data at the top of this file?
	local class_bar_map =
	{
		DEMONHUNTER = "AutoBarClassBarDemonHunter",
		DEATHKNIGHT = "AutoBarClassBarDeathKnight",
		DRUID = "AutoBarClassBarDruid",
		HUNTER = "AutoBarClassBarHunter",
		MAGE = "AutoBarClassBarMage",
		MONK = "AutoBarClassBarMonk",
		PALADIN = "AutoBarClassBarPaladin",
		PRIEST = "AutoBarClassBarPriest",
		ROGUE = "AutoBarClassBarRogue",
		SHAMAN = "AutoBarClassBarShaman",
		WARLOCK = "AutoBarClassBarWarlock",
		WARRIOR = "AutoBarClassBarWarrior"
	}

	-- Create the character's class bar if it doesn't already exist
	local class_bar_name = class_bar_map[AutoBar.CLASS]
	if (not AutoBar.db.class.barList[class_bar_name]) then
		AutoBar.db.class.barList[class_bar_name] = get_class_bar_default_settings(AutoBar.CLASS)
	end

	-- A list of all buttons on the class bar that a class should have
	local class_button_map =
	{
		DEATHKNIGHT =
		{
			{button_name = "AutoBarButtonClassBuff" },
			{button_name = "AutoBarButtonDebuff" },
			{button_name = "AutoBarButtonClassPet" },
			{button_name = "AutoBarButtonClassPets2" },
			{button_name = "AutoBarButtonER" },
		},
		DEMONHUNTER =
		{
			{button_name = "AutoBarButtonER" },
			{button_name = "AutoBarButtonCharge" },
			{button_name = "AutoBarButtonTrap",},
		},
		DRUID =
		{
			{button_name = "AutoBarButtonBear", },
			{button_name = "AutoBarButtonCat", },
			{button_name = "AutoBarButtonTravel", },
			{button_name = "AutoBarButtonAquatic", project_id = WOW_PROJECT_CLASSIC},
			{button_name = "AutoBarButtonAquatic", project_id = WOW_PROJECT_BURNING_CRUSADE_CLASSIC},
			{button_name = "AutoBarButtonAquatic", project_id = WOW_PROJECT_WRATH_CLASSIC},
			{button_name = "AutoBarButtonStagForm", project_id = WOW_PROJECT_MAINLINE},
			{button_name = "AutoBarButtonMoonkin", },
			{button_name = "AutoBarButtonTreeForm", },
			{button_name = "AutoBarButtonStealth", },
			{button_name = "AutoBarButtonDebuff", },
			{button_name = "AutoBarButtonClassBuff", },
			{button_name = "AutoBarButtonStance", project_id = WOW_PROJECT_CLASSIC},
			{button_name = "AutoBarButtonStance", project_id = WOW_PROJECT_BURNING_CRUSADE_CLASSIC},
			{button_name = "AutoBarButtonStance", project_id = WOW_PROJECT_WRATH_CLASSIC},
			{button_name = "AutoBarButtonShields", },
			{button_name = "AutoBarButtonInterrupt", },
			{button_name = "AutoBarButtonER", },
		},
		HUNTER =
		{
			{button_name = "AutoBarButtonAspect" },
			{button_name = "AutoBarButtonCharge" },
			{button_name = "AutoBarButtonFoodPet", additional_args = {rightClickTargetsPet = true}},
			{button_name = "AutoBarButtonTrap"},
			{button_name = "AutoBarButtonStealth" },
			{button_name = "AutoBarButtonDebuff" },
			{button_name = "AutoBarButtonClassPet" },
			{button_name = "AutoBarButtonClassPets2" },
			{button_name = "AutoBarButtonClassPets3" },
			{button_name = "AutoBarButtonER" },
		},
		MAGE =
		{
			{button_name = "AutoBarButtonShields", },
			{button_name = "AutoBarButtonStealth", },
			{button_name = "AutoBarButtonConjure", },
			{button_name = "AutoBarButtonInterrupt", },
			{button_name = "AutoBarButtonER", },
			{button_name = "AutoBarButtonClassBuff", },
		},
		PALADIN =
		{
			{button_name = "AutoBarButtonShields", },
			{button_name = "AutoBarButtonClassBuff", },
			{button_name = "AutoBarButtonDebuff", },
			{button_name = "AutoBarButtonInterrupt", },
			{button_name = "AutoBarButtonER", },
			{button_name = "AutoBarButtonStance", },
			{button_name = "AutoBarButtonSeal", project_id = WOW_PROJECT_CLASSIC},
			{button_name = "AutoBarButtonTrack", project_id = WOW_PROJECT_CLASSIC},
			{button_name = "AutoBarButtonSeal", project_id = WOW_PROJECT_BURNING_CRUSADE_CLASSIC},
			{button_name = "AutoBarButtonTrack", project_id = WOW_PROJECT_BURNING_CRUSADE_CLASSIC},
			{button_name = "AutoBarButtonSeal", project_id = WOW_PROJECT_WRATH_CLASSIC},
			{button_name = "AutoBarButtonTrack", project_id = WOW_PROJECT_WRATH_CLASSIC},
		},
		PRIEST =
		{
			{button_name = "AutoBarButtonShields", },
			{button_name = "AutoBarButtonER", },
			{button_name = "AutoBarButtonClassBuff", },
			{button_name = "AutoBarButtonClassPet",},
			{button_name = "AutoBarButtonInterrupt", },
		},
		ROGUE =
		{
			{button_name = "AutoBarButtonShields", },
			{button_name = "AutoBarButtonStealth" },
			{button_name = "AutoBarButtonPoisonLethal", },
			{button_name = "AutoBarButtonPoisonNonlethal", },
			{button_name = "AutoBarButtonInterrupt", },
			{button_name = "AutoBarButtonCharge", },
			{button_name = "AutoBarButtonER" },
			{button_name = "AutoBarButtonPickLock", additional_args = {targeted = "Lockpicking"} },
			{button_name = "AutoBarButtonTrap", project_id = WOW_PROJECT_CLASSIC},
			{button_name = "AutoBarButtonTrap", project_id = WOW_PROJECT_BURNING_CRUSADE_CLASSIC},
			{button_name = "AutoBarButtonTrap", project_id = WOW_PROJECT_WRATH_CLASSIC},
		},
		SHAMAN =
		{
			{button_name = "AutoBarButtonTotemAir", },
			{button_name = "AutoBarButtonTotemEarth", },
			{button_name = "AutoBarButtonTotemFire", },
			{button_name = "AutoBarButtonTotemWater", },
			{button_name = "AutoBarButtonTravel", },
		},
		WARLOCK =
		{
			{button_name = "AutoBarButtonShields", },
			{button_name = "AutoBarButtonClassPets2", },
			{button_name = "AutoBarButtonER", },
			{button_name = "AutoBarButtonConjure", },
			{button_name = "AutoBarButtonClassBuff", },
			{button_name = "AutoBarButtonDebuff", },
			{button_name = "AutoBarButtonTrack", project_id = WOW_PROJECT_CLASSIC},
			{button_name = "AutoBarButtonTrack", project_id = WOW_PROJECT_BURNING_CRUSADE_CLASSIC},
			{button_name = "AutoBarButtonTrack", project_id = WOW_PROJECT_WRATH_CLASSIC},
			{button_name = "AutoBarButtonClassPet" },
		},
		WARRIOR =
		{
			{button_name = "AutoBarButtonShields" },
			{button_name = "AutoBarButtonCharge" },
			{button_name = "AutoBarButtonInterrupt" },
			{button_name = "AutoBarButtonER" },
			{button_name = "AutoBarButtonStance" },
			{button_name = "AutoBarButtonClassBuff" },
			{button_name = "AutoBarButtonDebuff", project_id = WOW_PROJECT_MAINLINE},
		}
	}

	local my_class_buttons = class_button_map[AutoBar.CLASS] or {}

	for idx, button_def in ipairs(my_class_buttons) do
		if(button_def.project_id == nil) or (button_def.project_id == WOW_PROJECT_ID) then
			local button_name = button_def.button_name
			if (not AutoBar.db.class.buttonList[button_name]) then
				AutoBar.db.class.buttonList[button_name] = {
					buttonKey = button_name,
					buttonClass = button_name,
					barKey = AutoBar.classBar,
					defaultButtonIndex = idx,
					enabled = true,
				}
				if (button_def.additional_args) then
					Mixin(AutoBar.db.class.buttonList[button_name], button_def.additional_args)
				end
			end
		end
	end

--#endregion

--#region CommonButtons
	if (not AutoBar.db.account.buttonList["AutoBarButtonHearth"]) then
		AutoBar.db.account.buttonList["AutoBarButtonHearth"] = {
			buttonKey = "AutoBarButtonHearth",
			buttonClass = "AutoBarButtonHearth",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 1,
			enabled = true,
			hearth_include_ancient_dalaran = false,
			only_favourite_hearth = false,
			hearth_include_challenge_portals = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonBandages"]) then
		AutoBar.db.account.buttonList["AutoBarButtonBandages"] = {
			buttonKey = "AutoBarButtonBandages",
			buttonClass = "AutoBarButtonBandages",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 3,
			enabled = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonHeal"]) then
		AutoBar.db.account.buttonList["AutoBarButtonHeal"] = {
			buttonKey = "AutoBarButtonHeal",
			buttonClass = "AutoBarButtonHeal",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 4,
			enabled = true,
			shuffle = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonRecovery"]) then
		AutoBar.db.account.buttonList["AutoBarButtonRecovery"] = {
			buttonKey = "AutoBarButtonRecovery",
			buttonClass = "AutoBarButtonRecovery",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 6,
			enabled = true,
			shuffle = true,
		}
	end

	if (not AutoBar.db.account.buttonList["AutoBarButtonCooldownPotionRejuvenation"]) then
		AutoBar.db.account.buttonList["AutoBarButtonCooldownPotionRejuvenation"] = {
			buttonKey = "AutoBarButtonCooldownPotionRejuvenation",
			buttonClass = "AutoBarButtonCooldownPotionRejuvenation",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 8,
			enabled = true,
			shuffle = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonCooldownPotionCombat"]) then
		AutoBar.db.account.buttonList["AutoBarButtonCooldownPotionCombat"] = {
			buttonKey = "AutoBarButtonCooldownPotionCombat",
			buttonClass = "AutoBarButtonCooldownPotionCombat",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 9,
			enabled = true,
			shuffle = true,
		}
	end


	if (not AutoBar.db.account.buttonList["AutoBarButtonDrums"]) then
		AutoBar.db.account.buttonList["AutoBarButtonDrums"] = {
			buttonKey = "AutoBarButtonDrums",
			buttonClass = "AutoBarButtonDrums",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 14,
			enabled = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonFood"]) then
		AutoBar.db.account.buttonList["AutoBarButtonFood"] = {
			buttonKey = "AutoBarButtonFood",
			buttonClass = "AutoBarButtonFood",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 15,
			enabled = true,
			disableConjure = false,
			include_combo_basic = true
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonFoodBuff"]) then
		AutoBar.db.account.buttonList["AutoBarButtonFoodBuff"] = {
			buttonKey = "AutoBarButtonFoodBuff",
			buttonClass = "AutoBarButtonFoodBuff",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 16,
			enabled = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonFoodCombo"]) then
		AutoBar.db.account.buttonList["AutoBarButtonFoodCombo"] = {
			buttonKey = "AutoBarButtonFoodCombo",
			buttonClass = "AutoBarButtonFoodCombo",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 17,
			enabled = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonBuff"]) then
		AutoBar.db.account.buttonList["AutoBarButtonBuff"] = {
			buttonKey = "AutoBarButtonBuff",
			buttonClass = "AutoBarButtonBuff",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 18,
			enabled = true,
			arrangeOnUse = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonBuffWeapon1"]) then
		AutoBar.db.account.buttonList["AutoBarButtonBuffWeapon1"] = {
			buttonKey = "AutoBarButtonBuffWeapon1",
			buttonClass = "AutoBarButtonBuffWeapon",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 19,
			enabled = true,
			arrangeOnUse = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonElixirBattle"]) then
		AutoBar.db.account.buttonList["AutoBarButtonElixirBattle"] = {
			buttonKey = "AutoBarButtonElixirBattle",
			buttonClass = "AutoBarButtonElixirBattle",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 20,
			enabled = true,
			arrangeOnUse = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonElixirGuardian"]) then
		AutoBar.db.account.buttonList["AutoBarButtonElixirGuardian"] = {
			buttonKey = "AutoBarButtonElixirGuardian",
			buttonClass = "AutoBarButtonElixirGuardian",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 21,
			enabled = true,
			arrangeOnUse = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonElixirBoth"]) then
		AutoBar.db.account.buttonList["AutoBarButtonElixirBoth"] = {
			buttonKey = "AutoBarButtonElixirBoth",
			buttonClass = "AutoBarButtonElixirBoth",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 22,
			enabled = true,
			arrangeOnUse = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonCrafting"]) then
		AutoBar.db.account.buttonList["AutoBarButtonCrafting"] = {
			buttonKey = "AutoBarButtonCrafting",
			buttonClass = "AutoBarButtonCrafting",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 24,
			enabled = true,
			arrangeOnUse = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonQuest"]) then
		AutoBar.db.account.buttonList["AutoBarButtonQuest"] = {
			buttonKey = "AutoBarButtonQuest",
			buttonClass = "AutoBarButtonQuest",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 25,
			enabled = true,
			arrangeOnUse = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonTrinket1"]) then
		AutoBar.db.account.buttonList["AutoBarButtonTrinket1"] = {
			buttonKey = "AutoBarButtonTrinket1",
			buttonClass = "AutoBarButtonTrinket1",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 26,
			enabled = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonTrinket2"]) then
		AutoBar.db.account.buttonList["AutoBarButtonTrinket2"] = {
			buttonKey = "AutoBarButtonTrinket2",
			buttonClass = "AutoBarButtonTrinket2",
			barKey = "AutoBarClassBarBasic",
			defaultButtonIndex = 27,
			enabled = true,
		}
	end

	if (not AutoBar.db.account.buttonList["AutoBarButtonSpeed"]) then
		AutoBar.db.account.buttonList["AutoBarButtonSpeed"] = {
			buttonKey = "AutoBarButtonSpeed",
			buttonClass = "AutoBarButtonSpeed",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = 1,
			enabled = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonFreeAction"]) then
		AutoBar.db.account.buttonList["AutoBarButtonFreeAction"] = {
			buttonKey = "AutoBarButtonFreeAction",
			buttonClass = "AutoBarButtonFreeAction",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = 2,
			enabled = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonExplosive"]) then
		AutoBar.db.account.buttonList["AutoBarButtonExplosive"] = {
			buttonKey = "AutoBarButtonExplosive",
			buttonClass = "AutoBarButtonExplosive",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = 3,
			enabled = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonFishing"]) then
		AutoBar.db.account.buttonList["AutoBarButtonFishing"] = {
			buttonKey = "AutoBarButtonFishing",
			buttonClass = "AutoBarButtonFishing",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = 4,
			enabled = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonBattleStandards"]) then
		AutoBar.db.account.buttonList["AutoBarButtonBattleStandards"] = {
			buttonKey = "AutoBarButtonBattleStandards",
			buttonClass = "AutoBarButtonBattleStandards",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = 6,
			enabled = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonOpenable"]) then
		AutoBar.db.account.buttonList["AutoBarButtonOpenable"] = {
			buttonKey = "AutoBarButtonOpenable",
			buttonClass = "AutoBarButtonOpenable",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = 7,
			enabled = true,
			drag = true,
		}
	end
	if (not AutoBar.db.account.buttonList["AutoBarButtonMiscFun"]) then
		AutoBar.db.account.buttonList["AutoBarButtonMiscFun"] = {
			buttonKey = "AutoBarButtonMiscFun",
			buttonClass = "AutoBarButtonMiscFun",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = 8,
			enabled = true,
			arrangeOnUse = true,
		}
	end
--#endregion

--#region XpacButtons
	-- A list of all buttons on the account bars that a player should have by expansion pack

	if (LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_WRATH_OF_THE_LICH_KING) then

		if (not AutoBar.db.account.buttonList["AutoBarButtonMillHerbs"]) then
			AutoBar.db.account.buttonList["AutoBarButtonMillHerbs"] = {
				buttonKey = "AutoBarButtonMillHerbs",
				buttonClass = "AutoBarButtonMillHerbs",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = 11,
				enabled = true,
				arrangeOnUse = true,
				targeted = "Milling",
			}
		end

	end --LE_EXPANSION_WRATH_OF_THE_LICH_KING



	if (ABGData.is_mainline_wow) then	--ToDo: These should be changed to use LE_EXPANSION_* for forward compatibility

		if (not AutoBar.db.account.buttonList["AutoBarButtonArchaeology"]) then
			AutoBar.db.account.buttonList["AutoBarButtonArchaeology"] = {
				buttonKey = "AutoBarButtonArchaeology",
				buttonClass = "AutoBarButtonArchaeology",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = "*",
				enabled = true,
			}
		end

		if (not AutoBar.db.account.buttonList["AutoBarButtonPets"]) then
			AutoBar.db.account.buttonList["AutoBarButtonPets"] = {
				buttonKey = "AutoBarButtonPets",
				buttonClass = "AutoBarButtonPets",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = 5,
				enabled = true,
				arrangeOnUse = true,
			}
		end

		if (not AutoBar.db.account.buttonList["AutoBarButtonGuildSpell"]) then
			AutoBar.db.account.buttonList["AutoBarButtonGuildSpell"] = {
				buttonKey = "AutoBarButtonGuildSpell",
				buttonClass = "AutoBarButtonGuildSpell",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = 9,
				enabled = true,
				arrangeOnUse = true,
			}
		end

		if (not AutoBar.db.account.buttonList["AutoBarButtonSunsongRanch"]) then
			AutoBar.db.account.buttonList["AutoBarButtonSunsongRanch"] = {
				buttonKey = "AutoBarButtonSunsongRanch",
				buttonClass = "AutoBarButtonSunsongRanch",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = 10,
				enabled = true,
				arrangeOnUse = true,
			}
		end

		if (not AutoBar.db.account.buttonList["AutoBarButtonGarrison"]) then
			AutoBar.db.account.buttonList["AutoBarButtonGarrison"] = {
				buttonKey = "AutoBarButtonGarrison",
				buttonClass = "AutoBarButtonGarrison",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = 12,
				enabled = true,
				arrangeOnUse = true,
			}
		end

		if (not AutoBar.db.account.buttonList["AutoBarButtonOrderHallTroop"]) then
			AutoBar.db.account.buttonList["AutoBarButtonOrderHallTroop"] = {
				buttonKey = "AutoBarButtonOrderHallTroop",
				buttonClass = "AutoBarButtonOrderHallTroop",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = "*",
				enabled = true,
				arrangeOnUse = true,
			}
		end

		if (not AutoBar.db.account.buttonList["AutoBarButtonOrderHallResource"]) then
			AutoBar.db.account.buttonList["AutoBarButtonOrderHallResource"] = {
				buttonKey = "AutoBarButtonOrderHallResource",
				buttonClass = "AutoBarButtonOrderHallResource",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = "*",
				enabled = true,
				arrangeOnUse = true,
			}
		end

		if (not AutoBar.db.account.buttonList["AutoBarButtonBattlePetItems"]) then
			AutoBar.db.account.buttonList["AutoBarButtonBattlePetItems"] = {
				buttonKey = "AutoBarButtonBattlePetItems",
				buttonClass = "AutoBarButtonBattlePetItems",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = "*",
				enabled = true,
				arrangeOnUse = true,
			}
		end

		if (not AutoBar.db.account.buttonList["AutoBarButtonToyBox"]) then
			AutoBar.db.account.buttonList["AutoBarButtonToyBox"] = {
				buttonKey = "AutoBarButtonToyBox",
				buttonClass = "AutoBarButtonToyBox",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = "*",
				enabled = false,
				arrangeOnUse = true,
				toybox_only_show_favourites = false,
			}
		end
	end
--#endregion XpacButtons

	if (not AutoBar.db.account.buttonList["AutoBarButtonRaidTarget"]) then
		AutoBar.db.account.buttonList["AutoBarButtonRaidTarget"] = {
			buttonKey = "AutoBarButtonRaidTarget",
			buttonClass = "AutoBarButtonRaidTarget",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = "*",
			enabled = true,
			arrangeOnUse = true,
		}
	end

	if (not AutoBar.db.account.buttonList["AutoBarButtonMount"]) then
		AutoBar.db.account.buttonList["AutoBarButtonMount"] = {
			buttonKey = "AutoBarButtonMount",
			buttonClass = "AutoBarButtonMount",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = "*",
			enabled = true,
			arrangeOnUse = true,
			mount_show_qiraji = false,
			mount_show_favourites = true,
			mount_show_nonfavourites = false,
			mount_show_class = true,
			mount_reverse_sort = false,
			mount_show_rng_fave = false,
		}
	end

	if (not AutoBar.db.account.buttonList["AutoBarButtonReputation"]) then
		AutoBar.db.account.buttonList["AutoBarButtonReputation"] = {
			buttonKey = "AutoBarButtonReputation",
			buttonClass = "AutoBarButtonReputation",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = "*",
			enabled = true,
			arrangeOnUse = true,
		}
	end

	if (AutoBar.CLASS ~= "ROGUE" and AutoBar.CLASS ~= "WARRIOR") then
		if (not AutoBar.db.account.buttonList["AutoBarButtonWater"]) then
			AutoBar.db.account.buttonList["AutoBarButtonWater"] = {
				buttonKey = "AutoBarButtonWater",
				buttonClass = "AutoBarButtonWater",
				barKey = "AutoBarClassBarBasic",
				defaultButtonIndex = "AutoBarButtonFood",
				enabled = true,
				disableConjure = false,
				}
		end

		if (not AutoBar.db.account.buttonList["AutoBarButtonWaterBuff"]) then
			AutoBar.db.account.buttonList["AutoBarButtonWaterBuff"] = {
				buttonKey = "AutoBarButtonWaterBuff",
				buttonClass = "AutoBarButtonWaterBuff",
				barKey = "AutoBarClassBarBasic",
				defaultButtonIndex = "AutoBarButtonWater",
				enabled = true,
				arrangeOnUse = true,
			}
		end
	end

	if (not AutoBar.db.class.buttonList["AutoBarButtonShields"]) then
		AutoBar.db.class.buttonList["AutoBarButtonShields"] = {
			buttonKey = "AutoBarButtonShields",
			buttonClass = "AutoBarButtonShields",
			barKey = AutoBar.classBar,
			defaultButtonIndex = "*",
			enabled = true,
			arrangeOnUse = true,
		}
	end

	if (AutoBar.CLASS ~= "MONK") then
		if (not AutoBar.db.class.buttonList["AutoBarButtonER"]) then
			AutoBar.db.class.buttonList["AutoBarButtonER"] = {
				buttonKey = "AutoBarButtonER",
				buttonClass = "AutoBarButtonER",
				barKey = AutoBar.classBar,
				defaultButtonIndex = "*",
				enabled = true,
				noPopup = true,
			}
		end
	end

	if (not AutoBar.db.class.buttonList["AutoBarButtonInterrupt"]) then
		AutoBar.db.class.buttonList["AutoBarButtonInterrupt"] = {
			buttonKey = "AutoBarButtonInterrupt",
			buttonClass = "AutoBarButtonInterrupt",
			barKey = AutoBar.classBar,
			defaultButtonIndex = "*",
			enabled = true,
			arrangeOnUse = true,
		}
	end


--#endregion XpacButtons

	--classic-only: "AutoBarButtonTrack",
	local deprecated_buttons

	if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
		deprecated_buttons =
		{
			"AutoBarButtonWarlockStones", "AutoBarButtonSting", "AutoBarButtonAura",
			"AutoBarButtonRotationDrums", "AutoBarButtonAmmo",
			"AutoBarButtonOrderHall", "AutoBarButtonPowerShift",
			"AutoBarButtonCooldownStoneCombat", "AutoBarButtonBoomkinTree",
			"AutoBarButtonGuildSpell", "AutoBarButtonStagForm", "AutoBarButtonCooldownStoneHealth",
			"AutoBarButtonCooldownPotionHealth", "AutoBarButtonMillHerbs", "AutoBarButtonCooldownStoneMana",
			"AutoBarButtonMana", "AutoBarButtonCooldownPotionMana",
			"AutoBarButtonCooldownDrums",
		}
	elseif (ABGData.is_mainline_wow) then

		deprecated_buttons =
		{
			"AutoBarButtonWarlockStones", "AutoBarButtonSting", "AutoBarButtonAura",
			"AutoBarButtonRotationDrums", "AutoBarButtonAmmo",
			"AutoBarButtonSeal", "AutoBarButtonOrderHall", "AutoBarButtonPowerShift",
			"AutoBarButtonCooldownStoneCombat", "AutoBarButtonBoomkinTree",
			"AutoBarButtonTrack", "AutoBarButtonCooldownPotionHealth", "AutoBarButtonCooldownStoneHealth",
			"AutoBarButtonCooldownStoneMana", "AutoBarButtonAquatic",
			"AutoBarButtonMana", "AutoBarButtonCooldownPotionMana",
			"AutoBarButtonCooldownDrums",
		}
	else
		deprecated_buttons = {
			"AutoBarButtonCooldownDrums",
		}
	end

	for _, dep in ipairs(deprecated_buttons) do
		if (AutoBar.db.account.buttonList[dep]) then
			AutoBar.db.account.buttonList[dep] = nil
		end
		if (AutoBar.db.class.buttonList[dep]) then
			AutoBar.db.class.buttonList[dep] = nil
		end
		if (AutoBar.db.char.buttonList[dep]) then
			AutoBar.db.char.buttonList[dep] = nil
		end

	end

	if(AutoBar.CLASS == "WARLOCK" and AutoBar.db.class.buttonList["AutoBarButtonInterrupt"]) then
		AutoBar.db.class.buttonList["AutoBarButtonInterrupt"] = nil
	end

	if (ABGData.is_mainline_wow) then

		if(AutoBar.CLASS == "ROGUE" and AutoBar.db.class.buttonList["AutoBarButtonTrap"]) then
			AutoBar.db.class.buttonList["AutoBarButtonTrap"] = nil
		end
		if(AutoBar.CLASS == "DRUID" ) then
			AutoBar.db.class.buttonList["AutoBarButtonClassPet"] = nil
			AutoBar.db.class.buttonList["AutoBarButtonStance"] = nil
		end
	end


-- save as sample to remove buttons per class
--	if(AutoBar.CLASS == "xx" and AutoBar.db.class.buttonList["AutoBarButtonInterrupt"]) then
--		AutoBar.db.class.buttonList["AutoBarButtonInterrupt"] = nil
--	end

end


-- Populate AutoBar.buttonDBList with the correct DB from char, class or account
function AutoBar:RefreshButtonDBList()
	local buttonDBList = AutoBar.buttonDBList
	for buttonKey, _buttonDB in pairs(buttonDBList) do
		buttonDBList[buttonKey] = nil
	end
	for buttonKey, _buttonDB in pairs(AutoBar.db.char.buttonList) do
		buttonDBList[buttonKey] = AutoBar:GetButtonDB(buttonKey)
	end
	for buttonKey, _buttonDB in pairs(AutoBar.db.class.buttonList) do
		buttonDBList[buttonKey] = AutoBar:GetButtonDB(buttonKey)
	end
	for buttonKey, _buttonDB in pairs(AutoBar.db.account.buttonList) do
		buttonDBList[buttonKey] = AutoBar:GetButtonDB(buttonKey)
	end
end
--AutoBar:Print("AutoBar:RefreshButtonDBList<-- " .. tostring(buttonKey) .. " buttonDBList[buttonKey] " .. tostring(buttonDBList[buttonKey]))

-- Populate AutoBar.unplacedButtonList with buttons that are not on a bar
function AutoBar:RefreshUnplacedButtonList()
	local unplacedButtonList = AutoBar.unplacedButtonList
	wipe(unplacedButtonList)

	-- Duplicate all buttons
	local buttonDBList = AutoBar.buttonDBList
	for buttonKey, _button_db in pairs(buttonDBList) do
		unplacedButtonList[buttonKey] = L[buttonKey]
	end

--[[
	-- Remove placed ones
	local barButtonsDBList = AutoBar.barButtonsDBList
	for barKey, barDB in pairs(barButtonsDBList) do
		local buttonKeys = barDB.buttonKeys
		for buttonKeyIndex, buttonKey in pairs(buttonKeys) do
			unplacedButtonList[buttonKey] = nil
		end
	end
--]]
end

-- Populate AutoBar.barLayoutDBList, barButtonsDBList, barPositionDBList with the correct DB from char, class or account
function AutoBar:RefreshBarDBLists()
	local barButtonsDBList = AutoBar.barButtonsDBList
	local barLayoutDBList = AutoBar.barLayoutDBList
	local barPositionDBList = AutoBar.barPositionDBList
	wipe(barButtonsDBList)
	wipe(barLayoutDBList)
	wipe(barPositionDBList)
	for barKey, _bar_db in pairs(AutoBar.db.char.barList) do
		barButtonsDBList[barKey] = AutoBar:GetSharedBarDB(barKey, "sharedButtons")
		barLayoutDBList[barKey] = AutoBar:GetSharedBarDB(barKey, "sharedLayout")
		barPositionDBList[barKey] = AutoBar:GetSharedBarDB(barKey, "sharedLocation")
	end
	for barKey, _bar_db in pairs(AutoBar.db.class.barList) do
		barButtonsDBList[barKey] = AutoBar:GetSharedBarDB(barKey, "sharedButtons")
		barLayoutDBList[barKey] = AutoBar:GetSharedBarDB(barKey, "sharedLayout")
		barPositionDBList[barKey] = AutoBar:GetSharedBarDB(barKey, "sharedLocation")
	end
	for barKey, _bar_db in pairs(AutoBar.db.account.barList) do
		barButtonsDBList[barKey] = AutoBar:GetSharedBarDB(barKey, "sharedButtons")
		barLayoutDBList[barKey] = AutoBar:GetSharedBarDB(barKey, "sharedLayout")
		barPositionDBList[barKey] = AutoBar:GetSharedBarDB(barKey, "sharedLocation")
	end

	for _bar_key, bar in pairs(AutoBar.barList) do
		bar:UpdateShared()
	end

	local barValidateList = AutoBar.barValidateList
	wipe(barValidateList)
	barValidateList[""] = L["None"]
	for barKey, _bar_db in pairs(barLayoutDBList) do
		if (not L[barKey]) then
			L[barKey] = barLayoutDBList[barKey].name
		end
		barValidateList[barKey] = L[barKey]
	end
end

function AutoBar:ButtonExists(barDB, targetButtonDB)
	for _button_key_index, buttonKey in ipairs(barDB.buttonKeys) do
		if (buttonKey == targetButtonDB.buttonKey) then
			return true
		end
	end
	return false
end

local foundButtons = {}
-- Changing sharing may expose duplicate buttons. Also dragging from lower shared levels to higher shared levels may result in duplicates cross character.
-- Use the Button's barKey to resolve issues.
function AutoBar:RemoveDuplicateButtons()
	local barButtonsDBList = AutoBar.barButtonsDBList
	local buttonDBList = AutoBar.buttonDBList

	for buttonKey in pairs(foundButtons) do
		foundButtons[buttonKey] = nil
	end

	for barKey, barDB in pairs(barButtonsDBList) do
		local delete
		local buttonKeys = barDB.buttonKeys
		local nKeys = 0

		-- Remove Bar Duplicates
		for buttonKeyIndex, buttonKey in pairs(buttonKeys) do
			local foundBarKey = foundButtons[buttonKey]
			if (foundBarKey and foundBarKey == barKey) then
				buttonKeys[buttonKeyIndex] = false
				delete = true
			else
				foundButtons[buttonKey] = barKey
			end
			if (buttonKeyIndex > nKeys) then
				nKeys = buttonKeyIndex
			end
		end
		if (delete) then
			local buttonKeyList = buttonKeys
			for index = nKeys, 1, -1 do
				if (buttonKeyList[index] == false) then
					local numKeys = # buttonKeyList
					buttonKeyList[index] = nil
					for buttonIndex = index, numKeys - 1, 1 do
						buttonKeyList[buttonIndex] = buttonKeyList[buttonIndex + 1]
					end
				end
			end
		end

		-- Adjust Bar Location
		delete = false
		for buttonKeyIndex, buttonKey in ipairs(buttonKeys) do
			local buttonDB = buttonDBList[buttonKey]
			if (buttonDB) then
				if (not buttonDB.barKey) then
					-- Not officially placed, so place
					buttonDB.barKey = barKey
				end
				if (buttonDB.barKey ~= barKey) then
					local currentBarDB = barButtonsDBList[buttonDB.barKey]
					if (not currentBarDB) then
						-- Placed on a currently unaccesible Bar.  Adjust official location.
						-- ToDo: This implies placement on class or character only bar.  Should change sharing when doing that for the Button.
						buttonDB.barKey = barKey
					elseif (AutoBar:ButtonExists(currentBarDB, buttonDB)) then
						-- Exists in official location.  Remove duplicate.
						buttonKeys[buttonKeyIndex] = false
						delete = true
					else
						-- Not in official location.  Adjust official location.
						buttonDB.barKey = barKey
					end
				end
			end
		end
		if (delete) then
			local buttonKeyList = buttonKeys
			for index = nKeys, 1, -1 do
				if (buttonKeyList[index] == false) then
					local numKeys = # buttonKeyList
					buttonKeyList[index] = nil
					for buttonIndex = index, numKeys - 1, 1 do
						buttonKeyList[buttonIndex] = buttonKeyList[buttonIndex + 1]
					end
				end
			end
		end
	end
end

function AutoBar:ButtonInsertNew(barDB, buttonDB)
	for buttonDBIndex, buttonKey in ipairs(barDB.buttonKeys) do
		if (buttonKey == buttonDB.defaultButtonIndex) then
--AutoBar:Print("AutoBar:ButtonInsertNew buttonDBIndex + 1 " .. tostring(buttonDBIndex + 1) .. " " .. tostring(buttonDB.buttonKey) .. " # barDB.buttonKeys " .. tostring(# barDB.buttonKeys))
			table.insert(barDB.buttonKeys, buttonDBIndex + 1, buttonDB.buttonKey)
--AutoBar:Print("AutoBar:ButtonInsertNew # barDB.Buttons " .. tostring(# barDB.buttons))
			return nil
		end
	end
	return buttonDB
end

-- /script AutoBar:BarsCompact()
function AutoBar:BarsCompact()
	for _bar_key, barDB in pairs(AutoBar.barButtonsDBList) do
--AutoBar:Print("AutoBar:BarsCompact barKey " .. tostring(barKey) .. " AutoBar.barLayoutDBList[barKey].buttonKeys " .. tostring(AutoBar.barLayoutDBList[barKey].buttonKeys))
		local buttonKeys = barDB.buttonKeys
		local badIndexMax = nil
		local nKeys = 0
		for buttonKeyIndex, _button_key in pairs(buttonKeys) do
			if (buttonKeyIndex > 1 and buttonKeys[buttonKeyIndex - 1] == nil) then
				badIndexMax = buttonKeyIndex
			end
			if (buttonKeyIndex > nKeys) then
				nKeys = buttonKeyIndex
			end
		end
		if (badIndexMax) then
--print("AutoBar:BarsCompact badIndexMax " .. tostring(badIndexMax))
			local source = 0
			local sink = 1
			local sinkButtonKey, sourceButtonKey
			while true do
				sinkButtonKey = buttonKeys[sink]
				if (sinkButtonKey) then
					sink = sink + 1
				else
					if (source < sink) then
						source = sink + 1
					end
					while source <= nKeys do
						sourceButtonKey = buttonKeys[source]
						if (sourceButtonKey) then
							-- Move it
							buttonKeys[sink] = sourceButtonKey
							buttonKeys[source] = nil
							sink = sink + 1
							source = source + 1
							break
						else
							source = source + 1
						end
					end
				end
				if (source > nKeys or sink > nKeys) then
					break
				end
			end
		end
	end
end

function AutoBar:ButtonPopulateNew(buttonDB)
	local newButtonDB = {}
	-- ToDo: Upgrade if there is ever a table inside
	for key, value in pairs(buttonDB) do
		newButtonDB[key] = value
	end
	newButtonDB.barKey = nil
	newButtonDB.defaultButtonIndex = nil
--AutoBar:Print("AutoBar:ButtonPopulateNew " .. tostring(newButtonDB.buttonKey))
	return newButtonDB
end


local insertList = {}
local appendList = {}

-- if ignorePlace then ignore previous placement
function AutoBar:PopulateBars()
	local barButtonsDBList = AutoBar.barButtonsDBList
	local barDB, buttonIndex
	for index in pairs(insertList) do
		insertList[index] = nil
	end
	for index in pairs(appendList) do
		appendList[index] = nil
	end
	for _button_key, buttonDB in pairs(AutoBar.buttonDBList) do
		if (buttonDB.barKey) then
			barDB = barButtonsDBList[buttonDB.barKey]
		else
			barDB = nil
		end
		if (barDB and not AutoBar:ButtonExists(barDB, buttonDB)) then
			buttonIndex = nil
			if (type(buttonDB.defaultButtonIndex) == "number") then
				buttonIndex = tonumber(buttonDB.defaultButtonIndex)
			elseif (type(buttonDB.defaultButtonIndex) == "string") then
				-- "*" append, "~" do not place, "buttonKey" insert after the button
				if (buttonDB.defaultButtonIndex == "*") then
--AutoBar:Print("AutoBar:PopulateBars # appendList + 1 " .. tostring(# appendList + 1) .. " " .. tostring(buttonDB.buttonKey) .. " buttonKey " .. tostring(buttonKey))
					appendList[# appendList + 1] = buttonDB
				elseif (buttonDB.defaultButtonIndex == "~") then
				else
					insertList[# insertList + 1] = buttonDB
				end
			end
			if (buttonIndex) then
				if (barDB.buttonKeys[buttonIndex]) then
					appendList[# appendList + 1] = buttonDB
				else
					barDB.buttonKeys[buttonIndex] = buttonDB.buttonKey
				end
			end
		end
	end
	AutoBar:BarsCompact()
	for _index, buttonDB in ipairs(insertList) do
		barDB = barButtonsDBList[buttonDB.barKey]
		local couldNotInsertDB = AutoBar:ButtonInsertNew(barDB, buttonDB)
		if (couldNotInsertDB) then
			appendList[# appendList + 1] = couldNotInsertDB
		end
	end

	for _index, buttonDB in ipairs(appendList) do
		barDB = barButtonsDBList[buttonDB.barKey]
		local nButtons = # barDB.buttonKeys + 1
		barDB.buttonKeys[nButtons] = buttonDB.buttonKey
	end
end

-- Upgrade from old DB versions
local dbVersion = 2
local renameButtonList
local renameBarList

function AutoBar:UpgradeBar(barDB)
	if (barDB.isCustomBar) then
		local oldKey = barDB.barKey
		local newName = ABGCode.GetValidatedName(barDB.name)
		if (newName ~= barDB.name) then
			renameBarList[oldKey] = newName
		end
	end
end

function AutoBar:UpgradeButton(buttonDB)
	if (buttonDB.buttonClass == "AutoBarButtonCustom") then
		local oldKey = buttonDB.buttonKey
		local newName = ABGCode.GetValidatedName(buttonDB.name)
		if (newName ~= buttonDB.name) then
			renameButtonList[oldKey] = newName
		end
	end
end

-- Options are at three levels: Account, Class, Character
function AutoBar:UpgradeLevel(levelDB)
	if (levelDB.barList) then
		for _bar_key, barDB in pairs(levelDB.barList) do
			AutoBar:UpgradeBar(barDB)
		end
	end
	if (levelDB.buttonList) then
		for _button_key, buttonDB in pairs(levelDB.buttonList) do
			AutoBar:UpgradeButton(buttonDB)
		end
	end
end

function AutoBar:UpgradeVersion()
	if (not AutoBar.db.account.dbVersion) then
		AutoBar.db.account.customBarList = nil
		AutoBar.db.account.bars = nil
		if (AutoBarDB.classes) then
			for classKey, classDB in pairs (AutoBarDB.classes) do
				if (classDB.bars) then
					classDB.bars = nil
					if (not classDB.barList and not classDB.buttonList) then
						AutoBarDB.classes[classKey] = nil
					end
				end
			end
		end
		if (AutoBarDB.chars) then
			for charKey, charDB in pairs (AutoBarDB.chars) do
				if (charDB.bars) then
					charDB.bars = nil
					if (not charDB.barList and not charDB.buttonList) then
						AutoBarDB.chars[charKey] = nil
					end
				end
			end
		end
		AutoBarDB.currentProfile = nil
		AutoBarDB.profiles = nil
		AutoBar.db.account.dbVersion = 1
	end
	if (AutoBar.db.account.dbVersion < dbVersion) then
		if (not renameButtonList) then
			renameButtonList = {}
		end
		wipe(renameButtonList)
		if (not renameBarList) then
			renameBarList = {}
		end
		wipe(renameBarList)

		AutoBar:UpgradeLevel(AutoBarDB.account)
		if (AutoBarDB.classes) then
			for _, classDB in pairs (AutoBarDB.classes) do
				AutoBar:UpgradeLevel(classDB)
			end
		end
		if (AutoBarDB.chars) then
			for _, charDB in pairs (AutoBarDB.chars) do
				AutoBar:UpgradeLevel(charDB)
			end
		end

		for oldKey, newName in pairs(renameButtonList) do
			AutoBar.Class.Button:Rename(oldKey, newName)
		end
		for oldKey, newName in pairs(renameBarList) do
			AutoBar.Class.Bar:Rename(oldKey, newName)
		end
--		AutoBar.db.account.dbVersion = 2
	end
end


