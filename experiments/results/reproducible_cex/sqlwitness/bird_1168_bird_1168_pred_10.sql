-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, 'SJS', NULL, '2023-01-01', '2023-01-01', 'default2', NULL), (2, '%Y', '2023-01-02', '2023-01-01', NULL, 'default1', NULL), (1, '%Y', NULL, '2023-01-02', '2023-01-01', NULL, '%Y'), (3, 'default2', NULL, '2023-01-01', NULL, 'default2', 'default1'), (4, 'default1', NULL, '2023-01-02', '2023-01-01', 'default1', 'default1'), (5, 'default2', NULL, '2023-01-01', NULL, 'default2', 'SJS'), (6, '%Y', NULL, '2023-01-01', '2023-01-02', 'default2', '%Y');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (2, '2023-01-01', 0, 0, 2, NULL, NULL, 2.0, 2.0, 2, 1.0, 0.0, 2, 0, 0, 2, 1.0, 2.0, NULL, 1.0, 0, 2.0, 1, 2.0, 0, NULL, 1, 'SJS', 1, 1, 1, 'SJS', 'default1', '%Y', 2, 0, '%Y', NULL, '%Y', 'SJS', '%Y', 'SJS', 'default1', NULL), (6, '2023-01-01', 2, 1, 2, 0, 1.0, 1.0, 0.0, 0, 2.0, 2.0, 0, 1, 2, 1, 0.0, 1.0, NULL, 1.0, 0, 0.0, 1, 0.0, 2, NULL, 1, 'default1', NULL, 1, 1, NULL, 'default2', '%Y', 2, 1, NULL, 'default2', NULL, '%Y', NULL, 'default2', 'SJS', NULL), (3, '2023-01-02', 2, 0, NULL, 0, 1.0, 1.0, 1.0, 0, 2.0, 0.0, 0, NULL, 1, 1, NULL, 1.0, NULL, 1.0, 2, 0.0, 1, NULL, 0, 0, 0, 'SJS', 1, 1, 0, 'default1', 'default1', 'default2', 1, 1, 'default1', '%Y', NULL, 'SJS', '%Y', 'SJS', NULL, 1), (5, '2023-01-01', 1, 0, 0, 2, 2.0, NULL, NULL, NULL, 1.0, NULL, 2, 1, 2, 2, NULL, 2.0, NULL, NULL, NULL, 0.0, 0, 2.0, 1, NULL, 1, 'default1', 1, NULL, NULL, 'SJS', 'default1', NULL, 0, 0, '%Y', NULL, 'default2', '%Y', 'SJS', NULL, 'SJS', 0), (3, '2023-01-01', 2, 2, 1, 0, NULL, NULL, 0.0, 1, 2.0, NULL, 2, NULL, 0, NULL, 2.0, 0.0, 2.0, 0.0, 1, 0.0, 2, 2.0, NULL, 2, 1, 'default1', NULL, 2, 0, 'SJS', '%Y', 'default1', 0, 1, 'default1', 'default1', 'SJS', 'SJS', 'SJS', 'default2', NULL, 0), (1, '2023-01-02', 1, 2, 1, 0, 2.0, 2.0, 1.0, NULL, 0.0, NULL, NULL, 1, NULL, 2, 1.0, 0.0, 1.0, 1.0, 2, 2.0, 2, 1.0, 2, 0, 0, 'default2', 0, NULL, 1, NULL, '%Y', '%Y', 2, 1, '%Y', NULL, '%Y', 'SJS', 'default1', NULL, 'SJS', NULL), (2, '2023-01-02', 0, 0, 2, 2, 2.0, NULL, 1.0, 1, 0.0, 2.0, 2, 2, 0, NULL, 2.0, 1.0, 0.0, 1.0, NULL, 1.0, NULL, NULL, 1, 0, 0, NULL, NULL, 0, NULL, 'SJS', 'default1', 'default1', 0, NULL, 'default1', 'SJS', 'default2', 'default2', NULL, 'default2', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Date, STRFTIME('%Y', T2."First Date") - STRFTIME('%Y', T2.Birthday) FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T2.Diagnosis = 'SJS' AND NOT T2.Birthday IS NULL ORDER BY T2.Birthday ASC, T1.id NULLS LAST, T1.date NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2."Date", STRFTIME('%Y', T1."First Date") - STRFTIME('%Y', T1.Birthday) AS Age FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Diagnosis = 'SJS' ORDER BY T1.Birthday ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Prediction Result:
('2023-01-01', None)
*/