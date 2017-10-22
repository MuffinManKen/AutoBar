--[[
Name: AutoBar
Author: Toadkiller of Proudmoore
Credits: Saien the original author.  Sayclub (Korean), PDI175 (Chinese traditional and simplified), Teodred (German), Cinedelle (French), shiftos (Spanish)
Website: http://www.wowace.com/
Description: Dynamic 24 button bar automatically adds potions, water, food and other items you specify into a button for use. Does not use action slots so you can save those for spells and abilities.
--]]
--
-- Copyright 2004 - 2006 original author.
-- New Stuff Copyright 2006-2009 Toadkiller of Proudmoore.
-- New Stuff Copyright 2009- MuffinManKen

-- Maintained by MuffinManKen.  Original author Saien of Hyjal
-- http://muffinmangames.com



--
-- The Update Cycle / Hierarchy
--

-- Initialize
-- UpdateCategories
-- UpdateCustomBars
-- UpdateCustomButtons
-- UpdateSpells
-- UpdateObjects
-- UpdateRescan
-- UpdateScan
-- UpdateAttributes
-- UpdateActive
-- UpdateButtons

-- In normal operation after one each of UpdateCategories through UpdateObjects, only UpdateRescan & down are required.
-- The Update functions can be called directly or via AutoBar.delay["UpdateButtons"].
-- Delayed calls allow multiple updates to clump & get dealt with at once, especially after combat ends.

local LibKeyBound = LibStub("LibKeyBound-1.0")
local LibStickyFrames = LibStub("LibStickyFrames-2.0")
local AceOO = AceLibrary("AceOO-2.0")
local AceEvent = AceLibrary("AceEvent-2.0")
local Masque = LibStub("Masque", true)
local AceCfgDlg = LibStub("AceConfigDialog-3.0")
local L
local _

AutoBar = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceHook-2.1");

local AutoBar = AutoBar

-- List of [spellName] = <GetSpellInfo Name>
AutoBar.spellNameList = {}
-- List of [spellName] = <GetSpellInfo Icon>
AutoBar.spellIconList = {}

AutoBar.events = {}

AutoBar.delay = {}

AutoBarMountIsQiraji = {[25953] = 1;[26056] = 1;[26054] = 1; [26055] = 1}

AutoBar.warning_log = {}

AutoBar.visibility_driver_string = "[vehicleui] hide; [petbattle] hide; [possessbar] hide; show"


WHATSNEW_TEXT = "" ..
[[
 - Updated data libraries
 - Mounts button should remember last used mount
 - Added better handling of Class mounts for Warlocks (TODO: Other classes)
]] .. "|n"




--/run AutoBar:FrameInsp(ActionButton3)
function AutoBar:FrameInsp(p_frame) --AutoBarButtonExplosiveFrame

	local frame = p_frame

	print("Type:", frame:GetAttribute("type"),"type1:", frame:GetAttribute("type1"), "type2:", frame:GetAttribute("type2"), "ItemID:", frame:GetAttribute("itemID"), "Category:", frame:GetAttribute("category") )
	print("Item:", frame:GetAttribute("item"))
	print("State:", frame:GetAttribute("state"))
	print("Attribute:", frame:GetAttribute("attribute"))
	print("Action:", frame:GetAttribute("action"),"Action1:", frame:GetAttribute("action1"), "Action2:", frame:GetAttribute("action2"), "ActionPage:", frame:GetAttribute("actionpage"))
	print("Macro:", frame:GetAttribute("macro"), "MacroText:", frame:GetAttribute("macrotext"))
	print("Spell:", frame:GetAttribute("spell"), "Spell1:", frame:GetAttribute("spell1"), "Spell2:", frame:GetAttribute("spell2"))
	print("Unit:", frame:GetAttribute("unit"), "HelpButton:", frame:GetAttribute("helpbutton"), "harmbutton:", frame:GetAttribute("harmbutton"))

end


function AutoBar:GetSpellNameByName(p_name)

	if (AutoBar.spellNameList[p_name]) then
		return AutoBar.spellNameList[p_name]
	end

	AutoBar:Print("Unknown Spell Name:" .. p_name)

	return nil
end

-- Process a macro to determine what its "action" is:
--		a spell
--		an item
function AutoBar:GetActionForMacroBody(p_macro_body)
	local debug = false
	local action
	local tooltip
	local icon

	--print(debugstack())
	local show_action = string.match(p_macro_body, "#show%s+([^\n]+)")
	if(show_action) then
		action = show_action
	else
		local show_tt_action = string.match(p_macro_body, "#showtooltip%s+([^\n]+)")
		if(show_tt_action) then
			action = show_tt_action
			tooltip = GetSpellLink(action) or select(2,GetItemInfo(action))
		end
	end
	
	if(not action) then
		local cast_action = string.match(p_macro_body, "/cast%s+([^\n]+)")

		local use_action = string.match(p_macro_body, "/use%s+([^\n]+)")

		if(cast_action or use_action) then
			action = SecureCmdOptionParse(cast_action or use_action)
			
			--if there are qualifiers on the action (like [mounted]) and they all parse away, it returns null
			if(action) then
				tooltip = GetSpellLink(action) or select(2, GetItemInfo(action))
			end
		end

	end

	if(action) then 
		icon = select(3, GetSpellInfo(action)) or select(10, GetItemInfo(action))
	end

	return action, icon, tooltip
end


function AutoBar:IsInLockDown()

	return AutoBar.inCombat or InCombatLockdown() or C_PetBattles.IsInBattle() or UnitInVehicle("player")

end


function AutoBar:ConfigToggle()
	if (not InCombatLockdown()) then
			AutoBar:OpenOptions()
	end
end


function AutoBar:OnInitialize()
	L = AutoBar.locale
	BINDING_HEADER_AUTOBAR_SEP = L["AutoBar"];
	BINDING_NAME_AUTOBAR_CONFIG = L["CONFIG_WINDOW"];

	BINDING_HEADER_AutoBarButtonHeader = L["AutoBarButtonHeader"]
	BINDING_NAME_AutoBarButtonHearth_X = L["AutoBarButtonHearth"]
	BINDING_NAME_AutoBarButtonMount_X = L["AutoBarButtonMount"]
	BINDING_NAME_AutoBarButtonBandages_X = L["AutoBarButtonBandages"]
	BINDING_NAME_AutoBarButtonCrafting_X = L["AutoBarButtonCrafting"]
	BINDING_NAME_AutoBarButtonHeal_X = L["AutoBarButtonHeal"]
	BINDING_NAME_AutoBarButtonRecovery_X = L["AutoBarButtonRecovery"]
	BINDING_NAME_AutoBarButtonFood_X = L["AutoBarButtonFood"]
	BINDING_NAME_AutoBarButtonWater_X = L["AutoBarButtonWater"]
	BINDING_NAME_AutoBarButtonFoodBuff_X = L["AutoBarButtonFoodBuff"]
	BINDING_NAME_AutoBarButtonFoodCombo_X = L["AutoBarButtonFoodCombo"]
	BINDING_NAME_AutoBarButtonBuff_X = L["AutoBarButtonBuff"]
	BINDING_NAME_AutoBarButtonBuffWeapon1_X = L["AutoBarButtonBuffWeapon1"]

	BINDING_HEADER_AutoBarClassBarExtras = L["AutoBarClassBarExtras"]
	BINDING_NAME_AutoBarButtonCharge_X = L["AutoBarButtonCharge"]
	BINDING_NAME_AutoBarButtonClassBuff_X = L["AutoBarButtonClassBuff"]
	BINDING_NAME_AutoBarButtonShields_X = L["AutoBarButtonShields"]
	BINDING_NAME_AutoBarButtonClassPet_X = L["AutoBarButtonClassPet"]
	BINDING_NAME_AutoBarButtonFreeAction_X = L["AutoBarButtonFreeAction"]
	BINDING_NAME_AutoBarButtonER_X = L["AutoBarButtonER"]
	BINDING_NAME_AutoBarButtonExplosive_X = L["AutoBarButtonExplosive"]
	BINDING_NAME_AutoBarButtonFishing_X = L["AutoBarButtonFishing"]
	BINDING_NAME_AutoBarButtonBattleStandards_X = L["AutoBarButtonBattleStandards"]
	BINDING_NAME_AutoBarButtonTrinket1_X = L["AutoBarButtonTrinket1"]
	BINDING_NAME_AutoBarButtonTrinket2_X = L["AutoBarButtonTrinket2"]
	BINDING_NAME_AutoBarButtonPets_X = L["AutoBarButtonPets"]
	BINDING_NAME_AutoBarButtonQuest_X = L["AutoBarButtonQuest"]
	BINDING_NAME_AutoBarButtonMiscFun_X = L["AutoBarButtonMiscFun"]
	BINDING_NAME_AutoBarButtonGuildSpell_X = L["AutoBarButtonGuildSpell"]
	BINDING_NAME_AutoBarButtonSpeed_X = L["AutoBarButtonSpeed"]
	BINDING_NAME_AutoBarButtonStance_X = L["AutoBarButtonStance"]
	BINDING_NAME_AutoBarButtonStealth_X = L["AutoBarButtonStealth"]
	BINDING_NAME_AutoBarButtonSunsongRanch_X = L["AutoBarButtonSunsongRanch"]
	BINDING_NAME_AutoBarButtonGarrison_X = L["AutoBarButtonGarrison"]
	BINDING_NAME_AutoBarButtonOrderHall_X = L["AutoBarButtonOrderHall"]

--	BINDING_NAME_AutoBarButtonToyBox_X = L["AutoBarButtonToyBox"]

	BINDING_HEADER_AutoBarCooldownHeader = L["AutoBarCooldownHeader"]
	BINDING_NAME_AutoBarButtonCooldownDrums_X = L["AutoBarButtonCooldownDrums"]
	BINDING_NAME_AutoBarButtonCooldownPotionCombat_X = L["AutoBarButtonCooldownPotionCombat"]
	BINDING_NAME_AutoBarButtonCooldownPotionHealth_X = L["AutoBarButtonCooldownPotionHealth"]
	BINDING_NAME_AutoBarButtonCooldownStoneHealth_X = L["AutoBarButtonCooldownStoneHealth"]
	BINDING_NAME_AutoBarButtonCooldownPotionMana_X = L["AutoBarButtonCooldownPotionMana"]
	BINDING_NAME_AutoBarButtonCooldownStoneMana_X = L["AutoBarButtonCooldownStoneMana"]
	BINDING_NAME_AutoBarButtonCooldownPotionRejuvenation_X = L["AutoBarButtonCooldownPotionRejuvenation"]
	BINDING_NAME_AutoBarButtonCooldownStoneRejuvenation_X = L["AutoBarButtonCooldownStoneRejuvenation"]

	BINDING_HEADER_AutoBarClassBarHeader = L["AutoBarClassBarHeader"]
	BINDING_NAME_AutoBarButtonDebuff_X = L["AutoBarButtonDebuff"]

	BINDING_HEADER_AutoBarClassBarDeathKnight = L["AutoBarClassBarDeathKnight"]
	BINDING_HEADER_AutoBarClassBarMonk = L["AutoBarClassBarMonk"]
	BINDING_HEADER_AutoBarClassBarDemonHunter = L["AutoBarClassBarDemonHunter"]

	BINDING_HEADER_AutoBarClassBarDruid = L["AutoBarClassBarDruid"]
	BINDING_NAME_AutoBarButtonBear_X = L["AutoBarButtonBear"]
	BINDING_NAME_AutoBarButtonBoomkinTree_X = L["AutoBarButtonBoomkinTree"]
	BINDING_NAME_AutoBarButtonCat_X = L["AutoBarButtonCat"]
	BINDING_NAME_AutoBarButtonTravel_X = L["AutoBarButtonTravel"]

	BINDING_HEADER_AutoBarClassBarHunter = L["AutoBarClassBarHunter"]
	BINDING_NAME_AutoBarButtonFoodPet_X = L["AutoBarButtonFoodPet"]
	BINDING_NAME_AutoBarButtonTrap_X = L["AutoBarButtonTrap"]

	BINDING_HEADER_AutoBarClassBarMage = L["AutoBarClassBarMage"]

	BINDING_HEADER_AutoBarClassBarPaladin = L["AutoBarClassBarPaladin"]

	BINDING_HEADER_AutoBarClassBarPriest = L["AutoBarClassBarPriest"]

	BINDING_HEADER_AutoBarClassBarRogue = L["AutoBarClassBarRogue"]
	BINDING_NAME_AutoBarButtonPickLock_X = L["AutoBarButtonPickLock"]

	BINDING_HEADER_AutoBarClassBarShaman = L["AutoBarClassBarShaman"]
	BINDING_NAME_AutoBarButtonTotemAir_X = L["AutoBarButtonTotemAir"]
	BINDING_NAME_AutoBarButtonTotemEarth_X = L["AutoBarButtonTotemEarth"]
	BINDING_NAME_AutoBarButtonTotemFire_X = L["AutoBarButtonTotemFire"]
	BINDING_NAME_AutoBarButtonTotemWater_X = L["AutoBarButtonTotemWater"]

	BINDING_HEADER_AutoBarClassBarWarlock = L["AutoBarClassBarWarlock"]

	BINDING_HEADER_AutoBarClassBarWarrior = L["AutoBarClassBarWarrior"]

	AutoBar.dockingFramesValidateList = {
		["NONE"] = L["None"],
		["BT3Bar1"] = L["AUTOBAR_CONFIG_BT3BAR"]..1,
		["BT3Bar2"] = L["AUTOBAR_CONFIG_BT3BAR"]..2,
		["BT3Bar3"] = L["AUTOBAR_CONFIG_BT3BAR"]..3,
		["BT3Bar4"] = L["AUTOBAR_CONFIG_BT3BAR"]..4,
		["BT3Bar6"] = L["AUTOBAR_CONFIG_BT3BAR"]..6,
		["BT3Bar10"] = L["AUTOBAR_CONFIG_BT3BAR"]..10,
		["MainMenuBarArtFrame"] = L["AUTOBAR_CONFIG_DOCKTOMAIN"],
		["ChatFrame1"] = L["AUTOBAR_CONFIG_DOCKTOCHATFRAME"],
		["ChatFrameMenuButton"] = L["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"],
		["MainMenuBar"] = L["AUTOBAR_CONFIG_DOCKTOACTIONBAR"],
		["CharacterMicroButton"] = L["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"],
	}

	AutoBar.dockingFrames = {
		["NONE"] = {
			text = L["None"],
			offset = { x = 0, y = 0, point = "CENTER", relative = "TOPLEFT" },
		},
		["BT3Bar1"] = {
			text = L["AUTOBAR_CONFIG_BT3BAR"]..1,
			offset = { x = 0, y = 0, point = "CENTER", relative = "TOPLEFT" },
		},
		["BT3Bar2"] = {
			text = L["AUTOBAR_CONFIG_BT3BAR"]..2,
			offset = { x = 0, y = 0, point = "CENTER", relative = "TOPLEFT" },
		},
		["BT3Bar3"] = {
			text = L["AUTOBAR_CONFIG_BT3BAR"]..3,
			offset = { x = 0, y = 0, point = "CENTER", relative = "TOPLEFT" },
		},
		["BT3Bar4"] = {
			text = L["AUTOBAR_CONFIG_BT3BAR"]..4,
			offset = { x = 0, y = 0, point = "CENTER", relative = "BOTTOMLEFT" },
		},
		["BT3Bar6"] = {
			text = L["AUTOBAR_CONFIG_BT3BAR"]..6,
			offset = { x = 0, y = 0, point = "CENTER", relative = "TOPLEFT" },
		},
		["BT3Bar10"] = {
			text = L["AUTOBAR_CONFIG_BT3BAR"]..10,
			offset = { x = 0, y = 0, point = "CENTER", relative = "TOPLEFT" },
		},
		["MainMenuBarArtFrame"] = {
			text = L["AUTOBAR_CONFIG_DOCKTOMAIN"],
			offset = { x = 0, y = 0, point = "CENTER", relative = "TOPRIGHT" },
		},
		["ChatFrame1"] = {
			text = L["AUTOBAR_CONFIG_DOCKTOCHATFRAME"],
			offset = { x = 0, y = 25, point = "CENTER", relative = "TOPLEFT" },
		},
		["ChatFrameMenuButton"] = {
			text = L["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"],
			offset = { x = 0, y = 25, point = "CENTER", relative = "TOPLEFT" },
		},
		["MainMenuBar"] = {
			text = L["AUTOBAR_CONFIG_DOCKTOACTIONBAR"],
			offset = { x = 7, y = 40, point = "CENTER", relative = "TOPLEFT" },
		},
		["CharacterMicroButton"] = {
			text = L["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"],
			offset = { x = 0, y = 0, point = "CENTER", relative = "BOTTOMLEFT" },
		},
	}

	AutoBar.player_faction_name = UnitFactionGroup("player")
	AutoBar.currentPlayer = UnitName("player") .. " - " .. GetRealmName();
	_, AutoBar.CLASS = UnitClass("player")
	AutoBar.NiceClass = string.sub(AutoBar.CLASS, 1, 1) .. string.lower(string.sub(AutoBar.CLASS, 2))
	AutoBar.CLASSPROFILE = "_" .. AutoBar.CLASS;

	AutoBar:RegisterDB("AutoBarDB", nil, "class")

	AutoBar.inWorld = false
	AutoBar.inCombat = nil		-- For item use restrictions
	AutoBar.inBG = false		-- For battleground only items

	-- Single parent for key binding overides, and event handling
	AutoBar.frame = CreateFrame("Frame", "AutoBarEventFrame", UIParent)
	AutoBar.frame:SetScript("OnEvent",
		function(self, event, ...)

			-- The BAG_UPDATE event is now trivial in its execution; it just sets a boolean so don't throttle it
			if(event == "BAG_UPDATE") then
				AutoBar.events[event](AutoBar, ...)
				return
			end

			--If it's a GET_ITEM_INFO_RECEIVED and there aren't any items we don't know, ignore it
			if(event == "GET_ITEM_INFO_RECEIVED" and not AutoBar.missing_items) then
				return
			end

			if(AutoBar.db.account.throttle_event_limit > 0) then
				local timer_name = event .. "_last_tick"
				local now = GetTime()
				AutoBar[timer_name] = AutoBar[timer_name] or 0

				if ((now - AutoBar[timer_name]) < AutoBar.db.account.throttle_event_limit) then
					if (AutoBar.db.account.log_throttled_events) then print ("Skipping " .. event .. "(" .. AutoBar[timer_name] .. ", " .. now .. ")", ...) end
					return
				end
				AutoBar[timer_name] = now
			end

			AutoBar.events[event](AutoBar, ...)
		end)

	-- List of barKey = barDB (the correct DB to use between char, class or account)
	AutoBar.barButtonsDBList = {}
	AutoBar.barLayoutDBList = {}
	AutoBar.barPositionDBList = {}

	-- List of Bar Names
	AutoBar.barValidateList = {}

	-- List of buttonKey = buttonDB (the correct DB to use between char, class or account)
	AutoBar.buttonDBList = {}

	-- List of buttonKey for Buttons not currently placed on a Bar
	AutoBar.unplacedButtonList = {}

	-- List of buttonName = AutoBarButton
	AutoBar.buttonList = {}

	-- List of buttonName = AutoBarButton for disabled buttons
	AutoBar.buttonListDisabled = {}

--	AutoBar.db.account.performance = true
	AutoBar:LogEvent("OnInitialize")
	AutoBar:InitializeDB()
	AutoBarCategory:Upgrade()
	AutoBar:InitializeOptions()
	AutoBar:Initialize()
--	AutoBar.db.account.performance = false
--print("--> FullyInitialized")
	AutoBar:RegisterEvent("AceEvent_FullyInitialized", "FullyInitialized")
end

function AutoBar:FullyInitialized()
--print("<-- FullyInitialized")
	AutoBar.enableBindings = true
	AutoBar:UpdateCategories()
--	AutoBar.delay["UpdateObjects"]:Start()
end

function AutoBar:OnEnable(first)
	self:LogEvent("OnEnable")

	-- Called when the addon is enabled
	AutoBar.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	AutoBar.frame:RegisterEvent("PLAYER_LEAVING_WORLD")
	AutoBar.frame:RegisterEvent("BAG_UPDATE")
	AutoBar.frame:RegisterEvent("BAG_UPDATE_DELAYED")
	AutoBar.frame:RegisterEvent("LEARNED_SPELL_IN_TAB")

	if(AutoBar.db.account.handle_spell_changed) then
		AutoBar.frame:RegisterEvent("SPELLS_CHANGED")
	end
	AutoBar.frame:RegisterEvent("ACTIONBAR_UPDATE_USABLE")

	AutoBar.frame:RegisterEvent("PET_BATTLE_CLOSE")
	AutoBar.frame:RegisterEvent("TOYS_UPDATED")



	-- For item use restrictions
	AutoBar.frame:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
	AutoBar.frame:RegisterEvent("PLAYER_ALIVE")
	AutoBar.frame:RegisterUnitEvent("UNIT_AURA", "player")
	AutoBar.frame:RegisterEvent("PLAYER_CONTROL_GAINED")
	AutoBar.frame:RegisterEvent("PLAYER_REGEN_ENABLED")
	AutoBar.frame:RegisterEvent("PLAYER_REGEN_DISABLED")
	AutoBar.frame:RegisterEvent("PLAYER_UNGHOST")
	AutoBar.frame:RegisterEvent("BAG_UPDATE_COOLDOWN")
	AutoBar.frame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	AutoBar.frame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
	AutoBar.frame:RegisterEvent("COMPANION_LEARNED")
	AutoBar.frame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
	AutoBar.frame:RegisterEvent("QUEST_ACCEPTED")
	AutoBar.frame:RegisterEvent("QUEST_LOG_UPDATE")

	LibKeyBound.RegisterCallback(self, "LIBKEYBOUND_ENABLED")
	LibKeyBound.RegisterCallback(self, "LIBKEYBOUND_DISABLED")
	LibKeyBound.RegisterCallback(self, "LIBKEYBOUND_MODE_COLOR_CHANGED")

	LibStickyFrames.RegisterCallback(self, "OnSetGroup")
	LibStickyFrames.RegisterCallback(self, "OnClick")
--	LibStickyFrames.RegisterCallback(self, "OnStartFrameMoving")
	LibStickyFrames.RegisterCallback(self, "OnStopFrameMoving")
	LibStickyFrames.RegisterCallback(self, "OnStickToFrame")
end


function AutoBar:OnDisable()
	-- Called when the addon is disabled
	AutoBar:LogEvent("OnDisable")
end

local logItems = {}	-- n = startTime
local logMemory = {}	-- n = startMemory

function AutoBar:LogEvent(eventName, arg1)
	if (AutoBar.db.account.logMemory) then
		UpdateAddOnMemoryUsage()
		local memory = GetAddOnMemoryUsage("AutoBar")
		print(eventName, "memory" , memory)
	end
	if (AutoBar.db.account.logEvents) then
		if (arg1) then
			print(eventName, "arg1" , arg1, "time:", GetTime(), memString, memory)
		else
			print(eventName, "time:", GetTime())
		end
	end
end

function AutoBar:LogEventStart(eventName)
	if (AutoBar.db.account.logMemory) then
		UpdateAddOnMemoryUsage()
		local memory = GetAddOnMemoryUsage("AutoBar")
--			print(eventName, "memory" , memory)
		logMemory[eventName] = memory
	end
	if (AutoBar.db.account.performance) then
		if (logItems[eventName]) then
			--print(eventName, "restarted before previous completion")
		else
			logItems[eventName] = GetTime()
			--print(eventName, "started time:", logItems[eventName])
		end
	end
end

function AutoBar:LogEventEnd(eventName, arg1)
	if (AutoBar.db.account.performance) then
		if (logItems[eventName]) then
			local elapsed = GetTime() - logItems[eventName]
			logItems[eventName] = nil
			if (elapsed > 0.005) then
				if (arg1) then
					print(eventName, arg1, "time:", elapsed)
				else
					print(eventName, "time:", elapsed)
				end
			end
		else
			--print(eventName, "restarted before previous completion")
		end
	end
	if (AutoBar.db.account.logMemory) then
		UpdateAddOnMemoryUsage()
		local memory = GetAddOnMemoryUsage("AutoBar")
		local deltaMemory = memory - (logMemory[eventName] or 0)
		print(eventName, "memory" , deltaMemory)
		logMemory[eventName] = nil
	end
end


-- Will not update if set during combat
function AutoBar:RegisterOverrideBindings()
	AutoBar:LogEvent("RegisterOverrideBindings")
	ClearOverrideBindings(AutoBar.frame)
	for buttonKey, buttonDB in pairs(AutoBar.buttonDBList) do
		AutoBar.Class.Button:UpdateBindings(buttonKey, buttonKey .. "Frame")
	end
end


-- Layered delayed callback objects
-- Timers lower down the list are superceded and cancelled by those higher up
local timerList = {
	{name = "AutoBarInit", 			timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateCategories", 	timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateCustomBars", 	timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateCustomButtons",timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateSpells", 		timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateObjects", 		timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateRescan", 		timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateScan", 			timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateAttributes", 	timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateActive", 		timer = nil, runPostCombat = false, callback = nil},
	{name = "UpdateButtons", 		timer = nil, runPostCombat = false, callback = nil},
}
local timerIndexList = {
	["AutoBarInit"] = 1,
	["UpdateCategories"] = 2,
	["UpdateCustomBars"] = 3,
	["UpdateCustomButtons"] = 4,
	["UpdateSpells"] = 5,
	["UpdateObjects"] = 6,
	["UpdateRescan"] = 7,
	["UpdateScan"] = 8,
	["UpdateAttributes"] = 9,
	["UpdateActive"] = 10,
	["UpdateButtons"] = 11,
}
local IDelayedCallback = AceOO.Interface { Callback = "function" }

local DELAY_TIME = 0.08
local DELAY_TIME_INCREMENTAL = 0.01

local Delayed = AceOO.Class(IDelayedCallback)
Delayed.virtual = true
Delayed.prototype.postCombat = false -- Set to true to trigger call after combat
Delayed.prototype.timerList = timerList
Delayed.prototype.timerListIndex = 0
Delayed.prototype.timerInfo = 0
Delayed.prototype.name = "No Name"

function Delayed.prototype:init(timerListIndex)
	Delayed.super.prototype.init(self)
	self.timerListIndex = timerListIndex
	self.timerInfo = timerList[timerListIndex]
	self.name = timerList[timerListIndex].name
--	print("Delayed.prototype:init " .. tostring(self.name))
end

function Delayed.prototype:Callback()
	self.timerInfo.timer = nil
end

-- Start the timer if appropriate
function Delayed.prototype:Start(arg1, customDelay)
	AutoBar:LogEvent("--> DELAYED ", self.name)

	-- If in combat delay call till after combat
	if (InCombatLockdown() or C_PetBattles.IsInBattle()) then
		self.timerInfo.runPostCombat = true
		return
	end

	local currentTime = GetTime()
	local function MyCallback()
		local myself = self
		local arg1 = arg1
		-- If in combat delay call till after combat
		if (InCombatLockdown()or C_PetBattles.IsInBattle()) then
			self.timerInfo.runPostCombat = true
			return
		end

--print("***MyCallback "..myself.name.." at  " .. tostring(GetTime()).." arg1  " .. tostring(arg1))
		myself:Callback(arg1)
	end

--print("***Delayed.prototype:Start "..self.name.." here ");
	if (self.timerInfo.timer) then
--print("***Delayed.prototype:Start "..self.name.." extend timer at " .. currentTime);
		-- Timer not expired, extend it
		if (currentTime - self.timerInfo.timer > DELAY_TIME - DELAY_TIME_INCREMENTAL) then
			-- Almost or already exceeding DELAY_TIME, so use a small incremental delay
			AutoBar:CancelScheduledEvent(self.name)
			AutoBar:ScheduleEvent(self.name, MyCallback, DELAY_TIME_INCREMENTAL)
		else
			-- Still more than DELAY_TIME_INCREMENTAL before the original timer so do not change it
		end
	else
		-- Cancel if higher level timer already in progress
		for i, timerInfo in ipairs(self.timerList) do
			if (i < self.timerListIndex and timerInfo.timer) then
--print("***Delayed.prototype:Start cancel "..self.name.." because " .. timerInfo.name)
				return
			elseif (i == self.timerListIndex) then
				break
			end
		end

		-- Start new Timer
		self.timerInfo.timer = currentTime;
		AutoBar:ScheduleEvent(self.name, MyCallback, customDelay or DELAY_TIME)
--print("***Delayed.prototype:Start start "..self.name.." delay at " .. currentTime)

		-- Cancel Superceded timers
		for i, timerInfo in ipairs(self.timerList) do
			if (i > self.timerListIndex and timerInfo.timer) then
				AutoBar:CancelScheduledEvent(timerInfo.name)
				timerInfo.timer = nil
			end
		end
	end
--print("***Delayed.prototype:Start "..self.name.." end ");
end

function AutoBar.events:GET_ITEM_INFO_RECEIVED(p_item_id)
	AutoBar:LogEventStart("GET_ITEM_INFO_RECEIVED", p_item_id)
--print("GET_ITEM_INFO_RECEIVED", p_item_id)
	AutoBar:ClearMissingItemFlag();
	AutoBar.delay["UpdateScan"]:Start()

	AutoBar:LogEventEnd("GET_ITEM_INFO_RECEIVED", p_item_id)

end

-- Given an item link, this adds the item to the given category
-- NOTE: No effort is made to avoid adding an item that as already been added. As long as the list is small, this isn't worth worrying about.
local function add_item_to_dynamic_category(p_item_link, p_category_name)
	local debug_me = false
	local category = AutoBarCategoryList[p_category_name]

	if(debug_me) then print("Adding", p_item_link, " to ", p_category_name, AutoBar:Dump(category)); end;

	local item_name, item_id = AutoBar.ItemLinkDecode(p_item_link)
	category.items[#category.items + 1] = item_id

	if(debug_me) then print(item_name, item_id, "Num Items:", #category.items); end;
end

function AutoBar.events:QUEST_ACCEPTED(p_quest_index)
	AutoBar:LogEventStart("QUEST_ACCEPTED", p_quest_index)

	local link = GetQuestLogSpecialItemInfo(p_quest_index)
	
	if(link) then
		add_item_to_dynamic_category(link, "Dynamic.Quest")
		AutoBar.delay["UpdateScan"]:Start()
	end

	AutoBar:LogEventEnd("QUEST_ACCEPTED", p_quest_index)
end

function AutoBar.events:QUEST_LOG_UPDATE(p_arg1)
	AutoBar:LogEventStart("QUEST_LOG_UPDATE", p_arg1)
	
	--Make sure we're in the world. Should always be the case, but stuff loads in odd orders
	if(AutoBar.inWorld and AutoBarCategoryList["Dynamic.Quest"]) then
		AutoBar.frame:UnregisterEvent("QUEST_LOG_UPDATE")
		local _, num_quests = GetNumQuestLogEntries()

		for i = 1, num_quests do 
			local link = GetQuestLogSpecialItemInfo(i)
			if(link) then
				add_item_to_dynamic_category(link, "Dynamic.Quest")
			end
		end
	end

	AutoBar:LogEventEnd("QUEST_LOG_UPDATE", p_arg1)

end


function AutoBar.events:PLAYER_ENTERING_WORLD()
	AutoBar.inCombat = nil
	local scanned = false;
	if (not AutoBar.initialized) then
--print("   PLAYER_ENTERING_WORLD")
		AutoBar.delay["UpdateCategories"]:Start()
		scanned = true;
		AutoBar.initialized = true;
	end

	if (not AutoBar.inWorld) then
		AutoBar.inWorld = true;
--print("   PLAYER_ENTERING_WORLD")
		AutoBar.delay["UpdateCategories"]:Start()
	end

	AutoBar:DumpWarningLog()

	local this_version = GetAddOnMetadata("AutoBar", "Version")

	--only mark the dialog as seen if the frame was found. This protects against someone
	--updating the addon while in-game
	if(this_version ~= AutoBarDB.whatsnew_version) then
		 AutoBarDB.whatsnew_version = this_version

		WHATSNEW_TITLE = "What's New in AutoBar"

		local frame = CreateFrame("Frame", "AutoBarWhatsNewFrame", UIParent)
		frame:SetBackdrop({
			bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		 	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		 	tile = true,
		 	tileSize = 32,
		 	edgeSize = 32,
		 	insets = { left = 11, right = 11, top = 11, bottom = 10 }
		})
		frame:SetBackdropColor(0, 0, 0, 0.9);
		frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

		local header_frame = CreateFrame("Frame", "AutoBarWhatsNewHeaderFrame", frame)
		header_frame:SetBackdrop({
			bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		 	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		 	tile = true,
		 	tileSize = 28,
		 	edgeSize = 28,
		 	insets = { left = 5, right = 5, top = 5, bottom = 5 }
		})
		header_frame:SetBackdropColor(0, 0, 0, 0.9);
		header_frame:SetPoint("CENTER", frame, "TOP", 0, 0)

		local title_text = header_frame:CreateFontString("AutoBarWhatsNewTitleText", "ARTWORK", "GameFontNormal")
		title_text:SetText(WHATSNEW_TITLE .. "|n" .. this_version)
		title_text:SetJustifyH("CENTER")

		local title_string_width = title_text:GetStringWidth()
		local title_string_height = title_text:GetStringHeight()

		header_frame:SetSize(title_string_width * 1.4, title_string_height * 1.9)
		title_text:SetSize(title_string_width, title_string_height)

		title_text:SetPoint("CENTER", header_frame, "CENTER", 0, 0)


		local text = frame:CreateFontString("AutoBarWhatsNewFrameText", "ARTWORK", "GameFontNormal")
		text:SetTextColor(0, 1, 0, 0.9)
		text:SetText(WHATSNEW_TEXT)
		text:SetPoint("LEFT", frame, "LEFT", 20, 0)
		text:SetJustifyH("LEFT")

		local string_width = text:GetStringWidth()
		local string_height = text:GetStringHeight()

		local ok_button = CreateFrame("Button", "AutoBarWhatsNewFrameOkButton", frame, "UIPanelButtonTemplate")
		ok_button:SetText(OKAY)

		frame:SetSize(math.max(string_width * 1.2, 300), math.max(string_height * 1.5, 100) + ok_button:GetHeight())
		text:SetSize(string_width, string_height)

		ok_button:SetPoint("BOTTOM", frame, "BOTTOM", 0, 15)
		ok_button:SetScript("OnClick", function(self, button, down) frame:Hide() end)

		frame:Show()
	end

end


function AutoBar.events:PLAYER_LEAVING_WORLD()
	AutoBar.inWorld = false;
end


function AutoBar.events:BAG_UPDATE(arg1)
	AutoBar:LogEventStart("BAG_UPDATE")

	if (AutoBar.inWorld and arg1 <= NUM_BAG_FRAMES) then
		AutoBarSearch.dirtyBags[arg1] = true
	end

	AutoBar:LogEventEnd("BAG_UPDATE", arg1)

end

function AutoBar.events:BAG_UPDATE_DELAYED()
	AutoBar:LogEventStart("BAG_UPDATE_DELAYED")

	if (InCombatLockdown()) then
		for buttonName, button in pairs(AutoBar.buttonList) do
			button:UpdateCount()
		end
	else
		AutoBar.delay["UpdateScan"]:Start()
	end

	AutoBar:LogEventEnd("BAG_UPDATE_DELAYED")

end

function AutoBar.events:BAG_UPDATE_COOLDOWN(arg1)
	AutoBar:LogEventStart("BAG_UPDATE_COOLDOWN")

	if (not AutoBar:IsInLockDown()) then
		AutoBar.delay["UpdateScan"]:Start(arg1)
	end

	for buttonName, button in pairs(AutoBar.buttonList) do
		button:UpdateCooldown()
	end

	AutoBar:LogEventEnd("BAG_UPDATE_COOLDOWN", arg1)

end


function AutoBar.events:SPELL_UPDATE_COOLDOWN(arg1)
	AutoBar:LogEventStart("SPELL_UPDATE_COOLDOWN")

	for buttonName, button in pairs(AutoBar.buttonList) do
		button:UpdateCooldown()
	end

	AutoBar:LogEventEnd("SPELL_UPDATE_COOLDOWN", arg1)

end



function AutoBar.events:ACTIONBAR_UPDATE_USABLE(arg1)
	AutoBar:LogEvent("ACTIONBAR_UPDATE_USABLE", arg1)
	if (AutoBar.inWorld) then
		if (InCombatLockdown()) then
			for buttonName, button in pairs(AutoBar.buttonList) do
				button:UpdateUsable()
			end
		else
			AutoBar.delay["UpdateScan"]:Start(arg1)
		end
	end
end


function AutoBar.events:UPDATE_SHAPESHIFT_FORMS(arg1)
	AutoBar:LogEvent("UPDATE_SHAPESHIFT_FORMS", arg1)
	if (AutoBar.inWorld) then
		if (InCombatLockdown()) then
			for buttonName, button in pairs(AutoBar.buttonList) do
				button:UpdateUsable()
			end
		else
			AutoBar.delay["UpdateScan"]:Start(arg1)
		end
	end
end


function AutoBar.events:COMPANION_LEARNED(...)
	local companionType = ...;
	local need_update = false;

	AutoBar:LogEventStart("COMPANION_LEARNED", companionType)

	if (AutoBar.inWorld) then
		local button = AutoBar.buttonList["AutoBarButtonMount"]
		if (button and (companionType == "MOUNT")) then
			button:Refresh(button.parentBar, button.buttonDB, companionType == "MOUNT")
		end

		button = AutoBar.buttonList["AutoBarButtonPets"]
		if (button and (companionType == "MOUNT")) then
			button:Refresh(button.parentBar, button.buttonDB)
		end

		if(need_update) then
			AutoBar.delay["UpdateCategories"]:Start()
		end

	end

	AutoBar:LogEventEnd("COMPANION_LEARNED", companionType)
end


function AutoBar.events:UPDATE_BINDINGS()
	self:RegisterOverrideBindings()
	AutoBar.delay["UpdateButtons"]:Start()
end


function AutoBar.events:LEARNED_SPELL_IN_TAB(arg1)
	AutoBar:LogEvent("LEARNED_SPELL_IN_TAB", arg1)
	AutoBar.delay["UpdateSpells"]:Start(arg1)
end


function AutoBar.events:SPELLS_CHANGED(arg1)

	if(not AutoBar.db.account.handle_spell_changed) then
		return
	end
	AutoBar:LogEvent("SPELLS_CHANGED", arg1)
	if (AutoBar:IsInLockDown()) then
		AutoBar:SetRegenEnableUpdate("UpdateSpells")
	else
		AutoBar.delay["UpdateSpells"]:Start(arg1)
	end
end



function AutoBar.events:PLAYER_CONTROL_GAINED()
	AutoBar:LogEvent("PLAYER_CONTROL_GAINED", arg1)
	AutoBar.delay["UpdateButtons"]:Start()
end



local regenEnableUpdate = "UpdateRescan"
function AutoBar:SetRegenEnableUpdate(scanType)
	if (timerIndexList[scanType] < timerIndexList[regenEnableUpdate]) then
		regenEnableUpdate = scanType
	end
end


function AutoBar.events:PLAYER_REGEN_ENABLED(arg1)
	AutoBar:LogEvent("PLAYER_REGEN_ENABLED", arg1)
	AutoBar.inCombat = nil
	AutoBar.delay[regenEnableUpdate]:Start()
--print("PLAYER_REGEN_ENABLED " .. tostring(self))
end


function AutoBar.events:PLAYER_REGEN_DISABLED(arg1)
	AutoBar:LogEvent("PLAYER_REGEN_DISABLED", arg1)
	AutoBar.inCombat = true
	if (InCombatLockdown()) then
		print("PLAYER_REGEN_DISABLED called while InCombatLockdown")
	--else
	--print("PLAYER_REGEN_DISABLED " .. tostring(self))
	end

	if (AutoBar.moveButtonsMode) then
		AutoBar:MoveButtonsModeOff()
		LibKeyBound:Deactivate()
	end

	if (AutoBar.keyBoundMode) then
		LibKeyBound:Deactivate()
	end
--print("   PLAYER_REGEN_DISABLED")
	if (self:IsEventScheduled("UpdateRescan")) then
		self:CancelScheduledEvent("UpdateRescan")
		AutoBarSearch.stuff:Reset()
	elseif (self:IsEventScheduled("UpdateScan")) then
		self:CancelScheduledEvent("UpdateScan")
		AutoBarSearch.stuff:Scan()
	elseif (self:IsEventScheduled("UpdateActive")) then
		self:CancelScheduledEvent("UpdateActive")
	elseif (self:IsEventScheduled("UpdateButtons")) then
		self:CancelScheduledEvent("UpdateButtons")
	end
	AutoBar:UpdateActive()
	AceCfgDlg:Close(appName)
	AutoBar:SetRegenEnableUpdate("UpdateRescan")
end

function AutoBar.events:PET_BATTLE_CLOSE(arg1)
	AutoBar:LogEvent("PET_BATTLE_CLOSE", arg1)

	AutoBar.delay[regenEnableUpdate]:Start()

	-- AutoBar.in_pet_battle = false

end

function AutoBar.events:TOYS_UPDATED(p_arg1, p_arg2)
	AutoBar:LogEventStart("TOYS_UPDATED", p_arg1, p_arg2)

	local need_update = false;
	
	AutoBarSearch.dirtyBags.toybox = true
	local button = AutoBar.buttonList["AutoBarButtonToyBox"]
	if (button) then
		need_update = button:Refresh(button.parentBar, button.buttonDB, true)
	end

	--print("TOYS_UPDATED", p_arg1, p_arg2, "need update:", need_update)

	if(need_update) then
		AutoBar.delay["UpdateCategories"]:Start()
	end

	AutoBar:LogEventEnd("TOYS_UPDATED", p_arg1, p_arg2)

end

function AutoBar.events:PLAYER_ALIVE(arg1)
	AutoBar:LogEvent("PLAYER_ALIVE", arg1)
	AutoBar.delay["UpdateButtons"]:Start()
end


function AutoBar.events:UNIT_AURA(arg1)
	if (AutoBar:IsInLockDown()) then
		for buttonName, button in pairs(AutoBar.buttonList) do
			button:UpdateUsable()
		end
	else
		AutoBar:LogEvent("UNIT_AURA", arg1)
		AutoBar.delay["UpdateButtons"]:Start()
	end
end


function AutoBar.events:PLAYER_UNGHOST(arg1)
	if (not InCombatLockdown()) then
		AutoBar:LogEvent("PLAYER_UNGHOST", arg1)
		AutoBar.delay["UpdateButtons"]:Start()
	end
end


function AutoBar.events:UPDATE_BATTLEFIELD_STATUS()
	if (AutoBar.inWorld) then
		local bgStatus = false
		local max_battlefield_id = GetMaxBattlefieldID()
		for i = 1, max_battlefield_id do
			local status, mapName, instanceID = GetBattlefieldStatus(i);
			if (instanceID ~= 0) then
				bgStatus = true
				break
			end
		end
		if (AutoBar.inBG ~= bgStatus) then
			AutoBar.inBG = bgStatus
			AutoBar.delay["UpdateActive"]:Start()
		end
	end
end


-- When dragging, contains { frameName, index }, otherwise nil
AutoBar.dragging = nil;
local draggingData = {};

function AutoBar.GetDraggingIndex(frameName)
	if (AutoBar.dragging and AutoBar.dragging.frameName == frameName) then
		return AutoBar.dragging.index;
	end
	return nil;
end


function AutoBar.SetDraggingIndex(frameName, index)
	draggingData.frameName = frameName;
	draggingData.index = index;
	AutoBar.dragging = draggingData;
end


function AutoBar.ItemLinkDecode(link)
	if (link) then
		local id, name = string.match(link,"item:(%d+):.+%[(.*)%]")
		if (id and name) then
			return name, tonumber(id)
		end
	end
end



-- Initialize
--		All Initialization
-- UpdateCategories
--		Based on the current db, add or remove Custom Categories
-- UpdateCustomBars
--		Based on the current db, add or remove Custom Bars
-- UpdateCustomButtons
--		Based on the current db, add or remove Custom Buttons
-- UpdateSpells
--		Rescan all registerred spells
--		This is on a less frequent cycle than UpdateScan.  Called on leveling or spellbook changes.
--		ToDo: Also trigger on spec changes
-- UpdateObjects
--		Based on the current db, instantiate or refresh Bars, Buttons
--		Move disabled Bars, Buttons to cold storage, & thaw out re-enabled ones
--		This is done on Initialize and on Configuration changes
--		Could be triggered by events (Boss specific categories for instance)
-- UpdateRescan
--		Rescan all bags and inventory from scratch based on current Buttons and their Categories
-- UpdateScan
--		Scan all bags and inventory based on current Buttons and their Categories
--		Triggered by bag & inventory changes, combat end
-- UpdateAttributes
--		Based on the current Scan results, update the Button and Popup Attributes
--		Create Popup Buttons as needed
-- UpdateActive
--		Based on the current Scan results, Bars and their Buttons, determine the active Buttons
-- UpdateButtons
--		Based on the active Bars and their Buttons display them
--		Triggered by events

-- ToDo: Mmm Styles callback should be pulled out of the hierarchy



function AutoBar:Initialize()
--print("AutoBar:Initialize")
	self:LogEventStart("AutoBar:Initialize")

	-- Set AutoBar Skin
	if (Masque and not AutoBar.MasqueGroup) then
		local group = Masque:Group("AutoBar")
		AutoBar.MasqueGroup = group
		group.SkinID = AutoBar.db.account.SkinID or "Blizzard"
		group.Gloss = AutoBar.db.account.Gloss
		group.Backdrop = AutoBar.db.account.Backdrop
		group.Colors = AutoBar.db.account.Colors or {}
	end

	AutoBarCategory:Initialize()
	AutoBarCategory:Initialize2()
	AutoBarCategory:UpdateCustomCategories()
	AutoBarSearch:Initialize()
	self:LogEventEnd("AutoBar:Initialize")
--AutoBarSearch:Test()
end

-- Complete reload of everything.  Dump most old data structures.
local DelayedInitialize = AceOO.Class(Delayed)

function DelayedInitialize.prototype:init(timerListIndex)
	DelayedInitialize.super.prototype.init(self, timerListIndex)
end

function DelayedInitialize.prototype:Callback()
--print("   DelayedInitialize.prototype:Callback  self " .. tostring(self))
	DelayedInitialize.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedInitialize <--")
	AutoBar:Initialize()
	AutoBar:UpdateCategories()
end



local otherStickyFrames = {
	"GridLayoutFrame",
}

-- Based on the current db, add or remove Custom Categories
-- ToDo: support scheme for mutable categories like pet food.
function AutoBar:UpdateCategories()
	if (otherStickyFrames) then
		local delete = true
		for index, stickyFrame in pairs(otherStickyFrames) do
			if (_G[stickyFrame]) then
--print("AutoBar:OnEnable " .. tostring(index) .. "  " .. tostring(stickyFrame))
				LibStickyFrames:RegisterFrame(_G[stickyFrame])
			else
				delete = false
			end
		end
		if (delete) then
			otherStickyFrames = nil
		end
	end

	if (not InCombatLockdown()) then
		self:LogEventStart("AutoBar:UpdateCategories")
		AutoBarCategory:UpdateCustomCategories()
		self:UpdateCustomBars()
		self:LogEventEnd("AutoBar:UpdateCategories")
	else
		self:LogEvent("AutoBar:UpdateCategories InCombatLockdown")
		AutoBar:SetRegenEnableUpdate("UpdateCategories")
	end
end

local DelayedUpdateCategories = AceOO.Class(Delayed)

function DelayedUpdateCategories.prototype:init()
	DelayedUpdateCategories.super.prototype.init(self, timerIndexList["UpdateCategories"])
end

function DelayedUpdateCategories.prototype:Callback()
	DelayedUpdateCategories.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateCategories <--")
	if (not InCombatLockdown()) then
		AutoBar:UpdateCategories()
	end
end



-- Based on the current db, add Custom Bars that match player CLASS
-- Update shared state
function AutoBar:UpdateCustomBars()
	self:LogEventStart("AutoBar:UpdateCustomBars")
	self:UpdateCustomButtons()

	self:LogEventEnd("AutoBar:UpdateCustomBars")
end

local DelayedUpdateCustomBars = AceOO.Class(Delayed)

function DelayedUpdateCustomBars.prototype:init()
	DelayedUpdateCustomBars.super.prototype.init(self, timerIndexList["UpdateCustomBars"])
end

function DelayedUpdateCustomBars.prototype:Callback()
	DelayedUpdateCustomBars.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateCustomBars <--")
	AutoBar:UpdateCustomBars()
end



-- Based on the current db, add Custom Buttons used by existing Bars
function AutoBar:UpdateCustomButtons()
	self:LogEventStart("AutoBar:UpdateCustomButtons")

	self:UpdateSpells()

	self:LogEventEnd("AutoBar:UpdateCustomButtons")
end

local DelayedUpdateCustomButtons = AceOO.Class(Delayed)

function DelayedUpdateCustomButtons.prototype:init()
	DelayedUpdateCustomButtons.super.prototype.init(self, timerIndexList["UpdateCustomButtons"])
end

function DelayedUpdateCustomButtons.prototype:Callback()
	DelayedUpdateCustomButtons.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateCustomButtons <--")
	AutoBar:UpdateCustomButtons()
end



-- Rescan all registered spells
function AutoBar:UpdateSpells()
	self:LogEventStart("AutoBar:UpdateSpells")
	AutoBarSearch.stuff:ScanSpells()
	AutoBarSearch.stuff:ScanMacros()
	AutoBarCategory:UpdateCategories()
--	AutoBar:RefreshButtons()
	-- ToDo: update on learn.
	self:UpdateObjects()
	self:LogEventEnd("AutoBar:UpdateSpells")
end

local DelayedUpdateSpells = AceOO.Class(Delayed)

function DelayedUpdateSpells.prototype:init()
	DelayedUpdateSpells.super.prototype.init(self, timerIndexList["UpdateSpells"])
end

function DelayedUpdateSpells.prototype:Callback()
	DelayedUpdateSpells.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateSpells <--")
	AutoBar:UpdateSpells()
end


-- Based on the current db, instantiate or refresh Bars, Buttons, Popups
function AutoBar:UpdateObjects()
	self:LogEventStart("AutoBar:UpdateObjects")
	local barLayoutDBList = AutoBar.barLayoutDBList
	local bar
	for barKey, barDB in pairs(barLayoutDBList) do
		if (barDB.enabled and barDB[AutoBar.CLASS]) then
--print("UpdateObjects barKey " .. tostring(barKey) .. " AutoBar.CLASS " .. tostring(AutoBar.CLASS) .. " barDB[AutoBar.CLASS] " .. tostring(barDB[AutoBar.CLASS]))
			if (AutoBar.barList[barKey]) then
				AutoBar.barList[barKey]:UpdateObjects()
			else
				AutoBar.barList[barKey] = AutoBar.Class.Bar:new(barKey)
--print("UpdateObjects barKey " .. tostring(barKey) .. " Name " .. tostring(AutoBar.barList[barKey].barName))
			end
			bar = AutoBar.barList[barKey]
			LibStickyFrames:SetFrameEnabled(bar.frame, true)
			LibStickyFrames:SetFrameHidden(bar.frame, bar.sharedLayoutDB.hide)
			LibStickyFrames:SetFrameText(bar.frame, bar.barName)
		elseif (AutoBar.barList[barKey]) then
--print("UpdateObjects barKey " .. tostring(barKey) .. " Hide " .. tostring(AutoBar.barList[barKey].barName))
			bar = AutoBar.barList[barKey]
			bar.frame:Hide()
			LibStickyFrames:SetFrameEnabled(bar.frame)
			LibStickyFrames:SetFrameText(bar.frame, bar.barName)
		end
	end
	self:UpdateRescan()
	self:LogEventEnd("AutoBar:UpdateObjects")
end
-- /script AutoBar.barList["AutoBarClassBarExtras"].frame:Hide()
-- /dump AutoBar.barList["AutoBarClassBarHunter"].buttonList

local DelayedUpdateObjects = AceOO.Class(Delayed)

function DelayedUpdateObjects.prototype:init()
	DelayedUpdateObjects.super.prototype.init(self, timerIndexList["UpdateObjects"])
end

function DelayedUpdateObjects.prototype:Callback()
	DelayedUpdateObjects.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateObjects <--")
	AutoBar:UpdateObjects()
end



-- Rescan all bags and inventory from scratch based on current Buttons and their Categories
function AutoBar:UpdateRescan()
	self:LogEventStart("AutoBar:UpdateRescan")
	AutoBarSearch:Reset()
	self:UpdateAttributes()
	self:LogEventEnd("AutoBar:UpdateRescan")
end

local DelayedUpdateRescan = AceOO.Class(Delayed)

function DelayedUpdateRescan.prototype:init()
	DelayedUpdateRescan.super.prototype.init(self, timerIndexList["UpdateRescan"])
end

function DelayedUpdateRescan.prototype:Callback()
	DelayedUpdateRescan.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateRescan <--")
	AutoBar:UpdateRescan()
end



-- Scan all bags and inventory based on current Buttons and their Categories
function AutoBar:UpdateScan()
	self:LogEventStart("AutoBar:UpdateScan")
	AutoBarSearch:UpdateScan()
	self:UpdateAttributes()
	self:LogEventEnd("AutoBar:UpdateScan")
end

local DelayedUpdateScan = AceOO.Class(Delayed)

function DelayedUpdateScan.prototype:init()
	DelayedUpdateScan.super.prototype.init(self, timerIndexList["UpdateScan"])
end

function DelayedUpdateScan.prototype:Callback()
	DelayedUpdateScan.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateScan <--")
	AutoBar:UpdateScan()
end



-- Based on the current Scan results, update the Button and Popup Attributes
-- Create Popup Buttons as needed
function AutoBar:UpdateAttributes()
	self:LogEventStart("AutoBar:UpdateAttributes")
	for barKey, bar in pairs(AutoBar.barList) do
		bar:UpdateAttributes()
	end
	self:UpdateActive()
	self:LogEventEnd("AutoBar:UpdateAttributes")
end

local DelayedUpdateAttributes = AceOO.Class(Delayed)

function DelayedUpdateAttributes.prototype:init()
	DelayedUpdateAttributes.super.prototype.init(self, timerIndexList["UpdateAttributes"])
end

function DelayedUpdateAttributes.prototype:Callback()
	DelayedUpdateAttributes.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateAttributes <--")
	AutoBar:UpdateAttributes()
end



-- Based on the current Scan results, Bars and their Buttons, determine the active Buttons
function AutoBar:UpdateActive()
	self:LogEventStart("AutoBar:UpdateActive")
	for barKey, bar in pairs(AutoBar.barList) do
		bar:UpdateActive()
		bar:RefreshLayout()
	end
	self:UpdateButtons()
	self:LogEventEnd("AutoBar:UpdateActive")
end

local DelayedUpdateActive = AceOO.Class(Delayed)

function DelayedUpdateActive.prototype:init()
	DelayedUpdateActive.super.prototype.init(self, timerIndexList["UpdateActive"])
end

function DelayedUpdateActive.prototype:Callback()
	DelayedUpdateActive.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateActive <--")
	AutoBar:UpdateActive()
end



-- Based on the active Bars and their Buttons display them
function AutoBar:UpdateButtons()
	self:LogEventStart("AutoBar:UpdateButtons")
	for buttonName, button in pairs(self.buttonListDisabled) do
		--if (buttonKey == "AutoBarButtonCharge") then print("   AutoBar:UpdateButtons Disabled " .. buttonName); end;
		button:Disable()
		--I don't see why we should update all of these if they're disabled.
		--button:UpdateCooldown()
		--button:UpdateCount()
		--button:UpdateHotkeys()
		--button:UpdateIcon()
		--button:UpdateUsable()
	end
	for buttonKey, button in pairs(self.buttonList) do
		--if (buttonKey == "AutoBarButtonCharge") then print("   AutoBar:UpdateButtons Enabled " .. buttonKey); end;
		assert(button.buttonDB.enabled, "In list but disabled " .. buttonKey)
		button:SetupButton()
		button:UpdateCooldown()
		button:UpdateCount()
		button:UpdateHotkeys()
		button:UpdateIcon()
		button:UpdateUsable()
	end
	if (self.enableBindings) then
		self:RegisterOverrideBindings()
		AutoBar.frame:RegisterEvent("UPDATE_BINDINGS")
		self.enableBindings = nil
--print("<-- enableBindings")
	end
	self:LogEventEnd("AutoBar:UpdateButtons", " #buttons " .. tostring(# self.buttonList))
end

local DelayedUpdateButtons = AceOO.Class(Delayed)

function DelayedUpdateButtons.prototype:init()
	DelayedUpdateButtons.super.prototype.init(self, timerIndexList["UpdateButtons"])
end

function DelayedUpdateButtons.prototype:Callback()
	DelayedUpdateButtons.super.prototype.Callback(self)
	AutoBar:LogEvent("DelayedUpdateButtons <--")
	AutoBar:UpdateButtons()
end


AutoBar.delayInitialize = DelayedInitialize:new(timerIndexList["AutoBarInit"])
AutoBar.delay["UpdateCategories"] = DelayedUpdateCategories:new()
AutoBar.delay["UpdateCustomBars"] = DelayedUpdateCustomBars:new()
AutoBar.delay["UpdateCustomButtons"] = DelayedUpdateCustomButtons:new()
AutoBar.delay["UpdateSpells"] = DelayedUpdateSpells:new()
AutoBar.delay["UpdateObjects"] = DelayedUpdateObjects:new()
AutoBar.delay["UpdateRescan"] = DelayedUpdateRescan:new()
AutoBar.delay["UpdateScan"] = DelayedUpdateScan:new()
AutoBar.delay["UpdateActive"] = DelayedUpdateActive:new()
AutoBar.delay["UpdateButtons"] = DelayedUpdateButtons:new()


--
-- Bar & Button drag locking / unlocking and key binding modes
--

function AutoBar:ColorAutoBar()
	for i, bar in pairs(AutoBar.barList) do
		if (bar.sharedLayoutDB.enabled) then
			bar:ColorBars()
		end
	end
	if (AutoBarFuBar) then
		AutoBarFuBar:UpdateDisplay()
	end
end

function AutoBar:LIBKEYBOUND_ENABLED()
	AutoBar:MoveBarModeOff()
	AutoBar:MoveButtonsModeOff()
	AutoBar.keyBoundMode = true
	AutoBar:ColorAutoBar()
end

function AutoBar:LIBKEYBOUND_DISABLED()
	AutoBar.keyBoundMode = nil
	AutoBar:ColorAutoBar()
end

function AutoBar:LIBKEYBOUND_MODE_COLOR_CHANGED()
	AutoBar:ColorAutoBar()
end

function AutoBar:MoveBarModeToggle()
--print("AutoBar:MoveBarModeToggle")
	if (LibStickyFrames:GetGroup()) then
		AutoBar:MoveBarModeOff()
	else
		AutoBar:MoveBarModeOn()
	end
end

function AutoBar:MoveBarModeOff()
	LibStickyFrames:SetGroup(nil)
	AutoBar.stickyMode = false
end

function AutoBar:MoveBarModeOn()
	LibKeyBound:Deactivate()
	AutoBar:MoveButtonsModeOff()
	LibStickyFrames:SetGroup(true)
	AutoBar.stickyMode = true
end

function AutoBar.OnSetGroup(group)
--print("AutoBar.SetStickyMode stickyMode " .. tostring(stickyMode))
	AutoBar.stickyMode = false
	if (group == true) then
		AutoBar.stickyMode = true
	elseif (type(group) == "table") then
		for i, bar in pairs(AutoBar.barList) do
			if (bar.sharedLayoutDB.enabled and LibStickyFrames:InFrameGroup(bar.frame, group)) then
				AutoBar.stickyMode = true
				break
			end
		end
	end
	if (AutoBarFuBar) then
		AutoBarFuBar:UpdateDisplay()
	end
end

function AutoBar:OnClick(event, frame, button)
--print("AutoBar.Class.Bar.OnClick frame " .. tostring(frame) .. " button " .. tostring(button) .. " lolwut " .. tostring(lolwut))
	local bar = frame.class
	if (bar and bar.sharedLayoutDB) then
		if (button == "RightButton") then
	--print("AutoBar.Class.Bar.OnClick ShowBarOptions frame " .. tostring(frame) .. " button " .. tostring(button))
			--bar:ShowBarOptions()
		elseif (button == "LeftButton") then
	--print("AutoBar.Class.Bar.OnClick ToggleVisibilty frame " .. tostring(frame) .. " button " .. tostring(button))
			bar:ToggleVisibilty()
		end
	end
end

--[[
function AutoBar:OnStartFrameMoving()
--print("AutoBar.OnStartFrameMoving")
end

--]]
function AutoBar:OnStopFrameMoving(event, frame, point, stickToFrame, stickToPoint, stickToX, stickToY)
	local bar = frame.class
	if (bar and bar.sharedPositionDB) then
--print("AutoBar:OnStopFrameMoving " .. tostring(bar.barName) .. " frame " .. tostring(frame) .. " point " .. tostring(point) .. " stickToFrame " .. tostring(stickToFrame) .. " stickToPoint " .. tostring(stickToPoint))
		bar:StickTo(frame, point, stickToFrame, stickToPoint, stickToX, stickToY)
		bar:PositionSave()
	end
end

function AutoBar:OnStickToFrame(event, frame, point, stickToFrame, stickToPoint, stickToX, stickToY)
	local bar = frame.class
--print("AutoBar:OnStickToFrame " .. tostring(bar.barName) .. " frame " .. tostring(frame) .. " point " .. tostring(point) .. " stickToFrame " .. tostring(stickToFrame) .. " stickToPoint " .. tostring(stickToPoint))
	if (bar and bar.sharedPositionDB) then
		bar:StickTo(frame, point, stickToFrame, stickToPoint, stickToX, stickToY)
		bar:PositionSave()
	end
end


function AutoBar:MoveButtonsModeToggle()
	if AutoBar.moveButtonsMode then
		AutoBar:MoveButtonsModeOff()
	else
		AutoBar:MoveButtonsModeOn()
	end
end

function AutoBar:MoveButtonsModeOn()
	AutoBar:MoveBarModeOff()
	LibKeyBound:Deactivate()
	AutoBar.moveButtonsMode = true
	for i, bar in pairs(self.barList) do
		if (bar.sharedLayoutDB.enabled) then
			bar:MoveButtonsModeOn()
		end
	end
	self:UpdateActive()
	if (AutoBarFuBar) then
		AutoBarFuBar:UpdateDisplay()
	end
end

function AutoBar:MoveButtonsModeOff()
	AutoBar.moveButtonsMode = nil
	for i, bar in pairs(self.barList) do
		if bar.sharedLayoutDB.enabled then
			bar:MoveButtonsModeOff()
		end
	end
	self:UpdateActive()
	if (AutoBarFuBar) then
		AutoBarFuBar:UpdateDisplay()
	end
end


--
-- ConfigMode support
--

-- Create the global table if it does not exist yet
CONFIGMODE_CALLBACKS = CONFIGMODE_CALLBACKS or {}

-- Declare our handler
CONFIGMODE_CALLBACKS["AutoBar"] = function(action)
	if (action == "ON") then
		AutoBar:MoveBarModeOn()
	elseif (action == "OFF") then
		AutoBar:MoveBarModeOff()
	end
end


--
-- Drag and Drop support
--

-- Retrieve last object dragged from
function AutoBar:GetDraggingObject()
	return AutoBar.fromObject
end

-- Record last object dragged from
function AutoBar:SetDraggingObject(fromObject)
	AutoBar.fromObject = fromObject
end


--/dump AutoBar.db.account.barList["AutoBarClassBarBasic"].buttonKeys[16]
--/dump AutoBar.moveButtonsMode
--/script AutoBar.db.account.logEvents = true
--/script AutoBar.db.account.logEvents = nil
--/script LibStub("LibKeyBound-1.0"):SetColorKeyBoundMode(0.75, 1, 0, 0.5)
--/script DEFAULT_CHAT_FRAME:AddMessage("" .. tostring())
--/print GetMouseFocus():GetName()

function AutoBar:Print(...)
	print(...)
end

function AutoBar:Dump(o, p_max_depth)
	local depth = p_max_depth or 5
	if type(o) == 'table' and (depth >= 1)  then
		depth = depth - 1
		local s = '{ '
		for k,v in pairs(o) do
			if type(k) ~= 'number' then
				k = '"'..k..'"'
			end
			s = s .. '['..k..'] = ' .. AutoBar:Dump(v, depth) .. ','
		end
		return s .. '} '
	else
		return tostring(o)
	end
end

local StupidLogEnabled = false

function AutoBar:StupidLogEnable(p_toggle)
	StupidLogEnabled = p_toggle
end

function AutoBar:StupidLog(p_text)

	if (StupidLogEnabled) then
		AutoBar.db.account.stupidlog = AutoBar.db.account.stupidlog .. p_text
	end

end

function AutoBar:MakeSet(list)
   local set = {}
   for _, l in ipairs(list) do set[l] = true end
   return set
 end

AutoBar.set_mana_users = AutoBar:MakeSet{"DRUID","MAGE","MONK","PRIEST","PALADIN","SHAMAN","WARLOCK"}

function AutoBar:ClassUsesMana(class_name)

	return AutoBar.set_mana_users[class_name]

end

local function table_pack(...)
  return { n = select("#", ...), ... }
end

function AutoBar:LogWarning(...)

	local message = "";
	local args = table_pack(...)
	for i=1,args.n do
		message = message .. tostring(args[i]) .. " "
	end
	table.insert(AutoBar.warning_log, message)

end

function AutoBar:DumpWarningLog()

	if next(AutoBar.warning_log) == nil then --Empty log
		return
	end

	AutoBar:Print("Warnings/Errors occured in AutoBar:")

	for i,v in ipairs(AutoBar.warning_log) do
		AutoBar:Print(v)
	end

end

function AutoBar:LoggedGetSpellInfo(p_spell_id)

	local ret_val = {GetSpellInfo(p_spell_id)} --table-ify

	if next(ret_val) == nil then
		AutoBar:LogWarning("Invalid Spell ID:" .. p_spell_id)
	end

	return unpack(ret_val)

end

function AutoBar:DebugItemCategory(p_category_name)

	print("Category name:", p_category_name)
	local pt_set = LibStub("LibPeriodicTable-3.1"):GetSetTable(p_category_name)
	local set_size = AutoBar:tcount(pt_set) - 1 --PTSets have a "set" member which is the set name
	print("Size of PT Set:", set_size)
	
	local items = AutoBarCategoryList[p_category_name].items
	local item_size = AutoBar:tcount(items)
	
	print("# Category Items:", item_size)

	if(item_size) then
		local diff_set = AutoBar:SetDifference(pt_set, items)
		print("In PT, but not in items:", table.concat(diff_set, ","))
		diff_set = AutoBar:SetDifference(items, pt_set)
		print("In items, but not in PT:", table.concat(diff_set, ","))
	end

end

--/dump LibStub("LibPeriodicTable-3.1"):GetSetTable("Muffin.Flask")
--/dump AutoBarCategoryList["Muffin.Flask"].castList
--/dump AutoBarCategoryList["Muffin.Flask"].items
--/dump /run AutoBar:DebugItemCategory("Muffin.Flask")

-- tcount: count table members even if they're not indexed by numbers
function AutoBar:tcount(p_table)

	if(p_table == nil) then return nil; end

	local n = #p_table
	if (n == 0) then
		for k in pairs(p_table) do
			n = n + 1;
		end
	end
	return n
end

function AutoBar:SetDifference(p_set1, p_set2)
	if(p_set1 == nil) then return {} end;
	if(p_set2 == nil) then return p_set1 end;
	
	local s = {}
	for e in pairs(p_set1) do
		if not p_set2[e] then s[tostring(e)] = true end
	end
	return s
end

function AutoBar:FindNamelessCategories()

	local nameless = ""
	for key in pairs(AutoBarCategoryList) do
		if(AutoBar.locale[key] == nil) then
			nameless = nameless .. "|n" .. key
		end
	end

	return nameless
end

function AutoBar:ClearMissingItemFlag()

	AutoBar.missing_items = false;

end

local l_missing_item_count = 0
function AutoBar:SetMissingItemFlag(p_item)

	AutoBar.missing_items = true;

	l_missing_item_count = l_missing_item_count + 1
	--print("AutoBar.missing_items = true, (", p_item, ") - ", l_missing_item_count)

end

