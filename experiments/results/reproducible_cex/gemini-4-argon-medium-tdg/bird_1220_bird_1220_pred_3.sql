-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. DISTINCT vs non-DISTINCT (Patient 1 has two Laboratory records with UN = 29).
-- 2. Boundary conditions on WHERE T2.UN = 29 (Patient 2 has UN = 28, Patient 3 has UN = 30, Patient 4 has UN IS NULL).
-- 3. INNER JOIN vs LEFT JOIN (Patient 5 has no Laboratory records).
-- 4. Column selection confusion (Birthday vs Description vs First Date; UN vs GOT/UA/CRE).
-- 5. Table confusion (Examination table vs Laboratory table).
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1980-05-15', '2020-01-01', '2019-12-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1975-08-20', '2020-02-01', '2019-11-01', '-', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'F', '1990-11-30', '2020-03-01', '2019-10-01', '+', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'M', '1965-02-10', '2020-04-01', '2019-09-01', '-', 'SS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'F', '2000-07-07', '2020-05-01', '2019-08-01', '+', 'MCTD');
INSERT INTO Laboratory (ID, Date, UN, GOT, GPT, UA, CRE) VALUES (1, '2021-01-10', 29, 15, 20, 5.5, 0.8);
INSERT INTO Laboratory (ID, Date, UN, GOT, GPT, UA, CRE) VALUES (1, '2021-02-15', 29, 18, 22, 5.6, 0.9);
INSERT INTO Laboratory (ID, Date, UN, GOT, GPT, UA, CRE) VALUES (1, '2021-03-20', 15, 29, 29, 29.0, 29.0);
INSERT INTO Laboratory (ID, Date, UN, GOT, GPT, UA, CRE) VALUES (2, '2021-01-12', 28, 29, 29, 29.0, 29.0);
INSERT INTO Laboratory (ID, Date, UN, GOT, GPT, UA, CRE) VALUES (3, '2021-01-14', 30, 29, 29, 29.0, 29.0);
INSERT INTO Laboratory (ID, Date, UN, GOT, GPT, UA, CRE) VALUES (4, '2021-01-16', NULL, 29, 29, 29.0, 29.0);
INSERT INTO Examination (ID, "Examination Date", ANA, "aCL IgA", Thrombosis) VALUES (2, '2021-01-12', 29, 29, 29);
INSERT INTO Examination (ID, "Examination Date", ANA, "aCL IgA", Thrombosis) VALUES (5, '2021-01-18', 29, 29, 29);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T1.SEX, T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.UN = 29;

/*
Gold Result:
(1, 'F', '1980-05-15')
*/

-- Prediction Query
SELECT p.ID, p.SEX, p.Birthday FROM Patient AS p JOIN Laboratory AS l ON p.ID = l.ID WHERE l.UN = 29;

/*
Prediction Result:
(1, 'F', '1980-05-15')
(1, 'F', '1980-05-15')
*/