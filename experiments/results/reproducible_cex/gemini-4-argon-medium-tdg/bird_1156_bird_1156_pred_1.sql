-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. DISTINCT necessity (Patient 1 has multiple examinations with RVVT = '+').
-- 2. WHERE filter accuracy (Patient 2 has RVVT = '-', Patient 4 has RVVT = NULL).
-- 3. Wrong column selected in WHERE (e.g., KCT or LAC = '+' when RVVT is not '+').
-- 4. INNER JOIN vs LEFT JOIN (Patient 3 has no Examination records).
-- 5. Exact year subtraction vs Julian/date difference (Patient 1 born late in the year, Patient 5 born early in the year).
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1980-12-31', '2020-01-01', '2019-05-10', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1990-06-15', '2020-02-01', '2019-06-11', '-', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'F', '1975-03-20', '2020-03-01', '2019-07-12', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'M', '2000-01-01', '2020-04-01', '2019-08-13', '-', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'F', '1985-01-02', '2020-05-01', '2019-09-14', '+', 'APS');
INSERT INTO Examination (ID, "Examination Date", RVVT, KCT, LAC, Thrombosis) VALUES (1, '2021-01-10', '+', '-', '-', 1);
INSERT INTO Examination (ID, "Examination Date", RVVT, KCT, LAC, Thrombosis) VALUES (1, '2021-06-15', '+', '+', '+', 0);
INSERT INTO Examination (ID, "Examination Date", RVVT, KCT, LAC, Thrombosis) VALUES (2, '2021-02-20', '-', '+', '+', 1);
INSERT INTO Examination (ID, "Examination Date", RVVT, KCT, LAC, Thrombosis) VALUES (4, '2021-03-25', NULL, '+', '+', 0);
INSERT INTO Examination (ID, "Examination Date", RVVT, KCT, LAC, Thrombosis) VALUES (5, '2021-04-30', '+', '-', '-', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2.RVVT = '+';

/*
Gold Result:
(1, 45)
(5, 40)
*/

-- Prediction Query
SELECT "patient"."id", (STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', "patient"."birthday")) AS age FROM "patient" INNER JOIN "examination" ON "patient"."id" = "examination"."id" WHERE "examination"."rvvt" = '+';

/*
Prediction Result:
(1, 45)
(1, 45)
(5, 40)
*/