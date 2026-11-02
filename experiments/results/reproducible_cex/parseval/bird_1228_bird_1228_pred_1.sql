-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 't1__d1eddc');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, '3pyu78d99r', '2022-01-18', '2021-08-18', '2023-03-31', '0b4', 't1__d1eddc');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'p5qi2rk', '2021-01-15', '2023-10-06', '2022-12-15', 'x58pz0f8je', 'd2');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-05-05', -992890117, 1914020640, 1268590800, 1219478689, 718.397869, 324.940703, 399.341724, -1670923962, 663.049759, 711.020062, 1908028688, 301, 2122220075, 1072996612, 503.083789, 320.851235, 113.643485, 855.355181, -1377057208, 304.02808, -1364429300, 998.421621, -1257178728, 1236688122, 2087640001, 'dposiie5unw', -1399556171, 1038707349, 1419861592, '4ecigce376n', 'um5', 'zbuo4nrq', 418417917, -1031969798, '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', -1021749117);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2024-11-12', -688509700, -792092619, -1492524358, -1612443122, 22.63964, 328.40866, 989.653112, -1642259219, 109.083092, 802.414724, 1968874827, 301, -664193365, -1070063173, 629.317167, 668.309685, 635.267184, 210.05299, 1575412235, 269.734861, -841004020, 415.830002, 401805964, -1485777725, -1255130038, '3d', 513454646, -688216274, 331812443, 'cb98ozk3zbil', 'yrkn6vck6ah0', '8j', -932772113, -639539893, '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', -946046410);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2023-06-23', 678047687, -1478134144, -491938169, -106471771, 787.642728, 947.945777, 571.595144, 518609210, 123.184903, 953.64343, 1476361420, 301, 195720193, 1774087382, 13.875982, 860.831521, 39.297094, 903.322759, -1762140823, 819.265503, -290314193, 850.85096, 76996700, -435350511, 1992637800, 'dctmf', 7929158, -1744557630, 1870300798, 'q8qdjpe1', 'o22', '8507cvtjp', 1582582341, 453836040, '6b', 'ou5z', '36c', 'bfkfoacd', '7z2zezj', '7wgx', '5', -526612570);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2024-03-06', -2005628382, 1721638020, 983324983, 1269522000, 698.769833, 297.258735, 104.37745, 875300074, 125.223349, 172.799686, 1816660482, 301, -1212676731, 1692046802, 197.278049, 167.377262, 492.8451, 251.966916, -1125548818, 848.622384, -95808609, 306.477948, -244633520, 418247369, -1524425594, 'a3o', -1428186898, -761353513, 362376128, 'mu2ne578lf', 'yz7zzb', '8y', -705922211, 1043710187, '42q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', 'a9n0jxfofws', 'do2zobb', 'q0k32od', -613916489);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-01-03', 895277769, 364043263, -1177989415, -1352968577, 379.040817, 622.764817, 954.833605, -1960313034, 48.973066, 146.101675, 681061317, 301, 1935791961, 595714424, 746.006477, 106.602942, 166.233687, 428.592322, -499913447, 72.709865, -360096930, 47.707612, -795975227, 1294064538, 778835680, 'kb521gw', -1250380401, 1718516876, -2076274980, 'ow', 'i1z', 'nxih662q', 287256667, 1614799674, 'ow9oaawg96a', 'qb0tbindz39t', 'j', '9td8n5w', 'g', 'mbc3td', 'u6bd0w9603', -541917667);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-11-12', 1689143863, 237552112, -1046720861, 643589729, 213.271827, 722.776931, 680.425625, 2105860871, 467.033126, 602.631056, -732999244, 301, 1654100852, 30861410, 397.847489, 464.095805, 576.663277, 273.587055, 729449685, 942.225143, -1580984044, 422.698571, 150596046, 431832073, 1510892261, 'y0', 168442149, 1299171592, 2066302536, 'ewtqxxnja', 'bymzn2mfx7h3', 'p6sto1cj', 1728926031, -63214972, 'zys7', 'y', 'yd1jmgjach8', 'qta8y3a17v4y', 'ma', 'q3qdpua', '96rn', 2013152515);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-07-30', -1042976410, -1670945624, 555368535, -1369148652, 45.731407, 641.038677, 709.498138, 594760660, 439.465402, 210.16546, 833568923, 301, -384749431, -934098178, 307.243311, 63.923383, 40.211911, 598.265359, -1750715330, 564.645313, 908468929, 767.666908, -1414362698, 1046248997, 1584429327, 'k1y', 775289854, -2052350430, 166124233, 'st1', 'qomi', 'tvb6m4i', -2128972904, -1043357093, 'd8ftb8', '9114q', 'r', '6b', 'jeuuwsj8kj', '85', 'pxlvri', 986268139);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-08-05', 1228655416, -388527046, -1040951738, -1218774640, 662.418642, 599.871479, 843.228203, 1446366856, 467.19504, 28.233006, 438933248, 301, 180947503, -622923312, 916.71268, 880.348467, 889.074497, 51.885919, 313797011, 953.185987, -1215810104, 9.534625, -982188592, 1981548099, -913430713, 'an', 1195320303, 1463445550, -1096060187, 'mwfw', 'qrlawk', '14r5dqt', 1298113538, -1340460158, '7aqz2o20p', '6dd', 'ysu', 'iphdku2gi', '31vwq', '1oa2sb3u', 'i1pa', 1754053934);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-06-16', 1645850786, -471852873, -1005394301, 917675957, 846.162355, 131.43971, 173.977939, -1143329124, 818.621532, 305.710224, 3208964, 301, -471198540, 1394459557, 189.105795, 720.842041, 356.869416, 242.373447, -1305057240, 461.142569, -2131087784, 723.679635, 1663074182, -352678633, 1498627641, '133ir', -270436559, -569461411, 1498496406, 'l2i9', 'sa', '8pgc', 1394285393, -1052659852, 'sr54o', 'qjektb1d2', 'zg3r', 'jkwns47j2j', '8', 'c', 'y', -1015337060);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-04-04', 1497187692, 1511946366, -1910754958, -1900450199, 445.910628, 848.951769, 573.237647, 1805923837, 337.06993, 181.436108, 231250827, 301, -1519752081, 906349223, 320.846982, 779.56053, 525.356167, 428.509194, 720126052, 646.587479, 973615628, 878.282284, 1883146395, 2050088460, 699455208, 'v1rgeza', 423028705, -316078323, -754769711, 'ly', '8oitxeilp', 'e019cy7od0', -1882121644, 935816178, 's', 'nhed29', 'qv2', 'u331spxpw', '0bgwkxgi', 'nlj6idmp61', '2o3', -2106733603);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-10-01', 1562909425, 950497469, -1722214030, 1361395061, 63.114566, 614.405118, 897.548529, -582813835, 366.591075, 324.633755, 387548943, 300, -1459357985, -2051917235, 66.494394, 782.029487, 694.102094, 47.421322, 1557266002, 319.391855, -1417040770, 699.840562, 625191846, -2065694089, 1868665501, 'p', 1104707112, 1551904707, -400879450, 'u', 'y9v2z12983', '5xoepacxdb2f', -344881050, -537413388, 'et8xjhc', '46', 'f', 'perxa61sjv', 'nv3ddroku', 'zc', 'ehia3', 652687353);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-03-21', -1077762203, -1798310553, -1174073066, -1853296452, 978.77393, 286.991632, 83.400726, 1749319777, 541.094406, 450.301418, -1721445347, -314024594, -786313930, 184502432, 823.023023, 928.280038, 872.454011, 130.669436, 2095228319, 777.202886, -1727712360, 540.352703, -2038301430, -1037450107, 1311066510, 'sp4kwi', -150306637, -1480511510, -189319798, '795ybv83kr3', 'w4jn2z19xgj', 'jacgmukfb5', -1603206153, -81382082, '80terbfokvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 1772219707);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-03-28', 369829594, 1115155768, 428576631, -1253720301, 764.222623, 574.678854, 714.004082, -1016026459, 804.099076, 838.769485, -514593578, -1224799639, 28414592, -1669961050, 215.764397, 345.351353, 586.359273, 563.73055, 355299538, 420.075769, -619134105, 785.465366, -1524222898, -356851435, -1093026980, 'gdwb7jjpl', -604038417, -1369846060, 1693885387, '42nyj5yrji5m', 'kna38', 'fx', 1544468471, -626315618, 'd0zmxwdb', 'otp5qo1k4', 'c6gwnkd4kc', 'iikaxzr9', '0nhsp9gobb6n', 'n5ujp', 'yb', -2125510968);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID, T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.TG > 300;

/*
Gold Result:
(1, 't1__d1eddc')
(2, 'd2')
(2, 'd2')
(2, 'd2')
(1, 't1__d1eddc')
(1, 't1__d1eddc')
(1, 't1__d1eddc')
(1, 't1__d1eddc')
(1, 't1__d1eddc')
(1, 't1__d1eddc')
*/

-- Prediction Query
SELECT DISTINCT T1.ID, T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.TG > 300;

/*
Prediction Result:
(1, 't1__d1eddc')
(2, 'd2')
*/