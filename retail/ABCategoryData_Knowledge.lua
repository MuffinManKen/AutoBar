--
-- AutoBar Knowledge Category
-- Custom category for Scholar's Knowledge items
--
-- To add item IDs to this category, edit the KNOWLEDGE_ITEMS table below.
-- Simply add the item ID to the list, one per line.
--

local _ADDON_NAME, AB = ...

local code = AB.code ---@class ABCode
local ItemsCategory = AB.ItemsCategory

--#region Knowledge Category

-- EDIT THIS TABLE: Add item IDs for Knowledge items
local KNOWLEDGE_ITEMS = {
    192131, -- Valdrakken Weapon Chain
    192132, -- Draconium Blade Sharpener
    193891, -- Experimental Substance
    193897, -- Reawakened Catalyst
    193898, -- Umbral Bone Needle
    193899, -- Primalweave Spindle
    193900, -- Prismatic Focusing Shard
    193901, -- Primal Dust
    193902, -- Eroded Titan Gizmo
    193903, -- Watcher Power Core
    193904, -- Phoenix Feather Quill
    193905, -- Iskaaran Trading Ledger
    193907, -- Chipped Tyrstone
    193909, -- Ancient Gem Fragments
    193910, -- Molted Dragon Scales
    193913, -- Preserved Animal Parts
    194039, -- Heated Ore Sample
    194062, -- Unyielding Stone Chunk
    198837, -- Curious Hide Scraps
    198963, -- Decaying Phlegm
    198964, -- Elementious Splinter
    198965, -- Primeval Earth Fragment
    198966, -- Molten Globule
    198967, -- Primordial Aether
    198968, -- Primalist Charm
    198969, -- Keeper's Mark
    198970, -- Infinitely Attachable Pair o' Docks
    198971, -- Curious Djaradin Rune
    198972, -- Draconic Glamour
    198973, -- Incandescent Curio
    198974, -- Elegantly Engraved Embellishment
    198975, -- Ossified Hide
    198976, -- Exceedingly Soft Skin
    198977, -- Ohn'arhan Weave
    198978, -- Stupidly Effective Stitchery
    200677, -- Dreambloom Petal
    200678, -- Dreambloom
    201300, -- Iridescent Ore Fragments
    201301, -- Iridescent Ore
    201356, -- Glimmer of Fire
    201357, -- Glimmer of Frost
    201358, -- Glimmer of Air
    201359, -- Glimmer of Earth
    202011, -- Elementally-Charged Stone
    202014, -- Infused Pollen
    222552, -- Algari Treatise on Herbalism
    222621, -- Algari Treatise on Engineering
    224007, -- Uses for Leftover Husks (How to Take Them Apart)
    224023, -- Herbal Embalming Techniques
    224024, -- Theories of Bodily Transmutation, Chapter 8
    224036, -- And That's A Web-Wrap!
    224038, -- Smithing After Saronite
    224050, -- Web Sparkles: Pretty and Powerful
    224052, -- Clocks, Gears, Sprockets, and Legs
    224053, -- Eight Views on Defense against Hostile Runes
    224054, -- Emergent Crystals of the Surface-Dwellers
    224055, -- A Rocky Start
    224056, -- Uses for Leftover Husks (After You Take Them Apart)
    224264, -- Deepgrove Petal
    224265, -- Deepgrove Rose
    224583, -- Slab of Slate
    224584, -- Erosion-Polished Slate
    224780, -- Toughened Tempest Pelt
    224781, -- Abyssal Fur
    227407, -- Faded Blacksmith's Diagrams
    225234, -- Alchemical Sediment
    227408, -- Faded Scribe's Runic Drawings
    227409, -- Faded Alchemist's Research
    227410, -- Faded Tailor's Diagrams
    227411, -- Faded Enchanter's Research
    227412, -- Faded Engineer's Scribblings
    227413, -- Faded Jeweler's Illustrations
    227414, -- Faded Leatherworker's Diagrams
    227415, -- Faded Herbalist's Notes
    227416, -- Faded Miner's Notes
    227417, -- Faded Skinner's Notes
    227418, -- Exceptional Blacksmith's Diagrams
    227419, -- Exceptional Scribe's Runic Drawings
    227420, -- Exceptional Alchemist's Research
    227421, -- Exceptional Tailor's Diagrams
    227422, -- Exceptional Enchanter's Research
    227423, -- Exceptional Engineer's Scribblings
    227424, -- Exceptional Jeweler's Illustrations
    227425, -- Exceptional Leatherworker's Diagrams
    227426, -- Exceptional Herbalist's Notes
    227427, -- Exceptional Miner's Notes
    227428, -- Exceptional Skinner's Notes
    227429, -- Pristine Blacksmith's Diagrams
    227430, -- Pristine Scribe's Runic Drawings
    227431, -- Pristine Alchemist's Research
    227432, -- Pristine Tailor's Diagrams
    227433, -- Pristine Enchanter's Research
    227434, -- Pristine Engineer's Scribblings
    227435, -- Pristine Jeweler's Illustrations
    227436, -- Pristine Leatherworker's Diagrams
    227437, -- Pristine Herbalist's Notes
    227438, -- Pristine Miner's Notes
    227439, -- Pristine Skinner's Notes
    227659, -- Fleeting Arcane Manifestation
    227661, -- Gleaming Telluric Crystal
    227662, -- Shimmering Dust
    228738, -- Flicker of Tailoring Knowledge
    228739, -- Glimmer of Tailoring Knowledge
    224835, -- Deepgrove Roots
    232499, -- Undermine Treatise on Alchemy
    232500, -- Undermine Treatise on Blacksmithing
    232501, -- Undermine Treatise on Enchanting
    232502, -- Undermine Treatise on Tailoring
    232503, -- Undermine Treatise on Herbalism
    232504, -- Undermine Treatise on Jewelcrafting
    232505, -- Undermine Treatise on Leatherworking
    232506, -- Undermine Treatise on Skinning
    232507, -- Undermine Treatise on Engineering
    232508, -- Undermine Treatise on Inscription
    232509, -- Undermine Treatise on Mining
    235855, -- Ethereal Tome of Tailoring Knowledge
    235856, -- Ethereal Tome of Skinning Knowledge
    235857, -- Ethereal Tome of Mining Knowledge
    235858, -- Ethereal Tome of Leatherworking Knowledge
    235859, -- Ethereal Tome of Jewelcrafting Knowledge
    235860, -- Ethereal Tome of Inscription Knowledge
    235861, -- Ethereal Tome of Herbalism Knowledge
    235862, -- Ethereal Tome of Engineering Knowledge
    235863, -- Ethereal Tome of Enchanting Knowledge
    235864, -- Ethereal Tome of Blacksmithing Knowledge
    235865, -- Ethereal Tome of Alchemy Knowledge
}

AB.KnowledgeCategory = CreateFromMixins(AB.CategoryClass)
local KnowledgeCategory = AB.KnowledgeCategory

function KnowledgeCategory:new()
    local obj = CreateFromMixins(self)
    obj:init("Knowledge", "Interface\\Icons\\INV_Misc_Book_08")

    obj.items = KNOWLEDGE_ITEMS -- Direct assignment - items should be an array

    return obj
end

-- No need for Refresh method since items don't change

-- Register the Knowledge category
if AutoBarCategoryList then
    AutoBarCategoryList["Knowledge"] = KnowledgeCategory:new()
end

--#endregion Knowledge Category