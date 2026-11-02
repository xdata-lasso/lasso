-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2024-06-15', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'yp5qi2rk', '2021-01-15', '2023-10-06', '2024-06-15', 'x58pz', 'f8jegd2');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'vy9uxj4', '2021-05-25', '2023-12-18', '2024-06-15', 'd', 'lph2gn');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2438, 'q4301jh', '2025-03-06', '2020-08-23', '1970-01-02', 'n8', 'c68x8vacx7');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2439, 'f', '2023-07-08', '2025-06-26', '2024-06-15', '1of77p', 'o72ctdc');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2437, '78lfvyz7zz', '2020-03-31', '2020-10-14', '1970-01-01', 'yvkv42q7s', '58b4pm');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-1, 'oaawg96aq', '2020-03-22', '2024-08-11', '1970-01-02', 'bindz', '9tajz9td');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (0, 'n5wcgumbc', '2025-02-08', '2023-06-26', '2024-06-15', 'u', 'bd0w9603v');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 1644814318, 1465859724, 500, -1349201381, 737.440743, 334.878198, 55.194297, -845863578, 125.12763, 22.535764, 429706943, 462974032, -1137908826, -918961358, 126.856521, 489.397796, 933.422701, 345.718563, 44952191, 768.216462, 1620389964, 627.258639, 947159877, 1990080517, 1408123494, '4', 374105386, 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, 'liqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2024-06-15', 1968874827, -664193365, 500, -1070063173, 629.317167, 668.309685, 635.267184, -1245312912, 866.804244, 269.734861, -841004020, -361507387, 401805964, -1485777725, 261.415754, 915.268032, 207.767266, 89.552801, 806170397, 656.638403, 513454646, 339.762162, 331812443, 1382410067, 1631231566, '8ozk3zbil', 982314585, 638024588, -688098735, '6ah', 'f8jswwl', '7xb72', 1350414441, 2094425101, '7', 'yfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', -598313376);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2439, '2024-06-15', 1303877941, -1284905200, 500, 7929158, 93.813527, 935.463334, 492.883123, 820970595, 537.702873, 830.92312, -1488156735, -1858644047, -1180042408, 199672698, 993.555996, 848.763933, 520.999811, 43.10527, -866772222, 244.215606, -847293924, 511.172331, -2033879835, 1798111945, 944975670, 'i36c4bf', -1173368267, 382831862, -406331049, 'ezjo7wg', 'd5ysxc', 'r0oz', -870767087, -1699185893, '5i3lq5lnpim5', '58q', 's27p2r94gth2', 'najj', 'a3o', 'v8u', 'tmu2n', -1817527403);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2438, '2024-06-15', 1849819405, -929383517, 500, -2090240067, 337.117577, 160.717227, 564.003268, 609771851, 49.701386, 736.632717, 1105964624, -663234145, -2013213247, 101754718, 486.420817, 646.236852, 648.64235, 209.98973, 1731843275, 364.404955, -1165594842, 352.249155, 1719800120, -210159774, 270415200, 'b', -397848196, -366775518, 575038073, 'dwcl', '5amsorlwyngc', 'dj9erhi', 1056589776, -499913447, 'yo', 'l0hdt6fuq', 'xuzkb52', 'gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', 1774679448);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '2024-06-15', 2018368241, 920097188, 500, -639616320, 893.28445, 372.360229, 65.653061, 237552112, 85.140124, 165.89756, -1046720861, 643589729, -1231488097, 956819642, 680.425625, 990.308943, 467.033126, 602.631056, -732999244, 885.125365, 30861410, 397.847489, -154207334, 729449685, -1580984044, '8ri2hy0', 168442149, 1299171592, 2066302536, 'ewtqxxnja', 'bymzn2mfx7h3', 'p6sto1cj', 1728926031, -63214972, 'zys7', 'y', 'yd1jmgjach8', 'qta8y3a17v4y', 'ma', 'q3qdpua', '96rn', 2013152515);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '2024-06-15', 1139012231, -951706262, 500, -1324935647, 968.21585, 583.44162, 348.994405, -1573704891, 520.723549, 794.50432, -1260548409, 1409697108, -1104749933, 379651188, 362.160981, 906.254502, 840.039966, 964.892941, -1027584872, 107.568093, -1391541536, 321.654734, -1025517017, 1374676344, 238243966, 'ccukjq1q', -796609690, -1459013972, -1670335771, '8hlst1p', 'qomiztvb6m', 'iz78aqql', -753065777, 190510318, 'tb8r9114qbre', '6bjeuuwsj8k', 'h85', 'pxlvri', 'surz0kaqtncg', 'c8s3b7v88k', 'dmdbdh', 313797011);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '2023-01-03', 906324270, 1908028688, 499, 2122220075, 749.826493, 503.083789, 320.851235, -1659388584, 855.355181, 179.378884, -841692980, -1364429300, -1257178728, 1236688122, 986.066566, 666.330692, 46.9162, 776.327423, 907682809, 227.766936, 2026480202, 133.007885, -1823627488, -1209887326, -1399556171, 'a9000t5c4eci', 1149850321, -1833165707, 1155439218, 'um5', 'zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1."First Date" FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.LDH >= 500 ORDER BY T1."First Date" DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
('2024-06-15',)
*/

-- Prediction Query
SELECT L.Date FROM Patient AS P INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE P."First Date" = (SELECT MAX("First Date") FROM Patient) AND L.LDH >= 500;

/*
Prediction Result:
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
('2024-06-15',)
*/