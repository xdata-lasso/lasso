-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, NULL, NULL, '2023-01-01', NULL, 'default1', NULL), (0, 'default1', '2023-01-02', '2023-01-02', NULL, 'M', 'default1'), (2, NULL, '2023-01-01', '2023-01-02', '2023-01-02', 'F', 'M'), (3, 'default2', '2023-01-02', '2023-01-01', '2023-01-01', 'default2', 'M');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (0, '2023-01-01', 0, 0, NULL, 0, 3.0, 0.0, NULL, 1, NULL, 2.0, NULL, 0, 1, 1, NULL, 3.0, 2.0, 3.0, NULL, 0.0, 0, 0.0, NULL, NULL, 1, 'default1', NULL, NULL, 0, 'default1', NULL, 'default1', 1, NULL, 'F', NULL, 'M', 'F', NULL, 'default2', 'M', 0), (1, '2023-01-01', NULL, NULL, 0, 0, NULL, 2.0, 1.0, NULL, 0.0, 1.0, 1, 0, NULL, NULL, NULL, 3.0, 2.0, 3.0, 1, 0.0, NULL, 2.0, 1, 1, 1, 'M', 0, 1, 1, 'default2', 'default2', 'default2', NULL, NULL, 'M', 'F', 'default2', 'M', 'default2', 'default2', 'M', NULL), (1, '2023-01-02', 0, NULL, 0, 0, NULL, 0.0, NULL, 1, NULL, 3.0, 1, 0, 1, NULL, NULL, 3.0, 0.0, 3.0, 1, 0.0, 0, 3.0, NULL, 0, 1, 'F', 0, 0, 1, 'default1', 'default1', 'F', 1, 0, 'default1', 'default1', 'default2', 'default2', 'default1', NULL, 'M', 0), (2, '2023-01-01', NULL, 1, NULL, NULL, 1.0, 3.0, 3.0, NULL, NULL, 0.0, 0, NULL, 0, 1, 2.0, 0.0, 3.0, 2.0, 0, NULL, 0, 2.0, NULL, NULL, NULL, 'F', 0, 0, 1, 'default1', 'default2', 'F', NULL, 1, 'default1', 'M', 'F', 'F', 'default1', 'default2', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT CASE WHEN T1.SEX = 'F' THEN T1.ID END, CASE WHEN T1.SEX = 'M' THEN T1.ID END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2."T-BIL" >= 2.0;

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT T1.SEX, GROUP_CONCAT(T2.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2."T-BIL" >= 2.0 GROUP BY T1.SEX;

/*
Prediction Result:
(None, '1')
('default1', '0')
*/