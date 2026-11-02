-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (821298, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2024-06-15', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'p5s5bbp', '2024-08-27', '2024-12-15', '2020-11-05', 'tliqa1', 'ryytoo3');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 'o', '2025-01-21', '2024-06-24', '2024-06-15', 'obb0q0k32o', 'w');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (821298, '2024-06-15', 882.963176, 841.297061, -1349201381, 'hvdlttilbnpr', 2087640001, 'dposiie5unw', 'klfa9000t', 'c4ecigce', '76nium52', 'zbuo4nrqrof', 373262291);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2024-06-15', 228.583847, 111.926013, 1178636309, 'ex1', -74849714, '7zw', 'au2dwyrq13', 'yu78', '9', 'rljsl0b4y', -1116181514);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2024-06-15', 792.401003, 137.842122, -975213201, '9v', 556727997, '8pz0f8je', 'd2', 'vy9uxj4', 'wb', 'v', 1581736075);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2024-06-15', 439.200238, 795.815869, -1264842910, 'wnqcx', 722884590, 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 'kn6vc', 1784916884);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (821298, '2024-06-15', 508.771546, 591.134092, 834709651, 'f8jswwl', 1255343543, '7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', -946046410);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (821298, '2024-06-15', 630.468925, 309.988616, -902895762, 'ayxp1q43', 1235416111, 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 1303877941);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (821298, '2024-06-15', 695.452114, 200.834692, 7929158, '0v', 820970595, 'qdjpe1io2', '78507cvt', 'ptt', '6b', 'ou5z', 1691780814);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (821298, '2024-06-15', 464.719657, 952.850618, 1722106924, 'f', -1173368267, 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5', '3lq', 1816660482);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (821298, '2024-06-15', 184.430978, 217.651697, 1692046802, '5k58', -1125548818, '94gth', '2mnajjla3o', 'v8u', 'tmu2n', '57', -1402164108);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (821298, '2024-06-15', 988.50905, 994.409325, -526633767, 'zzbe8yvkv', 318331233, 'q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', 'a9n0jxfofws', 1719800120);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 38.169466, 179.038075, 440115543, 'msorlwyngc', -323362455, 'j9erhizgk1', 'yoeyo6l0hdt6', 'uq', 'xuzkb52', 'gwnlas6', -2076274980);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STRFTIME('%d', T3."Examination Date") - STRFTIME('%d', T1."First Date") FROM Patient AS T1 INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T1.ID = 821298;

/*
Gold Result:
(0,)
(0,)
(0,)
(0,)
(0,)
(0,)
(0,)
*/

-- Prediction Query
SELECT CAST(JULIANDAY(MIN(e."Examination Date")) - JULIANDAY(p."First Date") AS REAL) AS days_between FROM Examination AS e JOIN Patient AS p ON e.ID = p.ID WHERE p.ID = 821298;

/*
Prediction Result:
(0.0,)
*/