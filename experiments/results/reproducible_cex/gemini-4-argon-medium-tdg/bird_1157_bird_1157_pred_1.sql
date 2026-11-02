-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. DISTINCT keyword: Patient 1 has multiple matching Examination records with Thrombosis = 2.
-- 2. Column ambiguity: T1.Diagnosis vs T2.Diagnosis.
-- 3. Boundary values for WHERE clause: Thrombosis = 1, 2, 3, 0, NULL.
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (1, 'F', 'SLE');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (2, 'M', 'APS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (3, 'F', 'RA');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (4, 'M', 'SJS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (1, '2020-01-01', 'Exam_SLE_A', 2);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (1, '2020-06-01', 'Exam_SLE_B', 2);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (2, '2020-02-01', 'Exam_APS', 1);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (3, '2020-03-01', 'Exam_RA', 3);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (4, '2020-04-01', 'Exam_SJS_Null', NULL);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (4, '2020-05-01', 'Exam_SJS_Zero', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T1.SEX, T1.Diagnosis FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2.Thrombosis = 2;

/*
Gold Result:
(1, 'F', 'SLE')
*/

-- Prediction Query
SELECT Patient.ID, Patient.SEX, Patient.Diagnosis FROM Examination INNER JOIN Patient ON Examination.ID = Patient.ID WHERE Examination.Thrombosis = 2;

/*
Prediction Result:
(1, 'F', 'SLE')
(1, 'F', 'SLE')
*/