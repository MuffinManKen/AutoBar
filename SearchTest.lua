-- Testing & Debug function only
function SearchSpace.prototype:Contains(id)
	for itemId, _clientButtons in pairs(self.dataList) do
		if (itemId == id) then
			if (not AutoBarSearch.trace) then
				AutoBar:Print("SearchSpace.prototype:Contains    itemId " .. tostring(itemId))
			end
			return true
		end
	end
	return false
end

-- Testing & Debug function only
function Items.prototype:Contains(id)
	for _buttonKey, buttonItems in pairs(self.dataList) do
		for itemId, _itemData in pairs(buttonItems) do
			if (itemId == id) then
				if (not AutoBarSearch.trace) then
					AutoBar:Print("Items.prototype:Contains    itemId " .. tostring(itemId))
				end
				return true
			end
		end
	end
	return false
end

-- Testing & Debug function only
function CStuff:Contains(id)
	local slotList
	local contains = nil
	for bag = 0, NUM_BAG_SLOTS, 1 do
		slotList = self.dataList[bag]
		for i, itemId in pairs(slotList) do
			if (itemId == id) then
				contains = true
				if (not AutoBarSearch.trace) then
					AutoBar:Print("Stuff.prototype:Contains    itemId " .. tostring(itemId).." at bag/slot " .. tostring(bag).." / " .. tostring(i))
				end
			end
		end
	end
	slotList = self.dataList.inventory
	for _i, itemId in pairs(slotList) do
		if (itemId == id) then
			contains = true
			if (not AutoBarSearch.trace) then
				AutoBar:Print("Stuff.prototype:Contains inventory    itemId " .. tostring(itemId))
			end
		end
	end
	slotList = self.spells
	for _i, itemId in pairs(slotList) do
		if (itemId == id) then
			contains = true
			if (not AutoBarSearch.trace) then
				AutoBar:Print("Stuff.prototype:Contains spells    itemId " .. tostring(itemId))
			end
		end
	end
	return contains
end

-- Testing & Debug function only
function Found.prototype:Contains(id, count)
	for itemId, itemData in pairs(self.dataList) do
		if (itemId == id) then
			if (not AutoBarSearch.trace) then
				AutoBar:Print("Found.prototype:Contains    itemId " .. tostring(itemId))
			end
			if (count) then
				local nItems = # itemData
				local found = 0
				local i = 1
				while (i <= nItems) do
					if (itemData[i] or itemData[i + 1] or itemData[i + 2]) then
						found = found + 1
					end
					i = i + 3
				end
				if (found == count) then
					return true
				else
					return false
				end
			end
			return true
		end
	end
	return false
end

-- Testing & Debug function only
function Current.prototype:Contains(id)
	for buttonKey, buttonItems in pairs(self.dataList) do
		for itemId, itemData in pairs(buttonItems) do
			if (itemId == id) then
				if (not AutoBarSearch.trace) then
					AutoBar:Print("Current.prototype:Contains    itemId " .. tostring(itemId).." at buttonKey " .. tostring(buttonKey))
				end
				return true
			end
		end
	end
	return false
end

-- Testing & Debug function only
function Sorted.prototype:Contains(itemId)
	for buttonKey, buttonItems in pairs(self.dataList) do
		for _i, sortedItemData in ipairs(buttonItems) do
			if (itemId == sortedItemData.itemId) then
				if (not AutoBarSearch.trace) then
					AutoBar:Print("Sorted.prototype:Contains    itemId " .. tostring(itemId).." at buttonKey " .. tostring(buttonKey))
				end
				return true
			end
		end
	end
	return false
end

-- Testing & Debug function only
function AutoBarSearch:Contains(itemId)
	if (not AutoBarSearch.trace) then
		AutoBar:Print("\n\n   AutoBarSearch:Contains: " .. tostring(itemId))
	end
	local contains = nil

	contains = contains or AutoBarSearch.space:Contains(itemId)
	contains = contains or AutoBarSearch.items:Contains(itemId)
	contains = contains or AutoBarSearch.sorted:Contains(itemId)
	contains = contains or AutoBarSearch.current:Contains(itemId)
	contains = contains or AutoBarSearch.found:Contains(itemId)
	contains = contains or AutoBarSearch.stuff:Contains(itemId)

	return contains
end

--[[
-- Testing & Debug function only
function AutoBarSearch:DumpSlot(buttonKey)
	print("\n\n   AutoBarSearch:DumpSlot " .. tostring(buttonKey))
	print("items ")
	dump(AutoBarSearch.items:GetList(buttonKey))
	print("current ")
	dump(AutoBarSearch.current:GetList(buttonKey))
	print("sorted ")
	dump(AutoBarSearch.sorted:GetList(buttonKey))
end


-- Test harness		/script AutoBarSearch:Test()

function AutoBarSearch:Test()
	if (true and true) then
		AutoBarSearch.trace = true
		print("\nAutoBarSearch:Test start")
		AutoBarSearch:Empty()
		AutoBar.playerLevel = UnitLevel("player")

		UpdateAddOnMemoryUsage()
		local usedKB = GetAddOnMemoryUsage("AutoBar")
		print("usedKB = " .. usedKB)

		AutoBarSearch.items:Add({4536}, 1, nil, 1)
		assert(AutoBarSearch.items:Contains(4536), "AutoBarSearch.items:Add failed")
		assert(AutoBarSearch.space:Contains(4536), "AutoBarSearch.space:Add failed")
		AutoBarSearch.items:Delete({4536}, 1, nil, 1)
		assert(not AutoBarSearch.items:Contains(4536), "AutoBarSearch.items:Delete failed")
		assert(not AutoBarSearch.space:Contains(4536), "AutoBarSearch.space:Delete failed")
		AutoBarSearch.items:Add({4536, 6948, 4757}, 1, nil, 1)
--		AutoBar:Print("\n\n Items Added [1]")
--		DevTools_Dump(AutoBarSearch.items:GetList(1))
		assert(AutoBarSearch.items:Contains(4536), "AutoBarSearch.items:Add {4536, 6948, 4757} failed")
		assert(AutoBarSearch.items:Contains(6948), "AutoBarSearch.items:Add {4536, 6948, 4757} failed")
		assert(AutoBarSearch.items:Contains(4757), "AutoBarSearch.items:Add {4536, 6948, 4757} failed")
		assert(AutoBarSearch.space:Contains(4536), "AutoBarSearch.space:Add {4536, 6948, 4757} failed")
		assert(AutoBarSearch.space:Contains(6948), "AutoBarSearch.space:Add {4536, 6948, 4757} failed")
		assert(AutoBarSearch.space:Contains(4757), "AutoBarSearch.space:Add {4536, 6948, 4757} failed")

		AutoBarSearch.items:Add({787, 2070, 159}, "AutoBarButtonQuest", nil, 2)
		assert(AutoBarSearch.items:Contains(787), "AutoBarSearch.items:Add {787, 2070, 159} failed")
		assert(AutoBarSearch.items:Contains(2070), "AutoBarSearch.items:Add {787, 2070, 159} failed")
		assert(AutoBarSearch.items:Contains(159), "AutoBarSearch.items:Add {787, 2070, 159} failed")
		assert(AutoBarSearch.space:Contains(787), "AutoBarSearch.space:Add {787, 2070, 159} failed")
		assert(AutoBarSearch.space:Contains(2070), "AutoBarSearch.space:Add {787, 2070, 159} failed")
		assert(AutoBarSearch.space:Contains(159), "AutoBarSearch.space:Add {787, 2070, 159} failed")

		AutoBarSearch.stuff:Add(6948, 0, 1)
		assert(AutoBarSearch.stuff:Contains(6948), "AutoBarSearch.stuff:Add 6948 failed")
		AutoBarSearch.stuff:Delete(6948, 0, 1)
		assert(not AutoBarSearch.stuff:Contains(6948), "AutoBarSearch.stuff:Delete 6948 failed")

		-- Add something not looked for
		AutoBarSearch.stuff:Add(2130, 0, 1)
		assert(AutoBarSearch.stuff:Contains(2130), "AutoBarSearch.stuff:Add 2130 failed")
		assert(AutoBarSearch.found:Contains(2130), "AutoBarSearch.found:Add 2130 failed")
		assert(not AutoBarSearch.current:Contains(2130), "AutoBarSearch.current 2130 incorectly added")
		assert(not AutoBarSearch.sorted:Contains(2130), "AutoBarSearch.current 2130 incorectly added")

		-- Add something looked for
		AutoBarSearch.stuff:Add(6948, 0, 2)
		assert(AutoBarSearch.stuff:Contains(6948), "AutoBarSearch.stuff:Add 6948 failed")
		assert(AutoBarSearch.found:Contains(6948), "AutoBarSearch.found:Add 6948 failed")
		assert(AutoBarSearch.current:Contains(6948), "AutoBarSearch.current 6948 failed")
		assert(AutoBarSearch.sorted:Contains(6948), "AutoBarSearch.current 6948 failed")

		AutoBarSearch.stuff:Add(2132, 0, 3)
		assert(AutoBarSearch.stuff:Contains(2132), "AutoBarSearch.stuff:Add 2132 failed")
		assert(AutoBarSearch.found:Contains(2132), "AutoBarSearch.found:Add 2132 failed")
		assert(not AutoBarSearch.current:Contains(2132), "AutoBarSearch.current 2132 incorectly added")
		assert(not AutoBarSearch.sorted:Contains(2132), "AutoBarSearch.current 2132 incorectly added")

		AutoBarSearch.stuff:Add(4536, 0, 4)
		assert(AutoBarSearch.stuff:Contains(4536), "AutoBarSearch.stuff:Add 4536 failed")
		assert(AutoBarSearch.found:Contains(4536), "AutoBarSearch.found:Add 4536 failed")
		assert(AutoBarSearch.current:Contains(4536), "AutoBarSearch.current 4536 failed")
		assert(AutoBarSearch.sorted:Contains(4536), "AutoBarSearch.current 4536 failed")

		-- Add something looked for
		AutoBarSearch.stuff:Add(2070, 4, 1)
		assert(AutoBarSearch.stuff:Contains(2070), "AutoBarSearch.stuff:Add 2070 failed")
		assert(AutoBarSearch.found:Contains(2070), "AutoBarSearch.found:Add 2070 failed")
		assert(AutoBarSearch.current:Contains(2070), "AutoBarSearch.current 2070 failed")
		assert(AutoBarSearch.sorted:Contains(2070), "AutoBarSearch.current 2070 failed")

		AutoBarSearch.stuff:Add(787, 4, 2)
		assert(AutoBarSearch.stuff:Contains(787), "AutoBarSearch.stuff:Add 787 failed")
		assert(AutoBarSearch.found:Contains(787), "AutoBarSearch.found:Add 787 failed")
		assert(AutoBarSearch.current:Contains(787), "AutoBarSearch.current 787 failed")
		assert(AutoBarSearch.sorted:Contains(787), "AutoBarSearch.current 787 failed")

		AutoBarSearch.stuff:Add(159, 4, 3)
		assert(AutoBarSearch.stuff:Contains(159), "AutoBarSearch.stuff:Add 159 failed")
		assert(AutoBarSearch.found:Contains(159), "AutoBarSearch.found:Add 159 failed")
		assert(AutoBarSearch.current:Contains(159), "AutoBarSearch.current 159 failed")
		assert(AutoBarSearch.sorted:Contains(159), "AutoBarSearch.current 159 failed")

		AutoBarSearch.stuff:Add(4757, 0, 5)
		assert(AutoBarSearch.found:Contains(4757), "AutoBarSearch.found:Add 4757 failed")
		assert(AutoBarSearch.found:Contains(4757, 1), "AutoBarSearch.found:Add 4757 failed")
		AutoBarSearch.stuff:Add(4757, 2, 5)
		assert(AutoBarSearch.found:Contains(4757, 2), "AutoBarSearch.found:Add 4757 failed")
		AutoBarSearch.stuff:Add(4757, 1, 5)
		assert(AutoBarSearch.found:Contains(4757, 3), "AutoBarSearch.found:Add 4757 failed")
		assert(AutoBarSearch.stuff:Contains(4757), "AutoBarSearch.stuff:Add 4757 3/3 failed")
		assert(AutoBarSearch.current:Contains(4757), "AutoBarSearch.current 4757 failed")
		assert(AutoBarSearch.sorted:Contains(4757), "AutoBarSearch.current 4757 failed")

		AutoBarSearch.sorted:Update()
		local sorted = AutoBarSearch.sorted:GetList(1)
		assert(sorted[1].itemId == 4757, "AutoBarSearch.sorted 4757 failed")
		assert(sorted[2].itemId == 6948, "AutoBarSearch.sorted 4757 failed")
		assert(sorted[3].itemId == 4536, "AutoBarSearch.sorted 4757 failed")

		sorted = AutoBarSearch.sorted:GetList("AutoBarButtonQuest")
		assert(sorted[1].itemId == 159, "AutoBarSearch.sorted 159 failed")
		assert(sorted[2].itemId == 2070, "AutoBarSearch.sorted 2070 failed")
		assert(sorted[3].itemId == 787, "AutoBarSearch.sorted 787 failed")

		AutoBarSearch.stuff:Delete(2130, 0, 1)
		AutoBarSearch.stuff:Delete(6948, 0, 2)
		AutoBarSearch.stuff:Delete(2132, 0, 3)
		AutoBarSearch.stuff:Delete(4536, 0, 4)
		assert(not AutoBarSearch.stuff:Contains(2130), "AutoBarSearch.stuff:Delete 2130 failed")
		assert(not AutoBarSearch.stuff:Contains(6948), "AutoBarSearch.stuff:Delete 6948 failed")
		assert(not AutoBarSearch.stuff:Contains(2132), "AutoBarSearch.stuff:Delete 2132 failed")
		assert(not AutoBarSearch.stuff:Contains(4536), "AutoBarSearch.stuff:Delete 4536 failed")

		AutoBarSearch.stuff:Delete(4757, 0, 5)
		assert(AutoBarSearch.found:Contains(4757, 2), "AutoBarSearch.found:Delete 4757 1/3 failed")
		assert(AutoBarSearch.stuff:Contains(4757), "AutoBarSearch.stuff:Delete 4757 1/3 failed")
		assert(AutoBarSearch.current:Contains(4757), "AutoBarSearch.current 4757 1/3 failed")
		assert(AutoBarSearch.sorted:Contains(4757), "AutoBarSearch.current 4757 1/3 failed")
		AutoBarSearch.stuff:Delete(4757, 1, 5)
		assert(AutoBarSearch.found:Contains(4757, 1), "AutoBarSearch.found:Delete 4757 2/3 failed")
		assert(AutoBarSearch.stuff:Contains(4757), "AutoBarSearch.stuff:Delete 4757 2/3 failed")
		assert(AutoBarSearch.current:Contains(4757), "AutoBarSearch.current 4757 2/3 failed")
		assert(AutoBarSearch.sorted:Contains(4757), "AutoBarSearch.current 4757 2/3 failed")
		AutoBarSearch.stuff:Delete(4757, 2, 5)
		assert(not AutoBarSearch.found:Contains(4757), "AutoBarSearch.found:Delete 4757 3/3 failed")
		assert(not AutoBarSearch.stuff:Contains(4757), "AutoBarSearch.stuff:Delete 4757 3/3 failed")
		assert(not AutoBarSearch.current:Contains(4757), "AutoBarSearch.current 4757 3/3 failed")
		assert(not AutoBarSearch.sorted:Contains(4757), "AutoBarSearch.current 4757 3/3 failed")

		AutoBarSearch.items:Delete({4757}, 1, nil, 1)
		assert(not AutoBarSearch.items:Contains(4757), "AutoBarSearch.items:Delete 4757 failed")
		assert(not AutoBarSearch.space:Contains(4757), "AutoBarSearch.space:Delete 4757 failed")
		AutoBarSearch.items:Add({4757}, 1, nil, 1)
		AutoBarSearch.items:Delete({4536, 4757, 6948}, 1, nil, 1)
		assert(not AutoBarSearch.items:Contains(4757), "AutoBarSearch.items:Delete {4536, 6948, 4757} failed")
		assert(not AutoBarSearch.items:Contains(4536), "AutoBarSearch.items:Delete {4536, 6948, 4757} failed")
		assert(not AutoBarSearch.items:Contains(6948), "AutoBarSearch.items:Delete {4536, 6948, 4757} failed")
		assert(not AutoBarSearch.space:Contains(4757), "AutoBarSearch.space:Delete {4536, 6948, 4757} failed")
		assert(not AutoBarSearch.space:Contains(4536), "AutoBarSearch.space:Delete {4536, 6948, 4757} failed")
		assert(not AutoBarSearch.space:Contains(6948), "AutoBarSearch.space:Delete {4536, 6948, 4757} failed")

--		AutoBarSearch.items:Populate()
--		AutoBar:Print("\n\n SearchSpace")
--		DevTools_Dump(AutoBarSearch.space:GetList())

--		AutoBarSearch.items:Add({BS["Conjure Food"]}, 24, nil, 1)
--		AutoBarSearch.stuff:ScanSpells()
--		AutoBar:Print("\n\n SearchSpace")
--		DevTools_Dump(AutoBarSearch.space:GetList())

--		local bag0, bag1, bag2, bag3, bag4 = true, true, true, true, true
--		AutoBarSearch.stuff:Scan(bag0, bag1, bag2, bag3, bag4)

--		AutoBar:Print("\n\n Stuff")
--		DevTools_Dump(AutoBarSearch.stuff:GetList())
--
--		AutoBar:Print("\n\n Found")
--		DevTools_Dump(AutoBarSearch.found:GetList())
--
--		AutoBar:Print("\n\n Current")
--		DevTools_Dump(AutoBarSearch.current:GetList(1))
--
--		AutoBarSearch.sorted:Update()
--		AutoBar:Print("\n\n Sorted")
--		DevTools_Dump(AutoBarSearch.sorted:GetList())

		AutoBar:Print("AutoBarSearch:Test successful")
		AutoBarSearch:Reset()
		UpdateAddOnMemoryUsage()
		usedKB = GetAddOnMemoryUsage("AutoBar")
		AutoBar:Print("usedKB = " .. usedKB)
	end
end
--]]

--[[
/script AutoBarSearch:DumpSlot("AutoBarButtonMount")
/script AutoBarSearch:Contains("Travel Form")
/dump (AutoBarSearch.sorted:GetList("CustomButton33"))
/dump (AutoBarSearch.sorted:GetList("AutoBarButtonCooldownPotionMana"))
/dump (AutoBarSearch.sorted:Update("AutoBarButtonCooldownPotionMana"))
/dump AutoBarSearch.space:GetList()
/dump (AutoBarSearch.sorted:GetList())
/dump (AutoBarSearch.sorted:GetList("Custom1"))
/dump (AutoBarSearch.found:GetList()[28104])
/dump (AutoBarSearch.stuff:GetList())
/dump (AutoBarCategoryList["Spell.Portals"])
/dump (AutoBarSearch.registered_spells)
/script AutoBarSearch:Empty()
/script AutoBarSearch:Reset()
--]]