---@diagnostic disable: unused-local
---@meta


--#region Global Constants
---@type integer
LE_EXPANSION_WRATH_OF_THE_LICH_KING = 2

---@type integer
LE_EXPANSION_LEVEL_CURRENT = 99

---@type integer
WOW_PROJECT_WRATH_CLASSIC = 11

---@type integer
LE_MOUNT_JOURNAL_FILTER_COLLECTED = -1
LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED = -1
LE_MOUNT_JOURNAL_FILTER_UNUSABLE = -1


NUM_BAG_SLOTS = -1  ---@type integer

INVSLOT_FIRST_EQUIPPED = 1
INVSLOT_LAST_EQUIPPED = 19

--defined in BlizzardInterfaceCode\Interface\FrameXML\ActionButton.lua
---@type number
ATTACK_BUTTON_FLASH_TIME = 0.4
--#endregion Global Constants

--#region Global Strings
OKAY = "Okay"
KEY_BINDINGS = ""
KEY_BUTTON3 = ""
KEY_BACKSPACE = ""
KEY_SPACE = ""
KEY_DELETE = ""
KEY_HOME = ""
KEY_END = ""
KEY_INSERT = ""
KEY_PAGEUP = ""
KEY_PAGEDOWN = ""
KEY_DOWN = ""
KEY_UP = ""
KEY_LEFT = ""
KEY_RIGHT = ""
INVTYPE_TRINKET  = ""
--#endregion Global Strings


---@type Frame
PetActionBarFrame = {}

---@type FontObject
GameFontNormal = nil




---@param n number|string|nil
---@param radix number?
---@return number
function tonumber(n, radix) end

---@param frame Frame
function InterfaceOptions_AddCategory(frame) end

---@param panel Frame|string
function InterfaceOptionsFrame_OpenToCategory(panel) end

---@param frame Frame
---@param start number
---@param duration number
---@param enable number
---@param forceShowDrawEdge boolean?
---@param modRate number?
---@return nil
function CooldownFrame_Set(frame, start, duration, enable, forceShowDrawEdge, modRate ) end


---@param command string
---@return string, string
function GetBindingKey(command) end

---@return string, string, string, number
function GetBuildInfo() end

---@param itemInfo number|string|nil
---@param includeBank? boolean
---@param includeUses? boolean
---@param includeReagentBank? boolean
---@return number count
function GetItemCount(itemInfo, includeBank, includeUses, includeReagentBank) end


---@param itemID number
---@return number, number, number
function GetItemCooldown(itemID) end

---@return string, number, string
function GetMacroInfo(name_or_slot) end

---@return number, number
function GetNumQuestLogEntries() end

---@return boolean
function InCombatLockdown() end

---@param ttl number
---@return nil
function RegisterAutoHide(frame, ttl) end



---@param state string
function RegisterStateDriver(frame, state, values) end


---@param state string
function UnregisterStateDriver(frame, state) end


---@param script string
---@param preBody string
---@param postBody string?
---@return nil
function SecureHandlerWrapScript(frame, script, header, preBody, postBody)
    return nil
end

---@param cursor string|nil
---@return boolean changed
function SetCursor(cursor) end

---@param containerIndex number
---@return number numSlots
function GetContainerNumSlots(containerIndex) end

---@param containerIndex number
---@param slotIndex number
---@return number containerID
function GetContainerItemID(containerIndex, slotIndex) end

---@param containerIndex number
---@param slotIndex number
---@return string itemLink
function GetContainerItemLink(containerIndex, slotIndex) end


---@class AB
AB = {}

function AB.ClearNormalTexture(frame) end

---@return boolean
function AB.NVL(p_1, p_2) end


--#region LibKeyBound
---@class LibKeyBound
---@field Binder table
local LibKeyBound = {}

---@param target table
---@param RegisterName string
---@param UnregisterName string?
---@param UnregisterAllName string?
function LibKeyBound.RegisterCallback(target, RegisterName, UnregisterName, UnregisterAllName) end

function LibKeyBound.Deactivate() end

function LibKeyBound:GetColorKeyBoundMode() end

---@param button table
function LibKeyBound:Set(button) end

function Toggle() end

---@param key string
---@return string
function LibKeyBound:ToShortKey(key) end

--#endregion LibKeyBound


--#region LibStickyFrames
---@class LibStickyFrames
local LibStickyFrames = {}

---@param target table
---@param RegisterName string
---@param UnregisterName string?
---@param UnregisterAllName string?
function LibStickyFrames.RegisterCallback(target, RegisterName, UnregisterName, UnregisterAllName) end


---@param frame Frame
function LibStickyFrames:RegisterFrame(frame) end

function LibStickyFrames.Deactivate() end

function LibStickyFrames.GetGroup() end

---@param x any?
function LibStickyFrames:SetGroup(x) end

function LibStickyFrames:SetFramePoints(frame, point, stickToFrame, stickToPoint, stickToX, stickToY) end

function LibStickyFrames:GetColorHidden() end

function LibStickyFrames:InFrameGroup(frame, group) end

function LibStickyFrames:SetFrameEnabled(frame, b) end
function LibStickyFrames:SetFrameHidden(frame, should_hide) end
function LibStickyFrames:SetFrameText(frame, barName) end

--#endregion LibStickyFrames


--#region LibPeriodicTable
---@class LibPeriodicTable
LibPeriodicTable = {}

---@param pt_set string
function LibPeriodicTable:GetSetTable(pt_set) end

---@param pt_set string
function LibPeriodicTable:IterateSet(pt_set) end
--#endregion LibPeriodicTable


---@class GameTooltip
GameTooltip = {}


--#region Frame
---@class Frame
Frame = {}
function Frame:ClearNormalTexture() end
function Frame:SetNormalTexture(p_tex) end

-- ---@param scriptType ScriptFrame
-- ---@param handler function|nil
-- function Frame:SetScript(scriptType, handler) end

--These are actually part of BackdropTemplateMixin
function Frame:SetBackdrop(backdropInfo) end
function Frame:SetBackdropColor(r, g, b, a) end
--#endregion Frame

--#region Masque
---@class Masque
local Masque = {}

---@param group_name string
---@param other_param any?
function Masque:Group(group_name, other_param) end


---@param button table
---@return table
function Masque:GetBackdrop(button) end

---@param button table
---@return table
function Masque:GetGloss(button) end
--#endregion Masque




--#region AceConfigRegistry
---@class AceConfigRegistry-3.0
local AceConfigRegistry = {}

function AceConfigRegistry:NotifyChange(name) end



--#endregion AceConfigRegistry


---@class AutoBarSettings
local AutoBarSettings = {
    ["show_empty_buttons"] = false,
    ["fade_out"] = false,
    ["log_memory"] = false,
    ["show_tooltip"] = true,
    ["throttle_event_limit"] = 0,
    ["log_throttled_events"] = false,
    ["show_hotkey"] = true,
    ["performance"] = false,
    ["log_events"] = false,
    ["handle_spell_changed"] = true,
    ["show_count"] = true,
    ["self_cast_right_click"] = true,
    ["clamp_bars_to_screen"] = true,
    ["performance_threshold"] = 100,
    ["hack_PetActionBarFrame"] = false,
    ["show_tooltip_in_combat"] = true,
}

---@class AutoBarDB2
---@field settings AutoBarSettings
---@field skin table
---@field ldb_icon table
---@field account table
---@field classes table
---@field chars table
AutoBarDB2 = {}


---@class ABSpellInfo
---@field can_cast boolean
---@field spell_link string
---@field no_spell_check boolean
---@field spell_id number
ABSpellInfo = {}

---@class ABToyInfo
---@field guid string
---@field item_id integer
---@field ab_type integer
---@field icon integer
---@field is_fave boolean
---@field name string
ABToyInfo = {}





AutoBarDB = {}
