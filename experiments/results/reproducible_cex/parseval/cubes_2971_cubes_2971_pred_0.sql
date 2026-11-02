-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: companies --
INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483648, '5k5swwqcgs', 'com_60fafe', 'com_fc689c', 171.746906, 557.512061, 868.436572, 'c4pgu7vfe');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483647, 'hria2ypu', 'com_60fafe', 'com_fc689c', 882.963176, 841.297061, 294.861575, 'wbbp6');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483646, 'uhv', 'com_60fafe', 'com_fc689c', 855.355181, 179.378884, 304.02808, 'bnp');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483645, 'mdpos', 'com_ac71a2', 'com_61ae7d', 133.007885, 75.403642, 327.753528, 'w6kl');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483644, 'a9', 'com_ac71a2', 'com_61ae7d', 877.276439, 627.258639, 801.414196, '0t5c4ecigce');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483643, '76nium52', 'com_ac71a2', 'com_61ae7d', 816.814398, 396.776796, 676.357279, '4nrq');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483642, 'rofqyp5s5b', 'com_60fafe', 'com_fc689c', 22.720462, 990.777211, 705.580387, '2eutliqa11r');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483641, 'ytoo3o9', 'com_60fafe', 'com_fc689c', 111.926013, 731.301441, 691.846832, '2klex14ji');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483640, '7zwau2dwyr', 'com_60fafe', 'com_fc689c', 262.105498, 591.461096, 998.887019, 'u78d99r');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483639, 'jsl', 'com_ac71a2', 'com_61ae7d', 419.361606, 470.165282, 384.969231, '5qi2');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483638, 'kf9vq', 'com_ac71a2', 'com_61ae7d', 604.643336, 829.94159, 369.789339, '8pz0f8je');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483637, 'd2', 'com_ac71a2', 'com_61ae7d', 890.091601, 339.69384, 654.149, '9uxj4hwbdvlp');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483636, 'h2gndqwnqcx5', NULL, 'com_fc689c', 635.267184, 210.05299, 866.804244, 'jtu0d');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483635, '79fjgq8', NULL, 'com_fc689c', 915.268032, 207.767266, 89.552801, 'dqv0gcb98ozk');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483634, 'zbilyrkn', NULL, 'com_fc689c', 692.775559, 339.789525, 915.583344, 'ah0f8jsww');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483633, 'q7x', NULL, 'com_61ae7d', 21.129657, 525.144763, 626.23891, 'fxa7ryfd');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483632, 'z16ni', NULL, 'com_61ae7d', 968.276986, 154.68882, 128.858335, 'dh5ogrgj');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483631, '8', NULL, 'com_61ae7d', 740.059813, 388.212083, 393.279942, '1afgogritsj');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483630, 'ayxp1q43', 'com_60fafe', NULL, 787.642728, 947.945777, 571.595144, 'jh3den8c68');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483629, '8vacx7', 'com_60fafe', NULL, 854.793228, 983.924121, 313.653498, 'w1of77pz');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483628, '72ct', 'com_60fafe', NULL, 51.002063, 803.582738, 695.452114, 'fg62');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483627, '0v', 'com_ac71a2', NULL, 492.883123, 691.147113, 537.702873, 'djpe1');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483626, 'o22', 'com_ac71a2', NULL, 518.274259, 494.537964, 409.740447, '7cvtjpttg6b');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483625, 'ou5z', 'com_ac71a2', NULL, 988.279797, 893.898414, 464.719657, '4');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483624, 'f', 'com_60fafe', 'com_fc689c', 166.297151, 91.430825, 992.004558, 'acd0');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483623, '7z2zezjo7wg', 'com_60fafe', 'com_fc689c', 790.772456, 50.798088, 486.564401, 'xcmr0');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483622, 'ztdg', 'com_60fafe', 'com_fc689c', 145.027285, 495.31632, 458.880538, '5lnpi');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483621, '5k58', 'com_ac71a2', 'com_61ae7d', 251.966916, 723.188966, 287.301621, '7p2r94gt');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483620, '2m', 'com_ac71a2', 'com_61ae7d', 925.474843, 211.248782, 988.412528, 'ajjla3okv8');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483619, 'uttmu2ne578', 'com_ac71a2', 'com_61ae7d', 944.379011, 86.586744, 781.110793, 'yz7zzb');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483618, '8y', 'com_60fafe', 'com_fc689c', 335.639672, 743.007715, 574.117269, 'q7sx58b4');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483617, 'pmaus3auvmkr', 'com_60fafe', 'com_fc689c', 641.973572, 49.701386, 736.632717, 'zw5chn');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483616, 'mo705a9n0', 'com_60fafe', 'com_fc689c', 903.226183, 364.404955, 228.613802, 'szdo2z');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483615, 'obb0q0k32o', 'com_ac71a2', 'com_61ae7d', 57.929422, 38.169466, 179.038075, 'amsorlwy');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483614, 'gc1d', 'com_ac71a2', 'com_61ae7d', 605.551549, 821.485286, 549.267866, 'rhizgk1yoey');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483613, 'o6l0hdt6fu', 'com_ac71a2', 'com_61ae7d', 254.178165, 388.909559, 789.60677, 'zkb521');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483612, 'wn', 'com_60fafe', 'com_fc689c', 176.569118, 1.63343, 509.069144, 'elboeowii1');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483611, '5nxih66', 'com_60fafe', 'com_fc689c', 441.511648, 446.264042, 369.064418, 'lyotow9oaa');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483610, 'g96aqb', 'com_60fafe', 'com_fc689c', 411.178599, 19.108635, 702.106209, 'ndz39tajz9');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483609, 'd8n5w', 'com_ac71a2', 'com_61ae7d', 36.996954, 314.953709, 30.758515, '3');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483608, 'tdu6bd0w96', 'com_ac71a2', 'com_61ae7d', 411.582585, 594.051247, 329.082644, 'xw1rxe9');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483607, 'fk7qk16', 'com_ac71a2', 'com_61ae7d', 593.648908, 442.663656, 111.965818, '5y3dohvu');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483606, '6dza35r', 'com_60fafe', 'com_fc689c', 968.215769, 191.353745, 982.430519, 'io18ri2hy08');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483605, 'tp', 'com_60fafe', 'com_fc689c', 505.600334, 349.371383, 255.149792, 'njabym');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483604, 'n2mfx7h', 'com_60fafe', 'com_fc689c', 463.637542, 753.382585, 784.064518, '6sto1cj8sh5k');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483603, 'zys7', 'com_ac71a2', 'com_61ae7d', 846.300006, 376.265501, 809.419851, '1');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483602, 'jmgjach8qt', 'com_ac71a2', 'com_61ae7d', 644.437797, 839.760651, 546.774617, '3a17v4y');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483601, 'ma', 'com_ac71a2', 'com_61ae7d', 383.770043, 851.486083, 833.617436, 'dpuap96rnt');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483600, 'q', 'com_60fafe', 'com_fc689c', 278.413617, 191.514384, 968.21585, 'wlic7dn2np');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483599, '90xdmsqt', 'com_60fafe', 'com_fc689c', 107.568093, 176.006489, 321.654734, 'b9i9f');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483598, 'ccukjq1q', 'com_60fafe', 'com_fc689c', 763.851917, 314.524853, 160.296838, 'yhb08hlst1pq');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483597, 'mizt', 'com_ac71a2', 'com_61ae7d', 636.138886, 917.521539, 17.438617, '4iz7');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483596, 'aqqlud8ft', 'com_ac71a2', 'com_61ae7d', 21.957253, 281.001583, 661.737334, '14qbre6');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483595, 'j', 'com_ac71a2', 'com_61ae7d', 71.721662, 312.71205, 324.759821, 'j8kjh');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483594, '5wpxlvris', 'com_60fafe', 'com_fc689c', 637.018037, 975.54, 852.317741, 'z0kaq');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483593, 'ncgc8', 'com_60fafe', 'com_fc689c', 836.758526, 467.19504, 28.233006, '7v88kwdmdbd');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483592, 't6', 'com_60fafe', 'com_fc689c', 573.061557, 953.185987, 814.396154, 'xar5');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483591, 'hsjhanz', 'com_ac71a2', 'com_61ae7d', 840.734969, 48.58913, 810.178547, 'unmw');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483590, 'wx', 'com_ac71a2', 'com_61ae7d', 257.835629, 174.163863, 15.293616, '014');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483589, '5dqts', 'com_ac71a2', 'com_61ae7d', 187.899799, 977.087263, 912.323762, 'aqz2o20pj6d');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483588, 'dlysu6iphd', 'com_60fafe', 'com_fc689c', 168.487055, 320.257221, 440.688407, 'ir');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483587, '31vwq51oa2sb', 'com_60fafe', 'com_fc689c', 458.205677, 903.031128, 823.323021, '1pa');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483586, 'cvwnyq', 'com_60fafe', 'com_fc689c', 265.913399, 973.214347, 713.663081, 'rlr');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483585, 'pouit63xyf', 'com_ac71a2', 'com_61ae7d', 824.672918, 189.105795, 720.842041, 'pp26mb');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483584, 'aj0ju0h3', 'com_ac71a2', 'com_61ae7d', 753.62991, 907.509317, 430.132714, '3ir1axyy');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483583, 'hpl2i9esap', 'com_ac71a2', 'com_61ae7d', 543.088934, 249.739912, 577.893106, 'ck');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483582, 'wtsr5', 'com_60fafe', 'com_fc689c', 563.737346, 483.873235, 504.138859, 'ekt');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483581, '1', 'com_60fafe', 'com_fc689c', 840.973378, 451.237024, 720.390829, '3r');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483580, 'jkwns47j2j', 'com_60fafe', 'com_fc689c', 13.17027, 649.440889, 62.043518, 'y');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483579, 'vjwq49yr', 'com_ac71a2', 'com_61ae7d', 736.293094, 606.851472, 364.037151, '6dvdxdo2v7');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483578, '3gvpl', 'com_ac71a2', 'com_61ae7d', 149.715435, 83.301061, 333.3832, 'un7k10');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483577, 'z2my1ogyv1r', 'com_ac71a2', 'com_61ae7d', 101.269961, 396.356531, 598.494048, '1');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483576, 'l', 'com_60fafe', 'com_fc689c', 575.65588, 236.600951, 707.803422, 'y78oitxeilp');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483575, 'e019cy7od0', 'com_60fafe', 'com_fc689c', 457.405588, 461.555144, 667.832657, 'l');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483574, 'hdsvnhed29lq', 'com_60fafe', 'com_fc689c', 342.988653, 438.837282, 510.275787, '331spx');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483573, 'pw30bgwkxgi', 'com_ac71a2', 'com_61ae7d', 594.167398, 184.825054, 787.227287, '6id');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483572, 'p61l', 'com_ac71a2', 'com_61ae7d', 785.330004, 449.508173, 231.240853, 'ak162oca');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483571, 'je', 'com_ac71a2', 'com_61ae7d', 63.114566, 614.405118, 897.548529, 'zxlu49');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483570, 'ubo', 'com_60fafe', 'com_fc689c', 66.494394, 782.029487, 694.102094, 'e');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483569, 'uekhllbw', 'com_60fafe', 'com_fc689c', 935.082587, 58.4493, 914.942002, '5v0edu');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483568, 'y9v2z12983', 'com_60fafe', 'com_fc689c', 728.526405, 935.403582, 363.048023, 'epac');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483567, 'db2f0c', 'com_ac71a2', 'com_61ae7d', 444.074683, 557.815176, 374.873691, 'et8xjhc');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483566, '46', 'com_ac71a2', 'com_61ae7d', 33.523694, 990.684439, 240.031233, 'rx');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483565, '6', 'com_ac71a2', 'com_61ae7d', 752.593918, 423.335696, 146.627287, 'nv3ddroku');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT headquarters FROM (SELECT LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.n AS n, RHS.headquarters AS headquarters_other, RHS.industry AS industry_other, RHS.n AS n_other FROM (SELECT headquarters, industry, COUNT(*) AS n FROM companies GROUP BY headquarters, industry) AS LHS CROSS JOIN (SELECT headquarters, industry, COUNT(*) AS n FROM companies GROUP BY headquarters, industry) AS RHS) WHERE (n > n_other) ORDER BY headquarters;

/*
Gold Result:
('com_60fafe',)
('com_ac71a2',)
*/

-- Prediction Query
SELECT Headquarters FROM Companies GROUP BY Headquarters HAVING COUNT(*) > 2;

/*
Prediction Result:
(None,)
('com_60fafe',)
('com_ac71a2',)
*/