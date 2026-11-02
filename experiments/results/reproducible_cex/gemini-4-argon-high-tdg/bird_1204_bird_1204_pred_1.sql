-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (821297, 'F', '1970-01-05', '2009-01-10', '2010-02-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (821298, 'F', '1975-03-02', '2005-04-06', '2010-06-25', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (821299, 'M', '1982-11-14', '2011-01-08', '2011-03-05', '-', 'RA');
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (821297, '2010-02-28', 1.2, 0.8, 40, 'S', 0, 'SLE', '-', '-', '-', 'arthralgia', 0);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (821298, '2012-08-10', 5.4, 2.1, 160, 'H', 1, 'APS', '+', '+', '+', 'thrombosis', 1);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (821299, '2011-03-20', 0.5, 0.4, 0, NULL, 0, 'RA', '-', '-', '-', NULL, 0);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB) VALUES (821298, '2012-08-19', 22, 18, 190, 210, 7.2, 4.1);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB) VALUES (821298, '2012-09-21', 25, 20, 195, 215, 7.0, 4.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STRFTIME('%d', T3."Examination Date") - STRFTIME('%d', T1."First Date") FROM Patient AS T1 INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T1.ID = 821298;

/*
Gold Result:
(-15,)
*/

-- Prediction Query
SELECT JULIANDAY(E."Examination Date") - JULIANDAY(P."First Date") AS Days FROM Examination AS E INNER JOIN Patient AS P ON E.ID = P.ID WHERE P.ID = 821298;

/*
Prediction Result:
(777.0,)
*/