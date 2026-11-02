-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (821298, NULL, '2023-01-02', '2023-01-01', '2023-01-02', '%J', 'default2'), (821297, '%d', '2023-01-02', NULL, '2023-01-02', '%J', '%J'), (1, 'default1', '2023-01-02', '2023-01-02', NULL, '%J', '%d'), (0, 'default1', '2023-01-02', NULL, NULL, '%d', '%J'), (821299, '%J', '2023-01-02', '2023-01-01', '2023-01-01', 'default1', '%d'), (2, '%J', '2023-01-01', '2023-01-01', NULL, 'default1', NULL), (3, '%J', '2023-01-01', '2023-01-02', '2023-01-02', '%J', 'default1'), (4, 'default1', NULL, '2023-01-01', '2023-01-01', '%d', '%d'), (5, 'default2', NULL, '2023-01-01', NULL, '%d', 'default2');
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (1, '2023-01-01', NULL, 821297.0, 1, 'default2', NULL, NULL, NULL, 'default2', 'default1', '%d', NULL), (821297, '2023-01-01', NULL, NULL, NULL, NULL, 821298, 'default2', '%d', 'default2', NULL, '%J', 821299), (821297, NULL, 0.0, NULL, 821297, NULL, 821298, '%d', NULL, '%d', 'default2', 'default2', 0), (4, '2023-01-01', 1.0, 821298.0, 0, 'default1', 821299, '%d', 'default2', 'default1', NULL, '%d', 0), (NULL, NULL, 821297.0, NULL, NULL, NULL, 821297, NULL, '%d', '%d', NULL, 'default2', 821297), (821298, '2023-01-02', 1.0, 0.0, 0, '%J', 821298, NULL, 'default1', '%d', '%d', '%d', 821297), (NULL, '2023-01-01', 1.0, 821299.0, 821297, '%J', 821297, '%J', 'default2', '%J', '%J', 'default1', 0), (821298, '2023-01-02', 1.0, 821298.0, NULL, 'default1', 821297, '%d', 'default1', '%J', 'default1', 'default2', 821299);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STRFTIME('%d', T3."Examination Date") - STRFTIME('%d', T1."First Date") FROM Patient AS T1 INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T1.ID = 821298;

/*
Gold Result:
(0,)
(0,)
*/

-- Prediction Query
SELECT DISTINCT STRFTIME('%J', T2."Examination Date") - STRFTIME('%J', T1."First Date") AS days FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T1.ID = 821298;

/*
Prediction Result:
(0.0,)
*/