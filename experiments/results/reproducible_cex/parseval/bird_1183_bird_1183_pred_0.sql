-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2024-06-15', '8c4pgu7vfe', 't1__eee4d3');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'hria2ypu', '2024-06-23', '2021-03-30', '2024-06-15', 'rwbbp', 't1__eee4d3');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'ph2', '2021-03-22', '2022-04-21', '2024-06-15', 'q', 't1__eee4d3');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 503.083789, 320.851235, -1659388584, 'l', -845863578, 'SLE', 'lbn', 'rmdp', 'siie', 'unw6klfa', 1419861592);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 663.001988, 587.103196, 1274489983, 'gce', -1585009206, 'SLE', '52zb', 'uo4nrqrofqy', '5s5b', 'p', 882961052);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 673.065986, 825.231787, -1822992503, 'liqa1', 2074205376, 'yytoo', 'o9hl72kl', 'x1', 'ji7zwau2', 'dwyrq13pyu78', 244829661);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 182.777264, 943.791649, -904834265, 'b4yp5qi', -227162283, 'f9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', -1929953647);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 345.35543, 250.856497, 555413010, '5hncprjtu0d', 401805964, 'SLE', 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', 1784916884);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2024-06-15', 508.771546, 591.134092, 834709651, 'f8jswwl', 1255343543, '7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', -946046410);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 630.468925, 309.988616, -902895762, 'ayxp1q43', 1235416111, 'SLE', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 76996700);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2024-06-15', 398.637058, 689.065203, 1992637800, 'dctmf', 7929158, '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', -68044929);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 86.288364, 779.693388, 1923659053, 'c', -406331049, 'SLE', 'ezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', -176606723);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2024-06-15', 264.110281, 691.015295, -15162884, 'pim5', -1125548818, '94gth', '2mnajjla3o', 'v8u', 'tmu2n', '57', -1402164108);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 988.50905, 994.409325, -526633767, 'zzbe8yvkv', 318331233, 'SLE', 'q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', 238533676);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 419.43898, 147.331352, -1796351243, 'ws', 1719800120, 'o', '2zobb0q0k32o', 'w', 'l', '5amsorlwyngc', -323362455);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 605.551549, 821.485286, 211603887, 'rhizgk1yoey', 513375398, 'l0hdt6fuq', 'xuzkb52', 'gwnlas6', 'elboeowii1', '5nxih66', -251205568);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 446.264042, 369.064418, 287256667, 'otow9oa', 456034296, 'SLE', 'g96aqb', 'tbindz3', 'tajz9td8n', '5wcgumbc3td', 1964331395);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 506.209886, 17.397119, -1943814113, '9603vz', 920097188, '1rxe9y', 'k7', 'k162n', '55', '3dohvu0', 30861410);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 397.847489, 464.095805, 729449685, 'io1', 769234989, '8ftp6ewtqx', 'njabym', 'n2mfx7h', '3p6sto1c', '8sh', -63214972);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 207.572242, 757.679309, 1966809332, '7dyyd', 357443379, 'SLE', 'gjac', '8q', 'ta8y3a17v4', 'ygmayq3qdpu', 1595033206);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 237.529885, 910.552252, 1291298007, 'tdqr', -1670945624, 'wlic7dn2', 'p490', 'dmsqtg', 'lc', 'qb9i9f', -788896327);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 141.072566, 862.602858, -325680600, 'ik1yhb', 1862728578, 't1pqomiztvb6', '4iz7', 'aqqlud8ft', '8', '9114q', -2063751689);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 70.018028, 508.519106, -1537647691, 'uuwsj8kjh8', -55270062, 'SLE', 'xlvr', 'sur', '0kaqtnc', 'gc8s3b7v88k', -622923312);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 916.71268, 880.348467, 1671062261, 'h', 313797011, '7nxar50h', 'sjhanzxdpu', 'mwfw', 'qrlawk', '14r5dqt', 1298113538);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 187.899799, 977.087263, -2098439423, '2o20pj6', -1385967617, 'SLE', 'u6iph', 'k', 'u2gir31vwq5', 'oa2sb3u', 1388661799);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1970-01-01', 133.450116, 762.890435, 473443538, 'cvwnyq', -1005394301, 'uirlrpouit', '63xyfvmjwpp', '6mb3aj0j', '0h3r13', 'ir1axyyh', 370054768);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1997-01-27', 444.670601, 130.977083, -1837449583, 'p', -1452518801, 'SLE', 'tsr54o', 'qjektb1d2', 'zg3r', 'jkwns47j2j', -1881008758);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 44.786016, 465.464708, -1015337060, 'yrnxs6dvd', -563917514, '2v7t', 'gvplj9fj', 'uun7k1', 'z2my1og', 'v1rgeza', 423028705);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T1.ID = (SELECT ID FROM Examination WHERE "Examination Date" = '1997-01-27' AND Diagnosis = 'SLE') AND T2."Examination Date" = T1."First Date";

/*
Gold Result:
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
*/

-- Prediction Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2."Examination Date" = '1997-01-27' AND T2.Diagnosis = 'SLE' AND T1."First Date" = (SELECT MIN("First Date") FROM Patient WHERE ID = T1.ID);

/*
Prediction Result:
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
('t1__eee4d3',)
*/