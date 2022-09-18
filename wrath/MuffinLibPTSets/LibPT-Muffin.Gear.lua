--
-- LibPT-Muffin.Gear
--
if not LibStub("LibPeriodicTable-3.1", true) then error("PT3 must be loaded before data") end
LibStub("LibPeriodicTable-3.1"):AddData("Muffin.Gear", "Rev: 35",
{
	["Muffin.Gear.Trinket.Usable"] = "744,833,1258,1404,1713,2802,2820,3456,4381,4396,4397,5079,7506,7734,8688,8703,10418,10455,10576,10577,10587,10645,10716,10720,10725,10727,11819,11832,11905,13164,13171,13213,13515,14022,14023,15867,15873,16022,17690,17691,17744,17759,17900,17901,17902,17903,17904,17905,17906,17907,17908,17909,18438,18634,18637,18638,18639,18820,18834,18845,18846,18849,18850,18851,18852,18853,18854,18856,18857,18858,18859,18862,18863,18864,18951,19024,19141,19336,19337,19339,19340,19341,19342,19343,19344,19345,19930,19947,19948,19949,19950,19951,19952,19953,19954,19955,19956,19957,19958,19959,19979,19990,19991,19992,20036,20071,20072,20084,20130,20503,20512,20525,20534,20636,21115,21116,21117,21118,21119,21120,21180,21181,21326,21473,21488,21579,21625,21647,21670,21685,21748,21756,21758,21760,21763,21769,21777,21784,21789,21891,22268,22678,22954,23001,23027,23040,23041,23042,23046,23047,23558,23570,23714,23716,23835,23836,24124,24125,24126,24127,24128,24376,24390,24420,24551,25619,25620,25628,25633,25634,25786,25787,25798,25829,25936,25937,25994,25995,25996,26055,27416,27529,27770,27828,27891,27900,28040,28041,28042,28121,28223,28234,28235,28236,28237,28238,28239,28240,28241,28242,28243,28288,28370,28528,28590,28727,28798,29132,29179,29181,29370,29376,29383,29387,29592,29593,29776,30293,30300,30340,30343,30344,30345,30346,30348,30349,30350,30351,30620,30629,30665,30696,30841,31615,31617,32483,32501,32534,32654,32658,32694,32695,32864,33828,33829,33830,33831,33832,34029,34049,34050,34162,34163,34428,34429,34430,34471,34576,34577,34578,34579,34580,34626,35326,35327,35693,35694,35700,35702,35703,35935,35937,36871,36872,36874,36972,36993,37127,37128,37166,37555,37556,37557,37558,37560,37561,37562,37563,37578,37638,37723,37734,37844,37864,37865,37872,37873,38070,38073,38074,38075,38076,38077,38078,38079,38080,38081,38213,38257,38258,38259,38287,38288,38289,38290,38526,38588,38589,38760,38761,38762,38763,38764,38765,39214,39257,39292,39388,39811,39819,39821,40257,40354,40372,40476,40477,40483,40492,40531,40532,40593,40601,40683,41121,41587,41588,41589,41590,42122,42123,42124,42126,42128,42129,42130,42131,42132,42133,42134,42135,42136,42137,42341,42395,42413,42418,42988,43836,43837,44013,44014,44015,44063,44097,44098,44579,44597,45148,45158,45263,45292,45313,45466,45631,46021,46051,46081,46082,46083,46084,46085,46086,46087,46088,46312,47080,47088,47290,47451,47725,47726,47727,47728,47734,47735,47879,47880,47881,47882,47946,47947,47948,47949,48018,48019,48020,48021,48722,48724,49080,49116,49118,50235,50259,50260,50339,50346,50354,50356,50357,50361,50364,50726,51377,51378",
	["Muffin.Gear.Trinket.Nonusable"] = "1490,2919,2920,2921,2922,2923,3002,3003,3004,3005,3006,3788,3789,3790,3791,4030,4031,4032,4033,4130,8663,9149,10585,10659,10723,10779,11122,11302,11810,11811,11815,12065,12805,12846,12930,13209,13382,13503,13544,13965,13966,13968,14557,17064,17082,17774,18354,18355,18370,18371,18406,18465,18466,18467,18468,18469,18470,18471,18472,18473,18537,18646,18665,18706,18815,19120,19287,19288,19289,19290,19379,19395,19406,19431,19812,21565,21566,21567,21568,22321,23206,23207,25653,25801,27683,27896,27920,27921,27922,27924,27926,27927,28034,28108,28109,28190,28418,28579,28785,28789,28823,28830,30446,30447,30448,30449,30450,30619,30621,30626,30627,30663,30664,30720,31080,31113,31856,31857,31858,31859,32481,32485,32486,32487,32488,32489,32490,32491,32492,32493,32496,32505,32770,32771,32863,33003,33046,34423,34424,34427,34470,34472,34473,35485,35748,35749,35750,35751,37064,37111,37220,37264,37390,37559,37657,37660,37835,38071,38072,38212,38331,38358,38359,38383,38385,38479,38572,38674,38675,39229,39889,40255,40256,40258,40371,40373,40382,40430,40431,40432,40682,40684,40685,40754,40767,40865,42987,42989,42990,42991,42992,43555,43573,43829,43838,44073,44074,44253,44254,44255,44322,44323,44324,44869,44870,44912,44914,45131,45219,45286,45308,45490,45507,45518,45522,45535,45609,45703,45866,45929,45931,46038,47041,47059,47115,47131,47182,47188,47213,47214,47215,47216,47271,47303,47316,47432,47464,47477,49074,49076,49078,49310,49312,49463,49464,49487,49488,49686,50198,50340,50341,50342,50343,50344,50345,50348,50349,50351,50352,50353,50355,50358,50359,50360,50362,50363,50365,50366,50706",
})
