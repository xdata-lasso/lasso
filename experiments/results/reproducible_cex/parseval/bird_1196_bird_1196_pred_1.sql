-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483648, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2023-01-03', 711.020062, 944.247544, 2122220075, 'p6luhvdlttil', 429706943, 'SLE', 'rmdp', 'siie', 'unw6klfa', 'exa_5dc718', 1419861592);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-11-01', 950.466571, 796.740316, -1683203397, 'e376nium52', -443340271, 'SLE', 'uo4nrqrofqy', '5s5b', 'p', 'exa_5dc718', 882961052);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-11-05', 325.080047, 186.190286, 1673584235, '1', 2074205376, 'SLE', 'yytoo', 'o9hl72kl', 'x1', 'exa_5dc718', -74849714);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2025-11-18', 394.443388, 612.02959, 2123196517, 'dwyrq13pyu78', 244829661, 'SLE', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'exa_5dc718', 1836127587);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-12-28', 707.476301, 541.107536, -1937207087, 'vy9uxj4', -1612443122, 'SLE', 'd', 'lph2gn', 'q', 'exa_5dc718', -664193365);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-05-12', 629.317167, 668.309685, 580968159, 'cprj', -841004020, 'SLE', 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', 'exa_5dc718', -155284187);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-03-07', 138.057338, 728.712934, 638024588, '6vck6ah0f8js', -658391922, 'SLE', 'q7x', '7', '2fxa7ryfdrz', 'exa_9180ba', 61479715);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2021-06-18', 968.276986, 154.68882, -7597509, 'h5ogrgjd8yz', 1250290042, 'SLE', 'og', 'itsj3', 'y', 'exa_9180ba', -598313376);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2022-11-12', 632.340892, 687.319156, -1538707438, 'den8c68x', 1774087382, 'exa_46a56a', 'c', 'x7afu5w1of77', 'zo72', 'ctdctmfg62g0', 1870300798);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2024-06-15', 1.0, 1.0, 1, 'value', 1, NULL, 'value', 'value', 'value', 'value', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2022-12-09', 53.966914, 153.511511, -1858644047, 'o22', 2004147439, 'SLE', 'tjpttg', 'bnou5zi36', '4', 'f', -1173368267);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2020-09-06', 992.626961, 668.776683, 76987628, 'zezjo7wg', 1248858185, '5', 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5', 'exa_f1272c', -1125548818);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (-2147483648, '2024-06-15', 1.0, 1.0, 1, 'value', 1, 'SLE', 'value', 'value', 'value', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Symptoms FROM Examination WHERE Diagnosis = 'SLE' GROUP BY Symptoms ORDER BY COUNT(Symptoms) DESC, Symptoms NULLS LAST LIMIT 1;

/*
Gold Result:
('exa_5dc718',)
*/

-- Prediction Query
SELECT E.Symptoms FROM Patient AS P INNER JOIN Examination AS E ON P.ID = E.ID WHERE P.Diagnosis = 'SLE' GROUP BY E.Symptoms ORDER BY COUNT(E.Symptoms) DESC, E.Symptoms NULLS LAST LIMIT 1;

/*
Prediction Result:
*/