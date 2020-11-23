local ADDON_NAME, _ADDON_DATA = ... -- Pulls back the Addon-Local Variables and store them locally.

local font_size = 13
local font_name = "Fonts\\FRIZQT__.TTF"
local font_spacing = 2
local initial_delay = 4
local interstitial_delay = 0.25

local function table_pack(...)
  return { n = select("#", ...), ... }
end

local function d_print(...)
	local args = table_pack(...)

	local s = ""
	for i=1, args.n do
		s = s .. tostring(args[i])
	end

	-- I use tinspect to view the log and it sorts the keys by alpha even in a number array
	local key = "0000" .. tostring(MUFFIN_WHATS_NEW_QUEUE.StupidLogLine)
	key = strsub(key, -3)

	MUFFIN_WHATS_NEW_QUEUE.StupidLog[key] = s

	MUFFIN_WHATS_NEW_QUEUE.StupidLogLine = MUFFIN_WHATS_NEW_QUEUE.StupidLogLine + 1
end

local function build_queue_frame()
	d_print("build_queue_frame:", ADDON_NAME)

	local frame = CreateFrame("Frame", "MuffinWhatsNewFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
	frame:SetBackdrop({
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = { left = 11, right = 11, top = 11, bottom = 10 }
	})
	frame:SetBackdropColor(0, 0, 0, 0.9);
	frame:SetPoint("CENTER", UIParent, "CENTER")
	frame:EnableMouse(true)
	frame:SetMovable(true)
	frame:RegisterForDrag("LeftButton");
	frame:SetHitRectInsets(0, 0, -20, 0);
	frame:SetScript('OnDragStart', function(f) f:StartMoving() end)
	frame:SetScript('OnDragStop', function(f) f:StopMovingOrSizing() end)

	local muffin_texture = frame:CreateTexture("MuffinWhatsNewFrameMuffinTexture", "ARTWORK");
	muffin_texture:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -8, 10)
	muffin_texture:SetSize(64, 64);
	muffin_texture:SetTexture("Interface\\Addons\\" .. ADDON_NAME .. "\\Textures\\muffin.tga")
	muffin_texture:SetBlendMode("BLEND")

	local header_frame = CreateFrame("Frame", "MuffinWhatsNewHeaderFrame", frame, BackdropTemplateMixin and "BackdropTemplate")
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

	local title_text = header_frame:CreateFontString("MuffinWhatsNewTitleText", "ARTWORK", "GameFontNormal")
	title_text:SetFont(font_name, font_size)
	title_text:SetSpacing(font_spacing)
	title_text:SetJustifyH("CENTER")
	title_text:SetPoint("CENTER", header_frame, "CENTER", 0, 0)

	local body_text = frame:CreateFontString("MuffinWhatsNewFrameText", "ARTWORK", "GameFontNormal")
	body_text:SetFont(font_name, font_size)
	body_text:SetSpacing(font_spacing)
	body_text:SetTextColor(0, 1, 0, 0.9)
	body_text:SetPoint("LEFT", frame, "LEFT", 20, 0)
	body_text:SetJustifyH("LEFT")

	local ok_button = CreateFrame("Button", "MuffinWhatsNewFrameOkButton", frame, "UIPanelButtonTemplate")
	ok_button:SetText(OKAY)
	ok_button:SetHeight(ok_button:GetHeight() + 10);
	ok_button:SetWidth(ok_button:GetWidth() + 10);
	ok_button:SetPoint("BOTTOM", frame, "BOTTOM", 0, 15)
	ok_button:SetScript("OnClick", function(self, button, down) PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK); MUFFIN_WHATS_NEW_QUEUE.frame:Hide();  C_Timer.After(interstitial_delay, MUFFIN_WHATS_NEW_QUEUE.show_whats_new_internal); end)

	--Save pointers to stuff we'll need to change or reference for each different what's new dialog
	MUFFIN_WHATS_NEW_QUEUE.frame = frame
	MUFFIN_WHATS_NEW_QUEUE.header_frame = header_frame
	MUFFIN_WHATS_NEW_QUEUE.header_text = title_text
	MUFFIN_WHATS_NEW_QUEUE.body_text = body_text
	MUFFIN_WHATS_NEW_QUEUE.ok_button = ok_button

	frame:Hide()
end

local function queue_show_whats_new()
	d_print("queue_show_whats_new:", ADDON_NAME)

	if(not MUFFIN_WHATS_NEW_QUEUE.frame) then
		build_queue_frame()
	end

	assert(MUFFIN_WHATS_NEW_QUEUE.frame)

	d_print("  about to show ", ADDON_NAME, MUFFIN_WHATS_NEW_QUEUE, MUFFIN_WHATS_NEW_QUEUE.frame)

	C_Timer.After(0, function()
	 -- This strange double-timer thing works around an issue where the timer starts counting down, so to speak, during the loading screen if the UI is being reloaded (as per /reload), making the toast not appear.
		C_Timer.After(initial_delay, function() MUFFIN_WHATS_NEW_QUEUE.show_whats_new_internal(); end)
	end
	)

end

local function queue_show_whats_new_internal()
	d_print("queue_show_whats_new_internal")

	-- if the queue is empty, don't do anything
	if (next(MUFFIN_WHATS_NEW_QUEUE.q) == nil) then
		d_print("  queue is empty, nothing to do ")
		return;
	end

	-- An addon is already showing something, so don't clobber it
	if(MUFFIN_WHATS_NEW_QUEUE.frame:IsShown()) then
		d_print("  frame is Visible, nothing to do ")
		return
	end

	d_print("  frame is not Visible, getting ready to show it ")

	local frame = MUFFIN_WHATS_NEW_QUEUE.frame
	local header_frame = MUFFIN_WHATS_NEW_QUEUE.header_frame
	local header_text = MUFFIN_WHATS_NEW_QUEUE.header_text
	local body_text = MUFFIN_WHATS_NEW_QUEUE.body_text
	local ok_button = MUFFIN_WHATS_NEW_QUEUE.ok_button

	local back = table.remove(MUFFIN_WHATS_NEW_QUEUE.q) -- get a pending what's new request, retrieved from end since it doesn't require shuffling

	local dialog_title = string.format("What's New in %s|nv%s", back.addon_name, back.addon_version)
	header_text:SetText(dialog_title)
	local header_text_width = header_text:GetStringWidth()
	local header_text_height = header_text:GetStringHeight()

	header_text:SetSize(header_text_width, header_text_height)
	header_frame:SetSize(header_text_width * 1.4, header_text_height * 1.9)

	body_text:SetText(back.body_text)
	local body_width = body_text:GetStringWidth()
	local body_height = body_text:GetStringHeight()
	body_text:SetSize(body_width, body_height)

	frame:SetSize(math.max(body_width * 1.2, 300), math.max(body_height * 1.5, 100) + ok_button:GetHeight())

	PlaySound(888) -- Level Up sound
	frame:Show()
end

local function add_entry(p_q_entry)
	d_print(" add_entry:", p_q_entry.addon_name)

	assert(MUFFIN_WHATS_NEW_QUEUE ~= nil)
	assert(MUFFIN_WHATS_NEW_QUEUE.q ~= nil)

	p_q_entry.addon_name = p_q_entry.addon_name or ADDON_NAME
	p_q_entry.addon_version = p_q_entry.addon_version or GetAddOnMetadata(p_q_entry.addon_name, "Version")

	p_q_entry.body_text = gsub(p_q_entry.body_text, "`", "'")	--Replace backticks with ticks
	p_q_entry.body_text = gsub(p_q_entry.body_text, "\t", "")	--Remove code-required indenting
	p_q_entry.body_text = gsub(p_q_entry.body_text, "|t", "   ")	--Implement our own tabs since WoW doesn't seem to do so

	tinsert(MUFFIN_WHATS_NEW_QUEUE.q, p_q_entry)
end

local function add_conditional_entry(p_args)
	d_print(" add_conditional_entry:", p_args)

	assert(p_args);
	assert(p_args.text);

	local addon_name = p_args.addon_name or ADDON_NAME;	--Dumb hack
	local this_version = GetAddOnMetadata(addon_name, "Version")
	local stored_version = p_args.version or 0
	local force_show = p_args.force_show
	d_print("this_version:", this_version, "stored:", stored_version, addon_name)

	if((this_version ~= stored_version) or force_show) then

		local q_entry = {}
		q_entry.addon_name = addon_name
		q_entry.addon_version = this_version
		q_entry.body_text = p_args.text

		q_entry.body_text = gsub(q_entry.body_text, "`", "'")	--Replace backticks with ticks
		q_entry.body_text = gsub(q_entry.body_text, "\t", "")	--Remove code-required indenting
		q_entry.body_text = gsub(q_entry.body_text, "|t", "   ")	--Implement our own tabs since WoW doesn't seem to do so

		tinsert(MUFFIN_WHATS_NEW_QUEUE.q, q_entry)
	end

	return this_version;
end

if(not MUFFIN_WHATS_NEW_QUEUE) then

	MUFFIN_WHATS_NEW_QUEUE = {}
	MUFFIN_WHATS_NEW_QUEUE.version = 2
	MUFFIN_WHATS_NEW_QUEUE.q = {}
	MUFFIN_WHATS_NEW_QUEUE.frame = nil --Shared frame for showing all of the what's news
	MUFFIN_WHATS_NEW_QUEUE.header_frame = nil	--Header frame for the what's new dialog
	MUFFIN_WHATS_NEW_QUEUE.header_text = nil
	MUFFIN_WHATS_NEW_QUEUE.body_text = nil
	MUFFIN_WHATS_NEW_QUEUE.okay_button = nil
	MUFFIN_WHATS_NEW_QUEUE.StupidLog = {}
	MUFFIN_WHATS_NEW_QUEUE.StupidLogLine = 1

	MUFFIN_WHATS_NEW_QUEUE.Show = queue_show_whats_new
	MUFFIN_WHATS_NEW_QUEUE.show_whats_new_internal = queue_show_whats_new_internal
	MUFFIN_WHATS_NEW_QUEUE.AddEntry = add_entry
	MUFFIN_WHATS_NEW_QUEUE.AddConditionalEntry = add_conditional_entry

	d_print("Initialized MUFFIN_WHATS_NEW_QUEUE")

elseif MUFFIN_WHATS_NEW_QUEUE.version < 2 then

	MUFFIN_WHATS_NEW_QUEUE.AddConditionalEntry = add_conditional_entry

end
