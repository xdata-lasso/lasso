-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. DISTINCT keyword: Patient 1 has multiple Laboratory records with LDH > 500.
-- 2. Boundary condition (> 500 vs >= 500): Patient 2 has LDH = 500.
-- 3. Off-by-one (> 500 vs > 501): Patient 3 has LDH = 501.
-- 4. Less than condition & NULL handling: Patient 4 has LDH < 500 and LDH IS NULL.
-- 5. INNER JOIN vs LEFT JOIN: Patient 5 has no Laboratory records.
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'M', '1980-01-01', '2020-01-01', '2020-01-01', 'Yes', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'F', '1985-05-05', '2020-02-02', '2020-02-02', 'No', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'M', '1990-10-10', '2020-03-03', '2020-03-03', 'Yes', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'F', '1995-12-12', '2020-04-04', '2020-04-04', 'No', 'MCTD');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'M', '2000-06-06', '2020-05-05', '2020-05-05', 'Yes', 'SSc');
INSERT INTO Laboratory (ID, Date, LDH, GOT, GPT, ALP) VALUES (1, '2021-01-01', 600, 500, 400, 300);
INSERT INTO Laboratory (ID, Date, LDH, GOT, GPT, ALP) VALUES (1, '2021-01-02', 750, 200, 100, 150);
INSERT INTO Laboratory (ID, Date, LDH, GOT, GPT, ALP) VALUES (2, '2021-01-01', 500, 600, 600, 600);
INSERT INTO Laboratory (ID, Date, LDH, GOT, GPT, ALP) VALUES (3, '2021-01-01', 501, 100, 100, 100);
INSERT INTO Laboratory (ID, Date, LDH, GOT, GPT, ALP) VALUES (4, '2021-01-01', 499, 700, 700, 700);
INSERT INTO Laboratory (ID, Date, LDH, GOT, GPT, ALP) VALUES (4, '2021-01-02', NULL, 800, 800, 800);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T1.SEX, T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.LDH > 500;

/*
Gold Result:
(1, 'M', '1980-01-01')
(3, 'M', '1990-10-10')
*/

-- Prediction Query
SELECT Patient.ID, Patient.SEX, Patient.Birthday FROM Laboratory INNER JOIN Patient ON Laboratory.ID = Patient.ID WHERE Laboratory.LDH > 500;

/*
Prediction Result:
(1, 'M', '1980-01-01')
(1, 'M', '1980-01-01')
(3, 'M', '1990-10-10')
*/