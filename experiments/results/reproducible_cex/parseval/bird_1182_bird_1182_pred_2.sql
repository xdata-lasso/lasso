-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '1991-06-13', '8c4pgu7vfe', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'au2dwyrq13', '2022-09-28', '2024-03-19', '1991-06-13', '78d99r', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'jsl', '2024-09-13', '2020-04-20', '2025-04-09', 'p5qi2rk', '9v');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (7, '5k5swwqcgs', '2021-12-04', '2022-04-27', '1991-06-13', '8c4pgu7vfe', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, 'hria2ypu', '2024-06-23', '2021-03-30', '1991-06-13', 'rwbbp', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, '5k5swwqcgs', '2021-12-04', '2022-04-27', '1991-06-13', '8c4pgu7vfe', 't1__7f8af6');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (6, 'au2dwyrq13', '2022-09-28', '2024-03-19', '1991-06-13', '78d99r', 't1__7f8af6');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1995-01-01', -1633151678, -252690330, 1115440883, 1644814318, 841.297061, 294.861575, 268.234631, -1349201381, 737.440743, 334.878198, -1910425938, -845863578, -1610064545, 429706943, 240.969194, 267.815776, 192.379301, 607.794538, -1137908826, 619.836822, -918961358, 126.856521, -45536098, 1861536320, 44952191, 'fa9', 1620389964, 546571701, 947159877, '5c4ec', 'gce', '76nium52', -443340271, 757448742, '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -453362185);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '1995-01-01', 556727997, 1178000634, 1836127587, -1529584866, 755.698226, 778.537349, 712.084197, -283454505, 390.34832, 585.585659, 233994589, 1442655647, -87647544, -629784617, 50.647649, 185.427628, 243.480613, 868.276627, -261132974, 795.815869, -1264842910, 893.16532, -1052964641, -1245682094, -1660358170, 'p', -988981234, -841004020, -361507387, '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 638024588, -688098735, '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 1583472758);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1900-03-01', 1449284300, -977470238, -1478247928, 1074760385, 763.019095, 308.482994, 430.111467, 1250290042, 100.07927, 105.078878, 710458518, 678047687, -1478134144, -491938169, 239.245131, 422.041684, 255.41493, 912.234758, -106471771, 787.642728, 1923912467, 571.595144, 518609210, 1948383687, 1476361420, '8c68', -683007527, 2035306060, 1523825314, 'u5', '1of77p', 'o72ctdc', 1303877941, -1284905200, '62', '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', -406331049);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', -461418236, -468701684, 1448731351, -604098478, 790.772456, 50.798088, 486.564401, -915385605, 33.028254, 914.215057, 1721638020, 983324983, 1269522000, 853709925, 297.258735, 104.37745, 703.796681, 125.223349, -1405314653, 913.609637, 1816660482, 184.430978, -1212676731, 1692046802, -1300180872, '58q', 1817366143, 1615073310, 1055237066, 'r94gth2m', 'ajjl', '3', 1803796945, 872694102, 'tmu2n', '57', 'lfvyz7zzb', '8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 609771851);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '1995-01-01', 13244799, -1659388584, 1526238907, -1377057208, 304.02808, 182.319045, 998.421621, -1257178728, 787.938887, 986.066566, 907682809, 2026480202, -1576219117, -1823627488, 327.753528, 218.301157, 992.733505, 162.04354, -1399556171, 741.842896, 1419861592, 663.001988, 374105386, 1274489983, -1683203397, 'e376nium52', -443340271, 757448742, -1179823637, 'rqro', 'fqyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 'oo3o9hl72kl', 'x1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 556727997);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '1995-01-02', 1178000634, 1836127587, -1529584866, 1196308825, 712.084197, 452.27611, 434.003102, 233994589, 367.405851, 835.894437, -87647544, -629784617, -1929953647, 1581736075, 439.200238, 795.815869, 205.505811, 893.16532, -1052964641, 209.967034, -1660358170, 41.944398, -1106350634, -1509264256, -792947627, 'z', -1748371085, -1742081330, 894242932, 'f3dqv0gc', '9', 'ozk3zbily', 638024588, -688098735, '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 1583472758);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '1995-01-01', -1633151678, -252690330, 1115440883, 1644814318, 841.297061, 294.861575, 268.234631, -1349201381, 737.440743, 334.878198, -1910425938, -845863578, -1610064545, 429706943, 240.969194, 267.815776, 192.379301, 607.794538, -1137908826, 619.836822, -918961358, 126.856521, -45536098, 1861536320, 44952191, 'fa9', 1620389964, 546571701, 947159877, '5c4ec', 'gce', '76nium52', -443340271, 757448742, '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -453362185);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (6, '2004-03-01', -1362461264, -904834265, -346339240, 1692174491, 495.297639, 261.217059, 447.109657, 2056419640, 551.785129, 263.638479, 556727997, 1178000634, 1836127587, -1529584866, 755.698226, 778.537349, 712.084197, 452.27611, -283454505, 390.34832, 233994589, 367.405851, 1442655647, -87647544, -629784617, 'v', 1581736075, -261132974, -1264842910, 'wnqcx', '5hncprjtu0d', '79fjgq8', -1255130038, -1762857309, 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 1746373317);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM Laboratory WHERE ID = (SELECT ID FROM Patient WHERE "First Date" = '1991-06-13' AND Diagnosis = 'SJS') AND STRFTIME('%Y', Date) = '1995';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T2.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1."First Date" = '1991-06-13' AND T1.Diagnosis = 'SJS' AND STRFTIME('%Y', T2.Date) = '1995';

/*
Prediction Result:
(3,)
*/