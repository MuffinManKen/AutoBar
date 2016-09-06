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

AutoBarConfig = {}
AutoBarConfig.Debug = {} --table to store stuff related to the Debug Frame

AutoBarConfig.OptionsFrame = AceGUI:Create("BlizOptionsGroup")
AutoBarConfig.OptionsFrame:SetName("AutoBar")
InterfaceOptions_AddCategory(AutoBarConfig.OptionsFrame.frame);

AutoBarConfig.DebugFrame = AceGUI:Create("BlizOptionsGroup")
AutoBarConfig.DebugFrame:SetName("Debug", "AutoBar")
AutoBarConfig.DebugFrame:SetLayout("Fill")
InterfaceOptions_AddCategory(AutoBarConfig.DebugFrame.frame);


local function set_nameless_category_text(p_widget)

	local edit_box = p_widget:GetUserData("edit_box")
	edit_box:SetText(AutoBar:FindNamelessCategories())

end

-- function that draws the widgets for the first tab
local function DrawGroup1(container)

	local button = AceGUI:Create("Button")
	button:SetText("Find Nameless Categories")
	button:SetWidth(200)
	button:SetCallback("OnClick", set_nameless_category_text)
	container:AddChild(button)

	local edit_box = AceGUI:Create("MultiLineEditBox")
	edit_box:SetNumLines(20)
	edit_box:SetFullWidth(true)
	edit_box:DisableButton(true)
	container:AddChild(edit_box)

	button:SetUserData("edit_box", edit_box)
end


-- function that draws the widgets for the second tab
local function DrawGroup2(container)
  local desc = AceGUI:Create("Label")
  desc:SetText("This is Tab 2")
  desc:SetFullWidth(true)
  container:AddChild(desc)
  
  local button = AceGUI:Create("Button")
  button:SetText("Tab 2 Button")
  button:SetWidth(200)
  container:AddChild(button)
end

-- Callback function for OnGroupSelected
local function SelectGroup(container, event, group)
   container:ReleaseChildren()
   if group == "tab1" then
      DrawGroup1(container)
   elseif group == "tab2" then
      DrawGroup2(container)
   end
end

local tab =  AceGUI:Create("TabGroup")
tab:SetLayout("Flow")
-- Setup which tabs to show
tab:SetTabs({{text="Nameless Categories", value="tab1"}, {text="Tab 2", value="tab2"}})
-- Register callback
tab:SetCallback("OnGroupSelected", SelectGroup)
-- Set initial Tab (this will fire the OnGroupSelected callback)
tab:SelectTab("tab1")

-- add to the frame container
AutoBarConfig.DebugFrame:AddChild(tab)