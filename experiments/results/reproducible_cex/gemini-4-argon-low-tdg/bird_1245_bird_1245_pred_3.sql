-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for T2.Date ('1997-01-01', '1997-01-02', '1996-12-31')
-- and T2.APTT (44, 45, 46, NULL). Also tests logical AND vs OR between the two predicates.
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1970-01-01', '1995-01-01', '1995-01-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1965-05-05', '1996-01-01', '1996-01-01', '-', 'RA');
-- Boundary: Date = '1997-01-01' (Should be excluded by '>', included if mutated to '>=')
INSERT INTO Laboratory (ID, Date, APTT) VALUES (1, '1997-01-01', 45);
-- Boundary: Date = '1997-01-02' and APTT = 45 (Should be included; excluded if APTT mutated to '>')
INSERT INTO Laboratory (ID, Date, APTT) VALUES (1, '1997-01-02', 45);
-- Boundary: Date = '1997-01-03' and APTT = 44 (Should be excluded; included if OR used or APTT >= 44)
INSERT INTO Laboratory (ID, Date, APTT) VALUES (1, '1997-01-03', 44);
-- Boundary: Date = '1997-01-04' and APTT = 46 (Strictly satisfies both '>' and '>')
INSERT INTO Laboratory (ID, Date, APTT) VALUES (2, '1997-01-04', 46);
-- Boundary: Date = '1996-12-31' and APTT = 50 (Should be excluded; included if OR used or Date < '1997-01-01')
INSERT INTO Laboratory (ID, Date, APTT) VALUES (2, '1996-12-31', 50);
-- NULL handling: Date > '1997-01-01' and APTT IS NULL (Should be excluded)
INSERT INTO Laboratory (ID, Date, APTT) VALUES (2, '1998-01-01', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.Date > '1997-01-01' AND T2.APTT >= 45;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Examination INNER JOIN Laboratory ON Examination.ID = Laboratory.ID WHERE Examination."Examination Date" > '1997-01-01' AND Laboratory.APTT < 45;

/*
Prediction Result:
(0,)
*/