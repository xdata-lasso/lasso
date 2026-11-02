-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 't2__639a05');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'klfa9000t', '2025-07-01', '2020-06-05', '2025-04-12', 'ecigce376n', 't2__639a05');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483647, 'um5', '2025-01-28', '2024-06-13', '2020-03-30', 'uo4nrqrofqy', 't2__639a05');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, '3pyu78d99r', '2022-01-18', '2021-08-18', '2023-03-31', '0b4', 'p5qi2rk');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 'rjtu', '2024-08-30', '2020-08-25', '2024-06-09', '9fjgq8n2f', 'dqv0gcb9');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 't2__48ff03');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (6, 'hria2ypuzhs', '2023-01-03', '2023-11-30', '2020-05-06', 'p', 't2__48ff03');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 779.409124, 640.719621, 1160656988, 'ia2yp', -1670923962, 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'ie5', -1209887326);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '1985-01-01', 242.260296, 938.694822, 902551284, 'p', 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', -1021749117);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '1985-01-01', 811.601922, 92.834164, -705985602, 'x58pz0f8je', 1196308825, 'd21vy9uxj4hw', 'd', 'lph2gn', 'q', 'nqcx5h', -1245312912);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (5, '1985-01-01', 540.154414, 874.028321, 1443629118, 'zbilyrkn', -688098735, '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', -1496556994);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (5, '1985-01-01', 7.367195, 906.609226, 1360271423, 'ogrgjd8y', 1129658414, '1afgo', 'ri', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', -1762140823);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (5, '1985-01-01', 819.265503, 354.593207, -290314193, 'f77pzo72ctd', 481546706, 'g6', 'g0v5q8qd', 'jpe1io22785', '7cvtjpt', 'tg6bnou5zi', 1944978593);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (5, '1985-01-01', 900.959264, 17.379583, -1173368267, 'cd07z2zezjo7', 304189298, 'xd', 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 1817366143);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (5, '1985-01-01', 876.038555, 628.658254, 1055237066, 'r94gth2m', 418247369, 'jla', 'okv8uttm', '2ne578', 'fvy', '7zzbe8y', -705922211);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 743.007715, 574.117269, -233617564, '7sx58b4pma', -929383517, 'u', 'mkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 1719800120);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 55.294573, 221.713281, -210159774, 'obb0q0k32o', -1898678660, 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', -795975227);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 801.297876, 361.042997, 778835680, 'kb521gw', -1250380401, 's', 'elboeowii', 'z5nxih6', '2q2xlyoto', '9oaawg', 1044710644);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 725.010524, 19.988339, -850941333, 'indz39tajz', 261633665, '8', '5wcg', 'mbc3td', 'u6bd0w9603', 'vzxw1rxe9y', -1046720861);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 931.189708, 579.749775, 643589729, 'h55y', -141591627, 'ohvu06dza3', 'rmkio18r', 'i2hy08ftp6', 'wt', 'xxnja', -2080232972);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 607.620308, 399.670941, 1528227252, 'fx7h', -156175571, '6sto', 'cj8sh5k', 'zys7', 'y', 'yd1jmgjach8', 973811121);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 565.260711, 644.437797, -531872415, '1', 339193890, 'ygmayq3q', 'dpuap96rnt', 'q', 'hm5wl', 'c7d', 594760660);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 439.465402, 210.16546, 833568923, '90xdmsqt', -1685482179, 'cuq', '9', 'i9f2ccukjq1q', 'ik1yhb', '8hlst1p', -1333785554);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 915.602165, 591.192357, -696672546, 'm4iz78aqq', -1370566258, '8', 'tb', 'r9114qbre', '6bjeuuwsj8k', 'h85', -609840352);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1985-01-01', 368.667363, 613.26632, -679850352, 'sur', -459075802, 'aqt', 'ncgc8s3b7v', '88kwdmdbdht6', 'j47nxar50h', 'sjhanzxdpu', 2014610660);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (6, '1985-01-01', 503.083789, 320.851235, -1659388584, 'l', -845863578, 'lbn', 'rmdp', 'siie', 'unw6klfa', '9000t5c4ec', -1683203397);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '1985-01-01', 623.093099, 467.07027, -1585009206, '52zb', 757448742, '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', -1666765085);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Diagnosis FROM Examination AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T1."Examination Date" BETWEEN '1985-01-01' AND '1995-12-31' GROUP BY T2.Diagnosis ORDER BY COUNT(T2.Diagnosis) DESC, T2.Diagnosis NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__639a05',)
*/

-- Prediction Query
SELECT "examination"."diagnosis" FROM "examination" INNER JOIN "laboratory" ON "examination"."id" = "laboratory"."id" WHERE "laboratory"."date" BETWEEN '1985-01-01' AND '1995-12-31' GROUP BY "examination"."diagnosis" ORDER BY COUNT("examination"."diagnosis") DESC, "examination"."diagnosis" NULLS LAST LIMIT 1;

/*
Prediction Result:
*/