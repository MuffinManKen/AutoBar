
-- Separate tables for code and data. Splitting the code off from the data makes it easier to inspect data objects.
-- The names are verbose to reduce likelihood of conflict with another addon

-- All global data will be a child of this table
AutoBarGlobalDataObject = {
	TYPE_MACRO_TEXT = 1,
	TYPE_TOY = 2,
	TYPE_BATTLE_PET = 3,
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
		_,_,_,_,_,_,_,_,_, texture = GetItemInfo(item_id)
	end

	return texture;
end


