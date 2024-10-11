--
-- LibPT-Muffin.Misc
--
if not LibStub("LibPeriodicTable-3.1", true) then error("PT3 must be loaded before data") end
LibStub("LibPeriodicTable-3.1"):AddData("Muffin.Misc", "Rev: 75",
{
	["Muffin.Misc.Openable"] = "3745, 4632, 4633, 4634, 4636, 4637, 4638, 5335, 5523, 5524, 5738, 5758, 5759, 5760, 6307, 6351, 6352, 6353, 6354, 6355, 6356, 6357, 6643, 6645, 6647, 6715, 6755, 6827, 7190, 7209, 7870, 7973, 8049, 8366, 8484, 8647, 9265, 9276, 9363, 9539, 9540, 9541, 10456, 10479, 10569, 10695, 10752, 10773, 10834, 11024, 11107, 11422, 11423, 11568, 11617, 11883, 11887, 11912, 11937, 11938, 11955, 11966, 12033, 12122, 12339, 12849, 13874, 13875, 13881, 13891, 13918, 15102, 15103, 15699, 15874, 15876, 15902, 16882, 16883, 16884, 16885, 17685, 17726, 17727, 17962, 17963, 17964, 17965, 17969, 18804, 19035, 19150, 19151, 19152, 19153, 19154, 19155, 19296, 19297, 19298, 19422, 19425, 20228, 20229, 20230, 20231, 20233, 20236, 20469, 20601, 20602, 20603, 20708, 20766, 20767, 20768, 20805, 20808, 20809, 21042, 21113, 21131, 21132, 21133, 21150, 21156, 21164, 21191, 21216, 21228, 21266, 21270, 21271, 21310, 21315, 21327, 21363, 21386, 21509, 21510, 21511, 21512, 21513, 21528, 21640, 21740, 21741, 21742, 21743, 21746, 21812, 21975, 21979, 21980, 21981, 22137, 22154, 22155, 22156, 22157, 22158, 22159, 22160, 22161, 22162, 22163, 22164, 22165, 22166, 22167, 22168, 22169, 22170, 22171, 22172, 22178, 22320, 22568, 22648, 22649, 22650, 22746, 23022, 23846, 23921, 24336, 24402, 24476, 25419, 25422, 25423, 25424, 27446, 27481, 27511, 27513, 29569, 29753, 29754, 29755, 29756, 29757, 29758, 29759, 29760, 29761, 29762, 29763, 29764, 29765, 29766, 29767, 30236, 30237, 30238, 30239, 30240, 30241, 30242, 30243, 30244, 30245, 30246, 30247, 30248, 30249, 30250, 30260, 30320, 30650, 31089, 31090, 31091, 31092, 31093, 31094, 31095, 31096, 31097, 31098, 31099, 31100, 31101, 31102, 31103, 31408, 31522, 31800, 31952, 31955, 32064, 32462, 32624, 32625, 32626, 32627, 32628, 32629, 32630, 32631, 32724, 32777, 32835, 33045, 33844, 33857, 33926, 33928, 34077, 34119, 34426, 34583, 34584, 34585, 34587, 34592, 34593, 34594, 34595, 34846, 34848, 34851, 34852, 34853, 34854, 34855, 34856, 34857, 34858, 34863, 34871, 35232, 35286, 35313, 35348, 35512, 35792, 35945, 36781, 37168, 37586, 39418, 39883, 40610, 40611, 40612, 40613, 40614, 40615, 40616, 40617, 40618, 40619, 40620, 40621, 40622, 40623, 40624, 40625, 40626, 40627, 40628, 40629, 40630, 40631, 40632, 40633, 40634, 40635, 40636, 40637, 40638, 40639, 41426, 41888, 43346, 43347, 43504, 43556, 43575, 43622, 43624, 44113, 44142, 44161, 44163, 44475, 44663, 44700, 44718, 44751, 44943, 44951, 45072, 45328, 45632, 45633, 45634, 45635, 45636, 45637, 45638, 45639, 45640, 45641, 45642, 45643, 45644, 45645, 45646, 45647, 45648, 45649, 45650, 45651, 45652, 45653, 45654, 45655, 45656, 45657, 45658, 45659, 45660, 45661, 45724, 45875, 45878, 45909, 45986, 46007, 46110, 46740, 46812, 49294, 49369, 49631, 49909, 49926, 50160, 50161, 50238, 50301, 50409, 51316, 51999, 52000, 52001, 52002, 52003, 52004, 52005, 52006, 52274, 52304, 52340, 52344, 52676, 54516, 54535, 54536, 54537, 57540, 58856, 60681, 61387, 62062, 63349, 63682, 63683, 63684, 64314, 64315, 64316, 64491, 64657, 65000, 65001, 65002, 65087, 65088, 65089, 65513, 66943, 67248, 67250, 67414, 67423, 67424, 67425, 67426, 67427, 67428, 67429, 67430, 67431, 67443, 67495, 67539, 67597, 68384, 68598, 68689, 68729, 68795, 68813, 69817, 69818, 69822, 69823, 69838, 69886, 69903, 69914, 69956, 69999, 70719, 70931, 70938, 71631, 71668, 71669, 71670, 71671, 71672, 71673, 71674, 71675, 71676, 71677, 71678, 71679, 71680, 71681, 71682, 71683, 71684, 71685, 71686, 71687, 71688, 72201, 73792, 77501, 77956, 78170, 78171, 78172, 78173, 78174, 78175, 78176, 78177, 78178, 78179, 78180, 78181, 78182, 78183, 78184, 78847, 78848, 78849, 78850, 78851, 78852, 78853, 78854, 78855, 78856, 78857, 78858, 78859, 78860, 78861, 78862, 78863, 78864, 78865, 78866, 78867, 78868, 78869, 78870, 78871, 78872, 78873, 78874, 78875, 78876, 78897, 78898, 78899, 78900, 78901, 78902, 78903, 78904, 78905, 78906, 78907, 78908, 78909, 78910, 78930, 85223, 85224, 85225, 85226, 85227, 85271, 85272, 85274, 85275, 85276, 85277, 85497, 85498, 86428, 86595, 86623, 87217, 87218, 87219, 87220, 87221, 87222, 87223, 87224, 87225, 87391, 87533, 87534, 87535, 87536, 87537, 87538, 87539, 87540, 87541, 87701, 87702, 87703, 87704, 87705, 87706, 87707, 87708, 87709, 87710, 87712, 87713, 87714, 87715, 87716, 87721, 87722, 87723, 87724, 87725, 87726, 87727, 87728, 87729, 87730, 88165, 88496, 88567, 89125, 89234, 89235, 89236, 89237, 89238, 89239, 89240, 89241, 89242, 89243, 89244, 89245, 89246, 89247, 89248, 89249, 89250, 89251, 89252, 89253, 89254, 89255, 89256, 89257, 89258, 89259, 89260, 89261, 89262, 89263, 89264, 89265, 89266, 89267, 89268, 89269, 89270, 89271, 89272, 89273, 89274, 89275, 89276, 89277, 89278, 89427, 89428, 89607, 89608, 89609, 89610, 89613, 89804, 89807, 89808, 89810, 89856, 89857, 89858, 89991, 90041, 90155, 90156, 90157, 90158, 90159, 90160, 90161, 90162, 90163, 90164, 90165, 90395, 90397, 90398, 90399, 90400, 90401, 90406, 90537, 90621, 90622, 90623, 90624, 90625, 90626, 90627, 90628, 90629, 90630, 90631, 90632, 90633, 90634, 90635, 90735, 90818, 90839, 90840, 90892, 91086, 92718, 92744, 92788, 92789, 92790, 92791, 92792, 92793, 92794, 92813, 92960, 93146, 93147, 93148, 93149, 93198, 93199, 93200, 93360, 93626, 93724, 94158, 94159, 94207, 94219, 94220, 94296, 94553, 94566, 95343, 95469, 95569, 95570, 95571, 95572, 95573, 95574, 95575, 95576, 95577, 95578, 95579, 95580, 95581, 95582, 95583, 95601, 95602, 95617, 95618, 95619, 95822, 95823, 95824, 95855, 95856, 95857, 95879, 95880, 95881, 95887, 95888, 95889, 95955, 95956, 95957, 96566, 96567, 96568, 96599, 96600, 96601, 96623, 96624, 96625, 96631, 96632, 96633, 96699, 96700, 96701, 97153, 97565, 97948, 97949, 97950, 97951, 97952, 97953, 97954, 97955, 97956, 97957, 98095, 98096, 98097, 98098, 98099, 98100, 98101, 98102, 98103, 98133, 98134, 98546, 98560, 98562, 99667, 99668, 99669, 99670, 99671, 99672, 99673, 99674, 99675, 99676, 99677, 99678, 99679, 99680, 99681, 99682, 99683, 99684, 99685, 99686, 99687, 99688, 99689, 99690, 99691, 99692, 99693, 99694, 99695, 99696, 99712, 99713, 99714, 99715, 99716, 99717, 99718, 99719, 99720, 99721, 99722, 99723, 99724, 99725, 99726, 99742, 99743, 99744, 99745, 99746, 99747, 99748, 99749, 99750, 99751, 99752, 99753, 99754, 99755, 99756, 102137, 102263, 102264, 102265, 102266, 102267, 102268, 102269, 102270, 102271, 102272, 102273, 102274, 102275, 102276, 102277, 102278, 102279, 102280, 102281, 102282, 102283, 102284, 102285, 102286, 102287, 102288, 102289, 102290, 102291, 102318, 102320, 102321, 102322, 102323, 103535, 103624, 103632, 104009, 104010, 104012, 104013, 104034, 104035, 104112, 104114, 104198, 104258, 104260, 104261, 104263, 104268, 104271, 104272, 104273, 104275, 104292, 104296, 104319, 104345, 104347, 105713, 105714, 105751, 106130, 106895, 107077, 107270, 107271, 108738, 108740, 110278, 110592, 110678, 111598, 111599, 111600, 112108, 112623, 113258, 114028, 114052, 114053, 114057, 114058, 114059, 114060, 114063, 114066, 114068, 114069, 114070, 114071, 114072, 114073, 114074, 114075, 114076, 114077, 114078, 114079, 114080, 114082, 114083, 114084, 114085, 114086, 114087, 114088, 114089, 114090, 114091, 114092, 114093, 114094, 114096, 114097, 114098, 114099, 114100, 114101, 114105, 114108, 114109, 114110, 114111, 114112, 114634, 114641, 114648, 114655, 114662, 114669, 114970, 116062, 116111, 116129, 116202, 116376, 116404, 116414, 116761, 116762, 116764, 116920, 116980, 117386, 117387, 117388, 117392, 117393, 117394, 117414, 118065, 118066, 118093, 118094, 118193, 118529, 118530, 118531, 118697, 118706, 118759, 118924, 118925, 118926, 118927, 118928, 118929, 118930, 118931, 119000, 119036, 119037, 119040, 119041, 119042, 119043, 119114, 119115, 119116, 119117, 119118, 119119, 119120, 119121, 119122, 119123, 119124, 119125, 119188, 119189, 119190, 119191, 119195, 119196, 119197, 119198, 119199, 119200, 119201, 119305, 119306, 119307, 119308, 119309, 119311, 119312, 119313, 119314, 119315, 119318, 119319, 119320, 119321, 119322, 119330, 120142, 120146, 120147, 120151, 120170, 120184, 120212, 120213, 120214, 120215, 120216, 120217, 120218, 120219, 120220, 120221, 120222, 120223, 120224, 120225, 120226, 120227, 120228, 120229, 120230, 120231, 120232, 120233, 120234, 120235, 120236, 120237, 120238, 120239, 120240, 120241, 120242, 120243, 120244, 120245, 120246, 120247, 120248, 120249, 120250, 120251, 120252, 120253, 120254, 120255, 120256, 120301, 120302, 120312, 120319, 120320, 120321, 120322, 120323, 120324, 120325, 120334, 120353, 120354, 120355, 120356, 121331, 122163, 122191, 122478, 122479, 122480, 122481, 122482, 122483, 122484, 122485, 122486, 122535, 122607, 122613, 122621, 122622, 122623, 122624, 122625, 122626, 122627, 122628, 122629, 122630, 122631, 122632, 122633, 122677, 122718, 123857, 123858, 123961, 123962, 123963, 123975, 124054, 124550, 124551, 124552, 124553, 124554, 124555, 124556, 124557, 124558, 124559, 124560, 124561, 124562, 124670, 126901, 126902, 126903, 126904, 126905, 126906, 126907, 126908, 126909, 126910, 126911, 126912, 126913, 126914, 126915, 126916, 126917, 126918, 126919, 126920, 126921, 126922, 126923, 126924, 126947, 127141, 127148, 127390, 127395, 127751, 127777, 127778, 127779, 127780, 127781, 127782, 127783, 127784, 127790, 127791, 127792, 127793, 127794, 127795, 127796, 127797, 127798, 127799, 127800, 127803, 127804, 127805, 127806, 127807, 127808, 127809, 127810, 127816, 127817, 127818, 127819, 127820, 127821, 127822, 127823, 127831, 127853, 127854, 127855, 127953, 127954, 127955, 127956, 127957, 127958, 127959, 127960, 127961, 127962, 127963, 127964, 127965, 127966, 127967, 127995, 128025, 128213, 128214, 128215, 128216, 128319, 128327, 128348, 128391, 128513, 128652, 128653, 128670, 128803, 129746, 130186, 132892, 133549, 133721, 133803, 133804, 135539, 135540, 135541, 135542, 135543, 135544, 135545, 135546, 136359, 136362, 136383, 136926, 137209, 137414, 137560, 137561, 137562, 137563, 137564, 137565, 137590, 137591, 137592, 137593, 137594, 137600, 137608, 138098, 138469, 138470, 138471, 138472, 138473, 138474, 138475, 138476, 139048, 139049, 139137, 139284, 139341, 139343, 139381, 139382, 139383, 139416, 139467, 139484, 139486, 139487, 139488, 139771, 139777, 139879, 140148, 140150, 140152, 140154, 140200, 140220, 140221, 140222, 140224, 140225, 140226, 140227, 140591, 140601, 140997, 140998, 141069, 141155, 141156, 141157, 141158, 141159, 141160, 141161, 141162, 141163, 141164, 141165, 141166, 141167, 141168, 141169, 141170, 141171, 141172, 141173, 141174, 141175, 141176, 141177, 141178, 141179, 141180, 141181, 141182, 141183, 141184, 141344, 141350, 141410, 141995, 142023, 142113, 142114, 142115, 142342, 142350, 142381, 142447, 143562, 143563, 143564, 143565, 143566, 143567, 143568, 143569, 143570, 143571, 143572, 143573, 143574, 143575, 143576, 143577, 143578, 143579, 143606, 143607, 143753, 143948, 144291, 144330, 144345, 144373, 144374, 144375, 144376, 144377, 144378, 144379, 146317, 146747, 146748, 146749, 146750, 146751, 146752, 146753, 146799, 146800, 146801, 146897, 146898, 146899, 146900, 146901, 146902, 146948, 147212, 147213, 147214, 147215, 147216, 147217, 147218, 147219, 147220, 147221, 147222, 147223, 147316, 147317, 147318, 147319, 147320, 147321, 147322, 147323, 147324, 147325, 147326, 147327, 147328, 147329, 147330, 147331, 147332, 147333, 147351, 147361, 147384, 147432, 147446, 147518, 147519, 147520, 147521, 147573, 147574, 147575, 147576, 147786, 147791, 147792, 147793, 147794, 147795, 147796, 147797, 147798, 147799, 147800, 147801, 147876, 147905, 147907, 149503, 149504, 149574, 149752, 149753, 150924, 151060, 151221, 151222, 151223, 151224, 151225, 151229, 151230, 151231, 151232, 151233, 151235, 151238, 151264, 151345, 151350, 151464, 151465, 151466, 151467, 151468, 151469, 151470, 151471, 151482, 151550, 151551, 151552, 151553, 151554, 151557, 151558, 151638, 152065, 152066, 152067, 152068, 152069, 152070, 152071, 152072, 152073, 152074, 152075, 152076, 152077, 152078, 152079, 152080, 152081, 152082, 152102, 152103, 152104, 152105, 152106, 152107, 152108, 152515, 152516, 152517, 152518, 152519, 152520, 152521, 152522, 152523, 152524, 152525, 152526, 152527, 152528, 152529, 152530, 152531, 152532, 152578, 152580, 152581, 152582, 152649, 152650, 152652, 152733, 152734, 152735, 152736, 152737, 152738, 152739, 152740, 152741, 152742, 152743, 152744, 152799, 152868, 152922, 152923, 153059, 153060, 153061, 153062, 153063, 153064, 153065, 153066, 153067, 153068, 153116, 153117, 153118, 153119, 153120, 153121, 153122, 153132, 153135, 153136, 153137, 153138, 153139, 153140, 153141, 153142, 153143, 153144, 153145, 153146, 153147, 153148, 153149, 153150, 153151, 153152, 153153, 153154, 153155, 153156, 153157, 153158, 153173, 153191, 153202, 153205, 153206, 153207, 153208, 153209, 153210, 153211, 153212, 153213, 153214, 153215, 153216, 153248, 153501, 153502, 153503, 153504, 153574, 154759, 154903, 154904, 154905, 154906, 154907, 154908, 154909, 154910, 154911, 154912, 154991, 154992, 156682, 156683, 156688, 156689, 156698, 156707, 156836, 157822, 157823, 157824, 157825, 157826, 157827, 157828, 157829, 157830, 157831, 159783, 160054, 160268, 160322, 160324, 160439, 160485, 160514, 160578, 160831, 161083, 161084, 161878, 162637, 162644, 162974, 163059, 163139, 163141, 163142, 163144, 163146, 163148, 163611, 163612, 163613, 163633, 163734, 163825, 163826, 164251, 164252, 164253, 164254, 164257, 164258, 164259, 164260, 164261, 164262, 164263, 164264, 164579, 164625, 164626, 164627, 164931, 164938, 164939, 164940, 165711, 165712, 165713, 165714, 165715, 165716, 165717, 165718, 165724, 165729, 165730, 165731, 165732, 165839, 165851, 166245, 166282, 166290, 166292, 166294, 166295, 166297, 166298, 166299, 166300, 166505, 166508, 166509, 166510, 166511, 166512, 166513, 166514, 166515, 166529, 166530, 166531, 166532, 166533, 166534, 166535, 166536, 166537, 166741, 167026, 167696, 167848, 167850, 167851, 167853, 167855, 167858, 168057, 168096, 168124, 168162, 168204, 168208, 168209, 168210, 168211, 168263, 168264, 168266, 168269, 168394, 168395, 168488, 168496, 168740, 168833, 169113, 169133, 169137, 169335, 169336, 169337, 169338, 169339, 169340, 169341, 169342, 169343, 169430, 169471, 169475, 169477, 169478, 169479, 169480, 169481, 169482, 169483, 169484, 169485, 169666, 169838, 169848, 169850, 169903, 169904, 169905, 169908, 169909, 169910, 169911, 169914, 169915, 169916, 169917, 169919, 169920, 169921, 169922, 169939, 169940, 170061, 170065, 170073, 170074, 170144, 170145, 170162, 170185, 170188, 170190, 170195, 170473, 170489, 170502, 170539, 171209, 171210, 171211, 171305, 171987, 171988, 172014, 172021, 172224, 172225, 173372, 173393, 173394, 173395, 173396, 173397, 173398, 173399, 173400, 173401, 173402, 173403, 173404, 173405, 173406, 173407, 173408, 173409, 173410, 173411, 173412, 173413, 173414, 173415, 173416, 173417, 173418, 173419, 173420, 173422, 173423, 173424, 173425, 173734, 173949, 173950, 173983, 173987, 173988, 173989, 173990, 173991, 173992, 173993, 173994, 173995, 173996, 173997, 174039, 174181, 174182, 174183, 174184, 174194, 174195, 174358, 174483, 174484, 174529, 174630, 174631, 174632, 174633, 174634, 174635, 174636, 174637, 174638, 174642, 174652, 174958, 174959, 174960, 174961, 175021, 175024, 175095, 175135, 178078, 178128, 178513, 178528, 178529, 178965, 178966, 178967, 178968, 178969, 179311, 179380, 180085, 180128, 180355, 180378, 180379, 180380, 180386, 180442, 180522, 180532, 180533, 180646, 180647, 180648, 180649, 180875, 180974, 180975, 180976, 180977, 180979, 180980, 180981, 180983, 180984, 180985, 180988, 180989, 181372, 181475, 181476, 181556, 181557, 181732, 181733, 181739, 181741, 181767, 181778, 181779, 181780, 182114, 182590, 182591, 183424, 183426, 183428, 183429, 183699, 183701, 183702, 183703, 183822, 183834, 183835, 183882, 183883, 183884, 183885, 183886, 184045, 184046, 184047, 184048, 184103, 184158, 184316, 184317, 184395, 184444, 184522, 184584, 184589, 184627, 184630, 184631, 184632, 184633, 184634, 184635, 184636, 184637, 184638, 184639, 184640, 184641, 184642, 184643, 184644, 184645, 184646, 184647, 184648, 184810, 184811, 184812, 184843, 184866, 184868, 184869, 185765, 185832, 185833, 185834, 185906, 185940, 185972, 185990, 185991, 185992, 185993, 186160, 186161, 186196, 186529, 186530, 186531, 186533, 186650, 186680, 186688, 186690, 186691, 186692, 186693, 186694, 186705, 186706, 186707, 186708, 186970, 186971, 187028, 187029, 187182, 187187, 187221, 187222, 187254, 187278, 187346, 187351, 187354, 187440, 187494, 187502, 187503, 187520, 187543, 187551, 187561, 187569, 187570, 187571, 187572, 187573, 187574, 187575, 187576, 187577, 187596, 187597, 187598, 187599, 187600, 187601, 187604, 187605, 187659, 187710, 187780, 187781, 187787, 187817, 188162, 188173, 188265, 188787, 188796, 189428, 189452, 189765, 190178, 190233, 190382, 190610, 190654, 190655, 190656, 190741, 190823, 190954, 191002, 191003, 191004, 191005, 191006, 191007, 191008, 191009, 191010, 191011, 191012, 191013, 191014, 191015, 191016, 191017, 191018, 191019, 191020, 191021, 191030, 191040, 191041, 191139, 191203, 191296, 191301, 191302, 191303, 191701, 192093, 192094, 192437, 192438, 192888, 192889, 192890, 192891, 192892, 192893, 193376, 194037, 194072, 194334, 194419, 194750, 196586, 196587, 196588, 196589, 196590, 196591, 196592, 196593, 196594, 196595, 196596, 196597, 196598, 196599, 196600, 196601, 196602, 196603, 196604, 196605, 198166, 198167, 198168, 198169, 198170, 198171, 198172, 198395, 198438, 198439, 198657, 198863, 198864, 198865, 198866, 198867, 198868, 198869, 199108, 199192, 199341, 199342, 199472, 199473, 199474, 199475, 200069, 200070, 200072, 200073, 200094, 200095, 200156, 200300, 200468, 200477, 200513, 200515, 200516, 200609, 200610, 200611, 200931, 200932, 200934, 200936, 201250, 201251, 201252, 201296, 201297, 201298, 201299, 201326, 201343, 201352, 201353, 201354, 201362, 201439, 201462, 201728, 201754, 201755, 201756, 201757, 201817, 201818, 202048, 202049, 202050, 202051, 202052, 202054, 202055, 202056, 202057, 202058, 202079, 202080, 202097, 202098, 202099, 202100, 202101, 202102, 202122, 202142, 202172, 202183, 202371, 203210, 203217, 203218, 203220, 203221, 203222, 203223, 203224, 203476, 203611, 203612, 203613, 203614, 203615, 203616, 203617, 203618, 203619, 203620, 203622, 203623, 203626, 203627, 203628, 203629, 203630, 203631, 203632, 203633, 203634, 203635, 203636, 203637, 203638, 203639, 203640, 203641, 203642, 203643, 203644, 203645, 203646, 203647, 203648, 203649, 203650, 203681, 203699, 203700, 203724, 203730, 203742, 203743, 203774, 203912, 203959, 204307, 204346, 204359, 204378, 204379, 204380, 204381, 204383, 204403, 204636, 204712, 204721, 204722, 204723, 204724, 204725, 204726, 204911, 205226, 205247, 205248, 205288, 205346, 205347, 205367, 205368, 205369, 205370, 205371, 205372, 205373, 205374, 205877, 205964, 205965, 205966, 205967, 205968, 205983, 206028, 206039, 206135, 206136, 206270, 206271, 207050, 207051, 207052, 207053, 207063, 207064, 207065, 207066, 207067, 207068, 207069, 207070, 207071, 207072, 207073, 207074, 207075, 207076, 207077, 207078, 207079, 207080, 207081, 207082, 207093, 207094, 207096, 207582, 207583, 207584, 207594, 208006, 208015, 208028, 208054, 208090, 208091, 208094, 208095, 208142, 208211, 208691, 208878, 208890, 208891, 208892, 208893, 208894, 208895, 208896, 208897, 208898, 208899, 208900, 208901, 208902, 208903, 208904, 208905, 208906, 208907, 208908, 208909, 208910, 208911, 208912, 208913, 208914, 208915, 208916, 208917, 208918, 208919, 208920, 208921, 208922, 208923, 208924, 208925, 208926, 209024, 209026, 209036, 209037, 209831, 209832, 209833, 209834, 209835, 209871, 210062, 210063, 210180, 210217, 210218, 210219, 210224, 210225, 210226, 210549, 210595, 210657, 210726, 210758, 210759, 210760, 210872, 210991, 210992, 211279, 211303, 211373, 211388, 211389, 211394, 211410, 211411, 211413, 211414, 211429, 211430, 212157, 212458, 212924, 212979, 213175, 213176, 213177, 213185, 213186, 213187, 213188, 213189, 213190, 213428, 213429, 213541, 213779, 213780, 213781, 213782, 213783, 213784, 213785, 213786, 213787, 213788, 213789, 213790, 213791, 213792, 213793, 215160, 215359, 215362, 215363, 215364, 216638, 216874, 217011, 217012, 217013, 217109, 217110, 217111, 217241, 217382, 217411, 217412, 217705, 217728, 217729, 218130, 218309, 218311, 218738, 219218, 219219, 220376, 221269, 221502, 221503, 221509, 222977, 223908, 223909, 223910, 223911, 223953, 224027, 224028, 224029, 224030, 224031, 224032, 224033, 224034, 224035, 224037, 224039, 224040, 224100, 224120, 224156, 224296, 224547, 224556, 224557, 224573, 224586, 224587, 224588, 224650, 224721, 224722, 224723, 224724, 224725, 224726, 224784, 224913, 224941, 225239, 225245, 225246, 225247, 225571, 225572, 225573, 225739, 225881, 225896, 225948, 226045, 226100, 226103, 226146, 226147, 226148, 226149, 226150, 226151, 226152, 226153, 226154, 226193, 226194, 226195, 226196, 226198, 226199, 226256, 226263, 226264, 226273, 226813, 226814, 227450, 227675, 227676, 227681, 227682, 227713, 227792, 228220, 228337, 228361, 228610, 228611, 228612, 228741, 228916, 228917, 228918, 228919, 228920, 228931, 228932, 228933, 228959, 229005, 229006, 229129, 229130, 229354, 232602",

	["Muffin.Misc.Quest"] = "5845, 6650, 12886, 16652, 16654, 17763, 17764, 18149, 33346, 33780, 42922, 44185, 49365, 55049, 60680, 93228, 118179, 118283, 118286, 118288, 129058, 134001, 142353, 142355, 151880, 152846, 152893, 156513, 157022, 158465, 158908, 159752, 160440, 167547, 178567, 182617, 182625, 182626, 182627, 182628, 182629, 182630, 182631, 182632, 182633, 182634, 182636, 182637, 182638, 182640, 183210, 183211, 183212, 183213, 183214, 183215, 183217, 183218, 183219, 183220, 183221, 183222, 183223, 183224, 183225, 183226, 183227, 183228, 183229, 183230, 183231, 183232, 183234, 183235, 183236, 183237, 183238, 183239, 183240, 183241, 183242, 183243, 183244, 183245, 183246, 183247, 183248, 183249, 183250, 183251, 183253, 183254, 183255, 183256, 183258, 183259, 183260, 183261, 183262, 183263, 183264, 183265, 183266, 183267, 183268, 183269, 183270, 183271, 183272, 183273, 183274, 183275, 183277, 183278, 183279, 183280, 183281, 183282, 183283, 183284, 183285, 183286, 183287, 183288, 183289, 183290, 183291, 183292, 183293, 183294, 183295, 183296, 183297, 183298, 183299, 183300, 183301, 183303, 183304, 183305, 183306, 183307, 183308, 183309, 183310, 183311, 183312, 183313, 183314, 183315, 183316, 183317, 183318, 183319, 183320, 183322, 183323, 183324, 183325, 183326, 183327, 183328, 183329, 183330, 183332, 183333, 183334, 183335, 183336, 183337, 183338, 183339, 183340, 183341, 183342, 183343, 183344, 183345, 183346, 183347, 183348, 183349, 183350, 183351, 183352, 183353, 183355, 183356, 183357, 183359, 183360, 183361, 183362, 183363, 183364, 183365, 183366, 183367, 183369, 183370, 183371, 183372, 183373, 183374, 183375, 183376, 183377, 183378, 183379, 183380, 183381, 183382, 183383, 183384, 183385, 183386, 183387, 183388, 183389, 183390, 183391, 183393, 186565, 186568, 186570, 186572, 186576, 186577, 186591, 186609, 186621, 186635, 186673, 186676, 186687, 186689, 186710, 186712, 186775, 187105, 187106, 187109, 187111, 187118, 187127, 187132, 187160, 187161, 187162, 187163, 187217, 187224, 187225, 187226, 187227, 187229, 187230, 187231, 187232, 187237, 187258, 187259, 187277, 187280, 187511, 190587, 190589, 190591, 190594, 191634, 191635, 191636, 191638, 191639, 191640, 191642, 191643, 191644, 191645, 194743, 199552, 199553",

	["Muffin.Misc.StartsQuest"] = "1307, 1357, 1972, 3082, 4854, 5179, 8244, 8623, 8704, 8705, 9326, 10593, 12842, 16303, 16304, 16305, 16408, 18628, 18706, 19002, 19003, 19016, 19018, 19228, 19257, 19267, 19277, 19423, 19443, 19452, 20461, 20483, 20644, 20741, 20765, 21220, 21221, 21230, 21776, 22597, 22727, 23179, 23180, 23181, 23182, 23183, 23184, 23228, 23249, 23338, 23580, 23678, 23759, 23777, 23797, 23837, 23850, 23870, 23900, 23910, 24132, 24330, 24407, 24414, 24483, 24484, 24504, 24558, 24559, 25459, 28552, 29233, 29234, 29235, 29236, 29476, 29588, 29590, 29738, 30431, 30579, 30756, 31120, 31345, 31363, 31384, 31489, 31707, 31890, 31891, 31907, 31914, 32385, 32386, 32405, 32523, 32621, 32726, 33102, 33289, 33314, 33345, 33347, 33961, 33962, 34091, 34469, 34777, 34815, 34984, 35568, 35569, 35648, 35723, 36742, 36744, 36746, 36756, 36780, 36855, 36856, 36940, 36958, 37163, 37164, 37432, 37599, 37736, 37737, 37830, 37833, 38280, 38281, 38321, 38567, 38660, 38673, 40666, 41267, 41556, 42203, 42772, 43242, 43297, 44148, 44158, 44259, 44276, 44294, 44326, 44569, 44577, 44725, 44927, 44979, 45039, 45506, 45857, 46004, 46052, 46053, 46128, 46318, 46875, 46876, 46877, 46878, 46879, 46881, 46883, 46884, 46955, 47039, 48679, 49200, 49643, 49644, 49676, 49932, 50379, 50380, 51315, 52079, 52197, 53053, 54345, 54614, 54639, 55166, 55167, 55181, 55186, 55243, 56571, 56812, 57102, 57118, 57935, 58117, 58491, 58898, 59143, 60816, 60886, 60956, 61310, 61322, 61378, 61505, 62021, 62044, 62045, 62046, 62056, 62138, 62281, 62282, 62483, 62768, 62933, 63090, 63250, 63276, 63686, 63700, 64450, 65894, 65895, 65896, 65897, 69854, 70928, 70932, 71635, 71636, 71637, 71638, 71715, 71716, 71951, 71952, 71953, 74034, 77957, 79238, 79323, 79324, 79325, 79326, 80240, 80241, 80827, 82808, 82870, 83076, 83767, 83770, 83772, 83773, 83774, 83777, 83779, 83780, 84895, 84897, 84898, 84899, 85477, 85557, 85558, 85783, 86404, 86433, 86434, 86435, 86436, 86542, 86544, 86545, 87878, 88538, 88563, 88715, 89169, 89170, 89171, 89172, 89173, 89174, 89175, 89176, 89178, 89179, 89180, 89181, 89182, 89183, 89184, 89185, 89209, 89317, 89812, 89813, 89814, 91819, 91821, 91822, 91854, 91855, 91856, 92441, 94197, 94199, 94721, 95383, 95384, 95385, 95386, 95387, 95388, 95389, 95390, 102225, 105891, 108824, 108951, 109012, 109095, 109121, 111073, 111478, 112378, 112566, 112692, 113080, 113103, 113107, 113109, 113260, 113444, 113445, 113446, 113447, 113448, 113449, 113453, 113454, 113456, 113457, 113458, 113459, 113460, 113461, 113586, 113590, 114018, 114019, 114020, 114021, 114022, 114023, 114024, 114025, 114026, 114027, 114029, 114030, 114031, 114032, 114033, 114034, 114035, 114036, 114037, 114038, 114142, 114144, 114146, 114148, 114150, 114152, 114154, 114156, 114158, 114160, 114162, 114164, 114166, 114168, 114170, 114172, 114174, 114176, 114178, 114182, 114184, 114186, 114188, 114208, 114209, 114210, 114211, 114212, 114213, 114215, 114216, 114217, 114218, 114219, 114220, 114221, 114222, 114223, 114224, 114877, 114965, 114972, 114973, 114984, 115008, 115278, 115281, 115287, 115343, 115467, 115507, 115593, 115600, 116068, 116159, 116160, 116173, 116438, 119208, 119310, 119316, 119317, 119323, 120206, 120207, 120208, 120209, 120210, 120211, 120277, 120278, 120279, 120280, 120281, 120282, 120283, 120284, 120285, 122190, 122399, 122400, 122401, 122402, 122403, 122404, 122405, 122408, 122409, 122410, 122411, 122412, 122413, 122414, 122415, 122416, 122417, 122418, 122419, 122420, 122421, 122422, 122424, 122610, 122699, 123852, 123880, 124037, 124131, 124489, 124490, 124491, 124492, 124493, 124494, 124496, 124497, 124498, 124499, 124500, 124501, 124502, 126930, 126950, 127003, 127122, 127682, 127690, 127691, 127692, 127860, 127872, 127878, 127916, 127989, 127992, 128207, 128231, 128232, 128250, 128251, 128252, 128255, 128256, 128257, 128258, 128260, 128324, 128340, 128489, 128491, 128512, 128629, 128707, 128747, 128748, 128749, 128966, 128967, 128968, 128969, 128970, 128971, 128972, 128973, 128975, 129117, 129118, 129119, 129120, 129121, 129122, 129135, 129136, 129137, 129138, 129140, 129141, 129142, 129143, 129177, 129182, 129278, 129747, 129756, 129860, 129862, 129863, 129864, 129865, 129866, 129867, 129928, 129966, 130017, 130076, 130326, 130893, 130921, 130922, 130923, 130924, 130925, 130926, 130927, 130928, 130929, 130930, 130932, 130933, 130934, 130935, 132885, 132956, 132957, 132958, 133328, 133377, 133378, 133762, 133876, 133878, 133883, 133884, 133887, 133968, 134859, 135479, 136851, 136909, 136912, 136915, 136916, 136917, 136918, 138441, 138830, 138849, 138992, 138996, 139046, 139409, 139410, 139457, 139471, 139472, 139473, 139474, 139475, 139476, 139477, 139478, 139479, 139480, 139481, 139482, 139483, 139619, 139912, 140008, 140147, 140149, 140151, 140153, 140163, 140164, 140165, 140166, 140167, 140169, 140170, 140171, 140172, 140173, 140174, 140175, 140177, 140178, 140181, 140182, 140183, 140249, 140472, 140495, 140534, 140764, 140774, 140778, 141185, 141186, 141187, 141188, 141189, 141190, 141191, 141192, 141193, 141194, 141195, 141197, 141198, 141199, 141200, 141201, 141202, 141204, 141349, 142210, 142246, 142338, 142339, 142340, 142344, 142376, 142377, 142378, 142382, 142384, 142392, 142394, 142395, 142396, 142397, 142522, 142553, 142554, 142559, 143328, 143329, 143478, 143556, 143561, 143590, 143776, 143872, 143873, 143874, 143875, 143876, 143877, 143878, 143879, 143880, 143881, 143882, 143883, 143884, 143885, 143886, 143887, 143900, 146407, 146728, 146729, 146730, 146731, 147356, 147497, 147498, 147499, 147500, 147501, 147502, 147503, 147504, 147505, 147506, 147507, 147508, 147509, 147510, 147511, 147512, 147880, 147881, 150938, 150940, 150941, 150943, 150944, 150945, 150946, 151342, 151856, 151857, 151860, 151861, 151862, 151863, 151864, 151865, 151866, 151867, 151868, 152204, 152313, 152314, 152315, 152316, 152317, 152318, 152319, 152320, 152321, 152322, 152323, 152324, 152325, 152326, 152327, 152328, 152575, 152587, 152655, 152666, 152900, 152965, 153359, 153516, 154880, 154890, 154895, 154926, 154927, 154928, 154929, 154930, 154931, 154932, 154933, 154934, 154935, 156517, 156529, 156736, 156939, 157544, 157782, 157832, 157849, 157860, 158195, 158213, 158909, 158918, 158932, 159748, 159877, 159956, 160027, 160035, 160064, 160117, 160250, 160301, 160550, 160603, 160742, 160744, 160944, 160986, 161078, 161079, 161085, 161088, 161424, 161431, 162687, 163466, 163470, 163471, 163472, 163473, 163474, 163475, 163476, 163477, 163478, 163479, 163480, 163481, 163482, 163483, 163484, 163485, 163486, 163487, 163488, 163856, 164987, 165605, 165668, 166507, 167042, 167069, 167090, 167652, 167654, 167655, 167656, 167657, 167658, 167659, 167660, 167661, 167662, 167663, 167786, 167787, 167790, 167792, 167793, 167794, 167795, 167796, 167836, 167843, 167844, 167845, 167846, 167847, 167871, 167921, 167922, 168001, 168047, 168062, 168063, 168081, 168155, 168219, 168220, 168221, 168248, 168255, 168256, 168258, 168490, 168491, 168492, 168493, 168494, 168495, 168834, 168835, 168906, 168908, 168919, 168939, 168954, 169112, 169134, 169167, 169168, 169169, 169170, 169171, 169172, 169173, 169174, 169175, 169176, 169177, 169178, 169179, 169180, 169181, 169182, 169183, 169184, 169185, 169186, 169187, 169188, 169189, 169215, 169216, 169346, 169591, 169593, 169594, 169595, 169596, 169597, 169598, 169615, 169616, 169617, 169618, 169619, 169620, 169621, 169622, 169623, 169624, 169625, 169626, 169627, 169628, 169629, 169630, 169631, 169632, 169633, 169634, 169635, 169636, 169637, 169638, 169639, 169640, 169641, 169642, 169643, 169644, 169645, 169646, 169654, 169655, 169656, 169657, 169658, 169659, 169682, 169688, 169689, 169690, 169691, 169692, 169764, 169765, 169767, 169772, 169775, 169779, 169864, 169888, 170146, 170147, 170148, 170512, 171177, 171320, 172383, 173533, 173694, 173705, 173707, 173709, 173710, 173711, 173712, 173715, 173717, 173718, 173719, 173720, 173721, 173735, 174070, 174076, 174079, 174080, 174081, 174082, 174083, 174212, 174643, 174674, 174863, 174867, 175769, 175982, 178044, 178557, 178585, 179358, 179363, 180453, 180472, 180482, 180494, 180495, 180712, 180719, 180799, 180801, 180802, 180803, 180804, 180805, 180806, 180807, 180808, 181139, 181155, 181165, 181238, 181313, 181314, 181499, 181765, 182095, 182162, 182165, 182166, 182167, 182168, 182169, 182170, 182171, 182172, 182173, 182174, 182175, 182176, 182177, 182178, 182179, 182180, 182181, 182182, 182183, 182184, 182185, 182618, 182693, 182726, 182727, 182728, 182731, 182738, 182759, 182975, 183054, 183057, 183058, 183059, 183060, 183061, 183063, 183066, 183067, 183068, 183069, 183070, 183091, 183129, 183761, 183844, 183845, 183846, 183848, 183877, 183878, 183879, 183880, 183881, 184155, 184349, 184407, 184411, 184414, 184445, 184450, 184475, 184477, 184481, 184577, 184578, 184580, 184894, 185047, 185048, 185049, 185050, 185051, 185052, 185053, 185054, 185475, 185484, 185740, 185756, 185914, 185915, 186014, 186573, 187047, 187052, 187055, 187103, 187104, 187119, 187150, 187177, 187200, 187201, 187202, 187203, 187204, 187205, 187206, 187207, 187208, 187209, 187210, 187264, 187276, 187281, 187282, 187283, 187423, 187424, 187426, 187428, 187527, 187611, 187620, 187788, 187792, 187813, 187818, 187819, 187822, 187858, 187859, 187862, 187870, 187871, 187873, 187876, 187877, 187878, 187880, 187881, 187882, 187901, 187902, 187903, 187904, 187905, 187906, 189361, 189418, 189434, 189435, 189436, 189437, 189440, 189441, 189442, 189443, 189444, 189445, 189446, 189447, 189448, 189455, 189456, 189457, 189458, 189459, 189460, 189461, 189462, 189463, 189464, 189465, 189466, 189467, 189468, 189469, 189470, 189471, 189472, 189473, 189474, 189475, 189476, 189477, 189478, 189705, 189971, 189972, 189973, 189975, 189976, 189977, 189980, 189982, 189983, 189986, 189987, 189988, 189989, 189990, 189991, 190337, 190579, 190585, 190773, 191023, 191108, 191127, 191633, 191859, 191904, 192444, 193600, 193611, 193874, 194031, 198071, 198072, 198080, 198352, 198475, 198538, 198540, 198543, 198626, 198661, 199691, 199748, 199749, 199750, 199790, 199831, 199840, 199841, 199842, 199843, 199893, 199895, 199915, 200528, 200586, 200675, 200876, 201412, 201470, 201471, 202081, 202105, 202203, 202204, 202326, 202327, 202328, 202329, 202335, 202336, 202337, 203469, 203598, 203651, 203686, 203687, 203737, 204071, 204200, 204221, 204223, 204246, 204250, 204251, 204252, 204253, 204254, 204255, 204642, 204683, 204731, 205187, 205190, 205366, 205410, 205795, 205900, 205901, 205906, 205907, 205909, 205910, 205911, 205913, 206145, 206163, 206373, 206449, 206564, 206578, 206599, 206602, 206638, 206681, 206775, 206859, 206942, 206957, 206962, 206984, 206998, 207003, 207008, 207729, 207827, 208135, 208146, 208226, 208227, 208571, 208733, 208734, 208737, 208775, 208781, 208826, 208827, 208839, 208840, 208887, 208889, 208936, 208944, 209348, 209350, 210050, 210430, 210526, 210594, 211375, 211690, 211861, 211927, 212154, 212155, 212178, 212330, 212331, 212333, 212339, 212595, 213425, 213557, 214504, 216689, 217352, 217385, 217388, 217390, 218084, 219384, 224457, 224460, 224462, 224463, 224465, 224466, 224486, 224545, 224548, 225336, 225339, 225772, 225952, 226683, 227794, 228228, 228560, 228581, 228623, 228958, 231019",

	["Muffin.Misc.Reputation"] = "43950, 44710, 44711, 44713, 45714, 45715, 45716, 45717, 45718, 45719, 45720, 45721, 45722, 45723, 49702, 63359, 63517, 64398, 64399, 64400, 64401, 64402, 70145, 70146, 70147, 70148, 70149, 70150, 70151, 70152, 70153, 70154, 71087, 71088, 86592, 90815, 90816, 94223, 94225, 94226, 94227, 95487, 95488, 95489, 95490, 95496, 117492, 120148, 120149, 128315, 129940, 129941, 129942, 129943, 129944, 129945, 129946, 129947, 129948, 129949, 129950, 129951, 129954, 129955, 133150, 133151, 133152, 133154, 133159, 133160, 139020, 139021, 139023, 139024, 139025, 139026, 140260, 141338, 141339, 141340, 141341, 141342, 141343, 141870, 141987, 141988, 141989, 141990, 141991, 141992, 142363, 143935, 143936, 143937, 143938, 143939, 143940, 143941, 143942, 143943, 143944, 143945, 143946, 143947, 146330, 146935, 146936, 146937, 146938, 146939, 146940, 146941, 146942, 146943, 146944, 146945, 146946, 146949, 146950, 147410, 147411, 147412, 147413, 147414, 147415, 147416, 147418, 147727, 150925, 150926, 150927, 150928, 150929, 150930, 152464, 152954, 152955, 152956, 152957, 152958, 152959, 152960, 152961, 153113, 153114, 167924, 167925, 167926, 167927, 167928, 167929, 167930, 167932, 168017, 168018, 168497, 169941, 169942, 170079, 170081, 173374, 173375, 173376, 173377, 173736, 173947, 173948, 174501, 174502, 174503, 174504, 174505, 174506, 174507, 174508, 174518, 174519, 174521, 174522, 174523, 178147, 181443, 184119, 184120, 184121, 184122, 184124, 187610, 190339, 190941, 191299, 198790, 200285, 200287, 200288, 200289, 200452, 200453, 200454, 200455, 201779, 201781, 201782, 201783, 201921, 201922, 201923, 201924, 202091, 202092, 202093, 202094, 205249, 205250, 205251, 205252, 205253, 205254, 205342, 205365, 205985, 205989, 205991, 205992, 205998, 206006, 208132, 208133, 208134, 208617, 210419, 210420, 210421, 210422, 210423, 210730, 210757, 210847, 210916, 210920, 210921, 210950, 210951, 210952, 210954, 210957, 210958, 210959, 210997, 211131, 211353, 211366, 211369, 211370, 211371, 211372, 211416, 211417",

	["Muffin.Misc.Repair"] = "18232, 34113, 40769, 132514, 152839, 180710, 183126, 191260, 191261, 191884, 191885, 201366, 206645, 206646, 206647, 206648, 222520, 225660",

})
