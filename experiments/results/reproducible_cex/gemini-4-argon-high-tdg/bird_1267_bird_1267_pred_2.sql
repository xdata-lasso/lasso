-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (10, 'F', '1962-03-14', '1994-05-01', '1994-05-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (11, 'F', '1968-07-22', '1994-06-01', '1994-06-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (12, 'M', '1950-12-05', '1994-07-01', '1994-07-01', '-', 'MCTD');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (13, 'F', '1975-09-30', '1994-08-01', '1994-08-01', '+', 'SLE');
INSERT INTO Examination (ID, "Examination Date", ANA, "aCL IgA", Diagnosis, Thrombosis) VALUES (10, '1997-02-20', 0, 0, 'SLE', 1);
INSERT INTO Examination (ID, "Examination Date", ANA, "aCL IgA", Diagnosis, Thrombosis) VALUES (11, '1997-03-15', 1, 1, 'SLE', 2);
INSERT INTO Examination (ID, "Examination Date", ANA, "aCL IgA", Diagnosis, Thrombosis) VALUES (12, '1997-04-10', 1, 1, 'MCTD', 3);
INSERT INTO Examination (ID, "Examination Date", ANA, "aCL IgA", Diagnosis, Thrombosis) VALUES (13, '1997-05-05', 1, 1, 'SLE', NULL);
INSERT INTO Laboratory (ID, Date, RNP, SM, SC170, SSA, SSB, CENTROMEA, DNA) VALUES (10, '1994-11-11', '1', '0', '1', '1', '1', '1', '1');
INSERT INTO Laboratory (ID, Date, RNP, SM, SC170, SSA, SSB, CENTROMEA, DNA) VALUES (11, '1997-03-15', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO Laboratory (ID, Date, RNP, SM, SC170, SSA, SSB, CENTROMEA, DNA) VALUES (12, '1997-04-10', 'negative', 'negative', 'negative', 'negative', 'negative', 'negative', 'negative');
INSERT INTO Laboratory (ID, Date, RNP, SM, SC170, SSA, SSB, CENTROMEA, DNA) VALUES (13, '1997-05-05', '0', '0', '0', '0', '0', '0', '0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Examination AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.SM IN ('negative', '0') AND T1.Thrombosis = 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "patient"."id") FROM "patient" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" INNER JOIN "examination" ON "patient"."id" = "examination"."id" WHERE "laboratory"."sm" IN ('-', '+-', 'negative', '0') AND "examination"."thrombosis" = 0;

/*
Prediction Result:
(0,)
*/