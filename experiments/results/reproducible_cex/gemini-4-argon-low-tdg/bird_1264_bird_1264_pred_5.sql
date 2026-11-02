-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. COUNT(DISTINCT T1.ID) vs COUNT(*) / COUNT(T1.ID) / COUNT(T2.Date) (Patient 1 has multiple matching Lab records)
-- 2. Boundary condition T2.C4 > 10 vs >= 10, < 10, = 10, or NULL (Patients 2, 3, 4)
-- 3. Logical AND vs OR in WHERE clause
-- 4. Exact match vs LIKE '%APS%' or case-insensitivity on T1.Diagnosis (Patients 5, 6, 7)
-- 5. INNER JOIN vs LEFT JOIN (Patient 8 has no Laboratory records)
-- 6. Wrong column reference: T2.C3 vs T2.C4 (Patient 3 has C3 > 10 but C4 = 5)
-- 7. Wrong table reference: Examination.Diagnosis vs Patient.Diagnosis (Patient 5 has 'APS' in Examination, not Patient)
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (1, 'F', 'APS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (2, 'M', 'APS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (3, 'F', 'APS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (4, 'M', 'APS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (5, 'F', 'SLE');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (6, 'M', 'APS, SLE');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (7, 'F', 'aps');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (8, 'F', 'APS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (9, 'M', NULL);
INSERT INTO Laboratory (ID, Date, C3, C4) VALUES (1, '2020-01-01', 5, 11);
INSERT INTO Laboratory (ID, Date, C3, C4) VALUES (1, '2020-01-02', 5, 25);
INSERT INTO Laboratory (ID, Date, C3, C4) VALUES (1, '2020-01-03', 5, 10);
INSERT INTO Laboratory (ID, Date, C3, C4) VALUES (2, '2020-01-01', 20, 10);
INSERT INTO Laboratory (ID, Date, C3, C4) VALUES (3, '2020-01-01', 20, 5);
INSERT INTO Laboratory (ID, Date, C3, C4) VALUES (4, '2020-01-01', 20, NULL);
INSERT INTO Laboratory (ID, Date, C3, C4) VALUES (5, '2020-01-01', 20, 15);
INSERT INTO Laboratory (ID, Date, C3, C4) VALUES (6, '2020-01-01', 20, 15);
INSERT INTO Laboratory (ID, Date, C3, C4) VALUES (7, '2020-01-01', 20, 15);
INSERT INTO Laboratory (ID, Date, C3, C4) VALUES (9, '2020-01-01', 20, 15);
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (1, '2020-01-01', 'SLE');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (5, '2020-01-01', 'APS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (8, '2020-01-01', 'APS');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.C4 > 10 AND T1.Diagnosis = 'APS';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) AS count_of_patients FROM Examination AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Thrombosis = '1' AND T2.C4 > 10;

/*
Prediction Result:
(0,)
*/