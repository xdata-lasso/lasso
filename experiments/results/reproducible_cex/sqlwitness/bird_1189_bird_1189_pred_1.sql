-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (3, NULL, '2023-01-01', NULL, NULL, 'S', 'default2'), (1, 'S', '2023-01-02', NULL, '2023-01-02', 'default2', 'S'), (0, 'default2', '2023-01-02', '2023-01-01', '2023-01-01', 'default2', NULL), (2, 'S', NULL, '2023-01-02', '2023-01-01', NULL, 'S'), (4, NULL, '2023-01-02', '2023-01-01', '2023-01-01', 'default1', NULL), (5, 'default2', '2023-01-02', '2023-01-01', '2023-01-01', 'default2', NULL), (6, 'S', NULL, '2023-01-02', '2023-01-01', 'default1', 'default2'), (7, 'S', '2023-01-02', '2023-01-02', '2023-01-02', NULL, 'default2'), (8, 'S', '2023-01-02', '2023-01-01', NULL, 'S', 'default2'), (9, 'S', '2023-01-02', '2023-01-02', NULL, 'S', 'S'), (10, 'default1', NULL, '2023-01-01', '2023-01-01', NULL, 'default1'), (11, 'default1', NULL, NULL, NULL, 'S', 'default2'), (12, NULL, '2023-01-01', NULL, '2023-01-01', 'default2', 'S'), (13, 'S', '2023-01-01', '2023-01-02', '2023-01-01', 'default2', 'default1'), (14, 'default2', NULL, '2023-01-01', NULL, NULL, 'default2'), (15, NULL, '2023-01-02', '2023-01-02', '2023-01-01', NULL, NULL), (16, NULL, '2023-01-02', '2023-01-02', '2023-01-02', NULL, 'default1'), (17, 'default2', NULL, NULL, NULL, 'default1', 'S'), (18, 'S', NULL, '2023-01-01', '2023-01-01', 'default1', 'S'), (19, NULL, NULL, NULL, '2023-01-02', 'default1', 'default1');
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (16, NULL, 0.0, 3.0, 0, 'S', 1, 'S', 'default2', 'default2', 'default1', 'default2', 2), (5, '2023-01-02', 1.0, 0.19999999999999996, 1, 'default1', 3, NULL, 'default1', 'default1', 'S', 'S', 1), (16, '2023-01-01', 2.0, 0.19999999999999996, 3, 'S', 3, NULL, NULL, NULL, NULL, NULL, NULL), (18, NULL, 2.2, NULL, 2, NULL, 3, 'default2', 'S', NULL, 'default2', NULL, 3), (16, NULL, 0.0, NULL, NULL, 'default2', NULL, 'default1', 'default2', 'S', NULL, 'S', 2), (NULL, '2023-01-01', 1.0, 2.2, NULL, 'S', 0, 'default2', 'default1', 'S', 'default1', NULL, 0), (7, NULL, 2.2, 0.0, 0, 'default1', 0, 'default2', 'default1', 'S', 'default1', 'S', 2), (3, '2023-01-02', 1.0, 1.2, 2, 'default1', 0, 'default2', NULL, 'default2', 'default2', 'S', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM Examination WHERE Thrombosis = 2 AND "ANA Pattern" = 'S' AND "aCL IgM" > (SELECT AVG("aCL IgM") * 1.2 FROM Examination WHERE Thrombosis = 2 AND "ANA Pattern" = 'S');

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) AS PatientCount FROM Examination WHERE Thrombosis = 2 AND "ANA Pattern" = 'S' AND "aCL IgM" > (SELECT AVG("aCL IgM") FROM Examination) * 1.2;

/*
Prediction Result:
(1,)
*/