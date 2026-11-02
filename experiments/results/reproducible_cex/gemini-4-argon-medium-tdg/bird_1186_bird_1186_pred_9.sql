-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests Diagnosis exact string matching ('Behcet') vs substrings ('Behcet''s', 'Behcet Disease'), different diagnoses ('SLE'), case sensitivity ('behcet'), and Logical AND vs OR.
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (10, 'M', 'Behcet');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (11, 'F', 'SLE');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (12, 'M', 'Behcet''s');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (13, 'F', 'behcet');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (14, 'M', 'Behcet');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (10, '1997-05-20', 'Behcet');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (11, '1997-05-20', 'SLE');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (12, '1997-05-20', 'Behcet''s');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (13, '1997-05-20', 'behcet');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (14, '1995-05-20', 'Behcet');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ID FROM Examination WHERE "Examination Date" BETWEEN '1997-01-01' AND '1997-12-31' AND Diagnosis = 'Behcet';

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2.Diagnosis LIKE '%Behcet%' AND STRFTIME('%Y', T2."Examination Date") = '1997';

/*
Prediction Result:
(10,)
(12,)
(13,)
*/