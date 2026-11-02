-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic logical predicates (AND vs OR, inequality operators, NULL handling) and aggregation (COUNT vs SUM/MAX/MIN).
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (10, 'F', '1980-01-01', '2000-01-01', '2000-01-01', '+', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (20, 'F', '1982-05-12', '2001-03-15', '2001-03-15', '-', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (30, 'F', '1975-08-20', '1999-11-11', '1999-11-11', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (40, 'M', '1990-02-28', '2005-07-07', '2005-07-07', '+', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (50, 'M', '1965-12-01', '1995-04-20', '1995-04-20', '-', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (60, NULL, '1988-09-09', '2002-02-02', '2002-02-02', '+', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (70, 'F', '1992-06-15', '2008-08-08', '2008-08-08', '-', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(ID) FROM Patient WHERE SEX = 'F' AND Diagnosis = 'APS';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T1.SEX = 'F' AND T2.Diagnosis = 'APS';

/*
Prediction Result:
(0,)
*/