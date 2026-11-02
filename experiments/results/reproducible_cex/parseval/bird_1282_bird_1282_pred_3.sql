-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2024-06-15', '2021-12-04', '2022-04-27', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483647, 'yp5qi2rk', '2024-06-15', '2021-01-15', '2023-10-06', 'x58pz', 'f8jegd2');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-1, 'vy9uxj4', '2024-06-15', '2021-05-25', '2023-12-18', 'd', 'lph2gn');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'q', '2024-06-15', '2023-11-15', '2022-05-10', 'cx5hn', 'p');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'jtu0d', '2024-06-09', '2025-11-06', '2021-01-15', 'gq8', 'n2f3dqv0gcb9');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (0, '7p2r94gt', '2024-06-15', '2021-04-23', '2024-12-19', 'najj', 'a3o');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 'yp5qi2rk', '2021-01-15', '2023-10-06', '2022-12-15', 'x58pz0f8je', 'd2');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (6, 'value', NULL, '2024-06-15', '2024-06-15', 'value', 'value');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 1644814318, 59, 1465859724, -1349201381, 737.440743, 334.878198, 55.194297, -845863578, 125.12763, 22.535764, 429706943, 462974032, -1137908826, -918961358, 126.856521, 489.397796, 933.422701, 345.718563, 44952191, 768.216462, 1620389964, 627.258639, 947159877, 1990080517, 1408123494, '4', 374105386, 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, 'liqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '1969-12-31', 172461907, 59, 1606439408, 1443629118, 463.845085, 892.659478, 138.057338, 982314585, 279.382219, 170.168747, 638024588, -688098735, 1784916884, 37673509, 591.134092, 694.345982, 418.948509, 532.326819, -932772113, 351.095514, 1255343543, 21.129657, -541746689, 1294666887, -515895469, 'r', 777149609, 61479715, -1496556994, 'i', 'dh5ogrgj', '8', -458359144, 600440952, 'f', 'og', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 1523825314);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '1970-01-01', 2078438287, 59, -47052816, 645287482, 222.511261, 678.284012, 528.552305, -1099855564, 224.624401, 985.639995, 87529806, -1957268147, -1928431425, 1303877941, 695.452114, 200.834692, 102.360106, 501.846153, -1744557630, 935.463334, 820970595, 537.702873, 1421303999, -1488156735, -1858644047, 'o22', 2004147439, -691774480, -1523347137, 'ttg6bnou5zi3', 'c4bfkfoac', '0', 76987628, -253138337, 'zj', '7wgx', '5', 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 1817366143);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '1970-01-02', -1428186898, 59, -761353513, 362376128, 585.201826, 932.839964, 727.443156, -1311735207, 774.197346, 446.676539, -1817527403, -1402164108, 2123471885, -526633767, 823.908713, 604.525889, 391.037879, 920.405654, 458835042, 70.267562, 924693315, 335.639672, 1043710187, 318331233, -233617564, '7sx58b4pma', -929383517, -2090240067, -699574669, 'rpd', 'wzw', 'chn9mo70', 628082526, -1245584612, 'xfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 1483450542);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '2023-01-03', 906324270, 60, 1908028688, 2122220075, 749.826493, 503.083789, 320.851235, -1659388584, 855.355181, 179.378884, -841692980, -1364429300, -1257178728, 1236688122, 986.066566, 666.330692, 46.9162, 776.327423, 907682809, 227.766936, 2026480202, 133.007885, -1823627488, -1209887326, -1399556171, 'a9000t5c4eci', 1149850321, -1833165707, 1155439218, 'um5', 'zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '2024-11-12', 1, NULL, 1, 1, 1.0, 1.0, 1.0, 1, 1.0, 1.0, 1, 1, 1, 1, 1.0, 1.0, 1.0, 1.0, 1, 1.0, 1, 1.0, 1, 1, 1, 'value', 1, 1, 1, 'value', 'value', 'value', 1, 1, 'value', 'value', 'value', 'value', 'value', 'value', 'value', 1);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (6, '2025-06-17', -1437333179, 59, -921145356, 1258409369, 38.668834, 292.730571, 572.766956, 1610062532, 475.173408, 935.695299, 809183447, 89267185, -1865039888, 1160656988, 268.82475, 710.998147, 945.642658, 795.366812, 1219478689, 718.397869, -1670923962, 663.049759, 906324270, 1908028688, 2122220075, 'p6luhvdlttil', 429706943, 462974032, -1137908826, 'siie5unw6k', 'fa9', '00t5c4e', 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -453362185);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GPT < 60 ORDER BY T2.GPT DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 3;

/*
Gold Result:
('2024-06-15',)
('2024-06-09',)
('2024-06-09',)
*/

-- Prediction Query
SELECT DISTINCT patient.birthday FROM laboratory INNER JOIN patient ON laboratory.id = patient.id WHERE laboratory.gpt < 60 ORDER BY laboratory.gpt DESC, patient.birthday NULLS LAST LIMIT 3;

/*
Prediction Result:
('2024-06-09',)
('2024-06-15',)
(None,)
*/