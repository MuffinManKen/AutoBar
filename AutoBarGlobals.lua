
-- Separate tables for code and data. Splitting the code off from the data makes it easier to inspect data objects.
-- The names are verbose to reduce likelihood of conflict with another addon

-- GLOBALS: GetItemInfo, GetItemInfoInstant, GetSpellInfo, PlayerHasToy, C_ToyBox, type, GetSpellLink

local _, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

local print, select, ipairs, tostring, pairs, tonumber, string = print, select, ipairs, tostring, pairs, tonumber, string

AutoBar = MMGHACKAceLibrary("AceAddon-2.0"):new("AceDB-2.0");
AutoBar.warning_log = {}

-- All global code with be a child of this table.
AutoBarGlobalCodeSpace = {}


function AutoBarGlobalCodeSpace.MakeSet(list)
   local set = {}
   for _, l in ipairs(list) do set[l] = true end
   return set
end


-- All global data will be a child of this table
AutoBarGlobalDataObject = {
	TYPE_MACRO_TEXT = 1,
	TYPE_TOY = 2,
	TYPE_BATTLE_PET = 3,

	locale = {},

	timing = {},

	profile = {},

	QirajiMounts = {[25953] = 1;[26056] = 1;[26054] = 1; [26055] = 1},

	is_mainline_wow = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE),
	is_vanilla_wow = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC),
	is_bcc_wow = (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC),

}


-- List of [spellName] = <GetSpellInfo Name>
AutoBarGlobalDataObject.spell_name_list = {}
-- List of [spellName] = <GetSpellInfo Icon>
AutoBarGlobalDataObject.spell_icon_list = {}

AutoBarGlobalDataObject.set_mana_users = AutoBarGlobalCodeSpace.MakeSet{"DRUID", "HUNTER", "MAGE", "MONK", "PRIEST", "PALADIN", "SHAMAN", "WARLOCK"}

function AutoBarGlobalCodeSpace.ClassUsesMana(p_class_name)

	return AutoBarGlobalDataObject.set_mana_users[p_class_name]

end

function AutoBarGlobalCodeSpace.ClassInList(p_class_name, ...)
	local list = {...}

	for _i, v in ipairs(list) do
		if (p_class_name == v) then
			return true;
		end
	end

	return false;

end


AutoBarGlobalDataObject.TickScheduler =
{

	UpdateCategoriesID = 1,
	UpdateSpellsID = 2,
	UpdateObjectsID = 3,
	UpdateItemsID = 4,
	UpdateAttributesID = 5,
	UpdateActiveID = 6,
	UpdateButtonsID = 7,
	UpdateCompleteID = 8,

	BehaveTicker = 1,	-- Called by the ticker, so you may return the next step to be run rather than doing it immediately

	FullScanItemsFlag = true,

	ScheduledUpdate = nil,

	OtherStickyFrames = {
		"GridLayoutFrame",
		"Grid2LayoutFrame",
	}
}


function AB.Dump(o, p_max_depth)
	local depth = p_max_depth or 5
	if type(o) == 'table' and (depth >= 1)  then
		depth = depth - 1
		local s = '{ '
		for k,v in pairs(o) do
			if type(k) ~= 'number' then
				k = '"'..k..'"'
			end
			s = s .. '['..k..'] = ' .. AB.Dump(v, depth) .. ','
		end
		return s .. '} '
	else
		return tostring(o)
	end
end


local function table_pack(...)
  return { n = select("#", ...), ... }
end

function AutoBarGlobalCodeSpace.LogWarning(...)

	local message = "";
	local args = table_pack(...)
	for i=1,args.n do
		message = message .. tostring(args[i]) .. " "
	end
	table.insert(AutoBar.warning_log, message)

end

function AutoBarGlobalCodeSpace.GetWarningLogString()

	return table.concat(AutoBar.warning_log, "\n")

end

function AutoBarGlobalCodeSpace.ToyGUID(p_toy_id)

	local l = 7 - string.len(p_toy_id);
	local guid = "toy:" .. string.rep("0", l) .. p_toy_id;

	return guid;
end

function AutoBarGlobalCodeSpace.BPetGUID(p_bpet_id)

	local guid = "bpet:" .. p_bpet_id;

	return guid;
end

local macro_text_guid_index = 0;
function AutoBarGlobalCodeSpace.MacroTextGUID(_p_macro_text)	--TODO: We're not using the text?

	macro_text_guid_index = macro_text_guid_index + 1
	local guid = "macrotext:" .. macro_text_guid_index;

	return guid;
end



function AutoBarGlobalCodeSpace.GetIconForToyID(p_toy_id)
	local item_id = tonumber(p_toy_id)

	local _, _, texture =  C_ToyBox.GetToyInfo(item_id)

	if(texture == nil) then
		texture = AutoBarGlobalCodeSpace.GetIconForItemID(item_id);
	end

	return texture;
end

function AutoBarGlobalCodeSpace.GetIconForItemID(p_item_id)
	local i_texture = select(10, GetItemInfo(p_item_id))

	local ii_texture = select(5, GetItemInfoInstant(p_item_id))

	return ii_texture or i_texture;
end

function AutoBarGlobalCodeSpace.GetValidatedName(p_name)
	local name = p_name:gsub("%.", "")
	name = name:gsub("\"", "")
	name = name:gsub(" ", "")
	return name
end


local usable_items_override_set = AutoBarGlobalCodeSpace.MakeSet{
122484,	--Blackrock foundry spoils
71715,	--A Treatise on Strategy
113258,  --Blingtron 5000 Gift package
132892,  --Blingtron 6000 Gift package

150924, -- Greater Tribute of the Broken Isles

118529, -- Cache of Highmaul Treasures
}

local is_usable_item_cache = {}

function AutoBarGlobalCodeSpace.IsUsableItem(p_item_id)

	if(p_item_id == nil) then
		return nil;
	end

	return true;

--	local is_usable, not_enough_mana = IsUsableItem(p_item_id);

--	is_usable_item_cache[p_item_id] = is_usable or is_usable_item_cache[p_item_id] or usable_items_override_set[p_item_id];

--	return is_usable_item_cache[p_item_id], not_enough_mana;
end


--/run AutoBarGlobalCodeSpace.FrameInsp(ActionButton3)
function AutoBarGlobalCodeSpace.FrameInsp(p_frame) --AutoBarButtonExplosiveFrame

	local frame = p_frame

	print("Type:", frame:GetAttribute("type"),"type1:", frame:GetAttribute("type1"), "type2:", frame:GetAttribute("type2"), "ItemID:", frame:GetAttribute("itemID"), "Category:", frame:GetAttribute("category") )
	print("Item:", frame:GetAttribute("item"))
	print("State:", frame:GetAttribute("state"))
	print("Attribute:", frame:GetAttribute("attribute"))
	print("Action:", frame:GetAttribute("action"),"Action1:", frame:GetAttribute("action1"), "Action2:", frame:GetAttribute("action2"), "ActionPage:", frame:GetAttribute("actionpage"))
	print("Macro:", frame:GetAttribute("macro"), "MacroText:", frame:GetAttribute("macrotext"))
	print("Spell:", frame:GetAttribute("spell"), "Spell1:", frame:GetAttribute("spell1"), "Spell2:", frame:GetAttribute("spell2"))
	print("Unit:", frame:GetAttribute("unit"), "HelpButton:", frame:GetAttribute("helpbutton"), "harmbutton:", frame:GetAttribute("harmbutton"))

end


function AutoBarGlobalCodeSpace.CacheSpellData(p_spell_id, p_spell_name)

	local name, _rank, icon = GetSpellInfo(p_spell_id);

	if (p_spell_id == 120145) then	-- Ancient Dalaran Port TODO: Generalize this
		icon = 628678;
	end

	if(name == nil) then
		AutoBarGlobalCodeSpace.LogWarning("Invalid Spell ID:" .. p_spell_id .. " : " .. (p_spell_name or "Unknown"));
	else
		AutoBarGlobalDataObject.spell_name_list[p_spell_name] = name;
		AutoBarGlobalDataObject.spell_icon_list[p_spell_name] = icon;
	end


end

function AutoBarGlobalCodeSpace.GetSpellNameByName(p_spell_name)

	if (AutoBarGlobalDataObject.spell_name_list[p_spell_name]) then
		return AutoBarGlobalDataObject.spell_name_list[p_spell_name]
	end

	AutoBarGlobalCodeSpace.LogWarning("Unknown Spell Name:" .. (p_spell_name or "nil"))

	return nil
end

function AutoBarGlobalCodeSpace.GetSpellIconByName(p_spell_name)

	if (AutoBarGlobalDataObject.spell_icon_list[p_spell_name]) then
		return AutoBarGlobalDataObject.spell_icon_list[p_spell_name]
	end

	AutoBarGlobalCodeSpace.LogWarning("Unknown Spell Name:" .. (p_spell_name or "nil"))

	return nil
end

function AutoBarGlobalCodeSpace.GetSpellIconByNameFast(p_spell_name)

	return AutoBarGlobalDataObject.spell_icon_list[p_spell_name]

end

local prof = AutoBarGlobalDataObject.profile
function AutoBarGlobalCodeSpace.AddProfileData(p_name, p_time)

	if(prof[p_name] == nil) then
		prof[p_name] = {}
		prof[p_name].calls = 0;
		prof[p_name].total_time = 0;
		prof[p_name].avg_time = 0;
		prof[p_name].min_time = 99999;
		prof[p_name].max_time = 0;
	end

	prof[p_name].calls = prof[p_name].calls + 1;
	prof[p_name].total_time = prof[p_name].total_time + p_time;
	if(prof[p_name].min_time > p_time) then
		prof[p_name].min_time = p_time;
	end;
	if(prof[p_name].max_time < p_time) then
		prof[p_name].max_time = p_time;
	end;
	prof[p_name].avg_time = prof[p_name].total_time / prof[p_name].calls

end


function AutoBarGlobalCodeSpace.FindNamelessCategories()

	local nameless = ""
	for key in pairs(AutoBarCategoryList) do
		if(AutoBarGlobalDataObject.locale[key] == nil) then
			nameless = nameless .. "|n" .. key
		end
	end

	return nameless
end

function AutoBarGlobalCodeSpace.FindNamelessButtons()

	local nameless = ""
	for key in pairs(AutoBar.Class) do
		if(AutoBarGlobalDataObject.locale[key] == nil) then
			nameless = nameless .. "|n" .. key
		end
	end

	return nameless
end

function AutoBarGlobalCodeSpace.GetNumQuestLogEntries()

	if (C_QuestLog and C_QuestLog.GetNumQuestLogEntries) then
		return C_QuestLog.GetNumQuestLogEntries()
	else
		return GetNumQuestLogEntries()
	end
end

-- Return the interface display name
function AutoBarGlobalCodeSpace.GetButtonDisplayName(p_button_db)
	local name

	if (p_button_db.name) then
		name = tostring(p_button_db.name)
	else
		local L = AutoBarGlobalDataObject.locale
		name = L[p_button_db.buttonKey] or L["Custom"]
	end
	return name
end


local logItems = {}	-- n = startTime
local logMemory = {}	-- n = startMemory
local event_name_colour = "|cFFFFFF7F"

function AutoBarGlobalCodeSpace.LogEvent(p_event_name, p_arg1)
	local memory
	if (AutoBar.db.account.logMemory) then
		UpdateAddOnMemoryUsage()
		memory = GetAddOnMemoryUsage("AutoBar")
		print(p_event_name, "memory" , memory)
	end
	if (AutoBar.db.account.logEvents) then
		if (p_arg1) then
			memory = memory or ""
			print(event_name_colour .. p_event_name .. "|r", "arg1" , p_arg1, "time:", GetTime(), memory)
		else
			print(event_name_colour .. p_event_name .. "|r", "time:", GetTime())
		end
	end
end

function AutoBarGlobalCodeSpace.LogEventStart(p_event_name)
	local memory

	if (AutoBar.db.account.logMemory) then
		UpdateAddOnMemoryUsage()
		memory = GetAddOnMemoryUsage("AutoBar")
		logMemory[p_event_name] = memory
	end

	if (AutoBar.db.account.performance) then
		if (logItems[p_event_name]) then
			--print(p_event_name, "restarted before previous completion")
		else
			logItems[p_event_name] = debugprofilestop()
			--print(p_event_name, "started time:", logItems[p_event_name])
		end
	end

	if (AutoBar.db.account.logEvents) then
			memory = memory or ""
			print(event_name_colour .. p_event_name .. "|r", "time:", debugprofilestop(), memory)
	end
end

function AutoBarGlobalCodeSpace.LogEventEnd(p_event_name, p_arg1)	--ToDo: There can actually be multiple args
	if (AutoBar.db.account.performance) then
		if (logItems[p_event_name]) then
			local elapsed = debugprofilestop() - logItems[p_event_name]
			-- if (p_event_name == "SPELLS_CHANGED") then
			-- 	print(p_event_name, p_arg1, elapsed, "=", debugprofilestop(), " - ", logItems[p_event_name])
			-- end
			if (elapsed > AutoBarDB2.performance_threshold) then
				print(event_name_colour .. p_event_name .. "|r", (p_arg1 or ""), "time:", elapsed)
			end
		--else
			--print(p_event_name, "restarted before previous completion")
			logItems[p_event_name] = nil
		end
	end
	if (AutoBar.db.account.logMemory) then
		UpdateAddOnMemoryUsage()
		local memory = GetAddOnMemoryUsage("AutoBar")
		local deltaMemory = memory - (logMemory[p_event_name] or 0)
		print(p_event_name, "memory" , deltaMemory)
		logMemory[p_event_name] = nil
	end
end

function AutoBarGlobalCodeSpace.GetCategoryDB(p_category_key)
	return AutoBarDB2.custom_categories[p_category_key]
end

function AutoBarGlobalCodeSpace.GetCategoryItemDB(p_category_key, p_item_index)
	return AutoBarDB2.custom_categories[p_category_key].items[p_item_index]
end


-------------------------------------------------------------------
--
-- WoW Classic
--
-------------------------------------------------------------------
if (AutoBarGlobalDataObject.is_vanilla_wow or AutoBarGlobalDataObject.is_bcc_wow) then

	function AutoBarGlobalCodeSpace.InfoFromGUID(p_guid)
		return AutoBarSearch.macro_text[p_guid];
	end

	function AutoBarGlobalCodeSpace.PlayerHasToy(_p_item_id)
		return false;
	end

	function AutoBarGlobalCodeSpace.GetSpellLink(p_spell, p_rank)
		local spell_link

		if(type(p_spell) == "string") then
			local spell_id = select(7, GetSpellInfo(p_spell))
			if(spell_id) then
				spell_link = "spell:" .. spell_id;
			end
		else
			spell_link = GetSpellLink(p_spell, p_rank)
			if spell_link == "" then
				spell_link = nil;
			end

		end

		return spell_link;

	end

elseif (AutoBarGlobalDataObject.is_mainline_wow) then
-------------------------------------------------------------------
--
-- WoW Retail
--
-------------------------------------------------------------------

	--This should query a global guid registry and then the specific ones if not found.
	function AutoBarGlobalCodeSpace.InfoFromGUID(p_guid)
		return AutoBarSearch.macro_text[p_guid] or AutoBarSearch.toys[p_guid];
	end

	function AutoBarGlobalCodeSpace.PlayerHasToy(p_item_id)
		return PlayerHasToy(p_item_id);
	end

	function AutoBarGlobalCodeSpace.GetSpellLink(p_spell, p_rank)
		local spell = GetSpellLink(p_spell, p_rank)

		if spell == "" then
			spell = nil;
		end

		return spell;

	end


end

