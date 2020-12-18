std = "wowmmg"

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
function merge_tables(...)
	 result = {}
	 for i, t in ipairs{...} do
		 assert(type(t) == "table")
		 for k, v in pairs(t) do
			print(k,v)
			 if type(k) == "number" then
				 table.insert(result, v)
			 elseif type(v) == "table" then
				result[k] = deepcopy(v)
			 else
				result[k] = v
			 end
		 end
	 end
	 return result
 end

max_line_length = false
exclude_files = {
	".luacheckrc"
}
ignore = {
	"11./SLASH_.*", -- Setting an undefined (Slash handler) global variable
	--"11./BINDING_.*", -- Setting an undefined (Keybinding header) global variable
	--"113/LE_.*", -- Accessing an undefined (Lua ENUM type) global variable
	--"113/NUM_LE_.*", -- Accessing an undefined (Lua ENUM type) global variable
	--"211", -- Unused local variable
	--"211/L", -- Unused local variable "L"
	--"211/CL", -- Unused local variable "CL"
	--"212", -- Unused argument
	--"213", -- Unused loop variable
	-- "231", -- Set but never accessed
	--"311", -- Value assigned to a local variable is unused
	--"314", -- Value of a field in a table literal is unused
	--"42.", -- Shadowing a local variable, an argument, a loop variable.
	--"43.", -- Shadowing an upvalue, an upvalue argument, an upvalue loop variable.
	--"542", -- An empty if branch
	"211/_.*",
	"212/_.*",
	"213/_.*",


}

_checkbox_fields = {
	"Disable",
	"Enable",
	"SetChecked",
	"SetShown",
}

_text_fields = {
	"GetFontObject",
	"SetText",
	"SetTextColor",
}

read_globals = {

}


globals = {
	"_G",
	"SlashCmdList",

	"LibStub",

	--Autobar Globals
	"AutoBar",
	"AutoBarDB2",
	"AutoBarGlobalCodeSpace",
	"AutoBarGlobalDataObject",
	"AutoBarButton",
	"AutoBarCategory",
	"AutoBarCategoryList",
	"AutoBarItems",
	"AutoBarSpells",
	"AutoBarToyCategory",
	"AutoBarSearch",

	MUFFIN_WHATS_NEW_QUEUE = {
		fields = {
			"AddEntry",
			"body_text",
			"frame",
			"header_frame",
			"header_text",
			"ok_button",
			"q",
			"Show",
			"show_whats_new_internal",
			"StupidLog",
			"StupidLogLine",
			"version",
		}
	}
}
