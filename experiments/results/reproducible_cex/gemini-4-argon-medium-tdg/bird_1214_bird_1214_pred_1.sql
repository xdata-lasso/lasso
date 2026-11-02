-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Boundary conditions on TP (< 6.0 vs = 6.0 vs > 6.0 vs NULL), DISTINCT requirement (multiple qualifying rows per patient), INNER JOIN vs LEFT JOIN (patient with no laboratory records), and column confusion (ALB < 6.0 while TP >= 6.0).
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1980-05-15', '2020-01-01', '2019-12-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1975-10-20', '2020-02-01', '2020-01-15', '-', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'F', '1990-03-10', '2020-03-01', '2020-02-20', '+', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'M', '1965-07-30', '2020-04-01', '2020-03-25', '-', 'SJS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'F', '2000-11-11', '2020-05-01', '2020-04-10', '+', 'MCTD');
INSERT INTO Laboratory (ID, Date, TP, ALB, GOT, GPT) VALUES (1, '2020-01-10', 5.9, 7.0, 20, 25);
INSERT INTO Laboratory (ID, Date, TP, ALB, GOT, GPT) VALUES (1, '2020-01-20', 4.5, 6.5, 22, 28);
INSERT INTO Laboratory (ID, Date, TP, ALB, GOT, GPT) VALUES (2, '2020-02-10', 6.0, 4.0, 18, 19);
INSERT INTO Laboratory (ID, Date, TP, ALB, GOT, GPT) VALUES (3, '2020-03-10', 6.1, 3.5, 30, 35);
INSERT INTO Laboratory (ID, Date, TP, ALB, GOT, GPT) VALUES (4, '2020-04-10', NULL, 4.2, 15, 15);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", Diagnosis) VALUES (1, '2020-01-15', 12.5, 'SLE');
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", Diagnosis) VALUES (2, '2020-02-15', 5.0, 'RA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T1.SEX, T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.TP < 6.0;

/*
Gold Result:
(1, 'F', '1980-05-15')
*/

-- Prediction Query
SELECT Patient.ID, Patient.SEX, Patient.Birthday FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.TP < 6.0;

/*
Prediction Result:
(1, 'F', '1980-05-15')
(1, 'F', '1980-05-15')
*/