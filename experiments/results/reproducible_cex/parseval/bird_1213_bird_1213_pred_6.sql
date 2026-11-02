-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '1982-04-01', '2021-12-04', '2022-04-27', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'rhizgk1yoey', '1982-04-01', '2022-07-24', '2025-10-08', 'l0hdt6fuqyx', 'uzkb521gwnl');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'y0', '2020-12-26', '2023-06-25', '2022-09-10', 'ewtqxxnja', 'bymzn2mfx7h3');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-03-30', -1349201381, 1019800248, -1910425938, 1, 303.05704, 125.12763, 22.535764, 429706943, 240.969194, 267.815776, 462974032, -1137908826, -918961358, -1602639011, 489.397796, 933.422701, 345.718563, 510.466242, 1151980946, 83.204633, 1620389964, 627.258639, 947159877, 1990080517, 1408123494, '4', 374105386, 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, 'liqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2025-04-09', 1649269347, -1116181514, 1255852738, 1, 137.842122, 272.94048, 811.601922, -705985602, 604.643336, 829.94159, 537874887, -461695645, 836513442, 176555546, 75.31458, 913.624896, 97.626408, 48.958826, 1675430660, 339.69384, -792092619, 585.18838, -1492524358, -1612443122, -2050247126, 'lph2gn', 1968874827, -664193365, -1070063173, 'x5hncprjtu0', 'z', '9fjgq8n2f', -1056308489, -1454058168, 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', -458359144);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-02-11', -1794176801, -1194675273, -946046410, 1, 630.468925, 309.988616, 846.657221, -902895762, 453.914926, 991.735454, -598313376, 1972233925, 1792827279, 804529642, 457.141778, 410.094566, 426.421073, 617.644523, -1538707438, 774.445116, -163600466, 881.248682, -1826414375, 357330522, -683007527, 'x', -1762140823, 1371234901, -290314193, 'f77pzo72ctd', 't', 'mfg62g0v5q8q', -1488156735, -1858644047, 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', -405743609);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-07-20', -1699185893, 875300074, -1609653472, 299, 172.799686, 913.609637, 922.974233, -1212676731, 893.960343, 197.278049, -1125548818, 1497321728, -95808609, -244633520, 925.474843, 211.248782, 988.412528, 597.380802, -1524425594, 185.260952, 1919033056, 904.028668, -1428186898, -761353513, 362376128, 'mu2ne578lf', 2123471885, -526633767, 448935289, 'be8yvkv', '42q7sx58b4', 'pmaus3auvmkr', 609771851, -1934017803, 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', 211603887);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-04-10', 469838697, 1468640756, 1048147204, 1, 228.334858, 77.441426, 349.149444, -1610380698, 393.510383, 862.561101, 548968280, -1552469358, 7342822, -1034034171, 789.706494, 680.281941, 174.811686, 595.972666, 727608179, 886.204918, 456034296, 353.681528, 1044710644, 966412849, -2061634386, 'bindz', 2085299664, 2038321753, 1376887048, 'td8n5wcgu', 'bc3t', 'u', -1943814113, 1514371324, '603vzxw1r', 'e9yfk7', 'k162n', '55', '3dohvu0', 'dza35rmki', '18ri', 1510892261);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2025-02-01', 1220047834, 63063873, -843082635, 1, 433.623337, 149.178936, 539.789098, -1643065004, 165.118823, 739.2477, -515419519, -1884062674, -531932574, 357443379, 194.959809, 99.467804, 150.150672, 32.2942, 1122899168, 462.488905, -735270562, 643.031153, 306260487, 1168225104, -499203870, 'qdpuap96', 1291298007, 1982265552, 2013152515, 'q', 'hm5wl', 'c7d', 594760660, 833568923, '90xdmsqt', 'el', 'u', 'qb9i9f2ccu', 'jq1', 'uik1y', 'hb08hlst1pq', 1980131681);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-07-25', 1784997708, -696672546, 44959255, 1, 482.609422, 398.641235, 873.064955, -2128972904, 857.91055, 257.074492, -753065777, 190510318, -835782528, 192271618, 990.66185, 556.586972, 427.303571, 876.781557, 1639204149, 19.495363, 36589303, 760.996078, -1537647691, 364280973, 1592061050, 'sj8kjh', 1138926079, -609840352, 486475144, 'vrisurz0ka', 'qtncgc8s3b7', 'v88kwdmdbd', -1629148699, 103252327, 'ar50hs', 'han', 'xdpunmw', 'wx', 'rlawk', '14r5dqt', 'mg97a', -1019350771);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2025-01-06', -1148194959, 944310519, 6224071, 1, 562.744101, 949.111842, 783.349866, -1087163929, 47.174746, 653.320799, 334376591, 1154884242, 1352531282, -269868995, 354.170103, 665.003292, 779.203825, 635.24832, 1188674483, 981.395878, -299585625, 0.318929, -2014514218, -1184608964, 1994296595, 'avcvwnyqroui', -980625770, 721232773, 323781506, 'ouit63xyfvmj', 'wpp26mb3aj0j', '0h3r13', -156860347, 1805058154, 'axyyhpl', 'i9esap8p', 'gckqwtsr54', '6qje', 'ktb1d2nzg3rj', 'wns', '47j2ja8dccy3', 1560573473);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2021-08-16', 826141460, 1561936884, -516707997, 1, 736.293094, 606.851472, 364.037151, -1935855834, 568.642833, 368.702718, -1195137401, 134065688, 1770139230, -1680744918, 235.288115, 149.715435, 83.301061, 333.3832, -743497747, 904.4568, -1415215611, 411.706646, -251621840, -1720233199, -672126855, 'gezax', -316078323, -754769711, 1128553504, 'xeilp', 'e019cy7od0', '3dlhdsvn', -1640621748, 253464886, 'qv26u331spx', 'pw30bgwkxgi', 'nlj6idmp61', '2o3', 'k', '62ocagj', 'ev', -582813835);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2024-02-10', -1381068866, 207561330, -781096377, 1, 221.727759, 539.135238, 998.228481, -2007399097, 64.74848, 478.523041, 426006253, 1097428449, -712974538, 1201135348, 672.853096, 493.307381, 341.359358, 70.074089, 2117356203, 561.452917, 824044840, 450.037356, -54963162, 1084895939, 765955451, 'db2f0c', -537413388, 2011754567, 1755688363, '8xjhc', '46', 'f', 1280646590, -568125159, '1sjv8nv3d', 'r', 'kuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', '9q', -213453775);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-08-04', -314024594, -786313930, 184502432, 1, 823.023023, 928.280038, 872.454011, 2095228319, 777.202886, 565.446218, -1727712360, 173313547, -2038301430, -1037450107, 182.264528, 295.429659, 805.256456, 351.628347, -924570154, 476.853022, -635922435, 465.004005, -1480511510, -189319798, -51114840, 'v', -197208169, 2089151689, -561387633, 'jac', 'gmukfb5if4', '80terbf', 1176294340, -1429883874, 'e6', 'ltut6', 'lu2cel8mhfc', 'mn5', 'ni', '0fm', 'bgz5oqxs27', -494119248);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-10-16', 2132634715, 309851181, -156220540, 1, 17.0816, 804.161471, 912.62705, -1642107656, 432.439087, 188.660611, 888725581, 1896957144, 470513738, 2125055535, 401.545802, 856.229597, 237.09261, 475.496144, -1324600306, 208.856257, -1301565530, 273.359912, 668449456, 1353959969, -1449073012, 'p', 1851648795, 1130223592, -616998913, 'jjplwtlzh', '42nyj5yrji5m', 'kna38', -1725694639, 1037880389, '2', '0', 'mxwdb7o', 'p5qo1', '4c6', 'gwnkd4kc3ii', 'axz', 1008864713);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-06-02', -1660176735, -1205570400, -976193147, 1, 496.408957, 913.067252, 244.070345, -478462425, 215.23512, 5.096725, -2125510968, 2017526622, -693920036, 195093192, 44.154251, 414.589719, 287.505213, 710.920615, 1378228777, 203.913632, 355859046, 835.467188, -1500616, -1001218462, -1965995887, 'fx03rz', 1269188010, 1901522221, -1292966884, 'wb1b3vun', '6e0imolt0', '0zi90o50q', 162901577, -159167628, '865zm6dpewew', '092p40u2vi', 'l21xsad6q5z', 'qoa', 'uy023lwh99', 'fqc1m9gr', 'xjqbloxd4', -928434146);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2021-06-24', 343349384, 1293700593, 1501525023, 1, 162.174222, 829.725586, 715.048434, 1956394338, 587.301754, 348.323416, -151666814, -487579632, -1884996250, -1930352392, 240.446424, 784.438724, 983.668401, 373.337612, 832710468, 737.104626, -296531894, 256.996575, -1906909599, 1950702818, 877176214, '5m4s2ajdu', -567584339, -395383776, -1876636977, '3u5u77', '9qf9lx8', 'qzabivuumwu', -2091687257, 618880480, 'k6hh2o', '79', '50fzrv1l', '930', 'vkviql', 'n0rlpsaxe', 'in', -2045667486);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-06-07', 1938400567, -1191120749, 2110758629, 1, 189.307337, 862.598179, 677.992054, -1038583670, 903.632476, 454.423228, -794493872, -1202488383, 1264155936, -390950704, 583.746142, 626.448429, 699.97427, 426.876274, 1930622140, 734.343754, -983850650, 289.537914, 1250861085, -373858639, 1550708132, '303a1ngq', -745290521, 898805626, -77974859, 'ojdlhl', 'pdyxk0a', 'cql1c8c', -656017519, -2126129717, 'p', '760ugk2', 'jz', 'pg1lcg', 'a4gkjog8d', 'w16f5tqhjd', 'mabmkr2t', -1903548007);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-05-04', 63486487, 1411268911, -221912911, 1, 912.664032, 74.825807, 642.64851, -641282671, 44.472463, 442.844754, 258755990, -617631089, -1625641923, 758391026, 658.745155, 792.049687, 42.809974, 400.092976, 1690729846, 843.865938, 933590348, 900.195606, -1857994268, -1501533097, -106120329, 't99kvnbh', -681931530, 13488751, -1082755849, 'fndtw', '9qy6sru4e', 'fiof8o', 1796323549, -1022360195, 'rad', 'fhj8zr6k53', '8e5o', 'f0y', '1u', 'r8kzi0g50j5', '7fznqcuex', -130254436);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-02-20', -2006745200, -1815891316, -758991421, 1, 173.967595, 788.510625, 62.349178, 1337608681, 665.243078, 45.340187, -1664812348, -1156619022, -1963206903, 1757094915, 92.079866, 616.580406, 854.907363, 381.400463, 1346552102, 241.483027, 972288112, 231.156488, 1349808277, -194344351, 2087215165, 'pq97j534j5x', -2078230104, 1461270922, -924036125, 'c7xrv4p', 'pjjv', 'c2', -656237101, -1721897132, '6s', 'l45j', '5pbgwo', 'nhh', '6va3tdx5hn7', 'b733o58z', 'g', -561761019);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-08-02', 1737246157, -1184151348, 1942685474, 1, 473.652569, 390.356892, 705.498967, -1623767807, 34.522842, 80.491891, 1196652889, 205472765, -93920702, -1597057552, 951.779985, 963.5751, 976.165291, 858.643745, 196097271, 287.570218, 240654832, 828.162635, 1090670329, 1783185410, -211490974, 'ae6aj6ql167', 1083169975, 1093235102, 304203858, 'kjyfxso', 'e98b85', '0235v8ikp3qu', -1947520594, 970728092, 'wgr124vu6v8', 'kl', 'y93zu8y', 'b4qpog5smdhc', 'tnj8y6whwhl', '5i', 'dtdjm8r', 209226821);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2021-05-05', 1019149716, -1524863063, -209713762, 1, 437.076898, 398.58776, 614.733434, -1027442241, 492.143324, 649.85543, -665597852, -1102015194, 790826026, -1740675234, 300.517396, 121.633605, 432.054593, 172.037384, 1991996064, 287.210169, 1928368836, 219.34841, -1889113209, 822981708, 798014875, 'ufc', -737687664, -1708077219, 1608670538, 'bugxis', 'q2i', 'dq44u', 663227128, -1775767623, 'bwx3q5b', '37qob', 'vbj26kpxc567', 'vp0h', '2flntlcorqt', '1uo', 'dbvf3ya6l4', -286729739);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-12-20', -1841006453, 33100532, 56216130, 1, 131.84916, 84.3553, 822.562383, 1792401890, 343.597819, 363.780367, -96878107, 1620531975, -1048787950, -190180302, 69.868803, 473.642488, 48.386877, 239.25513, -109711729, 644.221131, 2033372614, 322.219154, 270795691, -264694280, 196492760, 'pxb6', 2144707422, -1434769338, -15764418, 'ce2y485y', '1gz7p', 'hvg0wytz', -1604313896, -1889176700, 'qs', 'zc192282', 'rnfvkrmfoqpz', 'cnn53i', '8owqwx0hv', 'v0oh59ivnipn', 'drokt16hq', 1284378621);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-02-14', 1295864154, -907384163, -1906595591, 2001378511, 711.431069, 951.903284, 413.983924, 1039998344, 128.924111, 621.583768, 2133566015, 47676950, -158083859, 186866531, 577.133888, 253.028726, 717.248288, 714.572251, -1836655128, 470.25628, -434565991, 979.991015, -1076579598, 1891418337, 666381636, 'w90', -1400434743, 1754716492, -1089704776, 'w1gno6r9d3zd', 'y', '5uhorv', 768162102, -582426548, 'd', 'ko47', 'q', '0691b7s1i', 'k8thqz3', 's94x3', 'yxg3ufg', 873990042);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-01-27', 914580189, 290300955, -1677989669, 1, 653.873815, 922.537036, 265.157782, 2026425184, 465.085565, 781.421387, 250255154, 1169111674, 74286708, 1260385497, 888.790521, 460.791005, 677.185802, 477.510063, -65141139, 514.030347, 550551687, 49.246598, -1638030257, -1253560766, 1061006043, '122bvxjn', -748409233, 561559089, -1291688734, '1nfs4niom2u', '85br2971kp', 'nnb', 1922143801, -40599967, 'nagrj6o3', '7kajtw7', 'qiuj9', '94', 'ycwnr8dq', '5gbzjmeuvjv', 'cr9l03f515y', 184090233);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-02-12', 1244725562, -1487494813, -844088252, 300, 92.15847, 429.510599, 565.310586, 1646925800, 885.420339, 763.851372, 1481930618, 1312219383, -1358863224, -720395989, 469.506005, 850.961033, 357.367188, 102.933169, -198326755, 660.277155, -435550780, 948.616856, 1922961793, -1175155753, 735250406, 'ze42lwenn4', -1395464118, 1147288001, 1325800971, 'gvoc9l5zm', 'sv641', '6b', 1820491976, 908208204, 't8', 'gqofzr1', 'v7z6i', 'r1w', 'x1', 'l', 'bbk27zz', -795681473);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID, CASE WHEN T2.ALP < 300 THEN 'normal' ELSE 'abNormal' END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Birthday = '1982-04-01';

/*
Gold Result:
(1, 'normal')
(1, 'abNormal')
(1, 'normal')
(1, 'normal')
(1, 'normal')
(1, 'normal')
(1, 'normal')
(1, 'normal')
(1, 'normal')
(1, 'abNormal')
(1, 'normal')
(1, 'normal')
(1, 'normal')
(1, 'normal')
(1, 'normal')
(1, 'normal')
(1, 'normal')
(2, 'normal')
*/

-- Prediction Query
SELECT T1.ID, CASE WHEN T2.ALP < 300 THEN 'Yes' ELSE 'No' END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Birthday = '1982-04-01';

/*
Prediction Result:
(1, 'Yes')
(1, 'No')
(1, 'Yes')
(1, 'Yes')
(1, 'Yes')
(1, 'Yes')
(1, 'Yes')
(1, 'Yes')
(1, 'Yes')
(1, 'No')
(1, 'Yes')
(1, 'Yes')
(1, 'Yes')
(1, 'Yes')
(1, 'Yes')
(1, 'Yes')
(1, 'Yes')
(2, 'Yes')
*/