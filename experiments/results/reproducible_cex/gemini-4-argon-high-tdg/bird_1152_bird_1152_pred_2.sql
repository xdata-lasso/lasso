-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1980-01-10', '2005-03-01', '2004-01-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'F', '1981-02-11', '2005-03-02', '2004-02-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'M', '1979-03-12', '2005-03-03', '2004-03-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'F', '1982-04-13', '2005-03-04', '2004-04-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'F', '1983-05-14', '2005-03-05', '2004-05-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (6, 'M', '1984-06-15', '2005-03-06', '2004-06-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (7, 'F', '1985-07-16', '2005-03-07', '2004-07-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (8, 'F', '1975-08-17', '2005-03-08', '2003-08-01', '-', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (9, 'M', '1976-09-18', '2005-03-09', '2003-09-01', '-', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (10, 'F', '1977-10-19', '2005-03-10', '2003-10-01', NULL, 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (11, 'F', '1978-11-20', '2005-03-11', '2003-11-01', '+-', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (12, 'F', '1970-01-01', '2005-04-01', '2002-01-01', '-', 'SLE, APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (13, 'F', '1971-01-01', '2005-04-02', '2002-02-01', '-', 'SLE, APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (14, 'F', '1972-01-01', '2005-04-03', '2002-03-01', '-', 'SLE, APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (15, 'F', '1973-01-01', '2005-04-04', '2002-04-01', '-', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (16, 'M', '1974-01-01', '2005-04-05', '2002-05-01', '-', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (17, 'F', '1969-01-01', '2005-04-06', '2002-06-01', '-', 'RA');
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (1, '2005-05-01', 10.5, 5.2, 640, 'S', 0, 'APS', '-', '-', '-', 'arthralgia', 0);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (8, '2005-05-02', 20.1, 8.4, 320, 'H', 1, 'APS', '-', '-', '-', 'fever', 0);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (8, '2005-06-02', 22.0, 9.0, 320, 'H', 1, 'APS', '-', '-', '-', 'fever', 0);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (8, '2005-07-02', 19.5, 7.5, 160, 'H', 0, 'APS', '-', '-', '-', 'fever', 0);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (8, '2005-08-02', 18.0, 7.0, 160, 'H', 0, 'APS', '-', '-', '-', 'fever', 0);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (15, '2005-05-10', 40.0, 15.0, 1280, 'S', 2, 'SLE', '+', '+', '+', 'thrombosis', 1);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (16, '2005-05-11', 35.0, 12.0, 640, 'S', 1, 'SLE', '+', '+', '+', 'thrombosis', 1);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB, WBC, RBC, HGB, HCT, PLT) VALUES (8, '2005-05-02', 25, 20, 180, 210, 7.2, 4.1, 5.5, 4.5, 13.5, 40.0, 220);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB, WBC, RBC, HGB, HCT, PLT) VALUES (8, '2005-06-02', 28, 22, 190, 215, 7.1, 4.0, 5.2, 4.4, 13.2, 39.5, 210);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB, WBC, RBC, HGB, HCT, PLT) VALUES (8, '2005-07-02', 24, 19, 175, 205, 7.3, 4.2, 5.8, 4.6, 13.8, 41.0, 230);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB, WBC, RBC, HGB, HCT, PLT) VALUES (8, '2005-08-02', 26, 21, 185, 220, 7.0, 3.9, 5.0, 4.3, 13.0, 39.0, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN Admission = '+' THEN 1 ELSE 0 END) / SUM(CASE WHEN Admission = '-' THEN 1 ELSE 0 END) FROM Patient WHERE Diagnosis = 'SLE';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT (SELECT COUNT("id") FROM "patient" WHERE "diagnosis" = 'SLE' AND "admission" = '-') * 1.0 / (SELECT COUNT("id") FROM "patient" WHERE "diagnosis" = 'SLE' AND "admission" = '+') AS ratio;

/*
Prediction Result:
(0.2857142857142857,)
*/