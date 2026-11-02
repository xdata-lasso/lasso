-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (251, '2025-01-01 00:00:00', '2023-01-01', NULL, NULL, '%Y', 'default2'), (250, NULL, NULL, '2023-01-02', '2023-01-01', 'default1', '2025-01-01 00:00:00'), (0, '2025-01-01 00:00:00', NULL, '2023-01-02', '2025-01-01', 'default2', '2025-01-01 00:00:00'), (179, '%Y', '2023-01-02', '2023-01-01', '2025-01-01', NULL, NULL), (249, '%Y', NULL, '2023-01-02', NULL, 'default2', NULL), (180, 'default2', '2025-01-01', '2025-01-01', '2023-01-02', 'default1', NULL), (181, 'default2', '2023-01-01', '2023-01-01', '2025-01-01', '2025-01-01 00:00:00', '2025-01-01 00:00:00'), (1, 'default1', '2025-01-01', '2025-01-01', '2025-01-01', 'default2', '%Y');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (1, '2025-01-01', NULL, 179, 251, 179, 180.0, 250.0, 0.0, 1, 0.0, 251.0, 0, 251, 180, NULL, 249.0, 250.0, 1.0, 1.0, 249, 250.0, 181, 179.0, 181, 249, 250, NULL, NULL, 251, 1, 'default1', 'default2', NULL, 179, NULL, 'default2', '2025-01-01 00:00:00', 'default2', '2025-01-01 00:00:00', 'default2', '2025-01-01 00:00:00', 'default1', 1), (179, '2025-01-01', 0, 250, 0, 0, 1.0, 1.0, 180.0, 250, 251.0, 181.0, NULL, 251, 180, NULL, 181.0, 250.0, 249.0, NULL, 0, 249.0, 0, 251.0, 179, 1, 251, '2025-01-01 00:00:00', 0, 1, 1, 'default1', '%Y', NULL, 251, 251, '%Y', '2025-01-01 00:00:00', 'default2', '%Y', 'default2', '%Y', 'default1', 249), (251, '2025-01-01', 250, 251, 1, 180, 180.0, 181.0, 179.0, 180, 249.0, 1.0, 1, 179, NULL, 181, 0.0, 180.0, 250.0, 181.0, 251, 180.0, 250, 180.0, 0, 250, 251, NULL, 180, 0, 251, NULL, NULL, 'default2', 1, 1, 'default2', 'default1', 'default1', 'default1', 'default1', '2025-01-01 00:00:00', 'default2', 1), (250, '2023-01-01', 180, 180, 250, 249, 181.0, 251.0, 1.0, 1, 250.0, 0.0, 249, 251, 0, 251, 249.0, 181.0, 249.0, 0.0, 180, 249.0, 181, 179.0, 181, NULL, 249, 'default2', 250, 181, 249, '2025-01-01 00:00:00', 'default2', '2025-01-01 00:00:00', 249, 251, '2025-01-01 00:00:00', '%Y', '2025-01-01 00:00:00', 'default2', NULL, '%Y', '2025-01-01 00:00:00', 1), (249, '2025-01-01', 181, 250, 181, 250, 1.0, 250.0, 249.0, 179, 251.0, 180.0, 1, 1, 180, 1, 249.0, 1.0, 181.0, 1.0, 249, 249.0, NULL, 0.0, 251, NULL, 181, '%Y', 251, 1, NULL, NULL, '2025-01-01 00:00:00', NULL, 0, NULL, '%Y', '%Y', 'default1', '2025-01-01 00:00:00', 'default2', 'default1', NULL, 249), (0, '2023-01-02', 181, 249, 249, 251, 179.0, 179.0, 179.0, 0, 1.0, 180.0, 179, 181, 1, 250, 181.0, 250.0, NULL, 180.0, 181, 1.0, 180, 181.0, 181, 249, 181, NULL, 251, 0, 180, 'default2', 'default2', NULL, 251, 249, 'default1', 'default2', 'default2', '2025-01-01 00:00:00', '%Y', 'default2', 'default1', 181), (251, '2023-01-01', 249, 0, 251, 0, 251.0, 0.0, 251.0, 181, 0.0, 0.0, 180, 1, 1, 180, 249.0, 179.0, 250.0, 249.0, 181, 181.0, 180, 1.0, 0, 1, NULL, 'default1', 1, 0, 251, 'default2', '%Y', NULL, 179, NULL, NULL, 'default2', '%Y', 'default2', '2025-01-01 00:00:00', 'default2', 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T1.SEX, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GLU >= 180 AND T2."T-CHO" < 250;

/*
Gold Result:
(0, '2025-01-01 00:00:00', None)
(250, None, None)
(251, '2025-01-01 00:00:00', 2)
*/

-- Prediction Query
SELECT T1.ID, T1.SEX, (STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday)) AS age FROM Patient AS T1 JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GLU >= 180 AND T2."T-CHO" < 250;

/*
Prediction Result:
(251, '2025-01-01 00:00:00', 2)
(250, None, None)
(0, '2025-01-01 00:00:00', None)
(251, '2025-01-01 00:00:00', 2)
*/