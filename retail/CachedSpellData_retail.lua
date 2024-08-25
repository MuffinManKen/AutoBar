local _, AB = ...

local types = AB.types	---@class ABTypes
local code = AB.code	---@class ABCode

local ABGData = AutoBarGlobalDataObject

-- NOTE: This entire set of code runs in ~2ms, so no need to try to optimize it
local cache_timer_start = debugprofilestop();
--All
code.cache_spell_data(125439, "Revive Battle Pets");
code.cache_spell_data(83958, "Mobile Banking");
code.cache_spell_data(58984, "Shadowmeld");
code.cache_spell_data(87840, "Running Wild");
code.cache_spell_data(265225, "Mole Machine");
code.cache_spell_data(131204, "Path of the Jade Serpent");
code.cache_spell_data(131205, "Path of the Stout Brew");
code.cache_spell_data(131206, "Path of the Shado-Pan");
code.cache_spell_data(131222, "Path of the Mogu King");
code.cache_spell_data(131225, "Path of the Setting Sun");
code.cache_spell_data(131231, "Path of the Scarlet Blade");
code.cache_spell_data(131229, "Path of the Scarlet Mitre");
code.cache_spell_data(131232, "Path of the Necromancer");
code.cache_spell_data(131228, "Path of the Black Ox");


--#region DeathKnight
code.cache_spell_data(3714, "Path of Frost");
code.cache_spell_data(63560, "Dark Transformation");
code.cache_spell_data(45524, "Chains of Ice");
code.cache_spell_data(48707, "Anti-Magic Shell");
code.cache_spell_data(48792, "Icebound Fortitude");
code.cache_spell_data(47528, "Mind Freeze");
code.cache_spell_data(194679, "Rune Tap");
code.cache_spell_data(49028, "Dancing Rune Weapon");
code.cache_spell_data(46584, "Raise Dead");
code.cache_spell_data(49206, "Summon Gargoyle");
code.cache_spell_data(42650, "Army of the Dead");
code.cache_spell_data(50977, "Death Gate");
--#endregion


--#region DemonHunter
code.cache_spell_data(195072, "Fel Rush");
code.cache_spell_data(198793, "Vengeful Retreat");
code.cache_spell_data(198589, "Blur");
code.cache_spell_data(196718, "Darkness");
code.cache_spell_data(204596, "Sigil of Flame");
code.cache_spell_data(207684, "Sigil of Misery");
code.cache_spell_data(202137, "Sigil of Silence");
code.cache_spell_data(183752, "Disrupt");
--#endregion


--#region Druid
code.cache_spell_data(22812, "Barkskin");
code.cache_spell_data(5487, "Bear Form");
code.cache_spell_data(768, "Cat Form");
code.cache_spell_data(193753, "Dreamwalk");
code.cache_spell_data(339, "Entangling Roots");
code.cache_spell_data(22842, "Frenzied Regeneration");
code.cache_spell_data(99, "Incapacitating Roar");
code.cache_spell_data(102342, "Ironbark");
code.cache_spell_data(5215, "Prowl");
code.cache_spell_data(1126, "Mark of the Wild");
code.cache_spell_data(197625, "Moonkin Form");
code.cache_spell_data(114282, "Treant Form");
code.cache_spell_data(106839, "Skull Bash");
code.cache_spell_data(210053, "Mount Form");
code.cache_spell_data(783, "Travel Form");
code.cache_spell_data(18960, "Teleport: Moonglade");
code.cache_spell_data(102401, "Wild Charge");
--#endregion

--#region Evoker
code.cache_spell_data(364342, "Blessing of the Bronze");
--#endregion Evoker

--#region Hunter
code.cache_spell_data(61648, "Aspect of the Chameleon");
code.cache_spell_data(186257, "Aspect of the Cheetah");
code.cache_spell_data(186289, "Aspect of the Eagle");
code.cache_spell_data(186265, "Aspect of the Turtle");
code.cache_spell_data(193530, "Aspect of the Wild");
code.cache_spell_data(1462, "Beast Lore");
code.cache_spell_data(19574, "Bestial Wrath");
code.cache_spell_data(109248, "Binding Shot");
code.cache_spell_data(883, "Call Pet 1");
code.cache_spell_data(83242, "Call Pet 2");
code.cache_spell_data(83243, "Call Pet 3");
code.cache_spell_data(83244, "Call Pet 4");
code.cache_spell_data(83245, "Call Pet 5");
code.cache_spell_data(199483, "Camouflage");
code.cache_spell_data(5116, "Concussive Shot");
code.cache_spell_data(147362, "Counter Shot");
code.cache_spell_data(120679, "Dire Beast");
code.cache_spell_data(781, "Disengage");
code.cache_spell_data(2641, "Dismiss Pet");
code.cache_spell_data(6197, "Eagle Eye");
code.cache_spell_data(321297, "Eyes of the Beast");
code.cache_spell_data(6991, "Feed Pet");
code.cache_spell_data(5384, "Feign Death");
code.cache_spell_data(125050, "Fetch");
code.cache_spell_data(190925, "Harpoon");
code.cache_spell_data(7093, "Intimidation");
code.cache_spell_data(34026, "Kill Command");
code.cache_spell_data(53271, "Master's Call");
code.cache_spell_data(136, "Mend Pet");
code.cache_spell_data(209997, "Play Dead");
code.cache_spell_data(982, "Revive Pet");
code.cache_spell_data(1515, "Tame Beast");
code.cache_spell_data(210000, "Wake Up");
code.cache_spell_data(195645, "Wing Clip");
code.cache_spell_data(187650, "Freezing Trap");
code.cache_spell_data(187698, "Tar Trap");
code.cache_spell_data(162488, "Steel Trap");
--#endregion


--#region Mage
code.cache_spell_data(1459, "Arcane Intellect");
code.cache_spell_data(235313, "Blazing Barrier");
code.cache_spell_data(42955, "Conjure Refreshment");
code.cache_spell_data(759, "Conjure Mana Gem");
code.cache_spell_data(2139, "Counterspell");
code.cache_spell_data(110959, "Greater Invisibility");
code.cache_spell_data(11426, "Ice Barrier");
code.cache_spell_data(27619, "Ice Block");
code.cache_spell_data(66, "Invisibility");
code.cache_spell_data(235450, "Prismatic Barrier");
code.cache_spell_data(130, "Slow Fall");
code.cache_spell_data(31687, "Summon Water Elemental");
code.cache_spell_data(198111, "Temporal Shield");

code.cache_spell_data(33691, "Portal: Shattrath");
code.cache_spell_data(35715, "Teleport: Shattrath");
code.cache_spell_data(49361, "Portal: Stonard");
code.cache_spell_data(49358, "Teleport: Stonard");
code.cache_spell_data(49360, "Portal: Theramore");
code.cache_spell_data(49359, "Teleport: Theramore");
code.cache_spell_data(11418, "Portal: Undercity");
code.cache_spell_data(3563, "Teleport: Undercity");
code.cache_spell_data(11420, "Portal: Thunder Bluff");
code.cache_spell_data(3566, "Teleport: Thunder Bluff");
code.cache_spell_data(10059, "Portal: Stormwind");
code.cache_spell_data(3561, "Teleport: Stormwind");
code.cache_spell_data(32267, "Portal: Silvermoon");
code.cache_spell_data(32272, "Teleport: Silvermoon");
code.cache_spell_data(32266, "Portal: Exodar");
code.cache_spell_data(32271, "Teleport: Exodar");
code.cache_spell_data(11419, "Portal: Darnassus");
code.cache_spell_data(3565, "Teleport: Darnassus");
code.cache_spell_data(11416, "Portal: Ironforge");
code.cache_spell_data(3562, "Teleport: Ironforge");
code.cache_spell_data(11417, "Portal: Orgrimmar");
code.cache_spell_data(3567, "Teleport: Orgrimmar");
code.cache_spell_data(53142, "Portal: Dalaran");
code.cache_spell_data(53140, "Teleport: Dalaran");
code.cache_spell_data(224871, "Portal: Dalaran - Broken Isles");
code.cache_spell_data(224869, "Teleport: Dalaran - Broken Isles");

code.cache_spell_data(88344, "Teleport: Tol Barad - Horde");
code.cache_spell_data(88346, "Portal: Tol Barad - Horde");
code.cache_spell_data(88342, "Teleport: Tol Barad - Alliance");
code.cache_spell_data(88345, "Portal: Tol Barad - Alliance");

code.cache_spell_data(132621, "Teleport: Vale of Eternal Blossoms - Alliance");
code.cache_spell_data(132620, "Portal: Vale of Eternal Blossoms - Alliance");
code.cache_spell_data(132627, "Teleport: Vale of Eternal Blossoms - Horde");
code.cache_spell_data(132626, "Portal: Vale of Eternal Blossoms - Horde");

code.cache_spell_data(176248, "Teleport: Stormshield");
code.cache_spell_data(176246, "Portal: Stormshield");
code.cache_spell_data(176242, "Teleport: Warspear");
code.cache_spell_data(176244, "Portal: Warspear");
code.cache_spell_data(120145, "Teleport: Ancient Dalaran");
code.cache_spell_data(120146, "Portal: Ancient Dalaran");

code.cache_spell_data(193759, "Teleport: Hall of the Guardian");

code.cache_spell_data(281403, "Teleport: Boralus");
code.cache_spell_data(281400, "Portal: Boralus");
code.cache_spell_data(281404, "Teleport: Dazar'alor");
code.cache_spell_data(281402, "Portal: Dazar'alor");

code.cache_spell_data(344587, "Teleport: Oribos");
code.cache_spell_data(344597, "Portal: Oribos");

code.cache_spell_data(395277, "Teleport: Valdrakken");
code.cache_spell_data(395289, "Portal: Valdrakken");

code.cache_spell_data(446540, "Teleport: Dornogal");
code.cache_spell_data(446534, "Portal: Dornogal");
--#endregion


--#region Monk
code.cache_spell_data(126892, "Zen Pilgrimage");
code.cache_spell_data(126895, "Zen Pilgrimage: Return");
code.cache_spell_data(115203, "Fortifying Brew");
code.cache_spell_data(116705, "Spear Hand Strike");
code.cache_spell_data(137639, "Storm, Earth, and Fire");
--#endregion


--#region Paladin
code.cache_spell_data(31850, "Ardent Defender");
code.cache_spell_data(642, "Divine Shield");
code.cache_spell_data(1044, "Blessing of Freedom");
code.cache_spell_data(1022, "Blessing of Protection");
code.cache_spell_data(6940, "Blessing of Sacrifice");
code.cache_spell_data(204018, "Blessing of Spellwarding");
code.cache_spell_data(183218, "Hand of Hindrance");
code.cache_spell_data(96231, "Rebuke");
code.cache_spell_data(633, "Lay on Hands");
code.cache_spell_data(317920, "Concentration Aura");
code.cache_spell_data(32223, "Crusader Aura");
code.cache_spell_data(465, "Devotion Aura");
code.cache_spell_data(183435, "Retribution Aura");
--#endregion


--#region Priest
code.cache_spell_data(17, "Power Word: Shield");
code.cache_spell_data(62618, "Power Word: Barrier");
code.cache_spell_data(34433, "Shadowfiend");
code.cache_spell_data(47585, "Dispersion");
code.cache_spell_data(47788, "Guardian Spirit");
code.cache_spell_data(33206, "Pain Suppression");
code.cache_spell_data(15487, "Silence");
code.cache_spell_data(1706, "Levitate");
code.cache_spell_data(21562, "Power Word: Fortitude");
--#endregion


--#region Rogue
code.cache_spell_data(381664, "Amplifying Poison");
code.cache_spell_data(381637, "Atrophic Poison");
code.cache_spell_data(3408, "Crippling Poison");
code.cache_spell_data(2823, "Deadly Poison");
code.cache_spell_data(315584, "Instant Poison");
code.cache_spell_data(5761, "Numbing Poison");
code.cache_spell_data(8679, "Wound Poison");
code.cache_spell_data(5277, "Evasion");
code.cache_spell_data(1766, "Kick");
code.cache_spell_data(36554, "Shadowstep");
code.cache_spell_data(1784, "Stealth");
code.cache_spell_data(1856, "Vanish");
code.cache_spell_data(271877, "Blade Rush");
--#endregion


--#region Shaman
code.cache_spell_data(556, "Astral Recall");
code.cache_spell_data(198103, "Earth Elemental");
code.cache_spell_data(51533, "Feral Spirit");
code.cache_spell_data(198067, "Fire Elemental");
code.cache_spell_data(2645, "Ghost Wolf");
code.cache_spell_data(192249, "Storm Elemental");
code.cache_spell_data(546, "Water Walking");
code.cache_spell_data(57994, "Wind Shear");

code.cache_spell_data(207399, "Ancestral Protection Totem");
code.cache_spell_data(157153, "Cloudburst Totem");
code.cache_spell_data(192058, "Capacitor Totem");
code.cache_spell_data(2484, "Earthbind Totem");
code.cache_spell_data(198838, "Earthen Wall Totem");
code.cache_spell_data(51485, "Earthgrab Totem");
code.cache_spell_data(5394, "Healing Stream Totem");
code.cache_spell_data(108280, "Healing Tide Totem");
code.cache_spell_data(192222, "Liquid Magma Totem");
code.cache_spell_data(16191, "Mana Tide Totem");
code.cache_spell_data(98008, "Spirit Link Totem");
code.cache_spell_data(192077, "Wind Rush Totem");
--#endregion


--#region Warlock
code.cache_spell_data(104316, "Call Dreadstalkers");
code.cache_spell_data(119898, "Command Demon");
code.cache_spell_data(1714, "Curse of Tongues");	--y
code.cache_spell_data(702, "Curse of Weakness");	--y
code.cache_spell_data(334275, "Curse of Exhaustion");	--y

code.cache_spell_data(108416, "Dark Pact");
code.cache_spell_data(108503, "Grimoire of Sacrifice");
code.cache_spell_data(20707, "Soulstone");	--y
code.cache_spell_data(5697, "Unending Breath");	--y
code.cache_spell_data(104773, "Unending Resolve");
code.cache_spell_data(6201, "Create Healthstone");--y
code.cache_spell_data(29893, "Create Soulwell");	--y
code.cache_spell_data(126, "Eye of Kilrogg");--y
code.cache_spell_data(691, "Summon Felhunter");--y
code.cache_spell_data(688, "Summon Imp");--y
code.cache_spell_data(366222, "Summon Sayaad");--y
code.cache_spell_data(697, "Summon Voidwalker");	--y
code.cache_spell_data(1122, "Summon Infernal");
code.cache_spell_data(30146, "Summon Felguard");
code.cache_spell_data(205180, "Summon Darkglare");--y
code.cache_spell_data(265187, "Summon Demonic Tyrant");
code.cache_spell_data(698, "Ritual of Summoning");
--#endregion


--#region Warrior
code.cache_spell_data(6673, "Battle Shout");
code.cache_spell_data(100, "Charge");
code.cache_spell_data(97462, "Rallying Cry");
code.cache_spell_data(197690, "Defensive Stance");
code.cache_spell_data(1160, "Demoralizing Shout");
code.cache_spell_data(184364, "Enraged Regeneration");
code.cache_spell_data(3411, "Intervene");
code.cache_spell_data(12975, "Last Stand");
code.cache_spell_data(6552, "Pummel");
code.cache_spell_data(2565, "Shield Block");
code.cache_spell_data(871, "Shield Wall");
--#endregion


--#region Skills
code.cache_spell_data(28596, "Alchemy");
code.cache_spell_data(818, "Cooking Fire");
code.cache_spell_data(29844, "Blacksmithing");
code.cache_spell_data(33359, "Cooking");
code.cache_spell_data(78670, "Archaeology");
code.cache_spell_data(13262, "Disenchant");
code.cache_spell_data(28029, "Enchanting");
code.cache_spell_data(30350, "Engineering");
code.cache_spell_data(45357, "Inscription");
code.cache_spell_data(28897, "Jewelcrafting");
code.cache_spell_data(32549, "Leatherworking");
code.cache_spell_data(51005, "Milling");
code.cache_spell_data(31252, "Prospecting");
code.cache_spell_data(53428, "Runeforging");
code.cache_spell_data(2656, "Smelting");
code.cache_spell_data(80451, "Survey");
code.cache_spell_data(26790, "Tailoring");
code.cache_spell_data(131474, "Fishing");
code.cache_spell_data(201891, "Undercurrent");

code.cache_spell_data(194174, "Skinning Journal");
code.cache_spell_data(271990, "Fishing Journal");
code.cache_spell_data(193290, "Herbalism Journal");
code.cache_spell_data(2656, "Mining Journal");
--#endregion

local cache_timer_stop = debugprofilestop();

ABGData.timing["CacheSpellData.lua"] = cache_timer_stop - cache_timer_start;
