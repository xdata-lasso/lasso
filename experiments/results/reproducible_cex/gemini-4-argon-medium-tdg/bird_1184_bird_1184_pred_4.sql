-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate output preservation (SELECT vs SELECT DISTINCT) and multiple matching records for the same or different patients.
INSERT INTO Patient (ID, Birthday, Diagnosis) VALUES (10, '1959-03-01', 'P_Diag1');
INSERT INTO Patient (ID, Birthday, Diagnosis) VALUES (20, '1959-03-01', 'P_Diag2');
INSERT INTO Examination (ID, "Examination Date", Symptoms, Diagnosis) VALUES (10, '1993-09-27', 'Rash', 'E_Diag1');
INSERT INTO Examination (ID, "Examination Date", Symptoms, Diagnosis) VALUES (10, '1993-09-27', 'Rash', 'E_Diag2');
INSERT INTO Examination (ID, "Examination Date", Symptoms, Diagnosis) VALUES (20, '1993-09-27', 'Arthritis', 'E_Diag3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Symptoms FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T1.Birthday = '1959-03-01' AND T2."Examination Date" = '1993-09-27';

/*
Gold Result:
('Rash',)
('Rash',)
('Arthritis',)
*/

-- Prediction Query
SELECT Symptoms FROM Examination WHERE ID = (SELECT ID FROM Patient WHERE Birthday = '1959-03-01') AND "Examination Date" = '1993-09-27';

/*
Prediction Result:
('Rash',)
('Rash',)
*/