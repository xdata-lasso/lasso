-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1980-05-12', '2000-01-10', '1999-11-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1975-03-22', '2001-02-15', '2000-06-10', '-', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'F', '1990-08-30', '2002-07-20', '2002-01-05', '+', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'M', '1965-12-01', '2003-04-11', '2001-09-19', '-', 'SJS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'F', '1988-01-17', '2004-05-05', '2003-12-12', '+', 'MCTD');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (6, 'M', '1970-09-09', '2005-08-08', '2004-03-03', '-', 'PSS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Symptoms, Thrombosis) VALUES (1, '2000-02-01', 'APS', 'headache', 2);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Symptoms, Thrombosis) VALUES (1, '2000-06-01', 'SLE, APS', 'fever', 2);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Symptoms, Thrombosis) VALUES (2, '2001-03-01', 'APS', 'none', 1);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Symptoms, Thrombosis) VALUES (3, '2002-08-01', 'RA', 'joint pain', 0);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Symptoms, Thrombosis) VALUES (4, '2003-05-01', 'SJS', 'dry eyes', 3);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Symptoms, Thrombosis) VALUES (5, '2004-06-01', 'MCTD', 'fatigue', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T1.SEX, T1.Diagnosis FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2.Thrombosis = 2;

/*
Gold Result:
(1, 'F', 'SLE')
*/

-- Prediction Query
SELECT Patient.ID, Patient.SEX, Patient.Diagnosis AS disease FROM Patient INNER JOIN Examination ON Patient.ID = Examination.ID WHERE Examination.Thrombosis = 2;

/*
Prediction Result:
(1, 'F', 'SLE')
(1, 'F', 'SLE')
*/