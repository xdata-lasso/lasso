-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2024-06-15', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, '9rljsl0b4', '2024-04-25', '2022-09-10', '1970-01-01', 'qi2rkf9v', 'x58pz');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483647, 'f8jegd2', '2024-11-12', '2023-10-23', '2024-06-15', '9uxj4hw', 'd');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (0, 'lph2gn', '2020-08-28', '2022-11-09', '2023-11-15', 'qcx5', 'hncprjtu0dz');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483644, 'vacx7afu5', '2023-12-23', '2024-11-06', '2024-06-15', 'f77p', 'o72ctdc');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483643, 'mfg62', '2021-01-19', '2024-08-28', '2024-06-15', '5q8qdj', 'e1io');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-1, '278507cv', '2023-05-06', '2021-08-18', '2022-09-27', 'ttg6bnou5zi3', 'c4bfkfoac');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483641, 'u', '2023-03-07', '2025-01-30', '2024-06-15', 'u', 'mkrpdj');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'value', '2024-06-15', '2024-06-15', NULL, 'value', 'value');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, 'qb0tbindz39t', '2020-01-07', '2021-09-14', '2024-06-01', 'td8n5wcgu', 'bc3t');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 1644814318, 1465859724, -1349201381, 1019800248, 334.878198, 55.194297, 303.05704, -1610064545, 22.535764, 600.048938, 462974032, -1137908826, -918961358, -1602639011, 489.397796, 933.422701, 345.718563, 510.466242, 1151980946, 83.204633, 1620389964, 627.258639, 947159877, 1990080517, 1408123494, '4', 374105386, 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, 'liqa1', 'ryytoo3', '9hl7', 'A', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '2024-06-15', -1748371085, -1742081330, 894242932, -211209314, 456.127515, 52.895335, 632.477228, -1056308489, 406.816852, 108.525871, -1454058168, -2078052421, -512640349, 1038566008, 615.222139, 203.331848, 507.498259, 34.258887, -1672720816, 92.94508, -1520489792, 346.706184, -1388029300, -566887085, 602161869, 'xa', 1294666887, -515895469, 1427161052, 'z16ni', 'jai', 'dh5ogrgj', -458359144, 600440952, 'f', 'og', 'itsj3', '?', 'y', 'p1q430', 'jh3den8', 195720193);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '2024-06-15', -406331049, -461418236, -468701684, 1448731351, 523.290303, 359.347359, 790.772456, -57705450, 286.870177, 33.028254, 1721638020, 983324983, 1269522000, 853709925, 297.258735, 104.37745, 703.796681, 125.223349, -1405314653, 913.609637, 1816660482, 184.430978, -1212676731, 1692046802, -1300180872, '58q', 1817366143, 1615073310, 1055237066, 'r94gth2m', 'ajjl', '3', 1803796945, 872694102, 'tmu2n', '57', 'lfvyz7zzb', 'A', '8y', 'kv42q7', 'x58b4', -1122409769);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2024-01-06', -663234145, -2013213247, 101754718, 628082526, 648.64235, 209.98973, 903.226183, -582376271, 228.613802, 352.249155, 1719800120, -210159774, 270415200, -2071531094, 407.368744, 983.253685, 651.034963, 414.603421, 575038073, 229.650617, -613916489, 979.99406, 895277769, 364043263, -1177989415, 'wyn', 1953495465, -1960313034, 681061317, 'iz', 'k1', 'yoeyo6l0hdt6', 1435223075, 1617348603, 'yxuzk', '5', '1gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', 1044710644);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '2020-08-27', 1964331395, -1943814113, 1514371324, -379749892, 594.051247, 329.082644, 754.799388, -541917667, 433.981179, 276.103112, 2012400150, -505019168, 1968783602, 125495479, 167.639352, 878.981937, 572.830427, 702.028088, -246257698, 111.965818, -516345261, 48.647907, -1191116453, 1709667347, -1934709172, '3', 1595632888, 2072023304, 789756515, '18ri', 'hy08ftp6', 'wt', -1051623642, 2013745856, 'b', 'mzn2mfx', 'h33p6sto1', '0', 'j', 'sh5knzys7', 'y', -531932574);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE NOT T1."First Date" IS NULL AND NOT T2.SSA IN ('negative', '0') ORDER BY T1."First Date" ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT Patient.ID FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE NOT Laboratory.SSA IN ('negative', '0') ORDER BY Patient."First Date" ASC, Patient.id NULLS LAST, Laboratory.id NULLS LAST, Laboratory.date NULLS LAST LIMIT 1;

/*
Prediction Result:
(3,)
*/