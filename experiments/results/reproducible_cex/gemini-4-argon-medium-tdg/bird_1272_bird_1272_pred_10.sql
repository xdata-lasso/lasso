-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1980-05-01', '1999-01-01', NULL, 'Yes', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'F', '1975-04-01', '1998-01-01', '1985-01-01', 'Yes', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'M', '1970-03-01', '1997-01-01', '1986-01-01', 'No', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'F', '1965-02-01', '1996-01-01', '1987-01-01', 'Yes', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'F', '1960-01-01', '1995-01-01', '1990-01-01', 'No', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (6, 'M', '1990-12-01', '1990-01-01', '1988-06-15', 'Yes', 'SLE');
INSERT INTO Laboratory (ID, Date, SSA, SSB, RNP, SM) VALUES (1, '1999-01-01', 'positive', 'negative', 'negative', 'negative');
INSERT INTO Laboratory (ID, Date, SSA, SSB, RNP, SM) VALUES (2, '1985-01-01', 'negative', 'positive', 'positive', 'positive');
INSERT INTO Laboratory (ID, Date, SSA, SSB, RNP, SM) VALUES (3, '1986-01-01', '0', 'positive', 'positive', 'positive');
INSERT INTO Laboratory (ID, Date, SSA, SSB, RNP, SM) VALUES (4, '1987-01-01', NULL, 'positive', 'positive', 'positive');
INSERT INTO Laboratory (ID, Date, SSA, SSB, RNP, SM) VALUES (5, '1980-01-01', 'positive', 'negative', '0', 'negative');
INSERT INTO Laboratory (ID, Date, SSA, SSB, RNP, SM) VALUES (6, '1995-01-01', '1+', 'negative', '0', 'negative');
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (5, '1990-01-01', 'SLE', 0);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (6, '1988-06-15', 'SLE', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE NOT T1."First Date" IS NULL AND NOT T2.SSA IN ('negative', '0') ORDER BY T1."First Date" ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT p.ID FROM Patient AS p JOIN Laboratory AS l ON p.ID = l.ID WHERE NOT l.SSA IN ('negative', '0') ORDER BY p."First Date" ASC, p.id NULLS LAST, l.id NULLS LAST, l.date NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/