-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. DISTINCT keyword: Patient 1 has multiple Laboratory records with LDH > 500. Without DISTINCT, Patient 1 appears twice.
-- 2. Boundary conditions for LDH > 500: Tests LDH = 500 (false), LDH = 501 (true), LDH = 499 (false), LDH IS NULL (false).
-- 3. Column Confusion: GOT, GPT, ALP, CPK set to > 500 while LDH <= 500 to kill mutants filtering on the wrong enzyme column.
-- 4. Date Confusion: Birthday, Description, "First Date", and Laboratory.Date all have distinct values for Patient 1 to kill mutants projecting the wrong date column.
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1980-05-15', '2020-01-01', '2019-06-01', '1', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1975-10-20', '2020-02-01', '2019-07-01', '0', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'F', '1990-12-01', '2020-03-01', '2019-08-01', '1', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'M', '1965-03-25', '2020-04-01', '2019-09-01', '0', 'MCTD');
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, CPK) VALUES (1, '2021-01-10', 20, 30, 501, 100, 50);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, CPK) VALUES (1, '2021-01-15', 25, 35, 650, 110, 60);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, CPK) VALUES (2, '2021-02-10', 600, 600, 500, 600, 600);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, CPK) VALUES (3, '2021-03-10', 700, 700, 499, 700, 700);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, CPK) VALUES (4, '2021-04-10', 800, 800, NULL, 800, 800);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T1.SEX, T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.LDH > 500;

/*
Gold Result:
(1, 'F', '1980-05-15')
*/

-- Prediction Query
SELECT "patient"."id", "patient"."sex", "patient"."birthday" FROM "patient" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" WHERE "laboratory"."ldh" > 500;

/*
Prediction Result:
(1, 'F', '1980-05-15')
(1, 'F', '1980-05-15')
*/