-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2024-06-15', '8c4pgu7vfe', 't1__5bfc1d');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483648, 'hria2ypu', '2024-06-23', '2021-03-30', '2024-06-15', 'rwbbp', 't1__5bfc1d');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'ph2', '2021-03-22', '2022-04-21', '2024-06-15', 'q', 't1__5bfc1d');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'ah0f8jsww', '2021-12-25', '2022-12-03', '2025-11-05', 'xb72fxa7ryfd', 'z16ni');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 503.083789, 320.851235, -1659388584, 'l', -845863578, 'SLE', 'lbn', 'rmdp', 'siie', 'unw6klfa', 1419861592);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 663.001988, 587.103196, 1274489983, 'gce', -1585009206, 'SLE', '52zb', 'uo4nrqrofqy', '5s5b', 'p', 882961052);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 673.065986, 825.231787, -1822992503, 'liqa1', 2074205376, 'yytoo', 'o9hl72kl', 'x1', 'ji7zwau2', 'dwyrq13pyu78', 244829661);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 182.777264, 943.791649, -904834265, 'b4yp5qi', -227162283, 'f9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', -1929953647);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 345.35543, 250.856497, 555413010, '5hncprjtu0d', 401805964, 'SLE', 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', 1784916884);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2024-06-15', 968.276986, 154.68882, -7597509, 'h5ogrgjd8yz', 1250290042, 'og', 'itsj3', 'y', 'p1q430', 'jh3den8', 195720193);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 897.348977, 764.833588, 1774087382, 'c', 1523825314, 'SLE', 'u5', '1of77p', 'o72ctdc', 'mfg62', -1744557630);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2024-06-15', 935.463334, 492.883123, 820970595, 'qdjpe1io2', 199672698, '7cvtjpt', 'tg6bnou5zi', '6c4bfkfo', 'c', '0', 76987628);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 441.061634, 64.04039, 641521863, 'o7w', -542502665, 'SLE', 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 1817366143);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2024-06-15', 876.038555, 628.658254, 1055237066, 'r94gth2m', 418247369, 'jla', 'okv8uttm', '2ne578', 'fvy', '7zzbe8y', -705922211);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 743.007715, 574.117269, -233617564, '7sx58b4pma', -929383517, 'SLE', 'u', 'mkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', -1793230843);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 296.34381, 397.200175, 2015094998, '2zobb0q0k32o', -1898678660, 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', -795975227);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 801.297876, 361.042997, 778835680, 'kb521gw', -1250380401, 's', 'elboeowii', 'z5nxih6', '2q2xlyoto', '9oaawg', 1044710644);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 725.010524, 19.988339, -850941333, 'indz39tajz', 261633665, 'SLE', '8', '5wcg', 'mbc3td', 'u6bd0w9603', -541917667);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 433.981179, 276.103112, 2012400150, '9yfk7qk162n', -516345261, 'o', 'vu', '6dza35r', 'mkio18ri2hy', '08ftp6ewtqxx', 1664452437);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 919.033168, 830.662489, -1485875026, 'bymzn2mfx7h3', -891525031, '1cj8', 'h5knz', 'ys7dyyd1jmg', 'jach8qta8y3', '1', 339193890);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 478.922811, 385.160931, -2081662466, '3qdpu', 1595033206, 'SLE', '96rn', 'dqrhm', 'wlic7dn2', 'p490', -592014051);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 906.254502, 840.039966, 1996699977, 'tgelc', -1025517017, 'i9f2ccukj', '1quik', 'yhb08hl', 't1pqo', 'iztv', -1304516770);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 137.186478, 906.372539, 195316816, 'qlud8', 948460309, '8', '9114q', 'r', '6b', 'jeuuwsj8kj', -55270062);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 243.463869, 827.119765, 1939337883, 'isurz', -388527046, 'SLE', 'q', 'ncgc8', '3b7v8', 'kwdmdbdht', 103252327);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 370.459832, 766.476432, -343920305, 'sjhanzxdpu', 2014610660, 'wfwx', 'rlawk', '14r5dqt', 'mg97a', 'z2o20', -1079009577);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 878.502931, 50.158445, -1385967617, 'u6iph', -1944869637, 'SLE', 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 'cvwnyq', -1005394301);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1970-01-01', 973.214347, 713.663081, -1582954378, 'rpo', -1599077491, '63xyfvmjwpp', '6mb3aj0j', '0h3r13', 'ir1axyyh', 'l2i9', -1837449583);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 13.527735, 249.295499, 1299933788, 'gckqwtsr54', -1042838119, 'SLE', 'kt', '1', '2', 'zg3r', 294604606);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 159.965354, 632.587127, 1014069980, '47j2j', -1881008758, 'y', 'vjwq49yr', 'nxs6dvdxdo2v', '7t3gvplj9f', 'vuu', -1415215611);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T1.ID = (SELECT ID FROM Examination WHERE "Examination Date" = '1997-01-27' AND Diagnosis = 'SLE') AND T2."Examination Date" = T1."First Date";

/*
Gold Result:
('t1__5bfc1d',)
('t1__5bfc1d',)
('t1__5bfc1d',)
('t1__5bfc1d',)
('t1__5bfc1d',)
('t1__5bfc1d',)
('t1__5bfc1d',)
('t1__5bfc1d',)
('t1__5bfc1d',)
('t1__5bfc1d',)
*/

-- Prediction Query
SELECT Patient.Diagnosis FROM Examination INNER JOIN Patient ON Examination.ID = Patient.ID WHERE Examination."Examination Date" = '1997-01-27' AND Patient.Diagnosis = 'SLE';

/*
Prediction Result:
*/