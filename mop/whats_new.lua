
local _ADDON_NAME, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

AB.WHATSNEW_TEXT = "" ..
[[
 - TOC Bump
 - Changing Clamp To Screen setting no longer requires a reload
 - Fixed a bug where Re-arrange On Use wasn't working properly
 - Control-clicking a popup button when set to RearrangeOnUse changes the default button
    without actually using the item/spell
 - Made default Config window size a bit bigger since no one ever notices the Button options.
 - Fixed PopupOnShift
 - Zone-specific items should (Flight Whistle, etc) be better behaved
 - New method for managing Custom Categories
 - Fixed a bug with Deleting a Button
 - Improved issue with popups staying up when you move the mouse too fast.
 - Fixed issue with Totems and secret values in Classic
 - I'm not playing WoW, so if things are missing make sure you report them.
]] .. "|n"
