-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, '+', '2023-01-02', '2025-01-01', '2023-01-02', 'default2', '2025-01-01 00:00:00'), (1, '+', '2023-01-02', '2023-01-01', '2023-01-02', NULL, '+'), (2, '2025-01-01 00:00:00', '2023-01-01', '2025-01-01', '2023-01-02', 'default2', 'default1'), (3, NULL, NULL, '2023-01-02', '2023-01-02', 'default2', '%Y'), (4, NULL, '2023-01-01', '2023-01-02', '2025-01-01', 'default2', '%Y'), (5, NULL, '2023-01-01', NULL, '2025-01-01', 'default2', 'default2'), (6, 'default2', '2023-01-01', '2023-01-01', '2025-01-01', NULL, '2025-01-01 00:00:00');
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (6, NULL, 0.0, 1.0, 1, '+', 1, '2025-01-01 00:00:00', NULL, 'default1', '%Y', NULL, 0), (2, '2025-01-01', 0.0, 0.0, 0, 'default1', NULL, '2025-01-01 00:00:00', NULL, '+', '2025-01-01 00:00:00', NULL, NULL), (3, '2023-01-02', 0.0, NULL, NULL, '%Y', 0, 'default1', 'default2', 'default1', '2025-01-01 00:00:00', NULL, 1), (4, '2025-01-01', 1.0, 1.0, NULL, 'default2', 1, '+', NULL, '+', '2025-01-01 00:00:00', '%Y', 0), (2, '2023-01-02', 1.0, NULL, NULL, '%Y', 0, 'default2', '%Y', '+', 'default2', 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2.RVVT = '+';

/*
Gold Result:
(2, 2)
(4, 2)
*/

-- Prediction Query
SELECT Patient.ID, CAST(STRFTIME('%Y', '2025-01-01 00:00:00') AS REAL) - CAST(STRFTIME('%Y', Patient.Birthday) AS REAL) AS age FROM Patient JOIN Examination ON Patient.ID = Examination.ID WHERE Examination.RVVT = '+';

/*
Prediction Result:
(2, 2.0)
(4, 2.0)
(2, 2.0)
*/