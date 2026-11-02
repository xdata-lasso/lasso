-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2024-06-15', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483647, 'yp5qi2rk', '2021-01-15', '2023-10-06', '2024-06-15', 'x58pz', 'f8jegd2');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'vy9uxj4', '2021-05-25', '2023-12-18', '2024-06-15', 'd', 'lph2gn');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483646, 'q', '2023-11-15', '2022-05-10', '2024-06-15', 'cx5hn', 'p');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'jtu0d', '2024-06-09', '2025-11-06', '2021-01-15', 'gq8', 'n2f3dqv0gcb9');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483643, 'u5', '2023-12-23', '2024-11-06', '2024-06-15', 'f77p', 'o72ctdc');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483642, 'mfg62', '2021-01-19', '2024-08-28', '2024-06-15', '5q8qdj', 'e1io');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483641, '278507cv', '2023-05-06', '2021-08-18', '2024-06-15', 'ttg6', 'n');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, 'u5zi', '2025-03-18', '2025-09-22', '2024-06-15', '4', 'f');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 'foa', '2020-07-07', '2020-09-06', '2024-06-15', '7z2zezj', '7wgx');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 1644814318, 1465859724, 499, -1349201381, 737.440743, 334.878198, 55.194297, -845863578, 125.12763, 22.535764, 429706943, 462974032, -1137908826, -918961358, 126.856521, 489.397796, 933.422701, 345.718563, 44952191, 768.216462, 1620389964, 627.258639, 947159877, 1990080517, 1408123494, '4', 374105386, 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, 'liqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2024-06-15', 172461907, 1606439408, 499, 1443629118, 463.845085, 892.659478, 138.057338, 982314585, 279.382219, 170.168747, 638024588, -688098735, 1784916884, 37673509, 591.134092, 694.345982, 418.948509, 532.326819, -932772113, 351.095514, 1255343543, 21.129657, -541746689, 1294666887, -515895469, 'r', 777149609, 61479715, -1496556994, 'i', 'dh5ogrgj', '8', -458359144, 600440952, 'f', 'og', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 1523825314);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '2020-07-27', 1999335832, -526612570, 499, -546516406, 187.71278, 789.269201, 270.418605, -405743609, 49.297401, 145.027285, -20116244, -176606723, -15162884, 1339733032, 236.262879, 137.487391, 487.138399, 821.273487, 195202164, 975.929586, 1817366143, 876.038555, 1055237066, 988954859, -1719383707, '2m', 418247369, -1524425594, -1351793914, 'okv8uttm', '2ne578', 'fvy', -451030047, -2052653308, 'yvkv42q7s', '58b4pm', 'u', '3auvm', 'rpd', 'wzw', 'chn9mo70', 628082526);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-05-10', -1514700303, -1796351243, 499, -1793230843, 296.34381, 397.200175, 969.175862, 1010672881, 399.489794, 221.079558, -2019656607, 375841374, -1449226553, -225238282, 57.929422, 38.169466, 179.038075, 496.273108, 440115543, 622.950834, 292557306, 665.099697, -984562992, -605061107, -1689155697, 'dj9erhi', 1056589776, -499913447, -360096930, 't', 'fuqyxuzkb', '521gwnlas6e', 1468640756, 1048147204, 'eowi', '1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', 2085299664);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '2020-01-07', 1376887048, 261633665, 499, 748154000, 767.502854, 36.996954, 314.953709, 989306270, 853.967947, 590.777158, 1147652228, 1378873397, 1964331395, -1943814113, 790.320515, 852.592046, 843.769504, 998.234157, -379749892, 594.051247, -541917667, 433.981179, -961629819, 2012400150, -505019168, '7qk', 643589729, -1231488097, 956819642, '5y3dohvu06d', 'a35rmki', '18ri', 1510892261, 1677948887, 'y08ftp6ewt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', 973811121);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1."First Date" FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.LDH < 500 ORDER BY T2.LDH DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
('2024-06-15',)
*/

-- Prediction Query
SELECT MIN("First Date") FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE LDH < 500 ORDER BY LDH DESC, Patient.id NULLS LAST, Laboratory.id NULLS LAST, Laboratory.date NULLS LAST LIMIT 1;

/*
Prediction Result:
('2021-01-15',)
*/