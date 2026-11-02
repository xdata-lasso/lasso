-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'rwbbp6luhvd', '2022-01-04', '2023-05-26', '2023-05-30', 'lbn', 'rmdp');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '8pz0f8je', '2021-02-03', '2020-07-19', '2025-01-26', 'vy9uxj4', 'wb');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, 'npi', '2022-03-19', '2025-06-18', '2021-11-16', '8qs27p2r', '4gth2mnaj');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, '06dza3', '2025-06-10', '2023-01-25', '2022-02-22', 'io1', 'ri2hy08ft');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (6, 'awk', '2024-09-05', '2024-10-27', '2025-04-16', '5dqts', 'g97a');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (7, 'vx', '2024-07-14', '2024-02-10', '2021-12-31', '49kubo', '8c');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '1975-06-20', 2026480202, -1576219117, -1823627488, -1209887326, 992.733505, 162.04354, 174.140432, 1038707349, 587.783596, 558.971814, 1419861592, 700088193, 374105386, 1274489983, 128.76421, 610.208018, 108.098664, 623.093099, -1585009206, 191.847248, -53231346, 816.814398, -443340271, 757448742, -1179823637, 'rqro', 775304493, 373262291, -472966518, 's5bbp02e', 'tliqa1', 'ryytoo3', -1666765085, 1178636309, 'ex1', 'ji7zwau2', '0', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 556727997);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1975-06-20', -1929953647, 1581736075, -261132974, -1264842910, 893.16532, 254.83756, 209.967034, -1660358170, 41.944398, 242.407667, -1509264256, -792947627, -1898531797, -1748371085, 94.390081, 541.805676, 708.207154, 450.823993, -1056308489, 406.816852, -1454058168, 395.957566, -2078052421, -512640349, 1038566008, 'n6vck6ah0f', 138842628, -932772113, -639539893, '7xb72', 'xa', '7ryfdrz16n', -1496556994, -2115841792, 'dh5ogrgj', '8', '0', 'yzt1afgogrit', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7', 1523825314);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 2078438287, -47052816, 645287482, 765724008, 528.552305, 243.919919, 224.624401, 87529806, 752.977863, 723.045103, -1957268147, -1928431425, 1303877941, -1284905200, 102.360106, 501.846153, 93.813527, 935.463334, 820970595, 537.702873, 1421303999, 53.966914, -1488156735, -1858644047, -1180042408, '78507cvt', -1523347137, 1582582341, 453836040, '6b', 'ou5z', '36c', 1722106924, -2072838897, 'foa', 'cd07z2zezjo7', '0', 'wgxd5ysxcm', '0oztd', 'j5', '3lq', 1816660482);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-09-30', -1351793914, 1919033056, -1428186898, -761353513, 584.372269, 585.201826, 932.839964, -1311735207, 774.197346, 446.676539, -1817527403, -1402164108, 2123471885, -526633767, 823.908713, 604.525889, 391.037879, 920.405654, 458835042, 70.267562, 924693315, 335.639672, 1043710187, 318331233, -233617564, '7sx58b4pma', -929383517, -2090240067, -699574669, 'rpd', 'wzw', 'chn9mo70', 628082526, -1245584612, 'xfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 1483450542);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '1975-06-20', 513375398, 718167481, 1428194830, -1614619556, 302.258495, 834.163912, 876.568312, -477129795, 789.60677, 323.811635, -1418927432, -30041412, -277407746, -670154354, 176.569118, 1.63343, 509.069144, 609.392845, 1468640756, 744.040787, -1814875250, 349.149444, -1610380698, -457369423, 1557188093, 'xih662q2xly', 412199481, 727608179, 456034296, 'g96aqb', 'tbindz3', 'tajz9td8n', -625404808, -1694533100, 'bc3t', 'u', '0', 'bd0w9603v', 'xw1rxe9', 'fk7qk16', '2nh55y3doh', 1709667347);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-09-10', 24053253, -646944990, -1051623642, 2013745856, 2.747847, 713.589996, 376.823393, -1312038093, 615.054987, 714.773459, 687330820, -224390110, -1810873111, 1243701948, 463.637542, 753.382585, 784.064518, 717.320553, 63063873, 303.704524, -285085577, 149.178936, 170892881, -1643065004, -1438303683, 'zys7dyyd1jmg', 729543907, -2108844113, 973811121, 'ta8y3a17v4', 'ygmayq3qdpu', 'p', -845136979, -1042976410, 'm5', 'wlic7dn2np', '90xdmsqt', 'el', 'u', 'qb9i9f2ccu', 'jq1', 1584429327);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '1975-06-20', -1575692857, 1570917601, 775289854, -2052350430, 538.678811, 933.576593, 770.955182, 1040753276, 982.976965, 424.56002, -1333785554, 1784997708, -696672546, 44959255, 482.609422, 398.641235, 873.064955, 637.227131, -2128972904, 857.91055, -1043357093, 324.663207, 190510318, -835782528, 192271618, '9114qbre6bj', -752650834, 2134937984, 1379644459, 'kjh85wpxl', 'vrisurz0ka', 'qtncgc8s3b7', 438933248, 180947503, 'dmdbdh', '6j47n', '0', 'ar50hs', 'han', 'xdpunmw', 'wx', -1040088060);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-12-11', -459764012, -1148194959, 944310519, 6224071, 562.744101, 949.111842, 783.349866, -1087163929, 47.174746, 653.320799, 334376591, 1154884242, 1352531282, -269868995, 354.170103, 665.003292, 779.203825, 635.24832, 1188674483, 981.395878, -299585625, 0.318929, -2014514218, -1184608964, 1994296595, 'avcvwnyqroui', -980625770, 721232773, 323781506, 'ouit63xyfvmj', 'wpp26mb3aj0j', '0h3r13', -156860347, 1805058154, 'axyyhpl', 'i9esap8p', 'gckqwtsr54', '6qje', 'ktb1d2nzg3rj', 'wns', '47j2ja8dccy3', 1560573473);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (6, '1975-06-20', 472597763, 826141460, 1561936884, -516707997, 736.293094, 606.851472, 364.037151, -1935855834, 568.642833, 368.702718, -1195137401, 134065688, 1770139230, -1680744918, 235.288115, 149.715435, 83.301061, 333.3832, -743497747, 904.4568, -1415215611, 411.706646, -251621840, -1720233199, -672126855, 'gezax', -316078323, -754769711, 1128553504, 'xeilp', 'e019cy7od0', '3dlhdsvn', -1640621748, 253464886, 'qv26u331spx', 'pw30bgwkxgi', '0', 'nlj6idmp61', '2o3', 'k', '62ocagj', 1361395061);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-07-13', -92242817, 426006253, 1097428449, -712974538, 235.490046, 779.661114, 672.853096, -681356377, 70.074089, 326.821585, 2117356203, 824044840, -214587907, -54963162, 752.597021, 74.371479, 246.634839, 8.795476, 765955451, 819.453645, 1147974039, 448.700958, -344881050, -537413388, 2011754567, 'et8xjhcf46c', 312333412, 871812581, -977983676, '6', 'sjv8nv3', 'd', -958249959, -1446721688, 'zc', 'ehia3', 'm', 'vb7vpc0xff', 'or1esk', 'f9q82', 'g01hu', -1585280787);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (7, '1975-06-20', 128895724, -1663813652, 1094664154, -1728059226, 884.814516, 493.547402, 664.385712, 854201197, 151.332492, 833.61801, -2086261320, 1540741724, -1101370596, -1439283063, 131.880413, 118.849547, 523.505367, 727.964075, -113489293, 388.063936, 209963559, 388.072029, 191797158, -1428261633, 1895921842, 'w4jn2z19xgj', 319828561, 1912528652, -1333309256, 'fb5', 'f41', '80terbfokvee', 59326585, -1371170489, 't6lu2c', 'l8', '0', 'mhfcimn5eni', '0fm', 'bgz5oqxs27', 'h888y1', -30240851);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.SC170 IN ('negative', '0') AND T2.Date > 1997 - 01 - 01;

/*
Gold Result:
(3,)
(1,)
(1,)
(4,)
(5,)
(6,)
(7,)
*/

-- Prediction Query
SELECT DISTINCT l.id FROM laboratory AS l WHERE l.date > '1997-01-01' AND l.sc170 IN ('negative', '0');

/*
Prediction Result:
(1,)
*/