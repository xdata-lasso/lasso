-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, 'default1', '1989-12-30', '2023-01-02', '1989-12-31', '1980-01-01', 'default2'), (1, 'default2', '1989-12-31', '1980-10-27', '1980-10-27', '1980-01-01', NULL), (2, NULL, '1980-10-27', '2023-01-01', '2023-01-02', '1980-01-01', '1980-01-01'), (3, NULL, '1980-01-02', '1989-10-27', '1989-10-27', 'F', '1989-12-31'), (4, 'F', '1980-10-27', '1980-01-02', '2023-01-01', 'default1', '1980'), (5, 'default2', NULL, '1989-12-31', '1990-01-01', '1989', NULL), (6, '%Y', '1979-12-31', NULL, '1990-01-01', '1980-01-01', 'default2'), (7, '1989-12-31', '1989-10-27', '2023-01-02', '1980-10-27', '1989', '1980'), (8, 'default1', '1980-01-01', NULL, '1980-01-02', '1980-01-01', 'default1'), (9, '1980-01-01', '1989-12-31', '1989-12-30', '1979-12-31', '1989', '1989-12-31'), (10, 'F', '1979-12-31', '2023-01-01', '1979-12-31', '%Y', 'default1'), (11, 'P', '1980-10-27', '2023-01-01', '2023-01-02', 'F', 'P'), (12, '1980-01-01', '1980-01-02', NULL, '1980-01-01', '1980-01-01', '%Y'), (13, 'F', '1989-12-31', '1980-01-01', '1989-12-31', '%Y', '1980-01-01'), (14, NULL, NULL, '1990-01-01', '1980-01-01', '%Y', NULL), (15, '1989', '1980-01-02', '1990-01-01', '1990-01-01', '1989', NULL);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (10, '2023-01-01', 0.0, 0.0, NULL, NULL, 0, 'default1', 'default1', '1989', '1980-01-01', 'default2', 1), (13, '1979-12-31', 0.0, 0.0, 1, '1989', NULL, '1989-12-31', '1980-01-01', NULL, 'default2', 'default1', 0), (11, '1990-01-01', 1.0, 1.0, 1, NULL, NULL, 'P', '%Y', 'default2', '1989-12-31', '1980', 0), (9, '1989-12-31', 1.0, NULL, 0, 'P', NULL, 'default2', 'F', 'F', '1989-12-31', 'F', 0), (0, '2023-01-02', 1.0, NULL, 1, '1980', 0, 'default1', 'P', '1980', 'P', NULL, NULL), (10, '1989-10-27', NULL, 0.0, 0, 'default1', 1, 'F', '%Y', NULL, '1980', '1989', NULL), (15, '2023-01-02', 0.0, 1.0, NULL, 'P', NULL, '%Y', '1980', NULL, 'F', 'P', 1), (NULL, '1980-01-01', NULL, 0.0, NULL, 'F', NULL, NULL, '%Y', '1980-01-01', '1980-01-01', 'default1', 0), (13, NULL, NULL, NULL, NULL, '1989-12-31', NULL, '1980-01-01', 'default2', 'default2', 'F', '1989-12-31', 0), (7, '1979-12-31', 0.0, 1.0, 1, '1980', 1, '1989', '1989', 'default1', '1989', 'P', 0), (5, '1980-10-27', NULL, 1.0, 1, 'P', NULL, '1980-01-01', '1989', 'F', 'default2', 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2."ANA Pattern" <> 'P' AND STRFTIME('%Y', T1.Birthday) BETWEEN '1980' AND '1989' AND T1.SEX = 'F';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Examination AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T1."ANA Pattern" <> 'P' AND T2.SEX = 'F' AND T2.Birthday BETWEEN '1980-01-01' AND '1989-12-31';

/*
Prediction Result:
(2,)
*/