-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'SLE', '2023-01-01', NULL, '2023-01-01', 'default2', 'SLE'), (0, 'SLE', NULL, '1997-01-26', NULL, NULL, 'SLE'), (2, 'SLE', '2023-01-02', NULL, '2023-01-01', '1997-01-27', NULL), (3, '1997-01-27', '1997-01-28', '1997-01-27', NULL, NULL, '1997-01-27'), (4, '1997-01-27', '1997-01-26', '2023-01-01', '1997-01-26', 'SLE', 'default1'), (5, 'default1', '2023-01-02', '2023-01-02', '2023-01-02', '1997-01-27', '1997-01-27'), (6, NULL, '2023-01-02', '1997-01-28', NULL, 'SLE', 'default1'), (7, 'default1', '2023-01-02', '1997-01-26', '1997-01-27', '1997-01-27', NULL), (8, '1997-01-27', '2023-01-01', '1997-01-27', '1997-01-28', '1997-01-27', 'SLE'), (9, 'default2', '1997-01-26', '1997-01-26', '1997-01-28', 'default2', NULL), (10, 'default1', '1997-01-27', '2023-01-01', '1997-01-28', 'default1', '1997-01-27'), (11, 'default1', '1997-01-26', '1997-01-26', '2023-01-01', 'SLE', 'default2');
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (8, '1997-01-27', 1.0, 1.0, 0, '1997-01-27', NULL, 'SLE', 'default2', 'SLE', NULL, '1997-01-27', 0), (2, '2023-01-02', NULL, 0.0, 0, 'default2', NULL, NULL, '1997-01-27', '1997-01-27', '1997-01-27', 'SLE', NULL), (8, '2023-01-01', NULL, NULL, 1, 'SLE', 1, 'default2', 'default2', 'default2', 'default2', '1997-01-27', NULL), (1, '2023-01-02', 1.0, NULL, NULL, 'SLE', NULL, NULL, 'default1', 'default1', 'default2', 'default2', 1), (4, '2023-01-02', 1.0, 0.0, 0, NULL, 0, 'SLE', 'default2', 'default2', '1997-01-27', 'default1', 1), (3, '2023-01-02', 0.0, 1.0, 1, '1997-01-27', NULL, NULL, 'default1', '1997-01-27', 'SLE', NULL, NULL), (6, '1997-01-27', NULL, NULL, NULL, 'SLE', 1, '1997-01-27', NULL, 'default1', NULL, 'SLE', 1), (0, '1997-01-28', 0.0, 0.0, 1, 'default1', NULL, 'SLE', 'default1', 'SLE', 'default1', '1997-01-27', NULL), (4, NULL, 0.0, NULL, 0, 'SLE', NULL, '1997-01-27', 'default1', NULL, NULL, 'SLE', 1), (9, '1997-01-26', 1.0, 1.0, NULL, NULL, NULL, '1997-01-27', NULL, NULL, 'SLE', '1997-01-27', NULL), (2, NULL, NULL, 0.0, 0, 'default1', 0, 'default1', 'SLE', '1997-01-27', '1997-01-27', 'default2', 1), (3, '1997-01-27', 0.0, 0.0, NULL, '1997-01-27', 0, '1997-01-27', NULL, NULL, NULL, 'default1', 0), (8, '2023-01-01', 0.0, NULL, NULL, NULL, 1, 'SLE', '1997-01-27', '1997-01-27', '1997-01-27', 'default2', 0), (2, NULL, NULL, NULL, 0, 'SLE', 1, NULL, 'default1', 'default2', '1997-01-27', 'default2', NULL), (7, '1997-01-28', 0.0, NULL, NULL, 'default2', 0, 'default2', 'default1', '1997-01-27', 'SLE', NULL, 1), (7, '1997-01-26', 0.0, 0.0, 1, 'default2', 0, 'SLE', 'default1', '1997-01-27', 'SLE', 'default2', 0), (2, '1997-01-26', 1.0, NULL, 0, 'default2', NULL, NULL, 'default2', NULL, '1997-01-27', '1997-01-27', NULL), (NULL, '2023-01-01', NULL, 1.0, 0, 'SLE', NULL, 'default2', 'SLE', 'default1', 'default2', 'SLE', 1), (3, '1997-01-28', 0.0, NULL, NULL, 'SLE', 1, 'default1', 'SLE', NULL, '1997-01-27', NULL, 0), (NULL, NULL, 1.0, 0.0, 1, 'default2', 0, 'default1', 'default2', NULL, 'default2', '1997-01-27', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T1.ID = (SELECT ID FROM Examination WHERE "Examination Date" = '1997-01-27' AND Diagnosis = 'SLE') AND T2."Examination Date" = T1."First Date";

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT patient.diagnosis FROM patient INNER JOIN examination ON patient.id = examination.id WHERE examination."Examination Date" = '1997-01-27' AND examination.diagnosis = 'SLE';

/*
Prediction Result:
('SLE',)
*/