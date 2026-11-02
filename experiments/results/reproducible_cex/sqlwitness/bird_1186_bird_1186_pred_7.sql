-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, '1997-01-01', '1997-12-30', NULL, '2023-01-01', 'default2', '1997-12-31'), (1, NULL, '1998-01-01', '1997-12-31', '1997-01-02', '1997-01-01', '1997-12-31'), (2, 'Behcet', '1997-12-30', '1997-01-02', '1996-12-31', 'Behcet', 'default1'), (3, NULL, '1997-01-01', '1997-12-31', '1998-01-01', 'Behcet', '1997-01-01'), (4, '1997-01-01', NULL, '1997-01-01', '1997-12-30', NULL, 'default2');
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (4, NULL, 1.0, 1.0, 1, '1997-12-31', 1, NULL, '1997-01-01', 'Behcet', '1997-12-31', '1997-12-31', 0), (2, '1998-01-01', 1.0, 0.0, 1, NULL, 0, 'default2', '1997-12-31', 'Behcet', 'Behcet', '1997-01-01', 1), (0, '1997-12-31', 0.0, NULL, 0, NULL, 0, NULL, 'Behcet', NULL, 'Behcet', 'default1', 1), (3, NULL, 1.0, 1.0, NULL, '1997-01-01', 0, NULL, '1997-01-01', '1997-12-31', NULL, 'Behcet', NULL), (NULL, '1997-01-02', NULL, NULL, 1, NULL, 1, 'default1', '1997-12-31', 'Behcet', '1997-12-31', 'default1', NULL), (2, '1998-01-01', 1.0, NULL, 1, '1997-01-01', 1, 'default1', 'Behcet', '1997-01-01', 'default2', 'default1', 0), (3, '1997-12-30', 1.0, NULL, NULL, 'default2', 0, 'default2', '1997-12-31', '1997-12-31', '1997-12-31', 'Behcet', 1), (1, '2023-01-02', NULL, NULL, NULL, 'Behcet', 0, '1997-01-01', '1997-12-31', '1997-01-01', '1997-01-01', 'default2', 1), (0, '1997-01-01', 1.0, 1.0, NULL, 'default1', NULL, 'Behcet', '1997-01-01', NULL, 'default2', 'default1', 1), (0, '1997-01-01', 1.0, NULL, 0, 'Behcet', NULL, 'default2', 'default1', 'Behcet', 'default1', 'default2', NULL), (3, '1998-01-01', NULL, 0.0, 0, '1997-12-31', 1, 'Behcet', NULL, 'Behcet', NULL, 'Behcet', 1), (NULL, '1997-12-30', 1.0, 1.0, 1, '1997-01-01', 0, 'default2', '1997-01-01', 'default1', NULL, '1997-01-01', 1), (NULL, '1998-01-01', 0.0, 0.0, 1, 'default1', NULL, 'default2', 'default1', '1997-01-01', NULL, 'default1', 0), (2, '1997-12-30', 0.0, NULL, 0, NULL, NULL, 'default2', 'Behcet', '1997-12-31', 'Behcet', '1997-01-01', 0), (0, '1997-12-30', 1.0, 0.0, 1, 'Behcet', 0, NULL, '1997-01-01', 'default1', 'Behcet', NULL, 0), (2, '1997-12-31', 0.0, NULL, 1, 'Behcet', 0, 'Behcet', '1997-01-01', '1997-01-01', 'default1', '1997-12-31', NULL), (0, '1997-12-31', 1.0, 1.0, 0, 'Behcet', 0, 'default2', 'default2', NULL, 'default1', 'default1', 1), (1, '1997-01-01', 0.0, 0.0, NULL, 'default1', 0, 'default2', '1997-01-01', '1997-01-01', '1997-01-01', '1997-01-01', NULL), (0, '1997-01-02', NULL, 1.0, 0, 'default1', 1, 'default2', NULL, 'Behcet', NULL, '1997-01-01', 0), (0, '1997-01-01', NULL, 0.0, 0, 'default2', NULL, 'Behcet', 'default2', NULL, 'Behcet', 'Behcet', NULL), (4, '1998-01-01', NULL, 1.0, 0, NULL, NULL, '1997-12-31', 'Behcet', '1997-01-01', 'default1', '1997-12-31', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ID FROM Examination WHERE "Examination Date" BETWEEN '1997-01-01' AND '1997-12-31' AND Diagnosis = 'Behcet';

/*
Gold Result:
(0,)
(2,)
(0,)
*/

-- Prediction Query
SELECT DISTINCT patient.id FROM patient INNER JOIN examination ON patient.id = examination.id WHERE examination.diagnosis = 'Behcet' AND examination."Examination Date" BETWEEN '1997-01-01' AND '1997-12-31';

/*
Prediction Result:
(0,)
(2,)
*/