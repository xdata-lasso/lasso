-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (1, 'M', 'PSS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (2, 'F', 'PSS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (3, 'F', 'PSS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (4, 'F', 'PSS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (5, 'F', 'PSS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (6, 'F', 'PSS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (7, 'F', 'PSS');
INSERT INTO Patient (ID, SEX, Diagnosis) VALUES (8, 'F', 'PSS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (1, '1997-01-01', 'PSS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (2, '1997-01-01', 'SLE');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (3, '1997-01-01', 'PSS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (4, '1997-01-01', 'PSS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (5, '1997-01-01', 'PSS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (6, '1997-01-01', 'PSS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (7, '1997-01-01', 'PSS');
INSERT INTO Examination (ID, "Examination Date", Diagnosis) VALUES (8, '1997-01-01', 'PSS');
INSERT INTO Laboratory (ID, Date, CRP, CRE, LDH) VALUES (1, '1997-01-02', '2+', 1.0, 123);
INSERT INTO Laboratory (ID, Date, CRP, CRE, LDH) VALUES (2, '1997-01-02', '2+', 1.0, 123);
INSERT INTO Laboratory (ID, Date, CRP, CRE, LDH) VALUES (3, '1997-01-02', '1+', 1.0, 123);
INSERT INTO Laboratory (ID, Date, CRP, CRE, LDH) VALUES (4, '1997-01-02', '3+', 1.0, 123);
INSERT INTO Laboratory (ID, Date, CRP, CRE, LDH) VALUES (5, '1997-01-02', '2+', 0.9, 123);
INSERT INTO Laboratory (ID, Date, CRP, CRE, LDH) VALUES (6, '1997-01-02', '2+', 1.1, 123);
INSERT INTO Laboratory (ID, Date, CRP, CRE, LDH) VALUES (7, '1997-01-02', '2+', 1.0, 122);
INSERT INTO Laboratory (ID, Date, CRP, CRE, LDH) VALUES (8, '1997-01-02', '2+', 1.0, 124);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.SEX FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID INNER JOIN Laboratory AS T3 ON T3.ID = T2.ID WHERE T2.Diagnosis = 'PSS' AND T3.CRP = '2+' AND T3.CRE = 1.0 AND T3.LDH = 123;

/*
Gold Result:
('M',)
*/

-- Prediction Query
SELECT "patient"."sex" FROM "patient" INNER JOIN "examination" ON "patient"."id" = "examination"."id" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" WHERE "examination"."diagnosis" = 'PSS' AND "laboratory"."crp" > 2 AND "laboratory"."cre" = 1 AND "laboratory"."ldh" = 123;

/*
Prediction Result:
('M',)
('F',)
*/