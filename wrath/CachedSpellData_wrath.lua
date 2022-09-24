
local ABGCS = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject

-- NOTE: This entire set of code runs in ~2ms, so no need to try to optimize it
local cache_timer_start = debugprofilestop();

--All
ABGCS.CacheSpellData(58984, "Shadowmeld");



--Druid
ABGCS.CacheSpellData(22812, "Barkskin");
ABGCS.CacheSpellData(99, "Disorienting Roar");
ABGCS.CacheSpellData(5215, "Prowl");
ABGCS.CacheSpellData(22842, "Frenzied Regeneration");
ABGCS.CacheSpellData(22570, "Mangle");
ABGCS.CacheSpellData(1126, "Mark of the Wild");
ABGCS.CacheSpellData(21849, "Gift of the Wild");
ABGCS.CacheSpellData(467, "Thorns");
ABGCS.CacheSpellData(5487, "Bear Form");
ABGCS.CacheSpellData(9634, "Dire Bear Form");
ABGCS.CacheSpellData(768, "Cat Form");
ABGCS.CacheSpellData(1066, "Aquatic Form");
ABGCS.CacheSpellData(24858, "Moonkin Form");
--ABGCS.CacheSpellData(775, "Tree Form");
ABGCS.CacheSpellData(783, "Travel Form");
ABGCS.CacheSpellData(33943, "Flight Form");
ABGCS.CacheSpellData(40120, "Swift Flight Form");
ABGCS.CacheSpellData(18960, "Teleport: Moonglade");

--#region DeathKnight
ABGCS.CacheSpellData(48265, "Unholy Presence");
ABGCS.CacheSpellData(48263, "Frost Presence");
ABGCS.CacheSpellData(48266, "Blood Presence");
ABGCS.CacheSpellData(48707, "Anti-Magic Shell");
ABGCS.CacheSpellData(51052, "Anti-Magic Zone");
ABGCS.CacheSpellData(3714, "Path of Frost");
ABGCS.CacheSpellData(57330, "Horn of Winter");
ABGCS.CacheSpellData(56222, "Dark Command");
ABGCS.CacheSpellData(45529, "Blood Tap");
ABGCS.CacheSpellData(48792, "Icebound Fortitude");
ABGCS.CacheSpellData(49576, "Death Grip");
ABGCS.CacheSpellData(48982, "Rune Tap");
ABGCS.CacheSpellData(55233, "Vampiric Blood");
ABGCS.CacheSpellData(47476, "Strangulate");
ABGCS.CacheSpellData(47528, "Mind Freeze");
ABGCS.CacheSpellData(46584, "Raise Dead");
ABGCS.CacheSpellData(49206, "Summon Gargoyle");
ABGCS.CacheSpellData(50977, "Death Gate");
--endregion


--#region Hunter
ABGCS.CacheSpellData(5118, "Aspect of the Cheetah");
ABGCS.CacheSpellData(13165, "Aspect of the Hawk");
ABGCS.CacheSpellData(13163, "Aspect of the Monkey");
ABGCS.CacheSpellData(20043, "Aspect of the Wild");
ABGCS.CacheSpellData(13159, "Aspect of the Pack");
ABGCS.CacheSpellData(13161, "Aspect of the Beast");
ABGCS.CacheSpellData(34074, "Aspect of the Viper");

ABGCS.CacheSpellData(1462, "Beast Lore");
ABGCS.CacheSpellData(19574, "Bestial Wrath");
ABGCS.CacheSpellData(883, "Call Pet");
ABGCS.CacheSpellData(5116, "Concussive Shot");
ABGCS.CacheSpellData(781, "Disengage");
ABGCS.CacheSpellData(2641, "Dismiss Pet");
ABGCS.CacheSpellData(6197, "Eagle Eye");
ABGCS.CacheSpellData(6991, "Feed Pet");
ABGCS.CacheSpellData(5384, "Feign Death");
ABGCS.CacheSpellData(19577, "Intimidation");
ABGCS.CacheSpellData(136, "Mend Pet");
ABGCS.CacheSpellData(982, "Revive Pet");
ABGCS.CacheSpellData(1515, "Tame Beast");
ABGCS.CacheSpellData(2974, "Wing Clip");

ABGCS.CacheSpellData(19883, "Track Humanoids");
ABGCS.CacheSpellData(19884, "Track Undead");
ABGCS.CacheSpellData(1494, "Track Beasts");
ABGCS.CacheSpellData(19885, "Track Hidden");
ABGCS.CacheSpellData(19878, "Track Demons");
ABGCS.CacheSpellData(19880, "Track Elementals");
ABGCS.CacheSpellData(19879, "Track Dragonkin");
ABGCS.CacheSpellData(19882, "Track Giants");

ABGCS.CacheSpellData(1499, "Freezing Trap");
ABGCS.CacheSpellData(13809, "Frost Trap");
ABGCS.CacheSpellData(13813, "Explosive Trap");
ABGCS.CacheSpellData(13795, "Immolation Trap");
ABGCS.CacheSpellData(34600, "Snake Trap");
--#endregion

--#region Mage
ABGCS.CacheSpellData(168, "Frost Armor");
ABGCS.CacheSpellData(7302, "Ice Armor");
ABGCS.CacheSpellData(6117, "Mage Armor");
ABGCS.CacheSpellData(30482, "Molten Armor");
ABGCS.CacheSpellData(27619, "Ice Block");
ABGCS.CacheSpellData(11426, "Ice Barrier");

ABGCS.CacheSpellData(1459, "Arcane Intellect");
ABGCS.CacheSpellData(23028, "Arcane Brilliance");
ABGCS.CacheSpellData(130, "Slow Fall");
ABGCS.CacheSpellData(1008, "Amplify Magic");
ABGCS.CacheSpellData(604, "Dampen Magic");

ABGCS.CacheSpellData(5504, "Conjure Water");
ABGCS.CacheSpellData(587, "Conjure Food");

ABGCS.CacheSpellData(759, "Conjure Mana Gem");

ABGCS.CacheSpellData(43987, "Ritual of Refreshment");

ABGCS.CacheSpellData(31687, "Summon Water Elemental");

ABGCS.CacheSpellData(66, "Invisibility");

ABGCS.CacheSpellData(11418, "Portal: Undercity");
ABGCS.CacheSpellData(3563, "Teleport: Undercity");
ABGCS.CacheSpellData(11420, "Portal: Thunder Bluff");
ABGCS.CacheSpellData(3566, "Teleport: Thunder Bluff");
ABGCS.CacheSpellData(10059, "Portal: Stormwind");
ABGCS.CacheSpellData(3561, "Teleport: Stormwind");
ABGCS.CacheSpellData(11419, "Portal: Darnassus");
ABGCS.CacheSpellData(3565, "Teleport: Darnassus");
ABGCS.CacheSpellData(11416, "Portal: Ironforge");
ABGCS.CacheSpellData(3562, "Teleport: Ironforge");
ABGCS.CacheSpellData(11417, "Portal: Orgrimmar");
ABGCS.CacheSpellData(3567, "Teleport: Orgrimmar");
ABGCS.CacheSpellData(49361, "Portal: Stonard");
ABGCS.CacheSpellData(49360, "Portal: Theramore");
ABGCS.CacheSpellData(32266, "Portal: Exodar");
ABGCS.CacheSpellData(32267, "Portal: Silvermoon");
ABGCS.CacheSpellData(33691, "Portal: Shattrath - Alliance");
ABGCS.CacheSpellData(35717, "Portal: Shattrath - Horde");
ABGCS.CacheSpellData(49358, "Teleport: Stonard");
ABGCS.CacheSpellData(49359, "Teleport: Theramore");
ABGCS.CacheSpellData(32271, "Teleport: Exodar");
ABGCS.CacheSpellData(32272, "Teleport: Silvermoon");
ABGCS.CacheSpellData(33690, "Teleport: Shattrath - Alliance");
ABGCS.CacheSpellData(35715, "Teleport: Shattrath - Horde");
--#endregion

--#region Paladin
ABGCS.CacheSpellData(498, "Divine Protection");
ABGCS.CacheSpellData(642, "Divine Shield");
-- ABGCS.CacheSpellData(64205, "Divine Sacrifice"); -- Prot, Not sure where to put it

ABGCS.CacheSpellData(19740, "Blessing of Might");
ABGCS.CacheSpellData(25782, "Greater Blessing of Might");
ABGCS.CacheSpellData(19742, "Blessing of Wisdom");
ABGCS.CacheSpellData(25894, "Greater Blessing of Wisdom");
ABGCS.CacheSpellData(20217, "Blessing of Kings");
ABGCS.CacheSpellData(25898, "Greater Blessing of Kings");
ABGCS.CacheSpellData(20911, "Blessing of Sanctuary");
ABGCS.CacheSpellData(25899, "Greater Blessing of Sanctuary");

ABGCS.CacheSpellData(633, "Lay on Hands");

ABGCS.CacheSpellData(1044, "Hand of Freedom");
ABGCS.CacheSpellData(1022, "Hand of Protection");
ABGCS.CacheSpellData(6940, "Hand of Sacrifice");
ABGCS.CacheSpellData(1038, "Hand of Salvation");

ABGCS.CacheSpellData(32223, "Crusader Aura");
ABGCS.CacheSpellData(465, "Devotion Aura");
ABGCS.CacheSpellData(7294, "Retribution Aura");
ABGCS.CacheSpellData(19746, "Concentration Aura");
ABGCS.CacheSpellData(19891, "Fire Resistance Aura");
ABGCS.CacheSpellData(19888, "Frost Resistance Aura");
ABGCS.CacheSpellData(19876, "Shadow Resistance Aura");

ABGCS.CacheSpellData(5502, "Sense Undead");

ABGCS.CacheSpellData(20375, "Seal of Command"); -- Ret
ABGCS.CacheSpellData(20164, "Seal of Justice");
ABGCS.CacheSpellData(20165, "Seal of Light");
ABGCS.CacheSpellData(20154, "Seal of Righteousness");
ABGCS.CacheSpellData(20166, "Seal of Wisdom");
ABGCS.CacheSpellData(31801, "Seal of Vengeance"); -- Alliance
ABGCS.CacheSpellData(53736, "Seal of Corruption"); -- Horde
--#endregion

--#region Priest
ABGCS.CacheSpellData(588, "Inner Fire");
ABGCS.CacheSpellData(1243, "Power Word: Fortitude");
ABGCS.CacheSpellData(21562, "Prayer of Fortitude");
ABGCS.CacheSpellData(17, "Power Word: Shield");
ABGCS.CacheSpellData(15487, "Silence");
ABGCS.CacheSpellData(976, "Shadow Protection");
ABGCS.CacheSpellData(27683, "Prayer of Shadow Protection");
ABGCS.CacheSpellData(34433, "Shadowfiend");
ABGCS.CacheSpellData(6346, "Fear Ward");
ABGCS.CacheSpellData(14752, "Divine Spirit");
ABGCS.CacheSpellData(27681, "Prayer of Spirit");
--#endregion

--Rogue
ABGCS.CacheSpellData(1842, "Disarm Trap");
ABGCS.CacheSpellData(4086, "Evasion");
ABGCS.CacheSpellData(1766, "Kick");
ABGCS.CacheSpellData(1784, "Stealth");
ABGCS.CacheSpellData(1856, "Vanish");
ABGCS.CacheSpellData(2094, "Blind");
ABGCS.CacheSpellData(6770, "Sap");
ABGCS.CacheSpellData(36554, "Shadowstep");


--#region Shaman
ABGCS.CacheSpellData(51730, "Earthliving Weapon");
ABGCS.CacheSpellData(8024, "Flametongue Weapon");
ABGCS.CacheSpellData(8033, "Frostbrand Weapon");
ABGCS.CacheSpellData(8017, "Rockbiter Weapon");
ABGCS.CacheSpellData(8232, "Windfury Weapon");

ABGCS.CacheSpellData(8042, "Earth Shock");

--Air totems
ABGCS.CacheSpellData(8177, "Grounding Totem");
ABGCS.CacheSpellData(10595, "Nature Resistance Totem");
ABGCS.CacheSpellData(6495, "Sentry Totem");
ABGCS.CacheSpellData(8512, "Windfury Totem");
ABGCS.CacheSpellData(3738, "Wrath of Air Totem");


--Earth totems
ABGCS.CacheSpellData(2484, "Earthbind Totem");
ABGCS.CacheSpellData(2062, "Earth Elemental Totem");
ABGCS.CacheSpellData(5730, "Stoneclaw Totem");
ABGCS.CacheSpellData(8071, "Stoneskin Totem");
ABGCS.CacheSpellData(8075, "Strength of Earth Totem");
ABGCS.CacheSpellData(8143, "Tremor Totem");

--Fire totems
ABGCS.CacheSpellData(16387, "Flametongue Totem");
ABGCS.CacheSpellData(8181, "Frost Resistance Totem");
ABGCS.CacheSpellData(8190, "Magma Totem");
ABGCS.CacheSpellData(3599, "Searing Totem");
ABGCS.CacheSpellData(30706, "Totem of Wrath");

--Water totems
ABGCS.CacheSpellData(8170, "Disease Cleansing Totem");
ABGCS.CacheSpellData(10538, "Fire Resistance Totem");
ABGCS.CacheSpellData(5394, "Healing Stream Totem");
ABGCS.CacheSpellData(5675, "Mana Spring Totem");
ABGCS.CacheSpellData(16190, "Mana Tide Totem");

ABGCS.CacheSpellData(546, "Water Walking");
ABGCS.CacheSpellData(2645, "Ghost Wolf");
ABGCS.CacheSpellData(556, "Astral Recall");
--#endregion

--#region Warlock
ABGCS.CacheSpellData(687, "Demon Skin");
ABGCS.CacheSpellData(706, "Demon Armor");
ABGCS.CacheSpellData(28176, "Fel Armor");

ABGCS.CacheSpellData(6201, "Create Healthstone");
-- ABGCS.CacheSpellData(6202, "Create Healthstone (Lesser)");
-- ABGCS.CacheSpellData(5699, "Create Healthstone");
-- ABGCS.CacheSpellData(11729, "Create Healthstone (Greater)");
-- ABGCS.CacheSpellData(11730, "Create Healthstone (Major)");
-- ABGCS.CacheSpellData(27230, "Create Healthstone (Master)");
-- ABGCS.CacheSpellData(47871, "Create Healthstone (Demonic)");
-- ABGCS.CacheSpellData(47878, "Create Healthstone (Fel)");

ABGCS.CacheSpellData(29893, "Ritual of Souls");
-- ABGCS.CacheSpellData(58887, "Ritual of Souls (Fel)");

--ABGCS.CacheSpellData(00000, "XXX");

ABGCS.CacheSpellData(6229, "Shadow Ward");

ABGCS.CacheSpellData(6366, "Create Firestone (Lesser)");--TODO: Add this to a category
ABGCS.CacheSpellData(17951, "Create Firestone");--TODO: Add this to a category
ABGCS.CacheSpellData(17952, "Create Firestone (Greater)");--TODO: Add this to a category
ABGCS.CacheSpellData(17953, "Create Firestone (Major)");--TODO: Add this to a category

ABGCS.CacheSpellData(2362, "Create Spellstone");--TODO: Add this to a category
ABGCS.CacheSpellData(17727, "Create Spellstone (Greater)");--TODO: Add this to a category

ABGCS.CacheSpellData(132, "Detect Invisibility");	--TODO: Add this to a category

ABGCS.CacheSpellData(5500, "Sense Demons");

ABGCS.CacheSpellData(1714, "Curse of Tongues");
ABGCS.CacheSpellData(702, "Curse of Weakness");
ABGCS.CacheSpellData(1490, "Curse of the Elements");
ABGCS.CacheSpellData(18223, "Curse of Exhaustion");

ABGCS.CacheSpellData(693, "Create Soulstone (Minor)");
ABGCS.CacheSpellData(20752, "Create Soulstone (Lesser)");
ABGCS.CacheSpellData(20755, "Create Soulstone");
ABGCS.CacheSpellData(20756, "Create Soulstone (Greater)");
ABGCS.CacheSpellData(20757, "Create Soulstone (Major)");

ABGCS.CacheSpellData(698, "Ritual of Summoning");

ABGCS.CacheSpellData(18220, "Dark Pact");
ABGCS.CacheSpellData(5697, "Unending Breath");
ABGCS.CacheSpellData(126, "Eye of Kilrogg");
ABGCS.CacheSpellData(691, "Summon Felhunter");
ABGCS.CacheSpellData(688, "Summon Imp");   -- y
ABGCS.CacheSpellData(712, "Summon Succubus");
ABGCS.CacheSpellData(697, "Summon Voidwalker");
ABGCS.CacheSpellData(1122, "Summon Infernal");
ABGCS.CacheSpellData(30146, "Summon Felguard");
--#endregion

--Warrior
ABGCS.CacheSpellData(6673, "Battle Shout");
ABGCS.CacheSpellData(100, "Charge");
ABGCS.CacheSpellData(1160, "Demoralizing Shout");
ABGCS.CacheSpellData(20252, "Intercept");
ABGCS.CacheSpellData(2565, "Shield Block");
ABGCS.CacheSpellData(871, "Shield Wall");
ABGCS.CacheSpellData(12975, "Last Stand");
ABGCS.CacheSpellData(71, "Defensive Stance");
ABGCS.CacheSpellData(2457, "Battle Stance");
ABGCS.CacheSpellData(2458, "Berserker Stance");



--Skills
ABGCS.CacheSpellData(3273, "First Aid");
ABGCS.CacheSpellData(2259, "Alchemy");
ABGCS.CacheSpellData(818, "Basic Campfire");
ABGCS.CacheSpellData(2018, "Blacksmithing");
ABGCS.CacheSpellData(2550, "Cooking");	--y
ABGCS.CacheSpellData(13262, "Disenchant");
ABGCS.CacheSpellData(7411, "Enchanting");
ABGCS.CacheSpellData(4036, "Engineering");
ABGCS.CacheSpellData(2108, "Leatherworking");
ABGCS.CacheSpellData(2656, "Smelting");
ABGCS.CacheSpellData(3908, "Tailoring");
ABGCS.CacheSpellData(7620, "Fishing");
ABGCS.CacheSpellData(2580, "Find Minerals");
ABGCS.CacheSpellData(2383, "Find Herbs");
ABGCS.CacheSpellData(25229, "Jewelcrafting");
ABGCS.CacheSpellData(31252, "Prospecting");
ABGCS.CacheSpellData(45357, "Inscription");
ABGCS.CacheSpellData(51005, "Milling");


local cache_timer_stop = debugprofilestop();

ABGData.timing["CacheSpellData.lua"] = cache_timer_stop - cache_timer_start;
