-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 't1__fd9ab7', '2025-06-17', '2021-11-08', '2025-06-13', 'wwqcg', 't1__113972');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 't1__fd9ab7', '2024-03-30', '2024-03-26', '2023-05-17', 'oo3o9hl72kl', 't1__113972');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'x1', '2025-05-30', '2021-08-16', '2021-06-29', '7zwau2dwyr', '13pyu');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-04-14', 171.746906, 557.512061, -1980249628, 'gu7v', -1865039888, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2021-06-28', 126.856521, 489.397796, 1861536320, '6klfa9', 1620389964, '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2025-11-02', 798.947629, 49.538289, 244829661, 'jsl', -346339240, 'yp5qi2rk', '9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2021-05-25', 353.366837, 50.647649, 1581736075, 'gndqwnqc', 555413010, '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2021-10-25', 508.771546, 591.134092, 834709651, 'f8jswwl', 1255343543, '7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2023-02-19', 127.371696, 665.416511, 678047687, '3ay', -598313376, 'q4301jh', 'den8c68x', 'vacx7afu5', '1of77p', 'o72ctdc', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2023-06-03', 695.452114, 200.834692, 7929158, '0v', 820970595, 'qdjpe1io2', '78507cvt', 'ptt', '6b', 'ou5z', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2021-06-29', 464.719657, 952.850618, 1722106924, 'f', -1173368267, 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5', '3lq', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-07-26', 184.430978, 217.651697, 1692046802, '5k58', -1125548818, '94gth', '2mnajjla3o', 'v8u', 'tmu2n', '57', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-12-24', 944.379011, 86.586744, 697257217, '7zzbe8y', -705922211, 'v42q7sx58b4p', 'aus3', 'u', 'mkrpdj', 'wzw5chn9mo70', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-06-15', 858.19408, 4.247544, 238533676, 'jxfofws', 1719800120, 'o', '2zobb0q0k32o', 'w', 'l', '5amsorlwyngc', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-10-05', 48.973066, 146.101675, 681061317, 'iz', -499913447, 'yo', 'l0hdt6fuq', 'xuzkb52', 'gwnlas6', 'elboeowii1', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-05-30', 493.031806, 207.080257, -564679000, '66', -251205568, 'xlyotow9', 'aawg', '6aqb0tbin', 'z', '9tajz9td', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2022-04-25', 655.746331, 486.084094, -625404808, 'um', 989306270, 'tdu6bd0w96', '3vzxw1r', 'e9yfk7', 'k162n', '55', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-04-04', 467.033126, 602.631056, -732999244, '6dza35r', 2072023304, 'io18ri2hy08', 'tp', 'ewtqxxnja', 'bymzn2mfx7h3', 'p6sto1cj', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-04-07', 842.068284, 117.444117, -1438303683, 'zys7dyyd1jmg', 729543907, 'c', '8q', 'ta8y3a17v4', 'ygmayq3qdpu', 'p', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T1.SEX, T1.Diagnosis FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2.Thrombosis = 2;

/*
Gold Result:
(1, 't1__fd9ab7', 't1__113972')
(3, 'x1', '13pyu')
*/

-- Prediction Query
SELECT T1.ID, T1.SEX, T1.Diagnosis FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2.Thrombosis = 2;

/*
Prediction Result:
(1, 't1__fd9ab7', 't1__113972')
(1, 't1__fd9ab7', 't1__113972')
(3, 'x1', '13pyu')
(3, 'x1', '13pyu')
(3, 'x1', '13pyu')
(3, 'x1', '13pyu')
(3, 'x1', '13pyu')
(3, 'x1', '13pyu')
(1, 't1__fd9ab7', 't1__113972')
(1, 't1__fd9ab7', 't1__113972')
(1, 't1__fd9ab7', 't1__113972')
(1, 't1__fd9ab7', 't1__113972')
(1, 't1__fd9ab7', 't1__113972')
(1, 't1__fd9ab7', 't1__113972')
*/