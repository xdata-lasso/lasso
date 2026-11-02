-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, NULL, '1997-01-26', '1997-01-27', '1997-01-27', 'default1', 'default2'), (1, NULL, NULL, '2023-01-01', '1997-01-26', 'default2', 'default2'), (2, 'default2', '1997-01-27', '2023-01-01', '1997-01-27', '1997-01-27', 'SLE'), (3, 'SLE', '1997-01-27', '2023-01-01', NULL, '1997-01-27', '1997-01-27'), (4, 'SLE', '1997-01-27', '1997-01-26', '1997-01-28', NULL, 'SLE'), (5, 'default2', '2023-01-01', '2023-01-02', '1997-01-26', 'SLE', NULL), (6, NULL, '2023-01-01', '2023-01-01', '2023-01-01', 'default2', 'default2'), (7, 'SLE', '1997-01-28', NULL, '1997-01-27', NULL, '1997-01-27'), (8, 'default2', NULL, '1997-01-26', '2023-01-01', 'default1', 'default2'), (9, '1997-01-27', '1997-01-27', '1997-01-28', NULL, 'default1', 'default1'), (10, 'default1', NULL, '1997-01-26', '2023-01-01', NULL, NULL), (11, 'SLE', '1997-01-28', '1997-01-27', '1997-01-27', NULL, NULL), (12, NULL, '2023-01-02', '1997-01-26', '1997-01-27', 'default1', NULL), (13, NULL, NULL, '1997-01-27', '2023-01-02', '1997-01-27', 'default2'), (14, '1997-01-27', '1997-01-27', NULL, '1997-01-27', NULL, NULL), (15, '1997-01-27', '1997-01-26', '1997-01-27', '2023-01-02', NULL, NULL), (16, '1997-01-27', '2023-01-02', NULL, '1997-01-26', 'default2', 'default2'), (17, 'default2', '2023-01-01', NULL, '1997-01-27', 'SLE', 'default2'), (18, '1997-01-27', '1997-01-26', NULL, '2023-01-01', 'SLE', 'SLE'), (19, '1997-01-27', '1997-01-27', '1997-01-27', '2023-01-01', 'SLE', 'SLE'), (20, 'default2', '1997-01-28', '2023-01-01', '2023-01-02', 'default2', 'SLE'), (21, 'default1', '1997-01-28', '2023-01-01', '1997-01-27', 'default1', 'SLE'), (22, 'default1', '1997-01-27', '2023-01-01', '1997-01-28', '1997-01-27', NULL), (23, 'default2', '2023-01-01', '1997-01-28', '1997-01-26', 'default2', '1997-01-27'), (24, 'SLE', '1997-01-26', NULL, '2023-01-01', '1997-01-27', NULL), (25, 'SLE', '1997-01-28', NULL, '2023-01-02', '1997-01-27', 'SLE');
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (4, '2023-01-01', 1.0, 0.0, 1, 'default2', NULL, NULL, 'SLE', NULL, 'default2', 'default1', NULL), (3, '2023-01-01', NULL, NULL, NULL, 'SLE', 1, 'SLE', 'SLE', '1997-01-27', 'default2', NULL, NULL), (7, '1997-01-27', 0.0, NULL, 0, 'default2', NULL, 'default2', NULL, 'SLE', 'SLE', 'default2', 0), (19, '1997-01-27', NULL, 1.0, 1, 'default1', 1, NULL, '1997-01-27', '1997-01-27', 'default2', 'default1', NULL), (7, NULL, 1.0, NULL, 0, 'SLE', NULL, 'default1', '1997-01-27', 'default1', NULL, '1997-01-27', 1), (7, '1997-01-26', 0.0, 1.0, 0, NULL, 0, 'default1', 'default2', 'default1', 'default1', 'default1', 0), (8, NULL, NULL, 0.0, 1, 'default2', 1, 'SLE', NULL, NULL, '1997-01-27', 'SLE', 0), (24, NULL, 1.0, 0.0, 1, 'SLE', 1, NULL, 'default2', NULL, '1997-01-27', 'default2', NULL), (9, '2023-01-02', 1.0, 1.0, NULL, '1997-01-27', NULL, NULL, 'default1', NULL, NULL, 'default1', 0), (23, '1997-01-27', NULL, 1.0, 0, 'default2', NULL, 'SLE', 'SLE', '1997-01-27', 'default2', 'SLE', NULL), (8, '1997-01-27', NULL, 1.0, NULL, 'default1', NULL, NULL, '1997-01-27', '1997-01-27', 'default2', 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T1.ID = (SELECT ID FROM Examination WHERE "Examination Date" = '1997-01-27' AND Diagnosis = 'SLE') AND T2."Examination Date" = T1."First Date";

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2."Examination Date" = '1997-01-27' AND T2.Diagnosis = 'SLE';

/*
Prediction Result:
('1997-01-27',)
*/