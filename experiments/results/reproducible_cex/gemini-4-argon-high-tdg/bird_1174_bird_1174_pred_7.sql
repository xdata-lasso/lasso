-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (10, 'F', '1950-03-10', '1989-04-01', '1989-04-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (20, 'M', '1965-07-20', '1990-06-15', '1990-06-15', '-', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (30, 'F', '1972-12-05', '1991-01-20', '1991-01-20', '+', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (40, 'M', '1920-01-01', '1988-11-11', '1988-11-11', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (50, 'F', '1910-06-15', '1987-02-28', '1987-02-28', '-', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (60, 'M', '1990-04-01', '1991-09-01', '1991-09-01', '-', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (70, 'F', '1930-08-08', '1990-10-10', '1990-10-10', '+', 'RA');
INSERT INTO Laboratory (ID, Date, GOT, GPT) VALUES (10, '1991-10-01', 21, 19);
INSERT INTO Laboratory (ID, Date, GOT, GPT) VALUES (20, '1991-10-15', 24, 22);
INSERT INTO Laboratory (ID, Date, GOT, GPT) VALUES (30, '1991-10-30', 17, 13);
INSERT INTO Laboratory (ID, Date, GOT, GPT) VALUES (40, '1991-10-31', 35, 30);
INSERT INTO Laboratory (ID, Date, GOT, GPT) VALUES (50, '1991-09-30', 28, 26);
INSERT INTO Laboratory (ID, Date, GOT, GPT) VALUES (60, '1991-11-01', 15, 12);
INSERT INTO Laboratory (ID, Date, GOT, GPT) VALUES (70, '1992-10-15', 29, 24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG('1999' - STRFTIME('%Y', T2.Birthday)) FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T1.Date BETWEEN '1991-10-01' AND '1991-10-30';

/*
Gold Result:
(36.666666666666664,)
*/

-- Prediction Query
SELECT AVG(1999 - STRFTIME('%Y', patient.birthday)) AS averageage FROM patient INNER JOIN laboratory ON patient.id = laboratory.id WHERE laboratory.date BETWEEN '1991-10-01' AND '1991-10-31';

/*
Prediction Result:
(47.25,)
*/