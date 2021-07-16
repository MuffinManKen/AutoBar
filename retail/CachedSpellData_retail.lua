
local ABGCS = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject

-- NOTE: This entire set of code runs in ~2ms, so no need to try to optimize it
local cache_timer_start = debugprofilestop();
--All
ABGCS.CacheSpellData(125439, "Revive Battle Pets");
ABGCS.CacheSpellData(83958, "Mobile Banking");
ABGCS.CacheSpellData(58984, "Shadowmeld");
ABGCS.CacheSpellData(87840, "Running Wild");
ABGCS.CacheSpellData(265225, "Mole Machine");
ABGCS.CacheSpellData(131204, "Path of the Jade Serpent");
ABGCS.CacheSpellData(131205, "Path of the Stout Brew");
ABGCS.CacheSpellData(131206, "Path of the Shado-Pan");
ABGCS.CacheSpellData(131222, "Path of the Mogu King");
ABGCS.CacheSpellData(131225, "Path of the Setting Sun");
ABGCS.CacheSpellData(131231, "Path of the Scarlet Blade");
ABGCS.CacheSpellData(131229, "Path of the Scarlet Mitre");
ABGCS.CacheSpellData(131232, "Path of the Necromancer");
ABGCS.CacheSpellData(131228, "Path of the Black Ox");


--DeathKnight
ABGCS.CacheSpellData(3714, "Path of Frost");
ABGCS.CacheSpellData(63560, "Dark Transformation");
ABGCS.CacheSpellData(45524, "Chains of Ice");
ABGCS.CacheSpellData(48707, "Anti-Magic Shell");
ABGCS.CacheSpellData(48792, "Icebound Fortitude");
ABGCS.CacheSpellData(47528, "Mind Freeze");
ABGCS.CacheSpellData(194679, "Rune Tap");
ABGCS.CacheSpellData(49028, "Dancing Rune Weapon");
ABGCS.CacheSpellData(46584, "Raise Dead");
ABGCS.CacheSpellData(49206, "Summon Gargoyle");
ABGCS.CacheSpellData(42650, "Army of the Dead");
ABGCS.CacheSpellData(50977, "Death Gate");

--DemonHunter
ABGCS.CacheSpellData(195072, "Fel Rush");
ABGCS.CacheSpellData(198793, "Vengeful Retreat");
ABGCS.CacheSpellData(198589, "Blur");
ABGCS.CacheSpellData(196718, "Darkness");
ABGCS.CacheSpellData(204596, "Sigil of Flame");
ABGCS.CacheSpellData(207684, "Sigil of Misery");
ABGCS.CacheSpellData(202137, "Sigil of Silence");
ABGCS.CacheSpellData(183752, "Disrupt");


--Druid
ABGCS.CacheSpellData(22812, "Barkskin");
ABGCS.CacheSpellData(5487, "Bear Form");
ABGCS.CacheSpellData(768, "Cat Form");
ABGCS.CacheSpellData(193753, "Dreamwalk");
ABGCS.CacheSpellData(339, "Entangling Roots");
ABGCS.CacheSpellData(22842, "Frenzied Regeneration");
ABGCS.CacheSpellData(99, "Incapacitating Roar");
ABGCS.CacheSpellData(102342, "Ironbark");
ABGCS.CacheSpellData(5215, "Prowl");
ABGCS.CacheSpellData(197625, "Moonkin Form");
ABGCS.CacheSpellData(114282, "Treant Form");
ABGCS.CacheSpellData(106839, "Skull Bash");
ABGCS.CacheSpellData(210053, "Mount Form");
ABGCS.CacheSpellData(783, "Travel Form");
ABGCS.CacheSpellData(18960, "Teleport: Moonglade");
ABGCS.CacheSpellData(102401, "Wild Charge");

--Hunter
ABGCS.CacheSpellData(61648, "Aspect of the Chameleon");
ABGCS.CacheSpellData(186257, "Aspect of the Cheetah");
ABGCS.CacheSpellData(186289, "Aspect of the Eagle");
ABGCS.CacheSpellData(186265, "Aspect of the Turtle");
ABGCS.CacheSpellData(193530, "Aspect of the Wild");
ABGCS.CacheSpellData(1462, "Beast Lore");
ABGCS.CacheSpellData(19574, "Bestial Wrath");
ABGCS.CacheSpellData(109248, "Binding Shot");
ABGCS.CacheSpellData(883, "Call Pet 1");
ABGCS.CacheSpellData(83242, "Call Pet 2");
ABGCS.CacheSpellData(83243, "Call Pet 3");
ABGCS.CacheSpellData(83244, "Call Pet 4");
ABGCS.CacheSpellData(83245, "Call Pet 5");
ABGCS.CacheSpellData(199483, "Camouflage");
ABGCS.CacheSpellData(5116, "Concussive Shot");
ABGCS.CacheSpellData(147362, "Counter Shot");
ABGCS.CacheSpellData(120679, "Dire Beast");
ABGCS.CacheSpellData(781, "Disengage");
ABGCS.CacheSpellData(2641, "Dismiss Pet");
ABGCS.CacheSpellData(6197, "Eagle Eye");
ABGCS.CacheSpellData(321297, "Eyes of the Beast");
ABGCS.CacheSpellData(6991, "Feed Pet");
ABGCS.CacheSpellData(5384, "Feign Death");
ABGCS.CacheSpellData(125050, "Fetch");
ABGCS.CacheSpellData(190925, "Harpoon");
ABGCS.CacheSpellData(7093, "Intimidation");
ABGCS.CacheSpellData(34026, "Kill Command");
ABGCS.CacheSpellData(53271, "Master's Call");
ABGCS.CacheSpellData(136, "Mend Pet");
ABGCS.CacheSpellData(209997, "Play Dead");
ABGCS.CacheSpellData(982, "Revive Pet");
ABGCS.CacheSpellData(1515, "Tame Beast");
ABGCS.CacheSpellData(210000, "Wake Up");
ABGCS.CacheSpellData(195645, "Wing Clip");
ABGCS.CacheSpellData(187650, "Freezing Trap");
ABGCS.CacheSpellData(187698, "Tar Trap");
ABGCS.CacheSpellData(162488, "Steel Trap");


--Mage
ABGCS.CacheSpellData(1459, "Arcane Intellect");
ABGCS.CacheSpellData(235313, "Blazing Barrier");
ABGCS.CacheSpellData(42955, "Conjure Refreshment");
ABGCS.CacheSpellData(759, "Conjure Mana Gem");
ABGCS.CacheSpellData(2139, "Counterspell");
ABGCS.CacheSpellData(110959, "Greater Invisibility");
ABGCS.CacheSpellData(11426, "Ice Barrier");
ABGCS.CacheSpellData(27619, "Ice Block");
ABGCS.CacheSpellData(66, "Invisibility");
ABGCS.CacheSpellData(235450, "Prismatic Barrier");
ABGCS.CacheSpellData(130, "Slow Fall");
ABGCS.CacheSpellData(31687, "Summon Water Elemental");
ABGCS.CacheSpellData(198111, "Temporal Shield");

ABGCS.CacheSpellData(33691, "Portal: Shattrath");
ABGCS.CacheSpellData(35715, "Teleport: Shattrath");
ABGCS.CacheSpellData(49361, "Portal: Stonard");
ABGCS.CacheSpellData(49358, "Teleport: Stonard");
ABGCS.CacheSpellData(49360, "Portal: Theramore");
ABGCS.CacheSpellData(49359, "Teleport: Theramore");
ABGCS.CacheSpellData(11418, "Portal: Undercity");
ABGCS.CacheSpellData(3563, "Teleport: Undercity");
ABGCS.CacheSpellData(11420, "Portal: Thunder Bluff");
ABGCS.CacheSpellData(3566, "Teleport: Thunder Bluff");
ABGCS.CacheSpellData(10059, "Portal: Stormwind");
ABGCS.CacheSpellData(3561, "Teleport: Stormwind");
ABGCS.CacheSpellData(32267, "Portal: Silvermoon");
ABGCS.CacheSpellData(32272, "Teleport: Silvermoon");
ABGCS.CacheSpellData(32266, "Portal: Exodar");
ABGCS.CacheSpellData(32271, "Teleport: Exodar");
ABGCS.CacheSpellData(11419, "Portal: Darnassus");
ABGCS.CacheSpellData(3565, "Teleport: Darnassus");
ABGCS.CacheSpellData(11416, "Portal: Ironforge");
ABGCS.CacheSpellData(3562, "Teleport: Ironforge");
ABGCS.CacheSpellData(11417, "Portal: Orgrimmar");
ABGCS.CacheSpellData(3567, "Teleport: Orgrimmar");
ABGCS.CacheSpellData(53142, "Portal: Dalaran");
ABGCS.CacheSpellData(53140, "Teleport: Dalaran");
ABGCS.CacheSpellData(224871, "Portal: Dalaran - Broken Isles");
ABGCS.CacheSpellData(224869, "Teleport: Dalaran - Broken Isles");

ABGCS.CacheSpellData(88344, "Teleport: Tol Barad - Horde");
ABGCS.CacheSpellData(88346, "Portal: Tol Barad - Horde");
ABGCS.CacheSpellData(88342, "Teleport: Tol Barad - Alliance");
ABGCS.CacheSpellData(88345, "Portal: Tol Barad - Alliance");

ABGCS.CacheSpellData(132621, "Teleport: Vale of Eternal Blossoms - Alliance");
ABGCS.CacheSpellData(132620, "Portal: Vale of Eternal Blossoms - Alliance");
ABGCS.CacheSpellData(132627, "Teleport: Vale of Eternal Blossoms - Horde");
ABGCS.CacheSpellData(132626, "Portal: Vale of Eternal Blossoms - Horde");

ABGCS.CacheSpellData(176248, "Teleport: Stormshield");
ABGCS.CacheSpellData(176246, "Portal: Stormshield");
ABGCS.CacheSpellData(176242, "Teleport: Warspear");
ABGCS.CacheSpellData(176244, "Portal: Warspear");
ABGCS.CacheSpellData(120145, "Teleport: Ancient Dalaran");
ABGCS.CacheSpellData(120146, "Portal: Ancient Dalaran");

ABGCS.CacheSpellData(204287, "Teleport: Hall of the Guardian");

ABGCS.CacheSpellData(281403, "Teleport: Boralus");
ABGCS.CacheSpellData(281400, "Portal: Boralus");
ABGCS.CacheSpellData(281404, "Teleport: Dazar'alor");
ABGCS.CacheSpellData(281402, "Portal: Dazar'alor");

ABGCS.CacheSpellData(344587, "Teleport: Oribos");
ABGCS.CacheSpellData(344597, "Portal: Oribos");



--Monk
ABGCS.CacheSpellData(126892, "Zen Pilgrimage");
ABGCS.CacheSpellData(126895, "Zen Pilgrimage: Return");
ABGCS.CacheSpellData(115203, "Fortifying Brew");
ABGCS.CacheSpellData(116705, "Spear Hand Strike");
ABGCS.CacheSpellData(137639, "Storm, Earth, and Fire");

--#region Paladin
ABGCS.CacheSpellData(31850, "Ardent Defender");
ABGCS.CacheSpellData(642, "Divine Shield");
ABGCS.CacheSpellData(1044, "Blessing of Freedom");
ABGCS.CacheSpellData(1022, "Blessing of Protection");
ABGCS.CacheSpellData(6940, "Blessing of Sacrifice");
ABGCS.CacheSpellData(204018, "Blessing of Spellwarding");
ABGCS.CacheSpellData(183218, "Hand of Hindrance");
ABGCS.CacheSpellData(96231, "Rebuke");
ABGCS.CacheSpellData(633, "Lay on Hands");
ABGCS.CacheSpellData(317920, "Concentration Aura");
ABGCS.CacheSpellData(32223, "Crusader Aura");
ABGCS.CacheSpellData(465, "Devotion Aura");
ABGCS.CacheSpellData(183435, "Retribution Aura");
--#endregion

--Priest
ABGCS.CacheSpellData(17, "Power Word: Shield");
ABGCS.CacheSpellData(62618, "Power Word: Barrier");
ABGCS.CacheSpellData(34433, "Shadowfiend");
ABGCS.CacheSpellData(47585, "Dispersion");
ABGCS.CacheSpellData(47788, "Guardian Spirit");
ABGCS.CacheSpellData(33206, "Pain Suppression");
ABGCS.CacheSpellData(15487, "Silence");
ABGCS.CacheSpellData(1706, "Levitate");
ABGCS.CacheSpellData(21562, "Power Word: Fortitude");


--Rogue
ABGCS.CacheSpellData(3408, "Crippling Poison");
ABGCS.CacheSpellData(2823, "Deadly Poison");
ABGCS.CacheSpellData(315584, "Instant Poison");
ABGCS.CacheSpellData(5761, "Numbing Poison");
ABGCS.CacheSpellData(8679, "Wound Poison");
ABGCS.CacheSpellData(5277, "Evasion");
ABGCS.CacheSpellData(1766, "Kick");
ABGCS.CacheSpellData(36554, "Shadowstep");
ABGCS.CacheSpellData(1784, "Stealth");
ABGCS.CacheSpellData(1856, "Vanish");
ABGCS.CacheSpellData(271877, "Blade Rush");



--Shaman
ABGCS.CacheSpellData(556, "Astral Recall");
ABGCS.CacheSpellData(198103, "Earth Elemental");
ABGCS.CacheSpellData(51533, "Feral Spirit");
ABGCS.CacheSpellData(198067, "Fire Elemental");
ABGCS.CacheSpellData(2645, "Ghost Wolf");
ABGCS.CacheSpellData(192249, "Storm Elemental");
ABGCS.CacheSpellData(546, "Water Walking");
ABGCS.CacheSpellData(57994, "Wind Shear");

ABGCS.CacheSpellData(207399, "Ancestral Protection Totem");
ABGCS.CacheSpellData(157153, "Cloudburst Totem");
ABGCS.CacheSpellData(192058, "Capacitor Totem");
ABGCS.CacheSpellData(2484, "Earthbind Totem");
ABGCS.CacheSpellData(198838, "Earthen Wall Totem");
ABGCS.CacheSpellData(51485, "Earthgrab Totem");
ABGCS.CacheSpellData(5394, "Healing Stream Totem");
ABGCS.CacheSpellData(108280, "Healing Tide Totem");
ABGCS.CacheSpellData(192222, "Liquid Magma Totem");
ABGCS.CacheSpellData(16191, "Mana Tide Totem");
ABGCS.CacheSpellData(98008, "Spirit Link Totem");
ABGCS.CacheSpellData(192077, "Wind Rush Totem");


--Warlock
ABGCS.CacheSpellData(104316, "Call Dreadstalkers");
ABGCS.CacheSpellData(119898, "Command Demon");
ABGCS.CacheSpellData(1714, "Curse of Tongues");	--y
ABGCS.CacheSpellData(702, "Curse of Weakness");	--y
ABGCS.CacheSpellData(334275, "Curse of Exhaustion");	--y

ABGCS.CacheSpellData(108416, "Dark Pact");
ABGCS.CacheSpellData(108503, "Grimoire of Sacrifice");
ABGCS.CacheSpellData(20707, "Soulstone");	--y
ABGCS.CacheSpellData(5697, "Unending Breath");	--y
ABGCS.CacheSpellData(104773, "Unending Resolve");
ABGCS.CacheSpellData(6201, "Create Healthstone");--y
ABGCS.CacheSpellData(29893, "Create Soulwell");	--y
ABGCS.CacheSpellData(126, "Eye of Kilrogg");--y
ABGCS.CacheSpellData(691, "Summon Felhunter");--y
ABGCS.CacheSpellData(688, "Summon Imp");--y
ABGCS.CacheSpellData(712, "Summon Succubus");--y
ABGCS.CacheSpellData(697, "Summon Voidwalker");	--y
ABGCS.CacheSpellData(1122, "Summon Infernal");
ABGCS.CacheSpellData(30146, "Summon Felguard");
ABGCS.CacheSpellData(205180, "Summon Darkglare");--y
ABGCS.CacheSpellData(265187, "Summon Demonic Tyrant");
ABGCS.CacheSpellData(698, "Ritual of Summoning");

--Warrior
ABGCS.CacheSpellData(6673, "Battle Shout");
ABGCS.CacheSpellData(100, "Charge");
ABGCS.CacheSpellData(97462, "Rallying Cry");
ABGCS.CacheSpellData(197690, "Defensive Stance");
ABGCS.CacheSpellData(1160, "Demoralizing Shout");
ABGCS.CacheSpellData(184364, "Enraged Regeneration");
ABGCS.CacheSpellData(3411, "Intervene");
ABGCS.CacheSpellData(12975, "Last Stand");
ABGCS.CacheSpellData(6552, "Pummel");
ABGCS.CacheSpellData(2565, "Shield Block");
ABGCS.CacheSpellData(871, "Shield Wall");

--Skills
ABGCS.CacheSpellData(28596, "Alchemy");
ABGCS.CacheSpellData(818, "Cooking Fire");
ABGCS.CacheSpellData(29844, "Blacksmithing");
ABGCS.CacheSpellData(33359, "Cooking");
ABGCS.CacheSpellData(78670, "Archaeology");
ABGCS.CacheSpellData(13262, "Disenchant");
ABGCS.CacheSpellData(28029, "Enchanting");
ABGCS.CacheSpellData(30350, "Engineering");
ABGCS.CacheSpellData(45357, "Inscription");
ABGCS.CacheSpellData(28897, "Jewelcrafting");
ABGCS.CacheSpellData(32549, "Leatherworking");
ABGCS.CacheSpellData(51005, "Milling");
ABGCS.CacheSpellData(31252, "Prospecting");
ABGCS.CacheSpellData(53428, "Runeforging");
ABGCS.CacheSpellData(2656, "Smelting");
ABGCS.CacheSpellData(80451, "Survey");
ABGCS.CacheSpellData(26790, "Tailoring");
ABGCS.CacheSpellData(131474, "Fishing");
ABGCS.CacheSpellData(201891, "Undercurrent");

local cache_timer_stop = debugprofilestop();

ABGData.timing["CacheSpellData.lua"] = cache_timer_stop - cache_timer_start;
