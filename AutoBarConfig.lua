--
-- AutoBarConfig
--
-- Config options in the standard place
--

-- http://muffinmangames.com
--

local AceGUI = LibStub("AceGUI-3.0")

local AutoBar = AutoBar
local ABGCode = AutoBarGlobalCodeSpace

local L = AutoBarGlobalDataObject.locale
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

--local function print_map_ids()
--local res = "";
--	for i = 1, 4000 do
--		local map_info = C_Map.GetMapInfo(i);
--		if(map_info) then
--			res = res .. "|n" .. tostring(i) .. "   " .. map_info.name;
--		end
--	end
--
--	return res;
--end

local function set_nameless_category_text(p_widget)

	local edit_box_cat = p_widget:GetUserData("edit_box_cat")
	edit_box_cat:SetText(ABGCode:FindNamelessCategories())

	local edit_box_btn = p_widget:GetUserData("edit_box_btn")
	edit_box_btn:SetText(ABGCode:FindNamelessButtons())

--	edit_box:SetText(print_map_ids())

end

-- function that draws the widgets for the first tab
local function DrawGroupNamelessCategories(container)

	local button = AceGUI:Create("Button")
	button:SetText("Find Nameless Categories/Buttons")
	button:SetWidth(200)
	button:SetCallback("OnClick", set_nameless_category_text)
	container:AddChild(button)

	local edit_box_cat = AceGUI:Create("MultiLineEditBox")
	edit_box_cat:SetNumLines(15)
	edit_box_cat:SetFullWidth(true)
	edit_box_cat:DisableButton(true)
	edit_box_cat:SetLabel(nil)
	container:AddChild(edit_box_cat)

	local edit_box_btn = AceGUI:Create("MultiLineEditBox")
	edit_box_btn:SetNumLines(15)
	edit_box_btn:SetFullWidth(true)
	edit_box_btn:DisableButton(true)
	edit_box_btn:SetLabel('')
	container:AddChild(edit_box_btn)

	button:SetUserData("edit_box_cat", edit_box_cat)
	button:SetUserData("edit_box_btn", edit_box_btn)
end



-- function that draws the widgets for the second tab
local function DrawGroupWarnings(container)


	local edit_box = AceGUI:Create("MultiLineEditBox")
	edit_box:SetNumLines(28)
	edit_box:SetFullWidth(true)
	edit_box:DisableButton(true)
	edit_box:SetLabel("")
	container:AddChild(edit_box)

	edit_box:SetText(AutoBarGlobalCodeSpace:GetWarningLogString())

end

-- Callback function for OnGroupSelected
local function SelectGroup(container, event, group)
   container:ReleaseChildren()
   if group == "tab1" then
      DrawGroupNamelessCategories(container)
   elseif group == "tab2" then
      DrawGroupWarnings(container)
   end
end

local tab =  AceGUI:Create("TabGroup")
tab:SetLayout("Flow")
-- Setup which tabs to show
tab:SetTabs({{text="Nameless Categories", value="tab1"}, {text="Warnings", value="tab2"}})
-- Register callback
tab:SetCallback("OnGroupSelected", SelectGroup)
-- Set initial Tab (this will fire the OnGroupSelected callback)
tab:SelectTab("tab1")

-- add to the frame container
AutoBarConfig.DebugFrame:AddChild(tab)