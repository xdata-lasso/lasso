-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. DISTINCT keyword (Patient 1 has multiple Laboratory rows with ALB < 3.5).
-- 2. Boundary condition ALB < 3.5 (Patient 2 has ALB = 3.5, which should be excluded).
-- 3. Wrong column confusion (TP < 3.5 vs ALB < 3.5 on Patient 2).
-- 4. Wrong table confusion (Patient 3 has Examination record, no Laboratory record).
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1980-01-01', '2020-01-01', '2020-01-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1975-05-12', '2020-02-01', '2020-02-01', '-', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'F', '1990-08-20', '2020-03-01', '2020-03-01', '+', 'APS');
INSERT INTO Laboratory (ID, Date, ALB, TP) VALUES (1, '2020-01-10', 3.4, 7.0);
INSERT INTO Laboratory (ID, Date, ALB, TP) VALUES (1, '2020-01-15', 2.8, 6.5);
INSERT INTO Laboratory (ID, Date, ALB, TP) VALUES (2, '2020-02-10', 3.5, 3.2);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", Diagnosis) VALUES (3, '2020-03-10', 2.1, 'APS_Exam');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T1.SEX, T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.ALB < 3.5;

/*
Gold Result:
(1, 'F', 'SLE')
*/

-- Prediction Query
SELECT p.ID, p.SEX, p.Diagnosis FROM Patient AS p JOIN Laboratory AS l ON p.ID = l.ID WHERE l.ALB < 3.5;

/*
Prediction Result:
(1, 'F', 'SLE')
(1, 'F', 'SLE')
*/