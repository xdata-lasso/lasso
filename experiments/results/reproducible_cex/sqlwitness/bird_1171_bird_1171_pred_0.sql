-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (18, '%Y', '2026-10-18', '1990-10-27', '1993-10-27', '%Y', '%Y'), (0, '18', NULL, '1990-10-27', NULL, '18', '1993'), (19, '%Y', '2023-01-02', NULL, '2023-01-02', '1990', 'default1'), (1, 'default1', '1993-10-27', '2026-10-18', '2023-01-01', '18', '%Y'), (17, '%Y', '2026-10-18', '2023-01-02', '2023-01-02', '1993', '18'), (2, 'default2', '2023-01-01', '1993-10-27', NULL, NULL, '1990');
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (17, '2023-01-01', 17.0, 19.0, 19, 'default2', 19, '1993', NULL, 'default2', '1993', '%Y', 19), (0, NULL, 0.0, 0.0, NULL, '1990', NULL, '18', 'default2', '18', '1993', '18', 1), (1, NULL, NULL, 18.0, 1, NULL, 19, '18', '18', 'default1', '1993', 'default2', 19), (18, '1993-10-27', 1.0, 0.0, 18, NULL, 19, '%Y', '1990', 'default2', '1990', '1990', NULL), (19, '2026-10-18', 19.0, 18.0, 18, '1993', 17, '%Y', NULL, '%Y', '%Y', '1990', 18), (2, NULL, 0.0, 19.0, 1, '1990', 1, '18', '%Y', '18', '1993', 'default1', 0), (19, '1993-10-27', 1.0, 1.0, 0, 'default1', 0, '1993', '18', '%Y', '18', 'default2', 18), (18, '2026-10-18', 17.0, NULL, 0, 'default2', 19, '%Y', '1990', '%Y', 'default1', 'default1', 18), (NULL, '1990-10-27', 18.0, NULL, 18, 'default1', 0, NULL, NULL, 'default1', '18', NULL, 0), (17, '1990-10-27', 18.0, 1.0, 1, '%Y', 1, '18', 'default1', '1993', '18', '1993', NULL), (18, NULL, 19.0, 1.0, 1, NULL, 18, '%Y', 'default1', '%Y', 'default2', '1993', 17), (1, '2026-10-18', 0.0, 18.0, 19, NULL, 18, '1993', '1990', '1990', '%Y', '1993', 18), (1, '2023-01-02', 0.0, 0.0, 0, NULL, NULL, '18', 'default1', 'default2', 'default2', NULL, 17), (19, '2023-01-02', 18.0, 19.0, 17, NULL, 19, NULL, '1990', '1993', NULL, '1993', 1), (0, '2026-10-18', NULL, 0.0, 1, 'default2', 1, '18', '18', NULL, NULL, '18', 17), (19, '2023-01-01', 0.0, NULL, 19, NULL, NULL, '18', '1990', 'default2', '%Y', 'default2', 0), (17, '2023-01-01', 1.0, NULL, NULL, '%Y', 0, NULL, '%Y', 'default2', '1990', '1993', 17), (NULL, '1993-10-27', 19.0, 1.0, 17, '1993', 19, '%Y', '1993', '18', '1990', NULL, NULL), (17, '1993-10-27', 19.0, 1.0, NULL, '%Y', 1, '1990', '1993', '%Y', '1993', '1990', NULL), (NULL, '2023-01-02', 1.0, 1.0, NULL, '%Y', 1, '18', NULL, '%Y', '1993', '1990', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T2."Examination Date") BETWEEN '1990' AND '1993' AND STRFTIME('%Y', T2."Examination Date") - STRFTIME('%Y', T1.Birthday) < '18';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T2."Examination Date") BETWEEN '1990' AND '1993' AND STRFTIME('%Y', T1.Birthday) > STRFTIME('%Y', T2."Examination Date") - 18;

/*
Prediction Result:
(3,)
*/