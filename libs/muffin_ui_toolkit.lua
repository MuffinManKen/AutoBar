local _ADDON_NAME, ADDON = ... -- Pulls back the Addon-Local Variables and store them locally.

ADDON.UITK = {}

local UITK = ADDON.UITK

UITK.default_font_name, UITK.default_font_height = GameFontNormal:GetFont()
local default_font_name = UITK.default_font_name

--TODO: This is MFAC-specific code and needs to be fixed to be general!!!
function UITK.resizing_set_text(p_self, p_text)
	p_self:oSetText(p_text)
	for i = p_self.MFAC_font_max, p_self.MFAC_font_min, -1 do
		local font_name, _, flags = p_self:GetFont()
		p_self:SetFont(font_name, i, flags)
		if not p_self:IsTruncated() then
			break;
		end
	end
end

--TODO: This is MFAC-specific code and needs to be fixed to be general!!!
function	UITK.make_fontstring_resizable(p_string, p_min, p_max)
	assert(p_string.oSetText == nil) --Calling this multiple times will cause bad behaviour
	p_string.oSetText = p_string.SetText
	p_string.SetText = UITK.resizing_set_text
	p_string.MFAC_font_min = p_min
	p_string.MFAC_font_max = p_max
end

function UITK.create_fontstring(p_frame, p_name, p_options)
	local opts = p_options or {}
	local fstring = p_frame:CreateFontString(p_name, "ARTWORK", opts.inherit)
	fstring:SetJustifyH(opts.JustifyH or "LEFT")
	fstring:SetJustifyV("TOP")
	fstring:SetFont(default_font_name, UITK.default_font_height)
	fstring:SetShadowColor(0,0,0,.9)
	fstring:SetShadowOffset(1,-1)

	return fstring;
end

function UITK.show_tooltip(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	local tt_backdrop = GameTooltip:GetBackdrop()
	tt_backdrop.bgFile = "Interface/ChatFrame/ChatFrameBackground"
	GameTooltip:SetBackdrop(tt_backdrop)
	GameTooltip:SetBackdropColor(0, 0, 0, 0.95);

	if(self.tooltip_title) then
		GameTooltip:SetText(self.tooltip_title, 1, 1, 0.5, 1.0, 1)
		GameTooltip:AddLine(self.tooltip_text, 1, 1, 1, 1.0, 1)
	elseif(self.tooltip_text) then
		GameTooltip:SetText(self.tooltip_text, nil, nil, nil, nil, 1);
	end

	GameTooltip:Show()
end

function UITK.create_checkbox(p_frame, p_name, p_text, p_options)
	local opts = p_options or {}
	local cb = CreateFrame("CheckButton", p_name, p_frame);
	cb:SetSize(26,26)
	cb:SetCheckedTexture("Interface/Buttons/UI-CheckBox-Check")
	cb:SetDisabledCheckedTexture("Interface/Buttons/UI-CheckBox-Check-Disabled")
	cb:SetHighlightTexture("Interface/Buttons/UI-CheckBox-Highlight", "ADD")
	cb:SetNormalTexture("Interface/Buttons/UI-CheckBox-Up")
	cb:SetPushedTexture("Interface/Buttons/UI-CheckBox-Down")

	cb.fnt_string = UITK.create_fontstring(cb, nil)
	cb.fnt_string:SetSize(0, 10)
	cb.fnt_string:SetPoint("LEFT", cb, "RIGHT", 0, 2)
	cb.fnt_string:SetText(p_text)

	cb.tooltip_title = opts.tip_title
	cb.tooltip_text = opts.tip

	cb:SetScript("OnEnter", function(self) UITK.show_tooltip(self); end)
	cb:SetScript("OnLeave", function(self) GameTooltip_Hide(); end)

	return cb;
end

function UITK.create_slider(p_parent_frame, p_range)

	local slider = CreateFrame("Slider", nil, p_parent_frame, BackdropTemplateMixin and "BackdropTemplate");
	slider:SetBackdrop({
		bgFile = "Interface/Buttons/UI-SliderBar-Background",
		tile = true,
		tileSize = 8,
		backdropColor = { r = 0.0, g = 0.0, b = 0.0, a = 0.97 },
	})
	slider:SetThumbTexture("Interface/Buttons/UI-ScrollBar-Knob")
	slider:GetThumbTexture():SetTexCoord(0.20, 0.80, 0.125, 0.875)
	slider:GetThumbTexture():SetSize(20, 26)
	slider:SetSize(20, 208);
	slider:SetMinMaxValues(p_range.min, p_range.max)
	slider:SetValue(p_range.min)
	slider:SetValueStep(1)
	slider:SetOrientation('VERTICAL')
	slider:SetObeyStepOnDrag(true)

	local slider_button_scroll_up = CreateFrame("Button", nil, p_parent_frame, "UIPanelScrollUpButtonTemplate");
	slider_button_scroll_up.my_slider = slider
	slider_button_scroll_up:SetScript("OnClick", function(self)
		local slider = self.my_slider;
		local slide_min, slide_max = slider:GetMinMaxValues()
		local current = slider:GetValue()
		if (current > slide_min) then slider:SetValue(current - 1); PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON); end;
		if ((current - 1) <= slide_min) then self:Disable(); end;
	end)

	local slider_button_scroll_down = CreateFrame("Button", nil, p_parent_frame, "UIPanelScrollDownButtonTemplate");
	slider_button_scroll_up.my_slider = slider
	slider_button_scroll_down:SetScript("OnClick", function(self)
		local slider = self.my_slider;
		local slide_min, slide_max = slider:GetMinMaxValues()
		local current = slider:GetValue()
		if (current < slide_max) then slider:SetValue(current + 1); PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON); end;
		if ((current + 1) >= slide_max) then self:Disable(); end;
	end)

	slider.my_button_up = slider_button_scroll_up
	slider.my_button_down = slider_button_scroll_down

	slider:SetPoint("TOPLEFT", slider_button_scroll_up, "BOTTOMLEFT", 0, 2)
	slider_button_scroll_down:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 0, 2)


	return slider
end

function UITK.create_divider(p_frame, p_name)

	local divider = p_frame:CreateTexture(p_name, "ARTWORK");
	divider:SetSize(0, 12);
	divider:SetTexture("Interface/DialogFrame/UI-DialogBox-Divider")
	divider:SetBlendMode("BLEND")
	divider:SetTexCoord(0.1, 0.7, 0.0, 0.5)

	return divider;
end

function UITK.CreateTexture(p_frame, p_file, p_width, p_height)
	local texture = p_frame:CreateTexture(nil, "ARTWORK");
	texture:SetTexture(p_file)
	if (p_width) then texture:SetWidth(p_width); end
	if (p_height) then texture:SetHeight(p_height); end
	texture:SetBlendMode("BLEND")

	return texture
end

function UITK.PlayClick(p_on)
	if(p_on) then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
	end
end


