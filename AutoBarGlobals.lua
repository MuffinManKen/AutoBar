
-- Separate tables for code and data. Splitting the code off from the data makes it easier to inspect data objects.
-- The names are verbose to reduce likelihood of conflict with another addon

-- All global data will be a child of this table
AutoBarGlobalDataObject = {
	TYPE_MACRO_TEXT = 1,
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
