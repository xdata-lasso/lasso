-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1980-05-10', '2005-01-01', '2004-06-15', 'Outpatient', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1970-12-28', '1998-03-20', '1997-11-10', 'Inpatient', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'F', '1965-08-14', '2001-07-04', '1999-02-28', 'Outpatient', 'RA');
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB, WBC, RBC, HGB, HCT, PLT) VALUES (1, '2010-04-12', 45, 50, 300, 250, 8.2, 4.8, 9.5, 5.8, 9.8, 52.0, 400);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB, WBC, RBC, HGB, HCT, PLT) VALUES (2, '2000-01-05', 20, 18, 150, 120, 6.8, 3.9, 5.2, 4.5, 14.5, 41.0, 210);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB, WBC, RBC, HGB, HCT, PLT) VALUES (3, '2008-09-22', 30, 28, 210, 180, 7.4, 4.2, 6.8, 4.9, 13.9, 44.5, 280);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (1, '2011-02-01', 'MCTD', 0);
INSERT INTO Examination (ID, "Examination Date", Diagnosis, Thrombosis) VALUES (2, '2002-06-15', 'SJS', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STRFTIME('%Y', T2.Date) - STRFTIME('%Y', T1.Birthday), T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID ORDER BY T2.HGB DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
(30, 'APS')
*/

-- Prediction Query
SELECT STRFTIME('%Y', "examination"."examination date") - STRFTIME('%Y', "patient"."birthday") AS age, "examination"."diagnosis" FROM "patient" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" INNER JOIN "examination" ON "patient"."id" = "examination"."id" WHERE "laboratory"."hgb" = (SELECT MAX("hgb") FROM "laboratory" WHERE "laboratory"."id" = "patient"."id") LIMIT 1;

/*
Prediction Result:
(31, 'MCTD')
*/