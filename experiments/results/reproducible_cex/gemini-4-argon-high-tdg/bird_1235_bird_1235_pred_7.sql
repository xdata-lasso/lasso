-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1985-12-30', '2010-05-10', '2012-03-15', 'F', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1978-06-20', '2011-04-12', '2013-07-19', 'T', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'F', '1992-11-15', '2015-01-20', '2016-08-01', 'F', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'M', '1965-02-10', '2008-09-09', '2009-10-10', 'T', 'SJS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'F', '2000-07-01', '2018-11-11', '2019-12-12', 'F', 'MCTD');
INSERT INTO Laboratory (ID, Date, WBC, RBC, HGB, HCT, TP, ALB, CRE, PT, FG) VALUES (1, '2020-01-10', 6.5, 3.49, 12.0, 36.0, 7.2, 4.1, 4.0, 11.5, 250.0);
INSERT INTO Laboratory (ID, Date, WBC, RBC, HGB, HCT, TP, ALB, CRE, PT, FG) VALUES (2, '2020-02-15', 2.1, 3.5, 2.9, 3.1, 3.0, 2.5, 0.8, 2.0, 2.5);
INSERT INTO Laboratory (ID, Date, WBC, RBC, HGB, HCT, TP, ALB, CRE, PT, FG) VALUES (3, '2020-03-20', 5.0, 3.0, 11.2, 34.5, 6.8, 3.9, 3.8, 12.0, 300.0);
INSERT INTO Laboratory (ID, Date, WBC, RBC, HGB, HCT, TP, ALB, CRE, PT, FG) VALUES (4, '2020-04-25', 2.8, 3.51, 3.2, 3.4, 3.1, 2.8, 1.1, 1.5, 1.8);
INSERT INTO Laboratory (ID, Date, WBC, RBC, HGB, HCT, TP, ALB, CRE, PT, FG) VALUES (5, '2020-05-30', 2.5, NULL, 2.8, 3.0, 2.9, 2.4, 0.7, 1.9, 2.1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis, T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.RBC < 3.5;

/*
Gold Result:
('SLE', 1, 40)
('APS', 3, 33)
*/

-- Prediction Query
SELECT patient.id, patient.diagnosis, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', patient.birthday) AS age FROM patient INNER JOIN laboratory ON patient.id = laboratory.id WHERE laboratory.rbc < 3.5;

/*
Prediction Result:
(1, 'SLE', 40)
(3, 'APS', 33)
*/