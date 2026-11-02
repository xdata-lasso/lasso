-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 'p_s_ef32f3', '2024-06-15', '2025-06-17', '2021-11-08', 'swwqcgsk', '9n8c4pgu7v');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'p_s_ef32f3', '2024-06-15', '2020-03-04', '2023-07-07', '2dwyrq13pyu7', 'd99rljsl0');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483647, 'p_s_ef32f3', '2024-06-15', '2020-04-20', '2025-04-09', 'p5qi2rk', '9v');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'rg', '2021-09-30', '2020-08-13', '2024-05-09', 't1afgog', 'itsj3');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 'yp5qi2rk', '2021-01-15', '2023-10-06', '2022-12-15', 'x58pz0f8je', 'd2');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (6, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1994-01-01', 59, -1865039888, 1160656988, -992890117, 710.998147, 945.642658, 795.366812, 1219478689, 718.397869, 324.940703, -1670923962, 700293388, 906324270, 1908028688, 994.117864, 749.826493, 503.083789, 320.851235, -1659388584, 855.355181, -1377057208, 304.02808, -1364429300, -1257178728, 1236688122, 'dpos', -1576219117, -1823627488, -1209887326, 'klfa9000t', 'c4ecigce', '76nium52', -443340271, 757448742, '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -453362185);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '1994-01-01', 59, 556727997, 1178000634, 1836127587, 410.133844, 88.474525, 704.657819, -1529584866, 755.698226, 778.537349, 910894705, -283454505, 233994589, 1442655647, 479.592965, 353.366837, 50.647649, 185.427628, 1581736075, 439.200238, -1264842910, 893.16532, -1052964641, -1245682094, -1660358170, 'p', -988981234, -841004020, -361507387, '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 638024588, -688098735, '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 1583472758);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '1994-01-01', 59, -491938169, -106471771, 1235416111, 947.945777, 571.595144, 620.748111, 1948383687, 57.52658, 843.742177, 195720193, 1774087382, 1732258051, -1762140823, 819.265503, 354.593207, 432.405958, 850.85096, 76996700, 398.637058, 1992637800, 308.935851, 481546706, -1784554553, -242584410, 'v5q8qdj', -1139855872, -288338724, 1897687032, '278507cv', 'jpttg', 'bnou5zi36', 1944978593, 1722106924, 'f', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5', '3lq', 1816660482);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2000-03-01', 59, -1212676731, 1692046802, -1300180872, 167.377262, 492.8451, 251.966916, -1125548818, 848.622384, 555.274052, -95808609, -244633520, 418247369, -1524425594, 185.260952, 462.366429, 946.809703, 904.028668, -1428186898, 543.846419, -761353513, 584.372269, -1311735207, -229022515, -1817527403, '78lfvyz7zz', -2052653308, -489120589, -72442907, '7sx58', 'b4pmaus3auv', 'krpd', -609553675, 989018473, 'chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', 211603887);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', -413043724, 761519897, 1504707292, 955267863, 230.654784, 845.392744, 619.529525, 718167481, 832.527521, 124.067083, 1435223075, 1617348603, -477129795, -1418927432, 904.57762, 769.556907, 593.9327, 493.005436, -277407746, 343.967529, -2140468103, 509.069144, 469838697, 1468640756, 1048147204, 'eowi', -1610380698, -457369423, 1557188093, 'xih662q2xly', 'otow9oaawg', '6aqb0tbin', -1897615568, 2085299664, 'j', '9td8n5w', 'g', 'mbc3td', 'u6bd0w9603', 'vzxw1rxe9y', 'k7', -1046720861);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '1994-01-01', 60, 700293388, 906324270, 1908028688, 994.117864, 749.826493, 503.083789, -1659388584, 855.355181, 179.378884, -841692980, -1364429300, -1257178728, 1236688122, 986.066566, 666.330692, 46.9162, 776.327423, 907682809, 227.766936, 2026480202, 133.007885, -1823627488, -1209887326, -1399556171, 'a9000t5c4eci', 1149850321, -1833165707, 1155439218, 'um5', 'zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '2000-03-01', 60, 1675430660, -688509700, -792092619, 585.18838, 152.494591, 124.573829, -2050247126, 328.40866, 989.653112, -1642259219, 1298861365, 1968874827, -664193365, 250.856497, 629.317167, 668.309685, 635.267184, -1245312912, 866.804244, -988981234, 304.188492, -361507387, 401805964, -1485777725, '8n2f3', 806170397, 513454646, -688216274, 'gcb98ozk3z', 'i', 'yrk', 32204797, -1672720816, '8j', 'wwlq7', 'xb72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', '8', -458359144);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (6, '1994-01-01', NULL, 1, 1, 1, 1.0, 1.0, 1.0, 1, 1.0, 1.0, 1, 1, 1, 1, 1.0, 1.0, 1.0, 1.0, 1, 1.0, 1, 1.0, 1, 1, 1, 'value', 1, 1, 1, 'value', 'value', 'value', 1, 1, 'value', 'value', 'value', 'value', 'value', 'value', 'value', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.SEX, T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GOT < 60 AND STRFTIME('%Y', T2.Date) = '1994';

/*
Gold Result:
('p_s_ef32f3', '2024-06-15')
('rg', '2021-09-30')
*/

-- Prediction Query
SELECT P.SEX, P.Birthday FROM Laboratory AS LAB INNER JOIN Patient AS P ON LAB.ID = P.ID WHERE LAB.GOT < 60 AND STRFTIME('%Y', LAB.Date) = '1994';

/*
Prediction Result:
('p_s_ef32f3', '2024-06-15')
('p_s_ef32f3', '2024-06-15')
('rg', '2021-09-30')
*/