
-- Separate tables for code and data. Splitting the code off from the data makes it easier to inspect data objects.
-- The names are verbose to reduce likelihood of conflict with another addon

local _, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

AutoBar = AceLibrary("AceAddon-2.0"):new("AceDB-2.0");
AutoBar.warning_log = {}

-- All global data will be a child of this table
AutoBarGlobalDataObject = {
	TYPE_MACRO_TEXT = 1,

	locale = {},

	timing = {},

	profile = {}
}


-- List of [spellName] = <GetSpellInfo Name>
AutoBarGlobalDataObject.spell_name_list = {}
-- List of [spellName] = <GetSpellInfo Icon>
AutoBarGlobalDataObject.spell_icon_list = {}

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
	}
}


-- All global code with be a child of this table.  
AutoBarGlobalCodeSpace = {}

local function table_pack(...)
  return { n = select("#", ...), ... }
end

function AutoBarGlobalCodeSpace:LogWarning(...)

	local message = "";
	local args = table_pack(...)
	for i=1,args.n do
		message = message .. tostring(args[i]) .. " "
	end
	table.insert(AutoBar.warning_log, message)

end

function AutoBarGlobalCodeSpace:GetWarningLogString()

	return table.concat(AutoBar.warning_log, "\n")

end


local macro_text_guid_index = 0;
function AutoBarGlobalCodeSpace:MacroTextGUID(p_macro_text)

	macro_text_guid_index = macro_text_guid_index + 1
	local guid = "macrotext:" .. macro_text_guid_index;

	return guid;
end


--This should query a global guid registry and then the specific ones if not found. 
function AutoBarGlobalCodeSpace:InfoFromGUID(p_guid)
	return AutoBarSearch.macro_text[p_guid];
end

function AutoBarGlobalCodeSpace:GetIconForItemID(p_item_id)
	local i_texture, ii_texture, _;
	_,_,_,_,_,_,_,_,_, texture = GetItemInfo(p_item_id)

	_, _, _, _, ii_texture, _, _ = GetItemInfoInstant(p_item_id)

	return ii_texture or texture;
end

function AutoBarGlobalCodeSpace:MakeSet(list)
   local set = {}
   for _, l in ipairs(list) do set[l] = true end
   return set
 end


local usable_items_override_set = AutoBarGlobalCodeSpace:MakeSet{
122484,	--Blackrock foundry spoils
71715,	--A Treatise on Strategy
113258,  --Blingtron 5000 Gift package
132892,  --Blingtron 6000 Gift package

150924, -- Greater Tribute of the Broken Isles

118529, -- Cache of Highmaul Treasures
}

local is_usable_item_cache = {}

function AutoBarGlobalCodeSpace:IsUsableItem(p_item_id)

	if(p_item_id == nil) then
		return nil;
	end

	return true;

--	local is_usable, not_enough_mana = IsUsableItem(p_item_id);

--	is_usable_item_cache[p_item_id] = is_usable or is_usable_item_cache[p_item_id] or usable_items_override_set[p_item_id];

--	return is_usable_item_cache[p_item_id], not_enough_mana;
end


--/run AutoBarGlobalCodeSpace:FrameInsp(ActionButton3)
function AutoBarGlobalCodeSpace:FrameInsp(p_frame) --AutoBarButtonExplosiveFrame

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


function AutoBarGlobalCodeSpace:CacheSpellData(p_spell_id, p_spell_name)

	local name, rank, icon = GetSpellInfo(p_spell_id);

	if(name == nil) then
		AutoBarGlobalCodeSpace:LogWarning("Invalid Spell ID:" .. p_spell_id .. " : " .. (p_spell_name or "Unknown"));
	else
		AutoBarGlobalDataObject.spell_name_list[p_spell_name] = name;
		AutoBarGlobalDataObject.spell_icon_list[p_spell_name] = icon;
	end
	

end

function AutoBarGlobalCodeSpace:GetSpellNameByName(p_spell_name)

	if (AutoBarGlobalDataObject.spell_name_list[p_spell_name]) then
		return AutoBarGlobalDataObject.spell_name_list[p_spell_name]
	end

	AutoBarGlobalCodeSpace:LogWarning("Unknown Spell Name:" .. (p_spell_name or "nil"))

	return nil
end

function AutoBarGlobalCodeSpace:GetSpellIconByName(p_spell_name)

	if (AutoBarGlobalDataObject.spell_icon_list[p_spell_name]) then
		return AutoBarGlobalDataObject.spell_icon_list[p_spell_name]
	end

	AutoBarGlobalCodeSpace:LogWarning("Unknown Spell Name:" .. (p_spell_name or "nil"))

	return nil
end

function AutoBarGlobalCodeSpace:GetSpellIconByNameFast(p_spell_name)

	return AutoBarGlobalDataObject.spell_icon_list[p_spell_name]

end

local prof = AutoBarGlobalDataObject.profile
function AutoBarGlobalCodeSpace:AddProfileData(p_name, p_time)

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
	if(prof[p_name].min_time > p_time) then prof[p_name].min_time = p_time; end;
	if(prof[p_name].max_time < p_time) then prof[p_name].max_time = p_time; end;
	prof[p_name].avg_time = prof[p_name].total_time / prof[p_name].calls


end




