-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: company --
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (582.588439, '5k5swwqcgsk', 'com_d01922', '9n8c4pgu7v', 86.520366, 65.761562, 779.409124, 640.719621);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (770.236508, 'ia2yp', 'com_d01922', 'uzhsrwbbp6lu', 737.440743, 334.878198, 55.194297, 303.05704);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (125.12763, 'n', 'com_d01922', 'rmdp', 227.766936, 971.82669, 133.007885, 75.403642);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (327.753528, 'w6kl', 'com_96dd1e', 'a9', 877.276439, 627.258639, 801.414196, 890.762259);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (720.527846, '5c4ec', 'com_96dd1e', 'gce', 467.07027, 875.837169, 893.977471, 502.947917);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (206.591836, 'um5', 'com_96dd1e', 'zbuo4nrq', 597.420508, 220.906948, 82.05602, 259.725805);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (242.260296, '02eutliqa11r', 'com_d01922', 'ytoo3o9', 111.926013, 731.301441, 691.846832, 907.988865);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (938.694822, 'klex14ji', 'com_d01922', '7zwau2dwyr', 262.105498, 591.461096, 998.887019, 375.832821);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (499.570479, '8d99rljsl', 'com_d01922', 'b4yp5qi', 447.109657, 164.583726, 978.797504, 551.785129);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (710.141592, 'x58pz', 'com_96dd1e', 'f8jegd2', 890.091601, 339.69384, 654.149, 744.309401);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (22.720462, '9uxj4hwbdvl', 'com_96dd1e', 'h2gn', 58.749749, 958.414393, 345.35543, 250.856497);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (990.777211, 'x5hncprjtu0', 'com_96dd1e', 'z', 521.610309, 654.674676, 92.925632, 94.390081);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (541.805676, 'n2f3dqv0gcb9', 'com_d01922', 'ozk3zbily', 279.382219, 170.168747, 648.551674, 692.775559);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (339.789525, '6ah', 'com_d01922', 'f8jswwl', 260.513699, 969.559316, 786.074668, 748.513304);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (792.282443, '7', 'com_d01922', '2fxa7ryfdrz', 753.351134, 433.558647, 514.314362, 130.468488);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (151.555666, 'i', 'com_96dd1e', 'dh5ogrgj', 54.980195, 958.424773, 740.059813, 388.212083);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (393.279942, '1afgogritsj', 'com_96dd1e', 'ayxp1q43', 787.642728, 947.945777, 571.595144, 620.748111);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (123.184903, 'den8c68x', 'com_96dd1e', 'vacx7afu5', 354.593207, 432.405958, 850.85096, 80.712613);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (517.927187, 'o72ctdc', NULL, 'mfg62', 93.813527, 935.463334, 492.883123, 691.147113);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (537.702873, 'djpe1', NULL, 'o22', 518.274259, 494.537964, 409.740447, 656.82869);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (966.626935, 'tjpttg', NULL, 'bnou5zi36', 952.850618, 900.959264, 17.379583, 166.297151);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (91.430825, 'acd0', NULL, '7z2zezjo7wg', 790.772456, 50.798088, 486.564401, 286.870177);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (33.028254, '0oztd', NULL, 'j5', 125.223349, 172.799686, 913.609637, 922.974233);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (184.430978, 'pim5', NULL, '58q', 975.929586, 923.138524, 876.038555, 628.658254);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (745.691525, 'r94gth2m', 'com_d01922', 'ajjl', 11.892553, 588.850908, 230.994112, 919.979201);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (338.437591, 'uttmu2ne578', 'com_d01922', 'fvy', 392.947196, 527.633597, 394.986387, 636.053055);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (751.664174, 'e', 'com_d01922', 'yvkv42q7s', 904.091882, 927.310086, 676.067095, 762.654945);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (903.551325, '8b4pmaus3au', 'com_96dd1e', 'mkrpdj', 736.632717, 757.502454, 401.500141, 345.578764);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (31.262264, '9mo7', 'com_96dd1e', '5a9n0jx', 81.754381, 82.48091, 296.34381, 397.200175);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (969.175862, '2zobb0q0k32o', 'com_96dd1e', 'w', 38.169466, 179.038075, 496.273108, 602.47238);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (622.950834, 'sorl', 'com_d01922', 'yngc1d', 605.551549, 821.485286, 549.267866, 633.999218);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (273.585386, 'iz', 'com_d01922', 'k1', 722.415629, 230.654784, 845.392744, 619.529525);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (514.470353, 'l0hdt6fuqyx', 'com_d01922', 'uzkb521gwnl', 900.123388, 291.821648, 907.723998, 65.338043);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (972.538761, 'boe', 'com_96dd1e', 'wii1', 393.510383, 862.561101, 627.816635, 138.537557);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (515.131026, '2q2xlyoto', 'com_96dd1e', '9oaawg', 555.75468, 743.240647, 725.010524, 19.988339);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (301.874779, 'indz39tajz', 'com_96dd1e', 'td8n5wcgu', 203.071475, 950.098522, 714.781282, 619.508764);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (455.52504, 'tdu6bd0w96', 'com_d01922', '3vzxw1r', 372.360229, 65.653061, 555.30941, 85.140124);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (165.89756, 'k162n', 'com_d01922', '55', 990.308943, 467.033126, 602.631056, 116.944655);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (329.335312, '6dza35r', 'com_d01922', 'mkio18ri2hy', 745.189516, 852.871276, 669.410517, 956.805026);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (417.045459, '8ftp6ewtqx', 'com_96dd1e', 'njabym', 399.670941, 931.785842, 640.605522, 206.389463);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (855.818133, 'fx7h', 'com_96dd1e', '3p6sto1c', 149.178936, 539.789098, 842.068284, 117.444117);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (165.118823, 'zys7dyyd1jmg', 'com_96dd1e', 'jach8qta8y3', 5.194667, 523.794239, 578.974734, 478.922811);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (385.160931, 'mayq3qdpua', 'com_d01922', '96rn', 968.723597, 51.630816, 765.196951, 278.413617);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (191.514384, 'wlic7dn2np', 'com_d01922', '90xdmsqt', 107.568093, 176.006489, 321.654734, 261.228211);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (554.543791, '9f2', 'com_d01922', 'ccukjq1qui', 160.296838, 696.949621, 886.836401, 389.028495);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (111.094646, '8hlst1p', 'com_96dd1e', 'qomiztvb6m', 482.609422, 398.641235, 873.064955, 637.227131);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (516.502645, 'q', 'com_96dd1e', 'lud8f', 877.828469, 305.404216, 544.766726, 990.66185);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (556.586972, '14qbre6', 'com_96dd1e', 'j', 71.721662, 312.71205, 324.759821, 997.078987);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (952.343165, '8kj', 'com_d01922', '85', 358.01048, 368.667363, 613.26632, 618.852675);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (341.710003, 'sur', 'com_d01922', '0kaqtnc', 662.418642, 599.871479, 843.228203, 836.758526);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (467.19504, '7', 'com_d01922', 'v88kwdmdbd', 120.684261, 507.914607, 147.235401, 482.136874);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (524.040306, 'ar50hs', 'com_96dd1e', 'han', 778.307195, 840.734969, 48.58913, 810.178547);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (244.803602, 'mwfw', 'com_96dd1e', 'qrlawk', 417.346356, 930.12583, 630.078975, 471.914793);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (490.559457, 'dqtsmg97aqz', 'com_96dd1e', 'o20pj6dd', 783.349866, 383.695713, 989.668309, 284.012583);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarters FROM (SELECT LHS.n AS n, RHS.headquarters AS headquarters, RHS.n AS n_other FROM (SELECT MAX(n) AS n FROM (SELECT headquarters, COUNT(*) AS n FROM company GROUP BY headquarters)) AS LHS CROSS JOIN (SELECT headquarters, COUNT(*) AS n FROM company GROUP BY headquarters) AS RHS) WHERE (n <= n_other) ORDER BY headquarters;

/*
Gold Result:
('com_96dd1e',)
('com_d01922',)
*/

-- Prediction Query
SELECT Headquarters FROM company GROUP BY Headquarters ORDER BY COUNT(*) DESC, Headquarters NULLS LAST LIMIT 1;

/*
Prediction Result:
('com_96dd1e',)
*/