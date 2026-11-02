-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ratio calculation (fractional result for integer vs real division), 1-to-many join multiplicity (COUNT(*) vs COUNT(DISTINCT ID)), and standard WHERE filtering (Year = '1997', Thrombosis = 1).
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date") VALUES (1, 'F', '1997-01-01', '1997-01-01', '1996-01-01');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date") VALUES (2, 'M', '1980-01-01', '1997-01-01', '1997-01-01');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date") VALUES (3, 'F', '1975-01-01', '1998-01-01', '1998-01-01');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date") VALUES (4, 'M', '1970-01-01', '1995-01-01', '1995-01-01');
INSERT INTO Examination (ID, "Examination Date", Thrombosis) VALUES (1, '1997-03-15', 1);
INSERT INTO Examination (ID, "Examination Date", Thrombosis) VALUES (1, '1997-09-20', 1);
INSERT INTO Examination (ID, "Examination Date", Thrombosis) VALUES (2, '1997-06-10', 1);
INSERT INTO Examination (ID, "Examination Date", Thrombosis) VALUES (3, '1997-11-11', 0);
INSERT INTO Examination (ID, "Examination Date", Thrombosis) VALUES (3, '1998-02-14', 1);
INSERT INTO Examination (ID, "Examination Date", Thrombosis) VALUES (4, '1996-12-31', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.SEX = 'F' THEN 1 ELSE 0 END) AS REAL) / COUNT(*) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T2."Examination Date") = '1997' AND T2.Thrombosis = 1;

/*
Gold Result:
(0.6666666666666666,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T2."Examination Date") = '1997' AND T2.Thrombosis = 1 AND T1.SEX = 'F';

/*
Prediction Result:
(1,)
*/