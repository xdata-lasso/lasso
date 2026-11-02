-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'F', '1989-10-27', '2023-01-02', '2023-01-01', 'default1', NULL), (0, '1980', NULL, '1989-10-27', '2023-01-02', '1980', '1980'), (2, '1989', NULL, '1989-10-27', '2023-01-01', 'F', '1989'), (3, '1980', '1989-10-27', NULL, '2023-01-02', 'F', 'default2'), (4, '1989', '1989-10-27', NULL, '1980-10-27', '1989', '%Y'), (5, 'default2', '2023-01-01', '1980-10-27', NULL, 'default1', '1989'), (6, '1989', '1989-10-27', '1989-10-27', '2023-01-02', 'P', '1980'), (7, 'default2', '2023-01-02', '1980-10-27', NULL, 'default2', '1989'), (8, 'F', '1989-10-27', '1989-10-27', '2023-01-01', '1980', 'default2'), (9, 'F', NULL, '1980-10-27', '1989-10-27', '%Y', '%Y'), (10, 'default1', NULL, '1980-10-27', '2023-01-01', 'default1', 'F'), (11, NULL, '1980-10-27', '2023-01-02', '1989-10-27', '1980', 'default1'), (12, 'default1', '1989-10-27', '1989-10-27', '2023-01-02', '1980', 'P'), (13, 'P', NULL, '1989-10-27', '1989-10-27', '1980', 'default1');
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (6, '1989-10-27', 1.0, NULL, 1, '1989', 1, 'default1', '1989', NULL, 'F', 'default1', 0), (12, NULL, NULL, 0.0, 0, 'F', 1, 'default1', 'default2', 'F', 'F', 'default1', 0), (10, '1980-10-27', 1.0, 1.0, NULL, '%Y', 0, '%Y', '1989', '1989', 'default1', '%Y', 0), (8, '2023-01-02', 1.0, 1.0, 0, '%Y', 1, 'P', '1989', 'default2', NULL, 'F', NULL), (10, '2023-01-01', 0.0, 1.0, 0, '%Y', 1, 'default2', 'P', '1980', 'P', NULL, 1), (6, '1980-10-27', 1.0, NULL, 0, NULL, NULL, 'default1', '1989', 'P', '1989', NULL, 0), (10, '1989-10-27', 0.0, 0.0, 0, 'P', 0, 'default2', 'P', 'P', 'P', 'P', NULL), (7, NULL, NULL, 0.0, 1, NULL, NULL, '1989', NULL, 'P', 'default1', 'P', 0), (2, '2023-01-01', 1.0, 1.0, 1, 'default2', 1, '%Y', 'F', 'default2', 'P', '%Y', 0), (11, '1989-10-27', 1.0, 0.0, 0, 'P', NULL, '%Y', '1989', '%Y', 'default1', 'default2', 0), (4, NULL, 0.0, 0.0, NULL, '%Y', 0, '1989', '%Y', NULL, '1980', NULL, NULL), (3, NULL, 1.0, 1.0, NULL, '1989', 0, NULL, '%Y', 'default1', 'P', 'default1', 1), (13, '2023-01-01', NULL, 0.0, 1, 'F', 1, 'default2', NULL, '1989', '1980', '1989', 1), (9, '2023-01-01', NULL, NULL, 0, 'default2', 0, 'F', NULL, NULL, '%Y', 'default1', 0), (3, '2023-01-02', 0.0, 0.0, NULL, NULL, NULL, '%Y', 'default2', 'P', 'F', 'F', 0), (13, '1980-10-27', NULL, 0.0, NULL, '1980', NULL, 'F', '1989', 'default1', '%Y', '1980', 1), (6, NULL, 1.0, 1.0, 0, 'default1', 1, '1980', 'P', '%Y', '1980', NULL, NULL), (1, '2023-01-01', 0.0, NULL, 1, '1989', 1, '%Y', 'default2', '1980', 'F', '1980', 1), (10, '1980-10-27', 1.0, NULL, 0, 'F', 1, 'default1', 'default2', 'P', 'F', 'F', 0), (1, '2023-01-02', 1.0, NULL, 1, 'default2', 1, '%Y', 'P', 'P', 'P', 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2."ANA Pattern" <> 'P' AND STRFTIME('%Y', T1.Birthday) BETWEEN '1980' AND '1989' AND T1.SEX = 'F';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM patient INNER JOIN examination ON patient.id = examination.id WHERE patient.sex = 'F' AND STRFTIME('%Y', patient.birthday) BETWEEN '1980' AND '1989' AND examination."ANA Pattern" <> 'P';

/*
Prediction Result:
(3,)
*/