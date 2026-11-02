-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1965-05-10', '1998-01-10', '1997-06-15', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'F', '1960-03-20', '1998-02-15', '1996-11-20', '-', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'M', '1960-01-01', '1998-03-01', '1997-01-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'F', '1960-01-01', '1998-04-01', '1997-02-01', '+', 'SJS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'F', '1990-01-01', '1998-05-01', '1997-03-01', '-', 'SLE');
INSERT INTO Laboratory (ID, Date, RBC, WBC, HGB) VALUES (1, '1998-01-15', 3.0, 5.5, 11.2);
INSERT INTO Laboratory (ID, Date, RBC, WBC, HGB) VALUES (2, '1998-02-20', 6.5, 6.1, 16.8);
INSERT INTO Laboratory (ID, Date, RBC, WBC, HGB) VALUES (3, '1998-03-05', 3.0, 5.0, 10.9);
INSERT INTO Laboratory (ID, Date, RBC, WBC, HGB) VALUES (4, '1998-04-10', 4.5, 6.0, 13.5);
INSERT INTO Laboratory (ID, Date, RBC, WBC, HGB) VALUES (5, '1998-05-12', 2.8, 4.8, 9.8);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (1, '1998-01-15', 'SLE', 0);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (2, '1998-02-20', 'RA', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T1.Admission FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.SEX = 'F' AND (T2.RBC <= 3.5 OR T2.RBC >= 6.0) AND STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) >= 50;

/*
Gold Result:
(1, '+')
(2, '-')
*/

-- Prediction Query
SELECT T1.ID, T1.SEX, (STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday)) AS Age, T2.RBC, CASE WHEN T1.Admission = '+' THEN 'Admitted' ELSE 'Not Admitted' END AS Admission_Status FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.SEX = 'F' AND (STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday)) >= 50 AND (T2.RBC <= 3.5 OR T2.RBC >= 6.0);

/*
Prediction Result:
(1, 'F', 60, 3.0, 'Admitted')
(2, 'F', 65, 6.5, 'Not Admitted')
*/