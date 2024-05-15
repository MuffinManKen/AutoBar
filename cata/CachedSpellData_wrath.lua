local _, AB = ...

local types = AB.types	---@class ABTypes
local code = AB.code	---@class ABCode

local ABGData = AutoBarGlobalDataObject

-- NOTE: This entire set of code runs in ~2ms, so no need to try to optimize it
local cache_timer_start = debugprofilestop();

--#region Racial
code.cache_spell_data(58984, "Shadowmeld");
--endregion


--#region Druid
code.cache_spell_data(22812, "Barkskin");
code.cache_spell_data(99, "Disorienting Roar");
code.cache_spell_data(5215, "Prowl");
code.cache_spell_data(22842, "Frenzied Regeneration");
code.cache_spell_data(22570, "Mangle");
code.cache_spell_data(1126, "Mark of the Wild");
code.cache_spell_data(21849, "Gift of the Wild");
code.cache_spell_data(467, "Thorns");
code.cache_spell_data(5487, "Bear Form");
code.cache_spell_data(9634, "Dire Bear Form");
code.cache_spell_data(768, "Cat Form");
code.cache_spell_data(1066, "Aquatic Form");
code.cache_spell_data(24858, "Moonkin Form");
--code.cache_spell_data(775, "Tree Form");
code.cache_spell_data(783, "Travel Form");
code.cache_spell_data(33943, "Flight Form");
code.cache_spell_data(40120, "Swift Flight Form");
code.cache_spell_data(18960, "Teleport: Moonglade");
--endregion

--#region DeathKnight
code.cache_spell_data(48265, "Unholy Presence");
code.cache_spell_data(48263, "Frost Presence");
code.cache_spell_data(48266, "Blood Presence");
code.cache_spell_data(48707, "Anti-Magic Shell");
code.cache_spell_data(51052, "Anti-Magic Zone");
code.cache_spell_data(3714, "Path of Frost");
code.cache_spell_data(57330, "Horn of Winter");
code.cache_spell_data(56222, "Dark Command");
code.cache_spell_data(45529, "Blood Tap");
code.cache_spell_data(48792, "Icebound Fortitude");
code.cache_spell_data(49576, "Death Grip");
code.cache_spell_data(48982, "Rune Tap");
code.cache_spell_data(55233, "Vampiric Blood");
code.cache_spell_data(47476, "Strangulate");
code.cache_spell_data(47528, "Mind Freeze");
code.cache_spell_data(46584, "Raise Dead");
code.cache_spell_data(49206, "Summon Gargoyle");
code.cache_spell_data(50977, "Death Gate");
--endregion


--#region Hunter
code.cache_spell_data(5118, "Aspect of the Cheetah");
code.cache_spell_data(13165, "Aspect of the Hawk");
code.cache_spell_data(13163, "Aspect of the Monkey");
code.cache_spell_data(20043, "Aspect of the Wild");
code.cache_spell_data(13159, "Aspect of the Pack");
code.cache_spell_data(13161, "Aspect of the Beast");
code.cache_spell_data(34074, "Aspect of the Viper");

code.cache_spell_data(1462, "Beast Lore");
code.cache_spell_data(19574, "Bestial Wrath");
code.cache_spell_data(883, "Call Pet");
code.cache_spell_data(5116, "Concussive Shot");
code.cache_spell_data(781, "Disengage");
code.cache_spell_data(2641, "Dismiss Pet");
code.cache_spell_data(6197, "Eagle Eye");
code.cache_spell_data(6991, "Feed Pet");
code.cache_spell_data(5384, "Feign Death");
code.cache_spell_data(19577, "Intimidation");
code.cache_spell_data(136, "Mend Pet");
code.cache_spell_data(982, "Revive Pet");
code.cache_spell_data(1515, "Tame Beast");
code.cache_spell_data(2974, "Wing Clip");

code.cache_spell_data(19883, "Track Humanoids");
code.cache_spell_data(19884, "Track Undead");
code.cache_spell_data(1494, "Track Beasts");
code.cache_spell_data(19885, "Track Hidden");
code.cache_spell_data(19878, "Track Demons");
code.cache_spell_data(19880, "Track Elementals");
code.cache_spell_data(19879, "Track Dragonkin");
code.cache_spell_data(19882, "Track Giants");

code.cache_spell_data(1499, "Freezing Trap");
code.cache_spell_data(13809, "Frost Trap");
code.cache_spell_data(13813, "Explosive Trap");
code.cache_spell_data(13795, "Immolation Trap");
code.cache_spell_data(34600, "Snake Trap");
code.cache_spell_data(61847, "Aspect of the Dragonhawk");
--#endregion

--#region Mage
code.cache_spell_data(168, "Frost Armor");
code.cache_spell_data(7302, "Ice Armor");
code.cache_spell_data(6117, "Mage Armor");
code.cache_spell_data(30482, "Molten Armor");
code.cache_spell_data(27619, "Ice Block");
code.cache_spell_data(11426, "Ice Barrier");

code.cache_spell_data(1459, "Arcane Intellect");
code.cache_spell_data(23028, "Arcane Brilliance");
code.cache_spell_data(130, "Slow Fall");
code.cache_spell_data(1008, "Amplify Magic");
code.cache_spell_data(604, "Dampen Magic");

code.cache_spell_data(5504, "Conjure Water");
code.cache_spell_data(587, "Conjure Food");

code.cache_spell_data(759, "Conjure Mana Gem");

code.cache_spell_data(43987, "Ritual of Refreshment");

code.cache_spell_data(31687, "Summon Water Elemental");

code.cache_spell_data(66, "Invisibility");

code.cache_spell_data(11418, "Portal: Undercity");
code.cache_spell_data(3563, "Teleport: Undercity");
code.cache_spell_data(11420, "Portal: Thunder Bluff");
code.cache_spell_data(3566, "Teleport: Thunder Bluff");
code.cache_spell_data(10059, "Portal: Stormwind");
code.cache_spell_data(3561, "Teleport: Stormwind");
code.cache_spell_data(11419, "Portal: Darnassus");
code.cache_spell_data(3565, "Teleport: Darnassus");
code.cache_spell_data(11416, "Portal: Ironforge");
code.cache_spell_data(3562, "Teleport: Ironforge");
code.cache_spell_data(11417, "Portal: Orgrimmar");
code.cache_spell_data(3567, "Teleport: Orgrimmar");
code.cache_spell_data(49361, "Portal: Stonard");
code.cache_spell_data(49360, "Portal: Theramore");
code.cache_spell_data(32266, "Portal: Exodar");
code.cache_spell_data(32267, "Portal: Silvermoon");
code.cache_spell_data(33691, "Portal: Shattrath - Alliance");
code.cache_spell_data(35717, "Portal: Shattrath - Horde");
code.cache_spell_data(49358, "Teleport: Stonard");
code.cache_spell_data(49359, "Teleport: Theramore");
code.cache_spell_data(32271, "Teleport: Exodar");
code.cache_spell_data(32272, "Teleport: Silvermoon");
code.cache_spell_data(33690, "Teleport: Shattrath - Alliance");
code.cache_spell_data(35715, "Teleport: Shattrath - Horde");
code.cache_spell_data(53140, "Teleport: Dalaran");
code.cache_spell_data(53142, "Portal: Dalaran");
--#endregion

--#region Paladin
code.cache_spell_data(498, "Divine Protection");
code.cache_spell_data(642, "Divine Shield");
-- code.cache_spell_data(64205, "Divine Sacrifice"); -- Prot, Not sure where to put it

code.cache_spell_data(19740, "Blessing of Might");
code.cache_spell_data(25782, "Greater Blessing of Might");
code.cache_spell_data(19742, "Blessing of Wisdom");
code.cache_spell_data(25894, "Greater Blessing of Wisdom");
code.cache_spell_data(20217, "Blessing of Kings");
code.cache_spell_data(25898, "Greater Blessing of Kings");
code.cache_spell_data(20911, "Blessing of Sanctuary");
code.cache_spell_data(25899, "Greater Blessing of Sanctuary");

code.cache_spell_data(633, "Lay on Hands");

code.cache_spell_data(1044, "Hand of Freedom");
code.cache_spell_data(1022, "Hand of Protection");
code.cache_spell_data(6940, "Hand of Sacrifice");
code.cache_spell_data(1038, "Hand of Salvation");

code.cache_spell_data(32223, "Crusader Aura");
code.cache_spell_data(465, "Devotion Aura");
code.cache_spell_data(7294, "Retribution Aura");
code.cache_spell_data(19746, "Concentration Aura");
code.cache_spell_data(19891, "Fire Resistance Aura");
code.cache_spell_data(19888, "Frost Resistance Aura");
code.cache_spell_data(19876, "Shadow Resistance Aura");

code.cache_spell_data(5502, "Sense Undead");

code.cache_spell_data(20375, "Seal of Command"); -- Ret
code.cache_spell_data(20164, "Seal of Justice");
code.cache_spell_data(20165, "Seal of Light");
code.cache_spell_data(20154, "Seal of Righteousness");
code.cache_spell_data(20166, "Seal of Wisdom");
code.cache_spell_data(31801, "Seal of Vengeance"); -- Alliance
code.cache_spell_data(53736, "Seal of Corruption"); -- Horde
--#endregion

--#region Priest
code.cache_spell_data(588, "Inner Fire");
code.cache_spell_data(1243, "Power Word: Fortitude");
code.cache_spell_data(21562, "Prayer of Fortitude");
code.cache_spell_data(17, "Power Word: Shield");
code.cache_spell_data(15487, "Silence");
code.cache_spell_data(976, "Shadow Protection");
code.cache_spell_data(27683, "Prayer of Shadow Protection");
code.cache_spell_data(34433, "Shadowfiend");
code.cache_spell_data(6346, "Fear Ward");
code.cache_spell_data(14752, "Divine Spirit");
code.cache_spell_data(27681, "Prayer of Spirit");
code.cache_spell_data(15286, "Vampiric Embrace");
--#endregion

--#region Rogue
code.cache_spell_data(1842, "Disarm Trap");
code.cache_spell_data(4086, "Evasion");
code.cache_spell_data(1766, "Kick");
code.cache_spell_data(1784, "Stealth");
code.cache_spell_data(1856, "Vanish");
code.cache_spell_data(2094, "Blind");
code.cache_spell_data(6770, "Sap");
code.cache_spell_data(36554, "Shadowstep");
--#endregion

--#region Shaman
code.cache_spell_data(51730, "Earthliving Weapon");
code.cache_spell_data(8024, "Flametongue Weapon");
code.cache_spell_data(8033, "Frostbrand Weapon");
code.cache_spell_data(8017, "Rockbiter Weapon");
code.cache_spell_data(8232, "Windfury Weapon");

code.cache_spell_data(8042, "Earth Shock");

--Air totems
code.cache_spell_data(8177, "Grounding Totem");
code.cache_spell_data(10595, "Nature Resistance Totem");
code.cache_spell_data(6495, "Sentry Totem");
code.cache_spell_data(8512, "Windfury Totem");
code.cache_spell_data(3738, "Wrath of Air Totem");


--Earth totems
code.cache_spell_data(2484, "Earthbind Totem");
code.cache_spell_data(2062, "Earth Elemental Totem");
code.cache_spell_data(5730, "Stoneclaw Totem");
code.cache_spell_data(8071, "Stoneskin Totem");
code.cache_spell_data(8075, "Strength of Earth Totem");
code.cache_spell_data(8143, "Tremor Totem");

--Fire totems
code.cache_spell_data(16387, "Flametongue Totem");
code.cache_spell_data(8181, "Frost Resistance Totem");
code.cache_spell_data(8190, "Magma Totem");
code.cache_spell_data(3599, "Searing Totem");
code.cache_spell_data(30706, "Totem of Wrath");

--Water totems
code.cache_spell_data(8170, "Disease Cleansing Totem");
code.cache_spell_data(10538, "Fire Resistance Totem");
code.cache_spell_data(5394, "Healing Stream Totem");
code.cache_spell_data(5675, "Mana Spring Totem");
code.cache_spell_data(16190, "Mana Tide Totem");

code.cache_spell_data(546, "Water Walking");
code.cache_spell_data(2645, "Ghost Wolf");
code.cache_spell_data(556, "Astral Recall");
--#endregion

--#region Warlock
code.cache_spell_data(687, "Demon Skin");
code.cache_spell_data(706, "Demon Armor");
code.cache_spell_data(28176, "Fel Armor");

code.cache_spell_data(6201, "Create Healthstone");
-- code.cache_spell_data(6202, "Create Healthstone (Lesser)");
-- code.cache_spell_data(5699, "Create Healthstone");
-- code.cache_spell_data(11729, "Create Healthstone (Greater)");
-- code.cache_spell_data(11730, "Create Healthstone (Major)");
-- code.cache_spell_data(27230, "Create Healthstone (Master)");
-- code.cache_spell_data(47871, "Create Healthstone (Demonic)");
-- code.cache_spell_data(47878, "Create Healthstone (Fel)");

code.cache_spell_data(29893, "Ritual of Souls");
-- code.cache_spell_data(58887, "Ritual of Souls (Fel)");

--code.cache_spell_data(00000, "XXX");

code.cache_spell_data(6229, "Shadow Ward");

code.cache_spell_data(6366, "Create Firestone (Lesser)");--TODO: Add this to a category
code.cache_spell_data(17951, "Create Firestone");--TODO: Add this to a category
code.cache_spell_data(17952, "Create Firestone (Greater)");--TODO: Add this to a category
code.cache_spell_data(17953, "Create Firestone (Major)");--TODO: Add this to a category

code.cache_spell_data(2362, "Create Spellstone");--TODO: Add this to a category
code.cache_spell_data(17727, "Create Spellstone (Greater)");--TODO: Add this to a category

code.cache_spell_data(132, "Detect Invisibility");	--TODO: Add this to a category

code.cache_spell_data(5500, "Sense Demons");

code.cache_spell_data(1714, "Curse of Tongues");
code.cache_spell_data(702, "Curse of Weakness");
code.cache_spell_data(1490, "Curse of the Elements");
code.cache_spell_data(18223, "Curse of Exhaustion");

code.cache_spell_data(693, "Create Soulstone (Minor)");
code.cache_spell_data(20752, "Create Soulstone (Lesser)");
code.cache_spell_data(20755, "Create Soulstone");
code.cache_spell_data(20756, "Create Soulstone (Greater)");
code.cache_spell_data(20757, "Create Soulstone (Major)");

code.cache_spell_data(698, "Ritual of Summoning");

code.cache_spell_data(18220, "Dark Pact");
code.cache_spell_data(5697, "Unending Breath");
code.cache_spell_data(126, "Eye of Kilrogg");
code.cache_spell_data(691, "Summon Felhunter");
code.cache_spell_data(688, "Summon Imp");   -- y
code.cache_spell_data(712, "Summon Succubus");
code.cache_spell_data(697, "Summon Voidwalker");
code.cache_spell_data(1122, "Summon Infernal");
code.cache_spell_data(30146, "Summon Felguard");
--#endregion

--#region Warrior
code.cache_spell_data(6673, "Battle Shout");
code.cache_spell_data(469, "Commanding Shout");
code.cache_spell_data(100, "Charge");
code.cache_spell_data(1160, "Demoralizing Shout");
code.cache_spell_data(20252, "Intercept");
code.cache_spell_data(2565, "Shield Block");
code.cache_spell_data(871, "Shield Wall");
code.cache_spell_data(12975, "Last Stand");
code.cache_spell_data(71, "Defensive Stance");
code.cache_spell_data(2457, "Battle Stance");
code.cache_spell_data(2458, "Berserker Stance");
--#endregion


--#region Skills
code.cache_spell_data(3273, "First Aid");
code.cache_spell_data(2259, "Alchemy");
code.cache_spell_data(818, "Basic Campfire");
code.cache_spell_data(2018, "Blacksmithing");
code.cache_spell_data(2550, "Cooking");	--y
code.cache_spell_data(13262, "Disenchant");
code.cache_spell_data(7411, "Enchanting");
code.cache_spell_data(4036, "Engineering");
code.cache_spell_data(2108, "Leatherworking");
code.cache_spell_data(2656, "Smelting");
code.cache_spell_data(3908, "Tailoring");
code.cache_spell_data(7620, "Fishing");
code.cache_spell_data(2580, "Find Minerals");
code.cache_spell_data(2383, "Find Herbs");
code.cache_spell_data(25229, "Jewelcrafting");
code.cache_spell_data(31252, "Prospecting");
code.cache_spell_data(45357, "Inscription");
code.cache_spell_data(51005, "Milling");
--#endregion

local cache_timer_stop = debugprofilestop();

ABGData.timing["CacheSpellData.lua"] = cache_timer_stop - cache_timer_start;
