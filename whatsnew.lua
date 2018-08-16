
local _, AB = ... -- Pulls back the Addon-Local Variables and store them locally.


local WHATSNEW_TEXT = "" ..
[[
 - Updated data libs
 - Fixed an issue where usable items weren't showing up on the bar (Blizzard lies!)
 - Go to MuffinManGames.com to report any issues or for information on my Patreon
]] .. "|n"

function AB.show_whats_new()

	local addon_name = "AutoBar"

	local this_version = GetAddOnMetadata(addon_name, "Version")

	if(this_version ~= AutoBarDB.whatsnew_version) then
		 AutoBarDB.whatsnew_version = this_version

		local WHATSNEW_TITLE = "What's New in " .. addon_name

		local muff_fac = _G["MuffinFactionizerWhatsNewFrame"];

		local frame = CreateFrame("Frame", addon_name .. "WhatsNewFrame", muff_fac or UIParent)
		frame:SetBackdrop({
			bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
			tile = true,
			tileSize = 32,
			edgeSize = 32,
			insets = { left = 11, right = 11, top = 11, bottom = 10 }
		})
		frame:SetBackdropColor(0, 0, 0, 0.9);
		if (muff_fac) then
			frame:SetPoint("BOTTOM", muff_fac, "TOP", 0, 20);
		else
			frame:SetPoint("CENTER", UIParent, "CENTER")
		end
		frame:EnableMouse(true)
		frame:SetMovable(true)
		frame:RegisterForDrag("LeftButton");
		frame:SetHitRectInsets(0, 0, -20, 0);
		frame:SetScript('OnDragStart', function(f) f:StartMoving() end) 
		frame:SetScript('OnDragStop', function(f) f:StopMovingOrSizing() end)


		local muffin_texture = frame:CreateTexture(addon_name .. "WhatsNewFrameMuffinTexture", "ARTWORK");
		muffin_texture:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -8, 10)
		muffin_texture:SetSize(48, 48);
		muffin_texture:SetTexture("Interface\\Addons\\" .. addon_name .. "\\Textures\\muffin.tga")
		muffin_texture:SetBlendMode("BLEND")


		local header_frame = CreateFrame("Frame", addon_name .. "WhatsNewHeaderFrame", frame)
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

		local title_text = header_frame:CreateFontString(addon_name .. "WhatsNewTitleText", "ARTWORK", "GameFontNormal")
		title_text:SetText(WHATSNEW_TITLE .. "|n" .. this_version)
		title_text:SetJustifyH("CENTER")

		local title_string_width = title_text:GetStringWidth()
		local title_string_height = title_text:GetStringHeight()

		header_frame:SetSize(title_string_width * 1.4, title_string_height * 1.9)
		title_text:SetSize(title_string_width, title_string_height)

		title_text:SetPoint("CENTER", header_frame, "CENTER", 0, 0)


		local text = frame:CreateFontString(addon_name .. "WhatsNewFrameText", "ARTWORK", "GameFontNormal")
		text:SetTextColor(0, 1, 0, 0.9)
		text:SetText(WHATSNEW_TEXT)
		text:SetPoint("LEFT", frame, "LEFT", 20, 0)
		text:SetJustifyH("LEFT")

		local string_width = text:GetStringWidth()
		local string_height = text:GetStringHeight()

		local ok_button = CreateFrame("Button", addon_name .. "WhatsNewFrameOkButton", frame, "UIPanelButtonTemplate")
		ok_button:SetText(OKAY)
		ok_button:SetHeight(ok_button:GetHeight() + 10);
		ok_button:SetWidth(ok_button:GetWidth() + 10);

		frame:SetSize(math.max(string_width * 1.2, 300), math.max(string_height * 1.5, 100) + ok_button:GetHeight())
		text:SetSize(string_width, string_height)

		ok_button:SetPoint("BOTTOM", frame, "BOTTOM", 0, 15)
		ok_button:SetScript("OnClick", function(self, button, down) frame:Hide() end)

		frame:Show()
	end

end
