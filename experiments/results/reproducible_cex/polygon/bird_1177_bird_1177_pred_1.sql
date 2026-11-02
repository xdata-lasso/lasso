-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2927464, '9015-02-16', 2927464, 2927464, 2927464, 'Normal2927464', 2927464, 'Normal2927464', 'Normal2927464', 'Normal2927464', 'Normal2927464', 'Normal2927464', 2927464);
INSERT INTO "Examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2927464, '9015-02-16', 2927464, 2927464, 2927464, 'Normal2927464', 2927464, 'Normal2927464', 'Normal2927464', 'Normal2927464', 'Normal2927464', 'Normal2927464', 2927464);
INSERT INTO "Patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (44, 'Normal2927464', '9015-02-16', '9015-02-16', '9015-02-16', 'Normal2927464', 'Normal2927464');
INSERT INTO "Patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2927464, 'Normal2927464', '9015-02-16', '9015-02-16', '9015-02-16', 'Normal2927464', 'Normal2927464');
INSERT INTO "Laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (44, '1000-02-15', 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 2927464, 'Normal2927464', 2927464, 2927464, 2927464, 'Normal2927464', 'Normal2927464', 'Normal2927464', 2927464, 2927464, 'Normal2927464', 'Normal2927464', 'Normal2927464', 'Normal2927464', 'Normal2927464', 'Normal2927464', 'Normal2927464', 2927464);
INSERT INTO "Laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2927464, '1995-09-04', 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, NULL, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 'Normal70', 71, 72, 73, 'Normal74', 'Abnormal75', 'Normal76', 77, 78, 'Abnormal79', 'Normal80', 'Abnormal81', 'Normal82', 'Abnormal83', 'Normal84', 'Abnormal85', 86);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN "T-CHO" < 250 THEN 'Normal' ELSE 'Abnormal' END FROM Laboratory WHERE ID = 2927464 AND Date = '1995-09-04';

/*
Gold Result:
('Abnormal',)
*/

-- Prediction Query
SELECT "T-CHO" < 250 AS is_normal FROM Laboratory WHERE ID = 2927464 AND Date = '1995-09-04';

/*
Prediction Result:
(None,)
*/