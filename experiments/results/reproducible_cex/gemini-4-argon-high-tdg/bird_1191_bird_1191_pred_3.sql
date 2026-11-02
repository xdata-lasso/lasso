-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'M', '1950-01-01', '1990-01-01', '1981-05-10', '+', 'BEHCET');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1981-02-02', '1981-03-03', '1981-08-20', '-', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'M', '1960-06-15', '1985-07-20', '1981-12-31', '+', NULL);
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'F', '1955-04-12', '1981-06-01', '1981-03-15', '+', 'BEHCET');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'M', '1981-04-10', '1981-05-10', '1980-12-31', '+', 'BEHCET');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (6, 'M', '1952-09-09', '1983-01-01', '1982-01-01', '-', 'BEHCET');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (7, NULL, '1958-11-11', '1984-02-02', '1981-06-01', '+', 'BEHCET');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (8, 'M', '1959-10-10', '1981-10-10', NULL, '+', 'BEHCET');
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (1, '1981-05-15', 'SLE', 0);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (1, '1981-06-15', 'SLE', 1);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (4, '1981-03-20', 'BEHCET', 0);
INSERT INTO Laboratory (ID, Date, GOT, GPT) VALUES (1, '1981-05-10', 20, 25);
INSERT INTO Laboratory (ID, Date, GOT, GPT) VALUES (1, '1981-05-12', 22, 27);
INSERT INTO Laboratory (ID, Date, GOT, GPT) VALUES (2, '1981-08-20', 18, 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN Diagnosis = 'BEHCET' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(ID) FROM Patient WHERE STRFTIME('%Y', "First Date") = '1981' AND SEX = 'M';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN Diagnosis = 'BEHCET' THEN 1 ELSE 0 END) AS REAL) / COUNT(*)) * 100 AS percentage FROM Patient WHERE SEX = 'M' AND STRFTIME('%Y', "First Date") = '1981';

/*
Prediction Result:
(33.33333333333333,)
*/