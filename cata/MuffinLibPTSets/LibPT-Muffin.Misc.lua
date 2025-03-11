--
-- LibPT-Muffin.Misc
--
if not LibStub("LibPeriodicTable-3.1", true) then error("PT3 must be loaded before data") end
LibStub("LibPeriodicTable-3.1"):AddData("Muffin.Misc", "Rev: 23",
{
	["Muffin.Misc.Hearth"] = "6948, 40582, 54452, 64488, 184871",
	["Muffin.Misc.Openable"] = "4632, 4633, 4634, 4636, 4637, 4638, 5335, 5738, 5758, 5759, 5760, 5857, 5858, 6307, 6351, 6352, 6353, 6354, 6355, 6356, 6357, 6643, 6644, 6645, 6646, 6647, 6715, 6755, 6827, 7190, 7209, 7868, 7870, 8049, 8366, 8484, 8502, 8503, 8504, 8505, 8506, 8507, 8647, 9265, 9276, 9363, 9529, 9532, 9537, 9539, 9540, 9541, 10456, 10479, 10569, 10595, 10695, 10752, 10773, 10834, 11024, 11107, 11422, 11423, 11568, 11617, 11883, 11887, 11912, 11937, 11938, 11955, 11966, 12033, 12122, 12339, 12849, 13247, 13874, 13875, 13881, 13891, 13918, 15699, 15876, 15902, 16783, 16882, 16883, 16884, 16885, 17685, 17726, 17727, 17962, 17963, 17964, 17965, 17969, 18636, 18804, 19035, 19150, 19151, 19152, 19153, 19154, 19155, 19296, 19297, 19298, 19422, 19425, 20228, 20229, 20230, 20231, 20233, 20236, 20367, 20393, 20469, 20601, 20602, 20603, 20708, 20766, 20767, 20768, 20805, 20808, 20809, 21042, 21113, 21131, 21132, 21133, 21150, 21156, 21162, 21163, 21164, 21191, 21216, 21228, 21243, 21266, 21270, 21271, 21310, 21315, 21327, 21363, 21386, 21509, 21510, 21511, 21512, 21513, 21528, 21640, 21740, 21741, 21742, 21743, 21746, 21812, 21975, 21979, 21980, 21981, 22137, 22152, 22154, 22155, 22156, 22157, 22158, 22159, 22160, 22161, 22162, 22163, 22164, 22165, 22166, 22167, 22168, 22169, 22170, 22171, 22172, 22178, 22233, 22320, 22568, 22648, 22649, 22650, 22746, 23022, 23224, 23846, 23895, 23921, 24336, 24402, 25419, 25422, 25423, 25424, 27446, 27481, 27511, 27513, 28135, 28499, 29569, 30260, 30320, 30650, 31408, 31522, 31800, 31952, 31955, 32064, 32462, 32624, 32625, 32626, 32627, 32628, 32629, 32630, 32631, 32724, 32777, 32835, 33045, 33844, 33857, 33926, 33928, 34077, 34119, 34426, 34503, 34548, 34583, 34584, 34585, 34587, 34592, 34593, 34594, 34595, 34846, 34863, 34871, 35232, 35286, 35313, 35348, 35512, 35745, 35792, 35945, 37168, 37586, 37605, 38539, 39014, 39418, 39883, 39903, 39904, 40308, 41426, 41888, 42953, 43346, 43347, 43504, 43556, 43575, 43622, 43624, 44113, 44142, 44161, 44163, 44475, 44663, 44700, 44718, 44751, 44943, 44951, 45072, 45328, 45724, 45875, 45878, 45986, 46007, 46110, 46740, 46809, 46810, 46812, 49294, 49369, 49631, 49909, 49926, 50160, 50161, 50238, 50301, 50409, 51316, 51999, 52000, 52001, 52002, 52003, 52004, 52005, 52006, 52274, 52304, 52331, 52344, 52676, 54467, 54516, 54535, 54536, 54537, 57540, 60681, 61387, 62062, 63349, 64491, 64657, 65513, 66943, 67248, 67250, 67414, 67443, 67495, 67539, 67597, 68133, 68384, 68598, 68689, 68729, 68795, 68798, 68799, 68800, 68801, 68802, 68803, 68804, 68805, 68813, 69817, 69818, 69822, 69823, 69886, 69903, 69999, 70719, 70931, 70938, 71631, 73204, 73792, 77956, 78897, 78898, 78899, 78900, 78901, 78902, 78903, 78904, 78905, 78906, 78907, 78908, 78909, 78910, 78930, 187714, 187799, 191060, 191061, 199210, 200238, 200239, 200240, 202269, 208157, 232947, 232948, 232949, 232950, 232951, 232952, 232953, 232954, 232955, 232956, 232957, 232958, 232959, 232960, 232961, 232962, 232963, 232964, 232965, 232966, 232967, 232968, 232969, 232970, 232971, 232972, 232973, 232974, 232975, 232976, 232977, 239111, 239112, 239113, 239114, 239220",
	["Muffin.Misc.Quest"] = "",
	["Muffin.Misc.StartsQuest"] = "1307, 1357, 1972, 3082, 4613, 4854, 5179, 6196, 6497, 8244, 8623, 8704, 8705, 9326, 10590, 10593, 12842, 14646, 14647, 14648, 14649, 14650, 14651, 16303, 16304, 16305, 16408, 16782, 17115, 17116, 17409, 18422, 18423, 18628, 18706, 18987, 19002, 19003, 19016, 19018, 19228, 19257, 19267, 19277, 19423, 19443, 19452, 19802, 20460, 20461, 20483, 20644, 20741, 20765, 20798, 20938, 20941, 20942, 21220, 21221, 21230, 21246, 21247, 21248, 21249, 21250, 21251, 21252, 21253, 21255, 21256, 21749, 21750, 21776, 22597, 22723, 22727, 22888, 22970, 22972, 22973, 22974, 22975, 22977, 23179, 23180, 23181, 23182, 23183, 23184, 23228, 23249, 23338, 23580, 23678, 23759, 23777, 23797, 23837, 23850, 23870, 23900, 23904, 23910, 24132, 24228, 24330, 24407, 24414, 24483, 24484, 24504, 24558, 24559, 25459, 25705, 25706, 28113, 28114, 28552, 28598, 29233, 29234, 29235, 29236, 29476, 29588, 29590, 29738, 30431, 30579, 30756, 31120, 31239, 31241, 31345, 31363, 31384, 31489, 31707, 31890, 31891, 31907, 31914, 32385, 32386, 32405, 32523, 32621, 32726, 33102, 33121, 33289, 33314, 33345, 33347, 33961, 33962, 33978, 34028, 34090, 34091, 34469, 34777, 34815, 34984, 35120, 35568, 35569, 35648, 35723, 35855, 36742, 36744, 36746, 36756, 36780, 36855, 36856, 36940, 36958, 37163, 37164, 37432, 37571, 37599, 37736, 37737, 37830, 37833, 38280, 38281, 38321, 38567, 38660, 38673, 39713, 40666, 41267, 41556, 42203, 42772, 43242, 43297, 44148, 44158, 44259, 44276, 44294, 44326, 44569, 44577, 44725, 44927, 44979, 45039, 45506, 45857, 46004, 46052, 46053, 46128, 46318, 46875, 46876, 46877, 46878, 46879, 46880, 46881, 46882, 46883, 46884, 46955, 47039, 47246, 48679, 49010, 49200, 49203, 49219, 49220, 49641, 49643, 49644, 49667, 49676, 49776, 49932, 50320, 50379, 50380, 51315, 52079, 52197, 53053, 54345, 54614, 54639, 55166, 55167, 55181, 55186, 55243, 56474, 56571, 56812, 57102, 57118, 57935, 58117, 58491, 58898, 59143, 60816, 60886, 60956, 61310, 61322, 61378, 61505, 62021, 62044, 62045, 62046, 62056, 62138, 62281, 62282, 62483, 62768, 62933, 63090, 63250, 63276, 63686, 63700, 64353, 64450, 65894, 65895, 65896, 65897, 69854, 70928, 70932, 71635, 71636, 71637, 71638, 71715, 71716, 71951, 71952, 71953, 74034, 77957",
	["Muffin.Misc.Reputation"] = "12844, 19707, 19708, 19709, 19710, 19711, 19712, 19713, 19714, 19715, 19858, 24520, 24522, 43154, 43155, 43156, 43157, 43471, 43950, 44710, 44711, 44713, 45574, 45577, 45578, 45579, 45580, 45581, 45582, 45583, 45584, 45585, 45714, 45715, 45716, 45717, 45718, 45719, 45720, 45721, 45722, 45723, 49702, 63359, 63517, 63518, 64398, 64399, 64400, 64401, 64402, 64492, 64882, 64884, 65904, 65905, 65906, 65907, 65908, 65909, 69209, 69210, 70145, 70146, 70147, 70148, 70149, 70150, 70151, 70152, 70153, 70154, 71087, 71088, 71134, 206392",
})
