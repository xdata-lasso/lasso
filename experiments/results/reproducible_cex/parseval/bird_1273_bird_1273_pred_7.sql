-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'SLE');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, '1afgogritsj', '2025-02-02', '2020-03-04', '2024-04-27', 'p1q430', 'jh3den8');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-05-05', -992890117, 1914020640, 1268590800, 1219478689, 718.397869, 324.940703, 399.341724, -1670923962, 663.049759, 711.020062, 1908028688, 2122220075, 1072996612, 13244799, 320.851235, 113.643485, 855.355181, 179.378884, -841692980, 182.319045, -1257178728, 787.938887, 2087640001, 907682809, 2026480202, 'ie5', -1209887326, -1399556171, 1038707349, '9000t5c4ec', 'gce', '76nium52', -443340271, 757448742, '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -453362185);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-03-04', 2123196517, 364869063, -953437896, -1097120355, 326.912005, 798.947629, 49.538289, 244829661, 182.777264, 943.791649, -904834265, -346339240, 1692174491, -1025564911, 447.109657, 164.583726, 978.797504, 551.785129, 556727997, 860.770887, 1178000634, 541.393553, 1836127587, -1529584866, 1196308825, 'd21vy9uxj4hw', -2050247126, -736979194, 2103044118, 'h2gndqwnqcx5', 'hncprjtu0dz', '9fjgq8n2f', -1056308489, -1454058168, 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', -458359144);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2020-07-09', -683007527, 2035306060, 1523825314, 2078438287, 313.653498, 489.044661, 650.242697, 765724008, 528.552305, 243.919919, 87529806, -1957268147, -1928431425, 1303877941, 695.452114, 200.834692, 102.360106, 501.846153, -1744557630, 935.463334, 820970595, 537.702873, 1421303999, -1488156735, -1858644047, 'o22', 2004147439, -691774480, -1523347137, 'ttg6bnou5zi3', 'c4bfkfoac', '0', 76987628, -253138337, 'zj', '7wgx', '5', 'sxcmr0o', 'negative', 'ztdgj5i3lq5l', 'pim5', -1125548818);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.SSB = 'negative' OR '0' AND T1.Diagnosis = 'SLE';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT Patient.ID) FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID INNER JOIN Examination ON Patient.ID = Examination.ID WHERE Laboratory.SSB IN ('-', '0') AND Examination.Diagnosis = 'SLE';

/*
Prediction Result:
(0,)
*/