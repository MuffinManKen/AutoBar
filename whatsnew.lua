
local ADDON_NAME, AB = ... -- Pulls back the Addon-Local Variables and store them locally.


local WHATSNEW_TEXT

if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then

	WHATSNEW_TEXT = "" ..
	[[
	 - Hunter: Track Hidden & Elementals
	 - Shaman: Earth Shock isn`t a totem
	 - Warlock: Fixed Demon Skin
	 - Warrior: Berserker/Battle Stance
	 - Lots of cleanup
	 - Really ugly hack to try to workaround Bagnon conflicts
	 - NOTE: LOTS of items/spells are missing but there shouldn`t be any lua errors
	 - Go to MuffinManGames.com to report any issues or for information on my Patreon
	]] .. "|n"

else
	WHATSNEW_TEXT = "" ..
	[[
	 - More data updates
	 - Updated libraries
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
