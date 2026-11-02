-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (1, 'F', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (2, 'F', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (3, 'M', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (4, 'F', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (5, 'M', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (6, 'F', '-', 'SLE');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (7, 'M', '-', 'SLE');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (8, 'F', NULL, 'SLE');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (9, 'M', '?', 'SLE');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (10, 'F', '+', 'RA');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (11, 'F', '+', 'RA');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (12, 'M', '+', 'RA');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (13, 'F', '+', 'SLE, RA');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (14, 'M', '+', 'SLE, APS');
INSERT INTO Patient (ID, SEX, Admission, Diagnosis) VALUES (15, 'F', NULL, NULL);
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (6, '2020-01-01', 'SLE');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (6, '2020-02-01', 'SLE');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (6, '2020-03-01', 'SLE');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (10, '2020-01-01', 'SLE');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (11, '2020-01-01', 'SLE');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (12, '2020-01-01', 'SLE');
INSERT INTO Laboratory (ID, Date, GOT) VALUES (6, '2020-01-01', 20);
INSERT INTO Laboratory (ID, Date, GOT) VALUES (6, '2020-02-01', 25);
INSERT INTO Laboratory (ID, Date, GOT) VALUES (6, '2020-03-01', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN Admission = '+' THEN 1 ELSE 0 END) / SUM(CASE WHEN Admission = '-' THEN 1 ELSE 0 END) FROM Patient WHERE Diagnosis = 'SLE';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT CAST((SELECT COUNT(ID) FROM Patient WHERE Diagnosis = 'SLE' AND Admission = '+') AS REAL) / CAST((SELECT COUNT(ID) FROM Patient WHERE Diagnosis = 'SLE' AND Admission = '-') AS REAL) AS inpatient_outpatient_ratio;

/*
Prediction Result:
(2.5,)
*/