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
--		battleground
--		notUsable (soul shards, arrows, etc.)
--		flying

--	AutoBar
--		spell
--		limit

local AutoBar = AutoBar

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
