-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2024-06-15', '8c4pgu7vfe', 't1__8b2cac');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'hria2ypu', '2024-06-23', '2021-03-30', '2024-06-15', 'rwbbp', 't1__8b2cac');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 'luhvdltti', '2022-01-16', '2020-04-02', '2022-04-29', 'rmdp', 'siie');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, 'cagjeevxzxlu', '2025-04-23', '2021-10-18', '2024-06-15', 'boe8cd', '4u');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 'kh', '2021-12-28', '2022-01-11', '2024-06-15', 'w', 'dpu5v0');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 489.397796, 933.422701, 44952191, 'fa9', 1620389964, 'SLE', '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 825.231787, 75.551482, -868774469, 'qa1', 2074205376, 'SLE', 'yytoo', 'o9hl72kl', 'x1', 'ji7zwau2', 364869063);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2024-06-15', 278.010437, 433.533777, -1097120355, '78d99r', -1362461264, 'l0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', -1612443122);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2024-06-15', 22.63964, 328.40866, 2103044118, 'h2gndqwnqcx5', 580968159, 'cprj', 'u0dz7', 'fjgq8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', -688098735);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 915.583344, 508.771546, 834709651, 'f8jswwl', 1255343543, 'SLE', '7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 1129658414);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2024-06-15', 308.482994, 430.111467, 1250290042, 'og', -946046410, 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 1303877941);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 695.452114, 200.834692, 7929158, '0v', 820970595, 'SLE', 'qdjpe1io2', '78507cvt', 'ptt', '6b', -1171104889);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2024-06-15', 813.864654, 493.191521, 1691780814, '6c4bfkfo', -1950324754, '7z2zezj', '7wgx', '5', 'sxcmr0o', 'ztdgj5i3lq5l', 1339733032);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 236.262879, 137.487391, -55240145, '8qs27p2r', -95808609, 'SLE', 'h2mna', 'jla', 'okv8uttm', '2ne578', 1908593332);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2024-06-15', 86.586744, 781.110793, 697257217, '7zzbe8y', -705922211, 'v42q7sx58b4p', 'aus3', 'u', 'mkrpdj', 'wzw5chn9mo70', 628082526);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 648.64235, 209.98973, 1731843275, 'fofwsz', -210159774, 'SLE', 'obb0q0k32o', 'w', 'l', '5amsorlwyngc', -323362455);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 605.551549, 821.485286, 211603887, 'rhizgk1yoey', 513375398, 'l0hdt6fuq', 'xuzkb52', 'gwnlas6', 'elboeowii1', '5nxih66', -251205568);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 446.264042, 369.064418, 287256667, 'otow9oa', 456034296, 'g96aqb', 'tbindz3', 'tajz9td8n', '5wcgumbc3td', 'u6bd0w9603', -541917667);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 433.981179, 276.103112, 2012400150, '9yfk7qk162n', -516345261, 'SLE', 'o', 'vu', '6dza35r', 'mkio18ri2hy', -1853955201);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 312.339174, 363.494801, 1664452437, 'jabymzn2mfx7', -1659775598, 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', 'qta8y3a17v4y', 306260487);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 771.998599, 383.770043, 1509621238, 'dpuap', -845136979, 'rhm5w', 'ic7', 'dn2np490xdm', 'sqtgelcuqb', 'i9f2ccukj', 1046248997);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 256.829372, 868.903699, -1575692857, 'yhb08hl', 1040753276, 'SLE', 'pqomizt', 'vb6m4iz78aq', 'lud8f', 'tb8r9114qbre', 316163741);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 71.721662, 312.71205, -752650834, 'j8kjh', 1138926079, 'pxlvri', 'surz0kaqtncg', 'c8s3b7v88k', 'dmdbdh', '6j47n', -556370776);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 766.476432, 491.36959, -343920305, 'sjhanzxdpu', 2014610660, 'wfwx', 'rlawk', '14r5dqt', 'mg97a', 'z2o20', -1079009577);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 878.502931, 50.158445, -1385967617, 'u6iph', -1944869637, 'SLE', 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 'cvwnyq', -1005394301);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 973.214347, 713.663081, -1582954378, 'rpo', -1599077491, '63xyfvmjwpp', '6mb3aj0j', '0h3r13', 'ir1axyyh', 'l2i9', -1837449583);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 13.527735, 249.295499, 1299933788, 'gckqwtsr54', -1042838119, 'SLE', 'kt', '1', '2', 'zg3r', 294604606);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1970-01-01', 159.965354, 632.587127, 1014069980, '47j2j', -1881008758, 'y', 'vjwq49yr', 'nxs6dvdxdo2v', '7t3gvplj9f', 'vuu', -1415215611);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 411.706646, 404.377376, -251621840, 'y1ogyv1rgeza', 423028705, 'SLE', '1', 'l', 'upgly78oit', 'xeilpe019cy', 72217086);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 57.900963, 408.522915, 1529023742, 'dlhdsvnhed29', -1066046077, '26u331spxpw3', 'bgwkxgi', 'nlj6idmp61', '2o3', 'k', -229524038);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (5, '1997-01-27', 70.074089, 326.821585, 2117356203, 'v2z129835', -1147311649, 'SLE', 'acxd', 'b2f0c296xiye', '8xjhc', '46', -2003500453);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (4, '1997-01-27', 990.684439, 240.031233, 1280646590, 'a61sjv', -1265768652, 'SLE', 'ddrokuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', 1403715810);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (4, '2024-06-15', 920.463395, 949.884831, 1494789426, 'g01hu', -1585280787, '7f8kqhiu5g', '8gxb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', -197208169);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (5, '2024-06-15', 271.953128, 465.965157, 2089151689, 'z19xgjja', 2062713020, 'gmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 858757143);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T1.ID = (SELECT ID FROM Examination WHERE "Examination Date" = '1997-01-27' AND Diagnosis = 'SLE') AND T2."Examination Date" = T1."First Date";

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.Diagnosis FROM Examination AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T1.Diagnosis = 'SLE' AND T1."Examination Date" = '1997-01-27';

/*
Prediction Result:
('siie',)
('siie',)
('siie',)
('siie',)
('siie',)
('siie',)
('siie',)
('siie',)
('siie',)
('siie',)
('siie',)
('dpu5v0',)
('4u',)
*/