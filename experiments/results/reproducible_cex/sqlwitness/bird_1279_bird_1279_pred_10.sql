-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (60, 'SLE', '2023-01-02', NULL, '2023-01-02', 'default1', 'default2'), (61, 'default1', '2023-01-02', NULL, NULL, '%SLE%', 'SLE'), (0, 'default1', '2023-01-01', '2023-01-01', '2023-01-02', 'default2', 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (60, '2023-01-01', 1, 101, 61, -1, 60.0, 61.0, 60.0, 2, 0.0, 1.0, -1, NULL, 101, 60, 1.0, 1.0, 1.0, 60.0, 99, 100.0, 101, NULL, 61, 60, 1, NULL, -1, -1, 99, '%SLE%', NULL, 'default2', 59, 1, 'SLE', 'SLE', '%SLE%', 'default2', '%SLE%', 'SLE', 'default1', NULL), (61, '2023-01-02', 0, 1, 0, 99, 101.0, 1.0, 0.0, 59, 100.0, -1.0, 61, 61, NULL, 1, 60.0, 100.0, 60.0, 59.0, 1, 1.0, 0, 61.0, 59, 2, 1, 'default1', 2, -1, 100, 'default2', NULL, 'SLE', 99, 2, 'default2', 'default2', 'SLE', 'default2', 'SLE', NULL, 'SLE', 0), (0, '2023-01-01', 101, 99, 0, 99, 59.0, -1.0, NULL, NULL, 0.0, NULL, NULL, 60, 99, 0, 59.0, 60.0, 1.0, 101.0, 0, 1.0, -1, 1.0, NULL, 0, 100, 'default1', 99, 60, NULL, 'SLE', NULL, 'default1', 2, 59, 'SLE', NULL, '%SLE%', 'default1', 'default1', 'default2', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(CASE WHEN T1.Diagnosis LIKE '%SLE%' THEN T1.ID ELSE 0 END) / COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2."GOT" >= 60;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN T1.GOT >= 60 AND T2.Diagnosis = 'SLE' THEN 1 END) AS REAL) * 100 / COUNT(CASE WHEN T1.GOT >= 60 THEN 1 END) AS percentage FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID;

/*
Prediction Result:
(0.0,)
*/