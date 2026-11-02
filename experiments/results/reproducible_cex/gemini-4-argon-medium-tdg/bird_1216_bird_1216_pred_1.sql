-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions on ALB (3.5, 5.5, inside, outside, NULL), SEX ('M', 'F', NULL), and missing join rows.
INSERT INTO Patient (ID, SEX, Birthday) VALUES (1, 'M', '1980-01-01');
INSERT INTO Patient (ID, SEX, Birthday) VALUES (2, 'M', '1981-01-01');
INSERT INTO Patient (ID, SEX, Birthday) VALUES (3, 'M', '1982-01-01');
INSERT INTO Patient (ID, SEX, Birthday) VALUES (4, 'M', '1983-01-01');
INSERT INTO Patient (ID, SEX, Birthday) VALUES (5, 'M', '1984-01-01');
INSERT INTO Patient (ID, SEX, Birthday) VALUES (6, 'M', '1985-01-01');
INSERT INTO Patient (ID, SEX, Birthday) VALUES (7, 'F', '1970-01-01');
INSERT INTO Patient (ID, SEX, Birthday) VALUES (8, NULL, '1975-01-01');
INSERT INTO Patient (ID, SEX, Birthday) VALUES (9, 'M', '1972-01-01');
INSERT INTO Laboratory (ID, Date, ALB) VALUES (1, '2020-01-01', 3.5);
INSERT INTO Laboratory (ID, Date, ALB) VALUES (2, '2020-01-01', 5.5);
INSERT INTO Laboratory (ID, Date, ALB) VALUES (3, '2020-01-01', 3.4);
INSERT INTO Laboratory (ID, Date, ALB) VALUES (4, '2020-01-01', 5.6);
INSERT INTO Laboratory (ID, Date, ALB) VALUES (5, '2020-01-01', 4.5);
INSERT INTO Laboratory (ID, Date, ALB) VALUES (6, '2020-01-01', NULL);
INSERT INTO Laboratory (ID, Date, ALB) VALUES (7, '2020-01-01', 2.0);
INSERT INTO Laboratory (ID, Date, ALB) VALUES (8, '2020-01-01', 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.SEX = 'M' AND (T2.ALB <= 3.5 OR T2.ALB >= 5.5) ORDER BY T1.Birthday, T1.ID NULLS LAST;

/*
Gold Result:
(1,)
(2,)
(3,)
(4,)
*/

-- Prediction Query
SELECT * FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.SEX = 'M' AND (Laboratory.ALB < 3.5 OR Laboratory.ALB > 5.5) ORDER BY Patient.Birthday DESC, Patient.id NULLS LAST, Laboratory.id NULLS LAST, Laboratory.date NULLS LAST;

/*
Prediction Result:
(4, 'M', '1983-01-01', None, None, None, None, 4, '2020-01-01', None, None, None, None, None, 5.6, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
(3, 'M', '1982-01-01', None, None, None, None, 3, '2020-01-01', None, None, None, None, None, 3.4, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
*/