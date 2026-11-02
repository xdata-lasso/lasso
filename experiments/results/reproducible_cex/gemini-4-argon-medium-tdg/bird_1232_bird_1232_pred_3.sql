-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests DISTINCT keyword, multiple Laboratory records per patient, and split conditions across rows.
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission) VALUES (10, 'F', '1985-08-25', '1990-01-01', '1995-01-01', '+');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission) VALUES (20, 'M', '1970-02-14', '1980-01-01', '1985-01-01', '-');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission) VALUES (30, 'F', '1995-06-30', '2000-01-01', '2005-01-01', '+');
-- Patient 10: Multiple matching Laboratory records -> Must appear only ONCE due to DISTINCT
INSERT INTO Laboratory (ID, Date, GLU, "T-CHO") VALUES (10, '2022-01-01', 185, 220);
INSERT INTO Laboratory (ID, Date, GLU, "T-CHO") VALUES (10, '2022-02-01', 190, 210);
INSERT INTO Laboratory (ID, Date, GLU, "T-CHO") VALUES (10, '2022-03-01', 250, 150);
-- Patient 20: Split conditions (one row has GLU >= 180, another has T-CHO < 250, neither has both) -> Should be excluded
INSERT INTO Laboratory (ID, Date, GLU, "T-CHO") VALUES (20, '2022-01-01', 190, 260);
INSERT INTO Laboratory (ID, Date, GLU, "T-CHO") VALUES (20, '2022-02-01', 150, 200);
-- Patient 30: No Laboratory records at all -> Tests INNER JOIN vs LEFT JOIN;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T1.SEX, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GLU >= 180 AND T2."T-CHO" < 250;

/*
Gold Result:
(10, 'F', 40)
*/

-- Prediction Query
SELECT Patient.ID, Patient.SEX, CAST((STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', Patient.Birthday)) AS REAL) AS age FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.GLU >= 180 AND Laboratory."T-CHO" < 250;

/*
Prediction Result:
(10, 'F', 40.0)
(10, 'F', 40.0)
(10, 'F', 40.0)
*/