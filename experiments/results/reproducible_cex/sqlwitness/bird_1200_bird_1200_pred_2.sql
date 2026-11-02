-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (100, '%SLE%', '2023-01-02', '2023-01-01', '2023-01-02', 'default2', 'default1'), (2, 'SLE', '2023-01-01', '2023-01-01', NULL, 'SLE', NULL);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (NULL, '2023-01-02', 2.0, 0.0, 1, 'default2', 1, NULL, 'thrombocytopenia', '%thrombocytopenia%', 'thrombocytopenia', 'thrombocytopenia', 99), (2, NULL, 101.0, 99.0, 2, 'default1', 99, '%SLE%', NULL, 'default1', '%thrombocytopenia%', 'thrombocytopenia', 2), (NULL, '2023-01-02', 1.0, NULL, 1, '%thrombocytopenia%', 0, 'SLE', '%SLE%', 'default1', 'thrombocytopenia', 'default2', 99), (100, '2023-01-01', NULL, -1.0, 2, NULL, 0, '%SLE%', 'thrombocytopenia', '%thrombocytopenia%', NULL, '%SLE%', NULL), (100, '2023-01-01', 1.0, 0.0, 0, 'thrombocytopenia', 0, '%SLE%', 'default1', 'SLE', 'thrombocytopenia', NULL, NULL), (100, NULL, 1.0, 2.0, -1, '%SLE%', NULL, '%SLE%', '%thrombocytopenia%', 'default1', NULL, 'default1', 1), (100, NULL, 1.0, 2.0, 0, 'default2', 99, 'thrombocytopenia', 'thrombocytopenia', '%SLE%', 'default1', '%thrombocytopenia%', 100), (NULL, '2023-01-02', 100.0, -1.0, 1, 'SLE', NULL, 'default2', 'thrombocytopenia', 'thrombocytopenia', '%SLE%', NULL, 2), (2, '2023-01-01', 2.0, 100.0, NULL, 'thrombocytopenia', 101, 'default2', '%thrombocytopenia%', 'default1', 'SLE', NULL, 99), (2, NULL, 0.0, NULL, 100, 'default2', -1, '%thrombocytopenia%', 'SLE', 'default1', 'SLE', 'default2', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN Diagnosis = 'SLE' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(ID) FROM Examination WHERE Symptoms = 'thrombocytopenia';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN "examination"."symptoms" LIKE '%thrombocytopenia%' THEN 1 ELSE 0 END) * 100.0 / SUM(CASE WHEN "examination"."diagnosis" LIKE '%SLE%' THEN 1 ELSE 0 END)) AS proportion FROM "examination" INNER JOIN "patient" ON "examination"."id" = "patient"."id" WHERE "examination"."symptoms" LIKE '%thrombocytopenia%' AND "examination"."diagnosis" LIKE '%SLE%';

/*
Prediction Result:
(100.0,)
*/