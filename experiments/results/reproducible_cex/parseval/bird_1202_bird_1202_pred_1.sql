-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 'M', '2025-06-17', '2021-11-08', '2025-06-13', '-', 'wwqcg');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'M', '2020-11-04', '2025-06-27', '2023-09-04', '-', 'w6kl');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'a9', '2024-07-24', '2024-09-12', '2024-09-18', '5c4ec', 'gce');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1995-01-01', 292.730571, 572.766956, 1610062532, 'pgu7vfe4', 1160656988, 'Behcet', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', -1576219117);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '1995-01-01', 467.07027, 875.837169, -1585009206, '52zb', 757448742, 'Behcet', '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 2137741668);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '1995-01-01', 881.232072, 377.535852, 1898504886, 'o3o9hl72klex', 1775126557, 'Behcet', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', -1116181514);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '1995-01-01', 792.401003, 137.842122, -975213201, '9v', 556727997, 'Behcet', '8pz0f8je', 'd2', 'vy9uxj4', 'wb', -1929953647);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '1995-01-01', 185.427628, 243.480613, 1581736075, 'gndqwnqc', 555413010, 'Behcet', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 638024588);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1995-01-01', 692.775559, 339.789525, 1784916884, 'ah0f8jsww', -1388029300, 'Behcet', 'xb72fxa7r', 'fdrz16n', 'jja', '5dh', 1583472758);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1995-01-01', 837.437794, 272.414976, -1478247928, 'yzt1afgog', -946046410, 'Behcet', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', 'afu5w1of7', 76996700);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1995-01-01', 398.637058, 689.065203, 1992637800, 'dctmf', 7929158, 'Behcet', '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 1582582341);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1995-01-01', 605.666938, 107.390057, 1467355421, 'ou5z', 1691780814, 'Behcet', '6c4bfkfo', 'c', '0', '7z2zezjo7wg', 1248858185);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1995-01-01', 50.798088, 486.564401, -915385605, 'm', 1721638020, 'Behcet', '0oztdgj5i3lq', '5lnpim5k58qs', '7p2r94gt', '2m', 418247369);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1995-01-01', 145.067008, 185.260952, 1919033056, 'v8u', 618058035, 'Behcet', '2ne578', 'fvy', '7zzbe8y', 'kv42q7', -2060082151);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1995-01-01', 710.005534, 238.668607, 1849819405, 'us3auvmkrpdj', 1105964624, 'Behcet', 'w5chn9m', 'o705a9n0jxfo', 'ws', 'do2zobb', -397848196);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1995-01-01', 983.253685, 651.034963, -366775518, '2odwcl5a', 292557306, 'Behcet', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', -30041412);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1995-01-01', 435.41097, 343.967529, -2140468103, 'elboeowii', -268740517, 't2__53be59', 'nxih662q', 'xlyotow9', 'aawg', '6aqb0tbin', -1897615568);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1995-01-01', 466.613431, 985.521662, 2038321753, 'z9t', 748154000, 'Behcet', 'cgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', -516345261);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1995-01-01', 48.647907, 222.671584, 1709667347, '06dza3', 1595632888, 'Behcet', 'mkio18ri2hy', '08ftp6ewtqxx', 'jaby', 'mzn2mfx7h3', -891525031);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1995-01-01', 231.292236, 40.960298, 1728926031, 'knzys7dy', -531932574, 'Behcet', 'jmgjach', 'qta8y3a17', 'v4ygmayq3qdp', 'uap96rntdqr', -1670945624);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2.Diagnosis = 'Behcet' AND T1.SEX = 'M' AND STRFTIME('%Y', T2."Examination Date") BETWEEN '1995' AND '1997' AND T1.Admission = '-';

/*
Gold Result:
(12,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT e.ID) FROM Examination AS e JOIN Patient AS p ON e.ID = p.ID WHERE p.SEX = 'M' AND e.Diagnosis = 'Behcet' AND e."Examination Date" BETWEEN '1995-01-01' AND '1997-12-31' AND p.Admission = '-';

/*
Prediction Result:
(1,)
*/