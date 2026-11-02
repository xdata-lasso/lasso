-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (1, 'F', 'RA');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (2, 'M', 'SLE');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (3, 'F', 'SLE');
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Symptoms) VALUES (1, '2020-01-01', 'SLE', 'thrombocytopenia');
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Symptoms) VALUES (1, '2020-01-02', 'APS', 'thrombocytopenia');
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Symptoms) VALUES (2, '2020-01-03', NULL, 'thrombocytopenia');
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Symptoms) VALUES (3, '2020-01-04', 'SLE', 'arthritis');
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Symptoms) VALUES (3, '2020-01-05', 'APS', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN Diagnosis = 'SLE' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(ID) FROM Examination WHERE Symptoms = 'thrombocytopenia';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN "examination"."symptoms" LIKE '%thrombocytopenia%' THEN 1 ELSE 0 END) * 100.0 / SUM(CASE WHEN "examination"."diagnosis" LIKE '%SLE%' THEN 1 ELSE 0 END)) AS proportion FROM "examination" INNER JOIN "patient" ON "examination"."id" = "patient"."id" WHERE "examination"."symptoms" LIKE '%thrombocytopenia%' AND "examination"."diagnosis" LIKE '%SLE%';

/*
Prediction Result:
(100.0,)
*/