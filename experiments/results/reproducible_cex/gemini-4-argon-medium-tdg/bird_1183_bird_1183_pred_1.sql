-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests missing join match on T2."Examination Date" = T1."First Date" (patient matches subquery, has examinations, but none on their First Date) and tests LEFT JOIN / inner join mutations.
INSERT INTO Patient (ID, "First Date", Diagnosis) VALUES (1, '1990-01-01', 'Should_Not_Be_Returned');
INSERT INTO Patient (ID, "First Date", Diagnosis) VALUES (2, '1992-06-15', 'Decoy_Matching_First_Date_Only');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (1, '1997-01-27', 'SLE');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (1, '1991-01-01', 'SLE');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (2, '1992-06-15', 'SLE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T1.ID = (SELECT ID FROM Examination WHERE "Examination Date" = '1997-01-27' AND Diagnosis = 'SLE') AND T2."Examination Date" = T1."First Date";

/*
Gold Result:
*/

-- Prediction Query
SELECT Patient.Diagnosis FROM Patient INNER JOIN Examination ON Patient.ID = Examination.ID WHERE Examination.Diagnosis = 'SLE' AND Examination."Examination Date" = '1997-01-27';

/*
Prediction Result:
('Should_Not_Be_Returned',)
*/