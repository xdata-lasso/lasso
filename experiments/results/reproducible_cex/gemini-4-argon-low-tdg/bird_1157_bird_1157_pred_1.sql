-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. DISTINCT necessity (Patient 1 has two examinations with Thrombosis = 2).
-- 2. Column ambiguity between Patient.Diagnosis and Examination.Diagnosis (Patient 1 has 'SLE' vs 'APS').
-- 3. WHERE clause filtering for Thrombosis = 2 vs 1, 0, 3, and NULL.
-- 4. INNER JOIN vs LEFT JOIN (Patient 5 has no Examination records).
-- 5. Cross-join / missing join condition detection.
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1980-01-01', '2000-01-01', '2000-01-05', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1975-05-12', '2001-03-10', '2001-03-15', '-', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'F', '1990-08-22', '2002-07-01', '2002-07-02', '+', 'MCTD');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'M', '1965-11-30', '1999-12-12', '1999-12-20', '-', 'SSc');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'F', '1988-04-18', '2003-02-28', '2003-03-01', '+', 'SJS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (1, '2000-02-01', 'APS', 2);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (1, '2000-06-01', 'APS_2', 2);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (1, '2000-09-01', 'SLE', 1);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (2, '2001-04-01', 'RA', 1);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (2, '2001-05-01', 'RA', 0);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (3, '2002-08-01', 'MCTD', 3);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (4, '2000-01-01', 'SSc', NULL);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (NULL, '2004-01-01', 'Unknown', 2);
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