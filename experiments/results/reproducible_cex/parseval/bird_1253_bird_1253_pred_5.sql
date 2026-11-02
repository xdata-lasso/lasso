-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'pat_f15797');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, '9rljsl0b4', '2024-04-25', '2022-09-10', '2025-07-21', 'i2rkf', 'pat_f15797');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2438, 'rg', '2021-09-30', '2020-08-13', '2024-05-09', 't1afgog', 'pat_cafff1');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483645, '5am', '2023-03-30', '2022-07-13', '2023-01-14', 'wyn', 'pat_cafff1');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-1, 'gc1dj9erhi', '2024-07-12', '2021-03-12', '2021-11-11', 'yoeyo6l', 'hdt6fuq');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2437, 'u', '2022-12-05', '2020-04-21', '2021-07-17', 'f2ccukjq1', 'pat_cafff1');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483642, 'p', '2022-10-19', '2021-02-16', '2020-06-13', 'qwt', 'pat_cafff1');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (0, '9lqv26u331s', '2022-09-01', '2024-02-15', '2022-10-05', '30bgwk', 'pat_f15797');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 1160656988, -992890117, 1914020640, 1268590800, 378.476082, 783.93201, 718.397869, -1670923962, 663.049759, 711.020062, 1908028688, 2122220075, 1072996612, 13244799, 320.851235, 113.643485, 855.355181, 179.378884, -841692980, 182.319045, -1257178728, 787.938887, 2087640001, 907682809, 2026480202, 'ie5', -1209887326, 80, -1399556171, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 373262291, -472966518, 's5bbp02e', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2024-06-15', 222415430, 556727997, 1178000634, 1836127587, 410.133844, 88.474525, 704.657819, -1529584866, 755.698226, 778.537349, 910894705, -283454505, 233994589, 1442655647, 479.592965, 353.366837, 50.647649, 185.427628, 1581736075, 439.200238, -1264842910, 893.16532, -1052964641, -1245682094, -1660358170, 'p', -988981234, 80, -841004020, 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', -155284187, 1686459626, 'lyr', 'kn6vck6ah0f8', 'sww', 'q7x', '7', '2fxa7ryfdrz', '16nijjai5dh', 1583472758);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2438, '1969-12-31', -946046410, -902895762, -197933860, 2111987706, 360.694313, 959.196496, 917.425128, 804529642, 457.141778, 410.094566, -1538707438, -163600466, -1826414375, 357330522, 565.286158, 729.327198, 973.224853, 369.474112, -683007527, 757.137864, 2035306060, 735.057703, 1523825314, 2078438287, -47052816, '1of77pzo72c', -820614248, 80, 481546706, 'g6', 'g0v5q8qd', 'jpe1io22785', 2119806856, -1962347906, 'jpttg', 'bnou5zi36', '4', 'f', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', 1721638020);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2438, '1970-01-01', 983324983, 1269522000, 853709925, -870767087, 104.37745, 703.796681, 125.223349, -1405314653, 913.609637, 922.974233, -1212676731, 1692046802, -1300180872, -1125548818, 848.622384, 555.274052, 477.692813, 306.477948, -244633520, 925.474843, 418247369, 145.067008, -1351793914, 1919033056, -1428186898, 'uttmu2ne5', -1402164108, 81, 2123471885, 'yz7zzbe8yvk', 'v42q7sx58b4p', 'aus3', -2090240067, -699574669, 'rpd', 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', -613916489);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1970-01-01', 1294064538, 778835680, 1755752040, 1262491793, 20.547158, 959.258771, 645.685372, 450555855, 451.913941, 107.446882, -1250380401, 1718516876, -2076274980, 1731324803, 230.129952, 129.891173, 437.428969, 493.031806, -564679000, 118.293148, -251205568, 446.264042, 287256667, 1614799674, 1083479253, '9oaawg', 1044710644, 80, 966412849, '0', 'bindz', '9tajz9td', 152478847, -625404808, 'um', 'c', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 30861410);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1970-01-02', -438741674, -154207334, 729449685, -1580984044, 422.698571, 535.063373, 600.543738, 1510892261, 890.677915, 590.734291, -1853955201, -805997097, -586285368, 1664452437, 919.033168, 830.662489, 154.042758, 779.614625, -2080232972, 607.620308, 1528227252, 202.604041, -1659775598, -891525031, -1154091048, 'j', 1728926031, 81, -63214972, 'zys7', 'y', 'yd1jmgjach8', 973811121, 280292620, 'a8y3a17v4yg', 'mayq3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', -1872934808);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2437, '1970-01-01', 1584429327, -1575692857, 1570917601, 775289854, 22.149931, 538.678811, 933.576593, 1040753276, 982.976965, 424.56002, -1333785554, 1784997708, -696672546, 44959255, 482.609422, 398.641235, 873.064955, 637.227131, -2128972904, 857.91055, -1043357093, 324.663207, 190510318, -835782528, 192271618, '9114qbre6bj', -752650834, 80, 2134937984, '8kj', '85', 'pxlvri', 986268139, 2042428747, 'z0kaq', 'ncgc8', '3b7v8', 'kwdmdbdht', 'j47nxar50', 'sj', 'an', 1195320303);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2437, '1970-01-02', 1463445550, -1096060187, 2014610660, 1492264835, 350.403401, 257.835629, 174.163863, -2081798075, 164.859551, 712.42959, -300547632, -967107842, -1011152325, 1298113538, 187.899799, 977.087263, 912.323762, 654.911516, -2098439423, 392.952848, -1148194959, 414.584569, 944310519, 6224071, 1928920679, 'ysu', 1193656937, 81, 434520825, 'dk', 'u2gir31vwq5', 'oa2sb3u', 1388661799, -1574319760, 'avcv', 'wnyqrouirlrp', 'ouit63xyfvmj', 'wpp26mb3aj0j', '0h3r13', 'ir1axyyh', 'l2i9', -1837449583);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1969-12-31', 1339281953, -69263912, 17776256, -1464066437, 28.746006, 430.265947, 59.32099, -460035045, 961.420907, 659.320607, 1794943626, 886926141, 294604606, -1460437682, 632.587127, 607.70109, 736.106561, 824.6928, 1070869226, 519.969066, -1522433566, 146.640308, 173803229, -1971104604, -526608193, 'vjwq49yrnx', 1511946366, 80, -1910754958, 'o', 'v7t3gvpl', '9fj', -743497747, -1415215611, 'z2my1og', 'v1rgeza', 'xc1clupgly', '8oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', 1188203659);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-01', 1659285381, 1693638235, 1718551923, 404445908, 184.825054, 787.227287, 144.386877, -1919229426, 235.871701, 503.520337, 495658460, 1530380378, 1069076646, 1574139922, 9.487854, 996.049277, 936.327627, 423.819361, -229524038, 884.782066, -1954048590, 878.988408, -1862623291, -696200137, -410809407, 'u49', -1459357985, 80, -2051917235, '8c', 'e', 'uekhllbw', 1868665501, -1896445805, '5v0edu', 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 'et8xjhcf46c', 'pe', 'rxa61sjv8nv', 2081562124);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-02', -1879135081, -958249959, -1446721688, -1963148607, 73.896263, 748.058371, 115.350233, 1509710997, 38.620596, 202.564482, 652687353, 848275284, 736542812, -1977676789, 833.986859, 877.490499, 93.534614, 961.717317, -980269466, 779.908464, -1424758178, 826.828056, 1494789426, -1048234032, -388744933, 'ui', 184502432, 81, 1387373331, 'hiu5gm8gxb5', 'qjlsawsp4kw', '3hl', 979098248, -113489293, '795ybv8', 'kr3w4jn2', '19xgjja', 'cgmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 479662575);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1969-12-31', 1224512097, 771073365, 1197643380, -1957884289, 190.485743, 205.180783, 790.556617, -1846239934, 129.503102, 962.255615, 1443327784, -2013600868, -415366855, 1778447090, 364.736768, 715.183555, 453.015883, 372.317864, -494119248, 159.703774, -30240851, 293.437533, 1904358742, 369829594, 1115155768, 'hn1mdaqqhy', 2125055535, 80, -422857559, 'p64h', 'nnw4', 'm0rrwbjk0b', -1093026980, -1940885010, '7', 'jjplwtlzh42n', 'j5yrji5', 'qkna', '38gfxswb2d0', 'mxwdb7o', 'p5qo1', 749598659);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patientData.Diagnosis FROM Patient AS patientData INNER JOIN Laboratory AS labData ON patientData.ID = labData.ID WHERE labData.IGA BETWEEN 80 AND 500 ORDER BY labData.IGA DESC, patientData.id NULLS LAST, labData.id NULLS LAST, labData.date NULLS LAST LIMIT 1;

/*
Gold Result:
('hdt6fuq',)
*/

-- Prediction Query
SELECT P.Diagnosis FROM Patient AS P INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE L.IGA = (SELECT MAX(IGA) FROM Laboratory WHERE IGA BETWEEN 80 AND 500);

/*
Prediction Result:
('pat_cafff1',)
('hdt6fuq',)
('pat_cafff1',)
('pat_f15797',)
*/