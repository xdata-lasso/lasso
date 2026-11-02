-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (-1, NULL, '2023-01-02', NULL, '2023-01-02', 'SLE', 'SLE'), (0, NULL, '2023-01-02', '2023-01-01', NULL, '-', 'default1'), (2, 'default2', '2023-01-01', '2023-01-01', NULL, '-', '-'), (1, '-', '2023-01-01', '2023-01-01', NULL, 'default1', 'SLE'), (3, 'SLE', NULL, NULL, '2023-01-01', '+', '-'), (4, 'SLE', '2023-01-02', '2023-01-02', '2023-01-01', NULL, 'default2'), (5, '-', NULL, '2023-01-01', NULL, 'default2', '-'), (6, '-', '2023-01-02', '2023-01-02', '2023-01-01', 'default1', 'default1'), (7, 'default1', NULL, '2023-01-01', '2023-01-01', 'default2', '+'), (8, '+', '2023-01-02', '2023-01-01', '2023-01-02', 'default1', '+'), (9, '-', '2023-01-01', '2023-01-02', NULL, '-', '-'), (10, '+', '2023-01-02', '2023-01-02', '2023-01-01', NULL, 'SLE'), (11, 'SLE', '2023-01-02', NULL, NULL, '+', 'SLE'), (12, '+', '2023-01-01', '2023-01-02', '2023-01-01', 'default2', 'default2'), (13, 'SLE', NULL, NULL, '2023-01-02', 'SLE', 'SLE'), (14, 'SLE', '2023-01-01', '2023-01-01', '2023-01-02', 'default2', 'SLE'), (15, 'SLE', '2023-01-01', NULL, NULL, 'SLE', '-'), (16, 'SLE', '2023-01-02', '2023-01-01', '2023-01-02', 'SLE', '-'), (17, 'default1', '2023-01-01', '2023-01-02', NULL, 'default2', 'default1'), (18, NULL, '2023-01-02', NULL, '2023-01-01', '-', 'SLE'), (19, '+', NULL, NULL, NULL, NULL, '+'), (20, 'default1', '2023-01-02', '2023-01-01', '2023-01-02', 'default2', 'default1'), (21, '-', '2023-01-01', '2023-01-01', NULL, 'SLE', 'SLE'), (22, '+', '2023-01-02', NULL, '2023-01-01', 'default1', 'SLE'), (23, NULL, '2023-01-01', '2023-01-01', '2023-01-02', '-', 'SLE'), (24, '-', '2023-01-01', '2023-01-01', '2023-01-02', 'default2', 'SLE'), (25, 'default2', NULL, '2023-01-01', '2023-01-01', '+', 'default2'), (26, 'default1', '2023-01-01', '2023-01-02', '2023-01-01', '-', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN Admission = '+' THEN 1 ELSE 0 END) / SUM(CASE WHEN Admission = '-' THEN 1 ELSE 0 END) FROM Patient WHERE Diagnosis = 'SLE';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN Admission = '+' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN Admission = '-' THEN 1 ELSE 0 END) FROM Patient WHERE Diagnosis = 'SLE';

/*
Prediction Result:
(0.5,)
*/