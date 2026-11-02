-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2024-06-15', '2021-12-04', '2024-06-15', '9n8c4pgu7v', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483647, 'au2dwyrq13', '2024-06-15', '2022-09-28', '2024-06-15', 'u78d99r', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (0, 'jsl', '2024-06-15', '2024-09-13', '2024-06-15', '4', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-1, 'p5qi2rk', '2021-01-15', '2023-10-06', '2022-12-15', 'x58pz0f8je', 'd2');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'value', NULL, '2024-06-15', '2024-06-15', 'value', 'value');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'value', NULL, '2024-06-15', '2024-06-15', 'value', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, 'value', NULL, '2024-06-15', '2024-06-15', 'value', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 'value', NULL, '2024-06-15', '2024-06-15', 'value', 'SJS');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', -1865039888, 1160656988, -992890117, 1914020640, 795.366812, 378.476082, 783.93201, -1670923962, 663.049759, 711.020062, 1908028688, 2122220075, 1072996612, 13244799, 320.851235, 113.643485, 855.355181, 179.378884, -841692980, 182.319045, -1257178728, 787.938887, 2087640001, 907682809, 2026480202, 'ie5', -1209887326, -1399556171, 1038707349, '9000t5c4ec', 'gce', '76nium52', -443340271, 757448742, '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -453362185);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '2024-06-15', 1675430660, -688509700, -792092619, -1492524358, 124.573829, 22.63964, 328.40866, 2103044118, 705.754562, 117.631729, 1298861365, 1968874827, -664193365, -1070063173, 629.317167, 668.309685, 635.267184, 210.05299, 1575412235, 269.734861, -841004020, 415.830002, 401805964, -1485777725, -1255130038, '3d', 513454646, -688216274, 331812443, 'cb98ozk3zbil', 'yrkn6vck6ah0', '8j', -932772113, -639539893, '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', -946046410);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '2024-06-15', -902895762, -197933860, 2111987706, -598313376, 959.196496, 917.425128, 632.340892, 804529642, 457.141778, 410.094566, -1538707438, -163600466, -1826414375, 357330522, 565.286158, 729.327198, 973.224853, 369.474112, -683007527, 757.137864, 2035306060, 735.057703, 1523825314, 2078438287, -47052816, '1of77pzo72c', -820614248, 481546706, -1784554553, '2g0v5q8qd', 'jpe1io22785', '7cvtjpt', 453836040, 1467355421, 'ou5z', '36c', 'bfkfoacd', '7z2zezj', '7wgx', '5', 'sxcmr0o', 853709925);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2023-05-02', -1935752926, -20116244, -176606723, -15162884, 811.930904, 236.262879, 137.487391, -55240145, 821.273487, 545.449043, 1817366143, 1615073310, 1055237066, 988954859, 99.674786, 796.553419, 577.602934, 193.695314, 1162591638, 625.532672, -2136247961, 155.873695, -2096405521, 1803796945, 872694102, 'tmu2n', -1817527403, -1402164108, 2123471885, 'yz7zzbe8yvk', 'v42q7sx58b4p', 'aus3', -2090240067, -699574669, 'rpd', 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', -613916489);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2025-06-17', -1437333179, -921145356, 1258409369, -1981402255, 292.730571, 572.766956, 206.939346, 1610062532, 475.173408, 935.695299, 809183447, 89267185, -1865039888, 1160656988, 268.82475, 710.998147, 945.642658, 795.366812, 1219478689, 718.397869, -1670923962, 663.049759, 906324270, 1908028688, 2122220075, 'p6luhvdlttil', 429706943, 462974032, -1137908826, 'siie5unw6k', 'fa9', '00t5c4e', 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -453362185);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '2020-03-04', 2123196517, 364869063, -953437896, -1097120355, 326.912005, 798.947629, 49.538289, 244829661, 182.777264, 943.791649, -904834265, -346339240, 1692174491, -1025564911, 447.109657, 164.583726, 978.797504, 551.785129, 556727997, 860.770887, 1178000634, 541.393553, 1836127587, -1529584866, 1196308825, 'd21vy9uxj4hw', -2050247126, -736979194, 2103044118, 'h2gndqwnqcx5', 'hncprjtu0dz', '9fjgq8n2f', -1056308489, -1454058168, 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', -458359144);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '2024-10-27', 1568069663, -1794176801, -1194675273, -946046410, 630.468925, 309.988616, 846.657221, -902895762, 453.914926, 991.735454, -598313376, 1972233925, 1792827279, 804529642, 457.141778, 410.094566, 426.421073, 617.644523, -1538707438, 774.445116, -163600466, 881.248682, -1826414375, 357330522, -683007527, 'x', -1762140823, 1371234901, -290314193, 'f77pzo72ctd', 't', 'mfg62g0v5q8q', -1488156735, -1858644047, 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', -405743609);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Date, STRFTIME('%Y', T2."First Date") - STRFTIME('%Y', T2.Birthday) FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T2.Diagnosis = 'SJS' AND NOT T2.Birthday IS NULL ORDER BY T2.Birthday ASC, T1.id NULLS LAST, T1.date NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('2024-06-15', 0)
*/

-- Prediction Query
SELECT t2.date, STRFTIME('%Y', t1."First Date") - STRFTIME('%Y', t1.birthday) AS age FROM patient AS t1 INNER JOIN laboratory AS t2 ON t1.id = t2.id WHERE t1.diagnosis = 'SJS' ORDER BY t1.birthday ASC, t1.id NULLS LAST, t2.id NULLS LAST, t2.date NULLS LAST LIMIT 1;

/*
Prediction Result:
('2025-06-17', None)
*/