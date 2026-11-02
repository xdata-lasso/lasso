-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2024-06-15', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-1, '9rljsl0b4', '2024-04-25', '2022-09-10', '1970-01-01', 'qi2rkf9v', 'x58pz');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (0, 'f8jegd2', '2024-11-12', '2023-10-23', '1970-01-02', '9uxj4hw', 'd');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'value', '2024-06-15', '2024-06-15', NULL, 'value', 'value');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, '50hsj', '2021-04-17', '2020-01-25', '2022-05-11', 'xdpunmw', 'wx');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, 'value', '2024-06-15', '2024-06-15', NULL, 'value', 'value');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 1644814318, 1465859724, -1349201381, 1019800248, 334.878198, 55.194297, 303.05704, -1610064545, 22.535764, 600.048938, 462974032, -1137908826, -918961358, -1602639011, 489.397796, 933.422701, 345.718563, 510.466242, 1151980946, 83.204633, 1620389964, 627.258639, 947159877, 1990080517, 1408123494, '4', 374105386, 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, 'liqa1', 'ryytoo3', '9hl7', 'A', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1969-12-31', -736979194, 2103044118, -1642259219, 1298861365, 58.749749, 958.414393, 345.35543, -1070063173, 629.317167, 668.309685, 580968159, -1245312912, 1575412235, -988981234, 304.188492, 415.830002, 395.809081, 552.472052, 401805964, 154.065416, -1255130038, 89.552801, 806170397, 513454646, -688216274, 'gcb98ozk3z', 1686459626, -1554531873, 982314585, 'kn6vc', '6ah', 'f8jswwl', 1255343543, -541746689, '7ryfdrz16n', 'jja', '5dh', 'A', 'ogrgjd8y', 't1afgog', 'itsj3', -491938169);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-01', -106471771, 1235416111, 1923912467, 518609210, 123.184903, 953.64343, 57.52658, 1476361420, 216.6701, 596.764785, 195720193, 1774087382, 1732258051, -1762140823, 819.265503, 354.593207, 432.405958, 850.85096, 76996700, 398.637058, 1992637800, 308.935851, 481546706, -1784554553, -242584410, 'v5q8qdj', -1139855872, -288338724, 1897687032, '278507cv', 'jpttg', 'bnou5zi36', 1944978593, 1722106924, 'f', 'foa', 'cd07z2zezjo7', 'A', 'wgxd5ysxcm', '0oztd', 'j5', -1609653472);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-02', -1405314653, 1816660482, -1212676731, 1692046802, 197.278049, 167.377262, 492.8451, -1125548818, 848.622384, 555.274052, -95808609, -244633520, 418247369, -1524425594, 185.260952, 462.366429, 946.809703, 904.028668, -1428186898, 543.846419, -761353513, 584.372269, -1311735207, -229022515, -1817527403, '78lfvyz7zz', -2052653308, -489120589, -72442907, '7sx58', 'b4pmaus3auv', 'krpd', -609553675, 989018473, 'chn9mo70', 'a9n0jxfo', 'ws', 'A', 'do2zobb', 'q0k32od', 'cl5ams', 709097796);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1969-12-31', -984562992, -605061107, -1689155697, -323362455, 605.551549, 821.485286, 549.267866, -413043724, 677.305163, 850.341964, 955267863, -1156828895, 1483450542, 513375398, 514.470353, 667.211392, 832.527521, 124.067083, 1435223075, 876.568312, -477129795, 789.60677, -1418927432, -30041412, -277407746, 'nlas6e', 1468640756, 1048147204, -1814875250, 'ii1z5n', 'xih662q2xly', 'otow9oaawg', 1044710644, 966412849, '0', 'bindz', '9tajz9td', 'A', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', -505019168);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1970-01-01', 1968783602, 125495479, 312804300, -246257698, 111.965818, 490.363975, 488.399647, -516345261, 48.647907, 222.671584, 1709667347, -1934709172, -2121397544, 1595632888, 968.215769, 191.353745, 982.430519, 683.879518, -1160642134, 816.359248, 769234989, 949.964729, 168442149, 1299171592, 2066302536, 'ewtqxxnja', -2080232972, 462225708, 1528227252, 'fx7h', '3p6sto1c', '8sh', -63214972, 1106724223, 'ys7dyyd1jmg', 'jach8qta8y3', '1', 'A', 'v4ygmayq3', 'dpuap', '6rntdqrhm', 555368535);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2022-01-12', -1573704891, -1260548409, 1409697108, -1104749933, 551.339916, 588.394429, 362.160981, 1744849810, 840.039966, 964.892941, -1027584872, -1685482179, -1391541536, -1025517017, 554.543791, 820.066773, 555.47049, 446.993541, -788896327, 141.072566, -325680600, 763.851917, -796609690, -1459013972, -1670335771, '8hlst1p', -1333785554, 1784997708, -696672546, 'm4iz78aqq', 'ud8', 'tb', 192271618, -312228770, 'qbre6bje', 'uuwsj8kjh8', 'wpxlvris', 'urz0kaqtncg', 'c8s3b7v88k', 'dmdbdh', '6j47n', -556370776);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2022-11-22', -958321297, 2015039199, -641927001, 558684943, 471.914793, 490.559457, 633.284644, 1348973408, 309.882408, 287.669302, 1084127083, -1019350771, -225571092, -261782899, 974.446302, 248.773501, 878.502931, 50.158445, -1385967617, 784.000091, 1813965704, 667.60579, 1193656937, 434520825, -1664440372, 'u2g', 1352531282, -269868995, 580887132, '1oa2sb3u', 'i1pa', 'cvwnyq', -1005394301, 917675957, 'rlr', 'pouit63xyf', 'mjwpp2', '0', 'mb3aj0ju0', '3r', '133ir1axyy', -1617977597);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '2025-06-17', -1437333179, -921145356, 1258409369, -1981402255, 292.730571, 572.766956, 206.939346, 1610062532, 475.173408, 935.695299, 809183447, 89267185, -1865039888, 1160656988, 268.82475, 710.998147, 945.642658, 795.366812, 1219478689, 718.397869, -1670923962, 663.049759, 906324270, 1908028688, 2122220075, 'p6luhvdlttil', 429706943, 462974032, -1137908826, 'siie5unw6k', 'fa9', '00t5c4e', 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '0', '2eutliqa11r', 'ytoo3o9', 'l7', 1178636309);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE NOT T1."First Date" IS NULL AND NOT T2.SSA IN ('negative', '0') ORDER BY T1."First Date" ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT "patient"."id" FROM "patient" JOIN "laboratory" ON "patient"."id" = "laboratory"."id" WHERE NOT "laboratory"."ssa" IN ('negative', '0') ORDER BY "patient"."first date" ASC, patient.id NULLS LAST, laboratory.id NULLS LAST, laboratory.date NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/