-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'F', NULL, NULL, '1997-10-27', '1997', '%Y'), (0, 'F', '2023-01-01', '1997-10-27', NULL, '1997', '1997'), (2, 'default1', '2023-01-02', '2023-01-02', '2023-01-01', 'F', 'F'), (3, '1997', '1997-10-27', '2023-01-01', '2023-01-02', 'default1', 'F'), (4, 'F', NULL, NULL, NULL, '1997', '-'), (5, 'default2', NULL, NULL, '2023-01-02', '-', 'F'), (6, '1997', '2023-01-02', '1997-10-27', NULL, '-', 'default2'), (7, 'F', '1997-10-27', NULL, '2023-01-02', 'F', 'default2'), (8, '1997', NULL, NULL, '2023-01-01', 'default1', NULL), (9, 'F', '1997-10-27', '1997-10-27', NULL, '-', '%Y');
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (NULL, '2023-01-02', 0.0, 1.0, NULL, 'default2', 0, '-', '-', '-', 'default1', 'default2', NULL), (4, '2023-01-01', 1.0, 0.0, 0, '%Y', 0, '1997', 'F', 'F', 'default2', 'default2', NULL), (4, '2023-01-01', 1.0, 1.0, 0, '-', 0, '-', '%Y', '-', '1997', 'default2', 0), (6, '2023-01-02', 0.0, NULL, 1, NULL, 0, 'F', 'default2', 'default2', NULL, 'default2', 1), (9, '1997-10-27', 0.0, NULL, 1, '%Y', 1, 'default2', NULL, '-', 'default2', 'default2', 1), (8, '2023-01-02', NULL, 1.0, NULL, '-', 1, '1997', NULL, NULL, NULL, NULL, 0), (4, '2023-01-01', 0.0, NULL, NULL, '%Y', 1, 'default2', NULL, 'default1', 'default2', '-', 1), (9, NULL, NULL, 0.0, NULL, '%Y', 0, 'default2', 'F', '%Y', 'default2', 'default2', 1), (NULL, '1997-10-27', NULL, 1.0, 0, '%Y', 1, '-', '1997', 'default1', '1997', NULL, 1), (5, '2023-01-02', 0.0, NULL, 0, '%Y', 0, 'F', 'default2', '1997', 'F', '%Y', NULL), (4, '1997-10-27', 1.0, 1.0, 0, 'default1', NULL, 'default2', 'default1', 'default2', '1997', NULL, 1), (3, '2023-01-02', 1.0, NULL, NULL, 'default1', NULL, '%Y', 'F', '%Y', NULL, NULL, 1), (5, '1997-10-27', NULL, NULL, 0, 'default2', 0, '1997', '1997', '%Y', NULL, '1997', 0), (4, NULL, 1.0, NULL, 0, 'F', 1, '1997', '%Y', 'default1', '1997', '-', 0), (8, NULL, 1.0, 0.0, NULL, '%Y', 1, 'default1', '1997', 'default2', '1997', 'F', 0), (NULL, '2023-01-02', 1.0, 0.0, NULL, NULL, 1, '1997', '%Y', '%Y', '1997', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM Patient WHERE STRFTIME('%Y', Description) = '1997' AND SEX = 'F' AND Admission = '-';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T1.SEX = 'F' AND STRFTIME('%Y', T1.Description) = '1997' AND T1.Admission = '-';

/*
Prediction Result:
(2,)
*/