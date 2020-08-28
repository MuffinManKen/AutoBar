std = "lua51"

package.path = package.path .. ";..\\WoWLuaCheckrc\\?.lua"

wow_global_constants = require("wow_global_constants")

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

	--THIS IS JUST TEMPORARY!!!!!!!!!!!!!!!!!
	"21/FIZ_.*",
	"11/FIZ_.*",
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

	--WoW API
	"CollapseFactionHeader",
	"CompleteQuest",
	"CreateFrame",
	"ExpandFactionHeader",
	"FactionToggleAtWar",
	"GetAddOnMetadata",
	"GetContainerItemInfo",
	"GetContainerItemLink",
	"GetContainerNumSlots",
	"GetFactionInfo",
	"GetFactionInfoByID",
	"GetFriendshipReputation",
	"GetGossipAvailableQuests",
	"GetGuildInfo",
	"GetItemCount",
	"GetItemInfo",
	"GetItemInfoInstant",
	"GetLFGBonusFactionID",
	"GetNumFactions",
	"GetNumGossipAvailableQuests",
	"GetNumQuestLogEntries",
	"GetProfessionInfo",
	"GetProfessions",
	"GetQuestLogIndexByID",
	"GetQuestLogTitle",
	"GetQuestLogQuestText",
	"GetQuestObjectiveInfo",
	"GetQuestReward",
	"GetRealmName",
	"GetSelectedFaction",
	"GetSpellInfo",
	"GetText",
	"InCombatLockdown",
	"IsFactionInactive",
	"IsInGuild",
	"IsQuestCompletable",
	"PlaySound",
	"SelectGossipAvailableQuest",
	"SetFactionActive",
	"SetFactionInactive",
	"SetWatchedFactionIndex",
	"UnitBuff",
	"UnitClass",
	"UnitFactionGroup",
	"UnitGUID",
	"UnitName",
	"UnitRace",
	"UnitSex",

	--FrameXML
	"AchievementFrame_LoadUI",
	"AlertFrame_PauseOutAnimation",
	"AlertFrame_ResumeOutAnimation",
	"AchievementAlertFrame_SetUp",
	"BreakUpLargeNumbers",
	"CharacterFrame",
	"ChatFrame_AddMessageEventFilter",
	"Clamp",
	"CloseDropDownMenus",
	"FauxScrollFrame_GetOffset",
	"FauxScrollFrame_Update",
	"FormatLargeNumber",
	"GameTooltip_AddQuestRewardsToTooltip",
	"GameTooltip_Hide",
	"GameTooltip_SetDefaultAnchor",
	"HideUIPanel",
	"HideParentPanel",
	"ReputationFrame_Update",
	"ReputationFrameStandingLabel",
	"ToggleCharacter",
	"ToggleDropDownMenu",
	"UIDropDownMenu_AddButton",
	"WorldMap_AddQuestTimeToTooltip",

	--WoW-specific lua functions
	"ceil",
	"debugprofilestop",
	"debugstack",
	"floor",
	"format",
	"gsub",
	"hooksecurefunc",
	"strrep",
	"strsplit",
	"strsub",
	"tinsert",
	"wipe",
	bit = {
		fields = {
			"band",
		},
	},

	GameFontNormal = {
		fields = {
			"GetFont",
		}
	},

	ReputationDetailFactionName = {
		fields = _text_fields
	},

	ReputationDetailFactionDescription = {
		fields = _text_fields
	},

	ReputationDetailAtWarCheckBox = {
		fields = _checkbox_fields
	},

	ReputationDetailAtWarCheckBoxText = {
		fields = _text_fields
	}, 

	ReputationDetailInactiveCheckBoxText = {
		fields = _text_fields
	},

	ReputationDetailLFGBonusReputationCheckBox = {
		fields = merge_tables( _checkbox_fields, {
			factionID = { read_only = false},
		})
	},


	ReputationDetailMainScreenCheckBox = {
		fields = _checkbox_fields
	},

	ReputationDetailInactiveCheckBox = {
		fields = _checkbox_fields
	},

	AchievementFrame = {},
	AlertFrame = {
		fields = {
			"AddQueuedAlertFrameSubSystem",
		}
	},

	--C_AzeriteItem
	C_AzeriteItem = {
		fields = {
			"FindActiveAzeriteItem",
			"GetAzeriteItemXPInfo",
			"GetPowerLevel",
		}
	},

	--C_Item
	C_Item = {
		fields = {
			"RequestLoadItemDataByID",
		}
	},

	--C_Reputation
	C_Reputation = {
		fields = {
			"GetFactionParagonInfo",
			"IsFactionParagon",
			"RequestFactionParagonPreloadRewardData",
		}
	},
	
	--C_Map
	C_Map = {
		fields = {
			"GetAreaInfo",
			"GetMapInfo",
		}
	},	
	--C_Timer
	C_Timer = {
		fields = {
			"After",
		}
	},

	--C_QuestLog
	C_QuestLog = {
		fields = {
			"GetQuestInfo",
			"GetQuestObjectives",
			"IsOnQuest",
		}
	},

	--C_TaskQuest
	C_TaskQuest = {
		fields = {
			"GetQuestInfoByQuestID",
		}
	},

	-- Item
	Item = {
		fields = {
			"CreateFromItemLocation",
		}
	},

	--StatusTrackingBarManager
	StatusTrackingBarManager = {
		fields = {
			"UpdateBarsShown",
		}
	},

	--ReputationFrame
	ReputationFrame = {
		fields = {
			"IsVisible",
			"paragonFramesPool",
		}
	},
	--ReputationDetailFrame
	ReputationDetailFrame = {
		fields = {
			"Hide",
			"IsShown",
			"IsVisible",
			"SetHeight",
			"Show",
		}
	},

	--ReputationListScrollFrame
	ReputationListScrollFrame = {
		fields = {
			
		}
	},
	--ReputationListScrollFrameScrollBar
	ReputationListScrollFrameScrollBar = {
		fields = {
			"SetValue",
		}
	},
	--ReputationFrameStandingLabel
	ReputationFrameStandingLabel = {
		fields = _text_fields
	},

	--SOUNDKIT
	SOUNDKIT = {
		fields = {
			"IG_MAINMENU_OPTION_CHECKBOX_OFF",
			"IG_MAINMENU_OPTION_CHECKBOX_ON",
			"GS_TITLE_OPTION_OK",
			"U_CHAT_SCROLL_BUTTON",
		}
	},

	GameTooltip = {
		fields = {
			"AddLine",
			"AddDoubleLine",
			"GetBackdrop",
			"Hide",
			"HookScript",
			"SetBackdrop",
			"SetBackdropColor",
			"SetMinimumWidth",
			"SetOwner",
			"SetText",
			"Show",
		}
	},

	--WorldMapTooltip
	WorldMapTooltip = {
		fields = {
			"AddLine",
			"ClearLines",
			"SetText",
			"Show",
		}
	},

	--ItemRefTooltip
	ItemRefTooltip = {
		fields = {
		}
	},

	--WorldMapFrame
	WorldMapFrame =  {
		fields = {
			"overlayFrames",
		}
	},

}

print("\n", read_globals)
read_globals = merge_tables(read_globals, wow_global_constants)
print("\n---------------\n", read_globals)

globals = {
	"_G",
	"SlashCmdList",

	--Autobar Globals


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
