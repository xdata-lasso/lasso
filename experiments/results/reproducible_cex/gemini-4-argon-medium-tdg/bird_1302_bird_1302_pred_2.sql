-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests OR vs AND, individual column conditions (KCT, RVVT, LAC), operator precedence (parentheses around ORs), and COUNT(ID) vs COUNT(DISTINCT ID) via 1-to-many joins.
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (1, 'F', 'SLE');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (2, 'M', 'APS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (3, 'F', 'SLE');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (4, 'M', 'APS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (5, 'F', 'RA');
-- Patient 1: Two Lab records with CPK < 250, one Exam with ONLY KCT = '+'
INSERT INTO Laboratory (ID, Date, CPK) VALUES (1, '2020-01-01', 100);
INSERT INTO Laboratory (ID, Date, CPK) VALUES (1, '2020-01-02', 249);
INSERT INTO Examination (ID, "Examination Date", KCT, RVVT, LAC) VALUES (1, '2020-01-01', '+', '-', '-');
-- Patient 2: One Lab with CPK < 250, one Exam with ONLY RVVT = '+'
INSERT INTO Laboratory (ID, Date, CPK) VALUES (2, '2020-01-01', 150);
INSERT INTO Examination (ID, "Examination Date", KCT, RVVT, LAC) VALUES (2, '2020-01-01', '-', '+', NULL);
-- Patient 3: One Lab with CPK < 250, one Exam with ONLY LAC = '+'
INSERT INTO Laboratory (ID, Date, CPK) VALUES (3, '2020-01-01', 200);
INSERT INTO Examination (ID, "Examination Date", KCT, RVVT, LAC) VALUES (3, '2020-01-01', NULL, '-', '+');
-- Patient 4: CPK >= 250, but RVVT = '+' and LAC = '+' (Kills missing parentheses around ORs: A AND B OR C OR D)
INSERT INTO Laboratory (ID, Date, CPK) VALUES (4, '2020-01-01', 300);
INSERT INTO Examination (ID, "Examination Date", KCT, RVVT, LAC) VALUES (4, '2020-01-01', '-', '+', '+');
-- Patient 5: All three '+', and CPK < 250
INSERT INTO Laboratory (ID, Date, CPK) VALUES (5, '2020-01-01', 120);
INSERT INTO Examination (ID, "Examination Date", KCT, RVVT, LAC) VALUES (5, '2020-01-01', '+', '+', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T2.CPK < 250 AND (T3.KCT = '+' OR T3.RVVT = '+' OR T3.LAC = '+');

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "Examination"."ID") FROM "Examination" INNER JOIN "Laboratory" ON "Examination"."ID" = "Laboratory"."ID" WHERE "Laboratory"."CPK" < 250 AND ("Examination"."KCT" = '+' OR "Examination"."RVVT" = '+' OR "Examination"."LAC" = '+');

/*
Prediction Result:
(4,)
*/