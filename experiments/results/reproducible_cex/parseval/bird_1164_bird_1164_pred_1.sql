-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 'F', '2025-06-17', '2021-11-08', '2025-06-13', 'wwqcg', 'k9n8c');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'F', '2020-01-23', '2024-07-24', '2024-09-12', '0t5c4ecigc', 'e376nium52');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'zbuo4nrqrof', '2022-11-29', '2024-05-15', '2022-09-19', 's5bbp02e', 'tliqa1');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-01', 475.173408, 935.695299, 809183447, 'vfe4hria2', 1219478689, 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', 'ie5', 'nw6klf', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '1997-01-01', 982.938576, 274.580687, 274769912, 'oo3o9', -1666765085, '72klex14ji7z', 'au2dwy', 'q13py', '78d99r', 'jsl', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '1997-01-01', 419.361606, 470.165282, 1692174491, 'qi2rkf9v', 556727997, '8pz0f8je', 'd2', 'vy9uxj4', 'wb', 'v', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '1997-01-01', 185.427628, 243.480613, 1581736075, 'gndqwnqc', 555413010, '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '1997-01-01', 915.583344, 508.771546, 834709651, 'f8jswwl', 1255343543, '7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-01', 279.731401, 630.468925, -902895762, 'ayxp1q43', 1235416111, 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-01', 803.582738, 695.452114, -1284905200, '62', -1744557630, '5q8qdj', 'e1io', '278507cv', 'jpttg', 'bnou5zi36', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-01', 952.850618, 900.959264, -2072838897, 'foa', 382831862, '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-01', 458.880538, 264.110281, -15162884, 'pim5', -1125548818, '94gth', '2mnajjla3o', 'v8u', 'tmu2n', '57', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-01', 533.30598, 173.533224, 2123471885, 'yz7zzbe8yvk', 1043710187, '42q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', 'a9n0jxfofws', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-01', 900.422166, 55.294573, -210159774, 'obb0q0k32o', -1898678660, 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-01', 506.13059, 78.702002, -795975227, 'xuzkb52', -277407746, 'nlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-01', 555.75468, 743.240647, 966412849, '0', -850941333, 'indz39tajz', 'td8n5wcgu', 'bc3t', 'u', 'bd0w9603v', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-01', 843.866361, 969.937976, 920097188, '1rxe9y', -1046720861, '162nh55y3d', 'ohvu06dza3', 'rmkio18r', 'i2hy08ftp6', 'wt', 2);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-01', 255.149792, 361.5356, 2013745856, 'b', -1312038093, 'n2mfx7h33p', '6sto1cj8sh5k', 'zys7', 'y', 'yd1jmgjach8', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1900-03-03', 726.733068, 565.260711, 620355627, '8y3a17v4yg', -2081662466, '3qdpu', 'p', '6rntdqrhm', 'wlic7dn2', 'p490', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-01', 362.160981, 906.254502, 1996699977, 'tgelc', -1025517017, 'i9f2ccukj', '1quik', 'yhb08hl', 't1pqo', 'iztv', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.SEX = 'F' THEN 1 ELSE 0 END) AS REAL) / COUNT(*) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T2."Examination Date") = '1997' AND T2.Thrombosis = 1;

/*
Gold Result:
(0.7333333333333333,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT Examination.ID) FROM Examination JOIN Patient ON Examination.ID = Patient.ID WHERE Thrombosis = '1' AND SEX = 'F' AND STRFTIME('%Y', "Examination Date") = '1997';

/*
Prediction Result:
(1,)
*/