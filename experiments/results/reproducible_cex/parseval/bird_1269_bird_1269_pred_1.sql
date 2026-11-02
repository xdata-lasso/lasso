-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'rwbbp6luhvd', '2022-01-04', '2023-05-26', '2023-05-30', 'lbn', 'rmdp');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '8pz0f8je', '2021-02-03', '2020-07-19', '2025-01-26', 'vy9uxj4', 'wb');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, 'npi', '2022-03-19', '2025-06-18', '2021-11-16', '8qs27p2r', '4gth2mnaj');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, '162nh55y3d', '2022-07-01', '2021-04-24', '2023-09-10', '06dza3', 'rmkio18r');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (6, 'dpunmw', '2020-12-14', '2023-12-06', '2024-03-09', 'rlawk', '14r5dqt');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (7, 'kxginl', '2021-08-14', '2025-09-23', '2021-07-24', 'dmp61l2o3ak1', '62ocagjeevx');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '1975-06-20', 2026480202, -1576219117, -1823627488, -1209887326, 992.733505, 162.04354, 174.140432, 1038707349, 587.783596, 558.971814, 1419861592, 700088193, 374105386, 1274489983, 128.76421, 610.208018, 108.098664, 623.093099, -1585009206, 191.847248, -53231346, 816.814398, -443340271, 757448742, -1179823637, 'rqro', 775304493, 373262291, -472966518, 's5bbp02e', 'tliqa1', 'ryytoo3', -1666765085, 1178636309, 'ex1', 'ji7zwau2', '0', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 556727997);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1975-06-20', -1929953647, 1581736075, -261132974, -1264842910, 893.16532, 254.83756, 209.967034, -1660358170, 41.944398, 242.407667, -1509264256, -792947627, -1898531797, -1748371085, 94.390081, 541.805676, 708.207154, 450.823993, -1056308489, 406.816852, -1454058168, 395.957566, -2078052421, -512640349, 1038566008, 'n6vck6ah0f', 138842628, -932772113, -639539893, '7xb72', 'xa', '7ryfdrz16n', -1496556994, -2115841792, 'dh5ogrgj', '8', '0', 'yzt1afgogrit', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7', 1523825314);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 2078438287, -47052816, 645287482, 765724008, 528.552305, 243.919919, 224.624401, 87529806, 752.977863, 723.045103, -1957268147, -1928431425, 1303877941, -1284905200, 102.360106, 501.846153, 93.813527, 935.463334, 820970595, 537.702873, 1421303999, 53.966914, -1488156735, -1858644047, -1180042408, '78507cvt', -1523347137, 1582582341, 453836040, '6b', 'ou5z', '36c', 1722106924, -2072838897, 'foa', 'cd07z2zezjo7', '0', 'wgxd5ysxcm', '0oztd', 'j5', '3lq', 1816660482);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '1975-06-20', -1478011227, -2096405521, 1803796945, 872694102, 311.951038, 298.104305, 564.350426, 618058035, 318.763195, 861.671891, -1252009958, 1908593332, 697257217, -451030047, 636.053055, 751.664174, 22.079409, 543.387709, -489120589, 161.672605, -72442907, 258.625847, -2060082151, -1122409769, 1849819405, 'us3auvmkrpdj', 1105964624, -663234145, -2013213247, '9mo7', '5a9n0jx', 'of', -634585028, 1719800120, 'o', '2zobb0q0k32o', '0', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 1056589776);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-03-12', 761519897, 1504707292, 955267863, -1156828895, 845.392744, 619.529525, 514.470353, 718167481, 832.527521, 124.067083, 1435223075, 1617348603, -477129795, -1418927432, 904.57762, 769.556907, 593.9327, 493.005436, -277407746, 343.967529, -2140468103, 509.069144, 469838697, 1468640756, 1048147204, 'eowi', -1610380698, -457369423, 1557188093, 'xih662q2xly', 'otow9oaawg', '6aqb0tbin', -1897615568, 2085299664, 'j', '9td8n5w', 'g', 'mbc3td', 'u6bd0w9603', 'vzxw1rxe9y', 'k7', -1046720861);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '1975-06-20', 431832073, 1510892261, 1677948887, 389700824, 745.189516, 852.871276, 669.410517, -1853955201, 312.339174, 363.494801, 1664452437, -1485875026, -2080232972, 462225708, 399.670941, 931.785842, 640.605522, 206.389463, 1528227252, 202.604041, -1659775598, 453.840746, -891525031, -1154091048, -1971560508, 'sh5knzys7', 1487347213, 1328948152, -1923069176, 'jmgjach8qt', 'a8y3a17v4yg', 'mayq3qdpua', 1291298007, 1982265552, 'dqrhm', 'wlic7dn2', '0', 'p490', 'dmsqtg', 'lc', 'qb9i9f', -788896327);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-07-31', 1046248997, 1584429327, -1575692857, 1570917601, 680.51123, 22.149931, 538.678811, 1862197286, 770.955182, 286.029577, 1040753276, -324012243, -1333785554, 1784997708, 591.192357, 312.188049, 918.559379, 337.793276, 44959255, 482.609422, -2128972904, 857.91055, -1043357093, -753065777, 190510318, 'tb8r9114qbre', 316163741, -752650834, 2134937984, '8kj', '85', 'pxlvri', 986268139, 2042428747, 'z0kaq', 'ncgc8', '3b7v8', 'kwdmdbdht', 'j47nxar50', 'sj', 'an', 1195320303);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (6, '1975-06-20', 1298113538, -1340460158, -2098439423, -459764012, 232.665028, 414.584569, 719.864422, 6224071, 562.744101, 949.111842, 1216978423, -1087163929, -1944869637, 658507818, 577.853117, 768.892438, 828.819416, 131.373165, 1352531282, 437.166224, 580887132, 776.759844, -299585625, -2014514218, -1184608964, 'pavcvwn', 1971816668, -1067465394, 1491006943, 'lrpou', 't63', 'xyfvmjwpp26', 1913338832, -2061050846, 'j', '0ju0h3r133ir', '0', 'axyyhpl', 'i9esap8p', 'gckqwtsr54', '6qje', 889799750);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-05-12', -1892701926, -460035045, 1794943626, 886926141, 568.592974, 159.965354, 632.587127, 1014069980, 824.6928, 293.222583, 1070869226, -1522433566, -1517668312, 173803229, 41.066446, 377.389472, 584.512314, 863.349328, 472597763, 630.926892, 826141460, 863.666767, -516707997, 1014871129, -583955995, '6dvdxdo2v7', 1805923837, -699779308, -1368221491, 'fjvuun7k1', 'z2my1og', 'v1rgeza', 423028705, -316078323, 'upg', 'ly78oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', '9lqv26u3', '1spxpw30', -2051120765);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (7, '1975-06-20', -410809407, -1381068866, 207561330, -781096377, 221.727759, 539.135238, 998.228481, -2007399097, 64.74848, 478.523041, 426006253, 1097428449, -712974538, 1201135348, 672.853096, 493.307381, 341.359358, 70.074089, 2117356203, 561.452917, 824044840, 450.037356, -54963162, 1084895939, 765955451, 'db2f0c', -537413388, 2011754567, 1755688363, '8xjhc', '46', 'f', 1280646590, -568125159, '1sjv8nv3d', 'r', '0', 'kuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', 1403715810);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-10-27', -213453775, -1721445347, -314024594, -786313930, 153.024976, 627.305072, 79.058562, 184502432, 823.023023, 928.280038, 1599677804, 2095228319, 1190577316, -1727712360, 540.352703, 366.943962, 25.420967, 987.183792, -1037450107, 182.264528, 1311066510, 351.628347, -924570154, -99415515, -635922435, 'hl7j43y7', 209963559, -480726958, 191797158, 'r3w', 'jn2z19xg', 'jac', -1725535379, 1709325128, 'if4180te', 'bfokv', 'e6', 'ltut6', 'lu2cel8mhfc', 'mn5', 'ni', -1800278299);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.SC170 IN ('negative', '0') AND T2.Date > 1997 - 01 - 01;

/*
Gold Result:
(2,)
(1,)
(1,)
(4,)
(5,)
(6,)
(7,)
*/

-- Prediction Query
SELECT DISTINCT T1.ID FROM Examination AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1."Examination Date" >= '1997-01-01' AND T2.SC170 IN ('-', '+-');

/*
Prediction Result:
*/