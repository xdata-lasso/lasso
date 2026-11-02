-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for HCT (52.0 vs 51.9 vs >52), HAVING COUNT(ID) >= 2 (exact 2 vs 1 with multiple lower records), and DISTINCT elimination.
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date") VALUES (1, 'M', '1980-12-31', '2020-01-01', '2019-01-01');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date") VALUES (2, 'F', '1990-01-01', '2021-01-01', '2018-01-01');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date") VALUES (3, 'M', '1975-06-15', '2022-01-01', '2017-01-01');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date") VALUES (4, 'F', '2000-05-20', '2023-01-01', '2016-01-01');
-- Patient 1: Exactly two records with HCT = 52.0, plus one record with HCT < 52 (tests DISTINCT and >= 52 boundary)
INSERT INTO Laboratory (ID, Date, HCT) VALUES (1, '2023-01-01', 52.0);
INSERT INTO Laboratory (ID, Date, HCT) VALUES (1, '2023-01-02', 52.0);
INSERT INTO Laboratory (ID, Date, HCT) VALUES (1, '2023-01-03', 45.0);
-- Patient 2: Only one record >= 52, two records < 52 (tests HAVING COUNT >= 2 vs total records >= 2 and WHERE HCT >= 52 without HAVING)
INSERT INTO Laboratory (ID, Date, HCT) VALUES (2, '2023-01-01', 55.0);
INSERT INTO Laboratory (ID, Date, HCT) VALUES (2, '2023-01-02', 51.9);
INSERT INTO Laboratory (ID, Date, HCT) VALUES (2, '2023-01-03', 50.0);
-- Patient 3: Three records strictly > 52 (tests > 52 vs >= 52 and > 2 vs >= 2)
INSERT INTO Laboratory (ID, Date, HCT) VALUES (3, '2023-01-01', 53.5);
INSERT INTO Laboratory (ID, Date, HCT) VALUES (3, '2023-01-02', 54.0);
INSERT INTO Laboratory (ID, Date, HCT) VALUES (3, '2023-01-03', 60.1);
-- Patient 4: Two records just below 52 (tests HCT >= 52 filter)
INSERT INTO Laboratory (ID, Date, HCT) VALUES (4, '2023-01-01', 51.99);
INSERT INTO Laboratory (ID, Date, HCT) VALUES (4, '2023-01-02', 51.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.ID IN (SELECT ID FROM Laboratory WHERE HCT >= 52 GROUP BY ID HAVING COUNT(ID) >= 2);

/*
Gold Result:
(1, 45)
(3, 50)
*/

-- Prediction Query
SELECT p.ID, CAST((STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', p.Birthday)) AS REAL) AS age FROM Patient AS p JOIN Laboratory AS l ON p.ID = l.ID WHERE l.HCT >= 52 GROUP BY p.ID HAVING COUNT(l.ID) > 2;

/*
Prediction Result:
(3, 50.0)
*/