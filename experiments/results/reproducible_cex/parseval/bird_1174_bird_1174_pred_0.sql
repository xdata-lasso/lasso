-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'yp5qi2rk', '2021-01-15', '2023-10-06', '2022-12-15', 'x58pz0f8je', 'd2');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'vy9uxj4', '2021-05-25', '2023-12-18', '2020-04-02', 'v', 'ph2');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 'yp5qi2rk', '2021-01-15', '2023-10-06', '2022-12-15', 'x58pz0f8je', 'd2');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (6, 'tsj3ayxp1q4', '2025-02-15', '2024-08-06', '2024-10-12', 'jh3den8c68', '8vacx7');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (7, '7p2r94gt', '2021-04-23', '2024-12-19', '2022-03-04', 'ajjl', '3');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1991-10-01', 700293388, 906324270, 1908028688, 2122220075, 749.826493, 503.083789, 320.851235, -1659388584, 855.355181, 179.378884, -841692980, -1364429300, -1257178728, 1236688122, 986.066566, 666.330692, 46.9162, 776.327423, 907682809, 227.766936, 2026480202, 133.007885, -1823627488, -1209887326, -1399556171, 'a9000t5c4eci', 1149850321, -1833165707, 1155439218, 'um5', 'zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '1991-10-01', 1298861365, 1968874827, -664193365, -1070063173, 629.317167, 668.309685, 635.267184, -1245312912, 866.804244, 269.734861, -841004020, -361507387, 401805964, -1485777725, 261.415754, 915.268032, 207.767266, 89.552801, 806170397, 656.638403, 513454646, 339.762162, 331812443, 1382410067, 1631231566, '8ozk3zbil', 982314585, 638024588, -688098735, '6ah', 'f8jswwl', '7xb72', 1350414441, 2094425101, '7', 'yfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', -598313376);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1991-10-31', 1972233925, 1792827279, 804529642, -1538707438, 774.445116, 461.908795, 881.248682, -1826414375, 544.095565, 583.19749, -683007527, 2035306060, 1523825314, 2078438287, 313.653498, 489.044661, 650.242697, 222.511261, 765724008, 528.552305, -1099855564, 224.624401, 87529806, -1957268147, -1928431425, 'mfg62', -1744557630, 1870300798, 820970595, 'qdjpe1io2', '78507cvt', 'ptt', 1467355421, -1171104889, '5zi36c4bfkfo', 'c', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', -176606723);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', -15162884, 1339733032, -1556979799, -55240145, 821.273487, 545.449043, 975.929586, 1817366143, 876.038555, 628.658254, 1055237066, 988954859, -1719383707, 1273687251, 577.602934, 193.695314, 770.686956, 625.532672, -2136247961, 155.873695, -2096405521, 588.850908, 1803796945, 872694102, 618058035, '2ne578', 1908593332, 697257217, -451030047, 'be8yvkv42q7', 'x58b4', 'pmaus3auvmkr', 609771851, -1934017803, 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', 211603887);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '1991-10-01', 700293388, 906324270, 1908028688, 2122220075, 749.826493, 503.083789, 320.851235, -1659388584, 855.355181, 179.378884, -841692980, -1364429300, -1257178728, 1236688122, 986.066566, 666.330692, 46.9162, 776.327423, 907682809, 227.766936, 2026480202, 133.007885, -1823627488, -1209887326, -1399556171, 'a9000t5c4eci', 1149850321, -1833165707, 1155439218, 'um5', 'zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '1991-10-01', 1675430660, -688509700, -792092619, -1492524358, 124.573829, 22.63964, 328.40866, 2103044118, 705.754562, 117.631729, 1298861365, 1968874827, -664193365, -1070063173, 629.317167, 668.309685, 635.267184, 210.05299, 1575412235, 269.734861, -841004020, 415.830002, 401805964, -1485777725, -1255130038, '3d', 513454646, -688216274, 331812443, 'cb98ozk3zbil', 'yrkn6vck6ah0', '8j', -932772113, -639539893, '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', -946046410);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (6, '1991-10-01', 1523825314, 2078438287, -47052816, 645287482, 222.511261, 678.284012, 528.552305, -1099855564, 224.624401, 985.639995, 87529806, -1957268147, -1928431425, 1303877941, 695.452114, 200.834692, 102.360106, 501.846153, -1744557630, 935.463334, 820970595, 537.702873, 1421303999, -1488156735, -1858644047, 'o22', 2004147439, -691774480, -1523347137, 'ttg6bnou5zi3', 'c4bfkfoac', '0', 76987628, -253138337, 'zj', '7wgx', '5', 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 1817366143);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (7, '1991-10-01', 1803796945, 872694102, 618058035, 1553368934, 208.49371, 497.427028, 522.61046, 1908593332, 86.586744, 781.110793, 697257217, -451030047, -2052653308, -489120589, 161.672605, 332.570125, 483.133073, 258.625847, -2060082151, 710.005534, -1122409769, 959.473065, 1849819405, -929383517, -2090240067, 'mkrpdj', 1105964624, -663234145, -2013213247, '9mo7', '5a9n0jx', 'of', -634585028, 1719800120, 'o', '2zobb0q0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', -1614619556);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG('1999' - STRFTIME('%Y', T2.Birthday)) FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T1.Date BETWEEN '1991-10-01' AND '1991-10-30';

/*
Gold Result:
(-22.666666666666668,)
*/

-- Prediction Query
SELECT AVG(STRFTIME('%Y', '1991') - STRFTIME('%Y', T2.Birthday)) FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T1.Date BETWEEN '1991-10-01' AND '1991-10-31';

/*
Prediction Result:
(-6728.571428571428,)
*/