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


local _, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

local LibKeyBound = LibStub("LibKeyBound-1.0")
local LibStickyFrames = LibStub("LibStickyFrames-2.0")
local AceOO = AceLibrary("AceOO-2.0")
local Masque = LibStub("Masque", true)
local AceCfgDlg = LibStub("AceConfigDialog-3.0")
local _

--AutoBar = AceLibrary("AceAddon-2.0"):new("AceDB-2.0");

local AutoBar = AutoBar
local ABGCS = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject
local tick = ABGData.TickScheduler

local ABSchedulerTickLength = 0.04

AutoBar.inWorld = false
AutoBar.inCombat = nil		-- For item use restrictions
AutoBar.inBG = false		-- For battleground only items
AutoBar.initialized = false;

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

AutoBar.events = {}

AutoBarMountIsQiraji = {[25953] = 1;[26056] = 1;[26054] = 1; [26055] = 1}


AutoBar.visibility_driver_string = "[vehicleui] hide; [possessbar] hide; show"

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



-- Single parent for key binding overides, and event handling
AutoBar.frame = CreateFrame("Frame", "AutoBarEventFrame", UIParent)

AutoBar.frame:SetScript("OnEvent",
	function(self, event, ...)

		-- The BAG_UPDATE event is now trivial in its execution; it just sets a boolean so don't throttle it
		-- PLAYER_ENTERING_WORLD runs before the throttling stuff is set up and doesn't need it anyway
		if(event == "BAG_UPDATE" or event == "PLAYER_ENTERING_WORLD") then
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

AutoBar.frame:RegisterEvent("PLAYER_ENTERING_WORLD")


-- Process a macro to determine what its "action" is:
--		a spell
--		an item
function AutoBar:GetActionForMacroBody(p_macro_body)
	local debug = false
	local action
	local tooltip
	local icon

	--if debug then print("Finding icon for", p_macro_body); end;
	--print(debugstack())
	local show_action = string.match(p_macro_body, "#show%s+([^\n]+)")
	if(show_action) then
		action = show_action
		--if debug then print("show_action:", show_action); end;
	else
		local show_tt_action = string.match(p_macro_body, "#showtooltip%s+([^\n]+)")
		if(show_tt_action) then
			--if debug then print("show_tt_action:", show_tt_action); end;
			action = show_tt_action
			tooltip = select(2, GetItemInfo(action)) or GetSpellLink(action)
			--if debug then print("   ", show_tt_action,tooltip); end;
		end
	end

	if(not action) then
		local cast_action = string.match(p_macro_body, "/cast%s+([^\n]+)")

		local use_action = string.match(p_macro_body, "/use%s+([^\n]+)")

		if(cast_action or use_action) then
			action = SecureCmdOptionParse(cast_action or use_action)

			--if there are qualifiers on the action (like [mounted]) and they all parse away, it returns null
			if(action) then
				tooltip = select(2, GetItemInfo(action)) or GetSpellLink(action)
			end
		end

	end

	if(action) then
		icon = select(3, GetSpellInfo(action)) or ABGCS:GetIconForItemID(action)
	end

	if(tooltip == "") then tooltip = nil; end; -- If not found, GetSpellLink can return an empty string

	return action, icon, tooltip
end


function AutoBar:IsInLockDown()

	return AutoBar.inCombat or InCombatLockdown() --or UnitInVehicle("player")

end


function AutoBar:ConfigToggle()
	if (not InCombatLockdown()) then
			AutoBar:OpenOptions()
	end
end


function AutoBar:InitializeZero()

	AutoBar.player_faction_name = UnitFactionGroup("player")
	AutoBar.currentPlayer = UnitName("player") .. " - " .. GetRealmName();
	_, AutoBar.CLASS = UnitClass("player")
	AutoBar.NiceClass = string.sub(AutoBar.CLASS, 1, 1) .. string.lower(string.sub(AutoBar.CLASS, 2))
	AutoBar.CLASSPROFILE = "_" .. AutoBar.CLASS;

	AutoBar:RegisterDB("AutoBarDB", nil, "class")

	AutoBar:LogEvent("InitializeZero")
	AutoBar:InitializeDB()
	AutoBarCategory:Upgrade()
	AutoBar:InitializeOptions()
	AutoBar:Initialize()

	ABGCS:UpdateCategories()
	self:RegisterOverrideBindings()
	AutoBar.frame:RegisterEvent("UPDATE_BINDINGS")


	AutoBar.frame:RegisterEvent("BAG_UPDATE")
	AutoBar.frame:RegisterEvent("BAG_UPDATE_DELAYED")
	AutoBar.frame:RegisterEvent("LEARNED_SPELL_IN_TAB")

	if(AutoBar.db.account.handle_spell_changed) then
		AutoBar.frame:RegisterEvent("SPELLS_CHANGED")
	end
	AutoBar.frame:RegisterEvent("ACTIONBAR_UPDATE_USABLE")


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
	AutoBar.frame:RegisterEvent("GET_ITEM_INFO_RECEIVED")

	LibKeyBound.RegisterCallback(self, "LIBKEYBOUND_ENABLED")
	LibKeyBound.RegisterCallback(self, "LIBKEYBOUND_DISABLED")
	LibKeyBound.RegisterCallback(self, "LIBKEYBOUND_MODE_COLOR_CHANGED")

	LibStickyFrames.RegisterCallback(self, "OnSetGroup")
	LibStickyFrames.RegisterCallback(self, "OnClick")
--	LibStickyFrames.RegisterCallback(self, "OnStartFrameMoving")
	LibStickyFrames.RegisterCallback(self, "OnStopFrameMoving")
	LibStickyFrames.RegisterCallback(self, "OnStickToFrame")
end



local logItems = {}	-- n = startTime
local logMemory = {}	-- n = startMemory

local event_name_colour = "|cFFFFFF7F"

function AutoBar:LogEvent(eventName, arg1)
	if (AutoBar.db.account.logMemory) then
		UpdateAddOnMemoryUsage()
		local memory = GetAddOnMemoryUsage("AutoBar")
		print(eventName, "memory" , memory)
	end
	if (AutoBar.db.account.logEvents) then
		if (arg1) then
			print(event_name_colour .. eventName .. "|r", "arg1" , arg1, "time:", GetTime(), memString, memory)
		else
			print(event_name_colour .. eventName .. "|r", "time:", GetTime())
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
					print(event_name_colour .. eventName .. "|r", arg1, "time:", elapsed)
				else
					print(event_name_colour .. eventName .. "|r", "time:", elapsed)
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



function AutoBar.events:GET_ITEM_INFO_RECEIVED(p_item_id)
	AutoBar:LogEventStart("GET_ITEM_INFO_RECEIVED", p_item_id)
--local item_name = GetItemInfo(p_item_id)
--print("GET_ITEM_INFO_RECEIVED", p_item_id, item_name)
	AutoBar:ClearMissingItemFlag();
	ABGCS:ABScheduleUpdate(tick.UpdateItemsID)

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


function AutoBar.events:PLAYER_ENTERING_WORLD()
--print("   PLAYER_ENTERING_WORLD")

	if (not AutoBar.initialized) then
		AutoBar:InitializeZero();
		AutoBar.initialized = true;
	end

	if (not AutoBar.inWorld) then
		AutoBar.inWorld = true;

		--AutoBar:DumpWarningLog()

		AB.show_whats_new();
	end

	AutoBar.frame:UnregisterEvent("PLAYER_ENTERING_WORLD")

	ABGCS:ABScheduleUpdate(tick.UpdateCategoriesID);

	C_Timer.After(ABSchedulerTickLength, AutoBar.ABSchedulerTick)
end


function AutoBar.events:PLAYER_LEAVING_WORLD()
	AutoBar.inWorld = false;
end


function AutoBar.events:BAG_UPDATE(arg1)
	AutoBar:LogEventStart("BAG_UPDATE")
	if (AutoBar.inWorld and arg1 <= NUM_BAG_SLOTS) then
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
		ABGCS:ABScheduleUpdate(tick.UpdateItemsID)
	end

	AutoBar:LogEventEnd("BAG_UPDATE_DELAYED")

end

function AutoBar.events:BAG_UPDATE_COOLDOWN(arg1)
	AutoBar:LogEventStart("BAG_UPDATE_COOLDOWN")

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

	if (InCombatLockdown()) then
		for buttonName, button in pairs(AutoBar.buttonList) do
			button:UpdateUsable()
		end
	else
		ABGCS:ABScheduleUpdate(tick.UpdateObjectsID)
	end
end


function AutoBar.events:UPDATE_SHAPESHIFT_FORMS(arg1)
	AutoBar:LogEvent("UPDATE_SHAPESHIFT_FORMS", arg1)

	if (InCombatLockdown()) then
		for buttonName, button in pairs(AutoBar.buttonList) do
			button:UpdateUsable()
		end
	end

	ABGCS:ABScheduleUpdate(tick.UpdateSpellsID)
end


function AutoBar.events:UPDATE_BINDINGS()
	self:RegisterOverrideBindings()
	ABGCS:ABScheduleUpdate(tick.UpdateButtonsID)
end


function AutoBar.events:LEARNED_SPELL_IN_TAB(arg1)
	AutoBar:LogEvent("LEARNED_SPELL_IN_TAB", arg1)
	ABGCS:ABScheduleUpdate(tick.UpdateSpellsID)
end


function AutoBar.events:SPELLS_CHANGED(arg1)

	if(not AutoBar.db.account.handle_spell_changed) then
		return
	end
	AutoBar:LogEvent("SPELLS_CHANGED", arg1)
	ABGCS:ABScheduleUpdate(tick.UpdateSpellsID)
end



function AutoBar.events:PLAYER_CONTROL_GAINED()
	AutoBar:LogEvent("PLAYER_CONTROL_GAINED", arg1)
	ABGCS:ABScheduleUpdate(tick.UpdateButtonsID)
end



function AutoBar.events:PLAYER_REGEN_ENABLED(arg1)
	AutoBar:LogEvent("PLAYER_REGEN_ENABLED", arg1)
	AutoBar.inCombat = nil

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

	ABGCS:UpdateActive()
	AceCfgDlg:Close(appName)
end


function AutoBar.events:PLAYER_ALIVE(arg1)
	AutoBar:LogEvent("PLAYER_ALIVE", arg1)
	ABGCS:ABScheduleUpdate(tick.UpdateButtonsID)
end


function AutoBar.events:UNIT_AURA(arg1)
	if (AutoBar:IsInLockDown()) then
		for buttonName, button in pairs(AutoBar.buttonList) do
			button:UpdateUsable()
		end
	else
		AutoBar:LogEvent("UNIT_AURA", arg1)
		ABGCS:ABScheduleUpdate(tick.UpdateButtonsID)
	end
end


function AutoBar.events:PLAYER_UNGHOST(arg1)
	AutoBar:LogEvent("PLAYER_UNGHOST", arg1)
	ABGCS:ABScheduleUpdate(tick.UpdateButtonsID)
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
			ABGCS:UpdateActive();
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
--		Rescan all registered spells
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
	ABGCS:UpdateActive()
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
	ABGCS:UpdateActive()
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


AutoBar.set_mana_users = ABGCS:MakeSet{"DRUID","HUNTER","MAGE","PRIEST","PALADIN","SHAMAN","WARLOCK"}

function AutoBar:ClassUsesMana(class_name)

	return AutoBar.set_mana_users[class_name]

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

function AutoBar:LoggedGetSpellInfo(p_spell_id, p_spell_name)

	local ret_val = {GetSpellInfo(p_spell_id)} --table-ify

	if next(ret_val) == nil then
		ABGCS:LogWarning("Invalid Spell ID:" .. p_spell_id .. " : " .. (p_spell_name or "Unknown"));
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
		if(AutoBarGlobalDataObject.locale[key] == nil) then
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






-------------------------------------------------------------------------
--
-- AutoBar Scheduler
--
-------------------------------------------------------------------------

function ABGCS:ABScheduleUpdate(p_update_id)

--print("ABGCS:ABScheduleUpdate", p_update_id);
	if ((tick.ScheduledUpdate == nil) or (p_update_id < tick.ScheduledUpdate)) then
		tick.ScheduledUpdate = p_update_id;
	end

end


function AutoBar:ABSchedulerTick()
--print("AutoBar:ABSchedulerTick", "ScheduledUpdate:", ABGData.TickScheduler.ScheduledUpdate)
	C_Timer.After(ABSchedulerTickLength, AutoBar.ABSchedulerTick)

	--If we're in combat, catch it on the next tick so we don't cause a hitch in gameplay
	if (AutoBar:IsInLockDown()) then
		return;
	end

	if(tick.ScheduledUpdate == nil or tick.ScheduledUpdate == tick.UpdateCompleteID) then	--Nothing scheduled to do, so return
		return;
	end

	if(tick.ScheduledUpdate == tick.UpdateCategoriesID) then
		tick.ScheduledUpdate = ABGCS:UpdateCategories(tick.BehaveTicker);
	elseif(tick.ScheduledUpdate == tick.UpdateSpellsID) then
		tick.ScheduledUpdate = ABGCS:UpdateSpells(tick.BehaveTicker);
	elseif(tick.ScheduledUpdate == tick.UpdateObjectsID) then
		tick.ScheduledUpdate = ABGCS:UpdateObjects(tick.BehaveTicker);
	elseif(tick.ScheduledUpdate == tick.UpdateItemsID) then
		tick.ScheduledUpdate = ABGCS:UpdateItems(false, tick.BehaveTicker);
	elseif(tick.ScheduledUpdate == tick.UpdateButtonsID) then
		tick.ScheduledUpdate = ABGCS:UpdateButtons(tick.BehaveTicker);
	else
print("     ", "Not sure what's happening", tick.ScheduledUpdate)
	end


end

function ABGCS:UpdateCategories(p_behaviour)
--	print("ABGCS:UpdateCategories");

	--TODO: Review sticky frame handling. This code could be cleaned up
	--TODO: Split this out to its own function
	if (tick.OtherStickyFrames) then
		local delete = true
		for index, stickyFrame in pairs(tick.OtherStickyFrames) do
			if (_G[stickyFrame]) then
--print("     ABGCS:UpdateCategories " .. tostring(index) .. "  " .. tostring(stickyFrame))
				LibStickyFrames:RegisterFrame(_G[stickyFrame])
			else
				delete = false
			end
		end
		if (delete) then
			otherStickyFrames = nil
		end
	end

	local ret = tick.UpdateCompleteID
	if (not InCombatLockdown()) then
		AutoBar:LogEventStart("ABGCS:UpdateCategories")
		AutoBarCategory:UpdateCustomCategories()
		ABGCS:UpdateSpells();	--We don't pass the behaviour flag along since we want calls to UpdateCategories to complete immediately
		AutoBar:LogEventEnd("ABGCS:UpdateCategories")
	else
		AutoBar:LogEvent("ABGCS:UpdateCategories InCombatLockdown. Scheduling UpdateCategories")
		ret = tick.UpdateCategoriesID
	end

	return ret;
end

function ABGCS:UpdateSpells(p_behaviour)
	AutoBar:LogEventStart("ABGCS:UpdateSpells")

	AutoBarSearch.stuff:ScanSpells()
	AutoBarSearch.stuff:ScanMacros()
	AutoBarCategory:UpdateCategories()

	ABGCS:UpdateObjects();	--We don't pass the behaviour flag along since we want calls to UpdateSpells to complete immediately

	AutoBar:LogEventEnd("ABGCS:UpdateSpells")

	return tick.UpdateCompleteID;
end

function ABGCS:UpdateObjects(p_behaviour)

	AutoBar:LogEventStart("ABGCS:UpdateObjects")
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

	tick.FullScanItemsFlag = true

	local ret = tick.UpdateItemsID;
	if(p_behaviour ~= tick.BehaveTicker) then	-- Run sequentially instead of letting the ticker get the next step
		ABGCS:UpdateItems();
		ret = tick.UpdateCompleteID;
	end

	AutoBar:LogEventEnd("ABGCS:UpdateObjects")

	return ret;

end


function ABGCS:UpdateItems(p_behaviour)

	AutoBar:LogEventStart("ABGCS:UpdateItems")

	if(tick.FullScanItemsFlag) then
		AutoBarSearch:Reset();
		tick.FullScanItemsFlag = false;
	else
		AutoBarSearch:UpdateScan()
	end

	ABGCS:UpdateAttributes(p_behaviour)

	AutoBar:LogEventEnd("ABGCS:UpdateItems")
	return tick.UpdateCompleteID;

end

-- Based on the current Scan results, update the Button and Popup Attributes
-- Create Popup Buttons as needed
function ABGCS:UpdateAttributes(p_behaviour)
	AutoBar:LogEventStart("ABGCS:UpdateAttributes")
	for barKey, bar in pairs(AutoBar.barList) do
		bar:UpdateAttributes()
	end

	ABGCS:UpdateActive(p_behaviour)

	AutoBar:LogEventEnd("ABGCS:UpdateAttributes")
end

-- Based on the current Scan results, Bars and their Buttons, determine the active Buttons
function ABGCS:UpdateActive(p_behaviour)
	AutoBar:LogEventStart("ABGCS:UpdateActive")
	for barKey, bar in pairs(AutoBar.barList) do
		bar:UpdateActive()
		bar:RefreshLayout()
	end

	ABGCS:UpdateButtons(p_behaviour)

	AutoBar:LogEventEnd("ABGCS:UpdateActive")
end

-- Based on the active Bars and their Buttons display them
function ABGCS:UpdateButtons(p_behaviour)
	AutoBar:LogEventStart("AutoBar:UpdateButtons")
	for buttonName, button in pairs(AutoBar.buttonListDisabled) do
		--if (buttonKey == "AutoBarButtonCharge") then print("   ABGCS:UpdateButtons Disabled " .. buttonName); end;
		button:Disable()
		--I don't see why we should update all of these if they're disabled.
		--button:UpdateCooldown()
		--button:UpdateCount()
		--button:UpdateHotkeys()
		--button:UpdateIcon()
		--button:UpdateUsable()
	end
	for buttonKey, button in pairs(AutoBar.buttonList) do
		--if (buttonKey == "AutoBarButtonCharge") then print("   ABGCS:UpdateButtons Enabled " .. buttonKey); end;
		assert(button.buttonDB.enabled, "In list but disabled " .. buttonKey)
		button:SetupButton()
		button:UpdateCooldown()
		button:UpdateCount()
		button:UpdateHotkeys()
		button:UpdateIcon()
		button:UpdateUsable()
	end
	AutoBar:LogEventEnd("ABGCS:UpdateButtons", " #buttons " .. tostring(# AutoBar.buttonList))

	return tick.UpdateCompleteID;

end

