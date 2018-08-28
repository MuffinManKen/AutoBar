
local ADDON_NAME, AB = ... -- Pulls back the Addon-Local Variables and store them locally.


local WHATSNEW_TEXT = "" ..
[[
 - Updated data libs
 - Removed ancient DewDropLib. You can no longer right-click on the minimap button
|t to get a popup menu. Leave me a comment if you used this feature and I`ll find an
|t alternate way to implement it
 - Go to MuffinManGames.com to report any issues or for information on my Patreon
]] .. "|n"

local DEBUG_SHOW = true

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
