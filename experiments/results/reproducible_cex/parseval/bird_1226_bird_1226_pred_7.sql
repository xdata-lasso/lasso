-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2437, 'yp5qi2rk', '1970-01-01', '2021-01-15', '2023-10-06', 'x58pz', 'f8jegd2');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (0, 'vy9uxj4', '2021-05-25', '2023-12-18', '2020-04-02', 'v', 'ph2');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2438, '5lnpi', '1970-01-01', '2022-03-19', '2025-06-18', '58q', 's27p2r94gth2');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-1, 'p490xdmsqt', '1970-01-01', '2021-03-16', '2020-09-18', 'cuq', '9');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 700293388, 906324270, 1908028688, 2122220075, 749.826493, 503.083789, 320.851235, -1659388584, 855.355181, 179.378884, 1, -841692980, -1364429300, -1257178728, 787.938887, 986.066566, 666.330692, 46.9162, 907682809, 227.766936, 2026480202, 133.007885, -1823627488, -1209887326, -1399556171, 'a9000t5c4eci', 1149850321, -1833165707, 1155439218, 'um5', 'zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1969-12-31', 1298861365, 1968874827, -664193365, -1070063173, 629.317167, 668.309685, 635.267184, -1245312912, 866.804244, 269.734861, 1, -841004020, -361507387, 401805964, 154.065416, 261.415754, 915.268032, 207.767266, -1762857309, 687.701166, 513454646, 339.762162, 331812443, 1382410067, 1631231566, '8ozk3zbil', 982314585, 638024588, -688098735, '6ah', 'f8jswwl', '7xb72', 1350414441, 2094425101, '7', 'yfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', -598313376);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-01', 1972233925, 1792827279, 804529642, -1538707438, 774.445116, 461.908795, 881.248682, -1826414375, 544.095565, 583.19749, 0, -683007527, 2035306060, 1523825314, 983.924121, 313.653498, 489.044661, 650.242697, 765724008, 528.552305, -1099855564, 224.624401, 87529806, -1957268147, -1928431425, 'mfg62', -1744557630, 1870300798, 820970595, 'qdjpe1io2', '78507cvt', 'ptt', 1467355421, -1171104889, '5zi36c4bfkfo', 'c', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', -176606723);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2438, '1969-12-31', 1162591638, -2136247961, -1478011227, -2096405521, 588.850908, 230.994112, 919.979201, 872694102, 311.951038, 298.104305, 0, 618058035, 1553368934, -1252009958, 497.427028, 522.61046, 944.379011, 86.586744, 697257217, 392.947196, -451030047, 636.053055, -2052653308, -489120589, -72442907, '7sx58', 782684333, 681598285, 319284352, '3auvm', 'rpd', 'wzw', -55494714, -1674145149, 'mo705a9n0', 'xfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', 211603887);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2438, '1970-01-01', -413043724, 761519897, 1504707292, 955267863, 230.654784, 845.392744, 619.529525, 718167481, 832.527521, 124.067083, -1, 1435223075, 1617348603, -477129795, 789.60677, 323.811635, 397.09556, 821.237495, -1418927432, 904.57762, -30041412, 435.41097, -670154354, -2140468103, 469838697, 'lboeowii1z5', 1557188093, 548968280, -1552469358, '62q2xlyot', 'ow9oaawg96a', 'qb0tbindz39t', 2038321753, 1376887048, 'td8n5wcgu', 'bc3t', 'u', 'bd0w9603v', 'xw1rxe9', 'fk7qk16', '2nh55y3doh', 1709667347);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2438, '1970-01-02', -1934709172, -2121397544, 1595632888, 2072023304, 683.879518, 229.766946, 816.359248, 769234989, 949.964729, 539.218493, 0, 1299171592, 2066302536, 24053253, 349.371383, 255.149792, 361.5356, 210.679814, 2013745856, 2.747847, 917362079, 376.823393, -1312038093, 687330820, -224390110, 'x7', -1659775598, -891525031, -1154091048, 'j', 'sh5knzys7', 'y', -531932574, 357443379, 'gjac', '8q', 'ta8y3a17v4', 'ygmayq3qdpu', 'p', '6rntdqrhm', 'wlic7dn2', 1409697108);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1970-01-01', -1750715330, 277649518, 908468929, 1149620614, 170.693019, 253.547988, 743.598829, 1584429327, 133.130417, 436.22226, 0, 1570917601, 775289854, -2052350430, 538.678811, 933.576593, 770.955182, 286.029577, 1040753276, 982.976965, -324012243, 597.166359, -1333785554, 1784997708, -696672546, 'm4iz78aqq', -1370566258, 948460309, 1183069552, '4qbre6b', 'jeuuwsj8kj', '85', -609840352, 486475144, 'vrisurz0ka', 'qtncgc8s3b7', 'v88kwdmdbd', 't6', 'j47nxar50h', 'sjhanzxdpu', 'mwfw', -544173163);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1970-01-02', -958321297, 2015039199, -641927001, 558684943, 471.914793, 490.559457, 633.284644, 1348973408, 309.882408, 287.669302, -1, 1084127083, -1019350771, -225571092, 439.048919, 974.446302, 248.773501, 878.502931, -1385967617, 784.000091, 1813965704, 667.60579, 1193656937, 434520825, -1664440372, 'u2g', 1352531282, -269868995, 580887132, '1oa2sb3u', 'i1pa', 'cvwnyq', -1005394301, 917675957, 'rlr', 'pouit63xyf', 'mjwpp2', 'mb3aj0ju0', '3r', '133ir1axyy', 'hpl2i9esap', -1452518801);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1969-12-31', -662859586, 1339281953, -69263912, 17776256, 152.841575, 70.62455, 159.120465, -1892701926, 211.896872, 392.889739, 0, 1794943626, 886926141, 294604606, 159.965354, 632.587127, 607.70109, 736.106561, 1070869226, 519.969066, -1522433566, 146.640308, 173803229, -1971104604, -526608193, 'vjwq49yrnx', 1511946366, -1910754958, -1900450199, 'v7t3gvpl', '9fj', 'uun7k1', -251621840, -1720233199, '1rgeza', 'xc1clupgly', '8oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', '9lqv26u3', -169055351);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2023-01-03', 1, 1, 1, 1, 1.0, 1.0, 1.0, 1, 1.0, 1.0, NULL, 1, 1, 1, 1.0, 1.0, 1.0, 1.0, 1, 1.0, 1, 1.0, 1, 1, 1, 'value', 1, 1, 1, 'value', 'value', 'value', 1, 1, 'value', 'value', 'value', 'value', 'value', 'value', 'value', 1);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2023-11-30', 1908028688, 2122220075, 1072996612, 13244799, 320.851235, 113.643485, 855.355181, -1377057208, 304.02808, 182.319045, -1257178728, 1236688122, 2087640001, 907682809, 227.766936, 971.82669, 133.007885, 75.403642, -1209887326, 992.733505, -1399556171, 741.842896, 1419861592, 700088193, 374105386, 'cigce376nium', 283598170, 742285925, -747753377, 'nrqrofqy', '5s5b', 'p', 882961052, 743312762, 'eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID, T2."T-CHO" FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID ORDER BY T2."T-CHO" DESC, T1.Birthday ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
(0, 1)
*/

-- Prediction Query
SELECT P.ID, L."T-CHO" FROM Patient AS P INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE P.Birthday = (SELECT MIN(Birthday) FROM Patient) AND L."T-CHO" = (SELECT MAX(L2."T-CHO") FROM Laboratory AS L2 INNER JOIN Patient AS P2 ON L2.ID = P2.ID WHERE P2.Birthday = (SELECT MIN(Birthday) FROM Patient));

/*
Prediction Result:
(2438, 0)
(2438, 0)
(-1, 0)
(-1, 0)
*/