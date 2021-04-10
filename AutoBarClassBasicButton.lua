--
-- AutoBarClassBasicButton
-- Copyright 2008+ Toadkiller of Proudmoore.
-- Implements SecureHandler and other code common to both anchor and popup buttons
--
-- Buttons are contained by AutoBar.Class.Bar
-- http://muffinmangames.com
--

-- GLOBALS: GameTooltip, GetCVar, GameTooltip_SetDefaultAnchor, GetScreenWidth, SecureHandlerWrapScript, GetSpellInfo, GetMacroInfo, GetItemCooldown
-- GLOBALS: GetSpellCooldown, CooldownFrame_Set, GetItemCount, GetSpellCount, IsUsableSpell

local AutoBar = AutoBar
local ABGCode = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject


local AceOO = MMGHACKAceLibrary("AceOO-2.0")
local L = AutoBarGlobalDataObject.locale
local _G = _G
local _

if (not AutoBar.Class) then
	AutoBar.Class = {}
end

-- Basic Button with textures, highlighting, keybindText, tooltips etc.
AutoBar.Class.BasicButton = AceOO.Class()

function AutoBar.Class.BasicButton.prototype:init(parentBar, buttonDB)
	AutoBar.Class.BasicButton.super.prototype.init(self)
end


-- OnLeave function.  Added to a button to allow calling it via control:CallMethod("TooltipHide")
function AutoBar.Class.BasicButton.TooltipHide()
	GameTooltip:Hide()
end


-- OnEnter function.  Added to a button to allow calling it via control:CallMethod("TooltipSet")
function AutoBar.Class.BasicButton.TooltipShow(button)
	local x = button:GetRight()
	if (x >= (GetScreenWidth() / 2)) then
		GameTooltip:SetOwner(button, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
	end

	local itemLink = button:GetAttribute("itemLink")
	local buttonType = button:GetAttribute("type")
	local item_guid = button:GetAttribute("AutoBarGUID")
	local item_data = ABGCode.InfoFromGUID(item_guid)


	if (AutoBar.moveButtonsMode) then
		local name = ABGCode.GetButtonDisplayName(button.class.buttonDB)
		GameTooltip:AddLine(name, 0.8, 0, 1, -1)
		GameTooltip:Show()
	elseif(item_data) then
		if(item_data.link) then
			GameTooltip:SetHyperlink(item_data.link)
		elseif(item_data.tooltip) then
			GameTooltip:AddLine(item_data.tooltip, 1, 1, 1)
		elseif(item_data.ab_type == ABGData.TYPE_TOY) then
			GameTooltip:SetToyByItemID(item_data.item_id)
		end
		button.UpdateTooltip = AutoBar.Class.BasicButton.TooltipShow
		GameTooltip:Show()
	elseif (buttonType == "spell") then
		local spell_name = button:GetAttribute("spell")
		if (tonumber(spell_name)) then
			GameTooltip:SetSpellByID(spell_name);
		else
			local spell_info = AutoBarSearch.spells[spell_name]
			GameTooltip:SetSpellByID(spell_info.spell_id);
		end
		button.UpdateTooltip = AutoBar.Class.BasicButton.TooltipShow
	elseif (itemLink) then
		GameTooltip:SetHyperlink(itemLink)
--		if (GameTooltip:SetHyperlink(itemLink)) then
			button.UpdateTooltip = AutoBar.Class.BasicButton.TooltipShow
--		end
	elseif (buttonType == "macro") then
		-- There is no accesible GameTooltip function for macros so make one with its name and the macro text
		local macroName = button:GetAttribute("macroName")
		local macroBody = button:GetAttribute("macroBody")

		if (macroName and macroBody) then
			GameTooltip:AddLine(macroName, 0.2, 0.8, 0.8)
			GameTooltip:AddLine(macroBody, 1, 1, 1, 1)
			button.UpdateTooltip = AutoBar.Class.BasicButton.TooltipShow
			GameTooltip:Show()
		end
	elseif (buttonType == "item") then
		-- There is no way to get charge information outside built in Blizzard functions for buttonType == "action"
		-- The best we can do is link to a specific bag/slot so at least the tooltip can show this info
		-- Sadly, the itemString for this is "[bag] [slot]" which is not a valid paramater for SetHyperlink
		-- It is thus special cased here
		local bagslot = button:GetAttribute("item")
		if (bagslot) then
			local bag, slot = strmatch(bagslot, "^(%d+)%s+(%d+)$")
			if (bag and slot and GameTooltip:SetBagItem(bag, slot)) then
				button.UpdateTooltip = AutoBar.Class.BasicButton.TooltipShow
			end
		end
	end

	local rightClickType = button:GetAttribute("type2")
	if (rightClickType == "spell") then
		local spellName = button:GetAttribute("spell")
		local spellName2 = button:GetAttribute("spell2")
		if (not spellName or (spellName2 ~= spellName)) then
			GameTooltip:AddLine(L["Right Click casts "] .. spellName2, 1, 0.2, 1, 1)
			GameTooltip:Show()
		end
	end
end
--[[
/dump GameTooltip:SetHyperlink("spell:32246")
--]]

-- Apply tooltipType to the Button
function AutoBar.Class.BasicButton:TooltipApply(button)
	if (AutoBar.db.account.showTooltip) then
		if (not button.TooltipShow) then
			button.TooltipShow = AutoBar.Class.BasicButton.TooltipShow
--			SecureHandlerWrapScript(button, "OnEnter", button, [[ control:CallMethod("TooltipShow", self) ]])
		end
		if (not button.TooltipHide) then
			button.TooltipHide = AutoBar.Class.BasicButton.TooltipHide
			SecureHandlerWrapScript(button, "OnLeave", button, [[ control:CallMethod("TooltipHide") ]])
		end
		button:SetAttribute("showTooltip", true)
	else
		button:SetAttribute("showTooltip", nil)
	end
end

local function get_texture_for_action(p_action)

	local texture
	if (p_action) then
		texture = select(3, GetSpellInfo(p_action)) or ABGCode.GetIconForItemID(p_action)
	end

	--We haven't found a texture. This might be because it's just not cached yet.
	--So we set this flag which will update the buttons when a GET_ITEM_INFO_RECEIVED event fires
	if(texture == nil) then
		ABGCode.SetMissingItemFlag(p_action);
	end

	return texture;

end

--local function get_texture_for_macro_body(p_macro_body)
--	local debug = false
--
--	local action = ABGCode.GetActionForMacroBody(p_macro_body);
--	local texture = get_texture_for_action(action)
--
--	if (debug) then
--		print("   texture:", texture);
--		print("   action:" .. action)
--	end
--
--	--We haven't found a texture. This might be because it's just not cached yet.
--	--So we set this flag which will update the buttons when a GET_ITEM_INFO_RECEIVED event fires
--	if(texture == nil) then
--		AutoBar.missing_items = true
--		--print("AutoBar.missing_items = true")
--	end
--
--	return texture
--end

local borderBlue = {r = 0, g = 0, b = 1.0, a = 0.35}
local borderGreen = {r = 0, g = 1.0, b = 0, a = 0.35}

function AutoBar.Class.BasicButton.prototype:GetIconTexture(frame)
	local texture, borderColor
	local itemType = frame:GetAttribute("type")
	local item_guid = frame:GetAttribute("AutoBarGUID")
	local item_data =  ABGCode.InfoFromGUID(item_guid)

	if(item_data) then
		if(item_data.icon) then
			texture = item_data.icon -- Use cached icon if we have one
		elseif(item_data.ab_type == ABGData.TYPE_TOY) then
			texture = ABGCode.GetIconForToyID(item_data.item_id)
			if(texture == nil) then
				ABGCode.SetMissingItemFlag(item_data.item_id);
			end
		end
	elseif (itemType == "item") then
		local itemId = frame:GetAttribute("itemId")
		if (itemId) then
			texture = ABGCode.GetIconForItemID(tonumber(itemId))
			if(texture == nil) then
				ABGCode.SetMissingItemFlag(itemId);
			end

			local bag, slot = AutoBarSearch.found:GetItemData(itemId)
			if ((not bag) and slot) then
				-- Add a green border if button is an equipped item
				borderColor = borderGreen
			end
		end
	elseif (itemType == "macro") then
		local macroIndex = frame:GetAttribute("macro")
		if (macroIndex) then
			_, texture = GetMacroInfo(macroIndex)
		else
			texture = frame.class.macroTexture or self.frame:GetAttribute("macro_icon")
			if (not texture) then
				local macro_action = self.frame:GetAttribute("macro_action")
				texture = get_texture_for_action(macro_action) or "Interface\\Icons\\INV_Misc_Gift_05"
			end
		end
	elseif (itemType == "spell") then
		local spellName = frame:GetAttribute("spell")
		if (spellName) then
			texture = ABGCode.GetSpellIconByNameFast(spellName) or select(3, GetSpellInfo(spellName))

			-- Add a blue border if button is a spell
			borderColor = borderBlue
		end
	end

	-- Fall through to right click spell
	if (not texture) then
		local spellName = frame:GetAttribute("spell2")
		if (spellName) then
			_, _, texture = GetSpellInfo(spellName)

			-- Add a blue border if button is a spell
			borderColor = borderBlue
		end
	end
	return texture, borderColor
end


-- Set cooldown based on the type settings
function AutoBar.Class.BasicButton.prototype:UpdateCooldown()
	local itemType = self.frame:GetAttribute("type")
	if (not itemType) then-- and not self.parentBar.faded
		return;
	end

	local item_guid = self.frame:GetAttribute("AutoBarGUID")
	local item_data = ABGCode.InfoFromGUID(item_guid)

	local start, duration, enabled = 0, 0, 0

	if (itemType == "item") then
		local itemId = self.frame:GetAttribute("itemId")
		if (itemId) then
			start, duration, enabled = GetItemCooldown(itemId)
		end
	elseif (itemType == "toy" and item_data) then
		start, duration, enabled = GetItemCooldown(item_data.item_id)
--	elseif (itemType == "macro") then --ToDo some day
--			local macroText = self.frame:GetAttribute("macrotext")
--			SecureCmdOptionParse()?
	elseif (itemType == "spell") then
		local spellName = self.frame:GetAttribute("spell")
		start, duration, enabled = GetSpellCooldown(spellName)
	end

	if (start and duration and enabled and start > 0 and duration > 0) then
		CooldownFrame_Set(self.frame.cooldown, start, duration, enabled)
		self.frame.cooldown:SetSwipeColor(0, 0, 0);
	else
		CooldownFrame_Set(self.frame.cooldown, 0, 0, 0)
	end
end

-- Set count based on the type and type2 settings
function AutoBar.Class.BasicButton.prototype:UpdateCount()
	local frame = self.frame
	if (AutoBar.db.account.showCount) then
		frame.count:Show()
		local count1 = 0
		local count2 = 0
		local itemType = frame:GetAttribute("type")

		if (itemType) then
			if (itemType == "item") then
				local itemId = frame:GetAttribute("itemId")
				count1 = GetItemCount(tonumber(itemId), nil, true) or 0
-- 		Toys and Macros don't have counts, though a macro of an item could.
--			elseif (itemType == "macro") then
--			elseif (itemType == "toy") then
			elseif (itemType == "spell") then
				local spellName = frame:GetAttribute("spell")
				count1 = GetSpellCount(spellName) or 0
				local spellName2 = frame:GetAttribute("spell2")
				if (spellName2) then
					count2 = GetSpellCount(spellName2) or 0
				end
			end
		end

		local displayCount1 = count1
		local displayCount2 = count2
		if (count1 > 999) then
			displayCount1 = "*"
		end
		if (count2 > 999) then
			displayCount2 = "*"
		end

		if (itemType == "spell") then
			if (count1 > 1 and count2 > 0) then
				frame.count:SetText(displayCount1 .. "/" .. displayCount2)
			elseif (count2 > 0) then
				frame.count:SetText("/" .. displayCount2)
			elseif (count1 > 0) then
				frame.count:SetText(displayCount1)
			else
				frame.count:SetText("")
			end
		elseif (count1 > 1) then
			frame.count:SetText(displayCount1)
		else
			frame.count:SetText("")
		end
	else
		frame.count:Hide()
	end
end


function AutoBar.Class.BasicButton.prototype:UpdateUsable()
	local frame = self.frame
	local itemType = frame:GetAttribute("type")
	local category = frame:GetAttribute("category")
	if (itemType) then
		local isUsable, notEnoughMana

		if (itemType == "item") then
			local itemId = frame:GetAttribute("itemId")
			isUsable, notEnoughMana = ABGCode.IsUsableItem(itemId)
			if (isUsable) then
				-- Single use in combat potion hack
				local _, _, enabled = GetItemCooldown(itemId)
				if (not enabled) then
					isUsable = false
				end
			end
		elseif (itemType == "spell") then
			local spellName = frame:GetAttribute("spell")
			isUsable, notEnoughMana = IsUsableSpell(spellName)
		elseif (itemType == "macro") then
			isUsable = true
		else
			frame.icon:SetVertexColor(1.0, 1.0, 1.0)
			frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)
			return
		end

		local oor = AutoBar.db.account.outOfRange or "none"
		if (isUsable and (not frame.outOfRange or not (oor ~= "none"))) then
			frame.icon:SetVertexColor(1.0, 1.0, 1.0)
			frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)
		elseif ((oor ~= "none") and frame.outOfRange) then
print("AutoBar.Class.BasicButton.prototype:UpdateUsable", oor)
			if (oor == "button") then
				frame.icon:SetVertexColor(0.8, 0.1, 0.1)
				frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)
			else
				frame.hotKey:SetVertexColor(0.8, 0.1, 0.1)
				frame.icon:SetVertexColor(1.0, 1.0, 1.0)
			end
		elseif ((oor ~= "none") and notEnoughMana) then
			frame.icon:SetVertexColor(0.1, 0.3, 1.0)
		else
			frame.icon:SetVertexColor(0.4, 0.4, 0.4)
		end
	end
end


local function scriptOnEvent(self, event, ...)
	self.class[event](self.class, ...)
end

function AutoBar.Class.BasicButton.prototype:EventsEnable()
	self.frame:SetScript("OnEvent", scriptOnEvent)
end

