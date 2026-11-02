-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 't1__5668f1');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483647, 'au2dwyrq13', '2022-09-28', '2024-03-19', '2023-09-01', '8d99rljsl', 't1__5668f1');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'ezjo7wg', '2024-03-10', '2020-07-27', '2025-06-15', 'sxcmr0o', 't1__5668f1');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'ztdgj5i3lq5l', '2022-06-10', '2022-08-25', '2021-07-17', '5k58', 's27p2');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-05-05', -992890117, 1914020640, 1268590800, 1219478689, 718.397869, 324.940703, 399.341724, -1670923962, 663.049759, 711.020062, 1908028688, 2122220075, 1072996612, 13244799, 320.851235, 113.643485, 855.355181, 179.378884, -841692980, 182.319045, -1257178728, 787.938887, 2087640001, 907682809, 2026480202, '530', -1576219117, -1823627488, -1209887326, 'klfa9000t', 'c4ecigce', '76nium52', -443340271, 757448742, '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -453362185);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-09-13', -2031361952, 1649269347, -1116181514, 1255852738, 137.842122, 272.94048, 811.601922, -705985602, 604.643336, 829.94159, 537874887, -461695645, 836513442, 176555546, 75.31458, 913.624896, 97.626408, 48.958826, 1675430660, 339.69384, -792092619, 585.18838, -1492524358, -1612443122, -2050247126, '530', -736979194, 2103044118, -1642259219, 'nd', 'wnqcx', '5hncprjtu0d', 401805964, -1485777725, '8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 2011234363);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-09-25', -2115841792, 1746373317, 1360271423, 1583472758, 837.437794, 272.414976, 155.818582, 1074760385, 763.019095, 308.482994, 1250290042, -1717646459, -1696173285, 710458518, 743.920586, 657.87028, 155.845079, 15.432127, -491938169, 239.245131, -106471771, 787.642728, 1923912467, 518609210, 1948383687, '530', 1476361420, 195720193, 1774087382, 'c', 'x7afu5w1of77', 'zo72', -1957268147, -1928431425, 'mfg62', '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', -406331049);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2023-01-31', -95808609, -244633520, 418247369, -1524425594, 185.260952, 462.366429, 946.809703, -1428186898, 543.846419, 685.003964, -761353513, 362376128, -1311735207, -229022515, 76.823924, 572.833475, 533.30598, 173.533224, 2123471885, 870.801677, -526633767, 823.908713, 448935289, 458835042, 924693315, '530', -705922211, 1043710187, 318331233, 'q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 101754718, 628082526, '9n0jxfofwsz', 'o', '2zobb0q0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 1056589776);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2021-03-12', 761519897, 1504707292, 955267863, -1156828895, 845.392744, 619.529525, 514.470353, 718167481, 832.527521, 124.067083, 1435223075, 1617348603, -477129795, -1418927432, 904.57762, 769.556907, 593.9327, 493.005436, -277407746, 343.967529, -2140468103, 509.069144, 469838697, 1468640756, 1048147204, '530', -1814875250, -647898186, -1610380698, '5nxih66', 'q2xlyoto', '9oaawg', 1044710644, 966412849, '0', 'bindz', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', -516345261);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2020-07-18', 440797047, -732999244, 1654100852, 30861410, 397.847489, 464.095805, 576.663277, 729449685, 942.225143, 164.253367, -1580984044, 150596046, 431832073, 1510892261, 890.677915, 590.734291, 745.189516, 852.871276, -1853955201, 312.339174, -586285368, 887.535529, -1485875026, -2080232972, 462225708, '530', 1528227252, -1277305894, -1659775598, 'p6sto1cj', 'sh5knzys7', 'y', -531932574, 357443379, 'gjac', '8q', 'ta8y3a17v4', 'ygmayq3qdpu', 'p', '6rntdqrhm', 'wlic7dn2', 1409697108);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-09-21', -384749431, -934098178, -827883679, -1872934808, 40.211911, 598.265359, 27.252619, -1750715330, 564.645313, 711.519405, 1149620614, -1414362698, 1046248997, 1584429327, 133.130417, 436.22226, 675.004906, 865.757759, 775289854, 22.149931, 166124233, 933.576593, 1040753276, -324012243, -1333785554, '530', 1784997708, -696672546, 44959255, 'iz78aqql', 'd8ftb8', '9114q', -2063751689, 36589303, 'jeuuwsj8kj', '85', 'pxlvri', 'surz0kaqtncg', 'c8s3b7v88k', 'dmdbdh', '6j47n', -556370776);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-01-16', -343920305, 460471995, -1515201134, -2121944911, 778.307195, 840.734969, 48.58913, -1096060187, 969.063097, 197.254857, 1492264835, -642512512, -1040088060, -2081798075, 164.859551, 712.42959, 697.7379, 430.023301, -967107842, 706.715402, -1011152325, 802.240612, -1340460158, -2098439423, -459764012, '530', -1148194959, 944310519, 6224071, 'dlysu6iphd', 'u2g', 'r31', -717865822, 2061102304, 'a2sb', 'uoi1pavc', 'wnyqro', 'uirlrpouit', '63xyfvmjwpp', '6mb3aj0j', '0h3r13', -156860347);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-01-10', -270436559, -569461411, 1498496406, 370054768, 444.670601, 130.977083, 72.185429, 1299933788, 603.11072, 658.158392, 1752727653, 1394285393, -1052659852, 1092207544, 917.502961, 786.170921, 698.265949, 659.070788, 987928936, 219.655532, -1042838119, 910.671682, 889799750, -860028884, 328574939, '530', 1464469520, -209435372, 946571403, '3r', 'jkwns47j2j', '8', -1881008758, -1955129162, 'vjwq49yr', 'nxs6dvdxdo2v', '7t3gvplj9f', 'vuu', '7k10', 'z2my1ogyv1r', 'ez', -560601844);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-10-12', -1970162044, 324939521, -1131290294, 892508923, 652.131381, 526.310762, 946.625268, 139907579, 831.213212, 133.24157, 914471233, -1813651479, -1353862813, -1839279753, 659.940979, 427.779746, 44.023651, 516.814345, -392891099, 856.003578, 1735624376, 177.152013, -1665891229, -929713613, -1239290359, '530', -1832294694, 1188203659, -1066046077, '26u331spxpw3', 'bgwkxgi', 'nlj6idmp61', 1530380378, 1069076646, 'ak162oca', 'je', 'vx', 'xlu49ku', 'o', '8c', 'e', 1557266002);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-08-01', 426006253, 1097428449, -712974538, 1201135348, 672.853096, 493.307381, 341.359358, -1846517698, 326.821585, 992.985408, 824044840, -214587907, -54963162, 1084895939, 74.371479, 246.634839, 8.795476, 678.337895, 1372042958, 62.264038, 1147974039, 448.700958, -344881050, -537413388, 2011754567, '530', 1755688363, 1177967285, -2001463367, '6cfperxa', '1sjv8nv3d', 'r', -1198828889, -744133723, 'ctehia3', 'm', 'vb7vpc0xff', 'or1esk', 'f9q82', 'g01hu', 'j7f', -1663813652);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-07-16', 1190577316, -1727712360, 173313547, -2038301430, 987.183792, 787.437236, 258.449824, 1311066510, 351.628347, 284.731733, -99415515, -635922435, -150306637, -1480511510, 455.92055, 754.156177, 525.703896, 488.0989, -2018922963, 880.544711, -197208169, 271.953128, 2089151689, -561387633, -1496507520, '530', 2062713020, -1725535379, 1709325128, 'if4180te', 'bfokv', 'e6', -879976368, -806686292, '6lu2c', 'l8', 'mhfcimn5eni', '0fm', 'bgz5oqxs27', 'h888y1', '253', -887179029);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2025-07-18', 1772219707, -1642107656, 888725581, 1896957144, 259.392409, 119.359365, 609.550017, 2125055535, 401.545802, 856.229597, -105243240, -1324600306, -1250452845, -1301565530, 273.359912, 680.293351, 655.635516, 16.251399, 1353959969, 162.611398, -2076821826, 117.191065, 1851648795, 1130223592, -616998913, '-21', 1022316699, -1519375860, -1398612932, 'lzh42', 'nyj5yrji5m', 'kna38', -1725694639, 1037880389, '2', '0', 'mxwdb7o', 'p5qo1', '4c6', 'gwnkd4kc3ii', 'axz', 1008864713);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-06-02', -1660176735, -1205570400, -976193147, -15423424, 913.067252, 244.070345, 388.599284, -2125510968, 336.870847, 969.742016, -693920036, 195093192, -1957842577, -366834342, 287.505213, 710.920615, 820.893893, 203.913632, 355859046, 835.467188, -1500616, 443.377693, -1001218462, -1965995887, -1756413046, '3rzgz84', 624911807, -1030722219, -1833815393, 'wb1b3vun66e0', 'mol', '070zi', 207340898, -1205465222, 'q833g86', '5zm6dpewew0', '2p40u2vil', '1xsad6q5', 'iqoauy0', '3lwh994f', 'qc1m9gr8xj', 1072042049);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-07-18', -551513589, -81327703, -1531362377, -1580370971, 987.328198, 811.615432, 612.52666, 945802166, 511.043385, 883.392802, -698277997, 748510826, 990008540, -2083332040, 621.995157, 983.551649, 193.467587, 355.590027, -1732139002, 524.244856, -1764222999, 466.386021, -1436037867, -1567310198, 1484560348, 'bl', -296531894, -1043691767, -1906909599, 'fc75m4s2ajdu', '6xuj90te', 'x3', -768531730, 99716186, 'qf9lx8qza', 'i', 'uumwu7', 'l', '0jw', '6hh', 'oe79350f', 1125313981);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2."U-PRO" >= 30;

/*
Gold Result:
('t1__5668f1',)
('t1__5668f1',)
('t1__5668f1',)
('s27p2',)
('s27p2',)
('s27p2',)
('t1__5668f1',)
('t1__5668f1',)
('t1__5668f1',)
('t1__5668f1',)
('t1__5668f1',)
('t1__5668f1',)
('t1__5668f1',)
('t1__5668f1',)
*/

-- Prediction Query
SELECT DISTINCT T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2."U-PRO" >= 30;

/*
Prediction Result:
('t1__5668f1',)
('s27p2',)
*/