-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. DISTINCT necessity (Patient 1 has multiple qualifying Lab records).
-- 2. Boundary condition for HGB < 10 (Patient 2 has HGB = 10.0, Patient 3 has HGB = 9.9, Patient 4 has HGB = 10.5).
-- 3. Admission = '-' condition vs '+', NULL, or other values.
-- 4. INNER JOIN vs LEFT JOIN (Patient 7 has Admission = '-' but no Lab records).
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (1, 'F', '-', 'SLE');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (2, 'M', '-', 'RA');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (3, 'F', '-', 'APS');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (4, 'M', '-', 'SLE');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (5, 'F', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (6, 'M', NULL, 'SLE');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (7, 'F', '-', 'MCTD');
INSERT INTO Laboratory (ID, Date, HGB, HCT, WBC, RBC) VALUES (1, '2020-01-01', 8.5, 8.5, 8.5, 8.5);
INSERT INTO Laboratory (ID, Date, HGB, HCT, WBC, RBC) VALUES (1, '2020-01-02', 9.2, 9.2, 9.2, 9.2);
INSERT INTO Laboratory (ID, Date, HGB, HCT, WBC, RBC) VALUES (2, '2020-01-01', 10.0, 9.0, 9.0, 9.0);
INSERT INTO Laboratory (ID, Date, HGB, HCT, WBC, RBC) VALUES (3, '2020-01-01', 9.9, 12.0, 12.0, 12.0);
INSERT INTO Laboratory (ID, Date, HGB, HCT, WBC, RBC) VALUES (4, '2020-01-01', 10.5, 8.0, 8.0, 8.0);
INSERT INTO Laboratory (ID, Date, HGB, HCT, WBC, RBC) VALUES (5, '2020-01-01', 7.5, 7.5, 7.5, 7.5);
INSERT INTO Laboratory (ID, Date, HGB, HCT, WBC, RBC) VALUES (6, '2020-01-01', 6.5, 6.5, 6.5, 6.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T1.SEX FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.HGB < 10 AND T1.Admission = '-';

/*
Gold Result:
(1, 'F')
(3, 'F')
*/

-- Prediction Query
SELECT P.ID, P.SEX FROM Patient AS P INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE P.Admission = '-' AND L.HGB < 10;

/*
Prediction Result:
(1, 'F')
(1, 'F')
(3, 'F')
*/