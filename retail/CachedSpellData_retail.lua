local _ADDON_NAME, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

local ABGData = AutoBarGlobalDataObject

-- NOTE: This entire set of code runs in ~2ms, so no need to try to optimize it
local cache_timer_start = debugprofilestop();
--All
AB.CacheSpellData(125439, "Revive Battle Pets");
AB.CacheSpellData(83958, "Mobile Banking");
AB.CacheSpellData(58984, "Shadowmeld");
AB.CacheSpellData(87840, "Running Wild");
AB.CacheSpellData(265225, "Mole Machine");
AB.CacheSpellData(131204, "Path of the Jade Serpent");
AB.CacheSpellData(131205, "Path of the Stout Brew");
AB.CacheSpellData(131206, "Path of the Shado-Pan");
AB.CacheSpellData(131222, "Path of the Mogu King");
AB.CacheSpellData(131225, "Path of the Setting Sun");
AB.CacheSpellData(131231, "Path of the Scarlet Blade");
AB.CacheSpellData(131229, "Path of the Scarlet Mitre");
AB.CacheSpellData(131232, "Path of the Necromancer");
AB.CacheSpellData(131228, "Path of the Black Ox");


--#region DeathKnight
AB.CacheSpellData(3714, "Path of Frost");
AB.CacheSpellData(63560, "Dark Transformation");
AB.CacheSpellData(45524, "Chains of Ice");
AB.CacheSpellData(48707, "Anti-Magic Shell");
AB.CacheSpellData(48792, "Icebound Fortitude");
AB.CacheSpellData(47528, "Mind Freeze");
AB.CacheSpellData(194679, "Rune Tap");
AB.CacheSpellData(49028, "Dancing Rune Weapon");
AB.CacheSpellData(46584, "Raise Dead");
AB.CacheSpellData(49206, "Summon Gargoyle");
AB.CacheSpellData(42650, "Army of the Dead");
AB.CacheSpellData(50977, "Death Gate");
--#endregion


--#region DemonHunter
AB.CacheSpellData(195072, "Fel Rush");
AB.CacheSpellData(198793, "Vengeful Retreat");
AB.CacheSpellData(198589, "Blur");
AB.CacheSpellData(196718, "Darkness");
AB.CacheSpellData(204596, "Sigil of Flame");
AB.CacheSpellData(207684, "Sigil of Misery");
AB.CacheSpellData(202137, "Sigil of Silence");
AB.CacheSpellData(183752, "Disrupt");
--#endregion


--#region Druid
AB.CacheSpellData(22812, "Barkskin");
AB.CacheSpellData(5487, "Bear Form");
AB.CacheSpellData(768, "Cat Form");
AB.CacheSpellData(193753, "Dreamwalk");
AB.CacheSpellData(339, "Entangling Roots");
AB.CacheSpellData(22842, "Frenzied Regeneration");
AB.CacheSpellData(99, "Incapacitating Roar");
AB.CacheSpellData(102342, "Ironbark");
AB.CacheSpellData(5215, "Prowl");
AB.CacheSpellData(1126, "Mark of the Wild");
AB.CacheSpellData(197625, "Moonkin Form");
AB.CacheSpellData(114282, "Treant Form");
AB.CacheSpellData(106839, "Skull Bash");
AB.CacheSpellData(210053, "Mount Form");
AB.CacheSpellData(783, "Travel Form");
AB.CacheSpellData(18960, "Teleport: Moonglade");
AB.CacheSpellData(102401, "Wild Charge");
--#endregion

--#region Evoker
AB.CacheSpellData(364342, "Blessing of the Bronze");
--#endregion Evoker

--#region Hunter
AB.CacheSpellData(61648, "Aspect of the Chameleon");
AB.CacheSpellData(186257, "Aspect of the Cheetah");
AB.CacheSpellData(186289, "Aspect of the Eagle");
AB.CacheSpellData(186265, "Aspect of the Turtle");
AB.CacheSpellData(193530, "Aspect of the Wild");
AB.CacheSpellData(1462, "Beast Lore");
AB.CacheSpellData(19574, "Bestial Wrath");
AB.CacheSpellData(109248, "Binding Shot");
AB.CacheSpellData(883, "Call Pet 1");
AB.CacheSpellData(83242, "Call Pet 2");
AB.CacheSpellData(83243, "Call Pet 3");
AB.CacheSpellData(83244, "Call Pet 4");
AB.CacheSpellData(83245, "Call Pet 5");
AB.CacheSpellData(199483, "Camouflage");
AB.CacheSpellData(5116, "Concussive Shot");
AB.CacheSpellData(147362, "Counter Shot");
AB.CacheSpellData(120679, "Dire Beast");
AB.CacheSpellData(781, "Disengage");
AB.CacheSpellData(2641, "Dismiss Pet");
AB.CacheSpellData(6197, "Eagle Eye");
AB.CacheSpellData(321297, "Eyes of the Beast");
AB.CacheSpellData(6991, "Feed Pet");
AB.CacheSpellData(5384, "Feign Death");
AB.CacheSpellData(125050, "Fetch");
AB.CacheSpellData(190925, "Harpoon");
AB.CacheSpellData(7093, "Intimidation");
AB.CacheSpellData(34026, "Kill Command");
AB.CacheSpellData(53271, "Master's Call");
AB.CacheSpellData(136, "Mend Pet");
AB.CacheSpellData(209997, "Play Dead");
AB.CacheSpellData(982, "Revive Pet");
AB.CacheSpellData(1515, "Tame Beast");
AB.CacheSpellData(210000, "Wake Up");
AB.CacheSpellData(195645, "Wing Clip");
AB.CacheSpellData(187650, "Freezing Trap");
AB.CacheSpellData(187698, "Tar Trap");
AB.CacheSpellData(162488, "Steel Trap");
--#endregion


--#region Mage
AB.CacheSpellData(1459, "Arcane Intellect");
AB.CacheSpellData(235313, "Blazing Barrier");
AB.CacheSpellData(42955, "Conjure Refreshment");
AB.CacheSpellData(759, "Conjure Mana Gem");
AB.CacheSpellData(2139, "Counterspell");
AB.CacheSpellData(110959, "Greater Invisibility");
AB.CacheSpellData(11426, "Ice Barrier");
AB.CacheSpellData(27619, "Ice Block");
AB.CacheSpellData(66, "Invisibility");
AB.CacheSpellData(235450, "Prismatic Barrier");
AB.CacheSpellData(130, "Slow Fall");
AB.CacheSpellData(31687, "Summon Water Elemental");
AB.CacheSpellData(198111, "Temporal Shield");

AB.CacheSpellData(33691, "Portal: Shattrath");
AB.CacheSpellData(35715, "Teleport: Shattrath");
AB.CacheSpellData(49361, "Portal: Stonard");
AB.CacheSpellData(49358, "Teleport: Stonard");
AB.CacheSpellData(49360, "Portal: Theramore");
AB.CacheSpellData(49359, "Teleport: Theramore");
AB.CacheSpellData(11418, "Portal: Undercity");
AB.CacheSpellData(3563, "Teleport: Undercity");
AB.CacheSpellData(11420, "Portal: Thunder Bluff");
AB.CacheSpellData(3566, "Teleport: Thunder Bluff");
AB.CacheSpellData(10059, "Portal: Stormwind");
AB.CacheSpellData(3561, "Teleport: Stormwind");
AB.CacheSpellData(32267, "Portal: Silvermoon");
AB.CacheSpellData(32272, "Teleport: Silvermoon");
AB.CacheSpellData(32266, "Portal: Exodar");
AB.CacheSpellData(32271, "Teleport: Exodar");
AB.CacheSpellData(11419, "Portal: Darnassus");
AB.CacheSpellData(3565, "Teleport: Darnassus");
AB.CacheSpellData(11416, "Portal: Ironforge");
AB.CacheSpellData(3562, "Teleport: Ironforge");
AB.CacheSpellData(11417, "Portal: Orgrimmar");
AB.CacheSpellData(3567, "Teleport: Orgrimmar");
AB.CacheSpellData(53142, "Portal: Dalaran");
AB.CacheSpellData(53140, "Teleport: Dalaran");
AB.CacheSpellData(224871, "Portal: Dalaran - Broken Isles");
AB.CacheSpellData(224869, "Teleport: Dalaran - Broken Isles");

AB.CacheSpellData(88344, "Teleport: Tol Barad - Horde");
AB.CacheSpellData(88346, "Portal: Tol Barad - Horde");
AB.CacheSpellData(88342, "Teleport: Tol Barad - Alliance");
AB.CacheSpellData(88345, "Portal: Tol Barad - Alliance");

AB.CacheSpellData(132621, "Teleport: Vale of Eternal Blossoms - Alliance");
AB.CacheSpellData(132620, "Portal: Vale of Eternal Blossoms - Alliance");
AB.CacheSpellData(132627, "Teleport: Vale of Eternal Blossoms - Horde");
AB.CacheSpellData(132626, "Portal: Vale of Eternal Blossoms - Horde");

AB.CacheSpellData(176248, "Teleport: Stormshield");
AB.CacheSpellData(176246, "Portal: Stormshield");
AB.CacheSpellData(176242, "Teleport: Warspear");
AB.CacheSpellData(176244, "Portal: Warspear");
AB.CacheSpellData(120145, "Teleport: Ancient Dalaran");
AB.CacheSpellData(120146, "Portal: Ancient Dalaran");

AB.CacheSpellData(204287, "Teleport: Hall of the Guardian");

AB.CacheSpellData(281403, "Teleport: Boralus");
AB.CacheSpellData(281400, "Portal: Boralus");
AB.CacheSpellData(281404, "Teleport: Dazar'alor");
AB.CacheSpellData(281402, "Portal: Dazar'alor");

AB.CacheSpellData(344587, "Teleport: Oribos");
AB.CacheSpellData(344597, "Portal: Oribos");

AB.CacheSpellData(395277, "Teleport: Valdrakken");
AB.CacheSpellData(395289, "Portal: Valdrakken");
--#endregion


--#region Monk
AB.CacheSpellData(126892, "Zen Pilgrimage");
AB.CacheSpellData(126895, "Zen Pilgrimage: Return");
AB.CacheSpellData(115203, "Fortifying Brew");
AB.CacheSpellData(116705, "Spear Hand Strike");
AB.CacheSpellData(137639, "Storm, Earth, and Fire");
--#endregion


--#region Paladin
AB.CacheSpellData(31850, "Ardent Defender");
AB.CacheSpellData(642, "Divine Shield");
AB.CacheSpellData(1044, "Blessing of Freedom");
AB.CacheSpellData(1022, "Blessing of Protection");
AB.CacheSpellData(6940, "Blessing of Sacrifice");
AB.CacheSpellData(204018, "Blessing of Spellwarding");
AB.CacheSpellData(183218, "Hand of Hindrance");
AB.CacheSpellData(96231, "Rebuke");
AB.CacheSpellData(633, "Lay on Hands");
AB.CacheSpellData(317920, "Concentration Aura");
AB.CacheSpellData(32223, "Crusader Aura");
AB.CacheSpellData(465, "Devotion Aura");
AB.CacheSpellData(183435, "Retribution Aura");
--#endregion


--#region Priest
AB.CacheSpellData(17, "Power Word: Shield");
AB.CacheSpellData(62618, "Power Word: Barrier");
AB.CacheSpellData(34433, "Shadowfiend");
AB.CacheSpellData(47585, "Dispersion");
AB.CacheSpellData(47788, "Guardian Spirit");
AB.CacheSpellData(33206, "Pain Suppression");
AB.CacheSpellData(15487, "Silence");
AB.CacheSpellData(1706, "Levitate");
AB.CacheSpellData(21562, "Power Word: Fortitude");
--#endregion


--#region Rogue
AB.CacheSpellData(381664, "Amplifying Poison");
AB.CacheSpellData(381637, "Atrophic Poison");
AB.CacheSpellData(3408, "Crippling Poison");
AB.CacheSpellData(2823, "Deadly Poison");
AB.CacheSpellData(315584, "Instant Poison");
AB.CacheSpellData(5761, "Numbing Poison");
AB.CacheSpellData(8679, "Wound Poison");
AB.CacheSpellData(5277, "Evasion");
AB.CacheSpellData(1766, "Kick");
AB.CacheSpellData(36554, "Shadowstep");
AB.CacheSpellData(1784, "Stealth");
AB.CacheSpellData(1856, "Vanish");
AB.CacheSpellData(271877, "Blade Rush");
--#endregion


--#region Shaman
AB.CacheSpellData(556, "Astral Recall");
AB.CacheSpellData(198103, "Earth Elemental");
AB.CacheSpellData(51533, "Feral Spirit");
AB.CacheSpellData(198067, "Fire Elemental");
AB.CacheSpellData(2645, "Ghost Wolf");
AB.CacheSpellData(192249, "Storm Elemental");
AB.CacheSpellData(546, "Water Walking");
AB.CacheSpellData(57994, "Wind Shear");

AB.CacheSpellData(207399, "Ancestral Protection Totem");
AB.CacheSpellData(157153, "Cloudburst Totem");
AB.CacheSpellData(192058, "Capacitor Totem");
AB.CacheSpellData(2484, "Earthbind Totem");
AB.CacheSpellData(198838, "Earthen Wall Totem");
AB.CacheSpellData(51485, "Earthgrab Totem");
AB.CacheSpellData(5394, "Healing Stream Totem");
AB.CacheSpellData(108280, "Healing Tide Totem");
AB.CacheSpellData(192222, "Liquid Magma Totem");
AB.CacheSpellData(16191, "Mana Tide Totem");
AB.CacheSpellData(98008, "Spirit Link Totem");
AB.CacheSpellData(192077, "Wind Rush Totem");
--#endregion


--#region Warlock
AB.CacheSpellData(104316, "Call Dreadstalkers");
AB.CacheSpellData(119898, "Command Demon");
AB.CacheSpellData(1714, "Curse of Tongues");	--y
AB.CacheSpellData(702, "Curse of Weakness");	--y
AB.CacheSpellData(334275, "Curse of Exhaustion");	--y

AB.CacheSpellData(108416, "Dark Pact");
AB.CacheSpellData(108503, "Grimoire of Sacrifice");
AB.CacheSpellData(20707, "Soulstone");	--y
AB.CacheSpellData(5697, "Unending Breath");	--y
AB.CacheSpellData(104773, "Unending Resolve");
AB.CacheSpellData(6201, "Create Healthstone");--y
AB.CacheSpellData(29893, "Create Soulwell");	--y
AB.CacheSpellData(126, "Eye of Kilrogg");--y
AB.CacheSpellData(691, "Summon Felhunter");--y
AB.CacheSpellData(688, "Summon Imp");--y
AB.CacheSpellData(712, "Summon Succubus");--y
AB.CacheSpellData(697, "Summon Voidwalker");	--y
AB.CacheSpellData(1122, "Summon Infernal");
AB.CacheSpellData(30146, "Summon Felguard");
AB.CacheSpellData(205180, "Summon Darkglare");--y
AB.CacheSpellData(265187, "Summon Demonic Tyrant");
AB.CacheSpellData(698, "Ritual of Summoning");
--#endregion


--#region Warrior
AB.CacheSpellData(6673, "Battle Shout");
AB.CacheSpellData(100, "Charge");
AB.CacheSpellData(97462, "Rallying Cry");
AB.CacheSpellData(197690, "Defensive Stance");
AB.CacheSpellData(1160, "Demoralizing Shout");
AB.CacheSpellData(184364, "Enraged Regeneration");
AB.CacheSpellData(3411, "Intervene");
AB.CacheSpellData(12975, "Last Stand");
AB.CacheSpellData(6552, "Pummel");
AB.CacheSpellData(2565, "Shield Block");
AB.CacheSpellData(871, "Shield Wall");
--#endregion


--#region Skills
AB.CacheSpellData(28596, "Alchemy");
AB.CacheSpellData(818, "Cooking Fire");
AB.CacheSpellData(29844, "Blacksmithing");
AB.CacheSpellData(33359, "Cooking");
AB.CacheSpellData(78670, "Archaeology");
AB.CacheSpellData(13262, "Disenchant");
AB.CacheSpellData(28029, "Enchanting");
AB.CacheSpellData(30350, "Engineering");
AB.CacheSpellData(45357, "Inscription");
AB.CacheSpellData(28897, "Jewelcrafting");
AB.CacheSpellData(32549, "Leatherworking");
AB.CacheSpellData(51005, "Milling");
AB.CacheSpellData(31252, "Prospecting");
AB.CacheSpellData(53428, "Runeforging");
AB.CacheSpellData(2656, "Smelting");
AB.CacheSpellData(80451, "Survey");
AB.CacheSpellData(26790, "Tailoring");
AB.CacheSpellData(131474, "Fishing");
AB.CacheSpellData(201891, "Undercurrent");

AB.CacheSpellData(194174, "Skinning Journal");
AB.CacheSpellData(271990, "Fishing Journal");
AB.CacheSpellData(193290, "Herbalism Journal");
AB.CacheSpellData(2656, "Mining Journal");
--#endregion

local cache_timer_stop = debugprofilestop();

ABGData.timing["CacheSpellData.lua"] = cache_timer_stop - cache_timer_start;
