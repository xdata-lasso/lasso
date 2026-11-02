-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1965-04-12', '1995-02-10', '1995-01-15', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1970-08-22', '1996-05-18', '1996-03-12', '-', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'M', '1958-11-30', '1994-09-01', '1994-08-20', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'F', '1997-01-01', '1997-03-10', '1997-03-10', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'F', '1980-06-15', '1997-07-01', '1997-06-01', '-', 'RA');
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (1, '1997-05-14', 12.5, 4.2, 160, 'S', 0, 'SLE', '+', '+', '+', 'CNS', 1);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (2, '1997-08-20', 25.0, 8.1, 80, 'H', 1, 'APS', '-', '+', '+', 'DVT', 1);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (3, '1997-11-03', 5.0, 1.2, 40, 'S', 0, 'SLE', '-', '-', '-', 'PE', 1);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (4, '1998-04-10', 18.0, 3.5, 320, 'P', 2, 'SLE', '+', '-', '+', 'Thrombosis', 1);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (5, '1997-09-12', 1.0, 0.5, 0, NULL, 0, 'Thrombosis', '-', '-', '-', 'arthralgia', 0);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB) VALUES (1, '1997-05-10', 20, 18, 150, 120, 7.2, 4.1);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB) VALUES (1, '1997-05-14', 22, 19, 155, 125, 7.0, 4.0);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB) VALUES (4, '1997-04-10', 30, 25, 180, 140, 6.8, 3.8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.SEX = 'F' THEN 1 ELSE 0 END) AS REAL) / COUNT(*) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T2."Examination Date") = '1997' AND T2.Thrombosis = 1;

/*
Gold Result:
(0.3333333333333333,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2."Examination Date" LIKE '1997%' AND T2.Thrombosis = 1 AND T1.SEX = 'F';

/*
Prediction Result:
(1,)
*/