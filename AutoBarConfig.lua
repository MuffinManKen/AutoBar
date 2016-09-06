--
-- AutoBarConfig
--
-- Config options in the standard place
--

-- http://muffinmangames.com
--

local AceGUI = LibStub("AceGUI-3.0")

local AutoBar = AutoBar

local L = AutoBar.locale
local _

--AutoBar.panel = CreateFrame( "Frame", "AutoBarConfigPanel", UIParent );
-- Register in the Interface Addon Options GUI
-- Set the name for the Category for the Options Panel
--AutoBar.panel.name = "AutoBar";
-- Add the panel to the Interface Options
--InterfaceOptions_AddCategory(AutoBar.panel);


---- Make a child panel
--AutoBar.buttonspanel = CreateFrame( "Frame", "AutoBarConfigButtons", AutoBar.panel);
--AutoBar.buttonspanel.name = "Buttons";
---- Specify childness of this panel (this puts it under the little red [+], instead of giving it a normal AddOn category)
--AutoBar.buttonspanel.parent = AutoBar.panel.name;
---- Add the child to the Interface Options
--InterfaceOptions_AddCategory(AutoBar.buttonspanel);
--
--AutoBar.foodpanel = CreateFrame( "Frame", "AutoBarConfigButtonsFood", AutoBar.buttonspanel);
--AutoBar.foodpanel.name = "Food";
---- Specify childness of this panel (this puts it under the little red [+], instead of giving it a normal AddOn category)
--AutoBar.foodpanel.parent = AutoBar.buttonspanel.name;
---- Add the child to the Interface Options
--InterfaceOptions_AddCategory(AutoBar.foodpanel);


-- Debug Panel
--AutoBar.buttonspanel = CreateFrame( "Frame", "AutoBarConfigDebug", AutoBar.panel);
--AutoBar.buttonspanel.name = "Debug";

--AutoBar.buttonspanel.parent = AutoBar.panel.name; -- Child of the main panel
--InterfaceOptions_AddCategory(AutoBar.buttonspanel);

--BlizOptionsGroup_AB_Name = "AutoBar2"
local blizz_options = AceGUI:Create("BlizOptionsGroup")
blizz_options:SetName("AutoBar2")
InterfaceOptions_AddCategory(blizz_options.frame);

local blizz_options_debug = AceGUI:Create("BlizOptionsGroup")
blizz_options_debug:SetName("AutoBar2-1", "AutoBar2")
InterfaceOptions_AddCategory(blizz_options_debug.frame);
