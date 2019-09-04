
local ADDON_NAME, AB = ... -- Pulls back the Addon-Local Variables and store them locally.


local WHATSNEW_TEXT = "" ..
[[
 - Hunters: Tracking, Aspect of the Monkey, Immolation Trap, marked as Mana users
 - Druid: Aquatic form and Stance button
 - Shaman: Strength of Earth Totem, Flametongue Weapon
 - Updated some data for Openables, Quest Items, Rep
 - Updated libraries
 - NOTE: LOTS of items/spells are missing but there shouldn`t be any lua errors
 - Go to MuffinManGames.com to report any issues or for information on my Patreon
]] .. "|n"

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
