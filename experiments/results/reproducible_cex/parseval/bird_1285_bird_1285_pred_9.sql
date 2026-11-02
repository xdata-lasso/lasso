-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'rwbbp6luhvd', '2022-01-04', '2023-05-26', '2023-05-30', 'lbn', 'rmdp');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 'd2', '2024-11-12', '2023-10-23', '2024-05-17', '9uxj4hwbdvl', 'h2gn');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, 'q4301jh', '2025-03-06', '2020-08-23', '2024-06-15', 'n8', 'c68x8vacx7');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 'f', '2023-07-08', '2025-06-26', '2024-06-15', '1of77p', 'o72ctdc');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (6, 'xuzkb52', '2024-11-18', '2021-03-16', '2024-06-15', 'nlas6e', 'lboeowii1z5');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (7, 'xih6', '2025-08-17', '2024-12-13', '2024-06-15', '2xlyo', 'tow9oaawg96a');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (8, 'urz0kaqtncg', '2020-05-16', '2023-04-22', '2024-06-15', 'b7v88kwd', 'dbdh');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (9, '6j47n', '2024-02-26', '2020-02-09', '2024-06-15', '50hsj', 'an');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2024-06-15', 2026480202, -1576219117, 500, -1823627488, 327.753528, 218.301157, 992.733505, -1399556171, 741.842896, 587.783596, 1419861592, 700088193, 374105386, 1274489983, 128.76421, 610.208018, 108.098664, 623.093099, -1585009206, 191.847248, -53231346, 816.814398, -443340271, 757448742, -1179823637, 'rqro', 775304493, 373262291, -472966518, 's5bbp02e', 'tliqa1', 'ryytoo3', -1666765085, 1178636309, 'ex1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', -1529584866);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 1968874827, -664193365, 500, -1070063173, 629.317167, 668.309685, 635.267184, -1245312912, 866.804244, 269.734861, -841004020, -361507387, 401805964, -1485777725, 261.415754, 915.268032, 207.767266, 89.552801, 806170397, 656.638403, 513454646, 339.762162, 331812443, 1382410067, 1631231566, '8ozk3zbil', 982314585, 638024588, -688098735, '6ah', 'f8jswwl', '7xb72', 1350414441, 2094425101, '7', 'yfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', -598313376);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '2023-06-03', -1284905200, 7929158, -1744557630, 1870300798, 492.883123, 691.147113, 537.702873, 1421303999, 53.966914, 153.511511, -1858644047, -1180042408, 199672698, 2119806856, 848.763933, 520.999811, 43.10527, 298.188866, -847293924, 511.172331, -2033879835, 918.655561, 944975670, -1575410149, -68044929, 'kf', 1923659053, -1950324754, 2115816682, '7z2zezjo7wg', 'd5ysxc', 'r0oz', -870767087, -1699185893, '5i3lq5lnpim5', '58q', 's27p2r94gth2', 'najj', 'a3o', 'v8u', 'tmu2n', -1817527403);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '2025-11-10', -1402164108, 2123471885, 500, -526633767, 823.908713, 604.525889, 391.037879, 458835042, 70.267562, 715.296942, -705922211, 1043710187, 318331233, -233617564, 574.707916, 518.470483, 904.091882, 927.310086, 756202403, 762.654945, 782684333, 476.006677, 681598285, 319284352, 1164790775, 'auvmkrpd', -609553675, 989018473, -55494714, 'n9', 'o705', 'a9n0jxfofws', 1719800120, -210159774, 'obb0q0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', -795975227);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (6, '2022-11-13', -2061634386, -850941333, -1216952047, -457901285, 555.680342, 302.335933, 1.527497, -841516418, 535.501742, 655.746331, -625404808, -1694533100, -1275298282, 1933158443, 714.781282, 619.508764, 455.52504, 615.213242, 1295379066, 749.454983, 40558455, 460.649748, 740386991, 2018368241, 920097188, '1rxe9y', -1046720861, 643589729, -1231488097, '55y3dohvu06d', 'a35rmki', '18ri', 1510892261, 1677948887, 'y08ftp6ewt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', 973811121);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '2023-06-07', 620355627, -531872415, 500, -2125172723, 523.794239, 578.974734, 478.922811, -493230039, 851.403807, 194.535395, -2081662466, -1941472821, -2082238979, -845136979, 857.029414, 257.163132, 110.952654, 487.287849, 555368535, 181.220234, 899787662, 638.478504, 833568923, -384749431, -934098178, 'gelcu', 422046500, -1750715330, 277649518, 'cukjq1quik1y', 'hb08hlst1pq', 'mizt', 1793241362, -1304516770, 'z78', 'q', 'lud8f', 'tb8r9114qbre', '6bjeuuwsj8k', 'h85', 'pxlvri', 986268139);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (8, '2024-05-23', 1463445550, -1096060187, 2014610660, 1492264835, 350.403401, 257.835629, 174.163863, -2081798075, 164.859551, 712.42959, -300547632, -967107842, -1011152325, 1298113538, 187.899799, 977.087263, 912.323762, 654.911516, -2098439423, 392.952848, -1148194959, 414.584569, 944310519, 6224071, 1928920679, 'ysu', 1193656937, 434520825, -1664440372, 'u2g', 'r31', 'wq51oa', 1813968674, 1907670428, '3', 'oi1pav', 'v', 'wnyqrouirlrp', 'ouit63xyfvmj', 'wpp26mb3aj0j', '0h3r13', -156860347);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '2024-11-25', -2103849024, -485095266, 500, -1617977597, 633.816798, 181.951966, 817.07132, 230411875, 296.668783, 920.0032, -1452518801, -662859586, 1339281953, -69263912, 504.138859, 152.841575, 70.62455, 159.120465, -1892701926, 211.896872, -460035045, 961.420907, 1794943626, 886926141, 294604606, 'wns', 1125564712, -233564324, -1881008758, 'y', 'vjwq49yr', 'nxs6dvdxdo2v', 1805923837, -699779308, 'j9f', 'vuu', '7k10', 'z2my1ogyv1r', 'ez', 'x', '1', -1970162044);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1."First Date" FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.LDH >= 500 ORDER BY T1."First Date" DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
('2024-06-15',)
*/

-- Prediction Query
SELECT MAX("laboratory"."date") FROM "patient" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" WHERE "laboratory"."ldh" >= 500 AND "patient"."first date" = (SELECT MAX("first date") FROM "patient");

/*
Prediction Result:
('2025-11-10',)
*/