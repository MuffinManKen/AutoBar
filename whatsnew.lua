
local ADDON_NAME, AB = ... -- Pulls back the Addon-Local Variables and store them locally.


local WHATSNEW_TEXT

if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then

	WHATSNEW_TEXT = "" ..
	[[
	 - Basic (non-buff) food should be more correct now
	 - Mounts have been mined, but I can`t test them
	 - Mage: Dampen Magic
	 - Go to MuffinManGames.com to report any issues or for information on my Patreon
	]] .. "|n"

else
	WHATSNEW_TEXT = "" ..
	[[
	 - Druid: Fixes
	 - Go to MuffinManGames.com to report any issues or for information on my Patreon
	]] .. "|n"

end

local DEBUG_SHOW = false

function AB.show_whats_new()

	local this_version = GetAddOnMetadata(ADDON_NAME, "Version")

	if((this_version ~= AutoBarDB.whatsnew_version) or DEBUG_SHOW) then
		AutoBarDB.whatsnew_version = this_version

		local text = gsub(WHATSNEW_TEXT, "\t", "")
		text = gsub(text, "`", "'")

		local q_entry = {}
		q_entry.addon_name = ADDON_NAME
		q_entry.addon_version = this_version
		q_entry.body_text = text

		MUFFIN_WHATS_NEW_QUEUE.AddEntry(q_entry)

		MUFFIN_WHATS_NEW_QUEUE.Show()
	end

end
