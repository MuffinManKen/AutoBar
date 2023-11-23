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


local ADDON_NAME, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

local _G = _G
local Masque = LibStub("Masque", true)
local AceCfgDlg = LibStub("AceConfigDialog-3.0")
local _
local L = AutoBarGlobalDataObject.locale

local AutoBar = AutoBar
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

AB.events = {}

AutoBar.visibility_driver_string = "[vehicleui] hide; [petbattle] hide; [possessbar] hide; show"

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
	function(_self, event, ...)

		-- The BAG_UPDATE event is now trivial in its execution; it just sets a boolean so don't throttle it
		-- PLAYER_ENTERING_WORLD runs before the throttling stuff is set up and doesn't need it anyway
		if(event == "BAG_UPDATE" or event == "PLAYER_ENTERING_WORLD") then
			AB.events[event]( ...)
			return
		end

		--If it's a GET_ITEM_INFO_RECEIVED and there aren't any items we don't know, ignore it
		if(event == "GET_ITEM_INFO_RECEIVED" and not AutoBar.missing_items) then
			return
		end

		if(AutoBarDB2.settings.throttle_event_limit > 0) then
			local timer_name = event .. "_last_tick"
			local now = GetTime()
			AutoBar[timer_name] = AutoBar[timer_name] or 0

			if ((now - AutoBar[timer_name]) < AutoBarDB2.settings.throttle_event_limit) then
				if (AutoBarDB2.settings.log_throttled_events) then print (" AutoBar Skipping " .. event .. "(" .. AutoBar[timer_name] .. ", " .. now .. ")", ...) end
				return
			end
			AutoBar[timer_name] = now
		end

		AB.events[event]( ...)
	end)

AutoBar.frame:RegisterEvent("PLAYER_ENTERING_WORLD")


-- Process a macro to determine what its "action" is:
--		a spell
--		an item
function AB.GetActionForMacroBody(p_macro_body)
	--local debug = false
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
			tooltip = select(2, GetItemInfo(action)) or AB.GetSpellLink(action)
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
				tooltip = select(2, GetItemInfo(action)) or AB.GetSpellLink(action)
			end
		end

	end

	if(action) then
		icon = select(3, GetSpellInfo(action)) or AB.GetIconForItemID(action)
	end

	return action, icon, tooltip
end


function AutoBar:IsInLockDown()

	return self.inCombat or InCombatLockdown() or (C_PetBattles and C_PetBattles.IsInBattle()) or (UnitInVehicle and UnitInVehicle("player"))

end

-- This function needs to be globally accessible for Bindings.xml
function AutoBar.ConfigToggle()
	if (not InCombatLockdown()) then
		AutoBar:OpenOptions()
	end
end


function AutoBar:InitializeZero()

	AutoBar.player_faction_name = UnitFactionGroup("player")
	AutoBar.currentPlayer = UnitName("player") .. " - " .. GetRealmName();
	_, AutoBar.CLASS = UnitClass("player")
	AutoBar.NiceClass = string.sub(AutoBar.CLASS, 1, 1) .. string.lower(string.sub(AutoBar.CLASS, 2))

	AutoBar.version = GetAddOnMetadata(ADDON_NAME, "Version")

	AutoBar.InitializeDB()
	AutoBar:InitializeOptions()
	AutoBar.Initialize()

	AB.UpdateCategories()
	AB.RegisterOverrideBindings()
	AutoBar.frame:RegisterEvent("UPDATE_BINDINGS")


	AutoBar.frame:RegisterEvent("BAG_UPDATE")
	AutoBar.frame:RegisterEvent("BAG_UPDATE_DELAYED")
	AutoBar.frame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	AutoBar.frame:RegisterEvent("LEARNED_SPELL_IN_TAB")
	AutoBar.frame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")

	if(AutoBarDB2.settings.handle_spell_changed) then
		AutoBar.frame:RegisterEvent("SPELLS_CHANGED")
	end
	AutoBar.frame:RegisterEvent("ACTIONBAR_UPDATE_USABLE")

	if (ABGData.is_mainline_wow) then
		AutoBar.frame:RegisterEvent("COMPANION_LEARNED")
		AutoBar.frame:RegisterEvent("QUEST_ACCEPTED")
		AutoBar.frame:RegisterEvent("QUEST_LOG_UPDATE")
		AutoBar.frame:RegisterEvent("TOYS_UPDATED")
	end


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

	AB.LibKeyBound.RegisterCallback(self, "LIBKEYBOUND_ENABLED")
	AB.LibKeyBound.RegisterCallback(self, "LIBKEYBOUND_DISABLED")
	AB.LibKeyBound.RegisterCallback(self, "LIBKEYBOUND_MODE_COLOR_CHANGED")

	AB.LibStickyFrames.RegisterCallback(self, "OnSetGroup")
	AB.LibStickyFrames.RegisterCallback(self, "OnClick")
	--	AB.LibStickyFrames.RegisterCallback(self, "OnStartFrameMoving")
	AB.LibStickyFrames.RegisterCallback(self, "OnStopFrameMoving")
	AB.LibStickyFrames.RegisterCallback(self, "OnStickToFrame")
end




-- Will not update if set during combat
function AB.RegisterOverrideBindings()
	AB.LogEventStart("RegisterOverrideBindings")

	ClearOverrideBindings(AutoBar.frame)
	for buttonKey, _buttonDB in pairs(AutoBar.buttonDBList) do
		AutoBar.Class.Button:UpdateBindings(buttonKey, buttonKey .. "Frame")
	end

	AB.LogEventEnd("RegisterOverrideBindings")
end



function AB.events.GET_ITEM_INFO_RECEIVED(p_item_id)
	AB.LogEventStart("GET_ITEM_INFO_RECEIVED")
	--print("GET_ITEM_INFO_RECEIVED", p_item_id, GetItemInfo(p_item_id))
	AB.ClearMissingItemFlag();
	AB.ABScheduleUpdate(tick.UpdateItemsID)

	AB.LogEventEnd("GET_ITEM_INFO_RECEIVED", p_item_id)
end

-- Given an item link, this adds the item to the given category
-- NOTE: No effort is made to avoid adding an item that as already been added. As long as the list is small, this isn't worth worrying about.
local function add_item_to_dynamic_category(p_item_link, p_category_name)
	local debug_me = false
	local category = AutoBarCategoryList[p_category_name]

	if(debug_me) then print("Adding", p_item_link, " to ", p_category_name, AB.Dump(category)); end;

	local item_name, item_id = AutoBar.ItemLinkDecode(p_item_link)
	category.items[#category.items + 1] = item_id

	if(debug_me) then print(item_name, item_id, "Num Items:", #category.items); end;
end

if (ABGData.is_mainline_wow) then

	function AB.events.QUEST_ACCEPTED(p_quest_index)
		AB.LogEventStart("QUEST_ACCEPTED")

		local link = GetQuestLogSpecialItemInfo(p_quest_index)
		if(link) then
			add_item_to_dynamic_category(link, "Dynamic.Quest")
			AB.ABScheduleUpdate(tick.UpdateObjectsID)
		end

		AB.LogEventEnd("QUEST_ACCEPTED", p_quest_index)
	end

	function AB.events.QUEST_LOG_UPDATE(p_arg1)
		AB.LogEventStart("QUEST_LOG_UPDATE")

		--Make sure we're in the world. Should always be the case, but stuff loads in odd orders
		if(AutoBar.inWorld and AutoBarCategoryList["Dynamic.Quest"]) then
			local num_entries, _num_quests = AB.GetNumQuestLogEntries()	--TODO: Remove this after Shadowlands and Classic no longer need the shim
			for i = 1, num_entries do
				local link = GetQuestLogSpecialItemInfo(i)
				if(link) then
					add_item_to_dynamic_category(link, "Dynamic.Quest")
					AB.ABScheduleUpdate(tick.UpdateObjectsID)
				end
			end
		end

		AB.LogEventEnd("QUEST_LOG_UPDATE", p_arg1)

	end

	function AB.events.COMPANION_LEARNED()
		local need_update = false;

		AB.LogEventStart("COMPANION_LEARNED")

		local button = AutoBar.buttonList["AutoBarButtonMount"]
		if (button) then
			button:Refresh(button.parentBar, button.buttonDB, true)
		end

		if(need_update) then
			AB.ABScheduleUpdate(tick.UpdateCategoriesID);
		end

		AB.LogEventEnd("COMPANION_LEARNED")
	end


	function AB.events.TOYS_UPDATED(p_item_id, p_new)
		AB.LogEventStart("TOYS_UPDATED")

		if(false) then AB.LogWarning("|nTOYS_UPDATED", p_item_id, p_new); end

		if(p_item_id == nil or p_new == true) then
			AB.ABScheduleUpdate(tick.ResetSearch)
		end

		AB.LogEventEnd("TOYS_UPDATED", p_item_id, p_new)

	end

end


function AB.events.PLAYER_ENTERING_WORLD()
	AB.LogWarning("* PLAYER_ENTERING_WORLD")

--UIParentLoadAddOn("Blizzard_DebugTools")
--UIParentLoadAddOn("Blizzard_EventTrace")


	if (not AutoBar.initialized) then
		AutoBar:InitializeZero();
		AutoBar.initialized = true;
	end

	if (not AutoBar.inWorld) then
		AutoBar.inWorld = true;

		--AutoBar:DumpWarningLog()

		AutoBarDB2.whatsnew_version = MUFFIN_WHATS_NEW_QUEUE.AddConditionalEntry({
			addon_name = ADDON_NAME,
			text = AB.WHATSNEW_TEXT,
			version = AutoBarDB2.whatsnew_version,
			force_show = false,
		})

		MUFFIN_WHATS_NEW_QUEUE.Show()
	end


	if(AutoBarDB2.settings.hack_PetActionBarFrame and PetActionBarFrame) then
		PetActionBarFrame:EnableMouse(false);
	end

	AutoBar.frame:UnregisterEvent("PLAYER_ENTERING_WORLD")

	AB.ABScheduleUpdate(tick.UpdateCategoriesID);

	C_Timer.After(ABSchedulerTickLength, AutoBar.ABSchedulerTick)
end


function AB.events.PLAYER_LEAVING_WORLD()
	AutoBar.inWorld = false;
end


function AB.events.BAG_UPDATE(p_bag_idx)
	AB.LogEventStart("BAG_UPDATE")

	if (AutoBar.inWorld and p_bag_idx <= NUM_BAG_SLOTS) then
		AutoBarSearch:MarkBagDirty(p_bag_idx)
	end

	AB.LogEventEnd("BAG_UPDATE", p_bag_idx)

end

function AB.events.BAG_UPDATE_DELAYED()
	AB.LogEventStart("BAG_UPDATE_DELAYED")

	if (InCombatLockdown()) then
		for _button_name, button in pairs(AutoBar.buttonList) do
			button:UpdateCount()
		end
	else
		AB.ABScheduleUpdate(tick.UpdateItemsID)
	end

	AB.LogEventEnd("BAG_UPDATE_DELAYED")

end


function AB.events.PLAYER_EQUIPMENT_CHANGED()
	AB.LogEventStart("PLAYER_EQUIPMENT_CHANGED")

	AutoBarSearch:MarkInventoryDirty()

	AB.ABScheduleUpdate(tick.UpdateItemsID)

	AB.LogEventEnd("PLAYER_EQUIPMENT_CHANGED")

end



function AB.events.BAG_UPDATE_COOLDOWN(p_arg1)
	AB.LogEventStart("BAG_UPDATE_COOLDOWN")

	for _button_name, button in pairs(AutoBar.buttonList) do
		button:UpdateCooldown()
	end

	AB.LogEventEnd("BAG_UPDATE_COOLDOWN", p_arg1)
end


function AB.events.SPELL_UPDATE_COOLDOWN(arg1)
	AB.LogEventStart("SPELL_UPDATE_COOLDOWN")

	for _button_name, button in pairs(AutoBar.buttonList) do
		button:UpdateCooldown()
	end

	AB.LogEventEnd("SPELL_UPDATE_COOLDOWN", arg1)
end



function AB.events.ACTIONBAR_UPDATE_USABLE(p_arg1)
	AB.LogEventStart("ACTIONBAR_UPDATE_USABLE")

	if (InCombatLockdown()) then
		for _button_name, button in pairs(AutoBar.buttonList) do
			button:UpdateUsable()
		end
	else
		AB.ABScheduleUpdate(tick.UpdateObjectsID)
	end

	AB.LogEventEnd("ACTIONBAR_UPDATE_USABLE", p_arg1)
end


function AB.events.UPDATE_SHAPESHIFT_FORMS(p_arg1)
	AB.LogEventStart("UPDATE_SHAPESHIFT_FORMS")

	if (InCombatLockdown()) then
		for _button_name, button in pairs(AutoBar.buttonList) do
			button:UpdateUsable()
		end
	end

	AB.ABScheduleUpdate(tick.UpdateSpellsID)

	AB.LogEventEnd("UPDATE_SHAPESHIFT_FORMS", p_arg1)
end


function AB.events.UPDATE_BINDINGS()
	AB.LogEventStart("UPDATE_BINDINGS")
	AB.RegisterOverrideBindings()
	AB.ABScheduleUpdate(tick.UpdateButtonsID)
	AB.LogEventEnd("UPDATE_BINDINGS")
end


function AB.events.LEARNED_SPELL_IN_TAB(p_arg1)
	AB.LogEventStart("LEARNED_SPELL_IN_TAB")
	AB.ABScheduleUpdate(tick.UpdateSpellsID)
	AB.LogEventEnd("LEARNED_SPELL_IN_TAB", p_arg1)
end

function AB.events.UNIT_SPELLCAST_SUCCEEDED(p_unit, p_guid, p_spell_id)
	AB.LogEventStart("UNIT_SPELLCAST_SUCCEEDED")
	assert(p_unit == "player")
	AB.ABScheduleUpdate(tick.UpdateSpellsID)
	AB.LogEventEnd("UNIT_SPELLCAST_SUCCEEDED", p_unit, p_guid, p_spell_id)
end


function AB.events.SPELLS_CHANGED(p_arg1)
	AB.LogEventStart("SPELLS_CHANGED")

	if(AutoBarDB2.settings.handle_spell_changed) then
		AB.ABScheduleUpdate(tick.UpdateSpellsID)
	end

	AB.LogEventEnd("SPELLS_CHANGED", p_arg1)
end



function AB.events.PLAYER_CONTROL_GAINED(p_arg1)
	AB.LogEventStart("PLAYER_CONTROL_GAINED")
	AB.ABScheduleUpdate(tick.UpdateButtonsID)
	AB.LogEventEnd("PLAYER_CONTROL_GAINED", p_arg1)
end



function AB.events.PLAYER_REGEN_ENABLED(p_arg1)
	AB.LogEventStart("PLAYER_REGEN_ENABLED")

	AutoBar.inCombat = nil

	AB.LogEventEnd("PLAYER_REGEN_ENABLED", p_arg1)
end


function AB.events.PLAYER_REGEN_DISABLED(p_arg1)
	AB.LogEventStart("PLAYER_REGEN_DISABLED")

	AutoBar.inCombat = true
	if (InCombatLockdown()) then
		print("AutoBar PLAYER_REGEN_DISABLED called while InCombatLockdown")
	end

	if (AutoBar.moveButtonsMode) then
		AutoBar:MoveButtonsModeOff()
		AB.LibKeyBound:Deactivate()
	end

	if (AutoBar.keyBoundMode) then
		AB.LibKeyBound:Deactivate()
	end

	AB.UpdateActive()
	AceCfgDlg:Close("AutoBar")

	AB.LogEventEnd("PLAYER_REGEN_DISABLED", p_arg1)
end


function AB.events.PLAYER_ALIVE(p_arg1)
	AB.LogEventStart("PLAYER_ALIVE")
	AB.ABScheduleUpdate(tick.UpdateButtonsID)
	AB.LogEventEnd("PLAYER_ALIVE", p_arg1)
end


function AB.events.UNIT_AURA(p_arg1)
	AB.LogEventStart("UNIT_AURA")

	if (AutoBar:IsInLockDown()) then
		for _button_name, button in pairs(AutoBar.buttonList) do
			button:UpdateUsable()
		end
	else
		AB.ABScheduleUpdate(tick.UpdateButtonsID)
	end

	AB.LogEventEnd("UNIT_AURA", p_arg1)
end


function AB.events.PLAYER_UNGHOST(p_arg1)
	AB.LogEventStart("PLAYER_UNGHOST")
	AB.ABScheduleUpdate(tick.UpdateButtonsID)
	AB.LogEventEnd("PLAYER_UNGHOST", p_arg1)
end


function AB.events.UPDATE_BATTLEFIELD_STATUS()
	AB.LogEventStart("UPDATE_BATTLEFIELD_STATUS")

	if (AutoBar.inWorld) then
		local bgStatus = false
		local max_battlefield_id = GetMaxBattlefieldID()
		for i = 1, max_battlefield_id do
			local _status, _map_name, instance_id = GetBattlefieldStatus(i);
			if (instance_id ~= 0) then
				bgStatus = true
				break
			end
		end
		if (AutoBar.inBG ~= bgStatus) then
			AutoBar.inBG = bgStatus
			AB.ABScheduleUpdate(tick.UpdateActiveID)
		end
	end

	AB.LogEventEnd("UPDATE_BATTLEFIELD_STATUS")
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



function AutoBar.Initialize()
	AB.LogEventStart("AutoBar:Initialize")

	-- Set AutoBar Skin
	if (Masque and not AutoBar.MasqueGroup) then
		local group = Masque:Group("AutoBar")
		AutoBar.MasqueGroup = group
		group.SkinID = AutoBarDB2.skin.SkinID or "Blizzard"
		group.Gloss = AutoBarDB2.skin.Gloss
		group.Backdrop = AutoBarDB2.skin.Backdrop
		group.Colors = AutoBarDB2.skin.Colors or {}
	end

	AB.InitializeAllCategories()
	AB.UpdateCustomCategories()
	AutoBarSearch:Initialize()

	AB.LogEventEnd("AutoBar:Initialize")
end




--
-- Bar & Button drag locking / unlocking and key binding modes
--

function AutoBar:ColorAutoBar()
	for _i, bar in pairs(self.barList) do
		if (bar.sharedLayoutDB.enabled) then
			bar:ColorBars()
		end
	end
end

function AutoBar:LIBKEYBOUND_ENABLED()
	self:MoveBarModeOff()
	self:MoveButtonsModeOff()
	self.keyBoundMode = true
	self:ColorAutoBar()
end

function AutoBar:LIBKEYBOUND_DISABLED()
	self.keyBoundMode = nil
	self:ColorAutoBar()
end

function AutoBar:LIBKEYBOUND_MODE_COLOR_CHANGED()
	self:ColorAutoBar()
end

function AutoBar:MoveBarModeToggle()
--print("AutoBar:MoveBarModeToggle")
	if (AB.LibStickyFrames:GetGroup()) then
		AutoBar:MoveBarModeOff()
	else
		AutoBar:MoveBarModeOn()
	end
end

function AutoBar:MoveBarModeOff()
	AB.LibStickyFrames:SetGroup(nil)
	AutoBar.stickyMode = false
end

function AutoBar:MoveBarModeOn()
	AB.LibKeyBound:Deactivate()
	AutoBar:MoveButtonsModeOff()
	AB.LibStickyFrames:SetGroup(true)
	AutoBar.stickyMode = true
end

function AutoBar.OnSetGroup(group)
--print("AutoBar.SetStickyMode stickyMode " .. tostring(stickyMode))
	AutoBar.stickyMode = false
	if (group == true) then
		AutoBar.stickyMode = true
	elseif (type(group) == "table") then
		for _, bar in pairs(AutoBar.barList) do
			if (bar.sharedLayoutDB.enabled and AB.LibStickyFrames:InFrameGroup(bar.frame, group)) then
				AutoBar.stickyMode = true
				break
			end
		end
	end
end


function AutoBar.OnClick(_self, _event, frame, button)
--print("AutoBar.Class.Bar.OnClick frame " .. tostring(frame) .. " button " .. tostring(button) .. " lolwut " .. tostring(lolwut))
	local bar = frame.class
	if (bar and bar.sharedLayoutDB) then
		if (button == "LeftButton") then
			--print("AutoBar.Class.Bar.OnClick ToggleVisibilty frame " .. tostring(frame) .. " button " .. tostring(button))
					bar:ToggleVisibilty()
		--elseif (button == "RightButton") then
			--print("AutoBar.Class.Bar.OnClick ShowBarOptions frame " .. tostring(frame) .. " button " .. tostring(button))
			--bar:ShowBarOptions()
		end
	end
end


--[[
function AutoBar:OnStartFrameMoving()
--print("AutoBar.OnStartFrameMoving")
end

--]]
function AutoBar.OnStopFrameMoving(_self, _event, frame, point, stickToFrame, stickToPoint, stickToX, stickToY)
	local bar = frame.class
	if (bar and bar.sharedPositionDB) then
--print("AutoBar:OnStopFrameMoving " .. tostring(bar.barName) .. " frame " .. tostring(frame) .. " point " .. tostring(point) .. " stickToFrame " .. tostring(stickToFrame) .. " stickToPoint " .. tostring(stickToPoint))
		bar:StickTo(frame, point, stickToFrame, stickToPoint, stickToX, stickToY)
		bar:PositionSave()
	end
end

function AutoBar.OnStickToFrame(_self, _event, frame, point, stickToFrame, stickToPoint, stickToX, stickToY)
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
	AB.LibKeyBound:Deactivate()
	AutoBar.moveButtonsMode = true
	for _, bar in pairs(self.barList) do
		if (bar.sharedLayoutDB.enabled) then
			bar:MoveButtonsModeOn()
		end
	end
	AB.UpdateActive()
end

function AutoBar:MoveButtonsModeOff()
	AutoBar.moveButtonsMode = nil
	for _, bar in pairs(self.barList) do
		if bar.sharedLayoutDB.enabled then
			bar:MoveButtonsModeOff()
		end
	end
	AB.UpdateActive()
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
	return self.fromObject
end

-- Record last object dragged from
function AutoBar:SetDraggingObject(fromObject)
	self.fromObject = fromObject
end


--/dump AutoBarDB2.account.barList["AutoBarClassBarBasic"].buttonKeys[16]
--/dump AutoBar.moveButtonsMode
--/script AutoBarDB2.settings.log_events = true
--/script AutoBarDB2.settings.log_events = false
--/script LibStub("LibKeyBound-1.0"):SetColorKeyBoundMode(0.75, 1, 0, 0.5)
--/script DEFAULT_CHAT_FRAME:AddMessage("" .. tostring())
--/print GetMouseFocus():GetName()

function AutoBar.Print(_self, ...)
	print(...)
end

local StupidLogEnabled = false

function AutoBar:StupidLogEnable(p_toggle)
	StupidLogEnabled = p_toggle
end

function AutoBar:StupidLog(p_text)

	if (StupidLogEnabled) then
		AutoBarDB2.stupidlog = AutoBarDB2.stupidlog .. p_text
	end

end


function AutoBar:DumpWarningLog()

	if next(AutoBar.warning_log) == nil then --Empty log
		return
	end

	AutoBar:Print("Warnings/Errors occured in AutoBar:")

	for _i, v in ipairs(AutoBar.warning_log) do
		AutoBar:Print(v)
	end

end

function AutoBar:LoggedGetSpellInfo(p_spell_id, p_spell_name)

	local ret_val = {GetSpellInfo(p_spell_id)} --table-ify

	if next(ret_val) == nil then
		AB.LogWarning("Invalid Spell ID:" .. p_spell_id .. " : " .. (p_spell_name or "Unknown"));
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
		for _k in pairs(p_table) do
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

function AB.ClearMissingItemFlag()

	AutoBar.missing_items = false;

end

local l_missing_item_count = 0
function AB.SetMissingItemFlag(_p_item)

	AutoBar.missing_items = true;

	l_missing_item_count = l_missing_item_count + 1
	--print("AutoBar.missing_items = true, (", _p_item, ") - ", l_missing_item_count)

end






-------------------------------------------------------------------------
--
-- AutoBar Scheduler
--
-------------------------------------------------------------------------

function AB.ABScheduleUpdate(p_update_id)

--print("AB.ABScheduleUpdate", p_update_id);
	if ((tick.ScheduledUpdate == nil) or (p_update_id < tick.ScheduledUpdate)) then
		tick.ScheduledUpdate = p_update_id;
	end

end


function AutoBar:ABSchedulerTick()
 	--if (tick.ScheduledUpdate ~= tick.UpdateCompleteID) then print("AutoBar:ABSchedulerTick", "ScheduledUpdate:", ABGData.TickScheduler.ScheduledUpdate); end;
	C_Timer.After(ABSchedulerTickLength, AutoBar.ABSchedulerTick)

	--If we're in combat, catch it on the next tick so we don't cause a hitch in gameplay
	if (AutoBar:IsInLockDown()) then
		return;
	end

	if(tick.ScheduledUpdate == nil or tick.ScheduledUpdate == tick.UpdateCompleteID) then	--Nothing scheduled to do, so return
		return;
	end

	if(tick.ScheduledUpdate == tick.ResetSearch) then
		tick.ScheduledUpdate = AB.ResetSearch(tick.BehaveTicker);
	elseif(tick.ScheduledUpdate == tick.UpdateCategoriesID) then
		tick.ScheduledUpdate = AB.UpdateCategories(tick.BehaveTicker);
	elseif(tick.ScheduledUpdate == tick.UpdateSpellsID) then
		tick.ScheduledUpdate = AB.UpdateSpells(tick.BehaveTicker);
	elseif(tick.ScheduledUpdate == tick.UpdateObjectsID) then
		tick.ScheduledUpdate = AB.UpdateObjects(tick.BehaveTicker);

	elseif(tick.ScheduledUpdate == tick.UpdateItemsID) then
		tick.ScheduledUpdate = AB.UpdateItems(tick.BehaveTicker);

	elseif(tick.ScheduledUpdate == tick.UpdateAttributesID) then
		tick.ScheduledUpdate = AB.UpdateAttributes(tick.BehaveTicker);

	elseif(tick.ScheduledUpdate == tick.UpdateActiveID) then
		tick.ScheduledUpdate = AB.UpdateActive(tick.BehaveTicker);

	elseif(tick.ScheduledUpdate == tick.UpdateButtonsID) then
		tick.ScheduledUpdate = AB.UpdateButtons(tick.BehaveTicker);
	else
		print("AutoBar : Invalid tick ID", tick.ScheduledUpdate)
		tick.ScheduledUpdate = tick.UpdateCompleteID
	end


end

function AB.ResetSearch(p_behaviour)
	AB.LogEventStart("ResetSearch")

	local ret = tick.ResetSearch
	if (not InCombatLockdown()) then
		AutoBarSearch:Reset()

		AutoBar:BarButtonChanged()

		AB.UpdateCategories();	--We don't pass the behaviour flag along since we want calls to ResetSearch to complete immediately

		ret = tick.UpdateCompleteID
	end

	AB.LogEventEnd("ResetSearch", p_behaviour)

	return ret;
end




function AB.UpdateCategories(p_behaviour)
	AB.LogEventStart("UpdateCategories")

	--TODO: Review sticky frame handling. This code could be cleaned up
	--TODO: Split this out to its own function
	if (tick.OtherStickyFrames) then
		local delete = true
		for _index, stickyFrame in pairs(tick.OtherStickyFrames) do
			if (_G[stickyFrame]) then
				--print("     AB.UpdateCategories " .. tostring(_index) .. "  " .. tostring(stickyFrame))
				AB.LibStickyFrames:RegisterFrame(_G[stickyFrame])
			else
				delete = false
			end
		end
		if (delete) then
			tick.OtherStickyFrames = nil
		end
	end

	local ret = tick.UpdateCompleteID
	if (not InCombatLockdown()) then
		AB.UpdateCustomCategories()
		AB.UpdateSpells();	--We don't pass the behaviour flag along since we want calls to UpdateCategories to complete immediately
	else
		ret = tick.UpdateSpellsID;
	end

	AB.LogEventEnd("UpdateCategories", p_behaviour)

	return ret;
end

function AB.UpdateSpells(p_behaviour)
	AB.LogEventStart("AB.UpdateSpells")

	AutoBarSearch:ScanRegisteredSpells()
	AutoBarSearch:ScanRegisteredMacros()
	AB.RefreshCategories()

	local ret = tick.UpdateObjectsID;
	if(p_behaviour ~= tick.BehaveTicker) then	-- Run sequentially instead of letting the ticker get the next step
		AB.UpdateObjects();
		ret = tick.UpdateCompleteID;
	end

	AB.LogEventEnd("AB.UpdateSpells", p_behaviour)

	return ret;
end

function AB.UpdateObjects(p_behaviour)

	AB.LogEventStart("AB.UpdateObjects")
	local barLayoutDBList = AutoBar.barLayoutDBList
	local bar
	for barKey, barDB in pairs(barLayoutDBList) do
		local matches_class = (barDB["allowed_class"] == "*") or (barDB["allowed_class"] == AutoBar.CLASS)
		--print("UpdateObjects", barKey, barDB["allowed_class"] .. " == " .. AutoBar.CLASS, matches_class)
		if (barDB.enabled and matches_class) then
			--print("UpdateObjects barKey " .. tostring(barKey) .. " AutoBar.CLASS " .. tostring(AutoBar.CLASS) .. " barDB[AutoBar.CLASS] " .. tostring(barDB[AutoBar.CLASS]))
			if (AutoBar.barList[barKey]) then
				AutoBar.barList[barKey]:UpdateObjects()
			else
				AutoBar.barList[barKey] = AutoBar.Class.Bar:new(barKey)
				--print("     UpdateObjects barKey " .. tostring(barKey) .. " Name " .. tostring(AutoBar.barList[barKey].barName))
			end
			bar = AutoBar.barList[barKey]
			AB.LibStickyFrames:SetFrameEnabled(bar.frame, true)
			AB.LibStickyFrames:SetFrameHidden(bar.frame, bar.sharedLayoutDB.hide)
			AB.LibStickyFrames:SetFrameText(bar.frame, bar.barName)
		elseif (AutoBar.barList[barKey]) then
			--print("UpdateObjects barKey " .. tostring(barKey) .. " Hide " .. tostring(AutoBar.barList[barKey].barName))
			bar = AutoBar.barList[barKey]
			bar.frame:Hide()
			AB.LibStickyFrames:SetFrameEnabled(bar.frame)
			AB.LibStickyFrames:SetFrameText(bar.frame, bar.barName)
		end
	end

	--tick.FullScanItemsFlag = true

	local ret = tick.UpdateItemsID;
	if(p_behaviour ~= tick.BehaveTicker) then	-- Run sequentially instead of letting the ticker get the next step
		AB.UpdateItems();
		ret = tick.UpdateCompleteID;
	end

	AB.LogEventEnd("AB.UpdateObjects", p_behaviour)

	return ret;

end


function AB.UpdateItems(p_behaviour)

	AB.LogEventStart("AB.UpdateItems")

	if(tick.FullScanItemsFlag) then
		AutoBarSearch:Reset();
		tick.FullScanItemsFlag = false;
	else
		AutoBarSearch:UpdateScan()
	end

	local ret = tick.UpdateAttributesID;
	if(p_behaviour ~= tick.BehaveTicker) then	-- Run sequentially instead of letting the ticker get the next step
		AB.UpdateAttributes();
		ret = tick.UpdateCompleteID;
	end

	AB.LogEventEnd("AB.UpdateItems", tostring(p_behaviour))
	return ret;

end

-- Based on the current Scan results, update the Button and Popup Attributes
-- Create Popup Buttons as needed
function AB.UpdateAttributes(p_behaviour)
	AB.LogEventStart("AB.UpdateAttributes")
	for _bar_key, bar in pairs(AutoBar.barList) do
		bar:UpdateAttributes()
	end

	AB.UpdateActive(p_behaviour)

	AB.LogEventEnd("AB.UpdateAttributes", tostring(p_behaviour))

	return tick.UpdateCompleteID;

end

-- Based on the current Scan results, Bars and their Buttons, determine the active Buttons
function AB.UpdateActive(p_behaviour)
	AB.LogEventStart("AB.UpdateActive")
	for _bar_key, bar in pairs(AutoBar.barList) do
		bar:UpdateActive()
		bar:RefreshLayout()
	end

	AB.UpdateButtons(p_behaviour)

	AB.LogEventEnd("AB.UpdateActive", tostring(p_behaviour))

	return tick.UpdateCompleteID;

end

-- Based on the active Bars and their Buttons display them
function AB.UpdateButtons(_p_behaviour)
	AB.LogEventStart("AB.UpdateButtons")
	local disabled_count, enabled_count = 0, 0

	for _button_name, button in pairs(AutoBar.buttonListDisabled) do
		--if (buttonKey == "AutoBarButtonCharge") then print("   AB.UpdateButtons Disabled " .. _button_name); end;
		button:Disable()
		--I don't see why we should update all of these if they're disabled.
		--button:UpdateCooldown()
		--button:UpdateCount()
		--button:UpdateHotkeys()
		--button:UpdateIcon()
		--button:UpdateUsable()
		disabled_count = disabled_count + 1
	end
	for button_key, button in pairs(AutoBar.buttonList) do
		--if (buttonKey == "AutoBarButtonCharge") then print("   AB.UpdateButtons Enabled " .. buttonKey); end;
		assert(button.buttonDB.enabled, "In list but disabled " .. button_key)
		button:SetupButton()
		button:UpdateCooldown()
		button:UpdateCount()
		button:UpdateHotkeys()
		button:UpdateIcon()
		button:UpdateUsable()
		enabled_count = enabled_count + 1
	end
	AB.LogEventEnd("AB.UpdateButtons", " #buttons " .. tostring(enabled_count) .. "  " .. disabled_count)

	return tick.UpdateCompleteID;

end

