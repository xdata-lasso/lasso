-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (61, 'default1', '2023-01-01', NULL, NULL, 'SLE', NULL), (1, 'default1', '2023-01-01', '2023-01-01', '2023-01-01', NULL, '%SLE%');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (61, '2023-01-02', 101, 60, 101, 61, 60.0, 99.0, 61.0, 1, -1.0, 0.0, 1, -1, NULL, 100, 1.0, 99.0, 1.0, 59.0, 60, 0.0, 59, 59.0, 101, 61, 0, 'SLE', 101, 61, 60, 'default1', 'default2', NULL, -1, 0, 'default1', 'default1', 'default2', 'SLE', 'default1', 'default1', '%SLE%', 101), (1, '2023-01-02', -1, 99, 59, 99, 1.0, NULL, 99.0, 60, 99.0, -1.0, 61, 61, 61, 1, 99.0, 100.0, 101.0, 101.0, 59, 61.0, 99, 61.0, NULL, -1, NULL, 'default2', 60, 100, 60, 'default1', 'default1', 'default2', 0, -1, 'SLE', '%SLE%', NULL, 'default2', NULL, '%SLE%', 'default2', 59);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(CASE WHEN T1.Diagnosis LIKE '%SLE%' THEN T1.ID ELSE 0 END) / COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2."GOT" >= 60;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT (CAST(COUNT(DISTINCT CASE WHEN GOT >= 60 AND Diagnosis = 'SLE' THEN Laboratory.ID END) AS REAL) / CAST(COUNT(DISTINCT CASE WHEN GOT >= 60 THEN Laboratory.ID END) AS REAL)) * 100 AS percentage FROM Laboratory JOIN Patient ON Laboratory.ID = Patient.ID;

/*
Prediction Result:
(0.0,)
*/