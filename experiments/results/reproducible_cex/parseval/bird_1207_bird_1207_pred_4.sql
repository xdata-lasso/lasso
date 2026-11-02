-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 't1__81208d', '2024-06-15', '2025-06-17', '2021-11-08', 'swwqcgsk', '9n8c4pgu7v');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 't1__81208d', '2024-06-15', '2020-12-20', '2020-09-26', 'hria2ypu', 'hsrwbbp');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483646, 't1__81208d', '2024-06-15', '2025-06-26', '2022-08-22', 'z0f8jegd21vy', '9uxj4hwbdvl');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483645, 't1__81208d', '2024-06-15', '2024-09-24', '2022-11-12', '4301jh3den8', 'c68x8vacx7');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483644, 't1__81208d', '2024-06-15', '2020-02-05', '2021-01-02', '5w1of7', 'pzo72ctdc');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 'xuzkb52', '2024-11-18', '2021-03-16', '2023-11-09', 'las6', 'elboeowii1');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 'yp5qi2rk', '2021-01-15', '2023-10-06', '2022-12-15', 'x58pz0f8je', 'd2');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '1994-01-01', 59, 13244799, -1659388584, 1526238907, 179.378884, 304.02808, 182.319045, -1257178728, 787.938887, 986.066566, 907682809, 2026480202, -1576219117, -1823627488, 327.753528, 218.301157, 992.733505, 162.04354, -1399556171, 741.842896, 1419861592, 663.001988, 374105386, 1274489983, -1683203397, 'e376nium52', -443340271, 757448742, -1179823637, 'rqro', 'fqyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 'oo3o9hl72kl', 'x1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 556727997);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '1994-01-01', 59, 2103044118, -1642259219, 1298861365, 58.749749, 958.414393, 345.35543, -1070063173, 629.317167, 668.309685, 580968159, -1245312912, 1575412235, -988981234, 304.188492, 415.830002, 395.809081, 552.472052, 401805964, 154.065416, -1255130038, 89.552801, 806170397, 513454646, -688216274, 'gcb98ozk3z', 1686459626, -1554531873, 982314585, 'kn6vc', '6ah', 'f8jswwl', 1255343543, -541746689, '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', -598313376);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2000-03-01', 59, 1303877941, -1284905200, 7929158, 93.813527, 935.463334, 492.883123, 820970595, 537.702873, 830.92312, -1488156735, -1858644047, -1180042408, 199672698, 993.555996, 848.763933, 520.999811, 43.10527, -866772222, 244.215606, -847293924, 511.172331, -2033879835, 1798111945, 944975670, 'i36c4bf', -1173368267, 382831862, -406331049, 'ezjo7wg', 'd5ysxc', 'r0oz', -870767087, -1699185893, '5i3lq5lnpim5', '58q', 's27p2r94gth2', 'najj', 'a3o', 'v8u', 'tmu2n', -1817527403);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '1900-12-28', 59, -1402164108, 2123471885, -526633767, 823.908713, 604.525889, 391.037879, 458835042, 70.267562, 715.296942, -705922211, 1043710187, 318331233, -233617564, 574.707916, 518.470483, 904.091882, 927.310086, 756202403, 762.654945, 782684333, 476.006677, 681598285, 319284352, 1164790775, 'auvmkrpd', -609553675, 989018473, -55494714, 'n9', 'o705', 'a9n0jxfofws', 1719800120, -210159774, 'obb0q0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', -795975227);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', -457369423, 1557188093, 548968280, -1552469358, 515.131026, 501.709636, 259.245161, 1244279905, 680.281941, 174.811686, 412199481, 727608179, 456034296, -628433041, 555.75468, 743.240647, 725.010524, 19.988339, -850941333, 602.319566, -1216952047, 393.386546, -2140923099, -841516418, 152478847, '5wcgumbc3td', 1964331395, -1943814113, 1514371324, '603vzxw1r', 'e9yfk7', 'k162n', -516345261, -1191116453, 'u06dza', '5rmkio18', 'i2hy0', '8ftp6ewtqx', 'njabym', 'n2mfx7h', '3p6sto1c', 170892881);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '1994-01-01', 60, 700293388, 906324270, 1908028688, 994.117864, 749.826493, 503.083789, -1659388584, 855.355181, 179.378884, -841692980, -1364429300, -1257178728, 1236688122, 986.066566, 666.330692, 46.9162, 776.327423, 907682809, 227.766936, 2026480202, 133.007885, -1823627488, -1209887326, -1399556171, 'a9000t5c4eci', 1149850321, -1833165707, 1155439218, 'um5', 'zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '2088-06-30', 60, 1675430660, -688509700, -792092619, 585.18838, 152.494591, 124.573829, -2050247126, 328.40866, 989.653112, -1642259219, 1298861365, 1968874827, -664193365, 250.856497, 629.317167, 668.309685, 635.267184, -1245312912, 866.804244, -988981234, 304.188492, -361507387, 401805964, -1485777725, '8n2f3', 806170397, 513454646, -688216274, 'gcb98ozk3z', 'i', 'yrk', 32204797, -1672720816, '8j', 'wwlq7', 'xb72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', '8', -458359144);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.SEX, T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GOT < 60 AND STRFTIME('%Y', T2.Date) = '1994';

/*
Gold Result:
('t1__81208d', '2024-06-15')
*/

-- Prediction Query
SELECT patient.sex, patient.birthday FROM patient INNER JOIN laboratory ON patient.id = laboratory.id WHERE STRFTIME('%Y', laboratory.date) = '1994' AND laboratory.got < 60;

/*
Prediction Result:
('t1__81208d', '2024-06-15')
('t1__81208d', '2024-06-15')
*/