-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 't1__0dc0db', '2024-06-15', '2025-06-17', '2021-11-08', 'swwqcgsk', '9n8c4pgu7v');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483648, 't1__0dc0db', '2024-06-15', '2020-12-20', '2020-09-26', 'hria2ypu', 'hsrwbbp');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 't1__0dc0db', '2024-06-15', '2025-06-26', '2022-08-22', 'z0f8jegd21vy', '9uxj4hwbdvl');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 't1__0dc0db', '2024-06-15', '2022-09-24', '2021-04-26', 'gndqwnqc', 'x5hncprjtu0');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483644, 't1__0dc0db', '2024-06-15', '2021-01-02', '2023-07-08', 'w1of77pz', '72ct');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483643, 't1__0dc0db', '2024-06-15', '2020-07-27', '2020-06-04', 'mfg62', '0v');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483642, 't1__0dc0db', '2024-06-15', '2025-07-11', '2022-10-24', 'qdjpe1io2', '78507cvt');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483641, 't1__0dc0db', '2024-06-15', '2021-08-18', '2022-09-27', 'ttg6bnou5zi3', 'c4bfkfoac');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483640, 't1__0dc0db', '2024-06-15', '2020-09-06', '2024-08-20', '7z2zezjo7wg', 'd5ysxc');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1994-01-01', 59, 13244799, -1659388584, 1526238907, 179.378884, 304.02808, 182.319045, -1257178728, 787.938887, 986.066566, 907682809, 2026480202, -1576219117, -1823627488, 327.753528, 218.301157, 992.733505, 162.04354, -1399556171, 741.842896, 1419861592, 663.001988, 374105386, 1274489983, -1683203397, 'e376nium52', -443340271, 757448742, -1179823637, 'rqro', 'fqyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 'oo3o9hl72kl', 'x1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 556727997);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '1994-01-01', 59, -1898531797, -1748371085, -1742081330, 541.805676, 708.207154, 450.823993, -1056308489, 406.816852, 108.525871, -1454058168, -2078052421, -512640349, 1038566008, 615.222139, 203.331848, 507.498259, 34.258887, -1672720816, 92.94508, -1520489792, 346.706184, -1388029300, -566887085, 602161869, 'xa', 1294666887, -515895469, 1427161052, 'z16ni', 'jai', 'dh5ogrgj', -458359144, 600440952, 'f', 'og', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 1523825314);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2000-03-01', 59, -405743609, -1935752926, -20116244, 458.880538, 264.110281, 691.015295, -15162884, 811.930904, 236.262879, -1556979799, -55240145, 1379859112, 195202164, 975.929586, 923.138524, 876.038555, 628.658254, 1055237066, 452.630377, 988954859, 99.674786, 1273687251, 333302050, 1162591638, 'ajjla3okv8u', 618058035, 1553368934, -1252009958, '78lfvyz7', 'zzbe8yvkv4', 'q7sx58b4', -1122409769, 1849819405, 'us3auvmkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 709097796);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', -984562992, -605061107, -1689155697, -323362455, 605.551549, 821.485286, 549.267866, -413043724, 677.305163, 850.341964, 955267863, -1156828895, 1483450542, 513375398, 514.470353, 667.211392, 832.527521, 124.067083, 1435223075, 876.568312, -477129795, 789.60677, -1418927432, -30041412, -277407746, 'nlas6e', 1468640756, 1048147204, -1814875250, 'ii1z5n', 'xih662q2xly', 'otow9oaawg', 1044710644, 966412849, '0', 'bindz', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', -516345261);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '1994-01-01', 60, 700293388, 906324270, 1908028688, 994.117864, 749.826493, 503.083789, -1659388584, 855.355181, 179.378884, -841692980, -1364429300, -1257178728, 1236688122, 986.066566, 666.330692, 46.9162, 776.327423, 907682809, 227.766936, 2026480202, 133.007885, -1823627488, -1209887326, -1399556171, 'a9000t5c4eci', 1149850321, -1833165707, 1155439218, 'um5', 'zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.SEX, T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GOT < 60 AND STRFTIME('%Y', T2.Date) = '1994';

/*
Gold Result:
('t1__0dc0db', '2024-06-15')
*/

-- Prediction Query
SELECT Patient.ID, Patient.SEX, Patient.Birthday FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.GOT < 60 AND STRFTIME('%Y', Laboratory.Date) = '1994';

/*
Prediction Result:
(1, 't1__0dc0db', '2024-06-15')
(2, 't1__0dc0db', '2024-06-15')
*/