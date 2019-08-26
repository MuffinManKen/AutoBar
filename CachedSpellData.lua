
local ABGCS = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject

-- NOTE: This entire set of code runs in ~2ms, so no need to try to optimize it
local cache_timer_start = debugprofilestop();
--All
ABGCS:CacheSpellData(83958, "Mobile Banking");
ABGCS:CacheSpellData(58984, "Shadowmeld");


--Druid
ABGCS:CacheSpellData(22812, "Barkskin");
ABGCS:CacheSpellData(99, "Disorienting Roar");
ABGCS:CacheSpellData(102342, "Ironbark");
ABGCS:CacheSpellData(5215, "Prowl");
ABGCS:CacheSpellData(22842, "Frenzied Regeneration");
ABGCS:CacheSpellData(102401, "Wild Charge");
ABGCS:CacheSpellData(5487, "Bear Form");
ABGCS:CacheSpellData(33917, "Mangle");
ABGCS:CacheSpellData(768, "Cat Form");
ABGCS:CacheSpellData(197625, "Moonkin Form");
ABGCS:CacheSpellData(114282, "Treant Form");
ABGCS:CacheSpellData(210053, "Stag Form");
ABGCS:CacheSpellData(33943, "Flight Form");
ABGCS:CacheSpellData(40120, "Swift Flight Form");
ABGCS:CacheSpellData(783, "Travel Form");
ABGCS:CacheSpellData(18960, "Teleport: Moonglade");
ABGCS:CacheSpellData(193753, "Dreamwalk");

--Hunter
ABGCS:CacheSpellData(61648, "Aspect of the Chameleon");
ABGCS:CacheSpellData(186257, "Aspect of the Cheetah");
ABGCS:CacheSpellData(186289, "Aspect of the Eagle");
ABGCS:CacheSpellData(186265, "Aspect of the Turtle");
ABGCS:CacheSpellData(193530, "Aspect of the Wild");
ABGCS:CacheSpellData(1462, "Beast Lore");
ABGCS:CacheSpellData(19574, "Bestial Wrath");
ABGCS:CacheSpellData(109248, "Binding Shot");
ABGCS:CacheSpellData(883, "Call Pet 1"); 
ABGCS:CacheSpellData(83242, "Call Pet 2");
ABGCS:CacheSpellData(83243, "Call Pet 3");
ABGCS:CacheSpellData(83244, "Call Pet 4");
ABGCS:CacheSpellData(83245, "Call Pet 5");
ABGCS:CacheSpellData(199483, "Camouflage");
ABGCS:CacheSpellData(5116, "Concussive Shot");
ABGCS:CacheSpellData(147362, "Counter Shot");
ABGCS:CacheSpellData(120679, "Dire Beast");
ABGCS:CacheSpellData(217200, "Dire Frenzy");
ABGCS:CacheSpellData(781, "Disengage");
ABGCS:CacheSpellData(2641, "Dismiss Pet");
ABGCS:CacheSpellData(6197, "Eagle Eye");
ABGCS:CacheSpellData(6991, "Feed Pet");
ABGCS:CacheSpellData(5384, "Feign Death");
ABGCS:CacheSpellData(125050, "Fetch");
ABGCS:CacheSpellData(190925, "Harpoon");
ABGCS:CacheSpellData(7093, "Intimidation");
ABGCS:CacheSpellData(34026, "Kill Command");
ABGCS:CacheSpellData(53271, "Master's Call");
ABGCS:CacheSpellData(136, "Mend Pet");
ABGCS:CacheSpellData(209997, "Play Dead");
ABGCS:CacheSpellData(200108, "Ranger's Net");
ABGCS:CacheSpellData(982, "Revive Pet");
ABGCS:CacheSpellData(206817, "Sentinel");
ABGCS:CacheSpellData(1515, "Tame Beast");
ABGCS:CacheSpellData(210000, "Wake Up");
ABGCS:CacheSpellData(195645, "Wing Clip");
ABGCS:CacheSpellData(187650, "Freezing Trap");
ABGCS:CacheSpellData(191433, "Explosive Trap");
ABGCS:CacheSpellData(187698, "Tar Trap");
ABGCS:CacheSpellData(194277, "Caltrops");
ABGCS:CacheSpellData(162488, "Steel Trap");


--Mage
ABGCS:CacheSpellData(11426, "Ice Barrier");
ABGCS:CacheSpellData(235450, "Prismatic Barrier");
ABGCS:CacheSpellData(235313, "Blazing Barrier");
ABGCS:CacheSpellData(198111, "Temporal Shield");
ABGCS:CacheSpellData(130, "Slow Fall");
--ABGCS:CacheSpellData(42955, "Conjure Refreshment");
--ABGCS:CacheSpellData(43987, "Conjure Refreshment Table");
ABGCS:CacheSpellData(66, "Invisibility");
ABGCS:CacheSpellData(110959, "Greater Invisibility");
ABGCS:CacheSpellData(27619, "Ice Block");
ABGCS:CacheSpellData(31687, "Summon Water Elemental");
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
ABGCS:CacheSpellData(11419, "Portal: Darnassus");
ABGCS:CacheSpellData(3565, "Teleport: Darnassus");
ABGCS:CacheSpellData(11416, "Portal: Ironforge");
ABGCS:CacheSpellData(3562, "Teleport: Ironforge");
ABGCS:CacheSpellData(11417, "Portal: Orgrimmar");
ABGCS:CacheSpellData(3567, "Teleport: Orgrimmar");

--Paladin
ABGCS:CacheSpellData(31850, "Ardent Defender"); 
ABGCS:CacheSpellData(642, "Divine Shield"); 
ABGCS:CacheSpellData(1044, "Blessing of Freedom"); 
ABGCS:CacheSpellData(1022, "Blessing of Protection"); 
ABGCS:CacheSpellData(6940, "Blessing of Sacrifice"); 
ABGCS:CacheSpellData(204018, "Blessing of Spellwarding"); 
ABGCS:CacheSpellData(204013, "Blessing of Salvation"); 
ABGCS:CacheSpellData(203538, "Greater Blessing of Kings"); 
ABGCS:CacheSpellData(203539, "Greater Blessing of Wisdom"); 
ABGCS:CacheSpellData(183218, "Hand of Hindrance");
ABGCS:CacheSpellData(96231, "Rebuke");
ABGCS:CacheSpellData(633, "Lay on Hands");

ABGCS:CacheSpellData(19740, "Blessing of Might"); --y

ABGCS:CacheSpellData(465, "Devotion Aura"); --y		TODO: Add Auras




--Priest
ABGCS:CacheSpellData(17, "Power Word: Shield");
ABGCS:CacheSpellData(34433, "Shadowfiend");
ABGCS:CacheSpellData(47585, "Dispersion");
ABGCS:CacheSpellData(47788, "Guardian Spirit");
ABGCS:CacheSpellData(33206, "Pain Suppression");
ABGCS:CacheSpellData(15487, "Silence");

--Rogue
ABGCS:CacheSpellData(200802, "Agonizing Poison");
ABGCS:CacheSpellData(3408, "Crippling Poison");
ABGCS:CacheSpellData(2823, "Deadly Poison");
ABGCS:CacheSpellData(4086, "Evasion");
ABGCS:CacheSpellData(1766, "Kick");
ABGCS:CacheSpellData(108211, "Leeching Poison");
ABGCS:CacheSpellData(199754, "Riposte");
ABGCS:CacheSpellData(36554, "Shadowstep");
ABGCS:CacheSpellData(1784, "Stealth");
ABGCS:CacheSpellData(1856, "Vanish");
ABGCS:CacheSpellData(8679, "Wound Poison");
ABGCS:CacheSpellData(2094, "Blind");
ABGCS:CacheSpellData(6770, "Sap");


--Shaman
ABGCS:CacheSpellData(2484, "Earthbind Totem");
ABGCS:CacheSpellData(51485, "Earthgrab Totem");
ABGCS:CacheSpellData(51533, "Feral Spirit");
ABGCS:CacheSpellData(546, "Water Walking");
ABGCS:CacheSpellData(192077, "Wind Rush Totem");
ABGCS:CacheSpellData(2645, "Ghost Wolf");
ABGCS:CacheSpellData(198103, "Earth Elemental");
ABGCS:CacheSpellData(198067, "Fire Elemental");
ABGCS:CacheSpellData(192249, "Storm Elemental");
ABGCS:CacheSpellData(556, "Astral Recall");
ABGCS:CacheSpellData(207399, "Ancestral Protection Totem");
ABGCS:CacheSpellData(198838, "Earthen Shield Totem");
ABGCS:CacheSpellData(61882, "Earthquake Totem");
ABGCS:CacheSpellData(192058, "Lightning Surge Totem");
ABGCS:CacheSpellData(196932, "Voodoo Totem");
ABGCS:CacheSpellData(157153, "Cloudburst Totem");
ABGCS:CacheSpellData(192222, "Liquid Magma Totem"); 
ABGCS:CacheSpellData(5394, "Healing Stream Totem");
ABGCS:CacheSpellData(108280, "Healing Tide Totem");
ABGCS:CacheSpellData(98008, "Spirit Link Totem");


--Warlock
ABGCS:CacheSpellData(687, "Demon Skin");	--y


ABGCS:CacheSpellData(104316, "Call Dreadstalkers"); 
ABGCS:CacheSpellData(119898, "Command Demon"); 
ABGCS:CacheSpellData(199954, "Curse of Fragility"); 
ABGCS:CacheSpellData(199890, "Curse of Tongues"); 
ABGCS:CacheSpellData(702, "Curse of Weakness"); --y
ABGCS:CacheSpellData(108416, "Dark Pact");
ABGCS:CacheSpellData(193396, "Demonic Empowerment"); 
ABGCS:CacheSpellData(193440, "Demonwrath"); 
ABGCS:CacheSpellData(108503, "Grimoire of Sacrifice"); 
ABGCS:CacheSpellData(111897, "Grimoire: Felhunter"); 
ABGCS:CacheSpellData(20707, "Soulstone"); 
ABGCS:CacheSpellData(205180, "Summon Darkglare"); 
ABGCS:CacheSpellData(5697, "Unending Breath");
ABGCS:CacheSpellData(104773, "Unending Resolve");
ABGCS:CacheSpellData(6201, "Create Healthstone");
ABGCS:CacheSpellData(29893, "Ritual of Souls");
ABGCS:CacheSpellData(126, "RitualSouls");
ABGCS:CacheSpellData(30146, "Eye of Kilrogg");
ABGCS:CacheSpellData(691, "Summon Felhunter");
ABGCS:CacheSpellData(688, "Summon Imp");   -- y
ABGCS:CacheSpellData(712, "Summon Succubus");
ABGCS:CacheSpellData(697, "Summon Voidwalker");
ABGCS:CacheSpellData(1122, "Summon Infernal");
ABGCS:CacheSpellData(30146, "Summon Felguard");
ABGCS:CacheSpellData(698, "Ritual of Summoning");

--Warrior
ABGCS:CacheSpellData(100, "Charge");
ABGCS:CacheSpellData(97462, "Commanding Shout");
ABGCS:CacheSpellData(197690, "Defensive Stance");
ABGCS:CacheSpellData(1160, "Demoralizing Shout");
ABGCS:CacheSpellData(184364, "Enraged Regeneration");
ABGCS:CacheSpellData(198304, "Intercept");
ABGCS:CacheSpellData(2565, "Shield Block"); 
ABGCS:CacheSpellData(871, "Shield Wall"); 
ABGCS:CacheSpellData(12975, "Last Stand");

--Skills
ABGCS:CacheSpellData(3273, "First Aid"); --y
ABGCS:CacheSpellData(2259, "Alchemy"); --y
ABGCS:CacheSpellData(818, "Basic Campfire"); --y
ABGCS:CacheSpellData(2018, "Blacksmithing"); --y
ABGCS:CacheSpellData(2550, "Cooking");	--y
ABGCS:CacheSpellData(13262, "Disenchant"); --y
ABGCS:CacheSpellData(7411, "Enchanting");  --y
ABGCS:CacheSpellData(4036, "Engineering"); --y
ABGCS:CacheSpellData(2108, "Leatherworking"); --y
ABGCS:CacheSpellData(2656, "Smelting"); --y
ABGCS:CacheSpellData(3908, "Tailoring"); --y
ABGCS:CacheSpellData(7620, "Fishing"); --y
ABGCS:CacheSpellData(2580, "Find Minerals"); --y
ABGCS:CacheSpellData(2383, "Find Herbs"); --y


local cache_timer_stop = debugprofilestop();

ABGData.timing["CacheSpellData.lua"] = cache_timer_stop - cache_timer_start;
