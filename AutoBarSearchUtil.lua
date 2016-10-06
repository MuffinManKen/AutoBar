

--These 2 maps are a bi-directional map, so you can find the location of an item by it's ID
-- or an ID by it's location
-- It tracks items, spells, and macros (and soon toys)
AutoBarGlobalDataObject.LocationToIDMap = {}
AutoBarGlobalDataObject.IDToLocationMap = {}

--local aliases for shorter typing
local LocationToIDMap = AutoBarGlobalDataObject.LocationToIDMap
local IDToLocationMap = AutoBarGlobalDataObject.IDToLocationMap

local function initialize_maps()

	LocationToIDMap.bags = {}
	for bag = 0, 4, 1 do
		LocationToIDMap.bags[bag] = {}
	end

	LocationToIDMap.inventory = {}
	LocationToIDMap.spells = {}
	LocationToIDMap.toys = {}


end

function AutoBarGlobalCodeSpace.Search_AddSpell(p_spell_id, p_spell_name)

	LocationToIDMap.spells[p_spell_name] = p_spell_id

--TODO: AutoBarSearch.found:Add(itemId, bag, slot, spell)

end

function AutoBarGlobalCodeSpace.Search_AddInventoryItem(p_item_id, p_slot)

	LocationToIDMap.inventory[p_slot] = p_item_id

--TODO: AutoBarSearch.found:Add(itemId, bag, slot, spell)

end

function AutoBarGlobalCodeSpace.Search_AddBagItem(p_item_id, p_bag, p_slot)

	local bag = LocationToIDMap.bags[p_bag]
	bag[p_slot] = p_item_id

--TODO: AutoBarSearch.found:Add(itemId, bag, slot, spell)

end
