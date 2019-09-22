
local ABGCS = AutoBarGlobalCodeSpace
local ABGData = AutoBarGlobalDataObject

-- NOTE: This entire set of code runs in ~2ms, so no need to try to optimize it
local cache_timer_start = debugprofilestop();

--All
ABGCS:CacheSpellData(20580, "Shadowmeld");


--Druid
ABGCS:CacheSpellData(22812, "Barkskin");
ABGCS:CacheSpellData(99, "Disorienting Roar");
ABGCS:CacheSpellData(5215, "Prowl");
ABGCS:CacheSpellData(22842, "Frenzied Regeneration");
ABGCS:CacheSpellData(22570, "Mangle");
ABGCS:CacheSpellData(1126, "Mark of the Wild");
ABGCS:CacheSpellData(21849, "Gift of the Wild");
ABGCS:CacheSpellData(467, "Thorns");
ABGCS:CacheSpellData(5487, "Bear Form");
ABGCS:CacheSpellData(768, "Cat Form");
ABGCS:CacheSpellData(1066, "Aquatic Form");
ABGCS:CacheSpellData(24858, "Moonkin Form");
ABGCS:CacheSpellData(775, "Tree Form");
ABGCS:CacheSpellData(783, "Travel Form");
ABGCS:CacheSpellData(18960, "Teleport: Moonglade");


--Hunter
ABGCS:CacheSpellData(5118, "Aspect of the Cheetah");
ABGCS:CacheSpellData(13165, "Aspect of the Hawk");
ABGCS:CacheSpellData(13163, "Aspect of the Monkey");
ABGCS:CacheSpellData(20043, "Aspect of the Wild");
ABGCS:CacheSpellData(1462, "Beast Lore");
ABGCS:CacheSpellData(19574, "Bestial Wrath");
ABGCS:CacheSpellData(883, "Call Pet");
ABGCS:CacheSpellData(5116, "Concussive Shot");
ABGCS:CacheSpellData(781, "Disengage");
ABGCS:CacheSpellData(2641, "Dismiss Pet");
ABGCS:CacheSpellData(6197, "Eagle Eye");
ABGCS:CacheSpellData(6991, "Feed Pet");
ABGCS:CacheSpellData(5384, "Feign Death");
ABGCS:CacheSpellData(7093, "Intimidation");
ABGCS:CacheSpellData(136, "Mend Pet");
ABGCS:CacheSpellData(982, "Revive Pet");
ABGCS:CacheSpellData(1515, "Tame Beast");
ABGCS:CacheSpellData(2974, "Wing Clip");

ABGCS:CacheSpellData(19883, "Track Humanoids");
ABGCS:CacheSpellData(19884, "Track Undead");
ABGCS:CacheSpellData(1494, "Track Beasts");

ABGCS:CacheSpellData(1499, "Freezing Trap");
ABGCS:CacheSpellData(13813, "Explosive Trap");
ABGCS:CacheSpellData(13795, "Immolation Trap");


--Mage
ABGCS:CacheSpellData(168, "Frost Armor");
ABGCS:CacheSpellData(1459, "Arcane Intellect");
ABGCS:CacheSpellData(5504, "Conjure Water");
ABGCS:CacheSpellData(587, "Conjure Food");

ABGCS:CacheSpellData(11426, "Ice Barrier");
ABGCS:CacheSpellData(130, "Slow Fall");
--ABGCS:CacheSpellData(42955, "Conjure Refreshment");
--ABGCS:CacheSpellData(43987, "Conjure Refreshment Table");
ABGCS:CacheSpellData(66, "Lesser Invisibility");
ABGCS:CacheSpellData(885, "Invisibility");
ABGCS:CacheSpellData(27619, "Ice Block");
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
ABGCS:CacheSpellData(498, "Divine Protection");
ABGCS:CacheSpellData(642, "Divine Shield");
ABGCS:CacheSpellData(1044, "Blessing of Freedom");
ABGCS:CacheSpellData(1022, "Blessing of Protection");
ABGCS:CacheSpellData(6940, "Blessing of Sacrifice");
ABGCS:CacheSpellData(1038, "Blessing of Salvation");
ABGCS:CacheSpellData(25898, "Greater Blessing of Kings");
ABGCS:CacheSpellData(25894, "Greater Blessing of Wisdom");
ABGCS:CacheSpellData(633, "Lay on Hands");

ABGCS:CacheSpellData(19740, "Blessing of Might"); --y

ABGCS:CacheSpellData(465, "Devotion Aura"); --y		TODO: Add Auras




--Priest
ABGCS:CacheSpellData(17, "Power Word: Shield");
ABGCS:CacheSpellData(15487, "Silence");

--Rogue
ABGCS:CacheSpellData(1842, "Disarm Trap");
ABGCS:CacheSpellData(4086, "Evasion");
ABGCS:CacheSpellData(1766, "Kick");
ABGCS:CacheSpellData(1784, "Stealth");
ABGCS:CacheSpellData(1856, "Vanish");
ABGCS:CacheSpellData(2094, "Blind");
ABGCS:CacheSpellData(6770, "Sap");


--Shaman
ABGCS:CacheSpellData(8024, "Flametongue Weapon");
ABGCS:CacheSpellData(8033, "Frostbrand Weapon");
ABGCS:CacheSpellData(8017, "Rockbiter Weapon");
ABGCS:CacheSpellData(8232, "Windfury Weapon");

	--Air totems
ABGCS:CacheSpellData(8835, "Grace of Air Totem");
ABGCS:CacheSpellData(8177, "Grounding Totem");
ABGCS:CacheSpellData(10595, "Nature Resistance Totem");
ABGCS:CacheSpellData(6495, "Sentry Totem");
ABGCS:CacheSpellData(25908, "Tranquil Air Totem");
ABGCS:CacheSpellData(8512, "Windfury Totem");
ABGCS:CacheSpellData(8512, "Windwall Totem");

	--Earth totems
ABGCS:CacheSpellData(8042, "Earth Shock");
ABGCS:CacheSpellData(2484, "Earthbind Totem");
ABGCS:CacheSpellData(5730, "Stoneclaw Totem");
ABGCS:CacheSpellData(8071, "Stoneskin Totem");
ABGCS:CacheSpellData(8075, "Strength of Earth Totem");
ABGCS:CacheSpellData(8143, "Tremor Totem");

	--Fire totems
ABGCS:CacheSpellData(1535, "Fire Nova Totem");
ABGCS:CacheSpellData(16387, "Flametongue Totem");
ABGCS:CacheSpellData(8181, "Frost Resistance Totem");
ABGCS:CacheSpellData(8190, "Magma Totem");
ABGCS:CacheSpellData(3599, "Searing Totem");

	--Water totems
ABGCS:CacheSpellData(8170, "Disease Cleansing Totem");
ABGCS:CacheSpellData(10538, "Fire Resistance Totem");
ABGCS:CacheSpellData(5394, "Healing Stream Totem");
ABGCS:CacheSpellData(5675, "Mana Spring Totem");
ABGCS:CacheSpellData(8166, "Poison Cleansing Totem");

ABGCS:CacheSpellData(51533, "Feral Spirit");
ABGCS:CacheSpellData(546, "Water Walking");
ABGCS:CacheSpellData(2645, "Ghost Wolf");
ABGCS:CacheSpellData(198103, "Earth Elemental");
ABGCS:CacheSpellData(198067, "Fire Elemental");
ABGCS:CacheSpellData(192249, "Storm Elemental");
ABGCS:CacheSpellData(556, "Astral Recall");


--Warlock
ABGCS:CacheSpellData(687, "Demon Skin");
ABGCS:CacheSpellData(706, "Demon Armor");

ABGCS:CacheSpellData(6201, "Create Healthstone (Minor)");
ABGCS:CacheSpellData(6202, "Create Healthstone (Lesser)");
ABGCS:CacheSpellData(5699, "Create Healthstone");
ABGCS:CacheSpellData(11729, "Create Healthstone (Greater)");
ABGCS:CacheSpellData(11730, "Create Healthstone (Major)");

--ABGCS:CacheSpellData(00000, "XXX");

ABGCS:CacheSpellData(6229, "Shadow Ward");

ABGCS:CacheSpellData(6366, "Create Firestone (Lesser)");--TODO: Add this to a category
ABGCS:CacheSpellData(17951, "Create Firestone");--TODO: Add this to a category
ABGCS:CacheSpellData(17952, "Create Firestone (Greater)");--TODO: Add this to a category
ABGCS:CacheSpellData(17953, "Create Firestone (Major)");--TODO: Add this to a category

ABGCS:CacheSpellData(2362, "Create Spellstone");--TODO: Add this to a category
ABGCS:CacheSpellData(17727, "Create Spellstone (Greater)");--TODO: Add this to a category

ABGCS:CacheSpellData(132, "Detect Lesser Invisibility");	--TODO: Add this to a category
ABGCS:CacheSpellData(2970, "Detect Invisibility");	--TODO: Add this to a category
ABGCS:CacheSpellData(11743, "Detect Greater Invisibility");	--TODO: Add this to a category

ABGCS:CacheSpellData(5500, "Sense Demons");

ABGCS:CacheSpellData(704, "Curse of Recklessness");
ABGCS:CacheSpellData(1714, "Curse of Tongues");
ABGCS:CacheSpellData(702, "Curse of Weakness"); --y
ABGCS:CacheSpellData(17862, "Curse of Shadow");
ABGCS:CacheSpellData(1490, "Curse of the Elements");

ABGCS:CacheSpellData(693, "Create Soulstone (Minor)");
ABGCS:CacheSpellData(20752, "Create Soulstone (Lesser)");
ABGCS:CacheSpellData(20755, "Create Soulstone");
ABGCS:CacheSpellData(20755, "Create Soulstone (Greater)");
ABGCS:CacheSpellData(20757, "Create Soulstone (Major)");

ABGCS:CacheSpellData(698, "Ritual of Summoning");


ABGCS:CacheSpellData(18220, "Dark Pact");
ABGCS:CacheSpellData(5697, "Unending Breath");
ABGCS:CacheSpellData(126, "Eye of Kilrogg");
ABGCS:CacheSpellData(691, "Summon Felhunter");
ABGCS:CacheSpellData(688, "Summon Imp");   -- y
ABGCS:CacheSpellData(712, "Summon Succubus");
ABGCS:CacheSpellData(697, "Summon Voidwalker");
ABGCS:CacheSpellData(1122, "Summon Infernal");

--Warrior
ABGCS:CacheSpellData(100, "Charge");
ABGCS:CacheSpellData(71, "Defensive Stance");
ABGCS:CacheSpellData(1160, "Demoralizing Shout");
ABGCS:CacheSpellData(20252, "Intercept");
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
