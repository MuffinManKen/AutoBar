
local ADDON_NAME, AB = ... -- Pulls back the Addon-Local Variables and store them locally.


local WHATSNEW_TEXT

if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then

	WHATSNEW_TEXT = "" ..
	[[
	 - Priest: Added Power Word: Fortitude
	 - New bars are 1x16 by default
	 - Dynamic Detection of Quest Items is working now
	 - Fix for spell-based buttons not re-ordering
	 - Go to MuffinManGames.com to report any issues or for information on my Patreon
	]] .. "|n"

else
	WHATSNEW_TEXT = "" ..
	[[
	 - So Many fixes!
	 - New bars are 1x16 by default
	 - Dynamic Detection of Quest Items is working now
	 - Custom Categories are visible again in the Categories tab
	 - Absolutely no new items have been added, that will happen later.
	 - Go to MuffinManGames.com to report any issues or for information on my Patreon
	]] .. "|n"

end

local DEBUG_SHOW = false

function AB.show_whats_new()

	local this_version = GetAddOnMetadata(ADDON_NAME, "Version")

	if((this_version ~= AutoBarDB.whatsnew_version) or DEBUG_SHOW) then
		AutoBarDB.whatsnew_version = this_version

		local q_entry = {}
		q_entry.addon_name = ADDON_NAME
		q_entry.addon_version = this_version
		q_entry.body_text = WHATSNEW_TEXT

		MUFFIN_WHATS_NEW_QUEUE.AddEntry(q_entry)

		MUFFIN_WHATS_NEW_QUEUE.Show()
	end

end
