-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483648, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2023-01-03', 711.020062, 944.247544, 2122220075, 'S', 1072996612, 'luhvdltti', 'bnp', 'mdpos', 'ie5', 'nw6klf', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2024-07-24', 627.258639, 801.414196, 947159877, 'S', 1990080517, 'c4ecigce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2021-11-08', 486.033807, 345.329712, -1022641847, 'exa_3c8b72', -1726781632, '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2024-06-15', 1.0, 1.0, 1, NULL, 1, 'value', 'value', 'value', 'value', 'value', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-05-06', 994.117864, 749.826493, 13244799, 'S', -1659388584, 'l', 'tilbn', 'rmdp', 'siie', 'unw6klfa', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2024-09-12', 801.414196, 890.762259, 947159877, 'exa_3c8b72', 1990080517, 'c4ecigce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2024-06-15', 1.0, 1.0, 1, NULL, 1, 'value', 'value', 'value', 'value', 'value', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM Examination WHERE Thrombosis = 2 AND "ANA Pattern" = 'S' AND "aCL IgM" > (SELECT AVG("aCL IgM") * 1.2 FROM Examination WHERE Thrombosis = 2 AND "ANA Pattern" = 'S');

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) AS patient_count FROM Examination WHERE Thrombosis = 2 AND "ANA Pattern" = 'S' AND "aCL IgM" * 1.2 > (SELECT AVG("aCL IgM") FROM Examination);

/*
Prediction Result:
(2,)
*/