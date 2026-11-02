-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests WBC exact boundaries (<= 3.5, >= 9.0), values just inside/outside, and NULLs.
-- Also tests INNER JOIN vs LEFT JOIN (Patient 7 has no Laboratory records).
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'M', '1980-01-01', '2000-01-01', '2000-01-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'F', '1985-05-05', '2001-01-01', '2001-01-01', '-', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'M', '1970-12-12', '2002-01-01', '2002-01-01', '+', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'F', '1990-06-15', '2003-01-01', '2003-01-01', '-', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'M', '1975-03-20', '2004-01-01', '2004-01-01', '+', 'SSc');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (6, 'F', '1988-11-11', '2005-01-01', '2005-01-01', '-', 'MCTD');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (7, 'M', '1965-07-07', '2006-01-01', '2006-01-01', '+', 'SLE');
INSERT INTO Laboratory (ID, Date, WBC) VALUES (1, '2020-01-01', 3.5);
INSERT INTO Laboratory (ID, Date, WBC) VALUES (2, '2020-01-01', 3.51);
INSERT INTO Laboratory (ID, Date, WBC) VALUES (3, '2020-01-01', 9.0);
INSERT INTO Laboratory (ID, Date, WBC) VALUES (4, '2020-01-01', 8.99);
INSERT INTO Laboratory (ID, Date, WBC) VALUES (5, '2020-01-01', 5.5);
INSERT INTO Laboratory (ID, Date, WBC) VALUES (6, '2020-01-01', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T1.SEX, T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.WBC <= 3.5 OR T2.WBC >= 9.0 GROUP BY T1.SEX, T1.ID ORDER BY T1.Birthday ASC, T1.ID NULLS LAST, T1.SEX NULLS LAST;

/*
Gold Result:
(3, 'M', '1970-12-12')
(1, 'M', '1980-01-01')
*/

-- Prediction Query
SELECT T1.ID, T1.SEX, T1.Birthday FROM Patient AS T1 JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.WBC < 3.5) OR (T2.WBC >= 9.0) GROUP BY T1.SEX ORDER BY (DATE('2025-01-01 00:00:00') - T1.Birthday) ASC, T1.ID NULLS LAST, T1.SEX NULLS LAST, T1.Birthday NULLS LAST;

/*
Prediction Result:
(3, 'M', '1970-12-12')
*/