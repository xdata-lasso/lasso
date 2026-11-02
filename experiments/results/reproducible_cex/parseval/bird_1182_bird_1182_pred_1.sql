-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '1991-06-13', '8c4pgu7vfe', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, '1afgogritsj', '2025-02-02', '2020-03-04', '1991-06-13', 'xp1q430', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'rhizgk1yoey', '2022-07-24', '2025-10-08', '1991-06-13', 'l0hdt6fuqyx', 'SJS');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1995-01-01', -1633151678, -252690330, 1115440883, 1644814318, 841.297061, 294.861575, 268.234631, -1349201381, 737.440743, 334.878198, -1910425938, -845863578, -1610064545, 429706943, 240.969194, 267.815776, 192.379301, 607.794538, -1137908826, 619.836822, -918961358, 126.856521, -45536098, 1861536320, 44952191, 'fa9', 1620389964, 546571701, 947159877, '5c4ec', 'gce', '76nium52', -443340271, 757448742, '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -453362185);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2084-12-31', 481163439, 2123196517, 364869063, -953437896, 433.533777, 458.991081, 244.556758, 244829661, 182.777264, 943.791649, -904834265, -346339240, 1692174491, -1025564911, 447.109657, 164.583726, 978.797504, 551.785129, 556727997, 860.770887, 1178000634, 541.393553, 1836127587, -1529584866, 1196308825, 'd21vy9uxj4hw', -2050247126, -736979194, 2103044118, 'h2gndqwnqcx5', 'hncprjtu0dz', '9fjgq8n2f', -1056308489, -1454058168, 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', -458359144);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '1995-01-01', 518609210, 1948383687, 1476361420, 195720193, 897.348977, 764.833588, 913.061904, 1732258051, 516.027628, 8.577518, -1762140823, 1371234901, -290314193, 76996700, 398.637058, 689.065203, 702.882704, 451.225704, 1992637800, 308.935851, 481546706, 84.501014, -242584410, -698610044, -1021978385, 'jpe1io22785', 2119806856, -1962347906, -866772222, 'ttg6', 'n', 'u5zi', 1944978593, 1722106924, 'f', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5', '3lq', 1816660482);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2022-01-25', 1339733032, -1556979799, -55240145, 1379859112, 545.449043, 975.929586, 923.138524, 1615073310, 628.658254, 745.691525, 988954859, -1719383707, 1273687251, 333302050, 193.695314, 770.686956, 625.532672, 822.122444, -2136247961, 155.873695, -2096405521, 588.850908, 1803796945, 872694102, 618058035, '2ne578', 1908593332, 697257217, -451030047, 'be8yvkv42q7', 'x58b4', 'pmaus3auvmkr', 609771851, -1934017803, 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', 211603887);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '1995-01-01', -1418927432, -30041412, -277407746, -670154354, 176.569118, 1.63343, 509.069144, 469838697, 668.530896, 841.944569, 1048147204, -1814875250, -647898186, -1610380698, 393.510383, 862.561101, 627.816635, 138.537557, 7342822, 259.245161, 1244279905, 680.281941, -1396673167, 412199481, 727608179, 'awg96aqb0tbi', 503053726, -1897615568, 2085299664, 'j', '9td8n5w', 'g', -794767771, 989306270, 'tdu6bd0w96', '3vzxw1r', 'e9yfk7', 'k162n', '55', '3dohvu0', 'dza35rmki', -1160642134);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2025-12-31', 769234989, 168442149, 1299171592, 2066302536, 505.600334, 349.371383, 255.149792, 2013745856, 2.747847, 713.589996, -1312038093, 687330820, -224390110, -1810873111, 522.859968, 789.571919, 463.637542, 753.382585, 1220047834, 717.320553, 63063873, 303.704524, -285085577, 170892881, -1643065004, 'nzy', 1487347213, 1328948152, -1923069176, 'jmgjach8qt', 'a8y3a17v4yg', 'mayq3qdpua', 1291298007, 1982265552, 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', 'lc', 'qb9i9f', 'ccukjq1q', -796609690);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM Laboratory WHERE ID = (SELECT ID FROM Patient WHERE "First Date" = '1991-06-13' AND Diagnosis = 'SJS') AND STRFTIME('%Y', Date) = '1995';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(Laboratory.ID) FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient."First Date" = '1991-06-13' AND Patient.Diagnosis = 'SJS' AND Laboratory.Date LIKE '1995%';

/*
Prediction Result:
(3,)
*/