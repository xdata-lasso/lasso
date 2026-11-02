-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 't1__c6a188', '2024-06-15', '2025-06-17', '2021-11-08', 'swwqcgsk', '9n8c4pgu7v');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 't1__c6a188', '2024-06-15', '2020-12-20', '2020-09-26', 'hria2ypu', 'hsrwbbp');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 't1__c6a188', '2024-06-15', '2025-06-26', '2022-08-22', 'z0f8jegd21vy', '9uxj4hwbdvl');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483645, 't1__c6a188', '2024-06-15', '2022-09-24', '2021-04-26', 'gndqwnqc', 'x5hncprjtu0');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483644, 't1__c6a188', '2024-06-15', '2021-01-02', '2023-07-08', 'w1of77pz', '72ct');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483643, 't1__c6a188', '2024-06-15', '2020-07-27', '2020-06-04', 'mfg62', '0v');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '1994-01-01', 59, 13244799, -1659388584, 1526238907, 179.378884, 304.02808, 182.319045, -1257178728, 787.938887, 986.066566, 907682809, 2026480202, -1576219117, -1823627488, 327.753528, 218.301157, 992.733505, 162.04354, -1399556171, 741.842896, 1419861592, 663.001988, 374105386, 1274489983, -1683203397, 'e376nium52', -443340271, 757448742, -1179823637, 'rqro', 'fqyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 'oo3o9hl72kl', 'x1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 556727997);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1994-01-01', 59, -1898531797, -1748371085, -1742081330, 541.805676, 708.207154, 450.823993, -1056308489, 406.816852, 108.525871, -1454058168, -2078052421, -512640349, 1038566008, 615.222139, 203.331848, 507.498259, 34.258887, -1672720816, 92.94508, -1520489792, 346.706184, -1388029300, -566887085, 602161869, 'xa', 1294666887, -515895469, 1427161052, 'z16ni', 'jai', 'dh5ogrgj', -458359144, 600440952, 'f', 'og', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 1523825314);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2000-03-01', 59, 820970595, 1421303999, -1488156735, 67.250709, 140.053935, 225.249964, 199672698, 993.555996, 848.763933, -1962347906, -866772222, -847293924, -2033879835, 918.655561, 322.910151, 720.019292, 405.452311, -1575410149, 510.534763, -68044929, 86.288364, 1201273976, 1923659053, -1950324754, '7z2zezj', 1448731351, -604098478, 1248858185, '5', 'sxcmr0o', 'ztdgj5i3lq5l', 1339733032, -1556979799, 'k58qs27p', 'r94gth2m', 'ajjl', '3', 'okv8uttmu2', 'e578', 'fvy', -451030047);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2000-12-31', 59, -2052653308, -489120589, -72442907, 258.625847, 783.973422, 282.68858, -2060082151, 710.005534, 238.668607, 1849819405, -929383517, -2090240067, -699574669, 160.717227, 564.003268, 641.973572, 49.701386, 1105964624, 401.500141, -663234145, 31.262264, 101754718, 628082526, -1245584612, 'xfo', -1793230843, -441521858, 2015094998, '2zobb0q0k32o', 'w', 'l', 895277769, 364043263, 'sorlwyngc1', 'j', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 1557188093);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 548968280, -1552469358, 7342822, -1034034171, 789.706494, 680.281941, 174.811686, 412199481, 749.652116, 746.02004, 727608179, 456034296, -628433041, 1044710644, 725.010524, 19.988339, 301.874779, 602.319566, -1216952047, 393.386546, -2140923099, 770.531988, -841516418, 152478847, -625404808, 'um', 989306270, 1147652228, 1378873397, 'u6bd0w9603', 'vzxw1rxe9y', 'k7', -1046720861, 643589729, 'h55y', 'dohvu06d', 'a35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', -2080232972);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '1994-01-01', 60, 700293388, 906324270, 1908028688, 994.117864, 749.826493, 503.083789, -1659388584, 855.355181, 179.378884, -841692980, -1364429300, -1257178728, 1236688122, 986.066566, 666.330692, 46.9162, 776.327423, 907682809, 227.766936, 2026480202, 133.007885, -1823627488, -1209887326, -1399556171, 'a9000t5c4eci', 1149850321, -1833165707, 1155439218, 'um5', 'zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '1994-01-01', NULL, 1, 1, 1, 1.0, 1.0, 1.0, 1, 1.0, 1.0, 1, 1, 1, 1, 1.0, 1.0, 1.0, 1.0, 1, 1.0, 1, 1.0, 1, 1, 1, 'value', 1, 1, 1, 'value', 'value', 'value', 1, 1, 'value', 'value', 'value', 'value', 'value', 'value', 'value', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.SEX, T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GOT < 60 AND STRFTIME('%Y', T2.Date) = '1994';

/*
Gold Result:
('t1__c6a188', '2024-06-15')
*/

-- Prediction Query
SELECT T2.SEX, T2.Birthday FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T1.Date) = '1994' AND T1.GOT < 60;

/*
Prediction Result:
('t1__c6a188', '2024-06-15')
('t1__c6a188', '2024-06-15')
*/