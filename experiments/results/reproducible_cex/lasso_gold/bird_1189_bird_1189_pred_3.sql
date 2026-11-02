-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1025, 'husband', '1994-03-02', '1997-06-05', '1971-09-08', 'throw', 'everything');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1026, 'bill', '1994-03-03', '1997-06-06', '1971-09-09', 'guy', 'surface');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1027, 'her', '1994-03-04', '1997-06-07', '1971-09-10', 'PM', 'animal');
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1025, '1974-01-11', 1028.5, -3.0, 1031, 'S', 1034, 'show', 'capital', 'bar', 'themselves', 'value', 2);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1025, '1974-01-12', 1035.5, -1.0, 1042.0, 'best', 1049.0, 'machine', 'win', 'old', 'production', 'training', 3);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1025, '1974-01-13', 1042.5, 1.0, 1053.0, 'S', 1064.0, 'not', 'human', 'finally', 'present', 'high', 2);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1025, '1974-01-11', 1028.5, -3.0, 1031, 'S', 1034, 'show', 'capital', 'bar', 'themselves', 'value', 2);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1025, '1974-01-11', 1028.5, 9.0, 1031, 'S', 1034, 'show', 'capital', 'bar', 'themselves', 'value', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM Examination WHERE Thrombosis = 2 AND "ANA Pattern" = 'S' AND "aCL IgM" > (SELECT AVG("aCL IgM") * 1.2 FROM Examination WHERE Thrombosis = 2 AND "ANA Pattern" = 'S');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Examination WHERE Thrombosis = 2 AND "ANA Pattern" = 'S' AND "aCL IgM" > (SELECT AVG("aCL IgM") * 1.2 FROM Examination WHERE NOT "aCL IgM" IS NULL);

/*
Prediction Result:
(2,)
*/