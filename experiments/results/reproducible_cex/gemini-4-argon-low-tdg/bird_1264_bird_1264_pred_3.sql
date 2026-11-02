-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests:
-- 1. COUNT(DISTINCT T1.ID) vs COUNT(DISTINCT T2.C4) or COUNT(DISTINCT T1.Diagnosis) or COUNT(DISTINCT T2.Date)
--    Here, 3 distinct patients match, all sharing the exact same C4 (15), Date ('2021-05-01'), and Diagnosis ('APS').
--    Gold Query returns 3. Mutants counting distinct C4, Date, or Diagnosis will return 1.
-- 2. Mutants using SUM(T1.ID), MAX(T1.ID), MIN(T1.ID), or AVG(T1.ID) instead of COUNT (IDs 10, 20, 30 yield non-3 values).
-- 3. Mutants joining on Examination table (Patients 10 and 20 have no Examination records; Patient 30 has multiple).
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (10, 'F', 'APS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (20, 'M', 'APS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (30, 'F', 'APS');
INSERT INTO Laboratory (ID, Date, C3, C4) VALUES (10, '2021-05-01', 5, 15);
INSERT INTO Laboratory (ID, Date, C3, C4) VALUES (20, '2021-05-01', 5, 15);
INSERT INTO Laboratory (ID, Date, C3, C4) VALUES (30, '2021-05-01', 5, 15);
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (30, '2021-05-01', 'APS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (30, '2021-05-02', 'APS');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.C4 > 10 AND T1.Diagnosis = 'APS';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT e.ID) FROM Examination AS e JOIN Laboratory AS l ON e.ID = l.ID WHERE (e.Diagnosis LIKE '%thrombosis%' OR e.Diagnosis LIKE '%APS%' OR e.Diagnosis LIKE '%DVT%') AND l.C4 > 10;

/*
Prediction Result:
(1,)
*/