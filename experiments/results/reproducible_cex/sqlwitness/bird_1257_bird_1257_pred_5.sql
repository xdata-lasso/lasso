-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, '2025-01-01 00:00:00', NULL, '2023-01-01', '2023-01-01', 'default1', '+-'), (71, 'default2', '2026-10-18', '2023-01-02', '2026-10-18', '+-', 'default2'), (70, '-', '2023-01-02', '2025-01-01', '2026-10-18', '2025-01-01 00:00:00', '-'), (69, '-', '2026-10-18', '2025-01-01', '2025-01-01', '2025-01-01 00:00:00', '+-');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (69, '2026-10-18', 70, 71, NULL, 0, 1.5, 1.5, 69.0, NULL, 1.0, 1.5, 1, 71, 1, NULL, 0.5, 1.5, 1.5, 0.0, NULL, 2.5, 1, 1.0, 71, 0, 0, 'default2', 69, 70, 71, '18', 'default2', '18', 69, 0, 'default1', '2025-01-01 00:00:00', 'default1', '18', '+-', NULL, NULL, NULL), (70, '2023-01-02', NULL, 70, 70, 71, 2.5, 2.0, 1.0, 0, 69.0, 70.0, 70, 71, NULL, 70, NULL, 2.0, 69.0, 0.5, 69, 70.0, NULL, NULL, 69, 71, 0, 'default2', 1, 71, 71, '%Y', '-', '%Y', NULL, 0, '+-', '-', '-', '%Y', '-', NULL, 'default2', 1), (69, '2025-01-01', NULL, 70, 71, 69, 69.0, 1.5, 0.0, NULL, 70.0, 69.0, 71, 0, 1, NULL, 2.5, 1.0, 0.0, 70.0, NULL, 2.0, 70, NULL, NULL, 0, 69, '2025-01-01 00:00:00', 0, 0, 70, '18', '-', '-', NULL, 0, 'default1', '+-', '%Y', NULL, '2025-01-01 00:00:00', '+-', 'default2', 71), (0, '2023-01-01', 71, NULL, 0, 70, 0.0, 69.0, 71.0, 71, 69.0, 1.5, NULL, 71, 0, 69, NULL, 0.0, 2.5, NULL, 1, 2.0, 69, NULL, 69, 0, 0, '-', 0, NULL, 70, 'default1', 'default1', '2025-01-01 00:00:00', NULL, NULL, '-', 'default2', '%Y', '-', 'default2', '%Y', '18', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.CRP <> '-' AND T2.CRP <> '+-') AND T2.CRP >= 1.0 AND STRFTIME('%Y', DATE('2025-01-01 00:00:00')) - STRFTIME('%Y', T1.Birthday) < '18';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Laboratory AS lab INNER JOIN Patient AS pat ON lab.ID = pat.ID WHERE lab.CRE >= 1.5 AND (STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', pat.Birthday)) < 70;

/*
Prediction Result:
(2,)
*/