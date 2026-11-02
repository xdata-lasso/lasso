-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (0, '6nijjai5dh', '2025-06-24', '2022-07-24', '2021-01-25', 'gjd8y', 't1afgog');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 700293388, 906324270, 1908028688, 2122220075, 749.826493, 3.5, 503.083789, -1659388584, 855.355181, 179.378884, -841692980, -1364429300, -1257178728, 1236688122, 986.066566, 666.330692, 46.9162, 776.327423, 907682809, 227.766936, 2026480202, 133.007885, -1823627488, -1209887326, -1399556171, 'a9000t5c4eci', 1149850321, -1833165707, 1155439218, 'um5', 'zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1969-12-31', 1692174491, -1025564911, -227162283, 2056419640, 551.785129, 3.5, 263.638479, 556727997, 860.770887, 774.274643, 1836127587, -1529584866, 1196308825, 910894705, 452.27611, 434.003102, 390.34832, 585.585659, 233994589, 367.405851, 1442655647, 479.592965, -629784617, -1929953647, 1581736075, 'gndqwnqc', 555413010, 722884590, 580968159, 'cprj', 'u0dz7', 'fjgq8n2f3', 806170397, 513454646, '0gcb98', 'zk3z', 'i', 'yrk', 'n6vck6ah0f', 'jswwlq7xb', '72fxa7ryfd', 564390026);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-01', -946046410, -902895762, -197933860, 2111987706, 360.694313, 4.5, 959.196496, 1792827279, 632.340892, 687.319156, -1538707438, -163600466, -1826414375, 357330522, 565.286158, 729.327198, 973.224853, 369.474112, -683007527, 757.137864, 2035306060, 735.057703, 1523825314, 2078438287, -47052816, '1of77pzo72c', -820614248, 481546706, -1784554553, '2g0v5q8qd', 'jpe1io22785', '7cvtjpt', 453836040, 1467355421, 'ou5z', '36c', 'bfkfoacd', '7z2zezj', '7wgx', '5', 'sxcmr0o', 853709925);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1970-01-01', -870767087, -1699185893, 875300074, -1609653472, 172.799686, 4.5, 913.609637, 1816660482, 184.430978, 217.651697, 1692046802, -1300180872, -1125548818, 1497321728, 555.274052, 477.692813, 306.477948, 116.827507, -244633520, 925.474843, 418247369, 145.067008, -1351793914, 1919033056, -1428186898, 'uttmu2ne5', -1402164108, 2123471885, -526633767, 'zzbe8yvkv', '42q7sx58b4', 'pmaus3auvmkr', 609771851, -1934017803, 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', 211603887);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Date FROM Laboratory WHERE ALB BETWEEN 3.5 AND 5.5 ORDER BY ALB DESC, Laboratory.id NULLS LAST, Laboratory.date NULLS LAST LIMIT 1;

/*
Gold Result:
('1970-01-01',)
*/

-- Prediction Query
SELECT "examination"."examination date" FROM "examination" INNER JOIN "laboratory" ON "examination"."id" = "laboratory"."id" WHERE "laboratory"."alb" = (SELECT MAX("alb") FROM "laboratory" WHERE "alb" > 3.5 AND "alb" < 5.5 AND "laboratory"."id" = "examination"."id");

/*
Prediction Result:
*/