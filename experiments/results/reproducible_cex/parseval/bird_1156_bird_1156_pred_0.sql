-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, '5k5swwqcgs', '2024-06-15', '2021-12-04', '2022-04-27', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'hsrwbbp', '2024-06-15', '2025-08-22', '2022-01-31', 'hvdltt', 'lbn');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 'rmdp', '2024-06-15', '2022-07-21', '2023-03-17', 'ie5', 'nw6klf');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2020-01-23', 587.783596, 558.971814, 1419861592, '4ecigce376n', 1313172851, 'm52zbu', '4nrq', '+', 'rofqyp5s5b', 'p', 882961052);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-12-15', 825.231787, 75.551482, -868774469, 'qa1', 2074205376, 'yytoo', 'o9hl72kl', '+', 'x1', 'ji7zwau2', 364869063);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2023-02-12', 262.105498, 591.461096, 2142703426, 'u78d99r', -1362461264, 'l0b4y', 'p5qi2rkf9v', '+', 'x58pz', 'f8jegd2', 1675430660);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2023-10-23', 390.34832, 585.585659, 233994589, 'j4hwbd', -736979194, 'h2gn', 'q', '+', 'nqcx5h', 'cprj', -841004020);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2024-08-30', 57.96362, 521.610309, -1748371085, 'q8', -1255130038, '3d', 'qv0gcb98ozk', '+', 'zbilyrkn', '6vck6ah0f8js', -658391922);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2021-12-25', 260.513699, 969.559316, 1255343543, '7', 602161869, 'xa', '7ryfdrz16n', '+', 'jja', '5dh', 1583472758);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2021-01-25', 272.414976, 155.818582, 1074760385, 't1afgog', -946046410, 'tsj3ayxp1q4', '01jh3den', '+', 'c68x8vacx', 'afu5w1of7', 76996700);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2024-06-20', 224.624401, 985.639995, 87529806, 'ctdctmfg62g0', 1870300798, 'q8qdjpe1', 'o22', '+', '8507cvtjp', 'ttg6bnou5zi3', -68044929);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2020-12-19', 166.297151, 91.430825, -1173368267, 'cd07z2zezjo7', 304189298, 'xd', 'ysxcmr0o', '+', 'ztdgj5i3lq5l', 'pim5', -1125548818);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-01-31', 555.274052, 477.692813, -244633520, 'ajjl', -2096405521, 'okv8uttmu2', 'e578', '+', 'fvy', '7zzbe8y', -705922211);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-09-24', 574.117269, 445.606673, 79330142, '58b4pm', 1849819405, 'us3auvmkrpdj', 'wzw5chn9mo70', '+', 'a9n0jxfo', 'ws', 1719800120);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2020-08-14', 969.175862, 778.650393, 1010672881, 'obb0q0k', 575038073, 'dwcl', '5amsorlwyngc', '+', 'dj9erhi', 'zgk1yoeyo6l0', -1614619556);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-05-23', 506.13059, 78.702002, -795975227, 'xuzkb52', -277407746, 'nlas6e', 'lboeowii1z5', '+', 'xih6', '2q2xlyoto', 1774679448);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2022-08-11', 735.218284, 11.569916, -2094843966, '96', 1044710644, 'qb0tbindz39t', 'j', '+', '9td8n5w', 'g', -794767771);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2020-05-05', 950.098522, 714.781282, 1295379066, 'd0w9603vzxw1', 1689143863, 'e9yfk7', 'k162n', 't2__676d6e', '55', '3dohvu0', 30861410);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-17', 6.073642, 485.223245, 1595632888, 'mkio18ri2hy', -1853955201, 'qxxnj', 'b', 't2__101637', 'mzn2mfx', 'h33p6sto1', -1971560508);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2.RVVT = '+';

/*
Gold Result:
(1, 1)
(3, 1)
*/

-- Prediction Query
SELECT Patient.ID, CAST(STRFTIME('%Y', '2025-01-01 00:00:00') AS REAL) - CAST(STRFTIME('%Y', Patient.Birthday) AS REAL) AS age FROM Patient JOIN Examination ON Patient.ID = Examination.ID WHERE Examination.RVVT = '+';

/*
Prediction Result:
(1, 1.0)
(1, 1.0)
(3, 1.0)
(3, 1.0)
(3, 1.0)
(3, 1.0)
(3, 1.0)
(3, 1.0)
(1, 1.0)
(1, 1.0)
(1, 1.0)
(1, 1.0)
(1, 1.0)
(1, 1.0)
*/