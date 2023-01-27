--
-- AutoBarClassButton
-- Copyright 2007+ Toadkiller of Proudmoore.
-- A lot of code borrowed from Bartender3
--
-- Layout Buttons for AutoBar
-- Buttons are contained by AutoBar.Class.Bar
-- http://muffinmangames.com
--

-- GLOBALS: SetCursor, ClearCursor, GetBindingKey, SetBinding, GetBindingText, SetOverrideBindingClick, InCombatLockdown, GameTooltip
-- GLOBALS: RegisterStateDriver, CreateFrame, GetContainerItemInfo, GetItemCount, PickupContainerItem, IsConsumableItem, GetSpellTabInfo, GetSpellBookItemName
-- GLOBALS: PickupItem, PickupSpellBookItem, PickupAction, PickupMacro, ItemHasRange, IsItemInRange, SpellHasRange, IsSpellInRange
local _ADDON_NAME, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

local AutoBar = AutoBar
local ABGCode = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject


local AceOO = MMGHACKAceLibrary("AceOO-2.0")
local L = AutoBarGlobalDataObject.locale
local Masque = LibStub("Masque", true)
local _
local _G = _G

local print, select, assert, ipairs, pairs, tonumber, strmatch = print, select, assert, ipairs, pairs, tonumber, strmatch

-- Basic Button with textures, highlighting, keybindText, tooltips etc.
AutoBar.Class.Button = AceOO.Class(AutoBar.Class.BasicButton)


local function onAttributeChangedFunc(button)
	local self = button.class
	self:UpdateButton()
end

local function onDragStartFunc(button)
	local fromObject = button.class
	if (AutoBar.moveButtonsMode) then
		ClearCursor()
		SetCursor("BUY_CURSOR")
		AutoBar:SetDraggingObject(fromObject)
		fromObject:SetDragCursor()
	else
		local buttonDB = AutoBar:GetButtonDB(fromObject.buttonDB.buttonKey)
--print("onDragStartFunc", fromObject.buttonName, "arg1", arg1, "arg2", arg2, "buttonDB.drag", buttonDB.drag)
		if (buttonDB.drag) then
			ClearCursor()
			AutoBar:SetDraggingObject(nil)
			fromObject:SetDragCursor()
		end
	end
end

local function onReceiveDragFunc(button)
	local toObject = button.class
--print("onReceiveDragFunc " .. tostring(toObject.buttonName) .. " arg1 " .. tostring(arg1) .. " arg2 " .. tostring(arg2))
	toObject:DropObject()
	SetCursor(nil)
end

local function OnUpdateFunc(button, elapsed)
	local self = button.class
	self.elapsed = self.elapsed + elapsed
	if (self.elapsed > 0.2) then
		self:OnUpdate(self.elapsed)
		self.elapsed = 0
	end
end


function AutoBar.Class.Button.prototype:init(parentBar, buttonDB)
	AutoBar.Class.Button.super.prototype.init(self)

	self.showgrid = 0
	self.flashing = 0
	self.flashtime = 0
	self.outOfRange = nil
	self.elapsed = 0
	self.action = 0

	self.parentBar = parentBar
	self.buttonDB = buttonDB

	if (self.buttonDB.square_popups == nil) then
		self.buttonDB.square_popups = true
	end

	self.buttonName = buttonDB.buttonKey
	self.buttonDBIndex = buttonDB.order
	self:CreateButtonFrame()
	self:Refresh(parentBar, buttonDB)
end

-- Refresh the category list
function AutoBar.Class.Button.prototype:Refresh(parentBar, buttonDB)
	--if(buttonDB.buttonKey == "AutoBarButtonCharge") then print("AB.C.Button.proto.Refresh", self.buttonName, self.buttonDB.hasCustomCategories, #self.buttonDB) end
	self.parentBar = parentBar
	if (buttonDB ~= self.buttonDB) then
		self.buttonDB = buttonDB
		assert(self.buttonName == buttonDB.buttonKey, "AutoBar.Class.Button.prototype:Refresh Button Name changed")
		self.buttonDBIndex = buttonDB.order
	end

	self.buttonName = buttonDB.buttonKey

	if (self.buttonDB.hasCustomCategories) then
		for categoryIndex, categoryKey in ipairs(self.buttonDB) do
			self[categoryIndex] = categoryKey
		end

		-- Clear out excess if any
		for i = # self.buttonDB + 1, # self, 1 do
			self[i] = nil
		end
	end
end


-- Disable the Button
function AutoBar.Class.Button.prototype:Disable()
--	self.frame:SetAttribute("category", nil)
--	self.frame:SetAttribute("itemId", nil)
--	self.frame:Hide()
--AutoBar:Print("AutoBar.Class.Button.prototype:Disable " .. tostring(self.buttonName))
end

-- Return the name of the global frame of the button.  Keybinds are made to it.
function AutoBar.Class.Button.prototype:GetButtonFrameName()
	return self.buttonDB.buttonKey .. "Frame"
end

function AutoBar.Class.Button.prototype:GetButtonBinding()
	return self.buttonDB.buttonKey .. "_X"
end


--
-- LibKeyBound Handlers
--

function AutoBar.Class.Button:GetHotkey()
	local frame = self
	local key1 = GetBindingKey(frame.class.buttonName .. "_X")
	local key = AB.LibKeyBound:ToShortKey(key1)
--AutoBar:Print("AutoBar.Class.Button.prototype:GetHotkey key1 " .. tostring(key1) .. " -> " .. tostring(key))-- .. " buttonName " .. tostring(frame.class.buttonName))
	return key
end

function AutoBar.Class.Button:GetActionName()
	local frame = self
	local buttonKey = frame.class.buttonDB.buttonKey
	return (L[buttonKey] or "???") .. " (" .. frame.class:GetButtonFrameName() .. ")"
end

function AutoBar.Class.Button:SetKey(key)
	local button = self.class
	local buttonKey = button.buttonDB.buttonKey
	local buttonFrameName = button:GetButtonFrameName()
	if (key) then
--		SetOverrideBindingClick(AutoBar.frame, false, key, buttonFrameName)
		local buttonBinding = button:GetButtonBinding()
		if (buttonBinding) then
--AutoBar:Print("AutoBar.Class.Button.prototype:SetKey buttonBinding " .. tostring(buttonBinding) .. " -> " .. tostring(key))-- .. " buttonName " .. tostring(frame.class.buttonName))
			SetBinding(key, buttonBinding)
--AutoBar:Print("AutoBar.Class.Button.prototype:SetKey buttonBinding " .. tostring(buttonBinding) .. " <- " .. tostring(GetBindingKey(buttonBinding)))-- .. " buttonName " .. tostring(frame.class.buttonName))
		end
		button:BindingsUpdate()
	end
end

function AutoBar.Class.Button:ClearBindings()
	local button = self.class
	local buttonFrameName = button:GetButtonFrameName()
	local buttonBinding = button:GetButtonBinding()
	while GetBindingKey(buttonBinding) do
		SetBinding(GetBindingKey(buttonBinding), nil)
	end
	button:BindingsUpdate()
end

function AutoBar.Class.Button:GetBindings()
	local button = self.class
	local buttonBinding = button:GetButtonBinding()
	local keys
	if (buttonBinding) then
		for i = 1, select('#', GetBindingKey(buttonBinding)) do
			local hotKey = select(i, GetBindingKey(buttonBinding))
			if keys then
				keys = keys .. ', ' .. GetBindingText(hotKey, 'KEY_')
			else
				keys = GetBindingText(hotKey, 'KEY_')
			end
		end
	end
	return keys
end
--/dump _G["AutoBarButtonTrinket2_X"]

function AutoBar.Class.Button.prototype:BindingsUpdate()
	local buttonFrameName = self:GetButtonFrameName()
	local buttonBinding = self:GetButtonBinding()
	for i = 1, select('#', GetBindingKey(buttonBinding)) do
		local hotKey = select(i, GetBindingKey(buttonBinding))
--AutoBar:Print("AutoBar.Class.Button.prototype:BindingsUpdate hotKey " .. tostring(hotKey) .. " buttonFrameName " .. tostring(buttonFrameName))
		SetOverrideBindingClick(AutoBar.frame, false, hotKey, buttonFrameName)
	end
--AutoBar:Print("AutoBar.Class.Button.prototype:BindingsUpdate -> buttonFrameName " .. tostring(buttonFrameName))
	self:UpdateHotkeys()
end


-- Update the keybinds for the Button.
-- Copied from Bartender3
-- Create Override Bindings from the Blizzard bindings to our dummy binds in Bindings.xml.
-- These do not clash with the real frames to bind to, so all is happy.
function AutoBar.Class.Button:UpdateBindings(buttonName, buttonFrameName)
	local key1, key2 = GetBindingKey(buttonName .. "_X")
	if (key1) then
--AutoBar:Print("AutoBar.Class.Button.prototype:UpdateBindings key1 " .. tostring(key1) .. " key2 " .. tostring(key2) .. " buttonName " .. tostring(buttonName))
		SetOverrideBindingClick(AutoBar.frame, false, key1, buttonFrameName)
	end
	if (key2) then
		SetOverrideBindingClick(AutoBar.frame, false, key2, buttonFrameName)
	end
end
--[[
/script SetOverrideBindingClick(AutoBarButtonTrinket1Frame, false, "U", "AutoBarButtonTrinket1Frame")
/script ClearOverrideBindings(AutoBarButtonTrinket1Frame)
/script AutoBarButtonTrinket2Frame.class:UpdateHotkeys()
/dump AutoBarButtonTrinket2Frame:GetScript("OnUpdate")
--]]


local function funcOnEnter(self)
	if (self.GetHotkey and AutoBar.keyBoundMode) then
		AB.LibKeyBound:Set(self)
	end

	local noTooltip = not (AutoBarDB2.settings.show_tooltip and self.needsTooltip or AutoBar.moveButtonsMode)
	noTooltip = noTooltip or (InCombatLockdown() and not AutoBarDB2.settings.show_tooltip_in_combat)
	if (noTooltip) then
		self.UpdateTooltip = nil
		GameTooltip:Hide()
	else
		AutoBar.Class.BasicButton.TooltipShow(self)
	end
end

local function funcOnLeave(self)
	GameTooltip:Hide()
end

function AutoBar.Class.Button.prototype:CreateButtonFrame()
	local name = self:GetButtonFrameName()
	local frame = CreateFrame("Button", name, self.parentBar.frame, "ActionButtonTemplate, SecureActionButtonTemplate, SecureHandlerBaseTemplate")
	self.frame = frame

	frame:ClearAllPoints()
	frame:SetWidth(ABGData.default_button_width)
	frame:SetHeight(ABGData.default_button_height)

	-- Support selfcast and focuscast
	frame:SetAttribute("checkselfcast", true)
	frame:SetAttribute("checkfocuscast", true)

	frame.class = self
	frame:SetMouseClickEnabled()
	frame:RegisterForClicks("AnyUp")
	frame:RegisterForDrag("LeftButton", "RightButton")

	frame:SetScript("OnUpdate", OnUpdateFunc)

	frame:SetScript("OnEnter", funcOnEnter)
	frame:SetScript("OnLeave", funcOnLeave)

	RegisterStateDriver(frame, "visibility", AutoBar.visibility_driver_string)

---	frame:SetScript("OnAttributeChanged", onAttributeChangedFunc)
	frame:SetScript("OnDragStart", onDragStartFunc)
	frame:SetScript("OnReceiveDrag", onReceiveDragFunc)
---	frame:SetScript("PostClick", self.PostClick)

	frame.icon = _G[("%sIcon"):format(name)]
	frame.border = _G[("%sBorder"):format(name)]
	frame.cooldown = _G[("%sCooldown"):format(name)]
	frame.macroName = _G[("%sName"):format(name)]
	frame.hotKey = _G[("%sHotKey"):format(name)]
	frame.count = _G[("%sCount"):format(name)]
	frame.flash = _G[("%sFlash"):format(name)]
	if (Masque) then
		local group = self.parentBar.frame.MasqueGroup
		frame.MasqueButtonData = {
			Border = frame.border,
			Cooldown = frame.cooldown,
			Count = frame.count,
			Flash = frame.flash,
			HotKey = frame.hotKey,
			Icon = frame.icon,
			Name = frame.macroName,
		}
		group:AddButton(frame, frame.MasqueButtonData)
	end
	frame.normalTexture = frame:GetNormalTexture()

	local frameStrata = AutoBar.barLayoutDBList[self.parentBar.barKey].frameStrata
	frame:SetFrameStrata(frameStrata)

	frame.GetHotkey = AutoBar.Class.Button.GetHotkey
	frame.GetActionName = AutoBar.Class.Button.GetActionName
	frame.SetKey = AutoBar.Class.Button.SetKey
	frame.ClearBindings = AutoBar.Class.Button.ClearBindings
	frame.GetBindings = AutoBar.Class.Button.GetBindings

	self:UpdateButton()
	self:EventsEnable()

end

-- Handle a click on a popped up button
function AutoBar.Class.Button.prototype.OnClick(object, button, down)
	local self = object.class
--AutoBar:Print("OnClick " .. self.buttonName .. " " .. tostring(object) .. " object.class " .. tostring(object.class) .. " button " .. tostring(button) .. " down " .. tostring(down))
	if (down) then
		object:SetChecked(1)
		return true
	else
		object:SetChecked(0)
	end
end



-- For a given itemId, find and shuffle stacks of it to targetBag, targetSlot
-- Return true if successful
-- Return nil if not
function AutoBar.Class.Button:ShuffleItem(itemId, targetBag, targetSlot, isNewItem)
	local _, itemCount, _locked = GetContainerItemInfo(targetBag, targetSlot)
	local totalCount = GetItemCount(itemId)
	if (not itemCount and totalCount > 0) then
		AutoBarSearch:ScanBagsInCombat()
	end

--	if (isNewItem) then
--AutoBar:Print("ShuffleItem isNewItem " .. " itemId " .. tostring(itemId) .. " itemCount " .. tostring(itemCount) .. " locked " .. tostring(locked))
--	end

	if ((itemCount == 1 and totalCount > 1) or (not itemCount and totalCount > 0) or (isNewItem and totalCount > 0)) then
		-- Shuffle in another stack
		local index = AutoBarSearch.found:GetTotalSlots(itemId)
--AutoBar:Print("ShuffleItem start index " .. tostring(self.class.buttonName) .. " itemId " .. tostring(itemId) .. " index " .. tostring(index))
		if (index and index > 0) then
			repeat
				local bag, slot, spell = AutoBarSearch.found:GetItemData(itemId, index)
--AutoBar:Print("ShuffleItem checking  index " .. tostring(index) .. " bag " .. tostring(bag) .. " slot " .. tostring(slot) .. " spell " .. tostring(spell))
				if (bag and slot) then
					local _, itemCount, locked = GetContainerItemInfo(bag, slot)
					if (itemCount and itemCount > 0) then
						ClearCursor()
						PickupContainerItem(bag, slot)
						PickupContainerItem(targetBag, targetSlot)
						AutoBarSearch.found:ClearItemData(itemId, index)
--AutoBar:Print("ShuffleItem actually swapped index " .. tostring(index) .. " bag " .. tostring(bag) .. " slot " .. tostring(slot) .. " locked " .. tostring(locked) .. " targetBag " .. tostring(targetBag) .. " targetSlot " .. tostring(targetSlot))
						return true
					end
				end
				index = index - 1
--AutoBar:Print("ShuffleItem done with  index " .. tostring(index) .. " bag " .. tostring(bag) .. " slot " .. tostring(slot) .. " spell " .. tostring(spell))
			until index <= 0
		else
			-- Redo scan for item only then call ShuffleItem again
		end
		return true
	elseif (totalCount == 1) then
		-- Redo scan for item only then call ShuffleItem again
	end

	-- Nothing left to shuffle in
	return nil
end

-- For a given itemId, find and shuffle stacks of it to targetBag, targetSlot
-- Return true if successful
-- Return nil if not
--TODO: Is this ever called??? ABGCS isn't defined here
function AutoBar.Class.Button.prototype:SwitchItem(buttonItemId, targetBag, targetSlot)
	local popupHeader = self.frame.popupHeader
	if (popupHeader) then
		for _, popupButton in pairs(popupHeader.popupButtonList) do
			local frame = popupButton.frame
			local itemType = self.frame:GetAttribute("type")
			if (itemType == "item") then
				local itemId = frame:GetAttribute("itemId")
				local isUsable = ABGCS.IsUsableItem(itemId)
				if (isUsable) then
					-- It is usable so we have some in inventory so switch
					local didShuffle = AutoBar.Class.Button:ShuffleItem(itemId, targetBag, targetSlot, true)
					if (didShuffle) then
						local texture
						texture = ABGCS.GetIconForItemID(tonumber(itemId))
						self.frame.icon:SetTexture(texture)
						texture = ABGCS.GetIconForItemID(tonumber(buttonItemId))
						frame.icon:SetTexture(texture)
						return true
	--					self:UpdateButton()
	--					popupButton:UpdateButton()
					end
				end
			end
		end
	end
	return false
end

-- Handle shuffle buttons
function AutoBar.Class.Button.prototype:PostClick(mouseButton, down)
	local self = self.class

	if (self.buttonDB.shuffle and InCombatLockdown()) then
		local itemType = self.frame:GetAttribute("type")
		if (itemType == "item") then
			local itemId = self.frame:GetAttribute("itemId")
			local itemLink = self.frame:GetAttribute("item")
			local targetBag, targetSlot = strmatch(itemLink, "^(%d+)%s+(%d+)$")
			if (IsConsumableItem(itemId) and targetBag and targetSlot) then
				local didShuffle = AutoBar.Class.Button:ShuffleItem(itemId, targetBag, targetSlot)
				if (not didShuffle) then
--AutoBar:Print("\nAutoBar.Class.PopupButton.prototype:PostClick did not shuffle, switchItem itemId " .. tostring(itemId) .. " targetBag " .. tostring(targetBag) .. " targetSlot " .. tostring(targetSlot))
					-- Switch to next item
					--[[local didSwitch = ]] self:SwitchItem(itemId, targetBag, targetSlot)
--AutoBar:Print("\nAutoBar.Class.PopupButton.prototype:PostClick didSwitch " .. tostring(didSwitch) .. " targetBag " .. tostring(targetBag) .. " targetSlot " .. tostring(targetSlot))
				end
			end
		end
	end
end
-- /dump AutoBarSearch.found:GetTotalSlots(2723)
-- /dump AutoBarSearch.found:GetList()[2723]
-- /dump IsUsableItem(2723) Pinot Noir
-- /dump IsUsableItem(32902) Bottled Nethergon
-- /dump IsUsableItem("1 6")

local borderMoveActive = {r = 0, g = 1.0, b = 0, a = 1.0}
local borderMoveDisabled = {r = 1.0, g = 0, b = 0, a = 1.0}
local borderMoveEmpty = {r = 0, g = 0, b = 1.0, a = 1.0}

-- Returns Icon texture, borderColor
-- Nil borderColor hides border
function AutoBar.Class.Button.prototype:GetIconTexture()
	local frame = self.frame
	local texture, borderColor = AutoBar.Class.Button.super.prototype.GetIconTexture(self, frame)

	local category = frame:GetAttribute("category")
	if (AutoBar.moveButtonsMode) then
		if (texture) then
			borderColor = borderMoveActive
		else
			if (category and AutoBarCategoryList[category]) then
				texture = AutoBarCategoryList[category].texture
				borderColor = borderMoveEmpty
			else
				texture = "Interface\\Icons\\INV_Misc_Gift_01"
				borderColor = borderMoveDisabled
			end
		end
	elseif ((AutoBarDB2.settings.show_empty_buttons or self.buttonDB.alwaysShow) and not texture) then
		if (category and AutoBarCategoryList[category]) then
			texture = AutoBarCategoryList[category].texture
		end
	end

	return texture, borderColor
end

--/script AutoBar.buttonList["AutoBarButtonTrinket1"].frame.icon:SetTexture("Interface\\Buttons\\UI-Quickslot2")
--/script AutoBar.buttonList["AutoBarButtonTrinket1"].frame.icon:SetTexture("Interface\\Icons\\INV_Misc_QirajiCrystal_05")
--/dump AutoBar.buttonList["AutoBarButtonTrinket1"].frame.icon:GetTexture()
--/script AutoBar.buttonList["AutoBarButtonTrinket1"]:UpdateIcon()

function AutoBar.Class.Button.prototype:UpdateIcon()
	local frame = self.frame
	local texture, borderColor = self:GetIconTexture()

	if (texture) then
		frame.icon:SetTexture(texture)
		frame.icon:Show()
		frame.tex = texture
	else
--		frame:Hide()
	end

	if (borderColor) then
		frame.border:SetVertexColor(borderColor.r, borderColor.g, borderColor.b, borderColor.a)
		frame.border:Show()
	else
		frame.border:Hide()
	end
end


function AutoBar.Class.Button.prototype:UpdateButton()
	local frame = self.frame
	self:UpdateIcon()
	self:UpdateCount()
	self:UpdateHotkeys()
	local itemType = frame:GetAttribute("type")
	if (AutoBar.moveButtonsMode) then
		self:ShowButton()
	elseif (itemType) then
		self:UpdateUsable()
		self:UpdateCooldown()
		self:ShowButton()
		frame:SetScript("OnUpdate", OnUpdateFunc)
	else
		frame:SetScript("OnUpdate", nil)

		frame.cooldown:Hide()
		self:HideButton()
	end

	if (AutoBar.moveButtonsMode) then
		frame.macroName:SetText(ABGCode.GetButtonDisplayName(self.buttonDB))
--	elseif self.parentBar.sharedLayoutDB.showMacrotext then
--		frame.macroName:SetText(GetActionText(self.action))
	else
		frame.macroName:SetText("")
	end

	local buttonDB = self.buttonDB
	if (buttonDB.drop) then
		frame:RegisterEvent("ACTIONBAR_SHOWGRID")
		frame:RegisterEvent("ACTIONBAR_HIDEGRID")
	else
		frame:UnregisterEvent("ACTIONBAR_SHOWGRID")
		frame:UnregisterEvent("ACTIONBAR_HIDEGRID")
	end
end

function AutoBar.Class.Button.prototype:UpdateHotkeys()
	if (AutoBarDB2.settings.show_hotkey) then
		self.frame.hotKey:Show()
	else
		self.frame.hotKey:Hide()
	end

	local frame = self.frame
	local buttonBinding = self:GetButtonBinding()
	local key
	if (buttonBinding) then
		key = GetBindingKey(buttonBinding)
	else
		key = AB.LibKeyBound.Binder:GetBindings(frame)
	end
	if (key) then
		frame.hotKey:SetText(AB.LibKeyBound:ToShortKey(GetBindingText(key, "KEY_", 1)))
	else
		frame.hotKey:SetText("")
	end
end


-- Set cooldown for the button and popups if any
function AutoBar.Class.Button.prototype:UpdateCooldown()
	AutoBar.Class.Button.super.prototype.UpdateCooldown(self)

	local popupHeader = self.frame.popupHeader
	if (popupHeader) then
		for _, popupButton in pairs(popupHeader.popupButtonList) do
			popupButton:UpdateCooldown()
		end
	end
end
--/script local start, duration, enabled = GetSpellCooldown("Summon Water Elemental", BOOKTYPE_SPELL); AutoBar:Print("start " .. tostring(start) .. " duration " .. tostring(duration) .. " enabled " .. tostring(enabled))

-- Set count for the button and popups if any
function AutoBar.Class.Button.prototype:UpdateCount()
	AutoBar.Class.Button.super.prototype.UpdateCount(self)
	if (AutoBarDB2.settings.show_count) then
		local popupHeader = self.frame.popupHeader
		if (popupHeader) then
			for _, popupButton in pairs(popupHeader.popupButtonList) do
				popupButton:UpdateCount()
			end
		end
	end
end

function AutoBar.Class.Button.prototype:UpdateUsable()
	local itemType = self.frame:GetAttribute("type")
	local category = self.frame:GetAttribute("category")
	if (itemType) then
		AutoBar.Class.Button.super.prototype.UpdateUsable(self)

		local popupHeader = self.frame.popupHeader
		if (popupHeader) then
			for _, popupButton in pairs(popupHeader.popupButtonList) do
				popupButton:UpdateUsable()
			end
		end
	elseif (category and (AutoBar.moveButtonsMode or AutoBarDB2.settings.show_empty_buttons or self.buttonDB.alwaysShow)) then
		self.frame.icon:SetVertexColor(0.4, 0.4, 0.4, 1)
	end
end
--[[
/script AutoBar.buttonList["AutoBarButtonQuest"].frame.icon:SetVertexColor(1.0, 1.0, 1.0)
/dump AutoBar.buttonList["AutoBarButtonTrinket1"].frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)
--]]


--/dump AutoBar.buttonList["AutoBarButtonCat"]:IsActive()

function AutoBar.Class.Button.prototype:IsActive()
	local debug_me = false; --("AutoBarButtonPets" == self.buttonName)
	if (debug_me) then print("AutoBar.Class.Button:IsActive", self.buttonName); end;
	if (not self.buttonDB.enabled) then
		return false
	end
	if (AutoBarDB2.settings.show_empty_buttons or AutoBar.moveButtonsMode or self.buttonDB.alwaysShow or AutoBar.keyBoundMode) then
		return true
	end
	local itemType = self.frame:GetAttribute("type")
	if (itemType) then
		if (debug_me) then print("AutoBar.Class.Button.prototype:IsActive itemId ", self.frame:GetAttribute("itemId"), "itemtype:", itemType); end;
		local category = self.frame:GetAttribute("category")
		local categoryInfo = AutoBarCategoryList[category]
		if (categoryInfo and categoryInfo.battleground and not AutoBar.inBG) then
			return false
		end

		local count = 0

		if (itemType == "item") then
			local itemId = self.frame:GetAttribute("itemId")
			count = GetItemCount(tonumber(itemId))
			if (count == 0) then
				local sortedItems = AutoBarSearch.sorted:GetList(self.buttonName)
				if (sortedItems) then
					local noPopup = self.buttonDB.noPopup
					local nItems = # sortedItems
					if (nItems > 1 and not noPopup) then
						count = 1
--AutoBar:Print("AutoBar.Class.Button.prototype:IsActive nItems " .. tostring(nItems))
					end
				end
				if (self.frame:GetAttribute("type2") == "spell") then
					count = 1
				end
			end
		elseif (itemType == "spell") then
			local sortedItems = AutoBarSearch.sorted:GetList(self.buttonName)
			if(sortedItems) then
				count = #sortedItems
			end
		elseif (itemType == "toy") then
			local sortedItems = AutoBarSearch.sorted:GetList(self.buttonName)
			if(sortedItems) then
				count = #sortedItems
			end
		elseif (itemType == "macro") then
			if (self.macroActive) then
				count = 1
			end
		end
		return count > 0
	elseif (self.macroTexture) then
		return true
	else
		return false
	end
end


local function FindSpell(spellName, bookType)
	local s
	local found = false;
	for i = 1, MAX_SKILLLINE_TABS do
		local name, _, offset, numSpells = GetSpellTabInfo(i)
		if (not name) then
			break
		end
		for s = offset + 1, offset + numSpells do
			local	spell = GetSpellBookItemName(s, bookType)
			if (spell == spellName) then
				found = true
			end
			if (found and spell ~=spellName) then
				return s-1
			end
		end
	end
	if (found) then
		return s
	end
	return nil
end

-- Set Cursor based on the type settings
function AutoBar.Class.Button.prototype:SetDragCursor()
	local itemType = self.frame:GetAttribute("type")
	if (itemType) then
		if (itemType == "item") then
			local itemLink = self.frame:GetAttribute("item")
			PickupItem(itemLink)
		elseif (itemType == "action") then
			local action = self.frame:GetAttribute("action1")
			PickupAction(action)
		elseif (itemType == "macro") then
			local macroIndex = self.frame:GetAttribute("macro")
			PickupMacro(macroIndex)
		elseif (itemType == "spell") then
			local spellName = self.frame:GetAttribute("spell")
			PickupSpellBookItem(spellName)
		end
	end
end

local ATTACK_BUTTON_FLASH_TIME = ATTACK_BUTTON_FLASH_TIME

function AutoBar.Class.Button.prototype:OnUpdate(elapsed)
	if (not self.frame.tex) then
		self:UpdateIcon()
	end

	if ( self.flashing == 1 ) then
		self.flashtime = self.flashtime - elapsed;
		if ( self.flashtime <= 0 ) then
			local overtime = -self.flashtime;
			if ( overtime >= ATTACK_BUTTON_FLASH_TIME ) then
				overtime = 0;
			end
			self.flashtime = ATTACK_BUTTON_FLASH_TIME - overtime;

			local flashTexture = self.frame.flash
			if ( flashTexture:IsVisible() ) then
				flashTexture:Hide()
			else
				flashTexture:Show()
			end
		end
	end

	local frame = self.frame
	local itemType = frame:GetAttribute("type")
	local inRange = 1
	if (itemType == "item") then
		local itemId = frame:GetAttribute("itemId")
		if (ItemHasRange(itemId)) then
			inRange = IsItemInRange(itemId, "target")
		end
	elseif (itemType == "spell") then
		local spellName = frame:GetAttribute("spell")
		if (SpellHasRange(spellName)) then
			inRange = IsSpellInRange(spellName, "target")
		end
	end

	if (frame.outOfRange ~= (inRange == 0)) then
		frame.outOfRange = not frame.outOfRange
		print(frame:GetName(), frame.outOfRange)
		self:UpdateUsable()
	end


	if (not self.updateTooltip) then
		return
	end

	self.updateTooltip = self.updateTooltip - elapsed
	if (self.updateTooltip > 0) then
		return
	end
end

function AutoBar.Class.Button.prototype:StartFlash()
	self.flashing = 1
	self.flashtime = 0
end

function AutoBar.Class.Button.prototype:StopFlash()
	self.flashing = 0
	self.frame.flash:Hide()
end

function AutoBar.Class.Button.prototype:ShowButton()

	if (Masque) then
		local frame = self.frame
		local backdrop, gloss = Masque:GetBackdrop(frame), Masque:GetGloss(frame)
		if (backdrop) then
			backdrop:Show()
		end
		if (gloss) then
			gloss:Show()
		end
		local popupHeader = frame.popupHeader
		if (popupHeader) then
			for _, popupButton in pairs(popupHeader.popupButtonList) do
				frame = popupButton.frame
				local backdrop, gloss = Masque:GetBackdrop(frame), Masque:GetGloss(frame)
				if (backdrop) then
					backdrop:Show()
				end
				if (gloss) then
					gloss:Show()
				end
			end
		end
	end
end

function AutoBar.Class.Button.prototype:HideButton()
	local frame = self.frame


	if (Masque) then
		local backdrop, gloss = Masque:GetBackdrop(self), Masque:GetGloss(self)
		if (backdrop) then
			backdrop:Hide()
		end
		if (gloss) then
			gloss:Hide()
		end
		local popupHeader = frame.popupHeader
		if (popupHeader) then
			for _, popupButton in pairs(popupHeader.popupButtonList) do
				frame = popupButton.frame
				local backdrop, gloss = Masque:GetBackdrop(frame), Masque:GetGloss(frame)
				if (backdrop) then
					backdrop:Hide()
				end
				if (gloss) then
					gloss:Hide()
				end
			end
		end
	end
end

function AutoBar.Class.Button.prototype:ShowGrid(override)
--	local frame = self.frame
--	if not override then
--		self.showgrid = self.showgrid + 1
--	end
--	frame.icon:Hide()
--	frame.normalTexture:Show()
end

function AutoBar.Class.Button.prototype:HideGrid(override)
--	local frame = self.frame
--	if (not override) then
--		self.showgrid = self.showgrid - 1
--	end
--	local itemType = self.frame:GetAttribute("type")
--	if (self.showgrid == 0 and not itemType) then
--		if (not self.parentBar.sharedLayoutDB.showGrid) then
--			frame.normalTexture:Hide()
--		end
--	end
--	frame.icon:Show()
end

function AutoBar.Class.Button.prototype:MoveButtonsModeOn()
	local frame = self.frame
	frame:SetScript("OnDragStart", onDragStartFunc)
	frame:SetScript("OnReceiveDrag", onReceiveDragFunc)
	frame.macroName:SetText(ABGCode.GetButtonDisplayName(self.buttonDB))
	frame:Show()
end

function AutoBar.Class.Button.prototype:MoveButtonsModeOff()
	local frame = self.frame
	frame:SetScript("OnDragStart", nil)
	frame:SetScript("OnReceiveDrag", nil)
	frame.macroName:SetText("")
	frame.menu = nil
	if (self.buttonDB.hide or self.parentBar.sharedLayoutDB.hide) then
		frame:Hide()
	elseif (self:IsActive()) then
--AutoBar:Print("AutoBar.Class.Button.prototype:MoveButtonsModeOff self:IsActive() " .. tostring(self:IsActive()) .. " self.buttonName " .. tostring(self.buttonName))
		frame:Show()
	else
		frame:Hide()
	end
end


-- Show grid feedback for droppable buttons
function AutoBar.Class.Button.prototype:ACTIONBAR_SHOWGRID()
--print(self.frame:GetName(), "ShowGrid")
	local frame = self.frame
	frame.icon:Hide()
	frame.normalTexture:Show()
end

-- Hide grid feedback for droppable buttons
function AutoBar.Class.Button.prototype:ACTIONBAR_HIDEGRID()
--print(self.frame:GetName(), "HideGrid")
	local frame = self.frame
	frame.icon:Show()
	frame.normalTexture:Hide()
end


-- Return a unique key to use
function AutoBar.Class.Button:GetCustomKey(customButtonName)
	local barKey = "AutoBarCustomButton" .. customButtonName
	return barKey
end


function AutoBar.Class.Button:NameExists(newName)
	local newKey = AutoBar.Class.Button:GetCustomKey(newName)

	if (AutoBarDB2.account.buttonList[newKey]) then
		return true
	end
	for _, classDB in pairs (AutoBarDB2.classes) do
		if (classDB.buttonList[newKey]) then
			return true
		end
	end
	for _, charDB in pairs (AutoBarDB2.chars) do
		if (charDB.buttonList[newKey]) then
			return true
		end
	end

	return nil
end

-- Return a unique name and buttonKey to use
function AutoBar.Class.Button:GetNewName(baseName)
	local newName, newKey
	local key_seed = 0
	while true do
		newName = baseName .. key_seed
		newKey = AutoBar.Class.Button:GetCustomKey(newName)

		key_seed = key_seed + 1
		if (not AutoBar.Class.Button:NameExists(newName)) then
			break
		end
	end
	return newName, newKey
end

function AutoBar.Class.Button:Delete(buttonKey)
	AutoBarDB2.account.buttonList[buttonKey] = nil
	for _, classDB in pairs (AutoBarDB2.classes) do
		classDB.buttonList[buttonKey] = nil
	end
	for _, charDB in pairs (AutoBarDB2.chars) do
		charDB.buttonList[buttonKey] = nil
	end

	-- Delete ButtonKeys on Bars
	AutoBar.Class.Bar:DeleteButtonKey(AutoBarDB2.account.barList, buttonKey)
	for _, classDB in pairs (AutoBarDB2.classes) do
		AutoBar.Class.Bar:DeleteButtonKey(classDB.barList, buttonKey)
	end
	for _, charDB in pairs (AutoBarDB2.chars) do
		AutoBar.Class.Bar:DeleteButtonKey(charDB.barList, buttonKey)
	end

	-- Delete Instantiated Buttons
	AutoBar.buttonList[buttonKey] = nil
	AutoBar.buttonListDisabled[buttonKey] = nil
end

function AutoBar.Class.Button:RenameCategoryKey(dbList, oldKey, newKey)
	for _, buttonDB in pairs(dbList) do
		for index, categoryKey in ipairs(buttonDB) do
			if (categoryKey == oldKey) then
				buttonDB[index] = newKey
			end
		end
	end
end

function AutoBar.Class.Button:RenameCategory(oldKey, newKey)
	-- Change all db instances
	AutoBar.Class.Button:RenameCategoryKey(AutoBarDB2.account.buttonList, oldKey, newKey)
	for _, classDB in pairs (AutoBarDB2.classes) do
		AutoBar.Class.Button:RenameCategoryKey(classDB.buttonList, oldKey, newKey)
	end
	for _, charDB in pairs (AutoBarDB2.chars) do
		AutoBar.Class.Button:RenameCategoryKey(charDB.buttonList, oldKey, newKey)
	end
end

function AutoBar.Class.Button:RenameKey(dbList, oldKey, newKey, newName)
	local buttonDB = dbList[oldKey]
	if (buttonDB) then
		dbList[newKey] = buttonDB
		dbList[oldKey] = nil
		buttonDB.buttonKey = newKey
		if (buttonDB.name) then
			buttonDB.name = newName
		end
	end
end

function AutoBar.Class.Button:Rename(oldKey, newName)
	local newKey = AutoBar.Class.Button:GetCustomKey(newName)

	-- Change all db instances
	AutoBar.Class.Button:RenameKey(AutoBarDB2.account.buttonList, oldKey, newKey, newName)
	for _, classDB in pairs (AutoBarDB2.classes) do
		AutoBar.Class.Button:RenameKey(classDB.buttonList, oldKey, newKey, newName)
	end
	for _, charDB in pairs (AutoBarDB2.chars) do
		AutoBar.Class.Button:RenameKey(charDB.buttonList, oldKey, newKey, newName)
	end

	-- Change instantated Buttons
	if (AutoBar.buttonListDisabled[oldKey]) then
		AutoBar.buttonListDisabled[newKey] = AutoBar.buttonListDisabled[oldKey]
		AutoBar.buttonListDisabled[oldKey] = nil
	end
	if (AutoBar.buttonList[oldKey]) then
		AutoBar.buttonList[newKey] = AutoBar.buttonList[oldKey]
		AutoBar.buttonList[oldKey] = nil
	end

	-- Change ButtonKeys on Bars
	AutoBar.Class.Bar:RenameButtonKey(AutoBarDB2.account.barList, oldKey, newKey)
	for _, classDB in pairs (AutoBarDB2.classes) do
		AutoBar.Class.Bar:RenameButtonKey(classDB.barList, oldKey, newKey)
	end
	for _, charDB in pairs (AutoBarDB2.chars) do
		AutoBar.Class.Bar:RenameButtonKey(charDB.barList, oldKey, newKey)
	end
end


function AutoBar.Class.Button:OptionsInitialize()
	if (not AutoBarDB2.account.buttonList) then
		AutoBarDB2.account.buttonList = {}
	end
	if (not AutoBar.class.buttonList) then
		AutoBar.class.buttonList = {}
	end
	if (not AutoBar.char.buttonList) then
		AutoBar.char.buttonList = {}
	end
	if (not AutoBar.char.buttonDataList) then
		AutoBar.char.buttonDataList = {}
	end
end

local function ResetCustomButtons(buttonListDB)
	for buttonKey, buttonDB in pairs(buttonListDB) do
		if (buttonDB.buttonClass == "AutoBarButtonCustom") then
			buttonListDB[buttonKey] = nil
		end
	end
end

function AutoBar.Class.Button:OptionsReset()
	ResetCustomButtons(AutoBarDB2.account.buttonList)
	ResetCustomButtons(AutoBar.class.buttonList)
	ResetCustomButtons(AutoBar.char.buttonList)
end

function AutoBar.Class.Button:OptionsUpgrade()

end



--/dump AutoBar.barList
--/script AutoBarClassBarBasicFrame:Show()
--/script AutoBar.barList["AutoBarClassBarBasic"]:UnlockFrames()
--/dump AutoBar.barList["AutoBarClassBarExtras"].buttonList[13]
--/dump AutoBar.buttonList["AutoBarCustomButtonPlanning Mods"]
-- /script AutoBar.barList["AutoBarClassBarBasic"].buttonList[18].frame.normalTexture:Hide()
-- /script AutoBar.barList["AutoBarClassBarBasic"].buttonList[18].frame:SetChecked(0)
-- /script AutoBar.barList["AutoBarClassBarBasic"].buttonList[18].frame:GetPushedTexture():SetTexture("")
-- /dump AutoBar.barList["AutoBarClassBarBasic"].buttonList[18].showgrid
-- /script AutoBar.buttonList["AutoBarButtonQuest"].frame.popupHeader.popupButtonList[2].frame.icon:Show()
-- /script AutoBar.buttonList["AutoBarButtonQuest"].frame.popupHeader.popupButtonList[2].frame.oldNT:Hide()
