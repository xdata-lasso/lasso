-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (99, NULL, NULL, NULL, NULL, 'default2', NULL), (0, 'F', NULL, NULL, '2023-01-02', NULL, 'default2'), (-1, 'default2', NULL, NULL, NULL, 'F', NULL), (1, 'F', '2023-01-02', '2023-01-02', '2023-01-02', 'default1', 'default2'), (2, NULL, '2023-01-02', NULL, NULL, 'default1', NULL), (100, NULL, '2023-01-02', NULL, '2023-01-02', 'default1', 'F');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (100, '2023-01-01', 0, 101, 99, 100, 2.0, 99.0, 7.5, 0, 7.0, 5.0, 1, NULL, 1, 101, NULL, NULL, 1.0, 99.0, 2, 8.5, 100, 6.0, NULL, 100, -1, NULL, 2, 100, 2, 'F', 'default1', 'F', 2, 100, 'F', NULL, 'F', NULL, NULL, 'default2', 'default1', -1), (100, '2023-01-02', NULL, 100, 2, 2, 99.0, 6.0, 8.5, NULL, 100.0, 7.5, -1, 1, 1, 100, 8.5, 7.5, 7.0, 2.0, 101, 6.0, 101, 8.5, 0, 1, 99, 'F', 0, 99, 2, 'default2', 'default2', 'F', 1, 1, 'F', NULL, 'default1', 'default2', 'F', 'F', 'F', NULL), (-1, '2023-01-01', 1, 2, 2, NULL, -1.0, 8.5, NULL, 99, -1.0, 2.0, 0, 2, NULL, -1, 2.0, 99.0, 2.0, 5.0, 99, 2.0, 1, 7.5, -1, -1, 2, NULL, 101, 100, NULL, 'default2', 'default2', 'F', -1, 2, 'default2', 'default1', 'default1', 'default2', 'default1', 'F', NULL, 0), (0, '2023-01-02', 2, 1, 2, 101, 5.0, 101.0, 7.5, 0, NULL, NULL, NULL, 101, 0, NULL, NULL, 5.0, 100.0, 6.0, 0, 7.0, 0, NULL, -1, 2, NULL, 'default2', 2, 0, 99, 'default2', 'F', 'default1', 2, 99, 'F', NULL, 'default1', 'default2', 'F', NULL, 'default1', 101), (99, '2023-01-01', 1, 0, 0, 101, 7.5, 7.0, 7.0, NULL, -1.0, 7.5, 0, 101, 99, 1, 5.0, 2.0, 2.0, 7.0, -1, 99.0, -1, 0.0, NULL, 100, NULL, 'F', 100, 100, NULL, NULL, 'F', 'F', 101, 1, 'default1', 'default1', 'default1', 'default2', NULL, NULL, 'F', 2), (99, '2023-01-02', 101, 1, NULL, 101, 6.0, 7.0, 6.0, 2, 2.0, 1.0, 0, 100, NULL, 0, 8.5, 7.5, 6.0, 9.5, 2, 7.5, 99, 7.5, NULL, 99, 101, 'default2', 101, 2, 101, 'default2', 'default2', 'F', 99, 99, 'default2', 'F', NULL, 'F', 'F', NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.SEX = 'F' AND (T2.TP < 6.0 OR T2.TP > 8.5) THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.SEX = 'F';

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT (CAST(COUNT(DISTINCT Laboratory.ID) AS REAL) * 100.0 / CAST((SELECT COUNT(DISTINCT ID) FROM Patient WHERE SEX = 'F') AS REAL)) AS percentage FROM Laboratory JOIN Patient ON Laboratory.ID = Patient.ID WHERE Patient.SEX = 'F' AND (Laboratory.TP < 6.0 OR Laboratory.TP > 8.5);

/*
Prediction Result:
(50.0,)
*/