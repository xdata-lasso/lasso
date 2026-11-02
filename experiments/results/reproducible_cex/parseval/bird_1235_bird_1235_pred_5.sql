-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483648, '5k5swwqcgs', '2024-06-15', '2021-12-04', '2022-04-27', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 'hsrwbbp', '2024-06-15', '2025-08-22', '2022-01-31', 'hvdltt', 't1__639878');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483646, '8pz0f8je', '2024-06-15', '2021-02-03', '2020-07-19', '1vy9uxj4', 'wb');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'v', '2024-06-15', '2022-01-29', '2022-09-24', 'h2gndqwnqcx5', 't1__639878');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'hncprjtu0dz', '2025-11-06', '2021-01-15', '2021-09-23', 'q8', 'n2f3dqv0gcb9');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483643, '5q8qdj', '2024-06-15', '2022-08-18', '2020-10-02', 'io22785', '7cvtjpt');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483642, 'v42q7sx58b4p', '2024-06-15', '2022-03-27', '2020-01-10', 'us3auvmkrpdj', 'wzw5chn9mo70');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483641, 'j', '2024-06-15', '2024-06-01', '2023-05-30', '8', '5wcg');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483640, 'urz0kaqtncg', '2024-06-15', '2020-05-16', '2023-04-22', 'b7v88kwd', 'dbdh');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483639, 'txe', '2024-06-15', '2021-07-15', '2022-01-26', 'e019', 'y');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483638, 'kfb5if', '2024-06-15', '2025-05-24', '2024-11-21', '80terbfokvee', 'sltut6lu2');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-05-27', -1364429300, -1257178728, 1236688122, 2087640001, 666.330692, 46.9162, 776.327423, 907682809, 227.766936, 971.82669, -1576219117, -1823627488, -1209887326, -1399556171, 741.842896, 3.49, 587.783596, 558.971814, 1419861592, 663.001988, 374105386, 950.466571, 1274489983, -1683203397, 528680845, '76nium52', -443340271, 757448742, -1179823637, 'rqro', 'fqyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 'oo3o9hl72kl', 'x1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 556727997);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2022-06-25', 1606439408, 1443629118, -155284187, 1686459626, 138.057338, 728.712934, 279.382219, 638024588, 692.775559, 339.789525, 1784916884, 37673509, 834709651, -348113485, 532.326819, 3.49, 282.822068, 351.095514, 1255343543, 21.129657, -541746689, 584.342044, 1294666887, -515895469, 1427161052, 'z16ni', 2011234363, -1483100200, -7597509, 'h5ogrgjd8yz', '1afgo', 'ri', -902895762, -197933860, 'xp1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', -1744557630);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2023-05-24', 1467355421, -1171104889, -29242208, 1691780814, 464.719657, 952.850618, 900.959264, -2072838897, 166.297151, 91.430825, -1173368267, 382831862, -406331049, -461418236, 703.87087, 3.49, 774.592762, 390.871884, 1448731351, 523.290303, -604098478, 790.772456, -57705450, -915385605, -2005628382, '0oztd', -1699185893, 875300074, -1609653472, 'q5l', 'pim5', '58q', 1817366143, 1615073310, '7p2r94gth2m', 'ajjl', '3', 'okv8uttmu2', 'e578', 'fvy', '7zzbe8y', -705922211);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2025-06-15', 238533676, -1514700303, -1796351243, -1793230843, 296.34381, 397.200175, 969.175862, 1010672881, 399.489794, 221.079558, -2019656607, 375841374, -1449226553, -225238282, 57.929422, 3.49, 38.169466, 179.038075, 440115543, 622.950834, 292557306, 665.099697, -984562992, -605061107, -1689155697, 'dj9erhi', 1056589776, -499913447, -360096930, 't', 'fuqyxuzkb', '521gwnlas6e', 1468640756, 1048147204, 'eowi', '1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', 2085299664);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-07-14', -1275298282, 1933158443, 1295379066, 1071401016, 420.240058, 932.006038, 357.469826, 40558455, 460.649748, 672.384779, 2018368241, 920097188, -639616320, 1689143863, 372.360229, 3.49, 65.653061, 555.30941, -1046720861, 931.189708, 643589729, 213.271827, 956819642, 774922170, 2105860871, 'dohvu06d', -438741674, -154207334, 729449685, 'io1', 'ri2hy08ft', '6ewt', -1051623642, 2013745856, 'b', 'mzn2mfx', 'h33p6sto1', 'j', 'sh5knzys7', 'y', 'yd1jmgjach8', 973811121);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-06-07', 620355627, -531872415, -2125172723, 339193890, 478.922811, 385.160931, 851.403807, -2081662466, 262.000738, 465.762986, -1941472821, -2082238979, -845136979, -1042976410, 110.952654, 3.49, 487.287849, 592.427623, 555368535, 181.220234, 899787662, 638.478504, 833568923, -384749431, -934098178, 'gelcu', 422046500, -1750715330, 277649518, 'cukjq1quik1y', 'hb08hlst1pq', 'mizt', 1793241362, -1304516770, 'z78', 'q', 'lud8f', 'tb8r9114qbre', '6bjeuuwsj8k', 'h85', 'pxlvri', 986268139);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-05-27', 103252327, -556370776, 1144507576, -343920305, 607.211987, 147.214741, 5.946198, 1195320303, 840.734969, 48.58913, -1096060187, 2014610660, 1492264835, -642512512, 257.835629, 3.49, 174.163863, 15.293616, -1439417265, 712.42959, -300547632, 274.827655, -1011152325, 1298113538, -1340460158, '7aqz2o20p', 6224071, 1928920679, 1216978423, 'su6iphd', 'u2g', 'r31', -717865822, 2061102304, 'a2sb', 'uoi1pavc', 'wnyqro', 'uirlrpouit', '63xyfvmjwpp', '6mb3aj0j', '0h3r13', -156860347);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-01-10', -270436559, -569461411, 1498496406, 370054768, 444.670601, 130.977083, 72.185429, 1299933788, 603.11072, 658.158392, 1752727653, 1394285393, -1052659852, 1092207544, 917.502961, 3.49, 786.170921, 698.265949, 987928936, 219.655532, -1042838119, 910.671682, 889799750, -860028884, 328574939, '2', -460035045, 1794943626, 886926141, 'jkwns47j2j', '8', 'c', -1955129162, -1015337060, 'yrnxs6dvd', 'do2v7t', 'gvplj9fj', 'uun7k1', 'z2my1og', 'v1rgeza', 'xc1clupgly', 139907579);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2025-10-17', -1164657946, 693108667, -1882121644, 935816178, 53.073416, 339.25783, 118.01298, 253464886, 683.8774, 677.985968, -159572656, 1991810359, -1125491025, 764047845, 346.187215, 3.49, 418.699943, 98.200808, -1248881581, 767.869106, 1595944351, 563.529532, 1673977398, 1004962990, -1318740197, '1l2o3ak16', 1562909425, 950497469, -1722214030, 'ev', 'zxlu49', 'ubo', 833662145, -1943810603, 'uekhllbw', 'dpu5v0', 'du', 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 'et8xjhcf46c', 312333412);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-10-21', -977983676, 1082379969, -878613380, 1660953326, 339.679956, 467.965633, 59.584068, -1198828889, 326.742866, 980.464424, 1795932554, -831032281, 2006256976, 660144343, 823.817654, 3.49, 460.55501, 687.698388, -682353894, 601.929722, -1077762203, 421.798302, -1798310553, -1174073066, -1853296452, 'sf9', 1494789426, -1048234032, -388744933, 'ui', '7f8', 'qhi', 1094664154, -1728059226, '5', 'qjlsawsp4kw', '3hl', 'j43y795yb', '83kr3w', 'jn2z19xg', 'jac', -1725535379);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-05-10', 1224512097, 771073365, 1197643380, -1957884289, 190.485743, 205.180783, 790.556617, -1846239934, 129.503102, 962.255615, 1443327784, -2013600868, -415366855, 1778447090, 364.736768, 3.5, 715.183555, 453.015883, -494119248, 159.703774, -30240851, 293.437533, 1904358742, 369829594, 1115155768, 'hn1mdaqqhy', 2125055535, -422857559, 1529994466, '64hm', 'nw4m', 'rrwbjk0', -2076821826, 1851648795, 'w', '7', 'jjplwtlzh42n', 'j5yrji5', 'qkna', '38gfxswb2d0', 'mxwdb7o', 1424429365);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-09-16', 792905581, -1013704446, -317233455, 1548141293, 594.105631, 510.034447, 103.89345, -616308274, 823.81986, 737.236238, 542602362, -1984500518, 872275367, -1586134101, 779.187396, 973.823282, 904.284942, 271.658038, 1008864713, 897.975119, -1660176735, 244.661902, -1205570400, -976193147, -15423424, 'phy', -2074051940, 1487440939, 1295963771, 'vhvyx8s', 'r', 'fs3qn0b', -1500616, -1001218462, 'crwfx0', '3rzgz84lqm', '2w', 'b1b3vun66e0i', 'olt0', '0zi90o50q', '33g865zm6', 1636393410);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-09-02', 498429250, -1869902412, 508276629, 796830191, 473.030667, 968.222028, 982.911425, 1571723723, 340.530483, 125.081812, -1357636512, 1511374322, -937869073, -49162316, 131.948235, 230.173036, 588.523703, 376.879576, -215230989, 176.854966, -669329028, 666.582025, 244519896, 816580199, 1500266641, 'c1m9gr8xjq', 943944514, -1172741948, 1887949884, 'j5il9', 'nd6dvy', 'gwakmwgw73f', -487579632, -1884996250, 'i', 'txfb', 'l10qx6j6d4fc', '5m4s2ajdu', '6xuj90te', 'x3', '5u7709', 564132547);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis, T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.RBC < 3.5;

/*
Gold Result:
('t1__639878', 1, 1)
('n2f3dqv0gcb9', 2, 0)
('n2f3dqv0gcb9', 2, 0)
('n2f3dqv0gcb9', 2, 0)
('t1__639878', 1, 1)
('t1__639878', 1, 1)
('t1__639878', 1, 1)
('t1__639878', 1, 1)
('t1__639878', 1, 1)
('t1__639878', 1, 1)
*/

-- Prediction Query
SELECT T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) AS age, T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.RBC < 3.5;

/*
Prediction Result:
(1, 1, 't1__639878')
(2, 0, 'n2f3dqv0gcb9')
(2, 0, 'n2f3dqv0gcb9')
(2, 0, 'n2f3dqv0gcb9')
(1, 1, 't1__639878')
(1, 1, 't1__639878')
(1, 1, 't1__639878')
(1, 1, 't1__639878')
(1, 1, 't1__639878')
(1, 1, 't1__639878')
*/