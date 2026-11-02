-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483648, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2023-01-03', 711.020062, 944.247544, 2122220075, 'p6luhvdlttil', 429706943, 'SLE', 'rmdp', 'siie', 'unw6klfa', 'exa_846064', 1419861592);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-11-01', 950.466571, 796.740316, -1683203397, 'e376nium52', -443340271, 'SLE', 'uo4nrqrofqy', '5s5b', 'p', 'exa_846064', 882961052);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-11-05', 325.080047, 186.190286, 1673584235, '1', 2074205376, 'SLE', 'yytoo', 'o9hl72kl', 'x1', 'exa_846064', -74849714);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2025-11-18', 394.443388, 612.02959, 2123196517, 'dwyrq13pyu78', 244829661, 'SLE', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'exa_846064', 1836127587);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-12-28', 707.476301, 541.107536, -1937207087, 'vy9uxj4', -1612443122, 'SLE', 'd', 'lph2gn', 'q', 'exa_846064', -664193365);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-05-12', 629.317167, 668.309685, 580968159, 'cprj', -841004020, 'SLE', 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', 'exa_846064', -155284187);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2021-07-19', 176.405718, 380.641619, 1038566008, 'n6vck6ah0f', 138842628, 'exa_f6ff4b', 'wwlq7', 'xb72fxa7ryfd', 'z16ni', 'exa_846064', 2011234363);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-01-31', 128.858335, 498.231061, -1625552518, 'grgj', -458359144, 'exa_888bf8', '1afgogritsj', 'ayxp1q43', '1jh3den', 'exa_846064', 357330522);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2023-10-28', 13.875982, 860.831521, 1732258051, 'afu5w1of7', 76996700, 'exa_dd6288', 'o72ctdc', 'mfg62', '0v', 'exa_846064', 820970595);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-08-09', 632.482455, 234.606624, -288338724, '2278', 2004147439, 'SLE', 'tjpttg', 'bnou5zi36', '4', 'exa_846064', -2072838897);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2021-01-09', 660.336025, 947.886774, -1950324754, '7z2zezj', 1448731351, 'SLE', 'wgxd5ysxc', 'r0oz', 'dgj5i', 'exa_846064', -176606723);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2025-07-26', 184.430978, 217.651697, 1692046802, '5k58', -1125548818, 'SLE', '94gth', '2mnajjla3o', 'v8u', 'exa_846064', 618058035);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2024-06-15', 1.0, 1.0, 1, 'value', 1, NULL, 'value', 'value', 'value', 'value', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2022-05-03', 76.823924, 572.833475, -1402164108, 'yz7zzb', 924693315, 'kv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'exa_f1272c', 101754718);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-01-18', 648.64235, 209.98973, 1731843275, 'fofwsz', -210159774, 'SLE', 'obb0q0k32o', 'w', 'l', '5amsorlwyngc', -323362455);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2024-06-15', 1.0, 1.0, 1, 'value', 1, 'SLE', 'value', 'value', 'value', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Symptoms FROM Examination WHERE Diagnosis = 'SLE' GROUP BY Symptoms ORDER BY COUNT(Symptoms) DESC, Symptoms NULLS LAST LIMIT 1;

/*
Gold Result:
('exa_846064',)
*/

-- Prediction Query
SELECT Symptoms FROM Examination JOIN Patient ON Examination.ID = Patient.ID WHERE Patient.Diagnosis = 'SLE' GROUP BY Symptoms ORDER BY COUNT(Symptoms) DESC, Symptoms NULLS LAST LIMIT 1;

/*
Prediction Result:
*/