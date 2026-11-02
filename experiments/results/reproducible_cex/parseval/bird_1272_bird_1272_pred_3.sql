-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2024-06-15', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, '9rljsl0b4', '2024-04-25', '2022-09-10', '1969-12-31', 'qi2rkf9v', 'x58pz');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-1, 'f8jegd2', '2024-11-12', '2023-10-23', '2024-05-17', '9uxj4hwbdvl', 'h2gn');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (0, 'npi', '2022-03-19', '2025-06-18', '1970-01-01', '58q', 's27p2r94gth2');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'value', '2024-06-15', '2024-06-15', NULL, 'value', 'value');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, 'qrlawk', '2024-09-05', '2024-10-27', '2025-04-16', '5dqts', 'g97a');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 'value', '2024-06-15', '2024-06-15', NULL, 'value', 'value');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 1644814318, 1465859724, -1349201381, 1019800248, 334.878198, 55.194297, 303.05704, -1610064545, 22.535764, 600.048938, 462974032, -1137908826, -918961358, -1602639011, 489.397796, 933.422701, 345.718563, 510.466242, 1151980946, 83.204633, 1620389964, 627.258639, 947159877, 1990080517, 1408123494, '4', 374105386, 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, 'liqa1', 'ryytoo3', '9hl7', 'A', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '2024-06-15', 1968874827, -664193365, -1070063173, 555413010, 668.309685, 635.267184, 210.05299, 1575412235, 269.734861, 304.188492, -361507387, 401805964, -1485777725, -1255130038, 89.552801, 687.701166, 656.638403, 619.547972, -688216274, 577.256099, 1382410067, 879.800692, 172461907, 1606439408, 1443629118, 'zbilyrkn', -688098735, 1784916884, 37673509, 'h0f8jswwlq', 'xb72fxa7r', 'fdrz16n', -1496556994, -2115841792, 'dh5ogrgj', '8', 'yzt1afgogrit', 'A', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7', 1523825314);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1970-01-02', 2078438287, -47052816, 645287482, 765724008, 528.552305, 243.919919, 224.624401, 87529806, 752.977863, 723.045103, -1957268147, -1928431425, 1303877941, -1284905200, 102.360106, 501.846153, 93.813527, 935.463334, 820970595, 537.702873, 1421303999, 53.966914, -1488156735, -1858644047, -1180042408, '78507cvt', -1523347137, 1582582341, 453836040, '6b', 'ou5z', '36c', 1722106924, -2072838897, 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', 'A', '0oztd', 'j5', '3lq', 1816660482);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '2024-06-15', 1162591638, -2136247961, -1478011227, -2096405521, 588.850908, 230.994112, 919.979201, 872694102, 311.951038, 298.104305, 618058035, 1553368934, -1252009958, 1908593332, 86.586744, 781.110793, 338.326185, 662.342849, -451030047, 636.053055, -2052653308, 543.387709, -489120589, -72442907, -2060082151, 'pmaus3auvmkr', 609771851, -1934017803, 1105964624, 'w5chn9m', 'o705a9n0jxfo', 'ws', 1719800120, -210159774, 'obb0q0k32o', 'w', 'l', 'A', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', -1614619556);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-01', 1435223075, 1617348603, -477129795, -1418927432, 904.57762, 769.556907, 593.9327, -30041412, 435.41097, 343.967529, -2140468103, 469838697, 1468640756, 1048147204, 228.334858, 77.441426, 349.149444, 125.054027, -457369423, 862.561101, 548968280, 138.537557, 7342822, -1034034171, 1244279905, 'lyotow9oaaw', -1048779857, -381485009, 868039568, 'ndz39tajz9', 'd8n5w', 'g', -794767771, 989306270, 'tdu6bd0w96', '3vzxw1r', 'e9yfk7', 'A', 'k162n', '55', '3dohvu0', 30861410);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1970-01-01', -438741674, -154207334, 729449685, -1580984044, 422.698571, 535.063373, 600.543738, 1510892261, 890.677915, 590.734291, -1853955201, -805997097, -586285368, 1664452437, 919.033168, 830.662489, 154.042758, 779.614625, -2080232972, 607.620308, 1528227252, 202.604041, -1659775598, -891525031, -1154091048, 'j', 1728926031, -63214972, 1106724223, 'ys7dyyd1jmg', 'jach8qta8y3', '1', 339193890, -493230039, 'mayq3qdpua', '96rn', 'dqrhm', 'A', 'wlic7dn2', 'p490', 'dmsqtg', -1872934808);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2020-06-13', -1025517017, 1374676344, 238243966, -788896327, 141.072566, 862.602858, 424.171576, -796609690, 160.296838, 696.949621, -1670335771, 1862728578, 1909521477, 2101986789, 961.035335, 784.591475, 139.623194, 403.002922, 2141720493, 636.138886, 1793241362, 17.438617, -1304516770, -1558272216, 195316816, 'qlud8', 948460309, 1183069552, -1057355067, 'e6bje', 'uuwsj8kjh8', 'wpxlvris', 2042428747, 1228655416, 'kaqtncg', 'c8s3b7v88k', 'dmdbdh', '6j47n', 'ar50hs', 'han', 'xdpunmw', -1782325492);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '2022-12-11', -459764012, -1148194959, 944310519, 6224071, 562.744101, 949.111842, 783.349866, -1087163929, 47.174746, 653.320799, 334376591, 1154884242, 1352531282, -269868995, 354.170103, 665.003292, 779.203825, 635.24832, 1188674483, 981.395878, -299585625, 0.318929, -2014514218, -1184608964, 1994296595, 'avcvwnyqroui', -980625770, 721232773, 323781506, 'ouit63xyfvmj', 'wpp26mb3aj0j', '0h3r13', -156860347, 1805058154, 'axyyhpl', 'i9esap8p', 'gckqwtsr54', '0', '6qje', 'ktb1d2nzg3rj', 'wns', 1125564712);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '2025-06-17', -1437333179, -921145356, 1258409369, -1981402255, 292.730571, 572.766956, 206.939346, 1610062532, 475.173408, 935.695299, 809183447, 89267185, -1865039888, 1160656988, 268.82475, 710.998147, 945.642658, 795.366812, 1219478689, 718.397869, -1670923962, 663.049759, 906324270, 1908028688, 2122220075, 'p6luhvdlttil', 429706943, 462974032, -1137908826, 'siie5unw6k', 'fa9', '00t5c4e', 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '0', '2eutliqa11r', 'ytoo3o9', 'l7', 1178636309);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE NOT T1."First Date" IS NULL AND NOT T2.SSA IN ('negative', '0') ORDER BY T1."First Date" ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT P.ID FROM Patient AS P JOIN Laboratory AS L ON P.ID = L.ID WHERE NOT L.SSA IN ('negative', '0') ORDER BY P."First Date" ASC, P.id NULLS LAST, L.id NULLS LAST, L.date NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/