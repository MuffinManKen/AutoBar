--
-- LibPT-Muffin.Gear
--
if not LibStub("LibPeriodicTable-3.1", true) then error("PT3 must be loaded before data") end
LibStub("LibPeriodicTable-3.1"):AddData("Muffin.Gear", "Rev: 1", {
	["Muffin.Gear.Trinket.Usable"] = "744,833,1404,1713,2802,2820,3456,4381,4396,4397,5079,7506,7734,8703,10418,10455,10576,10577,10587,10645,10716,10720,10725,10727,11819,11832,11905,13164,13171,13213,13379,13382,13515,14022,14023,15867,15873,16022,17690,17691,17744,17759,17900,17901,17902,17903,17904,17905,17906,17907,17908,17909,18438,18634,18637,18638,18639,18820,18834,18845,18846,18849,18850,18851,18852,18853,18854,18856,18857,18858,18859,18862,18863,18864,18951,19024,19141,19336,19337,19339,19340,19341,19342,19343,19344,19345,19930,19947,19948,19949,19950,19951,19952,19953,19954,19955,19956,19957,19958,19959,19979,19990,19991,19992,20036,20071,20072,20084,20130,20503,20512,20525,20534,20636,21115,21116,21117,21118,21119,21120,21180,21181,21326,21473,21488,21579,21625,21647,21670,21685,21748,21756,21758,21760,21763,21769,21777,21784,21789,21891,22268,22678,22954,23001,23027,23040,23041,23042,23046,23047,23558,23570,23714,23835,23836,24124,24125,24126,24127,24128,24376,24390,24551,25619,25620,25628,25633,25634,25786,25787,25829,25936,25937,25994,25995,25996,26055,27416,27529,27770,27828,27891,27900,28040,28041,28042,28121,28223,28234,28235,28236,28237,28238,28239,28240,28241,28242,28243,28288,28370,28528,28590,28727,28798,29132,29179,29181,29370,29376,29383,29387,29592,29593,29776,30293,30300,30340,30343,30344,30345,30346,30348,30349,30350,30351,30620,30629,30665,30696,30841,31615,31617,32483,32501,32534,32654,32658,32694,32695,32864,33828,33829,33830,33831,33832,34029,34049,34050,34162,34163,34428,34429,34430,34471,34576,34577,34578,34579,34580,34626,35326,35327,35693,35694,35700,35702,35703,35935,35937,36871,36872,36874,36972,36993,37127,37128,37166,37555,37556,37557,37558,37560,37561,37562,37563,37578,37638,37723,37734,37844,37864,37865,37872,37873,38070,38073,38080,38081,38213,38257,38258,38259,38287,38288,38289,38290,38526,38588,38589,38760,38761,38762,38763,38764,38765,39257,39292,39388,39811,39819,39821,40257,40354,40372,40476,40477,40483,40492,40531,40532,40593,40601,40683,41121,41587,41588,41589,41590,42122,42123,42124,42126,42128,42129,42130,42131,42132,42133,42134,42135,42136,42137,42341,42395,42413,42418,42988,43836,43837,44013,44014,44015,44063,44097,44098,44579,44597,45148,45158,45263,45292,45313,45466,45631,46021,46051,46081,46082,46083,46084,46085,46086,46087,46088,46312,47080,47088,47290,47451,47725,47726,47727,47728,47734,47735,47879,47880,47881,47882,47946,47947,47948,47949,48018,48019,48020,48021,48722,48724,49080,49116,49118,50235,50259,50260,50339,50346,50354,50356,50357,50361,50364,50726,51377,51378,52199,52351,52352,52353,52354,53597,54573,54589,55251,55256,55814,55845,55881,56115,56132,56136,56285,56290,56345,56370,56406,56440,56458,56463,56847,56849,57316,57346,58183,58184,59354,59461,59514,59515,59617,59685,59689,59707,59710,60233,60403,60794,60799,60800,60801,60806,60807,61026,61031,61032,61033,61034,61035,61429,61433,61448,62048,62463,62464,62466,62468,62469,62471,62966,62978,62984,62995,63192,63194,63241,63245,63632,63633,63742,63745,63840,63842,63843,64597,64627,64645,64687,64688,64689,64740,64741,64742,64789,64790,64791,64792,64793,64794,65029,65109,65110,65175,65176,65286,65357,65923,65931,66879,66994,67037,67101,67118,67152,68709,68712,68713,68915,68926,68972,68996,68998,69000,69001,69002,69109,69111,69113,69184,69185,69198,69199,69200,69762,69861,69862,70141,70142,70143,70144,70390,70391,70392,70393,70394,70395,70396,70397,70398,70399,70400,70401,70517,70518,70519,70563,70564,70565,70602,70603,70604,70605,70606,70607,71333,71334,71338,72304,72359,72360,72361,72410,72411,72412,72413,72414,72415,72448,72450,72898,72899,72901,73496,73498,73534,73535,73536,73537,73538,73539,73591,73592,73593,73648,77113,77114,77115,77116,77117,77984,77985,77986,77987,77988,78004,78005,78006,78007,78008,79329,81181,81263,81264,81265,81268,82984,84344,84399,84400,84401,84450,84451,84452,84453,84454,84455,84488,84490,84931,84932,84933,84934,84936,84938,84939,84940,84942,84943,84944,84945,86042,86043,86044,86045,86046,86567,86570,86572,86576,86579,86587,86771,86772,86773,86774,86775,87079,87080,87081,87082,87083,87495,87496,87498,87499,87500,87571,87575,87576,87780,88294,88358,88368,88369,88371,88376,88378,88577,88583,88590,88995,89079,89080,89081,89082,89083,89232,89611,91099,91209,91210,91211,91400,91410,91452,91562,91563,91564,91682,91683,91684,91685,91686,91687,91753,91763,92782,92783,92784,92785,92786,92787,93253,93254,93255,93256,93257,93258,93259,93260,93261,93262,93341,93342,93343,93344,93345,93346,93347,93348,93349,93350,93419,93485,93486,93487,93560,93561,93562,93563,93564,93565,93600,93606,93898,93899,93900,94329,94338,94346,94349,94361,94373,94386,94387,94388,94396,94422,94454,94507,94509,94516,94525,94528,95677,95763,95811,96049,96135,96183,96421,96507,96555,96793,96879,96927,98755,98811,98812,98813,98875,98876,98877,98878,98879,98880,98910,98912,99772,99838,99839,99840,99937,99943,99990,100006,100016,100019,100031,100043,100056,100057,100058,100066,100092,100124,100195,100305,100306,100307,100490,100500,100559,100568,100576,100579,100591,100603,100616,100617,100618,100626,100652,100684,100951,100963,102296,102307,102314,102316,102483,102616,102625,102633,102636,102659,102672,102680,102706,102738,102813,102822,102830,102833,102856,102869,102877,102903,102935,103145,103210,103211,103212,103308,103314,103333,103334,103335,103342,103407,103408,103409,103505,103511,103530,103531,103532,103639,103678,103688,103690,103988,103990,104298,104321,104442,104649,104691,104898,104940,105147,105189,105396,105438,105645,108902,108903,111222,111224,111225,111226,111227,111229,111230,111231,111232,114366,114367,114368,114369,114370,114488,114489,114490,114491,114492,115495,115496,115521,115749,115751,115752,115753,115754,115756,115757,115758,115759,116154,117357,117361,117391,117402,117403,117438,117729,117731,117732,117733,117734,117736,117737,117738,117739,117773,117774,117930,117932,117933,117934,117935,117937,117938,117939,117940,118199,118876,118878,118880,118882,118884,118936",
	["Muffin.Gear.Trinket.Nonusable"] = "1490,4130,8663,9149,10585,10659,10723,10779,11122,11302,11810,11811,11815,12065,12805,12846,12930,13209,13503,13544,13965,13966,13968,14557,17064,17082,17774,18354,18355,18370,18371,18406,18465,18466,18467,18468,18469,18470,18471,18472,18473,18537,18646,18665,18706,18815,19120,19287,19288,19289,19290,19379,19395,19406,19431,19812,21565,21566,21567,21568,22321,23206,23207,25653,27683,27896,27920,27921,27922,27924,27926,27927,28034,28108,28109,28190,28418,28579,28785,28789,28823,28830,30446,30447,30448,30449,30450,30619,30621,30626,30627,30663,30664,30720,31080,31113,31856,31857,31858,31859,32481,32485,32486,32487,32488,32489,32490,32491,32492,32493,32496,32505,32770,32771,32863,34423,34424,34427,34470,34472,34473,35748,35749,35750,35751,37064,37111,37220,37264,37390,37559,37657,37660,37835,38071,38072,38212,38358,38359,38383,38572,38674,38675,39229,39889,40255,40256,40258,40371,40373,40382,40430,40431,40432,40682,40684,40685,40767,40865,42987,42989,42990,42991,42992,43555,43573,43829,43838,44073,44074,44253,44254,44255,44322,44323,44324,44869,44870,44912,44914,45131,45219,45286,45308,45490,45507,45518,45522,45535,45609,45703,45866,45929,45931,46038,47041,47059,47115,47131,47182,47188,47213,47214,47215,47216,47271,47303,47316,47432,47464,47477,49074,49076,49078,49310,49463,49464,49487,49488,50198,50340,50341,50342,50343,50344,50345,50348,50349,50351,50352,50353,50355,50358,50359,50360,50362,50363,50365,50366,50706,54569,54571,54572,54588,54590,54591,55237,55266,55787,55795,55810,55816,55819,55854,55868,55874,55879,55889,55995,56100,56102,56121,56138,56280,56295,56320,56328,56339,56347,56351,56377,56393,56394,56400,56407,56414,56427,56431,56449,56462,57325,57338,58180,58181,58182,58483,59224,59326,59332,59441,59473,59500,59506,59519,59520,59630,59633,59661,59664,59792,61045,61046,61047,61411,61462,62047,62049,62050,62051,62465,62467,62470,62472,63838,63839,63841,64761,64762,64763,65026,65048,65053,65072,65105,65118,65124,65140,65803,65804,65805,66969,68710,68711,68775,68776,68777,68925,68927,68981,68982,68983,68994,68995,69110,69112,69138,69139,69149,69150,69167,69781,69782,69783,69784,69785,69786,69787,69788,69789,69790,69791,69792,70402,70403,70404,70409,70410,70411,70412,70413,70414,70577,70578,70579,71335,71336,71337,72309,72449,72455,72897,72900,73042,73060,73061,73062,73063,73064,73065,73066,73067,73068,73101,73104,73106,73109,73111,73114,73116,73119,73121,73124,73126,73129,73132,73135,73137,73140,73142,73145,73147,73150,73154,73155,73157,73160,73164,73165,73167,73170,73491,73497,73499,73500,73501,73577,73578,73579,73643,74034,74035,75274,77197,77198,77199,77200,77201,77202,77203,77204,77205,77206,77207,77208,77209,77210,77211,77530,77969,77970,77971,77972,77973,77974,77975,77976,77977,77978,77979,77980,77981,77982,77983,77989,77990,77991,77992,77993,77994,77995,77996,77997,77998,77999,78000,78001,78002,78003,79327,79328,79330,79331,80773,80774,80775,80776,80777,80778,80779,80780,80781,80782,81125,81133,81138,81192,81243,81266,81267,81532,81534,81535,81536,81661,81662,81663,81664,81665,81834,81835,81836,81837,81838,82574,82575,82576,82577,82578,82579,82580,82581,82582,82583,82696,82697,82698,82699,82700,83245,83246,83247,83248,83249,83731,83732,83733,83734,83735,83736,83737,83738,83739,83740,84071,84072,84073,84075,84076,84077,84078,84079,84349,84489,84495,84935,84937,84941,85181,86131,86132,86133,86144,86147,86323,86327,86332,86336,86388,86525,86526,86529,86585,86790,86791,86792,86802,86805,86881,86885,86890,86894,86907,87057,87063,87065,87072,87075,87160,87163,87167,87172,87175,87497,87572,87573,87574,88355,88360,88585,88634,88636,88639,88642,88644,88647,91104,91401,91415,91457,91754,91768,93424,93601,93611,93896,93897,94356,94415,94482,94508,94510,94511,94512,94513,94514,94515,94518,94519,94520,94521,94522,94523,94524,94526,94527,94529,94530,94531,94532,95625,95641,95654,95665,95669,95711,95712,95726,95727,95748,95757,95772,95779,95799,95802,95814,95817,95997,96013,96026,96037,96041,96083,96084,96098,96099,96120,96129,96144,96151,96171,96174,96186,96189,96369,96385,96398,96409,96413,96455,96456,96470,96471,96492,96501,96516,96523,96543,96546,96558,96561,96741,96757,96770,96781,96785,96827,96828,96842,96843,96864,96873,96888,96895,96915,96918,96930,96933,98760,98911,98917,99777,99938,99948,100026,100085,100152,100200,100491,100505,100586,100645,100712,100990,100991,100999,101002,101009,101012,101023,101026,101038,101041,101054,101057,101069,101072,101087,101089,101102,101107,101113,101117,101135,101138,101151,101152,101160,101163,101168,101171,101179,101183,101200,101203,101217,101220,101222,101225,101247,101250,101263,101266,101294,101295,101303,101306,102292,102293,102294,102295,102297,102298,102299,102300,102301,102302,102303,102304,102305,102306,102308,102309,102310,102311,102312,102313,102315,102643,102699,102766,102840,102896,102963,103150,103309,103319,103347,103506,103516,103686,103687,103689,103986,103987,103989,104313,104426,104463,104476,104478,104495,104518,104531,104544,104553,104572,104576,104584,104611,104613,104616,104619,104636,104652,104675,104712,104725,104727,104744,104767,104780,104793,104802,104821,104825,104833,104860,104862,104865,104868,104885,104901,104924,104961,104974,104976,104993,105016,105029,105042,105051,105070,105074,105082,105109,105111,105114,105117,105134,105150,105173,105210,105223,105225,105242,105265,105278,105291,105300,105319,105323,105331,105358,105360,105363,105366,105383,105399,105422,105459,105472,105474,105491,105514,105527,105540,105549,105568,105572,105580,105607,105609,105612,105615,105632,105648,106899,107195,108907,109262,111223,111228,111233,111293,111530,111533,111546,111547,111548,111554,111948,112884,112885,112886,112887,112888,112889,113023,113024,113025,113158,113159,113160,113161,113162,113163,113253,113254,113255,113408,113527,114303,114304,114305,114306,114307,114427,114428,114429,114430,114431,114549,114550,114551,114552,114553,114610,114611,114612,114613,114614,114886,114887,114888,114889,114890,114891,114957,114958,114959,114961,115750,115755,115760,116075,116077,116127,116799,116823,116824,117033,117034,117042,117045,117052,117055,117066,117069,117081,117084,117097,117100,117112,117115,117130,117132,117145,117150,117156,117160,117178,117181,117194,117195,117203,117206,117211,117214,117222,117226,117243,117246,117260,117263,117265,117268,117290,117293,117306,117309,117337,117338,117346,117349,117358,117359,117360,117537,117540,117730,117735,117740,117931,117936,117941,118016,118017,118018,118019,118020,118021,118202,118211,118229,118230,118246,118601,118602,118603,118677,118680,118682,118683,118684,118685,118690,118776,118777,118778,118779,118780,118875,118877,118879,118881,118883,119483,119484,119492,119495,119502,119505,119516,119519,119531,119534,119547,119550,119562,119565,119580,119582,119595,119600,119606,119610,119628,119631,119644,119645,119653,119656,119661,119664,119672,119676,119693,119696,119710,119713,119715,119718,119740,119743,119756,119759,119787,119788,119796,119799,119805,119808,120337,120341",
})
