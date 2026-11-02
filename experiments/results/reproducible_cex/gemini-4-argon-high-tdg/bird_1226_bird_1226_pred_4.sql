-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (1, 'F', '1940-01-01', '1995-01-01', '1995-01-01', '+', 'SLE');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (2, 'M', '1950-05-15', '1996-03-10', '1996-03-10', '+', 'RA');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (3, 'F', '1985-11-20', '1997-07-22', '1997-07-22', '-', 'SJS');
INSERT INTO Patient (ID, SEX, Birthday, Description, "First Date", Admission, Diagnosis) VALUES (4, 'M', '1970-03-10', '1998-02-14', '1998-02-14', '+', 'SLE');
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (1, '1995-01-05', 15.2, 8.1, 640, 'S', 5, 'SLE', '+', '+', '+', 'arthritis', 1);
INSERT INTO Examination (ID, "Examination Date", "aCL IgG", "aCL IgM", ANA, "ANA Pattern", "aCL IgA", Diagnosis, KCT, RVVT, LAC, Symptoms, Thrombosis) VALUES (2, '1996-03-12', 10.0, 4.0, 160, 'H', 2, 'RA', '-', '-', '-', 'fever', 0);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB, UA, UN, CRE, "T-BIL", "T-CHO", TG, CPK, GLU) VALUES (2, '1996-03-12', 120, 110, 450, 310, 8.2, 4.5, 7.8, 28, 1.4, 2.5, 180, 400, 350, 140);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB, UA, UN, CRE, "T-BIL", "T-CHO", TG, CPK, GLU) VALUES (3, '1997-07-25', 25, 20, 180, 150, 6.8, 3.9, 4.2, 12, 0.7, 0.8, 320, 150, 80, 90);
INSERT INTO Laboratory (ID, Date, GOT, GPT, LDH, ALP, TP, ALB, UA, UN, CRE, "T-BIL", "T-CHO", TG, CPK, GLU) VALUES (4, '1998-02-15', 40, 35, 210, 190, 7.1, 4.1, 5.5, 18, 0.9, 1.1, 95, 220, 110, 105);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID, T2."T-CHO" FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID ORDER BY T2."T-CHO" DESC, T1.Birthday ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
(3, 320)
*/

-- Prediction Query
SELECT p.ID, l."T-CHO" FROM Patient AS p JOIN Laboratory AS l ON p.ID = l.ID WHERE p.Birthday = (SELECT MIN(Birthday) FROM Patient) ORDER BY l."T-CHO" DESC, p.id NULLS LAST, l.id NULLS LAST, l.date NULLS LAST LIMIT 1;

/*
Prediction Result:
*/