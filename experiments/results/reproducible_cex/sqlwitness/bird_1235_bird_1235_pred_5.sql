-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, '%Y', '2025-01-01', NULL, '2025-01-01', '%Y', 'default2'), (0, 'default1', '2025-01-01', '2023-01-02', '2025-01-01', 'default2', 'default1'), (2, '%Y', '2023-01-01', '2023-01-01', '2023-01-02', NULL, '%Y');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (0, '2023-01-01', NULL, 1, 1, 1, 1.0, 0.0, 2.5, 1, NULL, 1.0, 0, 0, 0, 1, 1.0, 3.5, NULL, 0.0, NULL, 1.0, 1, 4.5, 0, 1, 0, NULL, 1, NULL, NULL, '%Y', '2025-01-01 00:00:00', 'default2', NULL, 0, NULL, '%Y', 'default1', '2025-01-01 00:00:00', 'default2', '%Y', '%Y', 1), (0, '2023-01-02', 0, 0, 0, NULL, 2.5, 1.0, NULL, NULL, 2.5, 3.5, NULL, 0, 1, 1, 3.5, 1.0, 4.5, 0.0, 1, 1.0, 0, 2.5, 1, 0, 1, '%Y', 0, 1, 1, 'default1', '2025-01-01 00:00:00', NULL, NULL, NULL, 'default1', '2025-01-01 00:00:00', '%Y', 'default1', '%Y', '%Y', 'default1', 0), (1, '2023-01-02', 1, NULL, NULL, 1, NULL, 4.5, 2.5, NULL, NULL, 1.0, 0, 1, NULL, 0, 1.0, 2.5, 4.5, NULL, 0, 0.0, 0, 3.5, NULL, 1, 1, 'default1', NULL, NULL, NULL, '2025-01-01 00:00:00', '%Y', 'default1', 0, NULL, 'default2', NULL, 'default1', '2025-01-01 00:00:00', '2025-01-01 00:00:00', 'default2', 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis, T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.RBC < 3.5;

/*
Gold Result:
('default1', 0, 0)
('default2', 1, 0)
*/

-- Prediction Query
SELECT T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) AS age, T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.RBC < 3.5;

/*
Prediction Result:
(0, 0, 'default1')
(1, 0, 'default2')
*/