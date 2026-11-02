-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic T-CHO DESC ordering, LIMIT 1, and INNER JOIN filtering (Patient 3 has no Laboratory record, Patient 4 has Examination instead of Laboratory).
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1980-05-15', '2020-01-01', '2019-01-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1975-03-20', '2020-02-01', '2019-02-01', '-', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'F', '1950-01-01', '2020-03-01', '2019-03-01', '+', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'M', '1960-06-10', '2020-04-01', '2019-04-01', '-', 'SJS');
INSERT INTO Laboratory (ID, Date, "T-CHO", GOT, GPT) VALUES (1, '2020-01-10', 220, 25, 30);
INSERT INTO Laboratory (ID, Date, "T-CHO", GOT, GPT) VALUES (2, '2020-02-15', 280, 40, 45);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (4, '2020-04-05', 'SJS', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID, T2."T-CHO" FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID ORDER BY T2."T-CHO" DESC, T1.Birthday ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
(2, 280)
*/

-- Prediction Query
SELECT "p"."id", "l"."t-cho" FROM "patient" AS "p" INNER JOIN "laboratory" AS "l" ON "p"."id" = "l"."id" WHERE "p"."birthday" = (SELECT MIN("birthday") FROM "patient") ORDER BY "l"."t-cho" DESC, p.id NULLS LAST, l.id NULLS LAST, l.date NULLS LAST LIMIT 1;

/*
Prediction Result:
*/