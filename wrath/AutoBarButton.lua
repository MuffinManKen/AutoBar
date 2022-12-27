--
-- AutoBarButton
-- Copyright 2007+ Toadkiller of Proudmoore.
--
-- Buttons for AutoBar
-- http://muffinmangames.com
--

--local _, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

local AutoBar = AutoBar
local AutoBarSearch = AutoBarSearch  --TODO: This shouldn't be a global at all

local ABGCode = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject
local spellIconList = ABGData.spell_icon_list

local AceOO = MMGHACKAceLibrary("AceOO-2.0")
local L = AutoBarGlobalDataObject.locale

local reverse_sort_func = function( a,b ) return a > b end
local forward_sort_func = function( a,b ) return a < b end


local AutoBarButtonAquatic = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonAquatic"] = AutoBarButtonAquatic

function AutoBarButtonAquatic.prototype:init(parentBar, buttonDB)
	AutoBarButtonAquatic.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.AquaticForm")

end

local AutoBarButtonTrack = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonTrack"] = AutoBarButtonTrack

function AutoBarButtonTrack.prototype:init(parentBar, buttonDB)
	AutoBarButtonTrack.super.prototype.init(self, parentBar, buttonDB)

	self:AddCategory("Spell.Track")
end





local AutoBarButtonMount = AceOO.Class(AutoBarButton)
AutoBar.Class["AutoBarButtonMount"] = AutoBarButtonMount

function AutoBarButtonMount.prototype:init(parentBar, buttonDB)
	AutoBarButtonMount.super.prototype.init(self, parentBar, buttonDB)
--print("AutoBarButtonMount.prototype:init");

	local buttonData = AutoBar.char.buttonDataList[buttonDB.buttonKey]
	if (not buttonData) then
		buttonData = {}
		AutoBar.char.buttonDataList[buttonDB.buttonKey] = buttonData
	end

	if(buttonDB.mount_show_qiraji == nil) then buttonDB.mount_show_qiraji = false end
	if(buttonDB.mount_show_favourites == nil) then buttonDB.mount_show_favourites = true end
	if(buttonDB.mount_show_nonfavourites == nil) then buttonDB.mount_show_nonfavourites = false end
	if(buttonDB.mount_show_class == nil) then buttonDB.mount_show_class = true end
	if(buttonDB.mount_reverse_sort == nil) then buttonDB.mount_reverse_sort = false end
	if(buttonDB.mount_show_rng_fave == nil) then buttonDB.mount_show_rng_fave = false end


	if(buttonDB.mount_show_class == true) then
		self:AddCategory("Misc.Mount.Summoned")
	end

	if(buttonDB.mount_show_rng_fave == true) then
		self:AddCategory("Macro.Mount.SummonRandomFave")
	end

	self:AddCategory("Spell.Mount")

end

function AutoBarButtonMount.prototype:Refresh(parentBar, buttonDB, updateMount)
	AutoBarButtonMount.super.prototype.Refresh(self, parentBar, buttonDB)

	if (not AutoBarCategoryList["Spell.Mount"]) then
		--AutoBarButtonMount.prototype:init hasn't run, so skip
		--print("Skipping AutoBarButtonMount.prototype:Refresh  UpdateMount:" .. tostring(updateMount));
		return true;
	end

	local thisIsSpam = true
	local category = AutoBarCategoryList["Spell.Mount"]

	AutoBar.last_mount_count = AutoBar.last_mount_count or 0;


	local num_mounts = GetNumCompanions("MOUNT");
	local needs_update = (num_mounts ~= AutoBar.last_mount_count) or buttonDB.is_dirty

--print("NumMounts:" .. num_mounts .. " UpdateMount:" .. tostring(updateMount) .. "  Last Count:" .. AutoBar.last_mount_count, "Dirty:", buttonDB.is_dirty, "NeedsUpdate:", needs_update)
--print(debugstack(1, 3, 3));

	--If the number of known mounts has changed, do stuff
	if (needs_update) then
--print("   Gonna do stuff");
		AutoBar.last_mount_count = num_mounts;
		buttonDB.is_dirty = false

		category.castList = {}

		thisIsSpam = category.initialized --or (# category.castList ~= count)

		for idx = 1, num_mounts do
			local _creature_id, name, spell_id, icon, _is_summoned, _mount_type = GetCompanionInfo("MOUNT", idx)
			--print(creature_id, creature_name, creature_spell_id, icon, is_summoned, mount_type)

			local spell_name = GetSpellInfo(spell_id)
			--print("Name:", name, "SpellName:", spell_name, "SpellID:", spell_id);
			if not spell_name then print("AutoBar Error: Missing spell name for", spell_id, name); end
			spellIconList[spell_name] = icon
			AutoBarSearch:RegisterSpell(spell_name, spell_id, true)
			local spellInfo = AutoBarSearch.GetRegisteredSpellInfo(spell_name)
			spellInfo.spell_link = "spell:" .. spell_id		--TODO: This shouldn't be necessary. Test to see if RegisterSpell isn't giving a good link
			category.castList[# category.castList + 1] = spell_name

		end

		if(buttonDB.mount_reverse_sort) then
			table.sort(category.castList, forward_sort_func)
		else
			table.sort(category.castList, reverse_sort_func)
		end


		category.initialized = true

		AutoBarCategoryList["Spell.Mount"]:Refresh()
	end

	return thisIsSpam
end



function AutoBarButtonMount.prototype:AddOptions(optionList, passValue)
	self:SetOptionBoolean(optionList, passValue, "mount_show_qiraji", L["MountShowQiraji"])
	self:SetOptionBoolean(optionList, passValue, "mount_show_favourites", L["MountShowFavourites"])
	self:SetOptionBoolean(optionList, passValue, "mount_show_nonfavourites", L["MountShowNonFavourites"])
	self:SetOptionBoolean(optionList, passValue, "mount_show_class", L["MountShowClass"])
	self:SetOptionBoolean(optionList, passValue, "mount_reverse_sort", L["MountReverseSort"])
	self:SetOptionBoolean(optionList, passValue, "mount_show_rng_fave", L["MountShowSummonRandom"])
end


--[[
/dump GetSpellInfo(43688)
/dump GetSpellInfo("Amani War Bear")
/dump AutoBarCategoryList["Spell.Mount"]
/script AutoBarSearch.sorted:Update("AutoBarButtonMount")
/dump AutoBarSearch.sorted:GetList("AutoBarButtonMount")
--]]

--- Temporary until Blizzard makes their code work for mounts & critters
function AutoBarButtonMount.prototype:UpdateUsable()
	local frame = self.frame
	local itemType = frame:GetAttribute("type")
	if (itemType) then
		if (AutoBar.inCombat) then
			frame.icon:SetVertexColor(0.4, 0.4, 0.4)
		else
			frame.icon:SetVertexColor(1.0, 1.0, 1.0)
			frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)
		end

		local popupHeader = self.frame.popupHeader
		if (popupHeader) then
			for _, popupButton in pairs(popupHeader.popupButtonList) do
				frame = popupButton.frame
				if (AutoBar.inCombat) then
					frame.icon:SetVertexColor(0.4, 0.4, 0.4)
				else
					frame.icon:SetVertexColor(1.0, 1.0, 1.0)
					frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)
				end
			end
		end
	end
end
