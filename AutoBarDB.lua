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
--  AutoBarDB2.account.barList[buttonKey]		-- common
--  AutoBar.class.barList[buttonKey]		-- class
--  AutoBar.char.barList[buttonKey]		-- char
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

local _, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

local AutoBar = AutoBar
local ABGCode = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject
local L = ABGData.locale

local CLASS_COLUMN_DEFAULT = 10

local CURRENT_DB_VERSION = 1


local CLASS_BAR_MAP = {
	DEATHKNIGHT = "AutoBarClassBarDeathKnight",
	DEMONHUNTER = "AutoBarClassBarDemonHunter",
	DRUID = "AutoBarClassBarDruid",
	EVOKER = "AutoBarClassBarEvoker",
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

local BASIC_BUTTON_DATA = {
	{button_name = "AutoBarButtonHearth", barKey = "AutoBarClassBarBasic", additional_args = {
		hearth_include_ancient_dalaran = false,
		only_favourite_hearth = true,
		hearth_include_challenge_portals = true,
	} },
	{button_name = "AutoBarButtonBandages", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonHeal", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonRecovery", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonCooldownPotionRejuvenation", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonCooldownPotionCombat", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonDrums", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonFood", barKey = "AutoBarClassBarBasic", additional_args = {
		disableConjure = false,
		include_combo_basic = true,
	} },
	{button_name = "AutoBarButtonFoodBuff", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonFoodCombo", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonWater", barKey = "AutoBarClassBarBasic", additional_args = {disableConjure = false} },
	{button_name = "AutoBarButtonWaterBuff", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonBuff", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonBuffWeapon1", buttonClass = "AutoBarButtonBuffWeapon", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonElixirBattle", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonElixirGuardian", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonElixirBoth", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonCrafting", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonQuest", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonTrinket1", barKey = "AutoBarClassBarBasic"},
	{button_name = "AutoBarButtonTrinket2", barKey = "AutoBarClassBarBasic"},

}



-- A list of all buttons on the class bar that a class should have
local CLASS_BUTTON_MAP = {
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
	EVOKER =
	{

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
	},
}


local changed_category_key_dict = {
	["Consumable.Buff Type.Both"] = "Consumable.Buff Type.Flask",
	["Muffin.Reputation"] = "Muffin.Misc.Reputation",
	["Muffin.Mount"] = "Muffin.Mounts",
	["Tradeskill.Gather.Herbalism"] = "Muffin.Herbs.Millable",
}
local function verify_db()
	-- Temporary, implement buttonKey field
	for buttonKey, buttonDB in pairs(AutoBar.char.buttonList) do
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
	for buttonKey, buttonDB in pairs(AutoBar.class.buttonList) do
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
	for buttonKey, buttonDB in pairs(AutoBarDB2.account.buttonList) do
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


local function migrate_db_from_ace2()

	if (not (AutoBarDB and AutoBarDB.account)) then
		return
	end

	AutoBarDB2.account = AutoBarDB2.account or {}
	AutoBarDB2.account.barList = AutoBarDB2.account.barList or {}

	AutoBarDB2.custom_categories = AutoBarDB2.custom_categories or AutoBarDB.account.customCategories
	AutoBarDB.account.customCategories = nil

	AutoBarDB2.settings = AutoBarDB2.settings or {}
	AutoBarDB2.ldb_icon = AutoBarDB2.ldb_icon or AutoBarDB.account.ldbIcon

	AutoBarDB.account.ldbIcon = nil
	AutoBarDB.account.stupidlog = nil
	AutoBarDB.account.keySeed = nil
	AutoBarDB.account.dbVersion = nil

	AutoBarDB2.classes = AutoBarDB2.classes or AutoBarDB.classes
	AutoBarDB2.chars = AutoBarDB2.chars or AutoBarDB.chars

	local setting_migration = {
		{"custom_categories", "customCategories"},
		{"show_empty_buttons", "showEmptyButtons"},
		{"show_tooltip", "showTooltip"},
		{"show_tooltip_in_combat", "showTooltipCombat"},
		{"handle_spell_changed", "handle_spell_changed"},
		{"log_events", "logEvents"},
		{"log_memory", "logMemory"},
		{"show_count", "showCount"},
		{"show_hotkey", "showHotkey"},
		{"self_cast_right_click", "selfCastRightClick"},
		{"hack_PetActionBarFrame", "hack_PetActionBarFrame"},
		{"fade_out", "fadeOut"},
		{"clamp_bars_to_screen", "clampedToScreen"},

	}

	for _i, data in ipairs(setting_migration) do
		local l, r = data[1], data[2]
		AutoBarDB2.settings[l] = AB.NVL(AutoBarDB2.settings[l], AutoBarDB.account[r])
		AutoBarDB.account[r] = nil
	end

	if (not AutoBarDB2.skin) then
		AutoBarDB2.skin = {
			["SkinID"] = AutoBarDB.account.SkinID,
			["Gloss"] = AutoBarDB.account.Gloss,
			["Backdrop"] = AutoBarDB.account.Backdrop,
			["Colors"] = AutoBarDB.account.Colors,
		}
		AutoBarDB.account.SkinID = nil
		AutoBarDB.account.Gloss = nil
		AutoBarDB.account.Backdrop = nil
		AutoBarDB.account.Colors = nil
	end

	-- Erase the per-class entries (MONK = true, MAGE = true, etc) and replace with the single "allowed_class"
	for _key, bar in pairs(AutoBarDB2.account.barList) do
		for class_name in pairs(CLASS_BAR_MAP) do
			bar[class_name] = nil
		end
		bar.allowed_class = bar.allowed_class or "*"

	end

	-- Move account-level bar and button lists from DB to DB2
	if (AutoBarDB.account.barList) then
		AutoBarDB2.account.barList = AutoBarDB.account.barList
		AutoBarDB.account.barList = nil
	end
	if(AutoBarDB.account.buttonList) then
		AutoBarDB2.account.buttonList = AutoBarDB.account.buttonList
		AutoBarDB.account.buttonList = nil
	end

	AutoBarDB.whatsnew_version = nil

	--Clean up various bits of failed migration
	AutoBarDB2.account.selfCastRightClick = nil
	AutoBarDB2.account.clampedToScreen = nil
	for class_name in pairs(CLASS_BAR_MAP) do
		AutoBarDB2.chars[class_name] = nil	-- Class data had been copied into the character table
	end

	for key in pairs(AutoBarDB2.classes) do
		if(CLASS_BAR_MAP[key] == nil) then
			print("Removing from classes:", key)
			AutoBarDB2.classes[key] = nil
		end

	end
end

local function upgrade_db_version()
	-- If we move to a version 2 database, then the upgrade logic would go here

	AutoBarDB2.db_version = CURRENT_DB_VERSION

end



function AutoBar.InitializeDB()
	AutoBar.classBar = CLASS_BAR_MAP[AutoBar.CLASS]

	AutoBarDB2 = AutoBarDB2 or {}


	migrate_db_from_ace2()

	upgrade_db_version()

	-- TODO: Move to AutoBar:InitializeDefaults() change to data
	AutoBarDB2.account = AutoBarDB2.account or {}

	AutoBarDB2.classes = AutoBarDB2.classes or {}
	AutoBarDB2.classes[AutoBar.CLASS] = AutoBarDB2.classes[AutoBar.CLASS] or {["barList"] = {}, ["buttonList"] = {}}
	AutoBar.class = AutoBarDB2.classes[AutoBar.CLASS]

	AutoBarDB2.chars = AutoBarDB2.chars or {}
	AutoBarDB2.chars[AutoBar.currentPlayer] = AutoBarDB2.chars[AutoBar.currentPlayer] or {["barList"] = {}, ["buttonList"] = {}, ["buttonDataList"] = {}}
	AutoBar.char = AutoBarDB2.chars[AutoBar.currentPlayer]


	AutoBarDB2.custom_categories = AutoBarDB2.custom_categories or {}

	AutoBarDB2.skin = AutoBarDB2.skin or {}

	AutoBarDB2.settings = AutoBarDB2.settings or {}
	local settings = AutoBarDB2.settings
	settings.show_empty_buttons = AB.NVL(settings.show_empty_buttons, false)
	settings.show_tooltip = AB.NVL(settings.show_tooltip, true)
	settings.show_tooltip_in_combat = AB.NVL(settings.show_tooltip_in_combat, true)
	settings.handle_spell_changed = AB.NVL(settings.handle_spell_changed, true)
	settings.show_count = AB.NVL(settings.show_count, true)
	settings.show_hotkey = AB.NVL(settings.show_hotkey, true)
	settings.hack_PetActionBarFrame = AB.NVL(settings.hack_PetActionBarFrame, false)
	settings.fade_out = AB.NVL(settings.fade_out, false)
	settings.clamp_bars_to_screen = AB.NVL(settings.clamp_bars_to_screen, true)
	settings.self_cast_right_click = AB.NVL(settings.self_cast_right_click, true)
	settings.log_throttled_events = AB.NVL(settings.log_throttled_events, false)
	settings.throttle_event_limit = settings.throttle_event_limit or 0
	settings.log_events = AB.NVL(settings.log_events, false)
	settings.log_memory = AB.NVL(settings.log_memory, false)
	settings.performance = AB.NVL(settings.performance, false)
	settings.performance_threshold = settings.performance_threshold or 100
	if (settings.performance_threshold < 20) then settings.performance_threshold = 100; end;

	AutoBarDB2.whatsnew_version = AutoBarDB2.whatsnew_version or ""

	AutoBarDB2.ldb_icon = AutoBarDB2.ldb_icon or {}

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


---@param p_template_db table
---@param p_button_list table
---@param p_bar_key string
local function create_buttons_from_template(p_template_db, p_button_list, p_bar_key)

	for idx, button_def in ipairs(p_template_db) do
		if(button_def.project_id == nil) or (button_def.project_id == WOW_PROJECT_ID) then
			local button_name = button_def.button_name
			if (not p_button_list[button_name]) then
				p_button_list[button_name] = {
					buttonKey = button_name,
					buttonClass = button_def.buttonClass or button_name,
					barKey = p_bar_key,
					defaultButtonIndex = idx,
					enabled = true,
				}
				if (button_def.additional_args) then
					Mixin(p_button_list[button_name], button_def.additional_args)
				end
			end
		end
	end
end

-- Character specific data for a particular Button
-- For instance, the arrangeOnUse item.
-- TODO: This doesn't need to be a function
local function get_bar_default_settings()

	local settings =
	{
		enabled = true,
		rows = 1,
		columns = 16,
		alignButtons = "3",
		alpha = 1,
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
		allowed_class = "*",
		buttonKeys = {},
	}

	return settings

end



---@param p_class_name string
---@return table
local function get_class_bar_default_settings(p_class_name)

	local settings =
	{
		enabled = true,
		share = "2",
		rows = 1,
		columns = CLASS_COLUMN_DEFAULT,
		alignButtons = "3",
		alpha = 1,
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
		allowed_class = p_class_name,
		buttonKeys = {},
	}

	return settings

end

function AutoBar:InitializeDefaults()

	AutoBar.Class.Bar:OptionsInitialize()
	AutoBar.Class.Bar:OptionsUpgrade()

	AutoBar.Class.Button:OptionsInitialize()
	AutoBar.Class.Button:OptionsUpgrade()

	AutoBarDB2.stupidlog = ""


	if (not AutoBarDB2.account.barList["AutoBarClassBarBasic"]) then
		AutoBarDB2.account.barList["AutoBarClassBarBasic"] = get_bar_default_settings();
	end
	if (not AutoBarDB2.account.barList["AutoBarClassBarExtras"]) then
		AutoBarDB2.account.barList["AutoBarClassBarExtras"] = get_bar_default_settings();
		AutoBarDB2.account.barList["AutoBarClassBarExtras"].columns = 9
		AutoBarDB2.account.barList["AutoBarClassBarExtras"].posX = 300
		AutoBarDB2.account.barList["AutoBarClassBarExtras"].posY = 360
	end

--#region ClassBar
	--
	-- Create the class bar
	--

	local class_bar_name = CLASS_BAR_MAP[AutoBar.CLASS]
	if (not AutoBar.class.barList[class_bar_name]) then
		AutoBar.class.barList[class_bar_name] = get_class_bar_default_settings(AutoBar.CLASS)
	end

	local my_class_buttons = CLASS_BUTTON_MAP[AutoBar.CLASS] or {}
	local my_class_button_list = AutoBar.class.buttonList

	create_buttons_from_template(my_class_buttons, my_class_button_list, class_bar_name)

--#endregion ClassBar

--#region Basic Bar
	local account_button_list = AutoBarDB2.account.buttonList
	local basic_bar_name = "AutoBarClassBarBasic"

	create_buttons_from_template(BASIC_BUTTON_DATA, account_button_list, basic_bar_name)

	-- for idx, button_def in ipairs(BASIC_BUTTON_DATA) do
	-- 	local button_name = button_def.button_name
	-- 	if (not common_button_list[button_name]) then
	-- 		common_button_list[button_name] = {
	-- 			buttonKey = button_name,
	-- 			buttonClass = button_def.buttonClass or button_name,
	-- 			barKey = button_def.barKey,
	-- 			defaultButtonIndex = idx,
	-- 			enabled = true,
	-- 			arrangeOnUse = true,
	-- 		}
	-- 		if (button_def.additional_args) then
	-- 			Mixin(common_button_list[button_name], button_def.additional_args)
	-- 		end

	-- 	end
	-- end

	if (not AutoBarDB2.account.buttonList["AutoBarButtonSpeed"]) then
		AutoBarDB2.account.buttonList["AutoBarButtonSpeed"] = {
			buttonKey = "AutoBarButtonSpeed",
			buttonClass = "AutoBarButtonSpeed",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = 1,
			enabled = true,
		}
	end
	if (not AutoBarDB2.account.buttonList["AutoBarButtonFreeAction"]) then
		AutoBarDB2.account.buttonList["AutoBarButtonFreeAction"] = {
			buttonKey = "AutoBarButtonFreeAction",
			buttonClass = "AutoBarButtonFreeAction",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = 2,
			enabled = true,
		}
	end
	if (not AutoBarDB2.account.buttonList["AutoBarButtonExplosive"]) then
		AutoBarDB2.account.buttonList["AutoBarButtonExplosive"] = {
			buttonKey = "AutoBarButtonExplosive",
			buttonClass = "AutoBarButtonExplosive",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = 3,
			enabled = true,
		}
	end
	if (not AutoBarDB2.account.buttonList["AutoBarButtonFishing"]) then
		AutoBarDB2.account.buttonList["AutoBarButtonFishing"] = {
			buttonKey = "AutoBarButtonFishing",
			buttonClass = "AutoBarButtonFishing",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = 4,
			enabled = true,
		}
	end
	if (not AutoBarDB2.account.buttonList["AutoBarButtonBattleStandards"]) then
		AutoBarDB2.account.buttonList["AutoBarButtonBattleStandards"] = {
			buttonKey = "AutoBarButtonBattleStandards",
			buttonClass = "AutoBarButtonBattleStandards",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = 6,
			enabled = true,
		}
	end
	if (not AutoBarDB2.account.buttonList["AutoBarButtonOpenable"]) then
		AutoBarDB2.account.buttonList["AutoBarButtonOpenable"] = {
			buttonKey = "AutoBarButtonOpenable",
			buttonClass = "AutoBarButtonOpenable",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = 7,
			enabled = true,
			drag = true,
		}
	end
	if (not AutoBarDB2.account.buttonList["AutoBarButtonMiscFun"]) then
		AutoBarDB2.account.buttonList["AutoBarButtonMiscFun"] = {
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

	if (LE_EXPANSION_WRATH_OF_THE_LICH_KING and LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_WRATH_OF_THE_LICH_KING) then

		if (not AutoBarDB2.account.buttonList["AutoBarButtonMillHerbs"]) then
			AutoBarDB2.account.buttonList["AutoBarButtonMillHerbs"] = {
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

		if (not AutoBarDB2.account.buttonList["AutoBarButtonArchaeology"]) then
			AutoBarDB2.account.buttonList["AutoBarButtonArchaeology"] = {
				buttonKey = "AutoBarButtonArchaeology",
				buttonClass = "AutoBarButtonArchaeology",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = "*",
				enabled = true,
			}
		end

		if (not AutoBarDB2.account.buttonList["AutoBarButtonPets"]) then
			AutoBarDB2.account.buttonList["AutoBarButtonPets"] = {
				buttonKey = "AutoBarButtonPets",
				buttonClass = "AutoBarButtonPets",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = 5,
				enabled = true,
				arrangeOnUse = true,
			}
		end

		if (not AutoBarDB2.account.buttonList["AutoBarButtonGuildSpell"]) then
			AutoBarDB2.account.buttonList["AutoBarButtonGuildSpell"] = {
				buttonKey = "AutoBarButtonGuildSpell",
				buttonClass = "AutoBarButtonGuildSpell",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = 9,
				enabled = true,
				arrangeOnUse = true,
			}
		end

		if (not AutoBarDB2.account.buttonList["AutoBarButtonSunsongRanch"]) then
			AutoBarDB2.account.buttonList["AutoBarButtonSunsongRanch"] = {
				buttonKey = "AutoBarButtonSunsongRanch",
				buttonClass = "AutoBarButtonSunsongRanch",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = 10,
				enabled = true,
				arrangeOnUse = true,
			}
		end

		if (not AutoBarDB2.account.buttonList["AutoBarButtonGarrison"]) then
			AutoBarDB2.account.buttonList["AutoBarButtonGarrison"] = {
				buttonKey = "AutoBarButtonGarrison",
				buttonClass = "AutoBarButtonGarrison",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = 12,
				enabled = true,
				arrangeOnUse = true,
			}
		end

		if (not AutoBarDB2.account.buttonList["AutoBarButtonOrderHallTroop"]) then
			AutoBarDB2.account.buttonList["AutoBarButtonOrderHallTroop"] = {
				buttonKey = "AutoBarButtonOrderHallTroop",
				buttonClass = "AutoBarButtonOrderHallTroop",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = "*",
				enabled = true,
				arrangeOnUse = true,
			}
		end

		if (not AutoBarDB2.account.buttonList["AutoBarButtonOrderHallResource"]) then
			AutoBarDB2.account.buttonList["AutoBarButtonOrderHallResource"] = {
				buttonKey = "AutoBarButtonOrderHallResource",
				buttonClass = "AutoBarButtonOrderHallResource",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = "*",
				enabled = true,
				arrangeOnUse = true,
			}
		end

		if (not AutoBarDB2.account.buttonList["AutoBarButtonBattlePetItems"]) then
			AutoBarDB2.account.buttonList["AutoBarButtonBattlePetItems"] = {
				buttonKey = "AutoBarButtonBattlePetItems",
				buttonClass = "AutoBarButtonBattlePetItems",
				barKey = "AutoBarClassBarExtras",
				defaultButtonIndex = "*",
				enabled = true,
				arrangeOnUse = true,
			}
		end

		-- if (not AutoBarDB2.account.buttonList["AutoBarButtonToyBox"]) then
		-- 	AutoBarDB2.account.buttonList["AutoBarButtonToyBox"] = {
		-- 		buttonKey = "AutoBarButtonToyBox",
		-- 		buttonClass = "AutoBarButtonToyBox",
		-- 		barKey = "AutoBarClassBarExtras",
		-- 		defaultButtonIndex = "*",
		-- 		enabled = false,
		-- 		arrangeOnUse = true,
		-- 		toybox_only_show_favourites = true,
		-- 	}
		-- end
	end
--#endregion XpacButtons

	if (not AutoBarDB2.account.buttonList["AutoBarButtonRaidTarget"]) then
		AutoBarDB2.account.buttonList["AutoBarButtonRaidTarget"] = {
			buttonKey = "AutoBarButtonRaidTarget",
			buttonClass = "AutoBarButtonRaidTarget",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = "*",
			enabled = true,
			arrangeOnUse = true,
		}
	end

	if (not AutoBarDB2.account.buttonList["AutoBarButtonMount"]) then
		AutoBarDB2.account.buttonList["AutoBarButtonMount"] = {
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

	if (not AutoBarDB2.account.buttonList["AutoBarButtonReputation"]) then
		AutoBarDB2.account.buttonList["AutoBarButtonReputation"] = {
			buttonKey = "AutoBarButtonReputation",
			buttonClass = "AutoBarButtonReputation",
			barKey = "AutoBarClassBarExtras",
			defaultButtonIndex = "*",
			enabled = true,
			arrangeOnUse = true,
		}
	end


	if (not AutoBar.class.buttonList["AutoBarButtonShields"]) then
		AutoBar.class.buttonList["AutoBarButtonShields"] = {
			buttonKey = "AutoBarButtonShields",
			buttonClass = "AutoBarButtonShields",
			barKey = AutoBar.classBar,
			defaultButtonIndex = "*",
			enabled = true,
			arrangeOnUse = true,
		}
	end

	if (AutoBar.CLASS ~= "MONK") then
		if (not AutoBar.class.buttonList["AutoBarButtonER"]) then
			AutoBar.class.buttonList["AutoBarButtonER"] = {
				buttonKey = "AutoBarButtonER",
				buttonClass = "AutoBarButtonER",
				barKey = AutoBar.classBar,
				defaultButtonIndex = "*",
				enabled = true,
				noPopup = true,
			}
		end
	end

	if (not AutoBar.class.buttonList["AutoBarButtonInterrupt"]) then
		AutoBar.class.buttonList["AutoBarButtonInterrupt"] = {
			buttonKey = "AutoBarButtonInterrupt",
			buttonClass = "AutoBarButtonInterrupt",
			barKey = AutoBar.classBar,
			defaultButtonIndex = "*",
			enabled = true,
			arrangeOnUse = true,
		}
	end




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
			"AutoBarButtonCooldownDrums", "AutoBarButtonToyBox",
		}
	else
		deprecated_buttons = {
			"AutoBarButtonCooldownDrums",
		}
	end

	for _, dep in ipairs(deprecated_buttons) do
		if (AutoBarDB2.account.buttonList[dep]) then
			AutoBarDB2.account.buttonList[dep] = nil
		end
		if (AutoBar.class.buttonList[dep]) then
			AutoBar.class.buttonList[dep] = nil
		end
		if (AutoBar.char.buttonList[dep]) then
			AutoBar.char.buttonList[dep] = nil
		end

	end

	if(AutoBar.CLASS == "WARLOCK" and AutoBar.class.buttonList["AutoBarButtonInterrupt"]) then
		AutoBar.class.buttonList["AutoBarButtonInterrupt"] = nil
	end

	if (ABGData.is_mainline_wow) then

		if(AutoBar.CLASS == "ROGUE" and AutoBar.class.buttonList["AutoBarButtonTrap"]) then
			AutoBar.class.buttonList["AutoBarButtonTrap"] = nil
		end
		if(AutoBar.CLASS == "DRUID" ) then
			AutoBar.class.buttonList["AutoBarButtonClassPet"] = nil
			AutoBar.class.buttonList["AutoBarButtonStance"] = nil
		end
	end


-- save as sample to remove buttons per class
--	if(AutoBar.CLASS == "xx" and AutoBar.class.buttonList["AutoBarButtonInterrupt"]) then
--		AutoBar.class.buttonList["AutoBarButtonInterrupt"] = nil
--	end

end


-- Populate AutoBar.buttonDBList with the correct DB from char, class or account
function AutoBar:RefreshButtonDBList()
	local buttonDBList = AutoBar.buttonDBList
	for buttonKey, _buttonDB in pairs(buttonDBList) do
		buttonDBList[buttonKey] = nil
	end
	for buttonKey, _buttonDB in pairs(AutoBar.char.buttonList) do
		buttonDBList[buttonKey] = AutoBar:GetButtonDB(buttonKey)
	end
	for buttonKey, _buttonDB in pairs(AutoBar.class.buttonList) do
		buttonDBList[buttonKey] = AutoBar:GetButtonDB(buttonKey)
	end
	for buttonKey, _buttonDB in pairs(AutoBarDB2.account.buttonList) do
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
	for barKey, _bar_db in pairs(AutoBar.char.barList) do
		barButtonsDBList[barKey] = AutoBar:GetSharedBarDB(barKey, "sharedButtons")
		barLayoutDBList[barKey] = AutoBar:GetSharedBarDB(barKey, "sharedLayout")
		barPositionDBList[barKey] = AutoBar:GetSharedBarDB(barKey, "sharedLocation")
	end
	for barKey, _bar_db in pairs(AutoBar.class.barList) do
		barButtonsDBList[barKey] = AutoBar:GetSharedBarDB(barKey, "sharedButtons")
		barLayoutDBList[barKey] = AutoBar:GetSharedBarDB(barKey, "sharedLayout")
		barPositionDBList[barKey] = AutoBar:GetSharedBarDB(barKey, "sharedLocation")
	end
	for barKey, _bar_db in pairs(AutoBarDB2.account.barList) do
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

end


