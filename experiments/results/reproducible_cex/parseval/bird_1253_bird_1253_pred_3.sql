-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'pat_2082cd');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, '9rljsl0b4', '2024-04-25', '2022-09-10', '2025-07-21', 'i2rkf', 'pat_2082cd');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'vqx58pz0f', '2021-08-12', '2020-11-04', '2021-02-03', 'd21vy9uxj4hw', 'pat_2082cd');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2437, 'q4301jh', '2025-03-06', '2020-08-23', '2020-11-02', '8c68', 'pat_2082cd');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2438, '8vacx7', '2020-02-05', '2021-01-02', '2023-07-08', 'w1of77pz', 'pat_296eb6');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2439, 'k1', '2024-04-20', '2022-08-02', '2020-10-24', 'o6l0hdt', 'pat_296eb6');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2436, 'u', '2022-12-05', '2020-04-21', '2021-07-17', 'f2ccukjq1', 'pat_2082cd');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (0, 'dpunmw', '2020-12-14', '2023-12-06', '2024-03-09', 'rlawk', 'pat_2082cd');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 1160656988, -992890117, 1914020640, 1268590800, 378.476082, 783.93201, 718.397869, -1670923962, 663.049759, 711.020062, 1908028688, 2122220075, 1072996612, 13244799, 320.851235, 113.643485, 855.355181, 179.378884, -841692980, 182.319045, -1257178728, 787.938887, 2087640001, 907682809, 2026480202, 'ie5', -1209887326, 80, -1399556171, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 373262291, -472966518, 's5bbp02e', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2024-06-15', -2050247126, -736979194, 2103044118, -1642259219, 109.083092, 802.414724, 58.749749, 1968874827, 345.35543, 250.856497, 555413010, 722884590, 580968159, -1245312912, 866.804244, 269.734861, 304.188492, 415.830002, 401805964, 154.065416, -1255130038, 89.552801, 806170397, 513454646, -688216274, 'gcb98ozk3z', 1686459626, 80, -1554531873, 'yrkn6vck6ah0', '8j', 'wwlq7', 1255343543, -541746689, '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', -598313376);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2438, '1970-01-01', 87529806, -1957268147, -1928431425, 1303877941, 695.452114, 200.834692, 102.360106, 7929158, 93.813527, 935.463334, 820970595, 1421303999, -1488156735, -1858644047, 140.053935, 225.249964, 445.968654, 546.48992, 2119806856, 848.763933, -1962347906, 298.188866, -847293924, -2033879835, 1798111945, '5zi36c', 1722106924, 80, -2072838897, 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', 1721638020, 983324983, 'ztdg', '5i3', 'q5l', 'pim5', '58q', 's27p2r94gth2', 'najj', -1351793914);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2438, '1970-01-02', 1919033056, -1428186898, -761353513, 362376128, 585.201826, 932.839964, 727.443156, -1311735207, 774.197346, 446.676539, -1817527403, -1402164108, 2123471885, -526633767, 823.908713, 604.525889, 391.037879, 920.405654, 458835042, 70.267562, 924693315, 335.639672, 1043710187, 318331233, -233617564, '7sx58b4pma', -929383517, 81, -2090240067, 'mkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', -1793230843, -441521858, '2zob', '0', '0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 1056589776);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2437, '1970-01-01', -795975227, 1294064538, 778835680, 1755752040, 852.508842, 793.946774, 20.547158, 450555855, 451.913941, 107.446882, -1250380401, 1718516876, -2076274980, 1731324803, 230.129952, 129.891173, 437.428969, 493.031806, -564679000, 118.293148, -251205568, 446.264042, 287256667, 1614799674, 1083479253, '9oaawg', 1044710644, 80, 966412849, '0', 'bindz', '9tajz9td', 152478847, -625404808, 'um', 'c', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 30861410);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2437, '1970-01-02', -438741674, -154207334, 729449685, -1580984044, 422.698571, 535.063373, 600.543738, 1510892261, 890.677915, 590.734291, -1853955201, -805997097, -586285368, 1664452437, 919.033168, 830.662489, 154.042758, 779.614625, -2080232972, 607.620308, 1528227252, 202.604041, -1659775598, -891525031, -1154091048, 'j', 1728926031, 81, -63214972, 'zys7', 'y', 'yd1jmgjach8', 973811121, 280292620, 'a8y3a17v4yg', 'mayq3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', -1872934808);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2437, '1969-12-31', 1584429327, -1575692857, 1570917601, 775289854, 22.149931, 538.678811, 933.576593, 1040753276, 982.976965, 424.56002, -1333785554, 1784997708, -696672546, 44959255, 482.609422, 398.641235, 873.064955, 637.227131, -2128972904, 857.91055, -1043357093, 324.663207, 190510318, -835782528, 192271618, '9114qbre6bj', -752650834, 80, 2134937984, '8kj', '85', 'pxlvri', 986268139, 2042428747, 'z0kaq', 'ncgc8', '3b7v8', 'kwdmdbdht', 'j47nxar50', 'sj', 'an', 1195320303);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-01', 558684943, -120625031, 572453185, 1348973408, 309.882408, 287.669302, 102.325141, 1084127083, 262.663904, 447.480136, -261782899, -1079009577, -1385967617, 1813965704, 667.60579, 513.39609, 777.919912, 737.929766, 434520825, 112.467274, 1849928338, 759.141894, -176968915, -717865822, 2061102304, 'a2sb', 1731005516, 80, 1388661799, '1pa', 'cvwnyq', 'ouirl', 721232773, 323781506, 'ouit63xyfvmj', 'wpp26mb3aj0j', '0h3r13', 'ir1axyyh', 'l2i9', 'sa', '8pgc', 1394285393);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-02', -1052659852, 1092207544, 851545765, 987928936, 219.655532, 257.195325, 910.671682, 889799750, 299.758919, 576.502311, 1464469520, -209435372, 946571403, -1517965246, 356.694673, 984.360893, 659.922911, 206.74277, 1807244612, 919.570578, 1125564712, 445.619063, -1881008758, -1955129162, -1015337060, 'yrnxs6dvd', -563917514, 81, -1195137401, '7t3gvp', 'j9f', 'vuu', -1415215611, -251621840, 'y1ogyv1rgeza', 'xc1clupgly', '8oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', '9lqv26u3', -169055351);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1969-12-31', -894726713, -1089715864, -165171643, -2051120765, 358.454959, 600.508152, 886.332485, 1693638235, 900.131547, 594.167398, -1919229426, 495658460, 1530380378, 1069076646, 866.50801, 9.487854, 996.049277, 936.327627, -229524038, 884.782066, -1954048590, 878.988408, -1862623291, -696200137, -410809407, 'u49', -1459357985, 80, -2051917235, '8c', 'e', 'uekhllbw', 1868665501, -1896445805, '5v0edu', 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 'et8xjhcf46c', 'pe', 'rxa61sjv8nv', 2081562124);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patientData.Diagnosis FROM Patient AS patientData INNER JOIN Laboratory AS labData ON patientData.ID = labData.ID WHERE labData.IGA BETWEEN 80 AND 500 ORDER BY labData.IGA DESC, patientData.id NULLS LAST, labData.id NULLS LAST, labData.date NULLS LAST LIMIT 1;

/*
Gold Result:
('pat_2082cd',)
*/

-- Prediction Query
SELECT patient.diagnosis FROM patient INNER JOIN laboratory ON patient.id = laboratory.id WHERE laboratory.iga = (SELECT MAX(iga) FROM laboratory WHERE iga BETWEEN 80 AND 500);

/*
Prediction Result:
('pat_296eb6',)
('pat_2082cd',)
('pat_2082cd',)
*/