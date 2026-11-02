-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483648, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2023-01-03', 711.020062, 944.247544, 2122220075, 'p6luhvdlttil', 429706943, 'A', 'rmdp', 'siie', 'unw6klfa', 'thrombocytopenia', 1419861592);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-11-01', 950.466571, 796.740316, -1683203397, 'e376nium52', -443340271, 'uo4nrqrofqy', '5s5b', 'p', '02eutliqa11r', 'thrombocytopenia', 2137741668);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2023-05-17', 668.928822, 942.030111, 624571013, 'o9hl72kl', -305670381, 'SLE', 'i7z', 'au2dwy', 'q13py', '78d99r', -1362461264);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2022-01-09', 419.361606, 470.165282, 1692174491, 'qi2rkf9v', 556727997, 'A', '8pz0f8je', 'd2', 'vy9uxj4', 'C', -1612443122);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-07-26', 328.40866, 989.653112, -1642259219, 'nd', -1052964641, 'qcx5', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'G', 172461907);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2021-10-23', 463.845085, 892.659478, -1554531873, 'yrkn6vck6ah0', -1520489792, 'A', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 1746373317);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2021-05-12', 488.601669, 781.755052, 1583472758, 'rg', -1478247928, 'yzt1afgog', 'itsj3', 'y', 'p1q430', 'thrombocytopenia', 1923912467);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2021-05-19', 774.445116, 461.908795, -1826414375, 'c68x8vacx', -1762140823, 'SLE', 'w1of77pz', '72ct', 'c', 'mfg62', -1744557630);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN Diagnosis = 'SLE' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(ID) FROM Examination WHERE Symptoms = 'thrombocytopenia';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (CAST(SUM(Diagnosis LIKE '%SLE%') AS REAL) * 100.0) / NULLIF(CAST(SUM(Symptoms LIKE '%thrombocytopenia%') AS REAL), 0) AS proportion FROM Examination;

/*
Prediction Result:
(66.66666666666667,)
*/