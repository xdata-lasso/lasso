-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'M', '1998-05-15', '1998-05-15', '1998-05-15', '1', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'F', '1970-01-01', '1998-06-01', '1998-06-01', '1', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, NULL, '1965-03-20', '1998-07-01', '1998-07-01', '0', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'M', '1980-11-11', '1997-12-31', '1997-12-31', '1', 'APS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (5, 'M', '1950-08-08', '1998-08-08', '1998-08-08', '0', 'SLE');
INSERT INTO Laboratory (ID, Date) VALUES (1, '1998-01-01');
INSERT INTO Laboratory (ID, Date) VALUES (1, '1998-06-15');
INSERT INTO Laboratory (ID, Date) VALUES (1, '1998-12-31');
INSERT INTO Laboratory (ID, Date) VALUES (1, '1997-12-31');
INSERT INTO Laboratory (ID, Date) VALUES (1, '1999-01-01');
INSERT INTO Laboratory (ID, Date) VALUES (2, '1998-05-05');
INSERT INTO Laboratory (ID, Date) VALUES (3, '1998-05-05');
INSERT INTO Laboratory (ID, Date) VALUES (4, '1997-05-05');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (1, '1998-01-01', 'SLE');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (5, '1998-08-08', 'SLE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T1.ID) AS REAL) / 12 FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T2.Date) = '1998' AND T1.SEX = 'M';

/*
Gold Result:
(0.25,)
*/

-- Prediction Query
SELECT AVG(total_patients_per_month) AS average_patients_per_month FROM (SELECT STRFTIME('%m', L."Date") AS month, COUNT(P.ID) AS total_patients_per_month FROM Laboratory AS L INNER JOIN Patient AS P ON L.ID = P.ID WHERE P.SEX = 'M' AND L."Date" BETWEEN '1998-01-01' AND '1998-12-31' GROUP BY STRFTIME('%m', L."Date")) AS subquery;

/*
Prediction Result:
(1.0,)
*/