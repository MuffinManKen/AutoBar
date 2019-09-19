
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
ABGCS:CacheSpellData(8017, "Rockbiter Weapon");


ABGCS:CacheSpellData(8042, "Earth Shock");
ABGCS:CacheSpellData(2484, "Earthbind Totem");
ABGCS:CacheSpellData(8071, "Stoneskin Totem");
ABGCS:CacheSpellData(5730, "Stoneclaw Totem");
ABGCS:CacheSpellData(8075, "Strength of Earth Totem");



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


ABGCS:CacheSpellData(1714, "Curse of Tongues");
ABGCS:CacheSpellData(702, "Curse of Weakness"); --y
ABGCS:CacheSpellData(18220, "Dark Pact");
ABGCS:CacheSpellData(20707, "Soulstone");
ABGCS:CacheSpellData(5697, "Unending Breath");
ABGCS:CacheSpellData(6201, "Create Healthstone");
ABGCS:CacheSpellData(126, "Eye of Kilrogg");
ABGCS:CacheSpellData(691, "Summon Felhunter");
ABGCS:CacheSpellData(688, "Summon Imp");   -- y
ABGCS:CacheSpellData(712, "Summon Succubus");
ABGCS:CacheSpellData(697, "Summon Voidwalker");
ABGCS:CacheSpellData(1122, "Summon Infernal");
ABGCS:CacheSpellData(698, "Ritual of Summoning");

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
