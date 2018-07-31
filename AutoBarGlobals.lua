
-- Separate tables for code and data. Splitting the code off from the data makes it easier to inspect data objects.
-- The names are verbose to reduce likelihood of conflict with another addon

local _, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

-- All global data will be a child of this table
AutoBarGlobalDataObject = {
	TYPE_MACRO_TEXT = 1,
	TYPE_TOY = 2,
	TYPE_BATTLE_PET = 3,

	locale = {},

	timing = {},
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

	FullScanItemsFlag = true,

	ScheduledUpdate = nil,

	OtherStickyFrames = {
		"GridLayoutFrame",
	}
}


-- All global code with be a child of this table.  
AutoBarGlobalCodeSpace = {}


function AutoBarGlobalCodeSpace:ToyGUID(p_toy_id)

	local l = 7 - string.len(p_toy_id);
	local guid = "toy:" .. string.rep("0", l) .. p_toy_id;

	return guid;
end

function AutoBarGlobalCodeSpace:BPetGUID(p_bpet_id)

	local guid = "toy:" .. p_bpet_id;

	return guid;
end

local macro_text_guid_index = 0;
function AutoBarGlobalCodeSpace:MacroTextGUID(p_macro_text)

	macro_text_guid_index = macro_text_guid_index + 1
	local guid = "macrotext:" .. macro_text_guid_index;

	return guid;
end


--This should query a global guid registry and then the specific ones if not found. 
function AutoBarGlobalCodeSpace:InfoFromGUID(p_guid)
	return AutoBarSearch.macro_text[p_guid] or AutoBarSearch.toys[p_guid];
end

function AutoBarGlobalCodeSpace:GetIconForToyID(p_toy_id)
	local texture;
	local item_id = tonumber(p_toy_id)
	
	_, _, texture =  C_ToyBox.GetToyInfo(item_id)

	if(texture == nil) then
		texture = AutoBarGlobalCodeSpace:GetIconForItemID(item_id);
	end

	return texture;
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

	local is_usable, not_enough_mana = IsUsableItem(p_item_id);

	is_usable_item_cache[p_item_id] = is_usable or is_usable_item_cache[p_item_id] or usable_items_override_set[p_item_id];

	return is_usable_item_cache[p_item_id], not_enough_mana;
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
		AutoBar:LogWarning("Invalid Spell ID:" .. p_spell_id .. " : " .. (p_spell_name or "Unknown"));
	else
		AutoBarGlobalDataObject.spell_name_list[p_spell_name] = name;
		AutoBarGlobalDataObject.spell_icon_list[p_spell_name] = icon;
	end
	

end

function AutoBarGlobalCodeSpace:GetSpellNameByName(p_spell_name)

	if (AutoBarGlobalDataObject.spell_name_list[p_spell_name]) then
		return AutoBarGlobalDataObject.spell_name_list[p_spell_name]
	end

	AutoBar:LogWarning("Unknown Spell Name:" .. (p_spell_name or "nil"))

	return nil
end

function AutoBarGlobalCodeSpace:GetSpellIconByName(p_spell_name)

	if (AutoBarGlobalDataObject.spell_icon_list[p_spell_name]) then
		return AutoBarGlobalDataObject.spell_icon_list[p_spell_name]
	end

	AutoBar:LogWarning("Unknown Spell Name:" .. (p_spell_name or "nil"))

	return nil
end

function AutoBarGlobalCodeSpace:GetSpellIconByNameFast(p_spell_name)

	return AutoBarGlobalDataObject.spell_icon_list[p_spell_name]

end