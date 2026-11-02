-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (2, 'SLE', '2023-01-02', '2023-01-01', '2023-01-01', 'default2', 'default1'), (0, NULL, NULL, '2023-01-01', NULL, 'SLE', 'default1'), (1, 'SLE', NULL, NULL, NULL, 'default2', 'SLE'), (3, NULL, '2023-01-01', NULL, '2023-01-01', NULL, 'SLE'), (4, 'SLE', '2023-01-02', '2023-01-02', '2023-01-02', 'SLE', 'SLE'), (5, 'default2', '2023-01-02', '2023-01-02', '2023-01-01', 'SLE', 'default2'), (6, NULL, NULL, '2023-01-02', '2023-01-02', 'default1', 'SLE'), (7, 'default1', NULL, NULL, '2023-01-01', 'default1', 'SLE');
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (5, '2023-01-02', 1.0, NULL, 1, NULL, 1, 'default1', 'default2', 'default1', 'SLE', 'default1', 1), (5, '2023-01-01', 1.0, 0.0, NULL, NULL, NULL, 'default2', NULL, 'SLE', NULL, 'default2', 2), (NULL, '2023-01-01', NULL, 1.0, 1, 'SLE', 0, 'SLE', 'SLE', 'default1', 'SLE', 'SLE', 0), (NULL, '2023-01-02', NULL, 1.0, 0, 'default1', NULL, 'default1', NULL, 'default2', 'default1', 'SLE', 2), (0, '2023-01-02', 2.0, 1.0, 1, 'default1', 2, NULL, 'SLE', NULL, NULL, 'default2', 1), (7, '2023-01-01', 2.0, NULL, 0, 'SLE', 2, 'default2', 'SLE', 'default1', 'default1', 'default2', 0), (6, '2023-01-01', 0.0, 0.0, 2, 'default2', 2, NULL, 'default1', 'default1', 'default2', 'SLE', 1), (NULL, NULL, 1.0, 2.0, 1, 'default1', 1, 'default2', 'SLE', NULL, 'SLE', 'default1', 1), (4, '2023-01-02', 2.0, 1.0, 2, 'default1', 2, 'default1', 'default1', NULL, NULL, NULL, NULL), (2, '2023-01-01', NULL, 0.0, 2, NULL, 0, 'SLE', 'default1', 'default2', 'SLE', NULL, 1), (7, '2023-01-01', 0.0, 2.0, NULL, 'default2', 0, 'default1', 'SLE', 'default1', NULL, 'default1', 1), (2, NULL, 1.0, 0.0, 0, 'default1', 1, 'default2', NULL, 'SLE', 'SLE', NULL, NULL), (0, '2023-01-01', 1.0, 1.0, 0, 'default2', 2, 'default1', 'default2', NULL, NULL, 'default1', NULL), (3, NULL, 0.0, NULL, 0, 'default1', 1, 'default1', 'default1', NULL, NULL, 'default2', 1), (2, '2023-01-02', 1.0, 0.0, 2, 'SLE', 1, NULL, 'default1', NULL, 'SLE', NULL, 2), (5, '2023-01-01', 0.0, NULL, 0, 'default2', 2, 'SLE', NULL, 'default2', 'default2', 'default1', NULL), (5, NULL, 2.0, 2.0, NULL, NULL, 0, 'default1', 'SLE', 'default2', 'default2', 'default1', 0), (7, NULL, 2.0, 1.0, 0, NULL, 2, 'default1', 'SLE', 'default1', 'default1', NULL, 1), (6, '2023-01-02', 0.0, 1.0, 1, 'SLE', 1, 'default2', 'default1', NULL, 'default1', NULL, 1), (4, NULL, 2.0, 0.0, 2, NULL, NULL, 'default2', 'SLE', 'default2', 'default2', 'default1', 2), (7, '2023-01-02', 2.0, 1.0, 2, 'default2', 1, 'default2', 'default2', NULL, 'SLE', 'default1', 0), (6, '2023-01-02', NULL, 2.0, 1, 'default2', 2, 'SLE', NULL, 'default2', 'default2', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Symptoms FROM Examination WHERE Diagnosis = 'SLE' GROUP BY Symptoms ORDER BY COUNT(Symptoms) DESC, Symptoms NULLS LAST LIMIT 1;

/*
Gold Result:
('SLE',)
*/

-- Prediction Query
SELECT Symptoms FROM Examination WHERE Diagnosis = 'SLE' GROUP BY Symptoms ORDER BY COUNT(*) DESC, Symptoms NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/