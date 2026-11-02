-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests COUNT(T1.ID) vs COUNT(DISTINCT T1.ID) and boundary conditions on Examination Year (1990, 1993) and Age (< 18 vs = 18).
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date") VALUES (1, 'F', '1980-06-15', '1990-01-01', '1990-01-01');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date") VALUES (2, 'M', '1975-06-15', '1993-01-01', '1993-01-01');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date") VALUES (3, 'F', '1970-01-01', '1985-01-01', '1985-01-01');
-- Patient 1 has two examinations in 1990 and 1993 (Age 10 and 13, both < 18, both within 1990-1993)
INSERT INTO Examination (ID, "Examination Date", "aCL IgG") VALUES (1, '1990-01-01', 1.2);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG") VALUES (1, '1993-12-31', 1.5);
-- Patient 2 has an examination in 1993 (Age 1993 - 1975 = 18, should be excluded by < '18')
INSERT INTO Examination (ID, "Examination Date", "aCL IgG") VALUES (2, '1993-05-05', 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T2."Examination Date") BETWEEN '1990' AND '1993' AND STRFTIME('%Y', T2."Examination Date") - STRFTIME('%Y', T1.Birthday) < '18';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT p.ID) AS underage_patients_count FROM Examination AS e JOIN Patient AS p ON e.ID = p.ID WHERE e."Examination Date" BETWEEN '1990-01-01' AND '1993-12-31' AND STRFTIME('%Y', e."Examination Date") - STRFTIME('%Y', p.Birthday) < 18;

/*
Prediction Result:
(1,)
*/