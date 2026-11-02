-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'M', '1970-01-15', '1995-05-10', '1995-05-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1965-03-20', '1996-02-11', '1996-01-15', '-', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'M', '1980-07-08', '1997-08-21', '1997-08-01', '-', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'M', '1955-11-30', '1994-12-05', '1994-11-20', '-', 'MCTD');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'F', '1972-04-12', '1996-06-18', '1996-06-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (6, 'F', '1968-09-25', '1997-03-14', '1997-03-01', '+', 'PSS');
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (1, '1995-05-12', 12.5, 4.2, 160, 'S', 2, 'SLE', '+', '-', '+', 'fever', 1);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (1, '1995-06-15', 10.1, 3.8, 80, 'S', 1, 'SLE', '-', '-', '-', 'none', 0);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB, UA, UN, CRE, WBC, RBC, HGB, HCT, PLT) VALUES (1, '1995-05-10', 25, 30, 180, 210, 7.2, 4.1, 5.5, 14, 0.8, 6.5, 4.5, 14.2, 42.0, 250);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB, UA, UN, CRE, WBC, RBC, HGB, HCT, PLT) VALUES (1, '1995-06-10', 22, 28, 175, 200, 7.0, 4.0, 5.2, 13, 0.7, 6.2, 4.4, 14.0, 41.5, 240);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN Admission = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / SUM(CASE WHEN Admission = '-' THEN 1 ELSE 0 END) FROM Patient WHERE SEX = 'M';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT (CAST(COUNT(CASE WHEN T1.Admission = '+' THEN T1.ID ELSE NULL END) AS REAL) * 100) / COUNT(T1.ID) - (CAST(COUNT(CASE WHEN T1.Admission = '-' THEN T1.ID ELSE NULL END) AS REAL) * 100) / COUNT(T1.ID) AS PercentageDeviation FROM Patient AS T1 WHERE T1.SEX = 'M';

/*
Prediction Result:
(-50.0,)
*/