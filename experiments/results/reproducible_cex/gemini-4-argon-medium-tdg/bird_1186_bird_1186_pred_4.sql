-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact date boundaries (1997-01-01, 1997-12-31) vs off-by-one dates (1996-12-31, 1998-01-01) and mid-year date.
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'M', '1960-01-01', '1997-01-01', '1997-01-01', '+', 'Behcet');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'F', '1965-05-05', '1997-06-15', '1997-06-15', '+', 'Behcet');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'M', '1970-10-10', '1997-12-31', '1997-12-31', '+', 'Behcet');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'F', '1975-12-12', '1996-12-31', '1996-12-31', '-', 'Behcet');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'M', '1980-03-03', '1998-01-01', '1998-01-01', '-', 'Behcet');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (1, '1997-01-01', 'Behcet');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (2, '1997-06-15', 'Behcet');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (3, '1997-12-31', 'Behcet');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (4, '1996-12-31', 'Behcet');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (5, '1998-01-01', 'Behcet');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ID FROM Examination WHERE "Examination Date" BETWEEN '1997-01-01' AND '1997-12-31' AND Diagnosis = 'Behcet';

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT DISTINCT e.ID FROM Examination AS e JOIN Patient AS p ON e.ID = p.ID WHERE p.Diagnosis = 'BEHCET' AND e."Examination Date" >= '1997-01-01' AND e."Examination Date" < '1998-01-01';

/*
Prediction Result:
*/