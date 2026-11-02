-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 't2__8e1a91');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483647, 'klfa9000t', '2025-07-01', '2020-06-05', '2025-04-12', 'ecigce376n', 't2__8e1a91');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'd2', '2024-11-12', '2023-10-23', '2024-05-17', '9uxj4hwbdvl', 'I');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 'h2gn', '2020-08-28', '2022-11-09', '2023-11-15', 'qcx5', 'hncprjtu0dz');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 't2__ef6a5c');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'hria2ypuzhs', '2023-01-03', '2023-11-30', '2020-05-06', 'p', 't2__ef6a5c');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 779.409124, 640.719621, 1160656988, 'ia2yp', -1670923962, 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'ie5', -1209887326);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 805.746877, 322.782838, 283598170, 'zbuo4nrq', 418417917, 'fqyp', 's5bbp02e', 'tliqa1', 'ryytoo3', '9hl7', 1178636309);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 176.308171, 763.856372, 1055976837, '4ji7zwa', 2123196517, 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', -1529584866);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (5, '1985-01-01', 521.610309, 654.674676, -1748371085, 'q8', -1255130038, '3d', 'qv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', 602161869);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (5, '1985-01-01', 814.417862, 987.646344, -961217731, 'dr', 777149609, '16nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', -598313376);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (5, '1985-01-01', 959.196496, 917.425128, 804529642, '01jh3den', 357330522, '68x8vacx7a', 'u5', '1of77p', 'o72ctdc', 'mfg62', -1744557630);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (5, '1985-01-01', 935.463334, 492.883123, 820970595, 'qdjpe1io2', 199672698, '7cvtjpt', 'tg6bnou5zi', '6c4bfkfo', 'c', '0', 76987628);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (5, '1985-01-01', 441.061634, 64.04039, 641521863, 'o7w', -542502665, 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 's27p2r94gth2', 1162591638);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 625.532672, 822.122444, -2136247961, 'la3', 1803796945, '8uttmu', 'ne578lfv', 'yz7zzbe8yvk', 'v42q7sx58b4p', 'aus3', -2090240067);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 337.117577, 160.717227, 274891948, 'pdjwzw5chn9', 101754718, 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 709097796);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 270.763563, 359.123233, -1689155697, 'dj9erhi', 1056589776, 'k1', 'yoeyo6l0hdt6', 'uq', 'xuzkb52', 'gwnlas6', -2076274980);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 903.105468, 230.129952, -1589605308, 'z5nxih6', -251205568, 'xlyotow9', 'aawg', '6aqb0tbin', 'z', '9tajz9td', 152478847);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 655.746331, 486.084094, -625404808, 'um', 989306270, 'tdu6bd0w96', '3vzxw1r', 'e9yfk7', 'k162n', '55', 2105860871);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 467.033126, 602.631056, -732999244, '6dza35r', 2072023304, 'io18ri2hy08', 'tp', 'ewtqxxnja', 'bymzn2mfx7h3', 'p6sto1cj', 1728926031);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 485.281618, 207.572242, 1106724223, 'ys7dyyd1jmg', 729543907, 'c', '8q', 'ta8y3a17v4', 'ygmayq3qdpu', 'p', -845136979);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 857.029414, 257.163132, -1670945624, 'wlic7dn2', 1409697108, 'p490xdmsqt', 'el', 'u', 'qb9i9f2ccu', 'jq1', 1584429327);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 133.130417, 436.22226, 1570917601, 'hb08hlst1pq', 1980131681, 'iztv', '6', '4iz7', 'aqqlud8ft', '8', 1183069552);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 429.343103, 484.123386, -1057355067, 'e6bje', 364280973, 'wsj8kj', '85', 'pxlvri', 'surz0kaqtncg', 'c8s3b7v88k', -622923312);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (4, '1985-01-01', 503.083789, 320.851235, -1659388584, 'l', -845863578, 'lbn', 'rmdp', 'siie', 'unw6klfa', '9000t5c4ec', -1683203397);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '1985-01-01', 623.093099, 467.07027, -1585009206, '52zb', 757448742, '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', -1666765085);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Diagnosis FROM Examination AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T1."Examination Date" BETWEEN '1985-01-01' AND '1995-12-31' GROUP BY T2.Diagnosis ORDER BY COUNT(T2.Diagnosis) DESC, T2.Diagnosis NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__8e1a91',)
*/

-- Prediction Query
SELECT diagnosis FROM examination WHERE "Examination Date" BETWEEN '1985-01-01' AND '1995-12-31' GROUP BY diagnosis ORDER BY COUNT(diagnosis) DESC, diagnosis NULLS LAST LIMIT 1;

/*
Prediction Result:
('16nijjai5dh',)
*/