-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'default2', '1980-10-27', NULL, NULL, 'P', 'F'), (0, 'F', '1989-10-27', '1980-10-27', '2023-01-01', '1980', '1989'), (2, '%Y', '2023-01-02', NULL, NULL, NULL, '1980'), (3, 'F', '1989-10-27', '1989-10-27', '1980-10-27', '%Y', 'default2'), (4, '1989', '1980-10-27', '1980-10-27', '2023-01-01', 'default2', '1980'), (5, 'P', '2023-01-02', '2023-01-01', '2023-01-02', '%Y', 'default1'), (6, NULL, '1980-10-27', '1989-10-27', '2023-01-01', 'default2', 'F'), (7, '%Y', NULL, '2023-01-01', '2023-01-01', 'P', '1980'), (8, NULL, NULL, '1989-10-27', '1989-10-27', '%Y', '1989'), (9, '1989', '1989-10-27', '2023-01-01', '1989-10-27', 'default2', '%Y'), (10, '%Y', '2023-01-02', '1980-10-27', '1980-10-27', 'default2', 'default2'), (11, '1989', '2023-01-02', '1980-10-27', '1980-10-27', NULL, '%Y'), (12, 'P', NULL, '1989-10-27', '2023-01-02', 'P', '%Y'), (13, 'F', '1989-10-27', '2023-01-02', NULL, 'F', 'F'), (14, 'default1', '1989-10-27', '1989-10-27', '2023-01-01', 'default2', NULL), (15, 'default2', '1980-10-27', '1980-10-27', '2023-01-02', 'default2', 'default1'), (16, 'F', '2023-01-01', '1989-10-27', '2023-01-01', '1980', '1980'), (17, 'F', '2023-01-02', '2023-01-01', '2023-01-01', 'default1', '%Y'), (18, NULL, '2023-01-02', '2023-01-01', '2023-01-01', NULL, '1980'), (19, '1989', '2023-01-01', NULL, NULL, 'default2', 'P'), (20, 'F', '1989-10-27', '2023-01-01', NULL, '1989', 'F');
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (7, '1989-10-27', NULL, 1.0, NULL, NULL, 1, '1980', 'P', '1980', 'P', '1989', 1), (0, '1980-10-27', NULL, NULL, 1, '%Y', 1, '1980', 'default1', 'F', '1989', 'default1', 1), (19, NULL, NULL, 0.0, 0, '1989', 0, '1980', 'default2', NULL, NULL, 'default1', 0), (12, NULL, NULL, NULL, 0, NULL, 1, NULL, '%Y', NULL, NULL, '1989', NULL), (19, NULL, 1.0, 0.0, NULL, 'F', 0, 'F', '1989', '1980', 'P', 'default2', 1), (5, '1989-10-27', 1.0, NULL, 0, '1980', NULL, '1989', 'default1', '%Y', '1980', '%Y', NULL), (14, '1989-10-27', 1.0, NULL, 1, 'P', 1, 'F', 'F', 'P', '1989', 'default1', 0), (6, '2023-01-02', 0.0, 0.0, NULL, '1980', NULL, 'F', '%Y', 'default1', '1989', 'F', NULL), (16, '1980-10-27', NULL, NULL, NULL, '1980', 0, '1989', NULL, '%Y', 'F', NULL, 1), (18, '1980-10-27', NULL, 0.0, NULL, 'default1', NULL, '1980', '1989', 'default1', 'default2', '%Y', 0), (16, '1989-10-27', 1.0, 0.0, 1, '1980', 1, 'default1', '1980', 'P', '1989', 'default2', NULL), (16, '2023-01-02', 1.0, NULL, 0, '1980', 0, 'P', NULL, 'default1', 'default2', 'default1', 1), (9, NULL, 0.0, NULL, 1, 'default2', 1, 'default1', '%Y', '1980', 'F', NULL, 1), (0, '1989-10-27', 0.0, NULL, 0, '1980', 1, 'default1', '%Y', '1989', 'default1', '1989', 0), (2, '2023-01-02', 1.0, 0.0, 0, '%Y', NULL, '%Y', 'F', '1980', 'F', '%Y', 0), (12, '2023-01-01', NULL, 0.0, NULL, 'default2', NULL, 'default1', '1980', 'default1', NULL, '1989', 1), (10, '1980-10-27', 0.0, 1.0, 1, 'default2', NULL, 'default1', '1989', '%Y', NULL, 'default2', 0), (19, '1980-10-27', 1.0, NULL, 0, 'F', 0, NULL, '1980', 'default1', '1980', '1989', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2."ANA Pattern" <> 'P' AND STRFTIME('%Y', T1.Birthday) BETWEEN '1980' AND '1989' AND T1.SEX = 'F';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T1.SEX = 'F' AND STRFTIME('%Y', T1.Birthday) BETWEEN '1980' AND '1989' AND T2."ANA Pattern" <> 'P';

/*
Prediction Result:
(2,)
*/