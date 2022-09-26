--
-- AutoBarButton
-- Copyright 2007+ Toadkiller of Proudmoore.
--
-- Buttons for AutoBar
-- http://muffinmangames.com
--

--local _, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

local AutoBar = AutoBar
local AutoBarSearch = AutoBarSearch  --TODO: This shouldn't be a global at all

local ABGCode = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject
local spellIconList = ABGData.spell_icon_list

local AceOO = MMGHACKAceLibrary("AceOO-2.0")
--local LibKeyBound = LibStub("LibKeyBound-1.0")
local L = AutoBarGlobalDataObject.locale


AutoBarButton = AceOO.Class(AutoBar.Class.Button)
AutoBarButton.dirtyButton = {}


function AutoBarButton.prototype:init(parentBar, buttonDB)
	AutoBarButton.super.prototype.init(self, parentBar, buttonDB)
end


-- Handle dragging of items, macros, spells to the button
-- Handle rearranging of buttons when buttonLock is off
--TODO: Why is this in the Button class? It should be part of Category
local function AddItemToCategory(category, itemType, itemId, itemInfo)
	local categoryInfo = AutoBarCategoryList[category]
	local itemsListDB = categoryInfo.customCategoriesDB.items
	local itemIndex = # itemsListDB + 1
--AutoBar:Print("AutoBarButton.prototype:DropLink " .. tostring(categoryInfo.description) .. "itemType " .. tostring(itemType) .. " itemId " .. tostring(itemId) .. " itemInfo " .. tostring(itemInfo))

	for index = # itemsListDB, 1, -1 do
		if(itemsListDB[index].itemId == itemId) then
			AutoBar:Print("AutoBar: Item " .. itemInfo .. " already exists in Category " .. tostring(categoryInfo.description) .. " not adding it again");
			return
		end
	end

	local itemDB = {
		itemType = itemType,
		itemId = itemId,
		itemInfo = itemInfo
	}
	itemsListDB[itemIndex] = itemDB
	if (itemType == "spell") then
		local spellName = GetSpellBookItemName(itemId, itemInfo)
		itemDB.spellName = spellName
		itemDB.spellClass = AutoBar.CLASS
	else
		itemDB.spellName = nil
		itemDB.spellClass = nil
	end
end


-- Handle dragging of items, macros, spells to the button
-- Handle rearranging of buttons when buttonLock is off
function AutoBarButton.prototype:DropLink(itemType, itemId, itemInfo)

	if(itemType == "item" and ABGCode.PlayerHasToy(itemId)) then
		AutoBar:Print("AutoBar: Item " .. itemInfo .. " looks like a Toy, so I'm not adding it. Toys are not currently supported in Drag and Drop.");
		return;
	end

	if (itemType == "item" or itemType == "spell" or itemType == "macro") then
		-- Select a Custom Category to use
		local categoryInfo, categoryKey, dropped
		for index = # self, 1, -1 do
			categoryKey = self[index]
			categoryInfo = AutoBarCategoryList[categoryKey]

			if (categoryInfo and categoryInfo.customKey) then
				AddItemToCategory(categoryKey, itemType, itemId, itemInfo)
				AutoBar:BarButtonChanged()
				dropped = true
				break
			end
		end

		-- Create a Custom Category to use
		local buttonDB = self.buttonDB
		if (not dropped and buttonDB.drop) then
			local buttonCategoryIndex = # buttonDB + 1
			local new_key = AutoBar:CategoryNew()
			buttonDB[buttonCategoryIndex] = new_key
			AddItemToCategory(new_key, itemType, itemId, itemInfo)
			AutoBar:BarButtonChanged()
		end
	end
end


-- Handle dragging of items, macros, spells to the button
-- Handle rearranging of buttons when buttonLock is off
function AutoBarButton.prototype:DropObject()
	local toObject = self
	local fromObject = AutoBar:GetDraggingObject()
	local refreshNeeded
--AutoBar:Print("AutoBarButton.prototype:DropObject " .. tostring(fromObject and fromObject.buttonDB.buttonKey or "none") .. " --> " .. tostring(toObject.buttonDB.buttonKey))
	if (fromObject and fromObject ~= toObject and AutoBar.moveButtonsMode) then
		AutoBar:ButtonMove(fromObject.parentBar.barKey, fromObject.order, toObject.parentBar.barKey, toObject.order)
		AutoBar:BarButtonChanged()
		ClearCursor()
	else
		local buttonDB = toObject.buttonDB
		if (buttonDB.hasCustomCategories and AutoBar.moveButtonsMode or buttonDB.drop) then
			local itemType, itemId, itemInfo = GetCursorInfo()
			if (itemType == "item" or itemType == "spell" or itemType == "macro") then
--AutoBar:Print("AutoBarButton.prototype:DropObject itemType " .. tostring(itemType) .. " itemId " .. tostring(itemId) .. " itemInfo " .. tostring(itemInfo))
				toObject:DropLink(itemType, itemId, itemInfo)
				refreshNeeded = true
				ClearCursor()
				AutoBar:CategoriesChanged()
			end
		end
	end

	if (refreshNeeded) then
		if (fromObject) then
			fromObject:UpdateButton()
		end
	end
	AutoBar:SetDraggingObject(nil)
end



-- popupNazi makes sure we dont have multiple popups open.  Google "Soup Nazi" for how this is done
-- There are two cases:

--	1) Rapid movement or movement off the window breaks the Blizzard code.  We use a sensible timer to fix this - popupNaziSnippet
local popupNaziSnippet = [[
	local flag = self:IsUnderMouse(true)
	if (flag) then
		local queued = control:SetTimer(1, "hoverCheck")
	else
		local anchorButton = self:GetFrameRef("anchorButton")
		x, y = anchorButton:GetMousePosition()
		if (x and y) then
			local queued = control:SetTimer(1, "hoverCheck")
		else
			self:Hide()
		end
	end
]]

--	2) Track the popped open menu.  If we open a new one we sensibly close the old one - popupNaziHandler
local popupNaziHandler = CreateFrame("Frame", "AutoBarPopupNaziHandler", nil, "SecureHandlerAttributeTemplate")
popupNaziHandler:SetAttribute("_onattributechanged", [[
	local openHandler = self:GetAttribute("openhandler")
	if (name == "openhandler") then
		local openHandler = self:GetAttribute("openhandler")
		local oldOpenHandler = self:GetAttribute("oldopenhandler")
		if (oldOpenHandler and oldOpenHandler ~= openHandler) then
--			print("hiding old one", oldOpenHandler, openHandler)
			oldOpenHandler:Hide()
		end
		self:SetAttribute("oldopenhandler", openHandler)
	end
]])


-- The basic idea is to have an intervening handler frame that is Shown / Hidden if popupOnModifier is true / nil
local snippetPopupKey = [[
	if (newstate == "1") then
		self:Show()
	else
		self:Hide()
	end
]]
local popupKeyStates = "[modifier:shift] 1; 0"

-- Clone the popup into the anchorButton
local snippetOnClick = [[
	local popupHeader = self:GetFrameRef("popupHeader")
	local anchorButton = popupHeader:GetFrameRef("anchorButton")

	-- Move the attributes that make the button work
	local itemType = self:GetAttribute("type")
	local itemType1 = self:GetAttribute("type1")
	local item_guid = self:GetAttribute("AutoBarGUID")

	if(itemType1) then
		anchorButton:SetAttribute("type1", self:GetAttribute("type1"))
		anchorButton:SetAttribute("target-slot1", self:GetAttribute("target-slot1"))
		anchorButton:SetAttribute("target-bag1", self:GetAttribute("target-bag1"))
		anchorButton:SetAttribute("item1", self:GetAttribute("item1"))
		anchorButton:SetAttribute("spell1", self:GetAttribute("spell1"))
	end
	anchorButton:SetAttribute("type", self:GetAttribute("type"))
	anchorButton:SetAttribute("unit", self:GetAttribute("unit"))
	anchorButton:SetAttribute("target-slot", self:GetAttribute("target-slot"))
	anchorButton:SetAttribute("target-bag", self:GetAttribute("target-bag"))
	anchorButton:SetAttribute("AutoBarGUID", self:GetAttribute("AutoBarGUID"))

	if (itemType == "toy") then
		anchorButton:SetAttribute("toy", self:GetAttribute("toy"))
	elseif (itemType == "item") then
		anchorButton:SetAttribute("item", self:GetAttribute("item"))
	elseif (itemType == "spell") then
		anchorButton:SetAttribute("spell", self:GetAttribute("spell"))
	elseif (itemType == "macro") then
		anchorButton:SetAttribute("macro", self:GetAttribute("macro"))
		anchorButton:SetAttribute("macrotext", self:GetAttribute("macrotext"))
		anchorButton:SetAttribute("macroName", self:GetAttribute("macroName"))
		anchorButton:SetAttribute("macroBody", self:GetAttribute("macroBody"))
	end


	-- Move the right click attributes
	itemType = self:GetAttribute("type2")
	anchorButton:SetAttribute("type2", self:GetAttribute("type2"))
	anchorButton:SetAttribute("target-slot2", self:GetAttribute("target-slot2"))
	anchorButton:SetAttribute("target-bag2", self:GetAttribute("target-bag2"))
	anchorButton:SetAttribute("unit2", self:GetAttribute("unit2"))
	if (itemType == "item") then
		anchorButton:SetAttribute("item2", self:GetAttribute("item2"))
	elseif (itemType == "spell") then
		anchorButton:SetAttribute("spell2", self:GetAttribute("spell2"))
	elseif (itemType == "macro") then
		anchorButton:SetAttribute("macro2", self:GetAttribute("macro2"))
		anchorButton:SetAttribute("macrotext2", self:GetAttribute("macrotext2"))
	end

	-- Tooltip and Icon support
	anchorButton:SetAttribute("category", self:GetAttribute("category"))
	anchorButton:SetAttribute("itemId", self:GetAttribute("itemId"))
	anchorButton:SetAttribute("icon", self:GetAttribute("icon"))
	anchorButton:SetAttribute("itemLink", self:GetAttribute("itemLink"))

	-- Arrange on Use source popup button
	anchorButton:SetAttribute("sourceButton", self)
]]

-- Clicking on a popup changes the anchor button spell.  This updates the icon texture to match
local function UpdateIcon(button, texture)
	button.icon:SetTexture(texture)
end

-- Clicking on a popup changes the anchor button spell.  This updates the icon texture to match
local function UpdateHandlers(frame)
	local TooltipSet = frame:GetAttribute("TooltipSet")
--print("UpdateHandlers", sourceButton, TooltipSet, frame.TooltipSet)
	frame.TooltipSet = TooltipSet

	local itemId
	local buttonKey = frame.class.buttonName
	local itemType = frame:GetAttribute("type")
	local item_guid = frame:GetAttribute("AutoBarGUID")

	if(item_guid) then
		itemId = item_guid
	elseif (itemType) then
		if (itemType == "item") then
			itemId = frame:GetAttribute("itemId")
		elseif (itemType == "spell") then
			itemId = frame:GetAttribute("spell")
		elseif (itemType == "macro") then
			itemId = frame:GetAttribute("macroId")
		else
			print("AutoBar UpdateHandlers can't handle:", itemType);
		end
	end

	local buttonData = AutoBar.db.char.buttonDataList[buttonKey]
	if (not buttonData) then
		buttonData = {}
		AutoBar.db.char.buttonDataList[buttonKey] = buttonData
	end

	buttonData.arrangeOnUse = itemId
end



local MAX_POPUP_HEIGHT = 8

-- Lay out the popups
function AutoBarButton.prototype:SetupPopups(nItems)
	local buttonKey = self.buttonDB.buttonKey
	local frame = self.frame
	local popupHeader = frame.popupHeader
	local popupKeyHandler = frame.popupKeyHandler
	local barKey = self.parentBar.barKey
	local layoutDB = AutoBar.barLayoutDBList[barKey]

	local padding = layoutDB.padding
	local hitRectPadding = -math.max(4, padding)
	local popupDirection = layoutDB.popupDirection
	local relativeSide, side, splitRelativeSide, splitSide
	local paddingX, paddingY, splitPaddingX, splitPaddingY = 0, 0, 0, 0
	if (popupDirection == "1") then	-- Top
		side = "BOTTOM"
		relativeSide = "TOP"
		paddingY = padding
		splitSide = "LEFT"
		splitRelativeSide = "RIGHT"
		splitPaddingX = padding
	elseif (popupDirection == "2") then -- Left
		side = "RIGHT"
		relativeSide = "LEFT"
		paddingX = -padding
		splitSide = "BOTTOM"
		splitRelativeSide = "TOP"
		splitPaddingY = padding
	elseif (popupDirection == "3") then -- Bottom
		side = "TOP"
		relativeSide = "BOTTOM"
		paddingY = -padding
		splitSide = "RIGHT"
		splitRelativeSide = "LEFT"
		splitPaddingX = -padding
	elseif (popupDirection == "4") then -- Right
		side = "LEFT"
		relativeSide = "RIGHT"
		paddingX = padding
		splitSide = "TOP"
		splitRelativeSide = "BOTTOM"
		splitPaddingY = -padding
	end

	local max_popup_height = self.buttonDB.max_popup_height or MAX_POPUP_HEIGHT

	-- For gigantic popups, split it up into a block
	local splitLength = max_popup_height
	local splitRelativePoint

	if(self.buttonDB.square_popups == true) then
		local nSplits = math.ceil(nItems / max_popup_height)
		if (nSplits > 1) then
			splitLength = math.ceil(nItems / nSplits)
		end
end


	--if (self.buttonDB.max_popup_height) then
	--	print("items:", nItems,"max height:", self.buttonDB.max_popup_height, "square:", self.buttonDB.square_popups, "split_len:", splitLength)
	--end

	-- Arrange on Use Buttons show the first Button because it needs to remain there for changes during combat.
	local arrangeOnUse = self.buttonDB.arrangeOnUse
	local popupIndexStart = 2
	if (arrangeOnUse) then
		popupIndexStart = 1
	end

	local buttonItems = AutoBarSearch.items:GetList(buttonKey)
	local buttonWidth = layoutDB.buttonWidth
	local buttonHeight = layoutDB.buttonHeight
	local relativePoint = popupHeader
	for popupButtonIndex = popupIndexStart, nItems, 1 do
		local popupButton = AutoBar.Class.PopupButton:GetPopupButton(self, popupButtonIndex, popupHeader, popupKeyHandler)
		local popupButtonFrame = popupButton.frame

		-- Wrap OnClick with the Arrange on use code
		local wrapped = popupButtonFrame.snippetOnClick
		if (wrapped and (not arrangeOnUse)) then
			local _header, preBody, _post_body = popupHeader:UnwrapScript(popupButtonFrame, "OnClick")
			assert(wrapped == preBody, "wrapped ~= preBody in UnwrapScript")
			-- ToDo: Are we the only wrapping people?  Maybe add some recursive unwrapping of our exact script.
		elseif ((not wrapped) and arrangeOnUse) then
			SecureHandlerWrapScript(popupButtonFrame, "OnClick", popupHeader, snippetOnClick)
			popupButtonFrame.snippetOnClick = snippetOnClick
		end

		-- Attach to edge of previous popupButtonFrame or the popupHeader
		popupButtonFrame:ClearAllPoints()
		popupButtonFrame:SetHeight(buttonHeight)
		popupButtonFrame:SetWidth(buttonWidth)
		popupButtonFrame:Raise()
		popupButtonFrame:SetScale(1)
		if (relativePoint == popupHeader) then
			popupButtonFrame:SetPoint(side, relativePoint, side, paddingX, paddingY)
			splitRelativePoint = popupButtonFrame
		else
			if (math.fmod(popupButtonIndex - popupIndexStart, splitLength) == 0) then
--print(frame:GetName(), popupButtonIndex, "/", nItems, splitLength, nSplits)
				popupButtonFrame:SetPoint(splitSide, splitRelativePoint, splitRelativeSide, splitPaddingX, splitPaddingY)
				splitRelativePoint = popupButtonFrame
			else
				popupButtonFrame:SetPoint(side, relativePoint, relativeSide, paddingX, paddingY)
			end
		end
		if (popupButtonIndex == 2) then
			if (popupDirection == "1") then
				popupButtonFrame:SetHitRectInsets(hitRectPadding, hitRectPadding, hitRectPadding, -padding)
			elseif (popupDirection == "2") then
				popupButtonFrame:SetHitRectInsets(hitRectPadding, -padding, hitRectPadding, hitRectPadding)
			elseif (popupDirection == "3") then
				popupButtonFrame:SetHitRectInsets(hitRectPadding, hitRectPadding, -padding, hitRectPadding)
			elseif (popupDirection == "4") then
				popupButtonFrame:SetHitRectInsets(-padding, hitRectPadding, hitRectPadding, hitRectPadding)
			end
		else
			popupButtonFrame:SetHitRectInsets(hitRectPadding, hitRectPadding, hitRectPadding, hitRectPadding)
		end
		relativePoint = popupButtonFrame

		-- Support selfcast
		popupButtonFrame:SetAttribute("checkselfcast", true)
		popupButtonFrame:SetAttribute("checkfocuscast", true)

		local bag, slot, spell, itemId, macroId, type_id, info_data = AutoBarSearch.sorted:GetInfo(buttonKey, popupButtonIndex)
		self:SetupAttributes(popupButton, bag, slot, spell, macroId, type_id, info_data, itemId, buttonItems[itemId])
		popupButton:UpdateIcon()
	end

	popupHeader:ClearAllPoints()
--- ToDo: fix for orientation
--			popupHeader:SetWidth(buttonWidth + paddingX * 2)
--			popupHeader:SetHeight((buttonHeight + paddingY) * (nItems - 1) + paddingY)
	popupHeader:SetWidth(2)
	popupHeader:SetHeight(2)
	popupHeader:SetScale(1)
	popupHeader:SetPoint(side, frame, relativeSide)
	RegisterAutoHide(popupHeader, 0.25)

	-- Hide unwanted buttons
	for popupButtonIndex, popupButton in pairs(popupHeader.popupButtonList) do
		if (popupButtonIndex > nItems) then
			popupButton.frame:Hide()	-- Items have shrunk below instantiated list.  Hide the excess.
		elseif (popupButtonIndex < popupIndexStart) then
--print("hiding popupButtonIndex, popupIndexStart, nItems, arrangeOnUse", popupButton:getName(), popupButtonIndex, popupIndexStart, nItems, arrangeOnUse)
			popupButton.frame:Hide()	-- Hide 1st popup if it is not arrange on use as it is identical to the anchorButton
		elseif (self.buttonDB.alwaysPopup) then
			popupButton.frame:Show()
			popupHeader:Show()
		else
			popupButton.frame:Show()
		end
	end
end



-- Set the state attributes of the button
function AutoBarButton.prototype:GetHierarchicalSetting(setting)
	local db = self.buttonDB
	if (db[setting] ~= nil) then
		return db[setting]
	end
	db = self.parentBar.sharedLayoutDB
	if (db[setting] ~= nil) then
		return db[setting]
	end
	db = AutoBar.db.account
	if (db[setting] ~= nil) then
		return db[setting]
	end
end


-- Update the anchorButton after a click on a popup
local snippetOnAttributeChanged = [[
	if (name == "icon") then
		control:CallMethod("UpdateIcon", value)
	elseif (name == "sourcebutton") then -- or name == "sourceButton" Some code is lowercasing this.  How silly.
		control:CallMethod("UpdateHandlers")
	end
]]

-- Used to pop up the buttons based on popupHeader FrameRef on the button
local popupHandler = CreateFrame("Frame", "AutoBarPopupHandler", nil, "SecureHandlerEnterLeaveTemplate")

-- Set the state attributes of the button
function AutoBarButton.prototype:SetupButton()
	local buttonKey = self.buttonDB.buttonKey
	local frame = self.frame

	local bag, slot, spell, itemId, macroId, type_id, info_data = AutoBarSearch.sorted:GetInfo(buttonKey, 1)
	local popupHeader = frame.popupHeader

	--if (buttonKey == "AutoBarButtonHearth") then print("AutoBarButton.proto:SetupButton buttonKey ", buttonKey, " bag ", bag, " slot ", slot, " spell ", spell, " macroId ", macroId, "type_id", type_id, "info_data", info_data) end;
	if ((bag or slot or spell or macroId or type_id) and self.buttonDB.enabled) then
		frame:Show()
		local sortedItems = AutoBarSearch.sorted:GetList(buttonKey)
		local noPopup = self.buttonDB.noPopup
		local nItems = # sortedItems
		if (nItems < 2) then
			noPopup = true
		end

		local buttonItems = AutoBarSearch.items:GetList(buttonKey)
		local itemData = buttonItems[itemId]

		self:SetupAttributes(self, bag, slot, spell, macroId, type_id, info_data, itemId, itemData)
		if (noPopup) then
			if (popupHeader) then
				for _, popupButton in pairs(popupHeader.popupButtonList) do
					popupButton.frame:Hide()
				end
			end
		else
			local popupOnModifier = self:GetHierarchicalSetting("popupOnShift")

			-- Create the Button's Popup Header
			if (not popupHeader) then
				local name = buttonKey .. "PopupHeader"
				popupHeader = CreateFrame("Frame", name, frame, "SecureHandlerEnterLeaveTemplate")
				popupHeader:SetAttribute("_onenter", [[self:Show()]])
				popupHeader:SetAttribute("_onleave", [[self:Hide()]])
				popupHeader:SetFrameStrata("DIALOG")

				-- Create the popupKeyHandler if required
				if (popupOnModifier) then
					-- Note that it is made a child of popupHeader, and later becomes parent to the popup buttons
					-- Hiding it will thus hide the popup buttons as well, even if popupHeader is shown
					local popupKeyHandler = CreateFrame("Frame", buttonKey .. "HandlerPopupKey", popupHeader, "SecureHandlerStateTemplate")
					popupKeyHandler:SetAttribute("_onstate-modifier", snippetPopupKey)
					popupKeyHandler:SetAllPoints(popupHeader)
					RegisterStateDriver(popupKeyHandler, "modifier", popupKeyStates)
					popupKeyHandler:SetAttribute("_onenter", [[ self:GetParent():Show() ]])
					popupKeyHandler:SetAttribute("_onleave", [[ self:GetParent():Hide() ]])
					frame.popupKeyHandler = popupKeyHandler
				end

				frame.popupHeader = popupHeader
				popupHeader.popupButtonList = {}
				RegisterAutoHide(popupHeader, 0.5)
			end

			-- Add needed snippets (only execute once)
			if (not frame.popupHandler) then
				frame.popupHandler = popupHandler

				frame:SetFrameRef("popupHeader", popupHeader)
				frame:Execute([[
					popupHeader = self:GetFrameRef("popupHeader")
					popupHeader:ClearAllPoints()
					popupHeader:SetPoint("BOTTOM", self, "TOP")
					popupHeader:Raise()
					popupHeader:Hide()
				]])

				SecureHandlerWrapScript(frame, "OnEnter", popupHandler, [[
					popupHeader = self:GetFrameRef("popupHeader")
					popupHeader:Show()
				]])
				popupHandler.TooltipHide = AutoBar.Class.BasicButton.TooltipHide
				SecureHandlerWrapScript(frame, "OnLeave", popupHandler, [[
					popupHeader = self:GetFrameRef("popupHeader")
					popupHeader:Hide()
				]])
				popupHandler:SetAttribute("_adopt", frame)

				-- Deal with rare irritating cases where Popups remain open incorrectly
				popupHeader:SetFrameRef("popupNaziHandler", popupNaziHandler)
				popupHeader:SetFrameRef("popupHeader", popupHeader)
				popupHeader:SetFrameRef("anchorButton", frame)
				popupHeader:SetAttribute("_ontimer", popupNaziSnippet)
			end

			local arrangeOnUse = self.buttonDB.arrangeOnUse
			local wrapped = frame.UpdateIcon
			-- Trigger Updating on the Anchor Button
			if (wrapped and (not arrangeOnUse)) then
				local _header, preBody, postBody = popupHeader:UnwrapScript(frame, "OnAttributeChanged")  --ToDo: Remove this?
			elseif ((not wrapped) and arrangeOnUse) then
				frame.UpdateIcon = UpdateIcon	-- Update Icon
				frame.UpdateHandlers = UpdateHandlers	-- Update Handlers: Tooltip
				SecureHandlerWrapScript(frame, "OnAttributeChanged", frame, snippetOnAttributeChanged)
			end

			self:SetupPopups(nItems)
		end

	else
		--if (buttonKey == "AutoBarButtonCharge") then print("Charge has no spell") end;
		frame:SetAttribute("itemId", nil)
		frame:Hide()
		if (popupHeader) then
			popupHeader:Hide()
		end

		--if (buttonKey == "AutoBarButtonCharge") then print("move_mode",AutoBar.moveButtonsMode, "showEmpty", AutoBar.db.account.showEmptyButtons, "Alwaysshow", self.buttonDB.alwaysShow, "enabled", self.buttonDB.enabled ) end;
		if ((AutoBar.moveButtonsMode or AutoBar.db.account.showEmptyButtons or self.buttonDB.alwaysShow) and self.buttonDB.enabled) then
			frame:Show()
			--if (buttonKey == "AutoBarButtonCharge") then print("Showing Frame", "self[1]", self[1]); end;
			if (self[1]) then
				frame:SetAttribute("category", self[# self])
			else
				frame:SetAttribute("category", nil)
			end
		else
			frame:SetAttribute("category", nil)
		end
	end
end
--[[
/dump (# AutoBarSearch.sorted:GetList("AutoBarButtonRecovery"))
/dump (AutoBar.buttonList["AutoBarButtonHearth"].frame.popupHeader.popupButtonList[2].frame:IsVisible())
/dump (AutoBar.buttonList["AutoBarButtonHearth"].frame.popupHeader.popupButtonList[2].frame:IsShown())
/script AutoBar.buttonList["AutoBarButtonHearth"].frame.popupHeader.popupButtonList[2].frame:SetPoint("RIGHT", -260,-80)
--]]

-- Clear the state attributes of the button
local function ClearButtonAttributes(frame)
	frame:SetAttribute("target-slot1", nil)
	frame:SetAttribute("target-slot2", nil)
	frame:SetAttribute("target-bag1", nil)
	frame:SetAttribute("target-bag2", nil)
	frame:SetAttribute("unit2", nil)
	frame:SetAttribute("type", nil)
	frame:SetAttribute("type2", nil)
	frame:SetAttribute("item", nil)
	frame:SetAttribute("item2", nil)
	frame:SetAttribute("spell", nil)
	frame:SetAttribute("spell2", nil)
	frame:SetAttribute("toy", nil)
	frame:SetAttribute("macroId", nil)
	frame:SetAttribute("macro", nil)
	frame:SetAttribute("macrotext", nil)
	frame:SetAttribute("macro_action", nil)
	frame:SetAttribute("macro_icon", nil)
	frame:SetAttribute("macroName", nil)
	frame:SetAttribute("macroBody", nil)
	frame:SetAttribute("macro2", nil)
	frame:SetAttribute("macrotext2", nil)
	frame:SetAttribute("itemLink", nil)
	frame:SetAttribute("AutoBarGUID", nil)
	frame:SetAttribute("icon", nil)
	frame:SetAttribute("category", nil)
	frame:SetAttribute("itemId", nil)
end

local SPELL_FEED_PET = AutoBar:LoggedGetSpellInfo(6991) -- Feed Pet
local SPELL_PICK_LOCK = AutoBar:LoggedGetSpellInfo(1804) -- Pick Lock
local SPELL_MILL_HERB
if(ABGData.is_mainline_wow) then
	SPELL_MILL_HERB = ABGCode.GetSpellNameByName("Milling")
end

local TRINKET1_SLOT = 13
local TRINKET2_SLOT = 14

-- Set the state attributes of the button
function AutoBarButton.prototype:SetupAttributes(button, bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData)
	local frame = button.frame
	ClearButtonAttributes(frame)

	local enabled = true
	frame.needsTooltip = true
	local category = itemData and itemData.category

	local debug_me = false; --p_type_id ~= nil
	if (debug_me) then print("ABButton.proto:SetupAttributes",  bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData.category) end;

	frame:SetAttribute("category", category)
	frame:SetAttribute("itemId", itemId)

	local targeted, castSpell, itemsRightClick
	local buttonDB = self.buttonDB	-- Use base button info for popups as well
	local selfCastRightClick = AutoBar.db.account.selfCastRightClick

	-- Set up special conditions from Category attributes
	local categoryInfo = AutoBarCategoryList[category]
	if (categoryInfo) then
		targeted = categoryInfo.targeted

		-- Disable battleground only items outside BG
		if (categoryInfo.battleground and not AutoBar.inBG) then
			enabled = false
		end

		castSpell = categoryInfo.castSpell
		itemsRightClick = categoryInfo.itemsRightClick
	end

	if (not targeted and buttonDB.targeted) then
		targeted = buttonDB.targeted
	end

	if (targeted) then
		if (targeted == "CHEST") then
			frame:SetAttribute("target-slot", 5)
			--frame:SetAttribute("target-slot2", 5)
		elseif (targeted == "SHIELD") then
			frame:SetAttribute("target-slot", 17)
			--frame:SetAttribute("target-slot2", 17)
		elseif (targeted == "WEAPON") then
			frame:SetAttribute("target-slot1", 16)
			frame:SetAttribute("target-slot2", 17)
		elseif (targeted == TRINKET1_SLOT) then
			frame:SetAttribute("target-slot1", TRINKET1_SLOT)
			frame:SetAttribute("target-slot2", TRINKET2_SLOT)
		elseif (targeted == TRINKET2_SLOT) then
			frame:SetAttribute("target-slot1", TRINKET2_SLOT)
			frame:SetAttribute("target-slot2", TRINKET1_SLOT)
		elseif (AutoBar.CLASS == "ROGUE" and targeted == "Lockpicking") then
				frame:SetAttribute("type2", "spell")
				frame:SetAttribute("spell2", SPELL_PICK_LOCK)
				frame:SetAttribute("target-bag2", bag)
				frame:SetAttribute("target-slot2", slot)
		elseif (targeted == "Milling") then
				frame:SetAttribute("type1", "spell")
				frame:SetAttribute("spell1", SPELL_MILL_HERB)
				frame:SetAttribute("target-bag1", bag)
				frame:SetAttribute("target-slot1", slot)
				frame:SetAttribute("type2", "item")
				frame:SetAttribute("item2", "Draenic Mortar")
				frame:SetAttribute("target-bag2", bag)
				frame:SetAttribute("target-slot2", slot)
		elseif (AutoBar.CLASS == "HUNTER" and targeted == "PET") then
			-- Right Click targets pet
			if (category and strfind(category, "Consumable.Food")) then
				frame:SetAttribute("type2", "spell")
				frame:SetAttribute("spell2", SPELL_FEED_PET)
				frame:SetAttribute("target-bag2", bag)
				frame:SetAttribute("target-slot2", slot)
			else
				frame:SetAttribute("unit2", "pet")
			end
		else
			-- Support selfcast-RightMouse
			if (selfCastRightClick) then
				frame:SetAttribute("unit2", "player")
			else
				frame:SetAttribute("unit2", nil)
			end
		end
	end

	if (enabled) then
		if (buttonDB) then
			-- Handle right click pet targeting for a slot
			if (buttonDB.rightClickTargetsPet) then
				if (category and strfind(category, "Consumable.Food")) then
					frame:SetAttribute("type2", "spell")
					frame:SetAttribute("spell2", SPELL_FEED_PET)
					frame:SetAttribute("target-bag2", bag)
					frame:SetAttribute("target-slot2", slot)
--AutoBar:Print("AutoBarButton.prototype:SetupAttributes buttonKey " .. tostring(buttonKey) .. " bag ".. tostring(bag).. " slot " .. tostring(slot))
				else
					frame:SetAttribute("unit2", "pet")
				end
			elseif (selfCastRightClick) then
				frame:SetAttribute("unit2", "player")
			end

			if (not castSpell) then
				castSpell = buttonDB.castSpell
			end
		end

		-- The matched spell to cast on RightClick
		if (itemsRightClick and itemsRightClick[itemId]) then
			castSpell = itemsRightClick[itemId]
			selfCastRightClick = nil
--AutoBar:Print("AutoBarButton.prototype:SetupAttributes category " .. category .. " castSpell " .. tostring(castSpell))
		end
		-- Special spell to cast on RightClick
		if (castSpell) then
			frame:SetAttribute("type2", "spell")
			frame:SetAttribute("spell2", castSpell)
		end

		-- selfCastRightClick targeting
		local unit2 = frame:GetAttribute("unit2")
		if (selfCastRightClick and not unit2) then
			frame:SetAttribute("unit2", "player")
		end

		local type2 = frame:GetAttribute("type2")
		if (not bag and slot) then
			local itemLink = GetInventoryItemLink("player", slot)
			frame:SetAttribute("type", "item")
			frame:SetAttribute("item", itemLink)

			-- Tooltip
			frame:SetAttribute("itemLink", itemLink)
		elseif (bag and slot) then
			local itemLink = GetContainerItemLink(bag, slot)
			frame:SetAttribute("itemLink", itemLink)
---			if (buttonDB.shuffle) then
---				itemLink = bag .. " " .. slot
---			end
			frame:SetAttribute("type", "item")
			frame:SetAttribute("item", itemLink)
			if (not type2) then
				frame:SetAttribute("type2", "item")
				frame:SetAttribute("item2", itemLink)
			end
		elseif (p_type_id == ABGData.TYPE_TOY) then
			frame:SetAttribute("type", "toy")
			frame:SetAttribute("toy", p_info_data.item_id)
			frame:SetAttribute("AutoBarGUID", p_info_data.guid)
		elseif (p_type_id == ABGData.TYPE_MACRO_TEXT) then
			frame:SetAttribute("type", "macro")
			frame:SetAttribute("macrotext", p_info_data.macro_text)
			frame:SetAttribute("AutoBarGUID", p_info_data.guid)
			frame:SetAttribute("itemLink", p_info_data.macro_tooltip)
			button.macroActive = true
		elseif (p_type_id == ABGData.TYPE_BATTLE_PET) then
			frame:SetAttribute("type", "macro")
			frame:SetAttribute("macrotext", p_info_data.macro_text)
			frame:SetAttribute("AutoBarGUID", p_info_data.guid)
			button.macroActive = true
		elseif (macroId) then
			local macroInfo = AutoBarSearch.macros[macroId]
			frame:SetAttribute("type", "macro")
			frame:SetAttribute("macroId", macroId)
			if (macroInfo.macroIndex) then
				frame:SetAttribute("macro", macroInfo.macroIndex)
				button.macroActive = true
			else
				frame:SetAttribute("macrotext", macroInfo.macroText)
				button.macroActive = true
				frame:SetAttribute("macroName", macroInfo.macroName)
				frame:SetAttribute("macroBody", macroInfo.macroText)

				frame:SetAttribute("macro_action", macroInfo.macro_action)
				--frame:SetAttribute("macro_tooltip", macroInfo.macro_tooltip)
				frame:SetAttribute("itemLink", macroInfo.macro_tooltip)
				frame:SetAttribute("macro_icon", macroInfo.macro_icon)
			end
		elseif (spell) then
			-- Default spell to cast
			frame:SetAttribute("type", "spell")
			frame:SetAttribute("spell", spell)

			-- Tooltip
			local spellInfo = AutoBarSearch.spells[spell]
			if (spellInfo and spellInfo.spellLink) then
				frame:SetAttribute("itemLink", spellInfo.spellLink)
			end
		elseif (castSpell) then
			-- Set castSpell as default if nothing else is available
--AutoBar:Print("AutoBarButton.prototype:SetupAttributes-castspell buttonKey " .. buttonKey .. " castSpell " .. tostring(castSpell))
			frame:SetAttribute("type", "spell")
			frame:SetAttribute("spell", castSpell)

			-- Tooltip
			local spellInfo = AutoBarSearch.spells[castSpell].spellLink
			if (spellInfo.spellLink) then
				frame:SetAttribute("itemLink", spellInfo.spellLink)
			end
		else
			frame:SetAttribute("type", nil)
			frame:SetAttribute("type2", nil)
		end
	end

	if (frame.menu) then
		frame:SetAttribute("type2", "menu")
	end
end
--[[
/dump AutoBar.buttonList["AutoBarButtonFoodPet"][1]
/dump AutoBar.buttonList["AutoBarButtonFoodPet"].frame.popupHeader.popupButtonList[2].frame:GetAttribute("type2")
/dump AutoBar.buttonList["AutoBarButtonFoodPet"].frame.popupHeader.popupButtonList[2].frame:GetAttribute("spell2")
/dump AutoBar.buttonList["AutoBarButtonFoodPet"].frame.popupHeader.popupButtonList[2].frame:GetAttribute("target-bag2")
/dump AutoBar.buttonList["AutoBarButtonFoodPet"].frame.popupHeader.popupButtonList[2].frame:GetAttribute("target-slot2")
/dump AutoBar.buttonList["AutoBarButtonBuff"].frame.popupHeader.popupButtonList[2].frame:GetAttribute("target-slot1")
/dump AutoBar.buttonList["AutoBarButtonClassBuff"].frame:GetAttribute("spell")
/dump AutoBar.buttonList["AutoBarButtonBuff"].frame:GetAttribute("target-slot2")
/dump AutoBar.buttonList["AutoBarButtonCooldownStoneMana"].frame:GetAttribute("itemId")
/dump AutoBar.buttonList["AutoBarButtonHealth"].frame:GetAttribute("itemId")
/dump AutoBar.buttonList["AutoBarButtonMillHerbs"].frame.popupHeader.popupButtonList[10].frame:GetAttribute("type")
--]]


--
-- Button Update callback functions
--

--function AutoBarButton:SetTooltip(button)
--AutoBar:Print("SetTooltip " .. tostring(self.needsTooltip) .. " button " .. tostring(button) .. " button " .. tostring(button) .. " showTooltip " .. tostring(AutoBar.db.account.showTooltip) .. " self.needsTooltip " .. tostring(self.needsTooltip))
--	local isAutoBarButton = self.class and self.class.buttonDB
--
--	if (isAutoBarButton and self.GetHotkey) then
--		LibKeyBound:Set(self)
--	end
--	local noTooltip = not (AutoBar.db.account.showTooltip and self.needsTooltip or AutoBar.moveButtonsMode)
--	noTooltip = noTooltip or (InCombatLockdown() and not AutoBar.db.account.showTooltipCombat) or (button == "OnLeave")
--	if (noTooltip) then
--		self.updateTooltip = nil
--		GameTooltip:Hide()
--		return
--	end
--
--	if (GetCVar("UberTooltips") == "1") then
--		GameTooltip_SetDefaultAnchor(GameTooltip, self)
--	else
--		local x = self:GetRight();
--		if ( x >= ( GetScreenWidth() / 2 ) ) then
--			GameTooltip:SetOwner(self, "ANCHOR_LEFT");
--		else
--			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
--		end
--	end
--
--	-- Add Button or Bar name
--	if (AutoBar.moveButtonsMode) then
--		if (self.class and self.class.sharedLayoutDB) then
--			GameTooltip:AddLine(self.class.barName)
--		elseif(isAutoBarButton) then
--			GameTooltip:AddLine(ABGCode.GetButtonDisplayName(self.class.buttonDB))
--		end
--	else
--		local buttonType = self:GetAttribute("type")
--
--		if (not buttonType) then
--			if (isAutoBarButton) then
--				GameTooltip:AddLine(ABGCode.GetButtonDisplayName(self.class.buttonDB))
--			else
--				self.updateTooltip = nil
--			end
--		elseif (buttonType == "item") then
--			local itemLink = self:GetAttribute("item")
--			if (itemLink) then
--				local itemId = self:GetAttribute("itemId")
--				local bag, slot = AutoBarSearch.found:GetItemData(itemId)
--				if (bag and slot) then
--					GameTooltip:SetBagItem(bag, slot)
--				elseif (slot) then
--					GameTooltip:SetInventoryItem("player", slot)
--				else
--					GameTooltip:SetHyperlink(itemLink)
--				end
--			end
--			self.updateTooltip = TOOLTIP_UPDATE_TIME
--			if (AutoBar.db.account.showTooltipExtended) then
--				print("GameTooltip_ShowCompareItem")
--				GameTooltip_ShowCompareItem()
--			end
---- /script local bag, slot = strmatch("3,4", "^(%d+)%s+(%d+)$"); AutoBar:Print("bag " .. tostring(bag).." slot " .. tostring(slot))
--		elseif (buttonType == "spell") then
--			local spellName = self:GetAttribute("spell")
--
--			if (spellName) then
--				local spellInfo = AutoBarSearch.spells[spellName]
--				GameTooltip:SetSpellBookItem(spellInfo.spellId, spellInfo.spellTab)
--			end
--			self.updateTooltip = TOOLTIP_UPDATE_TIME
--		end
--
--		local rightClickType = self:GetAttribute("type2")
--		if (rightClickType == "spell") then
--			local spellName = self:GetAttribute("spell2")
--			if (spellName) then
--				GameTooltip:AddLine(L["Right Click casts "] .. spellName, 1, 0.2, 1, 1)
--			end
--		end
--	end
--
--	GameTooltip:Show()
--end


-- Add your Button custom options to the optionlist
-- optionList[myCustomOptionKey]
-- Call specific SetOption<Type> methods to do the actual setting
function AutoBarButton.prototype.AddOptions(_self, _option_list, _pass_value)
end


local function set_button_option(p_info, p_value)

	local button_key = p_info.arg.buttonKey
	local button_db = AutoBar:GetButtonDB(button_key)

	button_db[p_info[# p_info]] = p_value
	button_db.is_dirty = true
	AutoBarChanged()
	AutoBar:ButtonsChanged();
end

-- Call specific option type methods to do the actual setting
function AutoBarButton.prototype:SetOptionBoolean(optionList, passValue, valueName, name, desc)
	if (not optionList.headerCustomOptions) then
		optionList.headerCustomOptions = {
			type = "header",
			order = 100,
			name = "",
		}
	end
	if (not optionList[valueName]) then
		optionList[valueName] = {
			type = "toggle",
			order = 110,
			name = name,
			desc = desc,
			arg = passValue,
			disabled = InCombatLockdown,
			set = set_button_option,
		}
	else
		optionList[valueName].arg = passValue
	end
end


-- Add category to the end of the buttons list
function AutoBarButton.prototype:AddCategory(p_category_name)
	if not AutoBarCategoryList[p_category_name] then
		ABGCode.LogWarning("AutoBar: Attempted to add nonexistent Category:", p_category_name)
	end
	for _, category in ipairs(self) do
		if (category == p_category_name) then
			-- Ignore.  ToDo shuffle to end.
			return
		end
	end
	-- Add to end
	self[# self + 1] = p_category_name
end

-- Delete category from the buttons list
function AutoBarButton.prototype:DeleteCategory(categoryName)
	for i, category in ipairs(self) do
		if (category == categoryName) then
			for j = i, # self do
				self[j] = self[j + 1]
				self[j + 1] = nil
			end
			return
		end
	end
end

-- Register the Macro
function AutoBarButton.prototype:AddMacro(macroText, macroTexture)
	self.macroText = macroText
	self.macroTexture = macroTexture
	local buttonKey = self.buttonDB.buttonKey
--AutoBar:Print("AutoBarButton.prototype:AddMacro RegisterMacro " .. tostring(buttonKey))
	AutoBarSearch:RegisterMacro(buttonKey, nil, L[buttonKey], macroText)
end


--AutoBarButtonMacro = AceOO.Class(AutoBarButton)
--
--function AutoBarButtonMacro.prototype:init(parentBar, buttonDB)
--	AutoBarButtonMacro.super.prototype.init(self, parentBar, buttonDB)
--end
--
---- Set the state attributes of the button
--function AutoBarButtonMacro.prototype:SetupButton()
--	local frame = self.frame
--
--	if (self.macroText and self.buttonDB.enabled) then
----AutoBar:Print("AutoBarButtonMacro.prototype:SetupButton buttonKey " .. tostring(self.buttonDB.buttonKey) .. " frame " .. tostring(frame))
--		frame:Show()
----- ToDo, disable popup
--		self:SetupAttributes(self, nil, nil, nil, self.buttonDB.buttonKey)
--	else
--		frame:Hide()
--	end
--end


local AutoBarButtonAspect = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonAspect"] = AutoBarButtonAspect

function AutoBarButtonAspect.prototype:init(parentBar, buttonDB)
	AutoBarButtonAspect.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Aspect")
end


local AutoBarButtonPoisonLethal = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonPoisonLethal"] = AutoBarButtonPoisonLethal

function AutoBarButtonPoisonLethal.prototype:init(parentBar, buttonDB)
	AutoBarButtonPoisonLethal.super.prototype.init(self, parentBar, buttonDB)

	if (ABGData.is_mainline_wow) then
		self:AddCategory("Spell.Poison.Lethal")
	else --(ABGData.is_vanilla_wow or ABGData.is_bcc_wow) then
		self:AddCategory("Muffin.Poison.Lethal")
	end
end

local AutoBarButtonPoisonNonlethal = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonPoisonNonlethal"] = AutoBarButtonPoisonNonlethal

function AutoBarButtonPoisonNonlethal.prototype:init(parentBar, buttonDB)
	AutoBarButtonPoisonNonlethal.super.prototype.init(self, parentBar, buttonDB)

	if (ABGData.is_mainline_wow) then
		self:AddCategory("Spell.Poison.Nonlethal")
	else --(ABGData.is_vanilla_wow or ABGData.is_bcc_wow) then
		self:AddCategory("Muffin.Poison.Nonlethal")
	end

end

local AutoBarButtonBandages = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonBandages"] = AutoBarButtonBandages

function AutoBarButtonBandages.prototype:init(parentBar, buttonDB)
	AutoBarButtonBandages.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Bandage.Basic")
	self:AddCategory("Consumable.Bandage.Battleground.Alterac Valley")
	self:AddCategory("Consumable.Bandage.Battleground.Arathi Basin")
	self:AddCategory("Consumable.Bandage.Battleground.Warsong Gulch")
end


local AutoBarButtonBattleStandards = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonBattleStandards"] = AutoBarButtonBattleStandards

function AutoBarButtonBattleStandards.prototype:init(parentBar, buttonDB)
	AutoBarButtonBattleStandards.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Misc.Battle Standard.Battleground")
	self:AddCategory("Misc.Battle Standard.Alterac Valley")
	self:AddCategory("Misc.Battle Standard.Guild")
end


local AutoBarButtonBuff = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonBuff"] = AutoBarButtonBuff

function AutoBarButtonBuff.prototype:init(parentBar, buttonDB)
	AutoBarButtonBuff.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Buff.Chest")
	self:AddCategory("Consumable.Buff.Shield")
	self:AddCategory("Consumable.Buff.Other.Self")
	self:AddCategory("Consumable.Buff Group.General.Target")
	self:AddCategory("Consumable.Buff Group.General.Self")
	self:AddCategory("Consumable.Buff.Water Breathing")

	self:AddCategory("Muffin.Potion.Water Breathing")

	if (ABGData.is_mainline_wow) then
		self:AddCategory("Muffin.Order Hall.Buff")
	end

	-- Melee
	if (AutoBar.CLASS ~= "MAGE" and AutoBar.CLASS ~= "WARLOCK" and AutoBar.CLASS ~= "PRIEST") then
		self:AddCategory("Consumable.Buff Group.Melee.Target")
		self:AddCategory("Consumable.Buff Group.Melee.Self")
	end

	-- Mana & Spell
	if (AutoBar.CLASS ~= "ROGUE" and AutoBar.CLASS ~= "WARRIOR") then
		self:AddCategory("Consumable.Buff Group.Caster.Target")
		self:AddCategory("Consumable.Buff Group.Caster.Self")
	end

	self:AddCategory("Muffin.Potion.Buff")

end


local AutoBarButtonBuffWeapon = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonBuffWeapon"] = AutoBarButtonBuffWeapon

function AutoBarButtonBuffWeapon.prototype:init(parentBar, buttonDB)
	AutoBarButtonBuffWeapon.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Weapon Buff")
	self:AddCategory("Spell.Buff.Weapon")

	if (ABGData.is_mainline_wow) then
		self:AddCategory("Spell.Poison.Lethal")
		self:AddCategory("Spell.Poison.Nonlethal")
	else --(ABGData.is_vanilla_wow or ABGData.is_bcc_wow) then
		self:AddCategory("Muffin.Poison.Lethal")
		self:AddCategory("Muffin.Poison.Nonlethal")
	end

end


local AutoBarButtonClassBuff = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonClassBuff"] = AutoBarButtonClassBuff

function AutoBarButtonClassBuff.prototype:init(parentBar, buttonDB)
	AutoBarButtonClassBuff.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Class.Buff")
end

function AutoBarButtonClassBuff.prototype:SetupAttributes(button, bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData)
	local selfCastRightClick = AutoBar.db.account.selfCastRightClick
	AutoBar.db.account.selfCastRightClick = nil
	AutoBarButtonClassBuff.super.prototype.SetupAttributes(self, button, bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData)
	AutoBar.db.account.selfCastRightClick = selfCastRightClick
end

local AutoBarButtonClassPets2 = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonClassPets2"] = AutoBarButtonClassPets2

function AutoBarButtonClassPets2.prototype:init(parentBar, buttonDB)
	AutoBarButtonClassPets2.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Class.Pets2")
end

local AutoBarButtonClassPet = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonClassPet"] = AutoBarButtonClassPet

function AutoBarButtonClassPet.prototype:init(parentBar, buttonDB)
	AutoBarButtonClassPet.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Class.Pet")
end

local AutoBarButtonClassPets3 = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonClassPets3"] = AutoBarButtonClassPets3

function AutoBarButtonClassPets3.prototype:init(parentBar, buttonDB)
	AutoBarButtonClassPets3.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Class.Pets3")
end

local AutoBarButtonConjure = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonConjure"] = AutoBarButtonConjure

function AutoBarButtonConjure.prototype:init(parentBar, buttonDB)
	AutoBarButtonConjure.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "MAGE") then
		self:AddCategory("Spell.Mage.Conjure Food")
		self:AddCategory("Spell.Mage.Create Manastone")
		if (not ABGData.is_mainline_wow) then --(ABGData.is_vanilla_wow or ABGData.is_bcc_wow) then
			self:AddCategory("Spell.Mage.Conjure Water")
		end
	elseif (AutoBar.CLASS == "WARLOCK") then
		self:AddCategory("Spell.Warlock.Create Healthstone")
		if (not ABGData.is_mainline_wow) then --(ABGData.is_vanilla_wow or ABGData.is_bcc_wow) then
			self:AddCategory("Spell.Warlock.Create Soulstone")
		end

	end
end


local AutoBarButtonOpenable = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonOpenable"] = AutoBarButtonOpenable

function AutoBarButtonOpenable.prototype:init(parentBar, buttonDB)
	AutoBarButtonOpenable.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Muffin.Misc.Openable")
end


local AutoBarButtonCrafting = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCrafting"] = AutoBarButtonCrafting

function AutoBarButtonCrafting.prototype:init(parentBar, buttonDB)
	AutoBarButtonCrafting.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Crafting")
end

if (ABGData.is_mainline_wow) then
	--TODO: Clean up all this crap once I know it's working
	local function find_known_spell(p_list)
		for _i, id in ipairs(p_list) do
			if IsSpellKnown(id) then
				return id
			end
		end
	end

	local cooking_spell_id
	local jc_spell_id
	local alchemy_spell_id
	local lw_spell_id
	local scribe_spell_id
	local smith_spell_id
	local chant_spell_id
	local tailor_spell_id
	local eng_spell_id

	function AutoBarButtonCrafting.prototype:SetupAttributes(button, bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData)

		local debug = false --= true or (spell == "Cooking")

		if (debug) then print("Spell:", spell, "ItemId:", itemId, ABGData.spell_name_list[spell], ABGData.spell_name_list["Cooking"]); end

			if(spell == ABGData.spell_name_list["Jewelcrafting"]) then
				jc_spell_id = jc_spell_id or find_known_spell({25229, 158750, 195116, 25230, 28894, 28895, 28897, 51311, 73318, 110420, 264532})
				spell = jc_spell_id
			elseif (spell == ABGData.spell_name_list["Alchemy"]) then
				alchemy_spell_id = alchemy_spell_id or find_known_spell({2259, 195095, 156606, 3101, 3464, 11611, 28596, 51304, 80731, 105206, 264211})
				spell = alchemy_spell_id
			elseif (spell == ABGData.spell_name_list["Leatherworking"]) then
				lw_spell_id = lw_spell_id or find_known_spell({2108, 158752, 195119, 3104, 3811, 10662, 32549, 51302, 81199, 110423, 264577})
				spell = lw_spell_id
			elseif (spell == ABGData.spell_name_list["Inscription"]) then
				scribe_spell_id = scribe_spell_id or find_known_spell({45357, 195115, 158748, 45358, 45359, 45360, 45361, 45363, 86008, 110417, 264494})
				spell = scribe_spell_id
			elseif (spell == ABGData.spell_name_list["Blacksmithing"]) then
				smith_spell_id = smith_spell_id or find_known_spell({2018, 195097, 158737, 3100, 3538, 9785, 29844, 51300, 76666, 110396, 264434})
				spell = smith_spell_id
			elseif (spell == ABGData.spell_name_list["Cooking"]) then
				cooking_spell_id = cooking_spell_id or find_known_spell({2550, 158765, 3102, 3413, 18260, 33359, 51296, 88053, 104381, 195128 })
				spell = cooking_spell_id
			elseif (spell == ABGData.spell_name_list["Enchanting"]) then
				chant_spell_id = chant_spell_id or find_known_spell({7411, 195096, 158716, 7412, 7413, 13920, 28029, 51313, 74258, 110400, 264455})
				spell = chant_spell_id
			elseif (spell == ABGData.spell_name_list["Tailoring"]) then
				tailor_spell_id = tailor_spell_id or find_known_spell({3908, 195126, 158758, 3909, 3910, 12180, 26790, 51309, 75156, 110426, 264616})
				spell = tailor_spell_id
			elseif (spell == ABGData.spell_name_list["Engineering"]) then
				eng_spell_id = eng_spell_id or find_known_spell({4036, 195112, 49383, 158739, 4037, 4038, 12656, 30350, 51306, 82774, 110403, 264475})
				spell = eng_spell_id
			end

		if (debug) then print("Spell:", spell, "ItemId:", itemId, ABGData.spell_name_list[spell], ABGData.spell_name_list["Cooking"]); end

		AutoBarButtonCrafting.super.prototype.SetupAttributes(self, button, bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData)

	end
end

--[[
		"*", ABGCode.GetSpellNameByName("Archaeology"),
		"*", ABGCode.GetSpellNameByName("Cooking Fire"),
		"*", ABGCode.GetSpellNameByName("Disenchant"),
		"*", ABGCode.GetSpellNameByName("Milling"),
		"*", ABGCode.GetSpellNameByName("Prospecting"),
		"*", ABGCode.GetSpellNameByName("Smelting"),
		"*", ABGCode.GetSpellNameByName("Survey"),
--]]

AutoBarButtonCustom = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCustom"] = AutoBarButtonCustom

function AutoBarButtonCustom.prototype:init(parentBar, buttonDB)
	AutoBarButtonCustom.super.prototype.init(self, parentBar, buttonDB)
	self.frame.SetKey = nil
end

function AutoBarButtonCustom.prototype:GetButtonBinding()
	return nil
end

function AutoBarButtonCustom.prototype:CreateButtonFrame()
	AutoBarButtonCustom.super.prototype.CreateButtonFrame(self)
	self.frame.GetActionName = nil
	self.frame.SetKey = nil
	self.frame.ClearBindings = nil
	self.frame.GetBindings = nil
end


local AutoBarButtonBear = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonBear"] = AutoBarButtonBear

function AutoBarButtonBear.prototype:init(parentBar, buttonDB)
	AutoBarButtonBear.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.BearForm")

end

local AutoBarButtonMoonkin = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonMoonkin"] = AutoBarButtonMoonkin

function AutoBarButtonMoonkin.prototype:init(parentBar, buttonDB)
	AutoBarButtonMoonkin.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.MoonkinForm")

end

local AutoBarButtonTreeForm = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTreeForm"] = AutoBarButtonTreeForm

function AutoBarButtonTreeForm.prototype:init(parentBar, buttonDB)
	AutoBarButtonTreeForm.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.TreeForm")

end


local AutoBarButtonCat = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCat"] = AutoBarButtonCat

function AutoBarButtonCat.prototype:init(parentBar, buttonDB)
	AutoBarButtonCat.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.CatForm")

end


local AutoBarButtonCharge = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCharge"] = AutoBarButtonCharge

function AutoBarButtonCharge.prototype:init(parentBar, buttonDB)
	AutoBarButtonCharge.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Charge")

end

local AutoBarButtonInterrupt = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonInterrupt"] = AutoBarButtonInterrupt

function AutoBarButtonInterrupt.prototype:init(parentBar, buttonDB)
	AutoBarButtonInterrupt.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Interrupt")

end

local AutoBarButtonTravel = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTravel"] = AutoBarButtonTravel

function AutoBarButtonTravel.prototype:init(parentBar, buttonDB)
	AutoBarButtonTravel.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Travel")

end


local AutoBarButtonDebuff = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonDebuff"] = AutoBarButtonDebuff

function AutoBarButtonDebuff.prototype:init(parentBar, buttonDB)
	AutoBarButtonDebuff.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Debuff.Single")
	self:AddCategory("Spell.Debuff.Multiple")
end


local AutoBarButtonElixirBattle = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonElixirBattle"] = AutoBarButtonElixirBattle

function AutoBarButtonElixirBattle.prototype:init(parentBar, buttonDB)
	AutoBarButtonElixirBattle.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Muffin.Elixir.Battle")
end


local AutoBarButtonElixirGuardian = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonElixirGuardian"] = AutoBarButtonElixirGuardian

function AutoBarButtonElixirGuardian.prototype:init(parentBar, buttonDB)
	AutoBarButtonElixirGuardian.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Muffin.Elixir.Guardian")
end


local AutoBarButtonElixirBoth = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonElixirBoth"] = AutoBarButtonElixirBoth

function AutoBarButtonElixirBoth.prototype:init(parentBar, buttonDB)
	AutoBarButtonElixirBoth.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Muffin.Flask")
end

local AutoBarButtonER = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonER"] = AutoBarButtonER

function AutoBarButtonER.prototype:init(parentBar, buttonDB)
	AutoBarButtonER.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.ER")

end


local AutoBarButtonExplosive = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonExplosive"] = AutoBarButtonExplosive

function AutoBarButtonExplosive.prototype:init(parentBar, buttonDB)
	AutoBarButtonExplosive.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Muffin.Explosives")
end


local AutoBarButtonFishing = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonFishing"] = AutoBarButtonFishing

function AutoBarButtonFishing.prototype:init(parentBar, buttonDB)
	AutoBarButtonFishing.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Muffin.Skill.Fishing.Bait")
	self:AddCategory("Muffin.Skill.Fishing.Lure")
	self:AddCategory("Muffin.Skill.Fishing.Misc")
	self:AddCategory("Muffin.Skill.Fishing.Pole")
	self:AddCategory("Muffin.Skill.Fishing.Rare Fish")
	if (ABGData.is_mainline_wow) then
		self:AddCategory("Muffin.Toys.Fishing")
	end

	self:AddCategory("Tradeskill.Tool.Fishing.Gear")
	self:AddCategory("Tradeskill.Tool.Fishing.Other")
	self:AddCategory("Tradeskill.Tool.Fishing.Tool")
	self:AddCategory("Tradeskill.Tool.Fishing.Bait")
	self:AddCategory("Spell.Fishing")
end

local AutoBarButtonFood = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonFood"] = AutoBarButtonFood

function AutoBarButtonFood.prototype:init(parentBar, buttonDB)
	AutoBarButtonFood.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "MAGE" and not buttonDB.disableConjure) then
		self:AddCategory("Spell.Mage.Conjure Food")
	end

	self:AddCategory("Muffin.Food.Health.Basic")

	if (buttonDB.include_combo_basic) then
		self:AddCategory("Muffin.Food.Combo.Basic")
	end

	self:AddCategory("Consumable.Food.Percent.Basic")
end

--local function SetDisableConjure(info, value)
--	local buttonDB = AutoBar:GetButtonDB(info.arg.buttonKey)
--	buttonDB.disableConjure = value
--	AutoBar:BarButtonChanged()
--	AutoBar:CategoriesChanged()
--end

--function AutoBarButtonFood.prototype:Refresh(parentBar, buttonDB)
--	AutoBarButtonFood.super.prototype.Refresh(self, parentBar, buttonDB)
--	if (AutoBar.CLASS == "MAGE") then
--		if (buttonDB.disableConjure) then
--			self:DeleteCategory("Consumable.Food.Conjure")
--			buttonDB.castSpell = nil
--			AutoBarCategoryList["Consumable.Food.Edible.Combo.Conjured"]:SetCastList(nil)
--		else
--			self:AddCategory("Consumable.Food.Conjure")
--		end
--	end
--end

function AutoBarButtonFood.prototype:AddOptions(optionList, passValue)
	if (AutoBar.CLASS == "MAGE") then
		self:SetOptionBoolean(optionList, passValue, "disableConjure", L["Disable Conjure Button"])
	end

	self:SetOptionBoolean(optionList, passValue, "include_combo_basic", L["Include Basic Combo Food"])

end


local AutoBarButtonFoodBuff = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonFoodBuff"] = AutoBarButtonFoodBuff

function AutoBarButtonFoodBuff.prototype:init(parentBar, buttonDB)
	AutoBarButtonFoodBuff.super.prototype.init(self, parentBar, buttonDB)

--	self:AddCategory("Consumable.Food.Buff.Stamina")
--	self:AddCategory("Consumable.Food.Buff.HP Regen")
--	self:AddCategory("Consumable.Food.Percent.Bonus")

	self:AddCategory("Muffin.Food.Health.Buff")

--	if (AutoBar.CLASS == "DEATHKNIGHT" or AutoBar.CLASS == "WARRIOR") then
--		self:AddCategory("Consumable.Food.Buff.Strength")
--		self:AddCategory("Consumable.Food.Buff.Attack Power")
--		self:AddCategory("Consumable.Food.Buff.Dodge")
--	elseif (AutoBar.CLASS == "DRUID") then
--		self:AddCategory("Consumable.Food.Buff.Agility")
--		self:AddCategory("Consumable.Food.Buff.Attack Power")
--		self:AddCategory("Consumable.Food.Buff.Dodge")
--		self:AddCategory("Consumable.Food.Buff.Healing")
--		self:AddCategory("Consumable.Food.Buff.Intellect")
--		self:AddCategory("Consumable.Food.Buff.Mana Regen")
--		self:AddCategory("Consumable.Food.Buff.Spell Damage")
--		self:AddCategory("Consumable.Food.Buff.Spirit")
--	elseif (AutoBar.CLASS == "HUNTER" or AutoBar.CLASS == "ROGUE") then
--		self:AddCategory("Consumable.Food.Buff.Agility")
--		self:AddCategory("Consumable.Food.Buff.Attack Power")
--	elseif (AutoBar.CLASS == "MAGE"or AutoBar.CLASS == "WARLOCK") then
--		self:AddCategory("Consumable.Food.Buff.Intellect")
--		self:AddCategory("Consumable.Food.Buff.Mana Regen")
--		self:AddCategory("Consumable.Food.Buff.Spell Damage")
--		self:AddCategory("Consumable.Food.Buff.Spirit")
--	elseif (AutoBar.CLASS == "PALADIN") then
--		self:AddCategory("Consumable.Food.Buff.Strength")
--		self:AddCategory("Consumable.Food.Buff.Attack Power")
--		self:AddCategory("Consumable.Food.Buff.Dodge")
--		self:AddCategory("Consumable.Food.Buff.Healing")
--		self:AddCategory("Consumable.Food.Buff.Intellect")
--		self:AddCategory("Consumable.Food.Buff.Mana Regen")
--		self:AddCategory("Consumable.Food.Buff.Spell Damage")
--		self:AddCategory("Consumable.Food.Buff.Spirit")
--	elseif (AutoBar.CLASS == "PRIEST") then
--		self:AddCategory("Consumable.Food.Buff.Intellect")
--		self:AddCategory("Consumable.Food.Buff.Mana Regen")
--		self:AddCategory("Consumable.Food.Buff.Spell Damage")
--		self:AddCategory("Consumable.Food.Buff.Spirit")
--		self:AddCategory("Consumable.Food.Buff.Healing")
--	elseif (AutoBar.CLASS == "ROGUE") then
--		self:AddCategory("Consumable.Food.Buff.Agility")
--		self:AddCategory("Consumable.Food.Buff.Attack Power")
--	elseif (AutoBar.CLASS == "SHAMAN") then
--		self:AddCategory("Consumable.Food.Buff.Agility")
--		self:AddCategory("Consumable.Food.Buff.Attack Power")
--		self:AddCategory("Consumable.Food.Buff.Healing")
--		self:AddCategory("Consumable.Food.Buff.Intellect")
--		self:AddCategory("Consumable.Food.Buff.Mana Regen")
--		self:AddCategory("Consumable.Food.Buff.Spell Damage")
--		self:AddCategory("Consumable.Food.Buff.Spirit")
--	end
--
--	self:AddCategory("Consumable.Food.Buff.Other")
end


local AutoBarButtonFoodCombo = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonFoodCombo"] = AutoBarButtonFoodCombo

function AutoBarButtonFoodCombo.prototype:init(parentBar, buttonDB)
	AutoBarButtonFoodCombo.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Muffin.Food.Combo.Basic")
	self:AddCategory("Muffin.Food.Combo.Buff")

end


local AutoBarButtonFoodPet = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonFoodPet"] = AutoBarButtonFoodPet

function AutoBarButtonFoodPet.prototype:init(parentBar, buttonDB)
	AutoBarButtonFoodPet.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "HUNTER") then
		self:AddCategory("Consumable.Food.Bread")
		self:AddCategory("Consumable.Food.Cheese")
		self:AddCategory("Consumable.Food.Fish")
		self:AddCategory("Consumable.Food.Fruit")
		self:AddCategory("Consumable.Food.Fungus")
		self:AddCategory("Consumable.Food.Meat")
		self:AddCategory("Consumable.Buff Pet")
	end

	self.rightClickTargetsPet = true
end


local AutoBarButtonFreeAction = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonFreeAction"] = AutoBarButtonFreeAction

function AutoBarButtonFreeAction.prototype:init(parentBar, buttonDB)
	AutoBarButtonFreeAction.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Buff.Free Action")
end


local AutoBarButtonHeal = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonHeal"] = AutoBarButtonHeal

function AutoBarButtonHeal.prototype:init(parentBar, buttonDB)
	AutoBarButtonHeal.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Muffin.Stones.Health")
	self:AddCategory("Muffin.Potion.Health")
	self:AddCategory("Muffin.Potion.Combo")

end

local AutoBarButtonHearth = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonHearth"] = AutoBarButtonHearth

function AutoBarButtonHearth.prototype:init(parentBar, buttonDB)
	AutoBarButtonHearth.super.prototype.init(self, parentBar, buttonDB)

	local class = AutoBar.CLASS

	if (class == "DEATHKNIGHT" or class == "DRUID" or class == "MAGE" or class == "SHAMAN" or class == "WARLOCK" or class ==  "MONK") then
		self:AddCategory("Spell.Portals")
	end

	if(buttonDB.hearth_include_ancient_dalaran and class == "MAGE") then
		self:AddCategory("Spell.AncientDalaranPortals")
	end

	if (AutoBarCategoryList["Muffin.Misc.Hearth"]) then
		self:AddCategory("Muffin.Misc.Hearth")
	end
	self:AddCategory("Misc.Hearth")

	if (ABGData.is_mainline_wow) then
		AutoBarCategoryList["Muffin.Toys.Hearth"].only_favourites = buttonDB.only_favourite_hearth

		self:AddCategory("Muffin.Toys.Hearth")
		self:AddCategory("Muffin.Toys.Portal")

		if(buttonDB.hearth_include_challenge_portals) then
			self:AddCategory("Spell.ChallengePortals")
		end

	end
end

if (ABGData.is_mainline_wow) then
	function AutoBarButtonHearth.prototype:AddOptions(optionList, passValue)
		self:SetOptionBoolean(optionList, passValue, "hearth_include_ancient_dalaran", L["HearthIncludeAncientDalaran"])
		self:SetOptionBoolean(optionList, passValue, "only_favourite_hearth", L["OnlyFavouriteHearth"])
		self:SetOptionBoolean(optionList, passValue, "hearth_include_challenge_portals", L["HearthIncludeChallengePortals"])
	end

	function AutoBarButtonHearth.prototype:Refresh(parentBar, buttonDB)
		AutoBarCategoryList["Muffin.Toys.Hearth"].only_favourites = buttonDB.only_favourite_hearth

		AutoBarButtonHearth.super.prototype.Refresh(self, parentBar, buttonDB)
	end

end







local AutoBarButtonPickLock = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonPickLock"] = AutoBarButtonPickLock

function AutoBarButtonPickLock.prototype:init(parentBar, buttonDB)
	AutoBarButtonPickLock.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Misc.Unlock")
	self:AddCategory("Misc.Lockboxes")
end


local AutoBarButtonMiscFun = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonMiscFun"] = AutoBarButtonMiscFun

function AutoBarButtonMiscFun.prototype:init(parentBar, buttonDB)
	AutoBarButtonMiscFun.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Food.Feast")
	self:AddCategory("Misc.Usable.Permanent")
	self:AddCategory("Misc.Usable.Fun")
	self:AddCategory("Misc.Usable.Replenished")
end

local AutoBarButtonReputation = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonReputation"] = AutoBarButtonReputation

function AutoBarButtonReputation.prototype:init(parentBar, buttonDB)
	AutoBarButtonReputation.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Muffin.Misc.Reputation")
end


local AutoBarButtonQuest = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonQuest"] = AutoBarButtonQuest

function AutoBarButtonQuest.prototype:init(parentBar, buttonDB)
	AutoBarButtonQuest.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Misc.Usable.StartsQuest")
	self:AddCategory("Muffin.Misc.Quest")
	self:AddCategory("Muffin.Misc.StartsQuest")
	self:AddCategory("Misc.Usable.BossItem")
	if (ABGData.is_mainline_wow) then
		self:AddCategory("Dynamic.Quest")
	end
end

local AutoBarButtonRaidTarget = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonRaidTarget"] = AutoBarButtonRaidTarget

function AutoBarButtonRaidTarget.prototype:init(parentBar, buttonDB)
	AutoBarButtonRaidTarget.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Macro.Raid Target")
end


local AutoBarButtonRecovery = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonRecovery"] = AutoBarButtonRecovery

function AutoBarButtonRecovery.prototype:init(parentBar, buttonDB)
	AutoBarButtonRecovery.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "ROGUE") then
		self:AddCategory("Consumable.Buff.Energy")
	end

	if (AutoBar.CLASS == "WARRIOR" or AutoBar.CLASS == "DRUID") then
		self:AddCategory("Consumable.Buff.Rage")
		self:AddCategory("Muffin.Potion.Rage")
	end

	if  (ABGCode.ClassUsesMana(AutoBar.CLASS)) then
		--self:AddCategory("Consumable.Potion.Recovery.Mana.Endless")
		--self:AddCategory("Consumable.Potion.Recovery.Mana.Basic")

		--self:AddCategory("Consumable.Potion.Recovery.Rejuvenation.Basic")

		self:AddCategory("Muffin.Potion.Mana")
		self:AddCategory("Muffin.Potion.Combo")
		self:AddCategory("Muffin.Stones.Mana")

		self:AddCategory("Consumable.Cooldown.Stone.Mana.Other")
		--self:AddCategory("Consumable.Cooldown.Potion.Rejuvenation")
		--self:AddCategory("Consumable.Cooldown.Potion.Mana.Basic")
		--self:AddCategory("Consumable.Cooldown.Potion.Mana.Pvp")
		--self:AddCategory("Consumable.Cooldown.Potion.Mana.Anywhere")
	end
end




local AutoBarButtonDrums = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonDrums"] = AutoBarButtonDrums

function AutoBarButtonDrums.prototype:init(parentBar, buttonDB)
	AutoBarButtonDrums.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBarCategoryList["Muffin.Drum"]) then
		self:AddCategory("Muffin.Drum")
	end
	if (AutoBarCategoryList["Consumable.Cooldown.Drums"]) then
		self:AddCategory("Consumable.Cooldown.Drums")
	end
end


local AutoBarButtonCooldownPotionCombat = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCooldownPotionCombat"] = AutoBarButtonCooldownPotionCombat

function AutoBarButtonCooldownPotionCombat.prototype:init(parentBar, buttonDB)
	AutoBarButtonCooldownPotionCombat.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Cooldown.Potion.Combat")
end



local AutoBarButtonCooldownPotionRejuvenation = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCooldownPotionRejuvenation"] = AutoBarButtonCooldownPotionRejuvenation

function AutoBarButtonCooldownPotionRejuvenation.prototype:init(parentBar, buttonDB)
	AutoBarButtonCooldownPotionRejuvenation.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Cooldown.Potion.Rejuvenation")
end



local AutoBarButtonCooldownStoneRejuvenation = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonCooldownStoneRejuvenation"] = AutoBarButtonCooldownStoneRejuvenation

function AutoBarButtonCooldownStoneRejuvenation.prototype:init(parentBar, buttonDB)
	AutoBarButtonCooldownStoneRejuvenation.super.prototype.init(self, parentBar, buttonDB)

--	if (AutoBar.CLASS ~= "ROGUE" and AutoBar.CLASS ~= "WARRIOR") then
--		self:AddCategory("Consumable.Cooldown.Potion.Rejuvenation")
--	end
end


local AutoBarButtonShields = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonShields"] = AutoBarButtonShields

function AutoBarButtonShields.prototype:init(parentBar, buttonDB)
	AutoBarButtonShields.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Shields")
end


local AutoBarButtonSpeed = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonSpeed"] = AutoBarButtonSpeed

function AutoBarButtonSpeed.prototype:init(parentBar, buttonDB)
	AutoBarButtonSpeed.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Consumable.Buff.Speed")
end

local AutoBarButtonSeal = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonSeal"] = AutoBarButtonSeal

function AutoBarButtonSeal.prototype:init(parentBar, buttonDB)
	AutoBarButtonSeal.super.prototype.init(self, parentBar, buttonDB)

		self:AddCategory("Spell.Seal")
end

local AutoBarButtonStance = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonStance"] = AutoBarButtonStance

function AutoBarButtonStance.prototype:init(parentBar, buttonDB)
	AutoBarButtonStance.super.prototype.init(self, parentBar, buttonDB)

		self:AddCategory("Spell.Stance")
end

function AutoBarButtonStance.prototype:GetLastUsed()
	local nStance = GetShapeshiftForm(true)
	local _, name = GetShapeshiftFormInfo(nStance)
	return name
end


local AutoBarButtonStealth = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonStealth"] = AutoBarButtonStealth

function AutoBarButtonStealth.prototype:init(parentBar, buttonDB)
	AutoBarButtonStealth.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Stealth")
end



--------------------------------------------------ADDING NEW FUNCTIONALITY HERE

local totemAir = 4
local totemEarth = 2
local totemFire = 1
local totemWater = 3

local destroyMacro = {
	[totemFire] = "/run DestroyTotem(1)",
	[totemEarth] = "/run DestroyTotem(2)",
	[totemWater] = "/run DestroyTotem(3)",
	[totemAir] = "/run DestroyTotem(4)",
}
local function DestroyTotem(frame, totemType)
	frame:SetAttribute("type2", "macro")
	frame:SetAttribute("macrotext2", destroyMacro[totemType])
end

local AutoBarButtonTotemAir = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTotemAir"] = AutoBarButtonTotemAir

function AutoBarButtonTotemAir.prototype:init(parentBar, buttonDB)
	AutoBarButtonTotemAir.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Totem.Air")
end

function AutoBarButtonTotemAir.prototype:SetupAttributes(button, bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData)
	AutoBarButtonTotemAir.super.prototype.SetupAttributes(self, button, bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData)

	DestroyTotem(self.frame, totemAir)
end

-- Set cooldown based on the deployed totem
function AutoBarButtonTotemAir.prototype:UpdateCooldown()
	local itemType = self.frame:GetAttribute("type")
	if (itemType and not self.parentBar.faded) then
		local enabled = true
		local _, _totemName, start, duration = GetTotemInfo(totemAir)

		if (start and duration and enabled and start > 0 and duration > 0) then
			self.frame.cooldown:Show() -- ToDo: necessary?
			CooldownFrame_Set(self.frame.cooldown, start, duration, enabled)
		else
			CooldownFrame_Set(self.frame.cooldown, 0, 0, 0)
		end

		local popupHeader = self.frame.popupHeader
		if (popupHeader) then
			for _, popupButton in pairs(popupHeader.popupButtonList) do
				popupButton:UpdateCooldown()
			end
		end
	end
end
-- /script CooldownFrame_Set(AutoBarButtonTotemAirFrame.cooldown, 0, 0, 0)

local AutoBarButtonTotemEarth = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTotemEarth"] = AutoBarButtonTotemEarth

function AutoBarButtonTotemEarth.prototype:init(parentBar, buttonDB)
	AutoBarButtonTotemEarth.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Totem.Earth")
end

function AutoBarButtonTotemEarth.prototype:SetupAttributes(button, bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData)
	AutoBarButtonTotemEarth.super.prototype.SetupAttributes(self, button, bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData)

	DestroyTotem(self.frame, totemEarth)
end

-- Set cooldown based on the deployed totem
function AutoBarButtonTotemEarth.prototype:UpdateCooldown()
	local itemType = self.frame:GetAttribute("type")
	if (itemType and not self.parentBar.faded) then
		local enabled = true
		local _, _totemName, start, duration = GetTotemInfo(totemEarth)

		if (start and duration and enabled and start > 0 and duration > 0) then
			self.frame.cooldown:Show() -- ToDo: necessary?
			CooldownFrame_Set(self.frame.cooldown, start, duration, enabled)
		else
			CooldownFrame_Set(self.frame.cooldown, 0, 0, 0)
		end

		local popupHeader = self.frame.popupHeader
		if (popupHeader) then
			for _, popupButton in pairs(popupHeader.popupButtonList) do
				popupButton:UpdateCooldown()
			end
		end
	end
end


local AutoBarButtonTotemFire = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTotemFire"] = AutoBarButtonTotemFire

function AutoBarButtonTotemFire.prototype:init(parentBar, buttonDB)
	AutoBarButtonTotemFire.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Totem.Fire")
end

function AutoBarButtonTotemFire.prototype:SetupAttributes(button, bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData)
	AutoBarButtonTotemFire.super.prototype.SetupAttributes(self, button, bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData)

	DestroyTotem(self.frame, totemFire)
end

-- Set cooldown based on the deployed totem
function AutoBarButtonTotemFire.prototype:UpdateCooldown()
	local itemType = self.frame:GetAttribute("type")
	if (itemType and not self.parentBar.faded) then
		local enabled = true
		local _, _totemName, start, duration = GetTotemInfo(totemFire)

		if (start and duration and enabled and start > 0 and duration > 0) then
			self.frame.cooldown:Show() -- ToDo: necessary?
			CooldownFrame_Set(self.frame.cooldown, start, duration, enabled)
		else
			CooldownFrame_Set(self.frame.cooldown, 0, 0, 0)
		end

		local popupHeader = self.frame.popupHeader
		if (popupHeader) then
			for _, popupButton in pairs(popupHeader.popupButtonList) do
				popupButton:UpdateCooldown()
			end
		end
	end
end


local AutoBarButtonTotemWater = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTotemWater"] = AutoBarButtonTotemWater

function AutoBarButtonTotemWater.prototype:init(parentBar, buttonDB)
	AutoBarButtonTotemWater.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Totem.Water")
end

function AutoBarButtonTotemWater.prototype:SetupAttributes(button, bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData)
	AutoBarButtonTotemWater.super.prototype.SetupAttributes(self, button, bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData)

	DestroyTotem(self.frame, totemWater)
end

-- Set cooldown based on the deployed totem
function AutoBarButtonTotemWater.prototype:UpdateCooldown()
	local itemType = self.frame:GetAttribute("type")
	if (itemType and not self.parentBar.faded) then
		local enabled = true
		local _, _totemName, start, duration = GetTotemInfo(totemWater)

		if (start and duration and enabled and start > 0 and duration > 0) then
			self.frame.cooldown:Show() -- ToDo: necessary?
			CooldownFrame_Set(self.frame.cooldown, start, duration, enabled)
		else
			CooldownFrame_Set(self.frame.cooldown, 0, 0, 0)
		end

		local popupHeader = self.frame.popupHeader
		if (popupHeader) then
			for _, popupButton in pairs(popupHeader.popupButtonList) do
				popupButton:UpdateCooldown()
			end
		end
	end
end


local AutoBarButtonTrap = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTrap"] = AutoBarButtonTrap

function AutoBarButtonTrap.prototype:init(parentBar, buttonDB)
	AutoBarButtonTrap.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Trap")
end


local AutoBarButtonTrinket1 = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTrinket1"] = AutoBarButtonTrinket1

function AutoBarButtonTrinket1.prototype:init(parentBar, buttonDB)
	AutoBarButtonTrinket1.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Muffin.Gear.Trinket")
	buttonDB.targeted = TRINKET1_SLOT
	buttonDB.equipped = TRINKET1_SLOT
end

function AutoBarButtonTrinket1.prototype:GetLastUsed()
	local _, itemId = AutoBar.ItemLinkDecode(GetInventoryItemLink("player", TRINKET1_SLOT))
	return itemId
end

function AutoBarButtonTrinket1.prototype:SetDragCursor()
	local itemType = self.frame:GetAttribute("type")
	if (itemType) then
		if (itemType == "item") then
			PickupInventoryItem(TRINKET1_SLOT)
		end
	end
end

local AutoBarButtonTrinket2 = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTrinket2"] = AutoBarButtonTrinket2

function AutoBarButtonTrinket2.prototype:init(parentBar, buttonDB)
	AutoBarButtonTrinket2.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Muffin.Gear.Trinket")
	buttonDB.targeted = TRINKET2_SLOT
	buttonDB.equipped = TRINKET2_SLOT
end

function AutoBarButtonTrinket2.prototype:GetLastUsed()
	local _, itemId = AutoBar.ItemLinkDecode(GetInventoryItemLink("player", TRINKET2_SLOT))
	return itemId
end

function AutoBarButtonTrinket2.prototype:SetDragCursor()
	local itemType = self.frame:GetAttribute("type")
	if (itemType and itemType == "item") then
		PickupInventoryItem(TRINKET2_SLOT)
	end
end


local equipTrinket2String = "/equipslot " .. TRINKET2_SLOT .. " "
function AutoBarButtonTrinket2.prototype:SetupAttributes(button, bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData)
--AutoBar:Print("AutoBarButtonTrinket2.prototype:SetupAttributes " .. tostring(bag) .. "|" .. tostring(slot) .. "|" .. tostring(itemId))

	local _, equippedItemId = AutoBar.ItemLinkDecode(GetInventoryItemLink("player", TRINKET2_SLOT))

	if ((equippedItemId == itemId) or (not bag)) then
		AutoBarButtonTrinket2.super.prototype.SetupAttributes(self, button, bag, slot, spell, macroId, p_type_id, p_info_data, itemId, itemData)
	else
		local macroTexture = ABGCode.GetIconForItemID((tonumber(itemId)))
		local macroText = equipTrinket2String .. bag .." " .. slot -- "/equipslot [button:2] Z X Y" to do right click filtering

		button.macroText = macroText
		button.macroTexture = macroTexture
		local macroId = macroText
		AutoBarSearch:RegisterMacro(macroId, nil, L["AutoBarButtonTrinket2"], macroText)
--AutoBar:Print("AutoBarButtonTrinket2.prototype:SetupAttributes macroId " .. tostring(macroId))
		AutoBarButtonTrinket2.super.prototype.SetupAttributes(self, button, nil, nil, nil, macroId)
	end
end


local AutoBarButtonWater = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonWater"] = AutoBarButtonWater

function AutoBarButtonWater.prototype:init(parentBar, buttonDB)
	AutoBarButtonWater.super.prototype.init(self, parentBar, buttonDB)

	if (AutoBar.CLASS == "MAGE" and not buttonDB.disableConjure) then
		self:AddCategory("Spell.Mage.Conjure Water")
	end

	if (ABGCode.ClassUsesMana(AutoBar.CLASS)) then
		self:AddCategory("Consumable.Water.Percentage")
		self:AddCategory("Consumable.Water.Basic")

		self:AddCategory("Muffin.Food.Mana.Basic")
	end
end

--function AutoBarButtonWater.prototype:Refresh(parentBar, buttonDB)
--	AutoBarButtonWater.super.prototype.Refresh(self, parentBar, buttonDB)
--	if (AutoBar.CLASS == "MAGE") then
--		if (buttonDB.disableConjure) then
--			self:DeleteCategory("Spell.Mage.Conjure Water")
--			buttonDB.castSpell = nil
--			AutoBarCategoryList["Consumable.Water.Basic"]:SetCastList(nil)
--		else
--			self:AddCategory("Spell.Mage.Conjure Water")
--		end
--	end
--end

function AutoBarButtonWater.prototype:AddOptions(optionList, passValue)
	if (AutoBar.CLASS == "MAGE") then
		self:SetOptionBoolean(optionList, passValue, "disableConjure", L["Disable Conjure Button"])
	end
end


local AutoBarButtonWaterBuff = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonWaterBuff"] = AutoBarButtonWaterBuff

function AutoBarButtonWaterBuff.prototype:init(parentBar, buttonDB)
	AutoBarButtonWaterBuff.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Muffin.Food.Mana.Buff")

end


if (LE_EXPANSION_WRATH_OF_THE_LICH_KING and LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_WRATH_OF_THE_LICH_KING) then

	local AutoBarButtonMillHerbs = AceOO.Class(AutoBarButton)
	AutoBar.Class["AutoBarButtonMillHerbs"] = AutoBarButtonMillHerbs

	function AutoBarButtonMillHerbs.prototype:init(parentBar, buttonDB)
		AutoBarButtonMillHerbs.super.prototype.init(self, parentBar, buttonDB)

		self:AddCategory("Muffin.Herbs.Millable")
	end
end
-------------------------------------------------------------------
--
-- WoW Classic
--
-------------------------------------------------------------------
if (ABGData.is_vanilla_wow or ABGData.is_bcc_wow) then

	local AutoBarButtonMount = AceOO.Class(AutoBarButton)
	AutoBar.Class["AutoBarButtonMount"] = AutoBarButtonMount

	function AutoBarButtonMount.prototype:init(parentBar, buttonDB)
		AutoBarButtonMount.super.prototype.init(self, parentBar, buttonDB)

		self:AddCategory("Muffin.Mounts.Item")
		self:AddCategory("Muffin.Mounts.Paladin")
		self:AddCategory("Muffin.Mounts.Warlock")
	end


	local AutoBarButtonAquatic = AceOO.Class(AutoBarButton)
	AutoBar.Class["AutoBarButtonAquatic"] = AutoBarButtonAquatic

	function AutoBarButtonAquatic.prototype:init(parentBar, buttonDB)
		AutoBarButtonAquatic.super.prototype.init(self, parentBar, buttonDB)

		self:AddCategory("Spell.AquaticForm")

	end

	local AutoBarButtonTrack = AceOO.Class(AutoBarButton)
	AutoBar.Class["AutoBarButtonTrack"] = AutoBarButtonTrack

	function AutoBarButtonTrack.prototype:init(parentBar, buttonDB)
		AutoBarButtonTrack.super.prototype.init(self, parentBar, buttonDB)

		self:AddCategory("Spell.Track")
	end

elseif (ABGData.is_mainline_wow) then

-------------------------------------------------------------------
--
-- WoW Retail
--
-------------------------------------------------------------------

	local AutoBarButtonArchaeology = AceOO.Class(AutoBarButton)
	AutoBar.Class["AutoBarButtonArchaeology"] = AutoBarButtonArchaeology

	function AutoBarButtonArchaeology.prototype:init(parentBar, buttonDB)
		AutoBarButtonArchaeology.super.prototype.init(self, parentBar, buttonDB)

		self:AddCategory("Muffin.Skill.Archaeology.Crate")
		self:AddCategory("Muffin.Skill.Archaeology.Lodestone")
		self:AddCategory("Muffin.Skill.Archaeology.Map")
		self:AddCategory("Muffin.Skill.Archaeology.Mission")

		if(buttonDB.archbtn_show_spells == nil) then
			buttonDB.archbtn_show_spells = false;
		elseif(buttonDB.archbtn_show_spells) then
			self:AddCategory("Spell.Archaeology")
		end

	end

	function AutoBarButtonArchaeology.prototype:AddOptions(optionList, passValue)
		self:SetOptionBoolean(optionList, passValue, "archbtn_show_spells", L["ArchBtnShowSpells"])
	end

	function AutoBarButtonArchaeology.prototype:Refresh(parentBar, buttonDB)
		AutoBarButtonArchaeology.super.prototype.Refresh(self, parentBar, buttonDB)

		if(buttonDB.archbtn_show_spells == false) then
			self:DeleteCategory("Spell.Archaeology")
		elseif(buttonDB.archbtn_show_spells) then
			self:AddCategory("Spell.Archaeology")
		end

	end


	local AutoBarButtonStagForm = AceOO.Class(AutoBarButton)
	AutoBar.Class["AutoBarButtonStagForm"] = AutoBarButtonStagForm

	function AutoBarButtonStagForm.prototype:init(parentBar, buttonDB)
		AutoBarButtonStagForm.super.prototype.init(self, parentBar, buttonDB)

		self:AddCategory("Spell.StagForm")

	end

	local AutoBarButtonGuildSpell = AceOO.Class(AutoBarButton)
	AutoBar.Class["AutoBarButtonGuildSpell"] = AutoBarButtonGuildSpell

	function AutoBarButtonGuildSpell.prototype:init(parentBar, buttonDB)
		AutoBarButtonGuildSpell.super.prototype.init(self, parentBar, buttonDB)

		self:AddCategory("Spell.Guild")
	end

	local AutoBarButtonSunsongRanch = AceOO.Class(AutoBarButton)
	AutoBar.Class["AutoBarButtonSunsongRanch"] = AutoBarButtonSunsongRanch

	function AutoBarButtonSunsongRanch.prototype:init(parentBar, buttonDB)
		AutoBarButtonSunsongRanch.super.prototype.init(self, parentBar, buttonDB)

		self:AddCategory("Muffin.SunSongRanch")
	end

	local AutoBarButtonGarrison = AceOO.Class(AutoBarButton)
	AutoBar.Class["AutoBarButtonGarrison"] = AutoBarButtonGarrison

	function AutoBarButtonGarrison.prototype:init(parentBar, buttonDB)
		AutoBarButtonGarrison.super.prototype.init(self, parentBar, buttonDB)

		self:AddCategory("Muffin.Garrison")
	end

	local AutoBarButtonOrderHallTroop = AceOO.Class(AutoBarButton)
	AutoBar.Class["AutoBarButtonOrderHallTroop"] = AutoBarButtonOrderHallTroop

	function AutoBarButtonOrderHallTroop.prototype:init(parentBar, buttonDB)
		AutoBarButtonOrderHallTroop.super.prototype.init(self, parentBar, buttonDB)

		self:AddCategory("Muffin.Order Hall.Troop Recruit")
		self:AddCategory("Muffin.Order Hall.Champion")

	end

	local AutoBarButtonOrderHallResource = AceOO.Class(AutoBarButton)
	AutoBar.Class["AutoBarButtonOrderHallResource"] = AutoBarButtonOrderHallResource

	function AutoBarButtonOrderHallResource.prototype:init(parentBar, buttonDB)
		AutoBarButtonOrderHallResource.super.prototype.init(self, parentBar, buttonDB)

		self:AddCategory("Muffin.Order Hall.Artifact Power")
		self:AddCategory("Muffin.Order Hall.Ancient Mana")
		self:AddCategory("Muffin.Order Hall.Order Resources")
		self:AddCategory("Muffin.Order Hall.Nethershard")

	end

	local AutoBarButtonBattlePetItems = AceOO.Class(AutoBarButton)
	AutoBar.Class["AutoBarButtonBattlePetItems"] = AutoBarButtonBattlePetItems

	function AutoBarButtonBattlePetItems.prototype:init(parentBar, buttonDB)
		AutoBarButtonBattlePetItems.super.prototype.init(self, parentBar, buttonDB)

		if(buttonDB.show_ornamental == nil) then buttonDB.show_ornamental = true end

		self:AddCategory("Muffin.Battle Pet Items.Level")
		self:AddCategory("Muffin.Battle Pet Items.Upgrade")
		self:AddCategory("Muffin.Battle Pet Items.Bandages")
		self:AddCategory("Muffin.Battle Pet Items.Pet Treat")

		self:AddCategory("Muffin.Toys.Pet Battle")
		self:AddCategory("Spell.Pet Battle")

		if(buttonDB.show_ornamental == true) then
			self:AddCategory("Muffin.Toys.Companion Pet.Ornamental")
		end

	end

	function AutoBarButtonBattlePetItems.prototype:AddOptions(optionList, passValue)
		self:SetOptionBoolean(optionList, passValue, "show_ornamental", L["Muffin.Toys.Pet Battle_ShowOrnamental"])
	end

	-------------------------- AutoBarButtonToyBox ---------------------
	local AutoBarButtonToyBox = AceOO.Class(AutoBarButton)
	AutoBar.Class["AutoBarButtonToyBox"] = AutoBarButtonToyBox

	function AutoBarButtonToyBox.prototype:init(parentBar, buttonDB)
		AutoBarButtonToyBox.super.prototype.init(self, parentBar, buttonDB)
	--print("AutoBarButtonToyBox.prototype:init", buttonDB.buttonKey);

		if (not AutoBarCategoryList["Toys.ToyBox"]) then
			AutoBarCategoryList["Toys.ToyBox"] = ABGCode.ToyCategory:new( "Toys.ToyBox", "inv_jewelcrafting_goldenhare")
			local category = AutoBarCategoryList["Toys.ToyBox"]
			category.initialized = false
		end
		self:AddCategory("Toys.ToyBox")

		if (not AutoBar.db.char.buttonDataList[buttonDB.buttonKey]) then
			AutoBar.db.char.buttonDataList[buttonDB.buttonKey] = {}
		end

		if(buttonDB.toybox_only_show_favourites == nil) then buttonDB.toybox_only_show_favourites = false end

		self:Refresh(parentBar, buttonDB)
		--print("After refresh ToyBox item list has " .. #AutoBarCategoryList["Toys.ToyBox"].items .. " entries");
	end

	local reverse_sort_func = function( a,b ) return a > b end
	local forward_sort_func = function( a,b ) return a < b end

	function AutoBarButtonToyBox.prototype:Refresh(parentBar, buttonDB, p_force_update)
		AutoBarButtonToyBox.super.prototype.Refresh(self, parentBar, buttonDB)

		if (not AutoBarCategoryList["Toys.ToyBox"]) then
			--print("Skipping AutoBarButtonToyBox.prototype:Refresh  UpdateToyBox:" .. tostring(p_force_update));
			return true;
		end

		local made_update = false

		local category = AutoBarCategoryList["Toys.ToyBox"]

		AutoBar.last_ToyBox_count = AutoBar.last_ToyBox_count or 0;

		C_ToyBox.SetCollectedShown(true)
		C_ToyBox.SetAllSourceTypeFilters(true)
		C_ToyBox.SetFilterString("")

		local toy_total = C_ToyBox.GetNumTotalDisplayedToys()
		local toy_total_learned = C_ToyBox.GetNumLearnedDisplayedToys()


	--print("toy_total:" .. toy_total .. " toy_total_learned:" .. toy_total_learned .. "  Last ToyBox Count:" .. AutoBar.last_ToyBox_count)

		--If the number of known Toys has changed, do stuff
		if ((toy_total_learned ~= AutoBar.last_ToyBox_count and not AutoBar.missing_items) or p_force_update) then
			--print("   Gonna do toybox stuff");
			made_update = true
			AutoBar.last_ToyBox_count = toy_total_learned;

			category.items = {}
			category.all_items = {}


			if(toy_total_learned <= 0) then
				return
			end

			for i = 1, toy_total do
				local item_id = C_ToyBox.GetToyFromIndex(i)
				local _, toy_name, toy_icon, toy_is_fave = C_ToyBox.GetToyInfo(item_id)
				local user_selected = (buttonDB.toybox_only_show_favourites and toy_is_fave) or not buttonDB.toybox_only_show_favourites
				if (ABGCode.PlayerHasToy(item_id) and user_selected) then
					--print("  Adding ", toy_name, item_id, toy_is_fave);
					local link = C_ToyBox.GetToyLink(item_id)
	--				AutoBarSearch:RegisterToy(item_id, link)
					if(not link) then
						ABGCode.SetMissingItemFlag(item_id)
					end
					category.all_items[#category.all_items + 1] = item_id
				end
			end

			category.initialized = true

			AutoBarCategoryList["Toys.ToyBox"]:Refresh()

		end

		return made_update
	end

	function AutoBarButtonToyBox.prototype:AddOptions(optionList, passValue)
		self:SetOptionBoolean(optionList, passValue, "toybox_only_show_favourites", L["ToyBoxOnlyFavourites"])
	end

	-------------------------- AutoBarButtonMount ---------------------

	local AutoBarButtonMount = AceOO.Class(AutoBarButton)
	AutoBar.Class["AutoBarButtonMount"] = AutoBarButtonMount

	function AutoBarButtonMount.prototype:init(parentBar, buttonDB)
		AutoBarButtonMount.super.prototype.init(self, parentBar, buttonDB)
	--print("AutoBarButtonMount.prototype:init");

		local buttonData = AutoBar.db.char.buttonDataList[buttonDB.buttonKey]
		if (not buttonData) then
			buttonData = {}
			AutoBar.db.char.buttonDataList[buttonDB.buttonKey] = buttonData
		end

		if(buttonDB.mount_show_qiraji == nil) then buttonDB.mount_show_qiraji = false end
		if(buttonDB.mount_show_favourites == nil) then buttonDB.mount_show_favourites = true end
		if(buttonDB.mount_show_nonfavourites == nil) then buttonDB.mount_show_nonfavourites = false end
		if(buttonDB.mount_show_class == nil) then buttonDB.mount_show_class = true end
		if(buttonDB.mount_reverse_sort == nil) then buttonDB.mount_reverse_sort = false end
		if(buttonDB.mount_show_rng_fave == nil) then buttonDB.mount_show_rng_fave = false end


		if(buttonDB.mount_show_class == true) then
			self:AddCategory("Misc.Mount.Summoned")
			local class = AutoBar.CLASS
			if(class == "PALADIN" or class == "DEATHKNIGHT" or class == "WARLOCK") then
				self:AddCategory("Muffin.Mounts")
			end
		end

		if(buttonDB.mount_show_rng_fave == true) then
			self:AddCategory("Macro.Mount.SummonRandomFave")
		end

		self:AddCategory("Spell.Mount")

	end

	function AutoBarButtonMount.prototype:Refresh(parentBar, buttonDB, updateMount)
		AutoBarButtonMount.super.prototype.Refresh(self, parentBar, buttonDB)

		if (not AutoBarCategoryList["Spell.Mount"]) then
			--AutoBarButtonMount.prototype:init hasn't run, so skip
			--print("Skipping AutoBarButtonMount.prototype:Refresh  UpdateMount:" .. tostring(updateMount));
			return true;
		end

		local thisIsSpam = true
		local category = AutoBarCategoryList["Spell.Mount"]

		AutoBar.last_mount_count = AutoBar.last_mount_count or 0;

		-- Get the player's current mount filter settings
		local setting_filter_collected = C_MountJournal.GetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_COLLECTED);
		local setting_filter_not_collected = C_MountJournal.GetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED);
		local setting_filter_unusable = C_MountJournal.GetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_UNUSABLE);

		--Set the mount filter settings the way we want
		C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_COLLECTED, true);
		C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED, false);
		C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_UNUSABLE, false);

		local num_mounts = C_MountJournal.GetNumDisplayedMounts();
		local needs_update = (num_mounts ~= AutoBar.last_mount_count) or buttonDB.is_dirty

	--print("NumMounts:" .. num_mounts .. " UpdateMount:" .. tostring(updateMount) .. "  Last Count:" .. AutoBar.last_mount_count, "Dirty:", buttonDB.is_dirty, "NeedsUpdate:", needs_update)
	--print(debugstack(1, 3, 3));

		--If the number of known mounts has changed, do stuff
		if (needs_update) then
	--print("   Gonna do stuff");
			AutoBar.last_mount_count = num_mounts;
			buttonDB.is_dirty = false

			category.castList = {}

			thisIsSpam = category.initialized --or (# category.castList ~= count)

			for idx = 0, num_mounts do
				local name, spell_id, icon, _active, _usable, _src, is_favourite, _faction_specific, _faction, _is_hidden, is_collected, _mount_id = C_MountJournal.GetDisplayedMountInfo(idx)
				local user_selected = (is_favourite and buttonDB.mount_show_favourites) or (not is_favourite and buttonDB.mount_show_nonfavourites)
				local qiraji_filtered = (not buttonDB.mount_show_qiraji and ABGData.QirajiMounts[spell_id]) or false;
	--if (name == "Emerald Raptor" or name=="Albino Drake" or name == "Creeping Carpet" or name == "Dreadsteed" ) then
	--if (is_collected and is_hidden ) then
	--	print(string.format("%5s  %5s  Usable:%5s", mount_id, spell_id, tostring(usable)), name)
	--	print("   FacSpecific:",faction_specific, "Faction:", faction, "Hidden:", is_hidden, "Collected:", is_collected)
	--	print("   ", AutoBar.player_faction_name, faction_id, "==", faction, "=>", faction_ok)
	--end;
				if (is_collected and user_selected and not qiraji_filtered) then
					local spell_name = GetSpellInfo(spell_id)
					--print("Name:", name, "SpellName:", spell_name, "SpellID:", spell_id, "Usable:", usable);
					if not spell_name then print("AutoBar Error: Missing spell name for", spell_id, name); end
					spellIconList[spell_name] = icon
					AutoBarSearch:RegisterSpell(spell_name, spell_id, true)
					local spellInfo = AutoBarSearch.spells[spell_name]
					spellInfo.spellLink = "spell:" .. spell_id
					category.castList[# category.castList + 1] = spell_name
				end

			end

			--This is backwards because the  original sort *is* a reverse sort, so this is a reverse-reverse sort.
			if(buttonDB.mount_reverse_sort) then
				table.sort(category.castList, forward_sort_func)
			else
				table.sort(category.castList, reverse_sort_func)
			end

			category.initialized = true

			AutoBarCategoryList["Spell.Mount"]:Refresh()
		end

		-- Reset the player's current mount filter settings to their original settings
		C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_COLLECTED, setting_filter_collected);
		C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED, setting_filter_not_collected);
		C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_UNUSABLE, setting_filter_unusable);

		return thisIsSpam
	end



	function AutoBarButtonMount.prototype:AddOptions(optionList, passValue)
		self:SetOptionBoolean(optionList, passValue, "mount_show_qiraji", L["MountShowQiraji"])
		self:SetOptionBoolean(optionList, passValue, "mount_show_favourites", L["MountShowFavourites"])
		self:SetOptionBoolean(optionList, passValue, "mount_show_nonfavourites", L["MountShowNonFavourites"])
		self:SetOptionBoolean(optionList, passValue, "mount_show_class", L["MountShowClass"])
		self:SetOptionBoolean(optionList, passValue, "mount_reverse_sort", L["MountReverseSort"])
		self:SetOptionBoolean(optionList, passValue, "mount_show_rng_fave", L["MountShowSummonRandom"])
	end


	--[[
	/dump GetSpellInfo(43688)
	/dump GetSpellInfo("Amani War Bear")
	/dump AutoBarCategoryList["Spell.Mount"]
	/script AutoBarSearch.sorted:Update("AutoBarButtonMount")
	/dump AutoBarSearch.sorted:GetList("AutoBarButtonMount")
	--]]

	--- Temporary until Blizzard makes their code work for mounts & critters
	function AutoBarButtonMount.prototype:UpdateUsable()
		local frame = self.frame
		local itemType = frame:GetAttribute("type")
		if (itemType) then
			if (AutoBar.inCombat) then
				frame.icon:SetVertexColor(0.4, 0.4, 0.4)
			else
				frame.icon:SetVertexColor(1.0, 1.0, 1.0)
				frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)
			end

			local popupHeader = self.frame.popupHeader
			if (popupHeader) then
				for _, popupButton in pairs(popupHeader.popupButtonList) do
					frame = popupButton.frame
					if (AutoBar.inCombat) then
						frame.icon:SetVertexColor(0.4, 0.4, 0.4)
					else
						frame.icon:SetVertexColor(1.0, 1.0, 1.0)
						frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)
					end
				end
			end
		end
	end

	local AutoBarButtonPets = AceOO.Class(AutoBarButton)
	AutoBar.Class["AutoBarButtonPets"] = AutoBarButtonPets

	function AutoBarButtonPets.prototype:init(parentBar, buttonDB)
		AutoBarButtonPets.super.prototype.init(self, parentBar, buttonDB)

		self:AddCategory("Battle Pet.Favourites")

		self:AddCategory("Macro.BattlePet.SummonRandom")
		self:AddCategory("Macro.BattlePet.DismissPet")
		self:AddCategory("Macro.BattlePet.SummonRandomFave")

		self:Refresh(parentBar, buttonDB)
	end

	function AutoBarButtonPets.prototype:Refresh(parentBar, buttonDB)
		AutoBarButtonPets.super.prototype.Refresh(self, parentBar, buttonDB)

		local category = AutoBarCategoryList["Battle Pet.Favourites"]

		AutoBar.last_critter_count = AutoBar.last_critter_count or 0;

		local _, total_pet_count = C_PetJournal.GetNumPets()

		--print("NumCritters:" .. total_pet_count .. "  Last Critter Count:" .. AutoBar.last_critter_count)

		if (total_pet_count ~= AutoBar.last_critter_count) then
			--print("   Gonna do critter stuff");
			AutoBar.last_critter_count = total_pet_count;
			wipe(category.items)
			for index = 1, total_pet_count, 1 do
				local pet_data = {C_PetJournal.GetPetInfoByIndex(index)}
				local pet_id = pet_data[1]
				local owned = pet_data[3]
				local favourite = pet_data[6]
				local icon = pet_data[9]
				--local link = C_PetJournal.GetBattlePetLink(pet_id)
				--local description = pet_data[13]
				local name = pet_data[4] or pet_data[8]
				local user_selected = owned and favourite

				if(user_selected) then
					local summon_macro = "/summonpet " .. pet_id
					category:AddMacroText(summon_macro, icon, "Summon " .. name, nil)
				end
	--			creatureID, creatureName, spellID, icon, active = GetCompanionInfo(companionType, index)
	--			spellName = GetSpellInfo(spellID)
	--			spellIconList[spellName] = icon
	--			AutoBarSearch:RegisterSpell(spellName, spellID, true)
	--			local spellInfo = AutoBarSearch.spells[spellName]
	--			spellInfo.spellLink = "spell:" .. spellID
	--			category.castList[index] = spellName
			end
		end


	end


	--- Temporary until Blizzard makes their code work for mounts & critters
	function AutoBarButtonPets.prototype:UpdateUsable()
		local frame = self.frame
		local itemType = frame:GetAttribute("type")
		if (itemType) then
			frame.icon:SetVertexColor(1.0, 1.0, 1.0)
			frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)

			local popupHeader = self.frame.popupHeader
			if (popupHeader) then
				for _, popupButton in pairs(popupHeader.popupButtonList) do
					frame = popupButton.frame
					frame.icon:SetVertexColor(1.0, 1.0, 1.0)
					frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)
				end
			end
		end
	end

end
