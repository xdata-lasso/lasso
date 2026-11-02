-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (69, 'default2', '2024-12-31', '2024-12-31', '2025-01-02', '18', 'default1'), (70, '+-', NULL, '2023-01-02', '2024-12-31', '-', '2025-01-01');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (70, '2024-12-31', 71, 70, 1, 0, 0.0, 69.0, NULL, NULL, 0.0, NULL, 69, NULL, 70, 0, 70.0, 2.5, 2.0, 0.5, 69, 70.0, 69, 1.5, 71, NULL, 71, '%Y', NULL, 70, 71, '18', '%Y', '2025-01-01 00:00:00', NULL, 71, 'default2', 'default2', '18', '%Y', '2025-01-01 00:00:00', '2025-01-01 00:00:00', 'default1', 71), (69, '2023-01-01', 69, NULL, 70, 0, 0.0, 1.5, 69.0, 0, 0.5, 70.0, NULL, 70, 1, 70, 70.0, 2.0, 70.0, 0.0, 1, NULL, 70, 1.0, 71, 71, NULL, 'default1', 69, 0, 0, 'default2', '%Y', 'default2', 69, 69, '-', '+-', '%Y', '-', '%Y', '18', '+-', 70);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.CRP <> '-' AND T2.CRP <> '+-') AND T2.CRP >= 1.0 AND STRFTIME('%Y', DATE('2025-01-01 00:00:00')) - STRFTIME('%Y', T1.Birthday) < '18';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Laboratory AS L JOIN Patient AS P ON L.ID = P.ID WHERE L.CRE >= 1.5 AND STRFTIME('%Y', '2025-01-01') - STRFTIME('%Y', P.Birthday) < 70;

/*
Prediction Result:
(0,)
*/