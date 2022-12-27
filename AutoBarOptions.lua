--
-- AutoBarOptions
-- Copyright 2007+ Toadkiller of Proudmoore.
--
-- Configuration Options for AutoBar
-- http://muffinmangames.com
--

-- Custom Category:
--  AutoBarDB2.custom_categories[customCategoryIndex]
--	A separate list of Categories that is global to all players
--	Users add custom Categories to list.
--	Custom Categories can have specific items and spells dragged into their list.
--	Custom Categories can also be set to PT3 Sets, one regular Set & one priority Set
--	A priority Set item has priority over a regular Set item with the same value.
--	All common settings available to a built in Category are also available to a Custom category

-- CustomButton:
--	A separate list of Buttons that is global to all players

-- Button:
--  AutoBar.db.<account|class|char>.buttonList[buttonIndex]
--	Some Buttons like custom Buttons can have their Categories chosen from the Categories list

--  AutoBar.db.char.buttons[buttonName]
--  Contains the defaults for Button settings & changes to the settings are stored here.
--  Enable / Disable state is recorded here
--  Only one buttonName per button found in a Bar
--  barKey
--  defaultButtonIndex (#, "*" for at end, "~" for do not place, "buttonName" to insert after a button).
--  place: true.  Placement sets it to false.
--    Buttons are placed in their barKey at defaultButtonIndex on initialize.
--  deleted: false. Can be deleted by deleting from a Bar.
--  Deleted Buttons can be added back to a Bar
--  Plugin & Custom Buttons are added here & must have non-clashing names

-- GLOBALS: IsShiftKeyDown, IsControlKeyDown, IsAltKeyDown, GameTooltip, InCombatLockdown, GetItemInfo, GetMacroInfo

local _, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

local AutoBar = AutoBar
local ABGCode = AutoBarGlobalCodeSpace
local _ABGData = AutoBarGlobalDataObject

local L = AutoBarGlobalDataObject.locale
local LDB = LibStub("LibDataBroker-1.1", true)
local ldbIcon = LibStub("LibDBIcon-1.0", true)
local AceCfgReg = LibStub("AceConfigRegistry-3.0")
local AceCfgDlg = LibStub("AceConfigDialog-3.0")
local AceCfgCmd = LibStub("AceConfigCmd-3.0")

local dewdrop = nil

local hintString = "|cffffffff%s:|r %s"
local hintText = {
	"AutoBar",
	hintString:format(L["Left-Click"], L["Options GUI"]),
	hintString:format(L["Alt-Click"], L["Key Bindings"]),
	hintString:format(L["Ctrl-Click"], L["Move the Buttons"]),
	hintString:format(L["Shift-Click"], L["Move the Bars"]),
}
local function LDBOnClick(_clickedFrame, button)
	if (button == "LeftButton") then
		if (dewdrop and dewdrop:GetOpenedParent()) then
			dewdrop:Close()
		end
		if (IsShiftKeyDown()) then
			AutoBar:MoveBarModeToggle()
		elseif (IsControlKeyDown()) then
			AutoBar:MoveButtonsModeToggle()
		elseif (IsAltKeyDown()) then
			AB.LibKeyBound:Toggle()
		elseif(AceCfgDlg.OpenFrames["AutoBar"]) then
			AceCfgDlg:Close("AutoBar")
		else
			AutoBar:CreateOptionsAce3()
			AceCfgDlg:Open("AutoBar")
		end
	elseif (button == "RightButton") then
		InterfaceOptionsFrame_OpenToCategory("AutoBar")
		InterfaceOptionsFrame_OpenToCategory("AutoBar")
	end
end

function AutoBar:InitializeOptions()

	self:CreateOptionsAce3()

	if (LDB) then
		local ldbAutoBar = LibStub("LibDataBroker-1.1"):NewDataObject("AutoBar", {
			type = "launcher",
			icon = "Interface\\Icons\\INV_Ingot_Eternium",
			tocname = "AutoBar",
			label = "AutoBar",
			OnClick = LDBOnClick,
			OnTooltipShow = function(tooltip)
				if (dewdrop and dewdrop:GetOpenedParent()) then
					GameTooltip:Hide()
				end
				if (tooltip and tooltip.AddLine) then
					for _i, text in ipairs(hintText) do
						tooltip:AddLine(text)
					end
				end
			end,
		})

		if (ldbIcon) then

			ldbIcon:Register("AutoBar", ldbAutoBar, AutoBarDB2.ldb_icon)

			self.optionsMain.args.main.args.ldbIcon = {
				type = "toggle",
				order = 199,
				width = 1.2,
				name = L["Show Minimap Icon"],
				desc = L["Show Minimap Icon"],
				get = function() return not AutoBarDB2.ldb_icon.hide end,
				set = function(_info, value)
					value = not value
					AutoBarDB2.ldb_icon.hide = value
					if (value) then
						ldbIcon:Hide("AutoBar")
					else
						ldbIcon:Show("AutoBar")
					end
				end,
			}


		end
	end
end


function AutoBar:OpenOptions()
	AutoBar:RefreshButtonDBList()
	AutoBar:RefreshBarDBLists()
	AutoBar:RemoveDuplicateButtons()
	AutoBar:RefreshUnplacedButtonList()
	AutoBar:CreateOptionsAce3()
	AceCfgReg:NotifyChange("AutoBar")
	AceCfgDlg:Open("AutoBar")
end

function AutoBarChanged()
	ABGCode:UpdateObjects()
	AceCfgReg:NotifyChange("AutoBar")
end


-- local function ButtonCategoriesChanged()
-- 	AutoBar:CreateCustomCategoryOptions(AutoBar.optionsMain.args.categories.args)
-- 	ABGCode.UpdateCategories()
-- end


function AutoBar:ButtonsChanged()
	AutoBar:RefreshButtonDBList()
	AutoBar:RemoveDuplicateButtons()
	AutoBar:RefreshUnplacedButtonList()
	AutoBar:CreateButtonOptions(AutoBar.optionsMain.args.buttons.args)
	ABGCode.UpdateCategories()
	AceCfgReg:NotifyChange("AutoBar")
end


function AutoBar:BarButtonChanged()
	AutoBar:RefreshButtonDBList()
	AutoBar:RemoveDuplicateButtons()
	AutoBar:RefreshBarDBLists()
	AutoBar:RefreshUnplacedButtonList()
	ABGCode.UpdateCategories()
	AutoBar:CreateOptionsAce3()
	AceCfgReg:NotifyChange("AutoBar")
end


function AutoBar:BarsChanged()
	AutoBar:RefreshButtonDBList()
	AutoBar:RefreshBarDBLists()
	AutoBar:RemoveDuplicateButtons()
	AutoBar:RefreshUnplacedButtonList()
	AutoBar:CreateOptionsAce3()
	ABGCode.UpdateCategories()
	AceCfgReg:NotifyChange("AutoBar")
end


function AutoBar:CategoriesChanged()
	AutoBar:CreateCustomCategoryOptions(AutoBar.optionsMain.args.categories.args)
	ABGCode.UpdateCategories()
	AceCfgReg:NotifyChange("AutoBar")
end


local function CopyTable(source, target)
	for k, _v in pairs(source) do
		if (type(k) == "table") then
			target[k] = {}
			CopyTable(source[k], target[k])
		else
			target[k] = source[k]
		end
	end
end

local shareValidateList = {
	["1"] = L["None"],	-- char
	["2"] = L["Class"],
	["3"] = L["Account"],
}

local SHARED_NONE = "1"
local SHARED_CLASS = "2"
local SHARED_ACCOUNT = "3"

function AutoBar:GetSharedBarDB(barKey, sharedVar)
	local charDB = AutoBar.char.barList[barKey]
	local classDB = AutoBar.class.barList[barKey]
	local accountDB = AutoBarDB2.account.barList[barKey]
	local debug = false --barKey == "AutoBarClassBarBasic"

	if (debug) then ABGCode.LogWarning("AutoBar:GetSharedBarDB(", barKey, ", ", sharedVar, ")"); end
	if (debug) then ABGCode.LogWarning("charDB", charDB, " classDB", classDB, " accountDB", accountDB); end

	-- Char specific db overides all others
	if (charDB and charDB[sharedVar]) then
		if (charDB[sharedVar] == SHARED_NONE) then
			return charDB
		elseif (charDB[sharedVar] == SHARED_CLASS and classDB) then
			return classDB
		elseif (charDB[sharedVar] == SHARED_ACCOUNT and accountDB) then
			return accountDB
		end
	end

	-- Class db overides account
	if (classDB and classDB[sharedVar]) then
		if (classDB[sharedVar] == SHARED_NONE and charDB) then
			return charDB
		elseif (classDB[sharedVar] == SHARED_CLASS) then
			return classDB
		elseif (classDB[sharedVar] == SHARED_ACCOUNT and accountDB) then
			return accountDB
		end
	end

	if (debug) then ABGCode.LogWarning("accountDB", accountDB, " sharedVar", accountDB[sharedVar]); end

	-- Default to account
	if (accountDB and accountDB[sharedVar]) then
		if (accountDB[sharedVar] == SHARED_NONE and charDB) then
			return charDB
		elseif (accountDB[sharedVar] == SHARED_CLASS and classDB) then
			return classDB
		elseif (accountDB[sharedVar] == SHARED_ACCOUNT) then
			return accountDB
		end
	end

	-- No specific setting so use the widest scope available
	if (accountDB) then
		if (debug) then ABGCode.LogWarning("using accountDB"); end
		if (debug) then ABGCode.LogWarning(AB.Dump(accountDB, 1)); end

		return accountDB
	elseif (classDB) then
		return classDB
	elseif (charDB) then
		return charDB
	else
		assert(accountDB and classDB and charDB, "AutoBar:GetSharedBarDB nil accountDB, classDB, charDB")
	end
end

function AutoBar:GetSharedBarDBValue(barKey, sharedVar)
	-- Char specific db overides all others
	local charDB = AutoBar.char.barList[barKey]
	if (charDB and charDB[sharedVar]) then
		return charDB[sharedVar]
	end

	-- Class db overides account
	local classDB = AutoBar.class.barList[barKey]
	if (classDB and classDB[sharedVar]) then
		return classDB[sharedVar]
	end

	-- Default to account
	local accountDB = AutoBarDB2.account.barList[barKey]
	if (accountDB and accountDB[sharedVar]) then
		return accountDB[sharedVar]
	end

	-- No specific setting so use the widest scope available
	if (accountDB) then
		return SHARED_ACCOUNT
	elseif (classDB) then
		return SHARED_CLASS
	elseif (charDB) then
		return SHARED_NONE
	else
		assert(accountDB and classDB and charDB, "AutoBar:GetSharedBarDBValue nil accountDB, classDB, charDB")
	end
end

--/dump AutoBar:GetSharedBarDBValue("AutoBarClassBarHunter", "sharedLayout")
--/dump AutoBar:GetSharedBarDB("AutoBarClassBarHunter", "sharedLayout")

--/dump AutoBar.char.barList["AutoBarClassBarHunter"]
--/dump AutoBar:GetSharedBarDBValue("AutoBarClassBarHunter", "sharedButtons")
--/dump AutoBar:GetSharedBarDB("AutoBarClassBarHunter", "sharedButtons")

function AutoBar:SetSharedBarDB(barKey, sharedVar, value)
	local charDB, classDB, accountDB

	if (value == SHARED_NONE) then
		charDB = AutoBar.char.barList[barKey]
		if (not charDB) then
			local sourceDB = AutoBar:GetSharedBarDB(barKey, sharedVar)
			charDB = {}
			AutoBar.char.barList[barKey] = charDB
			CopyTable(sourceDB, charDB)
		end
		charDB[sharedVar] = value
	elseif (value == SHARED_CLASS) then
		classDB = AutoBar.class.barList[barKey]
		if (not classDB) then
			local sourceDB = AutoBar:GetSharedBarDB(barKey, sharedVar)
			classDB = {}
			AutoBar.class.barList[barKey] = classDB
			CopyTable(sourceDB, classDB)
		end
		classDB[sharedVar] = value
		charDB = AutoBar.char.barList[barKey]
		if (charDB) then
			charDB[sharedVar] = nil
		end
	elseif (value == SHARED_ACCOUNT) then
		accountDB = AutoBarDB2.account.barList[barKey]
		if (accountDB) then
			charDB = AutoBar.char.barList[barKey]
			if (charDB) then
				charDB[sharedVar] = nil
			end
			classDB = AutoBar.class.barList[barKey]
			if (classDB) then
				classDB[sharedVar] = nil
			end
			accountDB[sharedVar] = nil
		else
			-- Disallow promotion to account.
		end
	end
end

function AutoBar:GetButtonDB(buttonKey)
--	assert(buttonKey, "nil buttonKey")
	local db, accountDB

	-- Char specific db overides all others
	db = AutoBar.char.buttonList[buttonKey]
	if (db) then
		if (db.shared and db.shared == SHARED_NONE) then
			return db
		elseif (db.shared and db.shared == SHARED_CLASS) then
			return AutoBar.class.buttonList[buttonKey]
		elseif (not db.shared or db.shared == SHARED_ACCOUNT) then
			return AutoBarDB2.account.buttonList[buttonKey]
		end
	end

	-- Class db overides account
	db = AutoBar.class.buttonList[buttonKey]
	if (db) then
		if (db.shared and db.shared == SHARED_CLASS) then
			return db
		elseif (not db.shared or db.shared == SHARED_ACCOUNT) then
			accountDB = AutoBarDB2.account.buttonList[buttonKey]
			if (accountDB) then
				return accountDB
			else
				return db
			end
		end
	end

	accountDB = AutoBarDB2.account.buttonList[buttonKey]
	if (accountDB) then
		return accountDB
	end

	return db
end

function AutoBar:GetSharedButtonDBValue(buttonKey)
	-- Char specific db overides all others
	local charDB = AutoBar.char.buttonList[buttonKey]
	if (charDB and charDB.shared) then
		return charDB.shared
	end

	-- Class db overides account
	local classDB = AutoBar.class.buttonList[buttonKey]
	if (classDB and classDB.shared) then
		return classDB.shared
	end

	-- Default to account
	local accountDB = AutoBarDB2.account.buttonList[buttonKey]
	if (accountDB and accountDB.shared) then
		return accountDB.shared
	end

	-- No specific setting so use the widest scope available
	if (accountDB) then
		return SHARED_ACCOUNT
	elseif (classDB) then
		return SHARED_CLASS
	elseif (charDB) then
		return SHARED_NONE
	else
		assert(accountDB and classDB and charDB, "AutoBar:GetSharedButtonDBValue nil accountDB, classDB, charDB")
	end
end

function AutoBar:SetSharedButtonDB(buttonKey, value)
	local charDB, classDB, accountDB

	if (value == SHARED_NONE) then
		charDB = AutoBar.char.buttonList[buttonKey]
		if (not charDB) then
			local sourceDB = AutoBar:GetButtonDB(buttonKey)
			charDB = {}
			AutoBar.char.buttonList[buttonKey] = charDB
			CopyTable(sourceDB, charDB)
		end
		charDB.shared = value
	elseif (value == SHARED_CLASS) then
		classDB = AutoBar.class.buttonList[buttonKey]
		if (not classDB) then
			local sourceDB = AutoBar:GetButtonDB(buttonKey)
			classDB = {}
			AutoBar.class.buttonList[buttonKey] = classDB
			CopyTable(sourceDB, classDB)
		end
		classDB.shared = value
		charDB = AutoBar.char.buttonList[buttonKey]
		if (charDB) then
			charDB.shared = nil
		end
	elseif (value == SHARED_ACCOUNT) then
		accountDB = AutoBarDB2.account.buttonList[buttonKey]
		if (not accountDB) then
			local sourceDB = AutoBar:GetButtonDB(buttonKey)
			accountDB = {}
			AutoBarDB2.account.buttonList[buttonKey] = accountDB
			CopyTable(sourceDB, accountDB)
		end
		charDB = AutoBar.char.buttonList[buttonKey]
		if (charDB) then
			charDB.shared = nil
		end
		classDB = AutoBar.class.buttonList[buttonKey]
		if (classDB) then
			classDB.shared = nil
		end
	end
end


function AutoBar:GetCategoriesItemDB(categoryKey, itemIndex)
	local config = AutoBarDB2.custom_categories[categoryKey]
	if (itemIndex) then
		config = config.items[itemIndex]
	end
	return config
end

--[[
local function ResetBarList(barList)
	for barKey, barDB in pairs(barList) do
		if (not barDB.isCustomBar) then
			barList[barKey] = nil
		end
	end
end
--]]

--[[
local function ResetBars()
	ResetBarList(AutoBarDB2.account.barList)
	for _classKey, classDB in pairs(AutoBarDB2.classes) do
		ResetBarList(classDB.barList)
	end
	for _charKey, charDB in pairs(AutoBarDB2.chars) do
		ResetBarList(charDB.barList)
	end

	AutoBar:InitializeDefaults()

	AutoBar:RefreshBarDBLists()
	for _barKey, bar in pairs(AutoBar.barList) do
		bar:UpdateShared()
	end

	AutoBar:PopulateBars()
	AutoBar:CreateOptionsAce3()
	ABGCode.UpdateCategories()
	AceCfgReg:NotifyChange("AutoBar")
end
--]]

--[[
local function ResetButtons()
	AutoBar:PopulateBars()
	AutoBar:CreateOptionsAce3()
	ABGCode.UpdateCategories()
	AceCfgReg:NotifyChange("AutoBar")
end
--]]

-- local function ResetAutoBar()
-- 	AutoBar:PopulateBars()
-- 	AutoBar:CreateOptionsAce3()
-- 	ABGCode.UpdateCategories()
-- 	AceCfgReg:NotifyChange("AutoBar")
-- end


function AutoBar:OnProfileDisable()
end


function AutoBar:OnProfileEnable()
end


local function getCombatLockdown()
	 return InCombatLockdown()
end


local function getDocking(info)
	local barKey = info.arg.barKey
	local docking = AutoBar.barLayoutDBList[barKey].docking
	if (not docking) then
		docking = "NONE"
	end
	return docking
end

local function setDocking(info, value)
	local barKey = info.arg.barKey
	if (value == "NONE") then
		value = nil
	end
	AutoBar.barLayoutDBList[barKey].docking = value
	AutoBarChanged()
end

local function setFrameStrata(info, value)
	local barKey = info.arg.barKey
	AutoBar.barLayoutDBList[barKey].frameStrata = value
	local bar = AutoBar.barList[barKey]
	if (bar) then
		bar.frame:SetFrameStrata(value)
	end
	AutoBarChanged()
end

local function getCustomBarName(info)
	local barKey = info.arg.barKey
	return AutoBar.barLayoutDBList[barKey].name
end

local function setCustomBarName(info, value)
	value = ABGCode.GetValidatedName(value)
	if (value and value ~= "") then
		local barKey = info.arg.barKey

		if (not AutoBar.Class.Bar:NameExists(value)) then
			local customBarDB = AutoBar.barLayoutDBList[barKey]
			customBarDB.name = value

			local bar = AutoBar.barList[barKey]
			if (bar) then
				bar:ChangeName(value)
			end

			AutoBar.Class.Bar:Rename(barKey, value)
			AutoBar:BarsChanged()
		end
	end
end

local function getCustomButtonName(info)
	local buttonKey = info.arg.buttonKey
	return AutoBar:GetButtonDB(buttonKey).name
end

local function setCustomButtonName(info, value)
	value = ABGCode.GetValidatedName(value)
	if (value and value ~= "") then
		local buttonKey = info.arg.buttonKey
		if (AutoBar.Class.Button:NameExists(value)) then
		else
			AutoBar.Class.Button:Rename(buttonKey, value)
			AutoBar:BarButtonChanged()
		end
	end
end


local function setButtonArrangeOnUse(info, value)
	local buttonKey = info.arg.buttonKey
	AutoBar:GetButtonDB(buttonKey).arrangeOnUse = value
	local buttonData = AutoBar.char.buttonDataList[buttonKey]
	if (buttonData) then
		buttonData.arrangeOnUse = nil
	end
	AutoBarChanged()
end



-- Cut the button at fromIndex out of fromBarKey
-- 1 <= fromIndex <= # fromButtonKeyList
-- Adjust the remaining buttons to fill the gap if any
-- Return the button, its DB & its Options
function AutoBar:ButtonCut(fromBarKey, fromIndex)
	local fromButtonKeyList = AutoBar.barButtonsDBList[fromBarKey].buttonKeys
	local nButtons = # fromButtonKeyList
	assert(fromIndex > 0, "AutoBar:ButtonCut fromIndex < 1")
	assert(fromIndex <= nButtons, "AutoBar:ButtonCut " .. tostring(fromBarKey) .. " fromIndex (" .. tostring(fromIndex) .. ") > nButtons (" .. tostring(nButtons) .. ")")

	local buttonKey = fromButtonKeyList[fromIndex]
	for index = fromIndex, nButtons, 1 do
		fromButtonKeyList[index] = fromButtonKeyList[index + 1]
	end

	local bar = AutoBar.barList[fromBarKey]
	local button
	if (bar) then
		button = bar.buttonList[fromIndex]
	end

	return buttonKey, button
end


-- Paste buttonKey, buttonOptions at toIndex of toBarKey
-- 1 <= toIndex <= # toButtonKeyList + 1
-- Adjust the remaining buttons to fill the gap if any
function AutoBar:ButtonPaste(buttonDB, fromBarKey, toBarKey, toIndex, button)
	local toButtonKeyList = AutoBar.barButtonsDBList[toBarKey].buttonKeys
	local nButtons = # toButtonKeyList
	assert(toIndex > 0, "AutoBar:ButtonPaste toIndex < 1")
	assert(toIndex <= nButtons + 1, "AutoBar:ButtonPaste toIndex > nButtons + 1")
	assert(buttonDB, "AutoBar:ButtonPaste buttonDB nil")
	local multiBarPaste = fromBarKey ~= toBarKey

	-- Avoid duplication
	local duplicate
	if (multiBarPaste) then
		local targetButtonKey = buttonDB.buttonKey
		for buttonKeyIndex, buttonKey in pairs(toButtonKeyList) do
			if (targetButtonKey == buttonKey) then
				duplicate = true
				break
			end
		end
	end

	if (not duplicate) then
		-- Make room
		if (toIndex <= nButtons) then
			for index = nButtons + 1, toIndex + 1, -1 do
				toButtonKeyList[index] = toButtonKeyList[index - 1]
			end
		end
		-- Paste it
		toButtonKeyList[toIndex] = buttonDB.buttonKey
	end

	-- Handle reparenting for multiBarPaste of the actual button
	if (multiBarPaste) then
		buttonDB.barKey = toBarKey
		local parentBar = AutoBar.barList[toBarKey]
		if (button) then
			button:Refresh(parentBar, buttonDB)
			button.parentBar.frame:SetAttribute("addchild", button.frame)
		end
	end
end


-- This supports moving without the lame condition where you cannot move to a particular end
-- Button is cut from fromIndex of fromBarKey and inserted at toIndex of toBarKey
-- For toIndex <= toButtonKeyList existing buttons are shuffled up to make room
-- For toIndex > toButtonKeyList button is inserted at end
function AutoBar:ButtonMove(fromBarKey, fromIndex, toBarKey, toIndex)
	local fromButtonKeyList = AutoBar.barButtonsDBList[fromBarKey].buttonKeys
	local toButtonKeyList = AutoBar.barButtonsDBList[toBarKey].buttonKeys
	local nButtons = # toButtonKeyList
	local multiBarMove = fromBarKey ~= toBarKey

	-- Wrangle the indexes
	if (toIndex < 1) then
		toIndex = 1
	end
	if (toIndex > nButtons) then
		if (multiBarMove) then
			-- Special case move to end across multiple bars
			toIndex = nButtons + 1
		else
			toIndex = nButtons
		end
	end
	if (not multiBarMove) then
		if (toIndex > fromIndex) then
			-- Adjust offset due to cut from earlier in the list
--			toIndex = toIndex - 1
		elseif (toIndex == fromIndex) then
			return
		end
	end

	-- Cut & Paste
	local buttonKey, button = AutoBar:ButtonCut(fromBarKey, fromIndex)
	local buttonDB = AutoBar:GetButtonDB(buttonKey)
	AutoBar:ButtonPaste(buttonDB, fromBarKey, toBarKey, toIndex, button)
end


local function BarNew()
	local newBarName, barKey = AutoBar.Class.Bar:GetNewName(L["Custom"])
	AutoBarDB2.account.barList[barKey] = {
		name = newBarName,
		desc = newBarName,
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
		posY = 360,
		allowed_class = "*",
		isCustomBar = true,
		buttonKeys = {},
	}
	AutoBar:BarsChanged()
--DevTools_Dump(AutoBarDB2.account.barList)
end
--/Dump AutoBarDB2.account.barList
--/dump AutoBarDB2.account.barList["AutoBarCustomBar1"]
--/Script AutoBarDB2.account.barList["AutoBarCustomBar1"] = nil

local function BarButtonDelete(barKey, buttonKey, buttonIndex)
	local buttonKey, button = AutoBar:ButtonCut(barKey, buttonIndex)
	-- Move to disabled cache
	if (AutoBar.buttonList[buttonKey]) then
		AutoBar.buttonListDisabled[buttonKey] = AutoBar.buttonList[buttonKey]
		AutoBar.buttonList[buttonKey] = nil
	end
	if (button) then
		button.frame:Hide()
	end
end


local function BarDelete(info)
	local barKey = info.arg.barKey

	local bar = AutoBar.barList[barKey]
	if (bar) then
		for buttonKey, button in pairs(bar.buttonList) do
			if (AutoBar.buttonList[buttonKey]) then
				AutoBar.buttonListDisabled[buttonKey] = AutoBar.buttonList[buttonKey]
				AutoBar.buttonList[buttonKey] = nil
			end
			button.frame:Hide()
		end
	end

	AutoBar.Class.Bar:Delete(barKey)
	AutoBar.optionsMain.args.bars.args[barKey] = nil
	AutoBar:BarsChanged()
end


local function CustomButtonReset()
	AutoBar.Class.Button:OptionsReset()
	AutoBar:ButtonsChanged()
end


local MAXBARBUTTONS = 64
local function BarButtonNew(info)
	local barKey = info.arg.barKey
	local buttonKeys = AutoBar.barButtonsDBList[barKey].buttonKeys
	local buttonIndex = # buttonKeys + 1
	if (buttonIndex <= MAXBARBUTTONS) then
		local newButtonName, customButtonKey = AutoBar.Class.Button:GetNewName(L["Custom"])
		AutoBarDB2.account.buttonList[customButtonKey] = {
			name = newButtonName,
			buttonKey = customButtonKey,
			buttonClass = "AutoBarButtonCustom",
			barKey = barKey,
			hasCustomCategories = true,
			enabled = true,
		}
		AutoBarDB2.account.buttonList[customButtonKey][1] = "Misc.Hearth"
		buttonKeys[buttonIndex] = customButtonKey
	end

	AutoBar:BarButtonChanged()
end


local function ButtonDelete(info)
	local barKey, buttonKey, buttonIndex = info.arg.barKey, info.arg.buttonKey, info.arg.buttonIndex
	local barButtonsDBList = AutoBar.barButtonsDBList
	for barKey, barDB in pairs(barButtonsDBList) do
		for barButtonIndex, barButtonKey in pairs(barDB.buttonKeys) do
			if (barButtonKey == buttonKey) then
				BarButtonDelete(barKey, buttonKey, barButtonIndex)
			end
		end
	end
	AutoBar.Class.Button:Delete(buttonKey)
	AutoBarSearch:Reset()

	AutoBar:BarButtonChanged()
end
-- /dump AutoBar.buttonDBList
-- /dump AutoBar.buttonDBList["AutoBarCustomButton4"]
-- /script AutoBarDB2.account.buttonList["AutoBarCustomButton4"] = nil
-- /script AutoBarDB2.account.buttonList["AutoBarCustomButton4"] = nil

local function ButtonRemove(info, oldBarKey, buttonKey)
	if (info) then
		oldBarKey, buttonKey = info.arg.barKey, info.arg.buttonKey
	end

	-- Search for its bar & cut it out
	local barButtonsDBList = AutoBar.barButtonsDBList
	for barKey, barDB in pairs(barButtonsDBList) do
		for barButtonIndex, barButtonKey in pairs(barDB.buttonKeys) do
			if (barButtonKey == buttonKey) then
				BarButtonDelete(barKey, buttonKey, barButtonIndex)
			end
		end
	end

	-- Update its Bar location
	local buttonDB = AutoBar.buttonDBList[buttonKey]
	buttonDB.barKey = nil

	AutoBar:BarButtonChanged()
end

local function ButtonNew()
	local newButtonName, customButtonKey = AutoBar.Class.Button:GetNewName(L["Custom"])
	AutoBarDB2.account.buttonList[customButtonKey] = {
		name = newButtonName,
		buttonKey = customButtonKey,
		buttonClass = "AutoBarButtonCustom",
		hasCustomCategories = true,
		enabled = true,
	}
	AutoBarDB2.account.buttonList[customButtonKey][1] = "Misc.Hearth"

	AutoBar:ButtonsChanged()
--DevTools_Dump(AutoBarDB2.account.buttonList)
end


local function getAddButtonName(info)
	return nil
end

local function setAddButtonName(info, value)
	local barKey = info.arg.barKey
	local buttonKey = value
	local buttonDB = AutoBar.buttonDBList[buttonKey]

	if (buttonDB.barKey) then
		ButtonRemove(nil, buttonDB.barKey, buttonKey)
	end
	local buttonKeys = AutoBar.barButtonsDBList[barKey].buttonKeys
	buttonKeys[# buttonKeys + 1] = value

	AutoBar:BarButtonChanged()
end

--[[
local function BarReset()
	AutoBar.Class.Bar:OptionsReset()
	AutoBar:BarsChanged()
end
--]]

local function CategoryReset()
	AutoBarDB2.custom_categories = {}
	AutoBar:CategoriesChanged()
end


function AutoBar:CategoryNew()
	local newCategoryName, categoryKey = ABGCode.GetNewCustomCategoryName(L["Custom"], 1)
	local customCategories = AutoBarDB2.custom_categories
	customCategories[categoryKey] = {
		name = newCategoryName,
		desc = newCategoryName,
		categoryKey = categoryKey,
		items = {},
	}
	AutoBarCategoryList[categoryKey] = ABGCode.CustomCategory:new(AutoBarDB2.custom_categories[categoryKey])
	AutoBar:CategoriesChanged()
	return categoryKey
end


local function CategoryDelete(info)
	local categoryKey = info.arg.categoryKey
	local categoriesListDB = AutoBarDB2.custom_categories
--print("CategoryDelete", categoryKey, categoriesListDB[categoryKey])
	categoriesListDB[categoryKey] = nil
	AutoBarCategoryList[categoryKey] = nil
	AutoBar.optionsMain.args.categories.args[categoryKey] = nil
	-- ToDo: remove category references from all Buttons.
	AutoBar:CategoriesChanged()
end
--DevTools_Dump(categoriesListDB)
-- /dump AutoBarDB2.custom_categories

local function CategoryItemNew(info)
	local categoryKey = info.arg.categoryKey
	local itemsListDB = AutoBarDB2.custom_categories[categoryKey].items
	local itemIndex = # itemsListDB + 1
	itemsListDB[itemIndex] = {}
	AutoBar:CategoriesChanged()
end


local otherMacroNames = {}
local function GetNewMacroName(itemsListDB)
	for key in pairs(otherMacroNames) do
		otherMacroNames[key] = nil
	end
	for itemIndex, itemsDB in pairs(itemsListDB) do
		if (itemsDB.itemType == "macroCustom") then
			otherMacroNames[itemsDB.itemId] = true
		end
	end
	local baseName = L["Custom"]
	local newName
	local key_seed = 0
	while true do
		newName = baseName .. key_seed
		key_seed = key_seed + 1
		if (not otherMacroNames[newName]) then
			break
		end
	end
	return newName
end

local function CategoryMacroNew(info)
	local categoryKey = info.arg.categoryKey
	local itemsListDB = AutoBarDB2.custom_categories[categoryKey].items
	local itemIndex = # itemsListDB + 1
	local name = GetNewMacroName(itemsListDB)
	local macroCustom = {
			itemType = "macroCustom",
			itemId = name,
			itemInfo = "",
		}
	itemsListDB[itemIndex] = macroCustom
	AutoBar:CategoriesChanged()
end


local function CategoryItemDelete(info)
	local categoryKey, itemIndex = info.arg.categoryKey, info.arg.itemIndex
	local itemsList = AutoBar.optionsMain.args.categories.args[categoryKey].args.items.args
	local itemsListDB = AutoBarDB2.custom_categories[categoryKey].items
	for i = itemIndex, # itemsListDB, 1 do
		itemsList[itemIndex .. "a"] = itemsList[(i + 1) .. "a"]
		itemsList[itemIndex .. "n"] = itemsList[(i + 1) .. "n"]
		itemsList[itemIndex .. "t"] = itemsList[(i + 1) .. "t"]
		itemsListDB[i] = itemsListDB[i + 1]
	end
	AutoBar:CategoriesChanged()
end

local alignValidateList = {
	["1"] = L["TOPLEFT"],
	["2"] = L["LEFT"],
	["3"] = L["BOTTOMLEFT"],
	["4"] = L["TOP"],
	["5"] = L["CENTER"],
	["6"] = L["BOTTOM"],
	["7"] = L["TOPRIGHT"],
	["8"] = L["RIGHT"],
	["9"] = L["BOTTOMRIGHT"],
}

local popupDirectionValidateList = {
	["1"] = L["TOP"],
	["2"] = L["LEFT"],
	["3"] = L["BOTTOM"],
	["4"] = L["RIGHT"],
}



local function getAutoBarValue(info)
	return AutoBarDB2.settings[info[# info]]
end

local function setAutoBarValue(info, value)
	local setting_name = info[# info]
	AutoBarDB2.settings[setting_name] = value
	AutoBarChanged()
end

local function getTooltipDisabled()
	return not AutoBarDB2.settings.show_tooltip
end

local function getFadeOutDisabled()
	return not AutoBarDB2.settings.fade_out
end


function AutoBar:CreateOptionsAce3()
	local name = "AutoBar"
	if (not AutoBar.optionsMain) then
		AutoBar.optionsMain = {
			type = "group",
			childGroups = "tab",
			args = {
				main = {
					type = "group",
					order = 10,
					name = "AutoBar",
					get = getAutoBarValue,
					set = setAutoBarValue,
					args = {
						header0 = {
							type = "header",
							order = 0,
							name = "AutoBar" .. " " .. AutoBar.version,
						},
						moveBarsMode = {
							type = "execute",
							order = 1,
							width = 1.2,
							name = L["Move the Bars"],
							desc = L["Drag a bar to move it, left click to hide (red) or show (green) the bar, right click to configure the bar."],
							func = AutoBar.MoveBarModeToggle,
							disabled = getCombatLockdown,
						},
						moveButtonsMode = {
							type = "execute",
							order = 2,
							width = 1.2,
							name = L["Move the Buttons"],
							desc = L["Drag a Button to move it, right click to configure the Button."],
							func = AutoBar.MoveButtonsModeToggle,
							disabled = getCombatLockdown,
						},
						keyBoundMode = {
							type = "execute",
							order = 3,
							width = 1.2,
							name = L["Key Bindings"],
							desc = L["Assign Bindings for Buttons on your Bars."],
							func = AB.LibKeyBound.Toggle,
							disabled = getCombatLockdown,
						},
						header1 = {
							type = "header",
							order = 100,
							name = "",
						},
						clamp_bars_to_screen = {
							type = "toggle",
							order = 161,
							width = 1.2,
							name = L["Clamp Bars to screen"],
							desc = L["Clamped Bars can not be positioned off screen"],
						},
						header2 = {
							type = "header",
							order = 300,
							name = "",
						},
						show_empty_buttons = {
							type = "toggle",
							order = 311,
							width = 1.2,
							name = L["Show Empty Buttons"],
							desc = L["Show Empty Buttons for %s"]:format(name),
							tristate = true,
						},
						show_count = {
							type = "toggle",
							order = 321,
							width = 1.2,
							name = L["Show Count Text"],
							desc = L["Show Count Text for %s"]:format(name),
							tristate = true,
						},
						show_hotkey = {
							type = "toggle",
							order = 331,
							width = 1.2,
							name = L["Show Hotkey Text"],
							desc = L["Show Hotkey Text for %s"]:format(name),
							tristate = true,
						},
						show_tooltip = {
							type = "toggle",
							order = 341,
							width = 1.2,
							name = L["Show Tooltips"],
							desc = L["Show Tooltips for %s"]:format(name),
							tristate = true,
						},
						show_tooltip_in_combat = {
							type = "toggle",
							order = 342,
							width = 1.2,
							name = L["Show Tooltips in Combat"],
							tristate = true,
							disabled = getTooltipDisabled,
						},
						self_cast_right_click = {
							type = "toggle",
							order = 361,
							width = 1.2,
							name = L["RightClick SelfCast"],
							desc = L["SelfCast using Right click"],
							tristate = true,
						},
--						popupOnShift = {
--							type = "toggle",
--							order = 371,
--							name = L["Popup on Shift Key"],
--							desc = L["Popup while Shift key is pressed for %s"]:format(name),
--							arg = passValue,
--							tristate = true,
--							--disabled = true,
--						},
						fadeOutSpacer = {
							type = "header",
							order = 400,
							name = L["FadeOut"],
						},
						fade_out = {
							type = "toggle",
							order = 410,
							name = L["FadeOut"],
							desc = L["Fade out the Bar when not hovering over it."],
							arg = passValue,
							tristate = true,
							disabled = getCombatLockdown,
						},

						fadeOutCancelInCombat = {
							type = "toggle",
							order = 412,
							name = L["FadeOut Cancels in combat"],
							desc = L["FadeOut is cancelled when entering combat."],
							arg = passValue,
							tristate = true,
							disabled = getFadeOutDisabled,
						},
						fadeOutCancelOnShift = {
							type = "toggle",
							order = 413,
							name = L["FadeOut Cancels on Shift"],
							desc = L["FadeOut is cancelled when holding down the Shift key."],
							arg = passValue,
							tristate = true,
							disabled = getFadeOutDisabled,
						},
						fadeOutCancelOnCtrl = {
							type = "toggle",
							order = 413,
							name = L["FadeOut Cancels on Ctrl"],
							desc = L["FadeOut is cancelled when holding down the Ctrl key."],
							arg = passValue,
							tristate = true,
							disabled = getFadeOutDisabled,
						},
						fadeOutCancelOnAlt = {
							type = "toggle",
							order = 413,
							name = L["FadeOut Cancels on Alt"],
							desc = L["FadeOut is cancelled when holding down the Alt key."],
							arg = passValue,
							tristate = true,
							disabled = getFadeOutDisabled,
						},
						fadeOutTime = {
							type = "range",
							order = 415,
							name = L["FadeOut Time"],
							desc = L["FadeOut takes this amount of time."],
							min = 0, max = 10, step = 0.1, bigStep = 1,
							arg = passValue,
							disabled = getFadeOutDisabled,
						},
						fadeOutDelay = {
							type = "range",
							order = 416,
							name = L["FadeOut Delay"],
							desc = L["FadeOut starts after this amount of time."],
							min = 0, max = 10, step = 0.1, bigStep = 1,
							arg = passValue,
							disabled = getFadeOutDisabled,
						},
						fadeOutAlpha = {
							type = "range",
							order = 417,
							name = L["FadeOut Alpha"],
							desc = L["FadeOut stops at this Alpha level."],
							min = 0, max = 1, step = 0.01, bigStep = 0.05,
							arg = passValue,
							disabled = getFadeOutDisabled,
						},
						header_debug = {
							type = "header",
							order = 500,
							name = "Advanced/Debug",
						},

						performance = {
							type = "toggle",
							order = 501,
							width = 1.2,
							name = L["Log Performance"],
						},
						log_events = {
							type = "toggle",
							order = 502,
							width = 1.2,
							name = L["Log Events"],
						},
						log_memory = {
							type = "toggle",
							order = 503,
							width = 1.2,
							name = L["Log Memory"],
						},
						handle_spell_changed = {
							type = "toggle",
							order = 504,
							width = 1.2,
							name = "Allow SPELLS_CHANGED",
							desc = "If unchecked some spell-related messages will be ignored. This will improve performance, but may cause side-effects",
						},
						hack_PetActionBarFrame = {
							type = "toggle",
							order = 505,
							width = 1.2,
							name = "Hack PetActionBarFrame",
							desc = "Blizzard's PetActionBarFrame is larger than it looks and can block access to other things near it. When enabled this will make the frame ignore the Mouse",
						},
						log_throttled_events = {
							type = "toggle",
							order = 540,
							width = 1.2,
							name = "Log Throttled Events"
						},
						throttle_event_limit = {
							type = "range",
							order = 541,
							width = 1.2,
							name = "Throttle Event Limit",
							desc = "Events happening faster than this limit are ignored (in seconds)",
							min = 0, max = 5, step = 0.05, bigStep = 0.25,
						},

					}
				},
				categories = {
					type = "group",
					order = 20,
					name = L["Categories"],
					args = {
						categoryNew = {
						    type = "execute",
							order = 1,
						    name = L["New"],
						    desc = L["New"],
						    func = AutoBar.CategoryNew,
						},
						categoryReset = {
							type = "execute",
							order = 2,
							name = L["Reset"],
							desc = L["ResetCategoryDescription"],
							func = CategoryReset,
							disabled = true,
						},
					}
				},
				buttons = {
					type = "group",
					order = 30,
					name = L["Buttons"],
					childGroups = "tree",
					args = {
					}
				},
				bars = {
					type = "group",
					order = 40,
					name = L["Bars"],
					childGroups = "tree",
					args = {
						barNew = {
						    type = "execute",
							order = 1,
						    name = L["New"],
						    desc = L["New"],
						    func = BarNew,
						}
					},
				},
				supporters = {
					type = "group",
					order = 50,
					name = L["Supporters"],
					childGroups = "tree",
					args = {
						header0 = {
							type = "header",
							order = 0,
							name = "AutoBar Supporters",
						},
						supp_text = {
						    type = "description",
							order = 1,
						    name = "Schaufel-Shandris & Thana|n|nFlashback of Shandris, IShiftMyself and Arrtard (Alexstraza), CrzyKidd, Solarious, Nurgle the Wonder Hamster, Joe Jamp, Dahn-Silvermoon, MrUzagi",
						    desc = "Awesome people",
						    fontSize = "medium",
						}
					},
				},
				contributors = {
					type = "group",
					order = 51,
					name = L["Contributors"],
					childGroups = "tree",
					args = {
						header0 = {
							type = "header",
							order = 0,
							name = "AutoBar Contributors",
						},
						cont_text = {
						    type = "description",
							order = 1,
						    name = "Maggz, Sinewyk, Korbl, jasskin",
						    desc = "Helpful people",
						    fontSize = "medium",
						}
					},
				},

				config = {
					type = "execute",
					order = 50,
					name = "AutoBar",
					desc = L["Toggle the config panel"],
					guiHidden = true,
					func = AutoBar.OpenOptions,
				},
			}
		}
	end

	AceCfgReg:RegisterOptionsTable("AutoBar", AutoBar.optionsMain)
	AceCfgCmd:CreateChatCommand(L["SLASHCMD_SHORT"], "AutoBar")
	AceCfgCmd:CreateChatCommand(L["SLASHCMD_LONG"], "AutoBar")

	-- Create Options for Bars and their associated Buttons
	local barOptions = AutoBar.optionsMain.args.bars.args
	local barLayoutDBList = AutoBar.barLayoutDBList
	for barKey, barDB in pairs(barLayoutDBList) do
		if (not L[barKey]) then
			L[barKey] = barDB.name
		end

		-- Ignore bars not marked for our class
		if (barDB["allowed_class"] == "*" or (barDB["allowed_class"] == AutoBar.CLASS)) then
			barOptions[barKey] = self:CreateBarOptions(barKey, barOptions[barKey])

			AceCfgReg:RegisterOptionsTable(barKey, barOptions[barKey])
		end
	end

	-- Trim deleted
	for barKey in pairs(barOptions) do
		if (not barLayoutDBList[barKey] and barKey ~= "barNew" and barKey ~= "barReset") then
			barOptions[barKey] = nil
		end
	end

	AutoBar:CreateButtonOptions(AutoBar.optionsMain.args.buttons.args)
	AutoBar:CreateCustomCategoryOptions(AutoBar.optionsMain.args.categories.args)
end

local frameStrataValidateList = {
	["LOW"] = LOW,
	["MEDIUM"] = L["Medium"],
	["HIGH"] = HIGH,
--	["DIALOG"] = L["Dialog"],
}

local function getBarLayoutValue(info)
	local barKey = info.arg.barKey
	return AutoBar.barLayoutDBList[barKey][info[#info]]
end

local function setBarLayoutValue(info, value)
	local barKey = info.arg.barKey
	local config = AutoBar.barLayoutDBList[barKey]
	config[info[#info]] = value
	AutoBarChanged()
end

local function setAlpha(info, value)
	local barKey = info.arg.barKey
	AutoBar.barLayoutDBList[barKey].alpha = value
	AutoBar.barLayoutDBList[barKey].faded = nil
	AutoBarChanged()
end

local function setFadeOut(info, value)
	local barKey = info.arg.barKey
	AutoBar.barLayoutDBList[barKey].fadeOut = value
	AutoBar.barList[barKey]:SetFadeOut(value)
	AutoBarChanged()
end

local function getFadeOutAlpha(info)
	local barKey = info.arg.barKey
	return AutoBar.barLayoutDBList[barKey].fadeOutAlpha or 0
end


local function getFadeOutTime(info)
	local barKey = info.arg.barKey
	return AutoBar.barLayoutDBList[barKey].fadeOutTime or 10
end


local function getFadeOutDelay(info)
	local barKey = info.arg.barKey
	return AutoBar.barLayoutDBList[barKey].fadeOutDelay or 0
end

local function setFadeOutDelay(info, value)
	local barKey = info.arg.barKey
	if (value == 0) then
		value = nil
	end
	AutoBar.barLayoutDBList[barKey].fadeOutDelay = value
	AutoBarChanged()
end




local function getBarLockdown(info)
	local barKey = info.arg.barKey
	return InCombatLockdown() or not AutoBar.barLayoutDBList[barKey].enabled
end

local function getBarPositionValue(info)
	local barKey = info.arg.barKey
	return AutoBar.barPositionDBList[barKey][info[#info]]
end

local function setBarPositionValue(info, value)
	local barKey = info.arg.barKey
	AutoBar.barPositionDBList[barKey][info[#info]] = value
	AutoBarChanged()
end

local function getSharedValue(info)
	local barKey = info.arg.barKey
	return AutoBar:GetSharedBarDBValue(barKey, info[#info])
end

local function setSharedValue(info, value)
	local barKey = info.arg.barKey
	AutoBar:SetSharedBarDB(barKey, info[#info], value)
	AutoBar:BarButtonChanged()
end

local validBarButtonKeys = {}
-- Creates Options for a Bar and its Buttons
function AutoBar:CreateBarOptions(barKey, existingOptions)
	if (not barKey) then
		return
	end
	local name = L[barKey]
	local barOptions
	local passValue

	if (existingOptions) then
		barOptions = existingOptions
		passValue = barOptions.args.enabled.arg
		passValue["barKey"] = barKey
		barOptions.name = name
	else
		passValue = {["barKey"] = barKey}
		barOptions = {
			type = "group",
			name = name,
			desc = L["Configuration for %s"]:format(name),
			get = getBarLayoutValue,
			set = setBarLayoutValue,
			childGroups = "tree",
			args = {
				enabled = {
					type = "toggle",
					order = 1,
					name = L["Enabled"],
					desc = L["Enable %s."]:format(name),
					disabled = getCombatLockdown,
					arg = passValue,
				},
				hide = {
					type = "toggle",
					order = 2,
					name = L["Hide"],
					desc = L["Hide %s"]:format(name),
					disabled = getCombatLockdown,
					arg = passValue,
				},
				sharedLayout = {
				    type = 'select',
					order = 5,
				    name = L["Shared Layout"],
				    desc = L["Share the Bar Visual Layout"],
					get = getSharedValue,
					set = setSharedValue,
				    values = shareValidateList,
					arg = passValue,
					disabled = getCombatLockdown,
				},
				sharedButtons = {
				    type = 'select',
					order = 6,
				    name = L["Shared Buttons"],
				    desc = L["Share the Bar Button List"],
					get = getSharedValue,
					set = setSharedValue,
				    values = shareValidateList,
					arg = passValue,
					disabled = getCombatLockdown,
				},
				sharedLocation = {
				    type = 'select',
					order = 7,
				    name = L["Shared Position"],
				    desc = L["Share the Bar Position"],
					get = getSharedValue,
					set = setSharedValue,
				    values = shareValidateList,
					arg = passValue,
					disabled = getCombatLockdown,
				},
				newButtonSpacer = {
					type = "header",
					order = 10,
					name = "Buttons",
				},
				newButton = {
				    type = "execute",
					order = 11,
				    name = L["NewButton"],
				    desc = L["NewButtonTooltip"],
				    func = BarButtonNew,
					arg = passValue,
				},
				addButton = {
				    type = 'select',
					order = 12,
				    name = L["Add Button"],
					get = getAddButtonName,
					set = setAddButtonName,
				    values = AutoBar.unplacedButtonList,
					arg = passValue,
				},
				fadeOutSpacer = {
					type = "header",
					order = 13,
					name = L["FadeOut"],
				},
				alpha = {
					type = "range",
					order = 14,
					name = L["Alpha"],
					desc = L["Change the alpha of the bar."],
					min = 0, max = 1, step = 0.01, bigStep = 0.05,
					set = setAlpha,
					arg = passValue,
					disabled = getCombatLockdown,
				},
				fadeOut = {
					type = "toggle",
					order = 15,
					name = L["FadeOut"],
					desc = L["Fade out the Bar when not hovering over it."],
					set = setFadeOut,
					arg = passValue,
					disabled = getCombatLockdown,
				},
				fadeOutCancelInCombat = {
					type = "toggle",
					order = 16,
					name = L["FadeOut Cancels in combat"],
					desc = L["FadeOut is cancelled when entering combat."],
					arg = passValue,
					disabled = getCombatLockdown,
				},
				fadeOutCancelOnShift = {
					type = "toggle",
					order = 17,
					name = L["FadeOut Cancels on Shift"],
					desc = L["FadeOut is cancelled when holding down the Shift key."],
					arg = passValue,
					disabled = getCombatLockdown,
				},
				fadeOutCancelOnCtrl = {
					type = "toggle",
					order = 17,
					name = L["FadeOut Cancels on Ctrl"],
					desc = L["FadeOut is cancelled when holding down the Ctrl key."],
					arg = passValue,
					disabled = getCombatLockdown,
				},
				fadeOutCancelOnAlt = {
					type = "toggle",
					order = 17,
					name = L["FadeOut Cancels on Alt"],
					desc = L["FadeOut is cancelled when holding down the Alt key."],
					arg = passValue,
					disabled = getCombatLockdown,
				},
				fadeOutTime = {
					type = "range",
					order = 18,
					name = L["FadeOut Time"],
					desc = L["FadeOut takes this amount of time."],
					min = 0, max = 10, step = 0.1, bigStep = 1,
					get = getFadeOutTime,
					arg = passValue,
					disabled = getCombatLockdown,
				},
				fadeOutDelay = {
					type = "range",
					order = 19,
					name = L["FadeOut Delay"],
					desc = L["FadeOut starts after this amount of time."],
					min = 0, max = 10, step = 0.1, bigStep = 1,
					get = getFadeOutDelay,
					set = setFadeOutDelay,
					arg = passValue,
					disabled = getCombatLockdown,
				},
				fadeOutAlpha = {
					type = "range",
					order = 20,
					name = L["FadeOut Alpha"],
					desc = L["FadeOut stops at this Alpha level."],
					min = 0, max = 1, step = 0.01, bigStep = 0.05,
					get = getFadeOutAlpha,
--					set = setFadeOutAlpha,
					arg = passValue,
					disabled = getCombatLockdown,
				},
				layoutSpacer = {
					type = "header",
					order = 30,
					name = L["General"],
				},
				rows = {
					type = "range",
					order = 31,
					name = L["Rows"],
					desc = L["Number of rows for %s"]:format(name),
					max = 32, min = 1, step = 1, -- maxbuttons will be adjusted by the bar itself.
					arg = passValue,
					disabled = getBarLockdown,
				},
				columns = {
					type = "range",
					order = 32,
					name = L["Columns"],
					desc = L["Number of columns for %s"]:format(name),
					max = 32, min = 1, step = 1, -- maxbuttons will be adjusted by the bar itself.
					arg = passValue,
					disabled = getBarLockdown,
				},
				padding = {
					type = "range",
					order = 33,
					name = L["Padding"],
					desc = L["Change the padding of the bar."],
					min = -20, max = 30, step = 1,
					arg = passValue,
					disabled = getBarLockdown,
				},
				scale = {
					type = "range",
					order = 35,
					name = L["Scale"],
					desc = L["Change the scale of the bar."],
					min = .1, max = 2, step = 0.01, bigStep = 0.05,
					isPercent = true,
					arg = passValue,
					disabled = getBarLockdown,
				},
				alignButtons = {
				    type = 'select',
					order = 41,
					name = L["Align Buttons"],
					desc = L["Align Buttons"],
				    values = alignValidateList,
					get = getBarPositionValue,
					set = setBarPositionValue,
					arg = passValue,
					disabled = getBarLockdown,
				},
				popupDirection = {
				    type = 'select',
					order = 42,
					name = L["Popup Direction"],
					desc = L["Popup Direction"],
				    values = popupDirectionValidateList,
					arg = passValue,
					disabled = getBarLockdown,
				},
				docking = {
				    type = 'select',
					order = 71,
					name = L["Docked to"],
					desc = L["Docked to"],
				    values = AutoBar.dockingFramesValidateList,
					get = getDocking,
					set = setDocking,
					arg = passValue,
					disabled = getBarLockdown,
				},
				dockShiftX = {
					type = "range",
					order = 72,
					name = L["Shift Dock Left/Right"],
					desc = L["Shift Dock Left/Right"],
					min = -50, max = 50, step = 1, bigStep = 1,
					arg = passValue,
					disabled = getBarLockdown,
				},
				dockShiftY = {
					type = "range",
					order = 73,
					name = L["Shift Dock Up/Down"],
					desc = L["Shift Dock Up/Down"],
					min = -50, max = 50, step = 1, bigStep = 1,
					arg = passValue,
					disabled = getBarLockdown,
				},
				frameStrata = {
				    type = 'select',
					order = 74,
					name = L["Frame Level"],
					desc = L["Adjust the Frame Level of the Bar and its Popup Buttons so they apear above or below other UI objects"],
				    values = frameStrataValidateList,
					set = setFrameStrata,
					arg = passValue,
					disabled = getBarLockdown,
				},
			},
		}
	end

	-- Custom Bar Options
	local barDB = AutoBar.barLayoutDBList[barKey]
	if (barDB.isCustomBar) then
		AutoBar:CreateCustomBarOptions(barKey, barOptions, passValue)
	end

	-- Buttons Config
	wipe(validBarButtonKeys)
	local buttonsOptions = barOptions.args--.buttons.args
	local buttonKeys = AutoBar.barButtonsDBList[barKey].buttonKeys
	for buttonIndex, buttonKey in ipairs(buttonKeys) do
		buttonsOptions[buttonKey] = self:CreateBarButtonOptions(barKey, buttonIndex, buttonKey, buttonsOptions[buttonKey])
		validBarButtonKeys[buttonKey] = true
		if (buttonsOptions[buttonKey]) then
			AceCfgReg:RegisterOptionsTable(buttonKey, buttonsOptions[buttonKey])
		end
	end
	-- Trim excess
	for key in pairs(buttonsOptions) do
		if (not validBarButtonKeys[key] and strmatch(key, "^AutoBar")) then
			buttonsOptions[key] = nil
		end
	end

	return barOptions
end

function AutoBar:CreateCustomBarOptions(barKey, barOptions, passValue)
	if (not barOptions.args.name) then
		barOptions.args.name = {
			type = "input",
			order = 3,
			name = L["Name"],
			usage = L["<Any String>"],
			get = getCustomBarName,
			set = setCustomBarName,
			arg = passValue,
			disabled = getCombatLockdown,
		}
	end

	if (not barOptions.args.delete) then
		barOptions.args.delete = {
		    type = "execute",
			order = 130,
		    name = L["Delete"],
		    func = BarDelete,
			arg = passValue,
			disabled = getCombatLockdown,
		}
	end
end



local function getButtonValue(info)
	local buttonKey = info.arg.buttonKey
	return AutoBar:GetButtonDB(buttonKey)[info[# info]]
end

local function setButtonValue(info, value)
	local buttonKey = info.arg.buttonKey
	AutoBar:GetButtonDB(buttonKey)[info[# info]] = value
	AutoBarChanged()
end


local function getButtonShare(info)
	local buttonKey = info.arg.buttonKey
	return AutoBar:GetSharedButtonDBValue(buttonKey)
end

local function setButtonShare(info, value)
	local buttonKey = info.arg.buttonKey

	AutoBar:SetSharedButtonDB(buttonKey, value)
	AutoBar:BarButtonChanged()
end


local function getBarLocation(info)
	local buttonKey = info.arg.buttonKey
	local barKey = AutoBar.buttonDBList[buttonKey].barKey

	return barKey or ""
end

local function setBarLocation(info, value)
	if (value == "") then
		ButtonRemove(info)
	else
		local buttonKey = info.arg.buttonKey
		ButtonRemove(info)

		local barKey = value
		local buttonKeys = AutoBar.barButtonsDBList[barKey].buttonKeys
		buttonKeys[# buttonKeys + 1] = buttonKey
	end

	AutoBar:BarButtonChanged()
end

local function CategoryAdd(info)
	local buttonKey = info.arg.buttonKey
	local buttonDB = AutoBar:GetButtonDB(buttonKey)
	local buttonCategoryIndex = # buttonDB + 1
	buttonDB[buttonCategoryIndex] = "Misc.Hearth"
	AutoBar:BarButtonChanged()
end


function AutoBar:CreateBarButtonOptions(barKey, buttonIndex, buttonKey, existingConfig)
	local buttonDB = AutoBar:GetButtonDB(buttonKey)
	if (not buttonDB) then
		return existingConfig
	end
	local name = ABGCode.GetButtonDisplayName(buttonDB)

	local passValue
	if (existingConfig) then
		passValue = existingConfig.args.shuffle.arg
		passValue["barKey"] = barKey
		passValue["buttonIndex"] = buttonIndex
		passValue["buttonKey"] = buttonKey
		existingConfig.name = name
	else
		passValue = {["barKey"] = barKey, ["buttonIndex"] = buttonIndex, ["buttonKey"] = buttonKey}
		existingConfig = {
			type = "group",
			order = buttonIndex,
			name = name,
			desc = L["Configuration for %s"]:format(name),
			get = getButtonValue,
			set = setButtonValue,
			args = {
				enabled = {
					type = "toggle",
					order = 1,
					name = L["Enabled"],
					desc = L["Enable %s."]:format(name),
					arg = passValue,
					disabled = getCombatLockdown,
				},
				share = {
					type = 'select',
					order = 2,
					name = L["Shared"],
					desc = L["Share the config"],
					get = getButtonShare,
					set = setButtonShare,
					values = shareValidateList,
					arg = passValue,
					disabled = getCombatLockdown,
				},
				barLocation = {
					type = 'select',
					order = 3,
					name = L["Bar Location"],
					desc = L["Bar the Button is located on"],
					get = getBarLocation,
					set = setBarLocation,
					values = AutoBar.barValidateList,
					arg = passValue,
					disabled = getCombatLockdown,
				},
				header1 = {
					type = "header",
					order = 9,
					name = "",
				},
				arrangeOnUse = {
					type = "toggle",
					order = 10,
					name = L["Rearrange Order on Use"],
					desc = L["Rearrange Order on Use for %s"]:format(name),
					set = setButtonArrangeOnUse,
					arg = passValue,
					disabled = getCombatLockdown,
					width = 1.25,
				},
				shuffle = {
					type = "toggle",
					order = 11,
					name = L["Shuffle"],
					desc = L["Shuffle replaces depleted items during combat with the next best item"],
					arg = passValue,
					disabled = getCombatLockdown,
					width = 1.25,
				},
				drag = {
					type = "toggle",
					order = 12,
					name = L["Drag"],
					desc = L["Drag to move items, spells or macros using the Cursor"],
					arg = passValue,
					disabled = getCombatLockdown,
					width = 1.25,
				},
				drop = {
					type = "toggle",
					order = 13,
					name = L["Drop"],
					desc = L["Drop items, spells or macros onto Button to add them to its top Custom Category"],
					arg = passValue,
					disabled = getCombatLockdown,
					width = 1.25,
				},
				hide = {
					type = "toggle",
					order = 14,
					name = L["Hide"],
					desc = L["Hide %s"]:format(name),
					arg = passValue,
					disabled = getCombatLockdown,
					width = 1.25,
				},
				alwaysPopup = {
					type = "toggle",
					order = 15,
					name = L["Always Popup"],
					desc = L["Always keep Popups open for %s"]:format(name),
					arg = passValue,
					disabled = getCombatLockdown,
					width = 1.25,
				},
--				popupOnShift = {
--					type = "toggle",
--					order = 16,
--					name = L["Popup on Shift Key"],
--					desc = L["Popup while Shift key is pressed for %s"]:format(name),
--					arg = passValue,
--					disabled = getCombatLockdown,
--					width = 1.25,
--				},
				noPopup = {
					type = "toggle",
					order = 17,
					name = L["No Popup"],
					desc = L["No Popup for %s"]:format(name),
					arg = passValue,
					disabled = getCombatLockdown,
					width = 1.25,
				},
				alwaysShow = {
					type = "toggle",
					order = 18,
					name = L["Always Show"],
					desc = L["Always Show %s, even if empty."]:format(name),
					arg = passValue,
					disabled = getCombatLockdown,
					width = 1.25,
				},
				rightClickTargetsPet = {
					type = "toggle",
					order = 20,
					name = L["Right Click Targets Pet"],
					desc = L["Right Click Targets Pet"],
					arg = passValue,
					disabled = getCombatLockdown,
					width = 1.25,
				},
				square_popups = {
					type = "toggle",
					order = 21,
					name = L["Square Popups"],
					desc = L["Square Popups Desc"],
					arg = passValue,
					disabled = getCombatLockdown,
					width = 1.25,
				},
				max_popup_height = {
					type = "range",
					max = 32, min = 1, step = 1,
					order = 22,
					name = L["Max Popup Height"],
					desc = L["Max Popup Height Desc"],
					arg = passValue,
					disabled = getCombatLockdown,
					width = "full",
				},
			},
		}
	end

	local buttonClass = AutoBar.buttonList[buttonKey] or AutoBar.buttonListDisabled[buttonKey]
	if (buttonClass) then
		buttonClass:AddOptions(existingConfig.args, passValue)
	end

	-- Delete option for Custom Buttons
	if (buttonDB.buttonClass == "AutoBarButtonCustom") then
		if (not existingConfig.args.name) then
			existingConfig.args.name = {
				type = "input",
				order = 0,
				name = L["Name"],
				usage = L["<Any String>"],
				width = "full",
				get = getCustomButtonName,
				set = setCustomButtonName,
				arg = passValue,
				disabled = getCombatLockdown,
			}
		end
		if (not existingConfig.args.delete) then
			existingConfig.args.delete = {
			    type = "execute",
				order = 5,
			    name = L["Delete"],
			    desc = L["Delete this Custom Button completely"],
			    func = ButtonDelete,
				arg = passValue,
				disabled = getCombatLockdown,
			}
		end
	end

	-- Remove option for Buttons on a Bar
	if (not existingConfig.args.remove) then
		existingConfig.args.remove = {
		    type = "execute",
			order = 4,
		    name = L["Remove"],
		    desc = L["Remove this Button from the Bar"],
		    func = ButtonRemove,
			arg = passValue,
			disabled = getCombatLockdown,
		}
	end

	if (buttonDB.hasCustomCategories) then
		if (not existingConfig.args.categories) then
			existingConfig.args.categoriesSpacer = {
				type = "header",
				order = -4,
				name = "",
			}
			existingConfig.args.categories = {
				type = "group",
				order = -3,
				name = L["Categories"],
				desc = L["Categories for %s"]:format(name),
				args = {
					newCategory = {
					    type = "execute",
						order = 0,
					    name = L["New"],
					    desc = L["New"],
					    func = CategoryAdd,
						arg = passValue,
					},
					categorySpacer = {
						type = "header",
						order = 1,
						name = "",
					},
				}
			}
		end
		self:CreateButtonCategoryOptions(barKey, buttonIndex, existingConfig.args.categories.args, buttonKey)
	end

	return existingConfig
end


local function getButtonCategory(p_info)
	local button_key, category_index = p_info.arg.buttonKey, p_info.arg.categoryIndex
	local buttonDB = AutoBar:GetButtonDB(button_key)

	return buttonDB[category_index]
end

local function setButtonCategory(p_info, p_value)
	local button_key, category_index = p_info.arg.buttonKey, p_info.arg.categoryIndex
	local buttonDB = AutoBar:GetButtonDB(button_key)
	buttonDB[category_index] = p_value

	AutoBar:BarButtonChanged()
end

local function CategoryRemove(info)
	local buttonKey, categoryIndex = info.arg.buttonKey, info.arg.categoryIndex
	local buttonDB = AutoBar:GetButtonDB(buttonKey)

	for i = categoryIndex, # buttonDB, 1 do
		buttonDB[i] = buttonDB[i + 1]
	end

	AutoBar:BarButtonChanged()
end

local function getKeysSortedByValue(tbl, sortFunction)	--TODO: Move this to the global space
  local keys = {}
  for key in pairs(tbl) do
    table.insert(keys, key)
  end

  table.sort(keys, function(a, b)
    return sortFunction(tbl[a], tbl[b])
  end)

  return keys
end

local validCategoryKeys = {}
function AutoBar:CreateButtonCategoryOptions(barKey, buttonIndex, categoryOptions, buttonKey)
--print("AutoBar:CreateButtonCategoryOptions barKey:", barKey, "buttonIndex:", buttonIndex)
	if (not AutoBarCategoryList) then
		return
	end
	assert(buttonKey, "AutoBar:CreateButtonCategoryOptions nil buttonKey")

	wipe(validCategoryKeys)
	validCategoryKeys.newCategory = true
	validCategoryKeys.categorySpacer = true

	local categoryList = AutoBar:GetButtonDB(buttonKey)
	for categoryIndex, categoryKey in ipairs(categoryList) do
		local categoryInfo = AutoBarCategoryList[categoryKey]
		if (not categoryInfo) then
			-- Missing Category, change to Misc.Hearth
			-- ToDo: or maybe some kind of blank category?
			categoryInfo = AutoBarCategoryList["Misc.Hearth"]
		end
		if (not categoryInfo) then
			return
		end

		local name = categoryInfo.description or L["Custom"]
		local passValue
		local keyCategory = categoryIndex .. "C"
		local keyDelete = categoryIndex .. "D"
		validCategoryKeys[keyCategory] = true
		validCategoryKeys[keyDelete] = true
		if (categoryOptions[keyCategory]) then
			passValue = categoryOptions[keyCategory].arg
			categoryOptions[keyCategory].name = name
		else
			passValue = {["barKey"] = barKey, ["buttonKey"] = buttonKey, ["buttonIndex"] = buttonIndex, ["categoryIndex"] = categoryIndex, ["categoryKey"] = categoryKey}
			local sortedKeys = getKeysSortedByValue(AutoBar.categoryValidateList, function(a, b) return a < b end)
			categoryOptions[keyCategory] = {
				order = categoryIndex * 2,
				type = 'select',
				name = L["Category"],
				desc = L["Category"],
				width = "double",
				get = getButtonCategory,
				set = setButtonCategory,
				values = AutoBar.categoryValidateList,
				sorting = sortedKeys,
				arg = passValue,
			}
			categoryOptions[keyDelete] = {
				order = categoryIndex * 2 + 1,
			    type = "execute",
			    name = L["Delete"],
			    desc = L["Delete"],
			    width = "half",
			    func = CategoryRemove,
				arg = passValue,
				disabled = getCombatLockdown,
			}
		end
		passValue.buttonIndex = buttonIndex
		passValue.buttonKey = buttonKey
		passValue.categoryKey = categoryKey
	end

	-- Trim excess
	for key in pairs(categoryOptions) do
		if (not validCategoryKeys[key]) then
			categoryOptions[key] = nil
		end
	end
end


-- Create Button Options for those that do not exist yet
function AutoBar:CreateButtonOptions(options)
	local buttonDBList = AutoBar.buttonDBList
	if (not buttonDBList) then
		return
	end
	if (not options["newButton"]) then
		options["newButton"] = {
		    type = "execute",
			order = 1,
		    name = L["NewButton"],
		    desc = L["NewButtonTooltip"],
		    func = ButtonNew,
		}
	end
--[[
	if (not options["reset"]) then
		options["reset"] = {
		    type = "execute",
			order = 2,
		    name = L["Reset"],
		    desc = L["Reset"],
		    func = CustomButtonReset,
		}
	end
--]]
	for buttonKey, _buttonDB in pairs(buttonDBList) do
		options[buttonKey] = AutoBar:CreateBarButtonOptions(nil, nil, buttonKey, options[buttonKey])
	end

	-- Trim excess
	for buttonKey in pairs(options) do
		if (not buttonDBList[buttonKey] and buttonKey ~= "newButton" and buttonKey ~= "reset") then
			options[buttonKey] = nil
		end
	end
end



local function getCategoryValue(info)
	local categoryKey = info.arg.categoryKey
	return ABGCode.GetCategoryDB(categoryKey)[info[# info]]
end

local function setCategoryValue(info, value)
	local categoryKey = info.arg.categoryKey
	ABGCode.GetCategoryDB(categoryKey)[info[# info]] = value
	AutoBar:CategoriesChanged()
end

local function setCategoryName(info, value)
	value = ABGCode.GetValidatedName(value)
	if (value and value ~= "") then
		local categoryKey = info.arg.categoryKey
		local categoryInfo = AutoBarCategoryList[categoryKey]
		local newName = categoryInfo:ChangeName(value)
		if (newName == value) then
		-- ToDo: If name did not change toss an error message?
			AutoBar:BarButtonChanged()
		end
	end
end

local function getCategoryItem(info)
	local categoryKey, itemIndex = info.arg.categoryKey, info.arg.itemIndex
	local itemDB = AutoBar:GetCategoriesItemDB(categoryKey, itemIndex)
	local value
	local itemType = itemDB.itemType
	if (itemType == "item") then
		value = itemDB.value or ("item:" .. itemDB.itemId)
	elseif (itemType == "spell") then
		value = itemDB.value or itemDB.spellName
	elseif (itemType == "macro") then
		value = itemDB.value or ("macro:" .. itemDB.itemInfo)
	elseif (itemType == "macroCustom") then
		value = itemDB.value or ("macroCustom:" .. (itemDB.texture or ""))
	end

--SetUserData = function(self, key, value)
--GetUserData = function(self, key)

	return value
end

local function setCategoryItem(info, value, ...)
	local categoryKey, itemIndex = info.arg.categoryKey, info.arg.itemIndex
	local itemDB = AutoBar:GetCategoriesItemDB(categoryKey, itemIndex)
	if (value == "SWAP") then
		local sourceIndex = ...
		local sourceItemDB = AutoBar:GetCategoriesItemDB(categoryKey, sourceIndex)
--print("setCategoryItem SWAP sourceIndex:", sourceIndex, "targetIndex:", itemIndex, sourceItemDB.value, "->", itemDB.value, " <> ", sourceItemDB.itemType, "->", itemDB.itemType)
		sourceItemDB.itemType, itemDB.itemType = itemDB.itemType, sourceItemDB.itemType
		sourceItemDB.value, itemDB.value = itemDB.value, sourceItemDB.value
		sourceItemDB.itemId, itemDB.itemId = itemDB.itemId, sourceItemDB.itemId
		sourceItemDB.itemInfo, itemDB.itemInfo = itemDB.itemInfo, sourceItemDB.itemInfo
		sourceItemDB.spellName, itemDB.spellName = itemDB.spellName, sourceItemDB.spellName
		sourceItemDB.spellClass, itemDB.spellClass = itemDB.spellClass, sourceItemDB.spellClass
		sourceItemDB.texture, itemDB.texture = itemDB.texture, sourceItemDB.texture
	elseif (value) then
		if (value == "DELETE") then
			CategoryItemDelete(info)
		elseif (itemDB.itemType == "macroCustom") then
			-- ToDo: Only grab the texture
			local _dragLinkType, _info1, _info2, texture = ...
			itemDB.texture = texture
		elseif (value:find("item:%d+")) then
			itemDB.itemType = "item"
			itemDB.value = value
			itemDB.itemId = value:match("item:(%d+)")
		elseif (strsub(value, 1, 6) == "macro:") then
			itemDB.itemType = "macro"
			itemDB.value = value
			itemDB.itemId = strsub(value, 7)
		elseif (value ~= "") then
			itemDB.itemType = "spell"
			itemDB.value = value
		end
	end
	AutoBar:CategoriesChanged()
end

local function getCategoryMacroName(info)
	local categoryKey, itemIndex = info.arg.categoryKey, info.arg.itemIndex
	return ABGCode.GetCategoryItemDB(categoryKey, itemIndex).itemId
end

local function setCategoryMacroName(info, value)
	value = ABGCode.GetValidatedName(value)
	if (value and value ~= "") then
		local newName = value--categoryInfo:ChangeName(value)
		if (newName == value) then
			local categoryKey, itemIndex = info.arg.categoryKey, info.arg.itemIndex
			ABGCode.GetCategoryItemDB(categoryKey, itemIndex).itemId = newName
			AutoBar:BarButtonChanged()
		end
	end
end


local function getCategoryMacroText(info)
	local categoryKey, itemIndex = info.arg.categoryKey, info.arg.itemIndex
	return ABGCode.GetCategoryItemDB(categoryKey, itemIndex).itemInfo
end

local function setCategoryMacroText(info, value)
	local categoryKey, itemIndex = info.arg.categoryKey, info.arg.itemIndex
	ABGCode.GetCategoryItemDB(categoryKey, itemIndex).itemInfo = value
	AutoBar:BarButtonChanged()
end



--local deleteIcon = "Interface\\Icons\\INV_Enchant_VoidSphere"
local validCustomCategoryKeys = {}

-- Create CustomCategoryOptions for those that do not exist yet
-- Also refresh the item list for each
function AutoBar:CreateCustomCategoryOptions(options)
	local customCategories = AutoBarDB2.custom_categories

	if (not customCategories) then
		return
	end

	for categoryKey, categoryDB in pairs(customCategories) do
		local name = categoryDB.name or L["Custom"]
		local passValue
		if (options[categoryKey]) then
			options[categoryKey].name = name
		else
			passValue = {["categoryKey"] = categoryKey}
			options[categoryKey] = {
				type = "group",
				order = 10,
				name = name,
				desc = L["Configuration for %s"]:format(name),
				get = getCategoryValue,
				set = setCategoryValue,
				args = {
					name = {
						type = "input",
						order = 1,
						name = L["Name"],
						usage = L["<Any String>"],
						width = "full",
						get = getCategoryValue,
						set = setCategoryName,
						arg = passValue,
						disabled = getCombatLockdown,
					},
					spacer1 = {
						type = "header",
						order = 2,
						name = "",
					},
					battleground = {
						type = "toggle",
						order = 3,
						name = L["Battlegrounds only"],
						arg = passValue,
						disabled = getCombatLockdown,
					},
					nonCombat = {
						type = "toggle",
						order = 5,
						name = L["Non Combat Only"],
						arg = passValue,
						disabled = getCombatLockdown,
					},
					targeted = {
						type = "toggle",
						order = 7,
						name = L["Targeted"],
						width = "full",
						arg = passValue,
						disabled = getCombatLockdown,
--ToDo: targeted = false,"PET", shield & chest etc
					},
					spacer2 = {
						type = "header",
						order = 8,
						name = "",
					},
					delete = {
					    type = "execute",
						order = 9,
					    name = L["Delete"],
					    func = CategoryDelete,
						arg = passValue,
						disabled = getCombatLockdown,
					},
					items = {
						type = "group",
						name = L["Items"],
						args = {
--							newCategoryItem = {
--							    type = "execute",
--								order = 0,
--							    name = L["New"],
--							    func = CategoryItemNew,
--								arg = passValue,
--							},
							newCategoryMacro = {
							    type = "execute",
								order = 1,
							    name = L["New Macro"],
							    func = CategoryMacroNew,
								arg = passValue,
							},
							spacerCategoryItem = {
								type = "header",
								order = 3,
								name = L["Items"],
							},
						},
					},
				},
			}
		end

		local items = options[categoryKey].args.items.args
		wipe(validCustomCategoryKeys)
		for itemIndex, itemDB in ipairs(customCategories[categoryKey].items) do
			local name
			if (itemDB.itemType == "item") then
				if (itemDB.itemId and itemDB.itemId ~= 0) then
					name = GetItemInfo(itemDB.itemId)
				end
			elseif (itemDB.itemType == "spell") then
				if (itemDB.spellName) then
					name = itemDB.spellName
				end
			elseif (itemDB.itemType == "macro") then
				if (itemDB.itemId) then
					name = GetMacroInfo(itemDB.itemId)
				end
			elseif (itemDB.itemType == "macroCustom") then
				if (itemDB.itemId) then
					name = itemDB.itemId
				end
			end
			if (not name) then
				name = tostring(itemIndex)
			end

			local itemKey = itemIndex .. "a"
			validCustomCategoryKeys[itemKey] = true
			if (items[itemKey]) then
				items[itemKey].name = name
				passValue = items[itemKey].arg
				passValue.categoryKey = categoryKey
				passValue.itemIndex = itemIndex
			else
				passValue = {["categoryKey"] = categoryKey, ["itemIndex"] = itemIndex}
				items[itemKey] = {
					type = "input",
					order = itemIndex * 4,
					dialogControl = "DragLink",
					name = "",
					width = "half",
					get = getCategoryItem,
					set = setCategoryItem,
					arg = passValue,
				}
			end

			local nameKey = itemIndex .. "n"
			local textKey = itemIndex .. "t"
			if (itemDB.itemType == "macroCustom") then
				validCustomCategoryKeys[nameKey] = true
				validCustomCategoryKeys[textKey] = true
				if (items[nameKey]) then
					items[nameKey].order = itemIndex * 4 + 2
				else
					items[nameKey] = {
						type = "input",
						order = itemIndex * 4 + 2,
						name = L["Name"],
						usage = L["<Any String>"],
						get = getCategoryMacroName,
						set = setCategoryMacroName,
						arg = passValue,
						disabled = getCombatLockdown,
					}
				end
				if (items[textKey]) then
					items[textKey].order = itemIndex * 4 + 3
				else
					items[textKey] = {
						type = "input",
						order = itemIndex * 4 + 3,
						name = L["Macro Text"],
						usage = L["<Any String>"],
						multiline = true,
						width = "full",
						get = getCategoryMacroText,
						set = setCategoryMacroText,
						arg = passValue,
						disabled = getCombatLockdown,
					}
				end
			else
				items[nameKey] = nil
				items[textKey] = nil
			end
		end
		-- Trim excess
		for key in pairs(items) do
			if (not validCustomCategoryKeys[key] and key ~= "newCategoryItem" and key ~= "newCategoryMacro" and key ~= "spacerCategoryItem") then
				items[key] = nil
			end
		end
	end

	-- Trim excess
	for categoryKey in pairs(options) do
		if (not customCategories[categoryKey] and categoryKey ~= "categoryNew" and categoryKey ~= "categoryReset") then
			options[categoryKey] = nil
		end
	end
--]]
end
--[[
/dump AutoBarDB2.custom_categories["CustomArrangeTest"].items
--]]


function AutoBar:ButtonInsert(barDB, buttonDB)
	for buttonDBIndex, aButtonDB in ipairs(barDB.buttons) do
		if (aButtonDB.buttonKey == buttonDB.defaultButtonIndex) then
			table.insert(barDB.buttons, buttonDBIndex + 1, AutoBar:ButtonPopulate(buttonDB))
			return nil
		end
	end
	return buttonDB
end

function AutoBar:ButtonPopulate(buttonDB)
	local newButtonDB = {}
	-- ToDo: Upgrade if there is ever a table inside
	for key, value in pairs(buttonDB) do
		newButtonDB[key] = value
	end
	buttonDB.place = false

	newButtonDB.barKey = nil
	newButtonDB.defaultButtonIndex = nil
	newButtonDB.place = nil
	return newButtonDB
end



--[[
/dump GetItemIcon("item:6948")
/script PickupSpellBookItem("Healing Wave")
/script PickupSpellBookItem("spell:2645")
/script PickupItem(6948)
/script PickupItem("item:6948")
/script PickupItem("Hearthstone")
/script PickupItem(GetContainerItemLink(0, 1))
/script PickupMacro(1)
--]]