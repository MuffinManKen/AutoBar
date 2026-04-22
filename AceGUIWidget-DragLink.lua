---@diagnostic disable
local AceGUI = LibStub("AceGUI-3.0")
local L = AutoBarGlobalDataObject.locale

--------------
-- DragLink --
--------------

-- Global to track source frame when dragging between DragLink widgets
DragLinkFrame = nil

do
	local Type = "DragLink"
	local Version = 2

	local function Acquire(self)
		self.frame:EnableMouse(true)
		self.frame:Raise()
		self.frame:Show()
	end

	local function Release(self)
		self.frame:ClearAllPoints()
		self.frame:Hide()
	end

	local function SetLabel(self, text)
	end

	local function SetDisabled(self, disabled)
	end

	-- Scan bags for an item with the given item ID and place it on the cursor
	local function PickupItemByID(itemId)
		for bag = 0, NUM_BAG_SLOTS do
			for slot = 1, C_Container.GetContainerNumSlots(bag) do
				local info = C_Container.GetContainerItemInfo(bag, slot)
				if info and info.itemID == itemId then
					C_Container.PickupContainerItem(bag, slot)
					return
				end
			end
		end
	end

	local function DragLinkGetTexture(self)
		if (self.dragLinkType == "item") then
			local texture = select(10, GetItemInfo(self.itemId or self.value))
			return texture or "Interface\\Icons\\INV_Misc_QuestionMark"
		elseif (self.dragLinkType == "spell") then
			local texture = C_Spell.GetSpellTexture(self.value)
			return texture or "Interface\\Icons\\INV_Misc_QuestionMark"
		elseif (self.dragLinkType == "macro") then
			local _name, texture = GetMacroInfo(strsub(self.value, 7))
			return texture or "Interface\\Icons\\INV_Misc_QuestionMark"
		elseif (self.dragLinkType == "macroCustom") then
			local texture = strsub(self.value, 13)
			if (not texture or texture == "") then
				texture = "Interface\\Icons\\INV_Misc_Gift_05"
			end
			return texture
		end
		return "Interface\\Icons\\INV_Misc_QuestionMark"
	end

	-- retail GetCursorInfo returns:
	--   "item"  → info1: itemId (integer),   info2: itemLink (string)
	--   "spell" → info1: spellIndex, info2: bookType, info3: spellID, info4: baseSpellID
	--   "macro" → info1: macroIndex (integer)
	-- Returns value (string for storage), itemId (integer, items only), spellId (integer, spells only)
	local function GetValueFromCursor(dragLinkType, info1, info2, info3, info4)
		if (dragLinkType == "item") then
			local itemId = info1 -- integer
			return "item:" .. itemId, itemId, nil
		elseif (dragLinkType == "spell") then
			-- GetCursorInfo returns: "spell", spellIndex, bookType, spellID, baseSpellID
			local spellId = info3
			if (spellId and spellId ~= 0) then
				local name = C_Spell.GetSpellName(spellId)
				if (name) then
					return name, nil, spellId
				end
			end
		elseif (dragLinkType == "macro") then
			local name = GetMacroInfo(info1)
			if (name) then
				return "macro:" .. name, nil, nil
			end
		end
		return nil
	end

	local function DragLinkOnDragStart(frame)
		local self = frame.obj
		DragLinkFrame = frame
		if (self.dragLinkType == "item") then
			PickupItemByID(self.itemId)
		elseif (self.dragLinkType == "spell") then
			-- No reliable API to pick up a spell by ID without a spellbook slot scan;
			-- DragLinkFrame is still set so swapping between slots will work if the
			-- target calls OnClick rather than relying on OnReceiveDrag.
		elseif (self.dragLinkType == "macro") then
			PickupMacro(strsub(self.value, 7))
		end
	end

	local function DragLinkOnReceiveDrag(frame)
		local self = frame.obj
		if (DragLinkFrame) then
			-- Swap content between two DragLink widgets
			local sourceIndex = DragLinkFrame.obj.userdata.option.arg.itemIndex
			self:Fire("OnEnterPressed", "SWAP", sourceIndex)
			ClearCursor()
			DragLinkFrame = nil
			return
		end

		local dragLinkType, info1, info2, info3, info4 = GetCursorInfo()
		if (dragLinkType == "item" or dragLinkType == "spell" or dragLinkType == "macro") then
			local value, itemId, spellId = GetValueFromCursor(dragLinkType, info1, info2, info3, info4)
			if (value) then
				self.value = value
				self.itemId = itemId
				self.spellId = spellId
				self.dragLinkType = dragLinkType
				local texture = DragLinkGetTexture(self)
				self:Fire("OnEnterPressed", self.value, dragLinkType, info1, info2, texture)
				self.dragLinkIcon:SetTexture(texture)
				ClearCursor()
			end
		elseif (dragLinkType) then
			print(L["AutoBar: '%s' is not supported here."]:format(dragLinkType))
		end
		DragLinkFrame = nil
	end

	local function DragLinkOnClick(frame, ...)
		local self = frame.obj
		if (IsControlKeyDown()) then
			self:Fire("OnEnterPressed", "DELETE")
			ClearCursor()
			DragLinkFrame = nil
		else
			DragLinkOnReceiveDrag(frame, ...)
		end
	end

	local function DragLinkOnEnter(frame)
		local self = frame.obj
		if (not self.dragLinkType or not self.value) then
			GameTooltip:SetOwner(self.frame, "ANCHOR_RIGHT")
			GameTooltip:AddLine(L["Empty Slot"], 1, 1, 1)
			GameTooltip:AddLine(L["Click with an item or spell on your cursor to add it."], 0.8, 0.8, 0.8, true)
			GameTooltip:AddLine(L["Ctrl-click to delete this slot."], 0.8, 0.8, 0.8, true)
			GameTooltip:Show()
		elseif (self.dragLinkType == "item") then
			GameTooltip:SetOwner(self.frame, "ANCHOR_RIGHT")
			GameTooltip:SetHyperlink(self.value)
			GameTooltip:AddLine(L["Ctrl-click to remove."], 0.8, 0.8, 0.8, true)
			GameTooltip:Show()
		elseif (self.dragLinkType == "spell") then
			if (self.spellId) then
				GameTooltip:SetOwner(self.frame, "ANCHOR_RIGHT")
				GameTooltip:SetSpellByID(self.spellId)
				GameTooltip:AddLine(L["Ctrl-click to remove."], 0.8, 0.8, 0.8, true)
				GameTooltip:Show()
			end
		elseif (self.dragLinkType == "macro") then
			local name, icon, body = GetMacroInfo(strsub(self.value, 7))
			if (name) then
				GameTooltip:SetOwner(self.frame, "ANCHOR_RIGHT")
				GameTooltip:AddLine(tostring(name), 0.2, 0.8, 0.8, 1)
				GameTooltip:AddTexture(icon)
				GameTooltip:AddLine(tostring(body), 1, 1, 1, 1)
				GameTooltip:AddLine(L["Ctrl-click to remove."], 0.8, 0.8, 0.8, true)
				GameTooltip:Show()
			end
		end
	end

	local function DragLinkOnLeave()
		GameTooltip:Hide()
	end

	local function SetText(self, text)
		if (not text or text == "") then return end
		if (text:find("^item:%d+")) then
			self.dragLinkType = "item"
			self.value = text
			self.itemId = tonumber(text:match("^item:(%d+)"))
		elseif (strsub(text, 1, 6) == "macro:") then
			self.dragLinkType = "macro"
			self.value = text
		elseif (strsub(text, 1, 12) == "macroCustom:") then
			self.dragLinkType = "macroCustom"
			self.value = text
		else
			-- Spell stored by name; spellId not available from name alone here
			self.dragLinkType = "spell"
			self.value = text
		end
		self.dragLinkIcon:SetTexture(DragLinkGetTexture(self))
	end

	local spacerWidth = 5
	local function OnWidthSet(self, width)
		if (width > self.iconWidth + spacerWidth + 0.1) then
			self:SetWidth(self.iconWidth + spacerWidth)
		end
	end

	local function Constructor()
		local frame = CreateFrame("Button", nil, UIParent)
		local self = {}
		self.type = Type

		self.Release = Release
		self.Acquire = Acquire
		self.SetLabel = SetLabel
		self.SetText = SetText
		self.SetDisabled = SetDisabled
		self.OnWidthSet = OnWidthSet

		self.iconWidth = 32
		self.iconHeight = 32

		self.frame = frame
		frame.obj = self

		frame:SetScript("OnDragStart", DragLinkOnDragStart)
		frame:SetScript("OnReceiveDrag", DragLinkOnReceiveDrag)
		frame:SetScript("OnClick", DragLinkOnClick)
		frame:SetScript("OnEnter", DragLinkOnEnter)
		frame:SetScript("OnLeave", DragLinkOnLeave)

		frame:EnableMouse()
		frame:RegisterForDrag("LeftButton")
		frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")

		local dragLinkIcon = frame:CreateTexture(nil, "OVERLAY")
		dragLinkIcon:SetWidth(self.iconWidth)
		dragLinkIcon:SetHeight(self.iconHeight)
		dragLinkIcon:SetPoint("LEFT", frame, "LEFT", 0, 0)
		dragLinkIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
		dragLinkIcon:SetTexCoord(0, 1, 0, 1)
		dragLinkIcon:Show()
		self.dragLinkIcon = dragLinkIcon

		frame:SetHeight(self.iconHeight)
		frame:SetWidth(self.iconWidth)

		local text = frame:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
		text:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 10)
		text:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 10)
		text:SetJustifyH("CENTER")
		text:SetJustifyV("TOP")
		text:SetHeight(18)
		self.text = text

		AceGUI:RegisterAsWidget(self)
		return self
	end

	AceGUI:RegisterWidgetType(Type, Constructor, Version)
end
