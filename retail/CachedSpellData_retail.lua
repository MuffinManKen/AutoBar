
local ABGCS = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject

-- NOTE: This entire set of code runs in ~2ms, so no need to try to optimize it
local cache_timer_start = debugprofilestop();
--All
ABGCS:CacheSpellData(125439, "Revive Battle Pets");
ABGCS:CacheSpellData(83958, "Mobile Banking");
ABGCS:CacheSpellData(58984, "Shadowmeld");
ABGCS:CacheSpellData(87840, "Running Wild");
ABGCS:CacheSpellData(265225, "Mole Machine");
ABGCS:CacheSpellData(131204, "Path of the Jade Serpent");
ABGCS:CacheSpellData(131205, "Path of the Stout Brew");
ABGCS:CacheSpellData(131206, "Path of the Shado-Pan");
ABGCS:CacheSpellData(131222, "Path of the Mogu King");
ABGCS:CacheSpellData(131225, "Path of the Setting Sun");
ABGCS:CacheSpellData(131231, "Path of the Scarlet Blade");
ABGCS:CacheSpellData(131229, "Path of the Scarlet Mitre");
ABGCS:CacheSpellData(131232, "Path of the Necromancer");
ABGCS:CacheSpellData(131228, "Path of the Black Ox");


--DeathKnight
ABGCS:CacheSpellData(3714, "Path of Frost"); --y
ABGCS:CacheSpellData(63560, "Dark Transformation"); --y
ABGCS:CacheSpellData(45524, "Chains of Ice"); --y
ABGCS:CacheSpellData(48707, "Anti-Magic Shell"); --y
ABGCS:CacheSpellData(48792, "Icebound Fortitude"); --y
ABGCS:CacheSpellData(47528, "Mind Freeze"); --y
ABGCS:CacheSpellData(194679, "Rune Tap"); --y
ABGCS:CacheSpellData(49028, "Dancing Rune Weapon"); --y
ABGCS:CacheSpellData(46584, "Raise Dead"); --y
ABGCS:CacheSpellData(49206, "Summon Gargoyle"); --y
ABGCS:CacheSpellData(42650, "Army of the Dead"); --y
ABGCS:CacheSpellData(50977, "Death Gate"); --y

--DemonHunter
ABGCS:CacheSpellData(195072, "Fel Rush"); --y
ABGCS:CacheSpellData(198793, "Vengeful Retreat"); --y
ABGCS:CacheSpellData(198589, "Blur"); --y
ABGCS:CacheSpellData(196718, "Darkness"); --y
ABGCS:CacheSpellData(204596, "Sigil of Flame"); --y
ABGCS:CacheSpellData(207684, "Sigil of Misery"); --y
ABGCS:CacheSpellData(202137, "Sigil of Silence"); --y
ABGCS:CacheSpellData(183752, "Disrupt"); --y


--Druid
ABGCS:CacheSpellData(22812, "Barkskin"); --y
ABGCS:CacheSpellData(5487, "Bear Form"); --y
ABGCS:CacheSpellData(768, "Cat Form"); --y
ABGCS:CacheSpellData(193753, "Dreamwalk"); --y
ABGCS:CacheSpellData(339, "Entangling Roots"); --y
ABGCS:CacheSpellData(22842, "Frenzied Regeneration"); --y
ABGCS:CacheSpellData(99, "Incapacitating Roar"); --y
ABGCS:CacheSpellData(102342, "Ironbark"); --y
ABGCS:CacheSpellData(5215, "Prowl"); --y
ABGCS:CacheSpellData(197625, "Moonkin Form"); --y
ABGCS:CacheSpellData(114282, "Treant Form"); --y
ABGCS:CacheSpellData(106839, "Skull Bash"); --y
ABGCS:CacheSpellData(210053, "Mount Form"); --y
ABGCS:CacheSpellData(783, "Travel Form"); --y
ABGCS:CacheSpellData(18960, "Teleport: Moonglade"); --y
ABGCS:CacheSpellData(102401, "Wild Charge"); --y

--Hunter
ABGCS:CacheSpellData(61648, "Aspect of the Chameleon"); --y
ABGCS:CacheSpellData(186257, "Aspect of the Cheetah"); --y
ABGCS:CacheSpellData(186289, "Aspect of the Eagle"); --y
ABGCS:CacheSpellData(186265, "Aspect of the Turtle"); --y
ABGCS:CacheSpellData(193530, "Aspect of the Wild"); --y
ABGCS:CacheSpellData(1462, "Beast Lore"); --y
ABGCS:CacheSpellData(19574, "Bestial Wrath"); --y
ABGCS:CacheSpellData(109248, "Binding Shot"); --y
ABGCS:CacheSpellData(883, "Call Pet 1"); --y
ABGCS:CacheSpellData(83242, "Call Pet 2"); --y
ABGCS:CacheSpellData(83243, "Call Pet 3"); --y
ABGCS:CacheSpellData(83244, "Call Pet 4"); --y
ABGCS:CacheSpellData(83245, "Call Pet 5"); --y
ABGCS:CacheSpellData(199483, "Camouflage"); --y
ABGCS:CacheSpellData(5116, "Concussive Shot"); --y
ABGCS:CacheSpellData(147362, "Counter Shot"); --y
ABGCS:CacheSpellData(120679, "Dire Beast"); --y
ABGCS:CacheSpellData(781, "Disengage"); --y
ABGCS:CacheSpellData(2641, "Dismiss Pet"); --y
ABGCS:CacheSpellData(6197, "Eagle Eye"); --y
ABGCS:CacheSpellData(321297, "Eyes of the Beast"); --y
ABGCS:CacheSpellData(6991, "Feed Pet"); --y
ABGCS:CacheSpellData(5384, "Feign Death"); --y
ABGCS:CacheSpellData(125050, "Fetch"); --y
ABGCS:CacheSpellData(190925, "Harpoon");  --y
ABGCS:CacheSpellData(7093, "Intimidation"); --y
ABGCS:CacheSpellData(34026, "Kill Command"); --y
ABGCS:CacheSpellData(53271, "Master's Call"); --y
ABGCS:CacheSpellData(136, "Mend Pet"); --y
ABGCS:CacheSpellData(209997, "Play Dead"); --y
ABGCS:CacheSpellData(982, "Revive Pet"); --y
ABGCS:CacheSpellData(1515, "Tame Beast"); --y
ABGCS:CacheSpellData(210000, "Wake Up"); --y
ABGCS:CacheSpellData(195645, "Wing Clip"); --y
ABGCS:CacheSpellData(187650, "Freezing Trap"); --y
ABGCS:CacheSpellData(187698, "Tar Trap"); --y
ABGCS:CacheSpellData(162488, "Steel Trap"); --y


--Mage
ABGCS:CacheSpellData(1459, "Arcane Intellect"); --y
ABGCS:CacheSpellData(235313, "Blazing Barrier"); --y
ABGCS:CacheSpellData(42955, "Conjure Refreshment"); --y
ABGCS:CacheSpellData(759, "Conjure Mana Gem");
ABGCS:CacheSpellData(2139, "Counterspell"); --y
ABGCS:CacheSpellData(110959, "Greater Invisibility"); --y
ABGCS:CacheSpellData(11426, "Ice Barrier"); --y
ABGCS:CacheSpellData(27619, "Ice Block"); --y
ABGCS:CacheSpellData(66, "Invisibility"); --y
ABGCS:CacheSpellData(235450, "Prismatic Barrier"); --y
ABGCS:CacheSpellData(130, "Slow Fall"); --y
ABGCS:CacheSpellData(31687, "Summon Water Elemental"); --y
ABGCS:CacheSpellData(198111, "Temporal Shield"); --y

ABGCS:CacheSpellData(33691, "Portal: Shattrath");
ABGCS:CacheSpellData(35715, "Teleport: Shattrath");
ABGCS:CacheSpellData(49361, "Portal: Stonard");
ABGCS:CacheSpellData(49358, "Teleport: Stonard");
ABGCS:CacheSpellData(49360, "Portal: Theramore");
ABGCS:CacheSpellData(49359, "Teleport: Theramore");
ABGCS:CacheSpellData(11418, "Portal: Undercity");
ABGCS:CacheSpellData(3563, "Teleport: Undercity");
ABGCS:CacheSpellData(11420, "Portal: Thunder Bluff");
ABGCS:CacheSpellData(3566, "Teleport: Thunder Bluff");
ABGCS:CacheSpellData(10059, "Portal: Stormwind");
ABGCS:CacheSpellData(3561, "Teleport: Stormwind");
ABGCS:CacheSpellData(32267, "Portal: Silvermoon");
ABGCS:CacheSpellData(32272, "Teleport: Silvermoon");
ABGCS:CacheSpellData(32266, "Portal: Exodar");
ABGCS:CacheSpellData(32271, "Teleport: Exodar");
ABGCS:CacheSpellData(11419, "Portal: Darnassus");
ABGCS:CacheSpellData(3565, "Teleport: Darnassus");
ABGCS:CacheSpellData(11416, "Portal: Ironforge");
ABGCS:CacheSpellData(3562, "Teleport: Ironforge");
ABGCS:CacheSpellData(11417, "Portal: Orgrimmar");
ABGCS:CacheSpellData(3567, "Teleport: Orgrimmar");
ABGCS:CacheSpellData(53142, "Portal: Dalaran");
ABGCS:CacheSpellData(53140, "Teleport: Dalaran");
ABGCS:CacheSpellData(224871, "Portal: Dalaran - Broken Isles");
ABGCS:CacheSpellData(224869, "Teleport: Dalaran - Broken Isles");

ABGCS:CacheSpellData(88344, "Teleport: Tol Barad - Horde");
ABGCS:CacheSpellData(88346, "Portal: Tol Barad - Horde");
ABGCS:CacheSpellData(88342, "Teleport: Tol Barad - Alliance");
ABGCS:CacheSpellData(88345, "Portal: Tol Barad - Alliance");

ABGCS:CacheSpellData(132621, "Teleport: Vale of Eternal Blossoms - Alliance");
ABGCS:CacheSpellData(132620, "Portal: Vale of Eternal Blossoms - Alliance");
ABGCS:CacheSpellData(132627, "Teleport: Vale of Eternal Blossoms - Horde");
ABGCS:CacheSpellData(132626, "Portal: Vale of Eternal Blossoms - Horde");

ABGCS:CacheSpellData(176248, "Teleport: Stormshield");
ABGCS:CacheSpellData(176246, "Portal: Stormshield");
ABGCS:CacheSpellData(176242, "Teleport: Warspear");
ABGCS:CacheSpellData(176244, "Portal: Warspear");
ABGCS:CacheSpellData(120145, "Teleport: Ancient Dalaran");
ABGCS:CacheSpellData(120146, "Portal: Ancient Dalaran");

ABGCS:CacheSpellData(204287, "Teleport: Hall of the Guardian");

ABGCS:CacheSpellData(281403, "Teleport: Boralus");
ABGCS:CacheSpellData(281400, "Portal: Boralus");
ABGCS:CacheSpellData(281404, "Teleport: Dazar'alor");
ABGCS:CacheSpellData(281402, "Portal: Dazar'alor");

ABGCS:CacheSpellData(344587, "Teleport: Oribos");
ABGCS:CacheSpellData(344597, "Portal: Oribos");



--Monk
ABGCS:CacheSpellData(126892, "Zen Pilgrimage"); --y
ABGCS:CacheSpellData(126895, "Zen Pilgrimage: Return"); --y
ABGCS:CacheSpellData(115203, "Fortifying Brew"); --y
ABGCS:CacheSpellData(116705, "Spear Hand Strike"); --y
ABGCS:CacheSpellData(137639, "Storm, Earth, and Fire"); --y

--Paladin
ABGCS:CacheSpellData(31850, "Ardent Defender"); --y
ABGCS:CacheSpellData(642, "Divine Shield"); --y
ABGCS:CacheSpellData(1044, "Blessing of Freedom"); --y
ABGCS:CacheSpellData(1022, "Blessing of Protection"); --y
ABGCS:CacheSpellData(6940, "Blessing of Sacrifice"); --y
ABGCS:CacheSpellData(204018, "Blessing of Spellwarding"); --y
ABGCS:CacheSpellData(183218, "Hand of Hindrance"); --y
ABGCS:CacheSpellData(96231, "Rebuke"); --y
ABGCS:CacheSpellData(633, "Lay on Hands"); --y
ABGCS:CacheSpellData(32223, "Crusader Aura"); --y
ABGCS:CacheSpellData(465, "Devotion Aura"); --y
ABGCS:CacheSpellData(183435, "Retribution Aura"); --y


--Priest
ABGCS:CacheSpellData(17, "Power Word: Shield"); --y
ABGCS:CacheSpellData(62618, "Power Word: Barrier"); --y
ABGCS:CacheSpellData(34433, "Shadowfiend"); --y
ABGCS:CacheSpellData(47585, "Dispersion"); --y
ABGCS:CacheSpellData(47788, "Guardian Spirit"); --y
ABGCS:CacheSpellData(33206, "Pain Suppression"); --y
ABGCS:CacheSpellData(15487, "Silence"); --y
ABGCS:CacheSpellData(1706, "Levitate"); --y
ABGCS:CacheSpellData(21562, "Power Word: Fortitude"); --y


--Rogue
ABGCS:CacheSpellData(3408, "Crippling Poison"); --y
ABGCS:CacheSpellData(2823, "Deadly Poison"); --y
ABGCS:CacheSpellData(315584, "Instant Poison"); --y
ABGCS:CacheSpellData(5761, "Numbing Poison"); --y
ABGCS:CacheSpellData(8679, "Wound Poison"); --y
ABGCS:CacheSpellData(5277, "Evasion"); --y
ABGCS:CacheSpellData(1766, "Kick"); --y
ABGCS:CacheSpellData(36554, "Shadowstep"); --y
ABGCS:CacheSpellData(1784, "Stealth"); --y
ABGCS:CacheSpellData(1856, "Vanish"); --y
ABGCS:CacheSpellData(271877, "Blade Rush"); --y



--Shaman
ABGCS:CacheSpellData(556, "Astral Recall"); --y
ABGCS:CacheSpellData(198103, "Earth Elemental"); --y
ABGCS:CacheSpellData(51533, "Feral Spirit"); --y
ABGCS:CacheSpellData(198067, "Fire Elemental"); --y
ABGCS:CacheSpellData(2645, "Ghost Wolf"); --y
ABGCS:CacheSpellData(192249, "Storm Elemental"); --y
ABGCS:CacheSpellData(546, "Water Walking"); --y
ABGCS:CacheSpellData(57994, "Wind Shear"); --y

ABGCS:CacheSpellData(207399, "Ancestral Protection Totem"); --y
ABGCS:CacheSpellData(157153, "Cloudburst Totem"); --y
ABGCS:CacheSpellData(192058, "Capacitor Totem"); --y
ABGCS:CacheSpellData(2484, "Earthbind Totem"); --y
ABGCS:CacheSpellData(198838, "Earthen Wall Totem"); --y
ABGCS:CacheSpellData(51485, "Earthgrab Totem"); --y
ABGCS:CacheSpellData(5394, "Healing Stream Totem"); --y
ABGCS:CacheSpellData(108280, "Healing Tide Totem"); --y
ABGCS:CacheSpellData(192222, "Liquid Magma Totem"); --y
ABGCS:CacheSpellData(16191, "Mana Tide Totem"); --y
ABGCS:CacheSpellData(98008, "Spirit Link Totem"); --y
ABGCS:CacheSpellData(192077, "Wind Rush Totem"); --y


--Warlock
ABGCS:CacheSpellData(104316, "Call Dreadstalkers"); --y
ABGCS:CacheSpellData(119898, "Command Demon"); --y
ABGCS:CacheSpellData(1714, "Curse of Tongues");	--y
ABGCS:CacheSpellData(702, "Curse of Weakness");	--y
ABGCS:CacheSpellData(334275, "Curse of Exhaustion");	--y

ABGCS:CacheSpellData(108416, "Dark Pact"); --y
ABGCS:CacheSpellData(108503, "Grimoire of Sacrifice"); --y
ABGCS:CacheSpellData(20707, "Soulstone");	--y
ABGCS:CacheSpellData(5697, "Unending Breath");	--y
ABGCS:CacheSpellData(104773, "Unending Resolve"); --y
ABGCS:CacheSpellData(6201, "Create Healthstone");--y
ABGCS:CacheSpellData(29893, "Create Soulwell");	--y
ABGCS:CacheSpellData(126, "Eye of Kilrogg");--y
ABGCS:CacheSpellData(691, "Summon Felhunter");--y
ABGCS:CacheSpellData(688, "Summon Imp");--y
ABGCS:CacheSpellData(712, "Summon Succubus");--y
ABGCS:CacheSpellData(697, "Summon Voidwalker");	--y
ABGCS:CacheSpellData(1122, "Summon Infernal"); --y
ABGCS:CacheSpellData(30146, "Summon Felguard"); --y
ABGCS:CacheSpellData(205180, "Summon Darkglare");--y
ABGCS:CacheSpellData(265187, "Summon Demonic Tyrant");
ABGCS:CacheSpellData(698, "Ritual of Summoning"); --y

--Warrior
ABGCS:CacheSpellData(6673, "Battle Shout"); --y
ABGCS:CacheSpellData(100, "Charge"); --y
ABGCS:CacheSpellData(97462, "Rallying Cry"); --y
ABGCS:CacheSpellData(197690, "Defensive Stance"); --y
ABGCS:CacheSpellData(1160, "Demoralizing Shout"); --y
ABGCS:CacheSpellData(184364, "Enraged Regeneration"); --y
ABGCS:CacheSpellData(3411, "Intervene"); --y
ABGCS:CacheSpellData(12975, "Last Stand"); --y
ABGCS:CacheSpellData(6552, "Pummel"); --y
ABGCS:CacheSpellData(2565, "Shield Block"); --y
ABGCS:CacheSpellData(871, "Shield Wall"); --y

--Skills
ABGCS:CacheSpellData(28596, "Alchemy");
ABGCS:CacheSpellData(818, "Cooking Fire");
ABGCS:CacheSpellData(29844, "Blacksmithing");
ABGCS:CacheSpellData(33359, "Cooking");
ABGCS:CacheSpellData(78670, "Archaeology");
ABGCS:CacheSpellData(13262, "Disenchant");
ABGCS:CacheSpellData(28029, "Enchanting");
ABGCS:CacheSpellData(30350, "Engineering");
ABGCS:CacheSpellData(45357, "Inscription");
ABGCS:CacheSpellData(28897, "Jewelcrafting");
ABGCS:CacheSpellData(32549, "Leatherworking");
ABGCS:CacheSpellData(51005, "Milling");
ABGCS:CacheSpellData(31252, "Prospecting");
ABGCS:CacheSpellData(53428, "Runeforging");
ABGCS:CacheSpellData(2656, "Smelting");
ABGCS:CacheSpellData(80451, "Survey");
ABGCS:CacheSpellData(26790, "Tailoring");
ABGCS:CacheSpellData(131474, "Fishing");
ABGCS:CacheSpellData(201891, "Undercurrent");

local cache_timer_stop = debugprofilestop();

ABGData.timing["CacheSpellData.lua"] = cache_timer_stop - cache_timer_start;
