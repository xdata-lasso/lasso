-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '1982-01-01', '2021-12-04', '2022-04-27', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, '1afgogritsj', '1982-01-01', '2025-02-02', '2020-03-04', 'xp1q430', 'jh3den8');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'c68x8vacx7', '2020-02-05', '2021-01-02', '2023-07-08', 'w1of77pz', '72ct');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-23', 1465859724, -1349201381, 1019800248, -1910425938, 303.05704, 1.0, 125.12763, 429706943, 240.969194, 267.815776, 462974032, -1137908826, -918961358, -1602639011, 489.397796, 933.422701, 345.718563, 510.466242, 1151980946, 83.204633, 1620389964, 627.258639, 947159877, 1990080517, 1408123494, '4', 374105386, 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, 'liqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2025-04-09', 1649269347, -1116181514, 1255852738, -1555456236, 272.94048, 3.5, 811.601922, -705985602, 604.643336, 829.94159, 537874887, -461695645, 836513442, 176555546, 75.31458, 913.624896, 97.626408, 48.958826, 1675430660, 339.69384, -792092619, 585.18838, -1492524358, -1612443122, -2050247126, 'lph2gn', 1968874827, -664193365, -1070063173, 'x5hncprjtu0', 'z', '9fjgq8n2f', -1056308489, -1454058168, 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', -458359144);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2020-07-27', 481546706, -1784554553, -242584410, -698610044, 935.437841, 1.0, 250.96443, -1021978385, 632.482455, 234.606624, -288338724, 1897687032, -241848752, 2004147439, 338.933701, 145.3181, 789.724834, 873.426435, 1582582341, 605.666938, 1467355421, 217.602841, -1171104889, -29242208, 1691780814, '6c4bfkfo', -1950324754, 2115816682, 76987628, 'zezjo7wg', 'd5ysxc', 'r0oz', -870767087, -1699185893, '5i3lq5lnpim5', '58q', 's27p2r94gth2', 'najj', 'a3o', 'v8u', 'tmu2n', -1817527403);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2025-11-10', -1402164108, 2123471885, -526633767, 448935289, 391.037879, 1.0, 920.405654, 458835042, 70.267562, 715.296942, -705922211, 1043710187, 318331233, -233617564, 574.707916, 518.470483, 904.091882, 927.310086, 756202403, 762.654945, 782684333, 476.006677, 681598285, 319284352, 1164790775, 'auvmkrpd', -609553675, 989018473, -55494714, 'n9', 'o705', 'a9n0jxfofws', 1719800120, -210159774, 'obb0q0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', -795975227);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2024-05-11', 778835680, 1755752040, 1262491793, 450555855, 451.913941, 1.0, 107.446882, -1250380401, 900.123388, 291.821648, -2076274980, 1731324803, -1159083009, -1589605308, 437.428969, 493.031806, 207.080257, 368.525424, -251205568, 446.264042, 287256667, 376.859029, 1614799674, 1083479253, 1774679448, 'oaawg96aq', -2061634386, -850941333, -1216952047, '39tajz9', 'd8n5w', 'g', -794767771, 989306270, 'tdu6bd0w96', '3vzxw1r', 'e9yfk7', 'k162n', '55', '3dohvu0', 'dza35rmki', -1160642134);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2025-12-31', 769234989, 168442149, 1299171592, 2066302536, 505.600334, 1.0, 349.371383, -1051623642, 361.5356, 210.679814, 2013745856, 917362079, -1312038093, 687330820, 815.035238, 447.755107, 78.373249, 522.859968, 1243701948, 463.637542, 1220047834, 717.320553, 63063873, -843082635, -285085577, '8sh', -63214972, 1106724223, 1966809332, '7dyyd', 'jmgjach', 'qta8y3a17', -735270562, 614314115, 'ma', 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', -1872934808);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-06-13', -1025517017, 1374676344, 238243966, -788896327, 141.072566, 1.0, 862.602858, -325680600, 763.851917, 314.524853, -1459013972, -1670335771, 1862728578, 1909521477, 245.30888, 989.406938, 961.035335, 784.591475, 2141720493, 636.138886, 1793241362, 17.438617, -1304516770, -1558272216, 195316816, 'qlud8', 948460309, 1183069552, -1057355067, 'e6bje', 'uuwsj8kjh8', 'wpxlvris', 2042428747, 1228655416, 'kaqtncg', 'c8s3b7v88k', 'dmdbdh', '6j47n', 'ar50hs', 'han', 'xdpunmw', -1782325492);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-03-09', -1040088060, -2081798075, -1439417265, -300547632, 274.827655, 1.0, 706.715402, -1011152325, 802.240612, 187.899799, -2098439423, -459764012, -1148194959, 944310519, 150.455914, 501.449153, 562.744101, 949.111842, 1216978423, 383.695713, -1087163929, 47.174746, 658507818, 334376591, 1154884242, 'r31', -717865822, 2061102304, -1204806277, 'sb3uoi1p', 'avcvwnyqroui', 'lrpou', 1368469085, 3208964, 'xyfvmjwpp26', 'b3aj', '0ju0h3r133ir', 'axyyhpl', 'i9esap8p', 'gckqwtsr54', '6qje', 889799750);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-05-12', -1892701926, -460035045, 1794943626, 886926141, 568.592974, 1.0, 159.965354, 1014069980, 824.6928, 293.222583, 1070869226, -1522433566, -1517668312, 173803229, 41.066446, 377.389472, 584.512314, 863.349328, 472597763, 630.926892, 826141460, 863.666767, -516707997, 1014871129, -583955995, '6dvdxdo2v7', 1805923837, -699779308, -1368221491, 'fjvuun7k1', 'z2my1og', 'v1rgeza', 423028705, -316078323, 'upg', 'ly78oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', '9lqv26u3', '1spxpw30', -2051120765);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-01-08', -1248881581, 1595944351, 1673977398, 1004962990, 192.956867, 1.0, 783.933532, -306339789, 785.330004, 449.508173, -177551902, 1128058273, 1562909425, 950497469, 14.163977, 99.015796, 816.974484, 63.114566, 1707457950, 364.303078, -572986964, 324.633755, 387548943, -1459357985, -2051917235, '8c', -1943810603, 1557266002, -775706063, 'khllbwvdpu', '5v0eduy9v2z', '29835xo', 765955451, 1372042958, 'b', 'f0c296xi', 'et8xjhc', '46', 'f', 'perxa61sjv', 'nv3ddroku', -1963148607);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-10-29', 2006256976, 660144343, -169414942, 806158445, 608.369624, 1.0, 341.127098, -1077762203, 421.798302, 369.534663, -1798310553, -1174073066, -1853296452, 2056318381, 286.991632, 83.400726, 552.485451, 907.295251, -213453775, 99.194768, -314024594, 316.922017, 184502432, 1387373331, 1599677804, 'u5g', -1728059226, 1652765764, 854201197, 'lsa', 'sp4kwi', 'hl7j43y7', 209963559, -480726958, '83kr3w', 'jn2z19xg', 'jac', 'gmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 479662575);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-09-16', -1637627413, 1995395561, -1550947002, 858757143, 488.923176, 1.0, 934.37472, -1246023488, 134.751491, 421.811676, -1800278299, 325130763, 1859885644, -22531339, 904.377043, 261.708225, 291.182955, 913.484241, 81406544, 797.293299, 1875923360, 433.204481, 2132634715, 309851181, -156220540, '5', 1772219707, -1642107656, 888725581, 'qhyyz', 'np64h', 'nnw4', 355299538, -343271949, 'wbjk0', 'p', '6g', 'w', '7', 'jjplwtlzh42n', 'j5yrji5', 2039586655);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-12-10', 1070662443, 683746439, -1725694639, 1037880389, 20.485725, 60.255356, 421.011518, 1388989730, 360.185574, 49.061305, -58324059, -1147699861, 749598659, 902707245, 207.246012, 915.7714, 830.949835, 809.486453, -1449454815, 619.852882, 1993999044, 571.139505, 825979697, -1565247126, -419727501, '90nhsp9gobb6', -976193147, -15423424, 1774110337, 'hybn', 'a', 'vhvyx8s', -1957842577, -366834342, '3qn0b', 'm2rlxcrw', 'x0', '3rzgz84lqm', '2w', 'b1b3vun66e0i', 'olt0', 80244587);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-07-07', 399119867, 207340898, -1205465222, -193700628, 100.260607, 720.695, 958.619742, 608918735, 403.166892, 773.037557, 1636393410, 1939546744, 1290157948, 2014227445, 641.070848, 236.186113, 409.370593, 792.264596, -243587307, 767.132946, 770112293, 439.205612, -555808510, -2091367850, 1367239582, '5ziqoauy023', -669329028, 244519896, 816580199, 'qc1m9gr8xj', 'qbloxd4sj5il', 'wnd6dvygw', -2083332040, -1732139002, '3fy3dkdip', 'txfbl10qx6j', 'd4fc75m4s', 'ajdu26xu', 'j90tefx3u5u', '709qf9lx8', 'qzabivuumwu', -2091687257);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-07-31', 1580782292, -624641029, 55189176, -1632840156, 887.41449, 6.5, 823.292568, -1203705305, 523.45511, 956.616504, 256025362, -1625632, -721010924, -1406020933, 555.229608, 732.145658, 928.179418, 900.346998, 286693031, 167.84281, -728757169, 683.94905, -1008994143, 680112185, 2129716173, 'rlpsaxeein', -2045667486, -1598084888, -46379547, 'sme', 'v3r3u', 'doxa0o', 858882953, 1930622140, 'mjrssbh72404', 'pp330', 'a1ngqut8', '184dwojdlhlz', 'dyxk', '0a0cql1c8c', 'wvadbp0760', 569834975);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN T2.ALB >= 3.5 AND T2.ALB <= 5.5 THEN 'normal' ELSE 'abnormal' END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T1.Birthday) = '1982';

/*
Gold Result:
('abnormal',)
('normal',)
('abnormal',)
('abnormal',)
('abnormal',)
('abnormal',)
('abnormal',)
('abnormal',)
('abnormal',)
('abnormal',)
('abnormal',)
('abnormal',)
*/

-- Prediction Query
SELECT P.ID, CASE WHEN L.ALB BETWEEN 3.5 AND 5.5 THEN 'Yes' ELSE 'No' END AS Albumin_within_normal_range FROM Patient AS P JOIN Laboratory AS L ON P.ID = L.ID WHERE STRFTIME('%Y', P.Birthday) = '1982';

/*
Prediction Result:
(1, 'No')
(1, 'Yes')
(1, 'No')
(1, 'No')
(1, 'No')
(1, 'No')
(1, 'No')
(1, 'No')
(1, 'No')
(1, 'No')
(1, 'No')
(1, 'No')
*/