-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'pat_d6919f');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, '9rljsl0b4', '2024-04-25', '2022-09-10', '2025-07-21', 'i2rkf', 'pat_d6919f');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2438, 'rg', '2021-09-30', '2020-08-13', '2024-05-09', 't1afgog', 'pat_ea7ad3');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2439, '5am', '2023-03-30', '2022-07-13', '2023-01-14', 'wyn', 'pat_ea7ad3');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2437, 'gc1dj9erhi', '2024-07-12', '2021-03-12', '2021-11-11', 'yoeyo6l', 'hdt6fuq');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483643, 'u', '2022-12-05', '2020-04-21', '2021-07-17', 'f2ccukjq1', 'pat_ea7ad3');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-1, 'uik1y', '2021-03-31', '2020-03-31', '2024-08-25', 'hlst1pqom', 'ztv');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483641, 'kxginl', '2021-08-14', '2025-09-23', '2021-07-24', 'dmp61l2o3ak1', 'pat_ea7ad3');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483640, '62ocagjeevx', '2024-07-14', '2024-02-10', '2021-12-31', '49kubo', 'pat_ea7ad3');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483639, '8c', '2020-07-13', '2020-09-22', '2025-05-14', 'ekhllb', 'pat_ea7ad3');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 1160656988, -992890117, 1914020640, 1268590800, 378.476082, 783.93201, 718.397869, -1670923962, 663.049759, 711.020062, 1908028688, 2122220075, 1072996612, 13244799, 320.851235, 113.643485, 855.355181, 179.378884, -841692980, 182.319045, -1257178728, 787.938887, 2087640001, 907682809, 2026480202, 'ie5', -1209887326, 80, -1399556171, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 373262291, -472966518, 's5bbp02e', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2024-06-15', 222415430, 556727997, 1178000634, 1836127587, 410.133844, 88.474525, 704.657819, -1529584866, 755.698226, 778.537349, 910894705, -283454505, 233994589, 1442655647, 479.592965, 353.366837, 50.647649, 185.427628, 1581736075, 439.200238, -1264842910, 893.16532, -1052964641, -1245682094, -1660358170, 'p', -988981234, 80, -841004020, 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', -155284187, 1686459626, 'lyr', 'kn6vck6ah0f8', 'sww', 'q7x', '7', '2fxa7ryfdrz', '16nijjai5dh', 1583472758);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2438, '2024-06-15', -946046410, -902895762, -197933860, 2111987706, 360.694313, 959.196496, 917.425128, 804529642, 457.141778, 410.094566, -1538707438, -163600466, -1826414375, 357330522, 565.286158, 729.327198, 973.224853, 369.474112, -683007527, 757.137864, 2035306060, 735.057703, 1523825314, 2078438287, -47052816, '1of77pzo72c', -820614248, 80, 481546706, 'g6', 'g0v5q8qd', 'jpe1io22785', 2119806856, -1962347906, 'jpttg', 'bnou5zi36', '4', 'f', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', 1721638020);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2438, '1970-01-01', 983324983, 1269522000, 853709925, -870767087, 104.37745, 703.796681, 125.223349, -1405314653, 913.609637, 922.974233, -1212676731, 1692046802, -1300180872, -1125548818, 848.622384, 555.274052, 477.692813, 306.477948, -244633520, 925.474843, 418247369, 145.067008, -1351793914, 1919033056, -1428186898, 'uttmu2ne5', -1402164108, 81, 2123471885, 'yz7zzbe8yvk', 'v42q7sx58b4p', 'aus3', -2090240067, -699574669, 'rpd', 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', -613916489);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2437, '2024-06-15', 1294064538, 778835680, 1755752040, 1262491793, 20.547158, 959.258771, 645.685372, 450555855, 451.913941, 107.446882, -1250380401, 1718516876, -2076274980, 1731324803, 230.129952, 129.891173, 437.428969, 493.031806, -564679000, 118.293148, -251205568, 446.264042, 287256667, 1614799674, 1083479253, '9oaawg', 1044710644, 80, 966412849, '0', 'bindz', '9tajz9td', 152478847, -625404808, 'um', 'c', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 30861410);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2437, '1970-01-01', -438741674, -154207334, 729449685, -1580984044, 422.698571, 535.063373, 600.543738, 1510892261, 890.677915, 590.734291, -1853955201, -805997097, -586285368, 1664452437, 919.033168, 830.662489, 154.042758, 779.614625, -2080232972, 607.620308, 1528227252, 202.604041, -1659775598, -891525031, -1154091048, 'j', 1728926031, 81, -63214972, 'zys7', 'y', 'yd1jmgjach8', 973811121, 280292620, 'a8y3a17v4yg', 'mayq3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', -1872934808);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '2024-06-15', -1304516770, -1558272216, 195316816, 1728201214, 180.890175, 57.158939, 908.604112, 948460309, 21.957253, 281.001583, 1183069552, -1057355067, -1004098188, 316163741, 71.721662, 312.71205, 324.759821, 997.078987, 1379644459, 531.665863, -1486030107, 537.801391, 1138926079, -609840352, 486475144, 'vrisurz0ka', 1384307628, 80, 1388796595, 'g', 'c8s3b7v88k', 'dmdbdh', 313797011, 1946419004, 'nxar50hsj', 'an', 'xdpunmw', 'wx', 'rlawk', '14r5dqt', 'mg97a', -1019350771);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1970-01-02', -225571092, -261782899, -1079009577, -1385967617, 784.000091, 922.346803, 667.60579, 1193656937, 737.929766, 601.169759, -1664440372, 1849928338, 1113005977, -176968915, 332.858841, 585.620811, 934.280409, 981.789907, 2061102304, 219.484173, 1813968674, 706.295383, 1907670428, 1265709623, 1731005516, 'i1pa', 1754053934, 81, 1206923461, 'wnyqro', 'uirlrpouit', '63xyfvmjwpp', 1913338832, -2061050846, 'j', '0ju0h3r133ir', 'axyyhpl', 'i9esap8p', 'gckqwtsr54', '6qje', 'ktb1d2nzg3rj', -1460437682);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2437, '1970-01-02', 1014069980, 1070869226, -1522433566, -1517668312, 745.88721, 540.466711, 41.066446, -526608193, 584.512314, 863.349328, 472597763, 826141460, 1561936884, -516707997, 736.293094, 606.851472, 364.037151, 765.686658, -1935855834, 568.642833, -563917514, 221.735391, 134065688, 1770139230, -1680744918, 'lj9f', -1519752081, 81, 906349223, 'n7k10z', '2my1ogyv1rg', 'za', 423028705, -316078323, 'upg', 'ly78oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', '9lqv26u3', '1spxpw30', -2051120765);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patientData.Diagnosis FROM Patient AS patientData INNER JOIN Laboratory AS labData ON patientData.ID = labData.ID WHERE labData.IGA BETWEEN 80 AND 500 ORDER BY labData.IGA DESC, patientData.id NULLS LAST, labData.id NULLS LAST, labData.date NULLS LAST LIMIT 1;

/*
Gold Result:
('ztv',)
*/

-- Prediction Query
SELECT "patient"."diagnosis" FROM "laboratory" INNER JOIN "patient" ON "laboratory"."id" = "patient"."id" WHERE "laboratory"."iga" = (SELECT MAX("iga") FROM "laboratory" WHERE "iga" BETWEEN 80 AND 500);

/*
Prediction Result:
('pat_ea7ad3',)
('hdt6fuq',)
('ztv',)
('hdt6fuq',)
*/