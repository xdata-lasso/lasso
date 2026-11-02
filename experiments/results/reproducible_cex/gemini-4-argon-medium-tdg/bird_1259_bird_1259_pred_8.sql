-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests Birthday boundary conditions:
-- 1) Distinguishes unquoted 1995 - 01 - 01 (evaluates to integer 1993) from quoted '1995-01-01'.
-- 2) Tests exact boundary '1995-01-01' (> vs >=) and dates before/after 1995.
-- 3) Tests numeric/year-only values around 1993 and 1995, and NULL Birthday.
INSERT INTO Patient (ID, SEX, Birthday, Diagnosis) VALUES (1, 'F', '1994-06-01', 'Diag_1994_Str');
INSERT INTO Patient (ID, SEX, Birthday, Diagnosis) VALUES (2, 'M', '1995-01-01', 'Diag_1995_Exact');
INSERT INTO Patient (ID, SEX, Birthday, Diagnosis) VALUES (3, 'F', '1995-01-02', 'Diag_1995_After');
INSERT INTO Patient (ID, SEX, Birthday, Diagnosis) VALUES (4, 'M', 1993, 'Diag_Int_1993');
INSERT INTO Patient (ID, SEX, Birthday, Diagnosis) VALUES (5, 'F', 1994, 'Diag_Int_1994');
INSERT INTO Patient (ID, SEX, Birthday, Diagnosis) VALUES (6, 'M', NULL, 'Diag_Null_Bday');
INSERT INTO Laboratory (ID, Date, RA) VALUES (1, '2010-01-01', '-');
INSERT INTO Laboratory (ID, Date, RA) VALUES (2, '2010-01-01', '+-');
INSERT INTO Laboratory (ID, Date, RA) VALUES (3, '2010-01-01', '-');
INSERT INTO Laboratory (ID, Date, RA) VALUES (4, '2010-01-01', '-');
INSERT INTO Laboratory (ID, Date, RA) VALUES (5, '2010-01-01', '+-');
INSERT INTO Laboratory (ID, Date, RA) VALUES (6, '2010-01-01', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.RA = '-' OR T2.RA = '+-') AND T1.Birthday > 1995 - 01 - 01;

/*
Gold Result:
('Diag_1994_Str',)
('Diag_1995_Exact',)
('Diag_1995_After',)
('Diag_Int_1994',)
*/

-- Prediction Query
SELECT DISTINCT T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T1.Birthday) >= '1985' AND T2.RA IN ('-', '+-');

/*
Prediction Result:
('Diag_1994_Str',)
('Diag_1995_Exact',)
('Diag_1995_After',)
*/