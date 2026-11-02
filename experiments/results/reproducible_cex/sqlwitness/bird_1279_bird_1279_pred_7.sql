-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (99, NULL, '2023-01-02', NULL, NULL, 'SLE', NULL), (0, '%SLE%', NULL, '2023-01-02', NULL, 'default1', NULL), (61, '%SLE%', '2023-01-01', NULL, NULL, NULL, 'SLE'), (101, 'SLE', '2023-01-01', NULL, '2023-01-01', 'default2', 'SLE'), (-1, 'SLE', NULL, '2023-01-01', NULL, 'default2', 'default1');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (101, '2023-01-02', 59, 0, 2, 60, 101.0, -1.0, 59.0, 101, 99.0, 100.0, 0, 59, -1, 60, 60.0, 99.0, 61.0, NULL, 100, -1.0, 0, 2.0, 59, -1, 2, 'SLE', 0, 61, 59, 'default2', 'SLE', 'SLE', 101, 100, '%SLE%', '%SLE%', NULL, 'SLE', '%SLE%', 'SLE', NULL, 60), (0, '2023-01-01', -1, 2, NULL, 2, 1.0, 59.0, NULL, -1, 99.0, 59.0, 61, NULL, 59, -1, -1.0, 60.0, 1.0, 60.0, 59, 59.0, 0, 0.0, 101, 0, 59, 'default1', NULL, 1, 1, 'default1', NULL, '%SLE%', 60, 2, NULL, '%SLE%', 'SLE', 'default2', 'default2', 'default2', '%SLE%', 101), (0, '2023-01-02', 1, 99, NULL, -1, NULL, -1.0, 1.0, NULL, 2.0, -1.0, 100, 99, 60, 99, NULL, 99.0, 59.0, 59.0, 59, 60.0, 100, 2.0, 100, 59, 59, 'default2', 101, 2, 59, 'default2', 'default2', 'SLE', 101, 59, 'default2', NULL, '%SLE%', 'default2', '%SLE%', NULL, 'SLE', 1), (99, '2023-01-01', 60, 101, 101, 1, -1.0, 59.0, 59.0, 101, 99.0, -1.0, -1, 1, 60, NULL, 61.0, 101.0, 60.0, 100.0, 99, 0.0, 1, 101.0, 2, 61, 100, 'SLE', 59, 0, 0, 'default2', NULL, 'default2', 99, 1, 'default2', 'default1', NULL, '%SLE%', 'default2', NULL, 'default2', 1), (99, '2023-01-02', 100, 59, 99, 61, 100.0, 61.0, 61.0, -1, 61.0, -1.0, 0, 1, NULL, 100, 60.0, 59.0, 60.0, 2.0, 2, 1.0, 61, -1.0, 2, 60, 101, '%SLE%', 101, 59, 1, 'default1', NULL, '%SLE%', 0, 2, '%SLE%', '%SLE%', 'default2', 'default2', NULL, 'default2', 'SLE', 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(CASE WHEN T1.Diagnosis LIKE '%SLE%' THEN T1.ID ELSE 0 END) / COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2."GOT" >= 60;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN t2.diagnosis = 'SLE' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(t1.id) * 1.0 AS percentage FROM laboratory AS t1 INNER JOIN patient AS t2 ON t1.id = t2.id WHERE t1.got >= 60;

/*
Prediction Result:
(0.0,)
*/