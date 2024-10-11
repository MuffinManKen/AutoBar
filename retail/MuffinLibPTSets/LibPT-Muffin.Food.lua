--
-- Muffin.Food
--
if not LibStub("LibPeriodicTable-3.1", true) then error("PT3 must be loaded before data") end
LibStub("LibPeriodicTable-3.1"):AddData("Muffin.Food", "Rev: 44",
{
	["Muffin.Food.Health.Basic"] = "117, 414, 422, 733, 787, 961, 1113, 1114, 1326, 1487, 1707, 2070, 2287, 2679, 2681, 2685, 3770, 3771, 3927, 4536, 4537, 4538, 4539, 4540, 4541, 4542, 4544, 4592, 4593, 4594, 4599, 4601, 4602, 4604, 4605, 4606, 4607, 4608, 4656, 5057, 5066, 5095, 5349, 5478, 5526, 6290, 6299, 6316, 6807, 6887, 6890, 7097, 7228, 8075, 8076, 8364, 8932, 8948, 8950, 8952, 8953, 8957, 9681, 11109, 11415, 11444, 11951, 12238, 13546, 13755, 13893, 13930, 13932, 13933, 13935, 16166, 16167, 16168, 16169, 16170, 16766, 17119, 17344, 17406, 17407, 17408, 18255, 18632, 18633, 18635, 19223, 19224, 19225, 19304, 19305, 19306, 19696, 19994, 19995, 19996, 20857, 21030, 21031, 21033, 21235, 21552, 22019, 22324, 22895, 23160, 23495, 24072, 24338, 27661, 27854, 27855, 27856, 27857, 27858, 27859, 28486, 29393, 29394, 29412, 29448, 29449, 29450, 29451, 29452, 29453, 30355, 30458, 30610, 30816, 32685, 32686, 33048, 33443, 33449, 33451, 33452, 33454, 34747, 35947, 35948, 35949, 35950, 35951, 35952, 35953, 37252, 37452, 38427, 38428, 38706, 40202, 40356, 40358, 40359, 41729, 41751, 42428, 42429, 42430, 42431, 42432, 42433, 42434, 42778, 43087, 44049, 44071, 44072, 44607, 44608, 44609, 44722, 44749, 44854, 44855, 44940, 46690, 46691, 46784, 46793, 46796, 46797, 49253, 49397, 49600, 57518, 57544, 58258, 58259, 58260, 58261, 58262, 58263, 58264, 58265, 58266, 58267, 58268, 58269, 58275, 58276, 58277, 58278, 58279, 58280, 59227, 59228, 59231, 59232, 60267, 60268, 60375, 60377, 60378, 60379, 61383, 62676, 62677, 62909, 63691, 63692, 63693, 63694, 64641, 65731, 67230, 67270, 67271, 67272, 67273, 69243, 69244, 69920, 73260, 74641, 74921, 75027, 75029, 75030, 75031, 75032, 75033, 75034, 75035, 75036, 81175, 81889, 81916, 81917, 81918, 81919, 81920, 81921, 81922, 82448, 82449, 82450, 82451, 83097, 85504, 86057, 86508, 88398, 90135, 111456, 111842, 112095, 113099, 113290, 115351, 115352, 115353, 115354, 115355, 117454, 117457, 117469, 117470, 117471, 117472, 117473, 117474, 118050, 118051, 128219, 128498, 128761, 128763, 128764, 128835, 128836, 128837, 128838, 128839, 128840, 128843, 128844, 128845, 128846, 128847, 128848, 128849, 128851, 132752, 132753, 133893, 133979, 133981, 133983, 135557, 136544, 136545, 136546, 136547, 136548, 136549, 136550, 136551, 136552, 136553, 136554, 136555, 136556, 136557, 136558, 136559, 136560, 138285, 138290, 138291, 138972, 138973, 138974, 138976, 138977, 138978, 138979, 138980, 138987, 139344, 139345, 140184, 140201, 140202, 140205, 140206, 140207, 140273, 140275, 140276, 140286, 140287, 140296, 140297, 140299, 140300, 140301, 140302, 140337, 140339, 140341, 140344, 140626, 140627, 140631, 140668, 140679, 140753, 140754, 141206, 141207, 141208, 141212, 141213, 141214, 143681, 147774, 151775, 152558, 152718, 155592, 155811, 155812, 155910, 158466, 159869, 159870, 159871, 159872, 159873, 159874, 159875, 159876, 159878, 159879, 159897, 159898, 159899, 159900, 159919, 159920, 160092, 160483, 160517, 160518, 160554, 160611, 160989, 161126, 161127, 161128, 161314, 161321, 161346, 161347, 161348, 161373, 161383, 161384, 162010, 162545, 162546, 162550, 162554, 162555, 162556, 162557, 162558, 162559, 162561, 162562, 162563, 162564, 162565, 162566, 162567, 162568, 162582, 162583, 163049, 163050, 163051, 163052, 163053, 163054, 163056, 163057, 163058, 163060, 163061, 163075, 163076, 163077, 163083, 163100, 163105, 163106, 163107, 163108, 163109, 163110, 163114, 163115, 163116, 163117, 163118, 163133, 163134, 163135, 163181, 163208, 163841, 164376, 167739, 168392, 169115, 169116, 169117, 169118, 169946, 169947, 169956, 172091, 173759, 173760, 173761, 174041, 174282, 174285, 177039, 177043, 178216, 178222, 178223, 178224, 178225, 178226, 178227, 178228, 178247, 178252, 178536, 178537, 178540, 178541, 178543, 178544, 178546, 178547, 178548, 178549, 178550, 178551, 178552, 178900, 179011, 179012, 179013, 179014, 179015, 179016, 179017, 179018, 179019, 179020, 179021, 179022, 179023, 179025, 179026, 179166, 179267, 179268, 179269, 179270, 179271, 179272, 179273, 179274, 179275, 179276, 179281, 179283, 179284, 179285, 179286, 179287, 180429, 180430, 182459, 183597, 184202, 184281, 186725, 191050, 191051, 194686, 194688, 194689, 194693, 194694, 194695, 195455, 195456, 195457, 195458, 195462, 195463, 196540, 196583, 196585, 197758, 197759, 197760, 197761, 197850, 197851, 197852, 197853, 197855, 197858, 200099, 200304, 200619, 200966, 201045, 201090, 201398, 201415, 201416, 201417, 201422, 202033, 202063, 202108, 202314, 204730, 205684, 205693, 205793, 206139, 206140, 206474, 211810, 215448, 223970, 224009, 224269, 226275, 227272, 227273, 227274, 227275, 227297, 227298, 227299, 227300, 227301, 227302, 227303, 227304, 227305, 227306, 227307, 227308",
	["Muffin.Food.Mana.Basic"] = "159, 1179, 1205, 1401, 1645, 1708, 2136, 2288, 3772, 4791, 5350, 8077, 8078, 8079, 8766, 9451, 10841, 17404, 18300, 19299, 19300, 22018, 27860, 28399, 29395, 29401, 29454, 30457, 30703, 32453, 32455, 32668, 33042, 33444, 33445, 35954, 37253, 38429, 38430, 38431, 38698, 39520, 40357, 41731, 42777, 43086, 43236, 44750, 44941, 49254, 49601, 49602, 58256, 58257, 58274, 59029, 59229, 59230, 60269, 61382, 62672, 62675, 63023, 63251, 63530, 68140, 74636, 74822, 75028, 75037, 81923, 81924, 85501, 88532, 88578, 90659, 90660, 104348, 105711, 111455, 117452, 117475, 128385, 128850, 128853, 133586, 133980, 136806, 138292, 138975, 138981, 138982, 139346, 139347, 140203, 140204, 140265, 140266, 140269, 140272, 140298, 140340, 140628, 140629, 141215, 141527, 152717, 155909, 159867, 159868, 162012, 162547, 162569, 162570, 163101, 163102, 163104, 163783, 163784, 163785, 163786, 169119, 169120, 169763, 169948, 169949, 169952, 169954, 173762, 174281, 177040, 178217, 178534, 178535, 178538, 178539, 178542, 178545, 179992, 179993, 184201, 186704, 190936, 191052, 191053, 191917, 191918, 191919, 194683, 194684, 194685, 194690, 194691, 194692, 195459, 195460, 195464, 196584, 197770, 197771, 197849, 197856, 197857, 200305, 200890, 201046, 201697, 201698, 201721, 201725, 201813, 202315, 204729, 205794, 222744, 222745, 224010, 224762, 226274, 227309, 227310, 227311, 227312, 227313, 227314, 227315, 227316, 227317, 227318, 227319, 227320, 227321, 227322, 227323, 227324",
	["Muffin.Food.Combo.Basic"] = "2682, 3448, 13724, 13931, 19301, 20031, 20516, 21215, 28112, 32722, 33053, 34062, 34759, 34760, 34761, 34780, 43518, 43523, 45932, 65499, 65500, 65515, 65516, 65517, 68687, 75026, 75038, 80610, 80618, 86026, 87253, 98111, 98116, 98118, 108920, 111544, 112449, 113509, 116120, 118424, 130192, 130259, 133575, 138983, 138986, 139398, 140352, 140355, 152564, 154889, 154891, 158926, 163692, 163781, 172046, 172047, 173350, 173351, 173859, 174283, 174284, 174351, 177041, 177042, 178515, 180006, 180011, 180054, 187911, 190880, 190881, 191056, 194680, 194681, 194682, 195465, 195466, 196582, 197762, 197763, 197795, 197847, 197848, 197854, 198356, 198441, 200871, 201047, 201413, 201419, 201420, 201469, 201820, 204235, 204790, 205690, 205692, 207956, 226262, 226811, 227325, 227326, 227327, 227328, 227329, 227330, 227331, 227332, 227333, 227334, 227335, 227336",
	["Muffin.Food.Health.Buff"] = "724, 1017, 1082, 2680, 2683, 2684, 2687, 2888, 3220, 3662, 3663, 3664, 3665, 3666, 3726, 3727, 3728, 3729, 4457, 5472, 5474, 5476, 5477, 5479, 5480, 5525, 5527, 6038, 6888, 7806, 7807, 7808, 11584, 12209, 12210, 12212, 12213, 12214, 12215, 12216, 12218, 12224, 13851, 13929, 16971, 17197, 17198, 17222, 18045, 20074, 20452, 21023, 22645, 23756, 24105, 24539, 27635, 27636, 27651, 27655, 27657, 27658, 27659, 27660, 27662, 27664, 27665, 27666, 27667, 29292, 30155, 30357, 30358, 30359, 30361, 31672, 31673, 32721, 33052, 33867, 33872, 34125, 34748, 34749, 34750, 34751, 34752, 34754, 34755, 34756, 34757, 34758, 35563, 39691, 42779, 42994, 42995, 42997, 43001, 44791, 57519, 77264, 77272, 77273, 81400, 81401, 81402, 81403, 81404, 81405, 81408, 81409, 81410, 81411, 81412, 81413, 88379, 98122, 98123, 98124, 98125, 98126, 104339, 104340, 104341, 104342, 104343, 104344, 105717, 105719, 105720, 105722, 105723, 105724, 140338, 140342, 197774, 197775, 197776, 197777, 197778, 197779, 197780, 197781, 197782, 197783, 197784, 197785, 197786, 197787, 197788, 197789, 197790, 197791, 197792, 202290, 202401, 204072, 210819, 210821, 212491, 212492, 222702, 222703, 222704, 222705, 222706, 222707, 222708, 222709, 222724, 222726, 222727, 222728, 222729, 222730, 222731, 222740, 222742, 222743, 222750, 222751, 222752, 222753, 222754, 222755, 222756, 222757, 222772, 222773, 222774, 222775, 222776, 222777, 222778, 222779, 222784, 223966, 223968, 225592, 225855",
	["Muffin.Food.Mana.Buff"] = "34411, 120168, 197772, 223967",
	["Muffin.Food.Combo.Buff"] = "21072, 21217, 21254, 27663, 33004, 34753, 34762, 34763, 34764, 34765, 34766, 34767, 34768, 34769, 42942, 42993, 42996, 42998, 42999, 43000, 43015, 43268, 44836, 44837, 44838, 44839, 44840, 44953, 46887, 60858, 62289, 62290, 62649, 62651, 62652, 62653, 62654, 62655, 62656, 62657, 62658, 62659, 62660, 62661, 62662, 62663, 62664, 62665, 62666, 62667, 62668, 62669, 62670, 62671, 70924, 70925, 70926, 70927, 74642, 74643, 74644, 74645, 74646, 74647, 74648, 74649, 74650, 74651, 74652, 74653, 74654, 74655, 74656, 74919, 75016, 79320, 81406, 81414, 86069, 86070, 86073, 86074, 87226, 87228, 87230, 87232, 87234, 87236, 87238, 87240, 87242, 87244, 87246, 87248, 88388, 88586, 89588, 89589, 89590, 89591, 89592, 89593, 89594, 89595, 89596, 89597, 89598, 89599, 89600, 89601, 90457, 94535, 98127, 101616, 101617, 101618, 101630, 101661, 101662, 101745, 101746, 101747, 101748, 101749, 101750, 105721, 111431, 111433, 111434, 111436, 111437, 111438, 111439, 111441, 111442, 111444, 111445, 111446, 111447, 111449, 111450, 111452, 111453, 111454, 111457, 111458, 115300, 116405, 116406, 116407, 116408, 116409, 118268, 118269, 118270, 118271, 118272, 118416, 118428, 118576, 120293, 122343, 122344, 122345, 122346, 122347, 122348, 126934, 126935, 126936, 129179, 133557, 133561, 133562, 133563, 133564, 133565, 133566, 133567, 133568, 133569, 133570, 133571, 133572, 133573, 133574, 133576, 133577, 133578, 133579, 138478, 138479, 138731, 140343, 142334, 143633, 143634, 143635, 152698, 154881, 154882, 154883, 154884, 154885, 154886, 154887, 154888, 156525, 156526, 163081, 165755, 166240, 166343, 166344, 166742, 166804, 167832, 168232, 168310, 168311, 168312, 168313, 168314, 168315, 172040, 172041, 172042, 172043, 172044, 172045, 172048, 172049, 172050, 172051, 172061, 172062, 172063, 172068, 172069, 174348, 174349, 174350, 174352, 182592, 182737, 184624, 184682, 184690, 187648, 197793, 197794, 197795, 210841, 210842, 222710, 222711, 222712, 222713, 222714, 222715, 222716, 222717, 222718, 222719, 222720, 222721, 222722, 222723, 222725, 222732, 222733, 222735, 222736, 222758, 222759, 222760, 222761, 222762, 222763, 222764, 222765, 222766, 222767, 222768, 222769, 222770, 222771, 222780, 222781, 222783",
	
	["Muffin.Food.Basic"] = "m,Muffin.Food.Health.Basic,Muffin.Food.Mana.Basic,Muffin.Food.Combo.Basic",
	["Muffin.Food.Buff"] = "m,Muffin.Food.Health.Buff,Muffin.Food.Mana.Buff,Muffin.Food.Combo.Buff",

})
