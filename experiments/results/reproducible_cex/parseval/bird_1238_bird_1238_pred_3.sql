-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 't1__10c6ca', '2025-06-17', '2021-11-08', '2025-06-13', 'wwqcg', 'SLE');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-1, 't1__10c6ca', '1969-12-31', '2020-03-04', '2023-07-07', '2dwyrq13pyu7', 'SLE');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (0, 't1__50bc1f', '1970-01-01', '2020-07-21', '2023-01-20', 'jsl', 'SLE');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'SLE');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'SLE');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'SLE');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 'ia2yp', '2023-08-23', '2024-06-23', '2021-03-30', 'rwbbp', 'SLE');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', -890215420, 1610062532, -106629402, 1871297066, 688.4027, 520.784135, 86.520366, -1865039888, 779.409124, 640.719621, 1160656988, -992890117, 1914020640, 1268590800, 378.476082, 783.93201, 10.01, 718.397869, -1670923962, 663.049759, 906324270, 944.247544, 2122220075, 1072996612, 13244799, 'hvdltt', -1610064545, 429706943, 462974032, 'posiie5unw6k', 'fa9', '00t5c4e', 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -453362185);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1969-12-31', -346339240, 1692174491, -1025564911, -227162283, 164.583726, 978.797504, 551.785129, 556727997, 860.770887, 774.274643, 1836127587, -1529584866, 1196308825, 910894705, 452.27611, 434.003102, 10.01, 390.34832, 233994589, 367.405851, 1442655647, 479.592965, -629784617, -1929953647, 1581736075, 'gndqwnqc', 555413010, 722884590, 580968159, 'cprj', 'u0dz7', 'fjgq8n2f3', 806170397, 513454646, '0gcb98', 'zk3z', 'i', 'yrk', 'n6vck6ah0f', 'jswwlq7xb', '72fxa7ryfd', 564390026);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-01', -1259474148, 2011234363, -1483100200, -7597509, 651.586084, 121.521559, 849.655083, -1738458256, 100.84577, 54.980195, -458359144, 600440952, 1568069663, -1794176801, 221.842983, 279.731401, 10.01, 630.468925, -902895762, 453.914926, 2111987706, 360.694313, 1972233925, 1792827279, 804529642, '01jh3den', 357330522, -683007527, 2035306060, 'x7afu5w1of77', 'zo72', 'ctdctmfg62g0', 1870300798, 820970595, 'qdjpe1io2', '78507cvt', 'ptt', '6b', 'ou5z', '36c', 'bfkfoacd', 2115816682);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-02', 76987628, -253138337, 641521863, 304189298, 108.948237, 373.68875, 965.506647, -526612570, 372.754231, 187.71278, -405743609, -1935752926, -20116244, -176606723, 264.110281, 691.015295, 10.01, 496.469611, 1339733032, 236.262879, -1556979799, 487.138399, 1379859112, 195202164, 1817366143, '7p2r94gt', 1273687251, 333302050, 1162591638, 'ajjla3okv8u', 'tmu2n', '57', -1402164108, 2123471885, 'yz7zzbe8yvk', 'v42q7sx58b4p', 'aus3', 'u', 'mkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', -1793230843);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2021-05-05', -992890117, 1914020640, 1268590800, 1219478689, 718.397869, 324.940703, 399.341724, -1670923962, 663.049759, 711.020062, 1908028688, 2122220075, 1072996612, 13244799, 320.851235, 113.643485, 17.0, 855.355181, -1377057208, 304.02808, -1364429300, 998.421621, -1257178728, 1236688122, 2087640001, 'dposiie5unw', -1399556171, 1038707349, 1419861592, '4ecigce376n', 'um5', 'zbuo4nrq', 418417917, -1031969798, '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', -1021749117);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2021-05-05', -992890117, 1914020640, 1268590800, 1219478689, 718.397869, 324.940703, 399.341724, -1670923962, 663.049759, 711.020062, 1908028688, 2122220075, 1072996612, 13244799, 320.851235, 113.643485, 10.0, 855.355181, -1377057208, 304.02808, -1364429300, 998.421621, -1257178728, 1236688122, 2087640001, 'dposiie5unw', -1399556171, 1038707349, 1419861592, '4ecigce376n', 'um5', 'zbuo4nrq', 418417917, -1031969798, '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', -1021749117);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '2021-05-05', 1, 1, 1, 1, 1.0, 1.0, 1.0, 1, 1.0, 1.0, 1, 1, 1, 1, 1.0, 1.0, NULL, 1.0, 1, 1.0, 1, 1.0, 1, 1, 1, 'value', 1, 1, 1, 'value', 'value', 'value', 1, 1, 'value', 'value', 'value', 'value', 'value', 'value', 'value', 1);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '2025-08-22', 1, 1, 1, 1, 1.0, 1.0, 1.0, 1, 1.0, 1.0, 1, 1, 1, 1, 1.0, 1.0, NULL, 1.0, 1, 1.0, 1, 1.0, 1, 1, 1, 'value', 1, 1, 1, 'value', 'value', 'value', 1, 1, 'value', 'value', 'value', 'value', 'value', 'value', 'value', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID, T1.SEX FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Diagnosis = 'SLE' AND T2.HGB > 10 AND T2.HGB < 17 ORDER BY T1.Birthday ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
(0, 't1__50bc1f')
*/

-- Prediction Query
SELECT DISTINCT t1.id, t1.sex FROM patient AS t1 INNER JOIN laboratory AS t2 ON t1.id = t2.id WHERE t1.diagnosis = 'SLE' AND t2.hgb > 10 AND t2.hgb < 17 ORDER BY t1.birthday ASC, t1.id NULLS LAST, t1.sex NULLS LAST LIMIT 1;

/*
Prediction Result:
(0, 't1__50bc1f')
*/