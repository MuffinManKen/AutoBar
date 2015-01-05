--
-- AutoBarConfig
--
-- Config options in the standard place
--

-- http://muffinmangames.com
--

--	PeriodicGroup
--		description
--		texture
--		targeted
--		nonCombat
--		location
--		battleground
--		notUsable (soul shards, arrows, etc.)
--		flying

--	AutoBar
--		spell
--		limit

local AutoBar = AutoBar

local REVISION = tonumber(("$Revision: 1.4 $"):match("%d+"))
if AutoBar.revision < REVISION then
	AutoBar.revision = REVISION
	AutoBar.date = ('$Date: 2010/12/22 04:28:17 $'):match('%d%d%d%d%-%d%d%-%d%d')
end


local L = AutoBar.locale
local _

AutoBar.panel = CreateFrame( "Frame", "AutoBarConfigPanel", UIParent );
-- Register in the Interface Addon Options GUI
-- Set the name for the Category for the Options Panel
AutoBar.panel.name = "AutoBar";
-- Add the panel to the Interface Options
InterfaceOptions_AddCategory(AutoBar.panel);

-- Make a child panel
AutoBar.buttonspanel = CreateFrame( "Frame", "AutoBarConfigButtons", AutoBar.panel);
AutoBar.buttonspanel.name = "Buttons";
-- Specify childness of this panel (this puts it under the little red [+], instead of giving it a normal AddOn category)
AutoBar.buttonspanel.parent = AutoBar.panel.name;
-- Add the child to the Interface Options
InterfaceOptions_AddCategory(AutoBar.buttonspanel);

AutoBar.foodpanel = CreateFrame( "Frame", "AutoBarConfigButtonsFood", AutoBar.buttonspanel);
AutoBar.foodpanel.name = "Food";
-- Specify childness of this panel (this puts it under the little red [+], instead of giving it a normal AddOn category)
AutoBar.foodpanel.parent = AutoBar.buttonspanel.name;
-- Add the child to the Interface Options
InterfaceOptions_AddCategory(AutoBar.foodpanel);
