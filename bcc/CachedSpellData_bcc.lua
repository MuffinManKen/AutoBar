local _ADDON_NAME, AB = ... -- Pulls back the Addon-Local Variables and store them locally.

local ABGData = AutoBarGlobalDataObject

-- NOTE: This entire set of code runs in ~2ms, so no need to try to optimize it
local cache_timer_start = debugprofilestop();

--All
AB.CacheSpellData(20580, "Shadowmeld");


--Druid
AB.CacheSpellData(22812, "Barkskin");
AB.CacheSpellData(99, "Disorienting Roar");
AB.CacheSpellData(5215, "Prowl");
AB.CacheSpellData(22842, "Frenzied Regeneration");
AB.CacheSpellData(22570, "Mangle");
AB.CacheSpellData(1126, "Mark of the Wild");
AB.CacheSpellData(21849, "Gift of the Wild");
AB.CacheSpellData(467, "Thorns");
AB.CacheSpellData(5487, "Bear Form");
AB.CacheSpellData(9634, "Dire Bear Form");
AB.CacheSpellData(768, "Cat Form");
AB.CacheSpellData(1066, "Aquatic Form");
AB.CacheSpellData(24858, "Moonkin Form");
--AB.CacheSpellData(775, "Tree Form");
AB.CacheSpellData(783, "Travel Form");
AB.CacheSpellData(33943, "Flight Form");
AB.CacheSpellData(40120, "Swift Flight Form");
AB.CacheSpellData(18960, "Teleport: Moonglade");


--#region Hunter
AB.CacheSpellData(5118, "Aspect of the Cheetah");
AB.CacheSpellData(13165, "Aspect of the Hawk");
AB.CacheSpellData(13163, "Aspect of the Monkey");
AB.CacheSpellData(20043, "Aspect of the Wild");
AB.CacheSpellData(13159, "Aspect of the Pack");
AB.CacheSpellData(13161, "Aspect of the Beast");
AB.CacheSpellData(34074, "Aspect of the Viper");

AB.CacheSpellData(1462, "Beast Lore");
AB.CacheSpellData(19574, "Bestial Wrath");
AB.CacheSpellData(883, "Call Pet");
AB.CacheSpellData(5116, "Concussive Shot");
AB.CacheSpellData(781, "Disengage");
AB.CacheSpellData(2641, "Dismiss Pet");
AB.CacheSpellData(6197, "Eagle Eye");
AB.CacheSpellData(6991, "Feed Pet");
AB.CacheSpellData(5384, "Feign Death");
AB.CacheSpellData(19577, "Intimidation");
AB.CacheSpellData(136, "Mend Pet");
AB.CacheSpellData(982, "Revive Pet");
AB.CacheSpellData(1515, "Tame Beast");
AB.CacheSpellData(2974, "Wing Clip");

AB.CacheSpellData(19883, "Track Humanoids");
AB.CacheSpellData(19884, "Track Undead");
AB.CacheSpellData(1494, "Track Beasts");
AB.CacheSpellData(19885, "Track Hidden");
AB.CacheSpellData(19878, "Track Demons");
AB.CacheSpellData(19880, "Track Elementals");
AB.CacheSpellData(19879, "Track Dragonkin");
AB.CacheSpellData(19882, "Track Giants");

AB.CacheSpellData(1499, "Freezing Trap");
AB.CacheSpellData(13809, "Frost Trap");
AB.CacheSpellData(13813, "Explosive Trap");
AB.CacheSpellData(13795, "Immolation Trap");
AB.CacheSpellData(34600, "Snake Trap");
--#endregion

--#region Mage
AB.CacheSpellData(168, "Frost Armor");
AB.CacheSpellData(7302, "Ice Armor");
AB.CacheSpellData(6117, "Mage Armor");
AB.CacheSpellData(30482, "Molten Armor");
AB.CacheSpellData(27619, "Ice Block");
AB.CacheSpellData(11426, "Ice Barrier");

AB.CacheSpellData(1459, "Arcane Intellect");
AB.CacheSpellData(23028, "Arcane Brilliance");
AB.CacheSpellData(130, "Slow Fall");
AB.CacheSpellData(1008, "Amplify Magic");
AB.CacheSpellData(604, "Dampen Magic");

AB.CacheSpellData(5504, "Conjure Water");
AB.CacheSpellData(587, "Conjure Food");

AB.CacheSpellData(759, "Conjure Mana Agate");
AB.CacheSpellData(10054, "Conjure Mana Ruby");
AB.CacheSpellData(3552, "Conjure Mana Jade");
AB.CacheSpellData(10053, "Conjure Mana Citrine");
AB.CacheSpellData(27101, "Conjure Mana Emerald");

AB.CacheSpellData(31687, "Summon Water Elemental");

--AB.CacheSpellData(42955, "Conjure Refreshment");
--AB.CacheSpellData(43987, "Conjure Refreshment Table");
AB.CacheSpellData(7870, "Lesser Invisibility");
AB.CacheSpellData(66, "Invisibility");

AB.CacheSpellData(11418, "Portal: Undercity");
AB.CacheSpellData(3563, "Teleport: Undercity");
AB.CacheSpellData(11420, "Portal: Thunder Bluff");
AB.CacheSpellData(3566, "Teleport: Thunder Bluff");
AB.CacheSpellData(10059, "Portal: Stormwind");
AB.CacheSpellData(3561, "Teleport: Stormwind");
AB.CacheSpellData(11419, "Portal: Darnassus");
AB.CacheSpellData(3565, "Teleport: Darnassus");
AB.CacheSpellData(11416, "Portal: Ironforge");
AB.CacheSpellData(3562, "Teleport: Ironforge");
AB.CacheSpellData(11417, "Portal: Orgrimmar");
AB.CacheSpellData(3567, "Teleport: Orgrimmar");
AB.CacheSpellData(49361, "Portal: Stonard");
AB.CacheSpellData(49360, "Portal: Theramore");
AB.CacheSpellData(32266, "Portal: Exodar");
AB.CacheSpellData(32267, "Portal: Silvermoon");
AB.CacheSpellData(33691, "Portal: Shattrath - Alliance");
AB.CacheSpellData(35717, "Portal: Shattrath - Horde");
AB.CacheSpellData(49358, "Teleport: Stonard");
AB.CacheSpellData(49359, "Teleport: Theramore");
AB.CacheSpellData(32271, "Teleport: Exodar");
AB.CacheSpellData(32272, "Teleport: Silvermoon");
AB.CacheSpellData(33690, "Teleport: Shattrath - Alliance");
AB.CacheSpellData(35715, "Teleport: Shattrath - Horde");
--#endregion

--#region Paladin
AB.CacheSpellData(498, "Divine Protection");
AB.CacheSpellData(642, "Divine Shield");
AB.CacheSpellData(1044, "Blessing of Freedom");
AB.CacheSpellData(1022, "Blessing of Protection");
AB.CacheSpellData(6940, "Blessing of Sacrifice");
AB.CacheSpellData(1038, "Blessing of Salvation");
AB.CacheSpellData(25898, "Greater Blessing of Kings");
AB.CacheSpellData(19742, "Blessing of Wisdom");
AB.CacheSpellData(25894, "Greater Blessing of Wisdom");
AB.CacheSpellData(633, "Lay on Hands");

AB.CacheSpellData(19740, "Blessing of Might");

AB.CacheSpellData(32223, "Crusader Aura");
AB.CacheSpellData(465, "Devotion Aura");
AB.CacheSpellData(7294, "Retribution Aura");
AB.CacheSpellData(19746, "Concentration Aura");
AB.CacheSpellData(19891, "Fire Resistance Aura");
AB.CacheSpellData(19888, "Frost Resistance Aura");
AB.CacheSpellData(20218, "Sanctity Aura");
AB.CacheSpellData(19876, "Shadow Resistance Aura");

AB.CacheSpellData(5502, "Sense Undead");

AB.CacheSpellData(20375, "Seal of Command");
AB.CacheSpellData(20164, "Seal of Justice");
AB.CacheSpellData(20165, "Seal of Light");
AB.CacheSpellData(20154, "Seal of Righteousness");
AB.CacheSpellData(21082, "Seal of the Crusader");
AB.CacheSpellData(348700, "Seal of the Martyr");
AB.CacheSpellData(20166, "Seal of Wisdom");
--#endregion

--#region Priest
AB.CacheSpellData(588, "Inner Fire");
AB.CacheSpellData(1243, "Power Word: Fortitude");
AB.CacheSpellData(21562, "Prayer of Fortitude");
AB.CacheSpellData(17, "Power Word: Shield");
AB.CacheSpellData(15487, "Silence");
AB.CacheSpellData(976, "Shadow Protection");
AB.CacheSpellData(27683, "Prayer of Shadow Protection");
AB.CacheSpellData(34433, "Shadowfiend");
AB.CacheSpellData(18137, "Shadowguard");
AB.CacheSpellData(13896, "Feedback");
AB.CacheSpellData(2651, "Elune's Grace");
AB.CacheSpellData(2652, "Touch of Weakness");
AB.CacheSpellData(6346, "Fear Ward");
--#endregion

--Rogue
AB.CacheSpellData(1842, "Disarm Trap");
AB.CacheSpellData(4086, "Evasion");
AB.CacheSpellData(1766, "Kick");
AB.CacheSpellData(1784, "Stealth");
AB.CacheSpellData(1856, "Vanish");
AB.CacheSpellData(2094, "Blind");
AB.CacheSpellData(6770, "Sap");
AB.CacheSpellData(36554, "Shadowstep");


--#region Shaman
AB.CacheSpellData(8024, "Flametongue Weapon");
AB.CacheSpellData(8033, "Frostbrand Weapon");
AB.CacheSpellData(8017, "Rockbiter Weapon");
AB.CacheSpellData(8232, "Windfury Weapon");

AB.CacheSpellData(8042, "Earth Shock");

--Air totems
AB.CacheSpellData(8835, "Grace of Air Totem");
AB.CacheSpellData(8177, "Grounding Totem");
AB.CacheSpellData(10595, "Nature Resistance Totem");
AB.CacheSpellData(6495, "Sentry Totem");
AB.CacheSpellData(25908, "Tranquil Air Totem");
AB.CacheSpellData(8512, "Windfury Totem");
AB.CacheSpellData(15107, "Windwall Totem");
AB.CacheSpellData(3738, "Wrath of Air Totem");


--Earth totems
AB.CacheSpellData(2484, "Earthbind Totem");
AB.CacheSpellData(2062, "Earth Elemental Totem");
AB.CacheSpellData(5730, "Stoneclaw Totem");
AB.CacheSpellData(8071, "Stoneskin Totem");
AB.CacheSpellData(8075, "Strength of Earth Totem");
AB.CacheSpellData(8143, "Tremor Totem");

--Fire totems
AB.CacheSpellData(1535, "Fire Nova Totem");
AB.CacheSpellData(16387, "Flametongue Totem");
AB.CacheSpellData(8181, "Frost Resistance Totem");
AB.CacheSpellData(8190, "Magma Totem");
AB.CacheSpellData(3599, "Searing Totem");
AB.CacheSpellData(30706, "Totem of Wrath");

--Water totems
AB.CacheSpellData(8170, "Disease Cleansing Totem");
AB.CacheSpellData(10538, "Fire Resistance Totem");
AB.CacheSpellData(5394, "Healing Stream Totem");
AB.CacheSpellData(5675, "Mana Spring Totem");
AB.CacheSpellData(16190, "Mana Tide Totem");
AB.CacheSpellData(8166, "Poison Cleansing Totem");

AB.CacheSpellData(546, "Water Walking");
AB.CacheSpellData(2645, "Ghost Wolf");
AB.CacheSpellData(556, "Astral Recall");
--#endregion

--#region Warlock
AB.CacheSpellData(687, "Demon Skin");
AB.CacheSpellData(706, "Demon Armor");
AB.CacheSpellData(28176, "Fel Armor");

AB.CacheSpellData(6201, "Create Healthstone (Minor)");
AB.CacheSpellData(6202, "Create Healthstone (Lesser)");
AB.CacheSpellData(5699, "Create Healthstone");
AB.CacheSpellData(11729, "Create Healthstone (Greater)");
AB.CacheSpellData(11730, "Create Healthstone (Major)");

--AB.CacheSpellData(00000, "XXX");

AB.CacheSpellData(6229, "Shadow Ward");

AB.CacheSpellData(6366, "Create Firestone (Lesser)");--TODO: Add this to a category
AB.CacheSpellData(17951, "Create Firestone");--TODO: Add this to a category
AB.CacheSpellData(17952, "Create Firestone (Greater)");--TODO: Add this to a category
AB.CacheSpellData(17953, "Create Firestone (Major)");--TODO: Add this to a category

AB.CacheSpellData(2362, "Create Spellstone");--TODO: Add this to a category
AB.CacheSpellData(17727, "Create Spellstone (Greater)");--TODO: Add this to a category

AB.CacheSpellData(132, "Detect Invisibility");	--TODO: Add this to a category

AB.CacheSpellData(5500, "Sense Demons");

AB.CacheSpellData(704, "Curse of Recklessness");
AB.CacheSpellData(1714, "Curse of Tongues");
AB.CacheSpellData(702, "Curse of Weakness");
AB.CacheSpellData(17862, "Curse of Shadow");
AB.CacheSpellData(1490, "Curse of the Elements");
AB.CacheSpellData(18223, "Curse of Exhaustion");

AB.CacheSpellData(693, "Create Soulstone (Minor)");
AB.CacheSpellData(20752, "Create Soulstone (Lesser)");
AB.CacheSpellData(20755, "Create Soulstone");
AB.CacheSpellData(20756, "Create Soulstone (Greater)");
AB.CacheSpellData(20757, "Create Soulstone (Major)");

AB.CacheSpellData(698, "Ritual of Summoning");


AB.CacheSpellData(18220, "Dark Pact");
AB.CacheSpellData(5697, "Unending Breath");
AB.CacheSpellData(126, "Eye of Kilrogg");
AB.CacheSpellData(691, "Summon Felhunter");
AB.CacheSpellData(688, "Summon Imp");   -- y
AB.CacheSpellData(712, "Summon Succubus");
AB.CacheSpellData(697, "Summon Voidwalker");
AB.CacheSpellData(1122, "Summon Infernal");
AB.CacheSpellData(30146, "Summon Felguard");
--#endregion

--Warrior
AB.CacheSpellData(6673, "Battle Shout");
AB.CacheSpellData(100, "Charge");
AB.CacheSpellData(1160, "Demoralizing Shout");
AB.CacheSpellData(20252, "Intercept");
AB.CacheSpellData(2565, "Shield Block");
AB.CacheSpellData(871, "Shield Wall");
AB.CacheSpellData(12975, "Last Stand");
AB.CacheSpellData(71, "Defensive Stance");
AB.CacheSpellData(2457, "Battle Stance");
AB.CacheSpellData(2458, "Berserker Stance");



--Skills
AB.CacheSpellData(3273, "First Aid");
AB.CacheSpellData(2259, "Alchemy");
AB.CacheSpellData(818, "Basic Campfire");
AB.CacheSpellData(2018, "Blacksmithing");
AB.CacheSpellData(2550, "Cooking");	--y
AB.CacheSpellData(13262, "Disenchant");
AB.CacheSpellData(7411, "Enchanting");
AB.CacheSpellData(4036, "Engineering");
AB.CacheSpellData(2108, "Leatherworking");
AB.CacheSpellData(2656, "Smelting");
AB.CacheSpellData(3908, "Tailoring");
AB.CacheSpellData(7620, "Fishing");
AB.CacheSpellData(2580, "Find Minerals");
AB.CacheSpellData(2383, "Find Herbs");
AB.CacheSpellData(25229, "Jewelcrafting");
AB.CacheSpellData(31252, "Prospecting");


local cache_timer_stop = debugprofilestop();

ABGData.timing["CacheSpellData.lua"] = cache_timer_stop - cache_timer_start;
