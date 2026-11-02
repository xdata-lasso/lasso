-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1980-01-01', '2019-01-01', '2019-01-02', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1975-05-05', '2018-05-05', '2018-05-06', '-', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'F', '1990-10-10', '2020-10-10', '2020-10-11', '+', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'M', '1965-03-03', '2017-03-03', '2017-03-04', '-', 'SLE');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (1, '2020-01-10', 'SLE');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (3, '2022-11-20', 'APS');
INSERT INTO Laboratory (ID, Date, ALB) VALUES (1, '2020-01-10', 3.8);
INSERT INTO Laboratory (ID, Date, ALB) VALUES (2, '2021-06-15', 5.2);
INSERT INTO Laboratory (ID, Date, ALB) VALUES (3, '2022-11-20', 4.5);
INSERT INTO Laboratory (ID, Date, ALB) VALUES (4, '2023-01-01', 6.1);
INSERT INTO Laboratory (ID, Date, ALB) VALUES (4, '2019-01-01', 2.9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Date FROM Laboratory WHERE ALB BETWEEN 3.5 AND 5.5 ORDER BY ALB DESC, Laboratory.id NULLS LAST, Laboratory.date NULLS LAST LIMIT 1;

/*
Gold Result:
('2021-06-15',)
*/

-- Prediction Query
SELECT "examination"."examination date" FROM "examination" INNER JOIN "laboratory" ON "examination"."id" = "laboratory"."id" WHERE "laboratory"."alb" = (SELECT MAX("alb") FROM "laboratory" WHERE "alb" > 3.5 AND "alb" < 5.5 AND "laboratory"."id" = "examination"."id");

/*
Prediction Result:
('2020-01-10',)
('2022-11-20',)
*/