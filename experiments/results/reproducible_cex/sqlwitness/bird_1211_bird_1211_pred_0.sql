-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, '%Y', '2023-01-01', '2023-01-01', NULL, NULL, 'default1'), (600, NULL, NULL, '2025-01-01', '2023-01-01', '%Y', 'default1'), (801, 'default2', '2023-01-01', '2025-01-01', '2025-01-01', 'default1', NULL), (800, 'default1', '2025-01-01', '2025-01-01', '2025-01-01', 'default1', '%Y');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (800, '2025-01-01', 801, 1, 600, 800, NULL, 599.0, 601.0, 601, 801.0, 601.0, 800, 601, 800, NULL, 0.0, 0.0, 799.0, 601.0, 600, 799.0, 801, 601.0, 799, 600, 599, 'default1', 0, 1, 800, '%Y', '%Y', 'default2', 1, 601, '%Y', '2025-01-01 00:00:00', '%Y', '2025-01-01 00:00:00', '%Y', '%Y', '%Y', NULL), (1, '2023-01-01', 800, 601, 599, 599, NULL, NULL, 600.0, 601, NULL, 800.0, 801, 799, 599, 599, 600.0, 801.0, 800.0, 0.0, 801, 799.0, 801, 0.0, 799, 800, 599, NULL, 599, NULL, 600, 'default2', '2025-01-01 00:00:00', '%Y', 800, 801, 'default1', '2025-01-01 00:00:00', 'default2', 'default1', '%Y', NULL, '%Y', 801), (801, '2023-01-02', 600, NULL, 0, 800, 0.0, 1.0, 0.0, 801, 600.0, 801.0, 800, 1, 0, 800, 800.0, 1.0, 801.0, 801.0, 601, 599.0, 799, NULL, 800, 600, 799, NULL, 599, 1, 599, 'default2', 'default2', '2025-01-01 00:00:00', 600, 0, 'default1', 'default2', 'default2', '2025-01-01 00:00:00', 'default1', NULL, '2025-01-01 00:00:00', 601), (801, '2025-01-01', 800, 801, 800, 799, 599.0, 599.0, 1.0, 599, 1.0, 599.0, 599, 800, 0, 801, 799.0, NULL, 599.0, 599.0, 1, 600.0, 801, 601.0, 1, NULL, 601, '2025-01-01 00:00:00', 1, 801, NULL, 'default1', 'default1', '%Y', NULL, 600, '%Y', 'default2', '2025-01-01 00:00:00', '2025-01-01 00:00:00', '2025-01-01 00:00:00', NULL, '2025-01-01 00:00:00', 800);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.LDH > 600 AND T2.LDH < 800;

/*
Gold Result:
*/

-- Prediction Query
SELECT P.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', P.Birthday) AS age FROM Laboratory AS L INNER JOIN Patient AS P ON L.ID = P.ID WHERE L.LDH BETWEEN 600 AND 800;

/*
Prediction Result:
(800, 0)
(801, 2)
*/