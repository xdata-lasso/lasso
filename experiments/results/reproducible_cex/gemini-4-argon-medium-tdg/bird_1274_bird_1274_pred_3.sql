-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests SQLite operator precedence and boolean coercion: WHERE T2.SSB = 'negative' OR '0' AND NOT T1.Symptoms IS NULL
-- In SQLite, '0' evaluates to FALSE (0), so ('0' AND ...) is always FALSE.
-- Thus, the query actually only filters for T2.SSB = 'negative', regardless of T1.Symptoms!
-- This dataset kills mutants that rewrite `'0'` as `T2.SSB = '0'`, or change operator precedence with parentheses `(T2.SSB = 'negative' OR T2.SSB = '0') AND T1.Symptoms IS NOT NULL`.
INSERT INTO Patient (ID, SEX) VALUES (1, 'F');
INSERT INTO Patient (ID, SEX) VALUES (2, 'M');
INSERT INTO Patient (ID, SEX) VALUES (3, 'F');
-- Patient 1: SSB = 'negative', Symptoms IS NULL.
-- Gold Query includes this (because T2.SSB = 'negative' is TRUE, short-circuiting the OR).
-- Mutant with `(SSB = 'negative' OR ...) AND Symptoms IS NOT NULL` will exclude this.
INSERT INTO Examination (ID, "Examination Date", Symptoms) VALUES (1, '2020-01-01', NULL);
INSERT INTO Laboratory (ID, Date, SSB) VALUES (1, '2020-01-01', 'negative');
-- Patient 2: SSB = '0', Symptoms = 'Fever' (NOT NULL).
-- Gold Query excludes this (because SSB = 'negative' is FALSE, and '0' evaluates to FALSE in boolean context).
-- Mutant with `SSB = '0'` will include this.
INSERT INTO Examination (ID, "Examination Date", Symptoms) VALUES (2, '2020-01-02', 'Fever');
INSERT INTO Laboratory (ID, Date, SSB) VALUES (2, '2020-01-02', '0');
-- Patient 3: SSB = 'negative', Symptoms = 'Cough' (NOT NULL).
-- Included by both Gold and typical mutants.
INSERT INTO Examination (ID, "Examination Date", Symptoms) VALUES (3, '2020-01-03', 'Cough');
INSERT INTO Laboratory (ID, Date, SSB) VALUES (3, '2020-01-03', 'negative');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Examination AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.SSB = 'negative' OR '0' AND NOT T1.Symptoms IS NULL;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.ID) FROM Laboratory AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T1.SSB IN ('-', '+-') AND NOT T2.Symptoms IS NULL;

/*
Prediction Result:
(0,)
*/