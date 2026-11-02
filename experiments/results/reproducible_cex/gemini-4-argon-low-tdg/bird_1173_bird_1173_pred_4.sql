-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Patient.Diagnosis vs Examination.Diagnosis (wrong table column selected/grouped)
-- 2. WHERE date filter omitting rows outside 1985-1995 (missing WHERE clause or wrong date column like Patient.Birthday / First Date)
-- 3. COUNT(T2.Diagnosis) vs COUNT(DISTINCT T1.ID) (one patient with multiple exams vs multiple patients with one exam)
-- 4. ORDER BY DESC vs ASC and LIMIT 1
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1990-05-05', '1990-05-05', '1990-05-05', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1970-01-01', '1970-01-01', '1970-01-01', '+', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'F', '1970-01-01', '1970-01-01', '1970-01-01', '-', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'M', '1990-01-01', '1990-01-01', '1990-01-01', '+', 'SJS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'F', '1988-01-01', '1988-01-01', '1988-01-01', '+', 'PSS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (1, '1988-03-15', 'MCTD');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (1, '1991-07-20', 'MCTD');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (1, '1994-11-10', 'MCTD');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (2, '1989-02-01', 'MCTD');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (3, '1992-06-12', 'MCTD');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (4, '1984-12-31', 'SJS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (4, '1980-01-01', 'SJS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (4, '1996-01-01', 'SJS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (4, '1999-05-05', 'SJS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (5, '1990-10-10', 'PSS');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Diagnosis FROM Examination AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T1."Examination Date" BETWEEN '1985-01-01' AND '1995-12-31' GROUP BY T2.Diagnosis ORDER BY COUNT(T2.Diagnosis) DESC, T2.Diagnosis NULLS LAST LIMIT 1;

/*
Gold Result:
('SLE',)
*/

-- Prediction Query
SELECT diagnosis FROM examination WHERE "Examination Date" BETWEEN '1985-01-01' AND '1995-12-31' GROUP BY diagnosis ORDER BY COUNT(diagnosis) DESC, diagnosis NULLS LAST LIMIT 1;

/*
Prediction Result:
('MCTD',)
*/