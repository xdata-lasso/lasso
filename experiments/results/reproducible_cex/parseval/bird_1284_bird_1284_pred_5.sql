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

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2438, 'q4301jh', '2025-03-06', '2020-08-23', '2024-06-15', 'n8', 'c68x8vacx7');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2437, 'k1', '2024-04-20', '2022-08-02', '2024-06-15', 'yo', 'l0hdt6fuq');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (0, 'xuzkb52', '2024-11-18', '2021-03-16', '2023-11-09', 'las6', 'elboeowii1');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-1, 'ddlysu6ip', '2021-04-05', '2020-07-12', '2024-06-15', 'u2g', 'r31');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 1644814318, 1465859724, 499, -1349201381, 737.440743, 334.878198, 55.194297, -845863578, 125.12763, 22.535764, 429706943, 462974032, -1137908826, -918961358, 126.856521, 489.397796, 933.422701, 345.718563, 44952191, 768.216462, 1620389964, 627.258639, 947159877, 1990080517, 1408123494, '4', 374105386, 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, 'liqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2024-06-15', 1968874827, -664193365, 499, -1070063173, 629.317167, 668.309685, 635.267184, -1245312912, 866.804244, 269.734861, -841004020, -361507387, 401805964, -1485777725, 261.415754, 915.268032, 207.767266, 89.552801, 806170397, 656.638403, 513454646, 339.762162, 331812443, 1382410067, 1631231566, '8ozk3zbil', 982314585, 638024588, -688098735, '6ah', 'f8jswwl', '7xb72', 1350414441, 2094425101, '7', 'yfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', -598313376);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2438, '1969-12-31', 1523825314, 2078438287, 499, -47052816, 650.242697, 222.511261, 678.284012, -1099855564, 224.624401, 985.639995, 87529806, -1957268147, -1928431425, 1303877941, 695.452114, 200.834692, 102.360106, 501.846153, -1744557630, 935.463334, 820970595, 537.702873, 1421303999, -1488156735, -1858644047, 'o22', 2004147439, -691774480, -1523347137, 'ttg6bnou5zi3', 'c4bfkfoac', '0', 76987628, -253138337, 'zj', '7wgx', '5', 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 1817366143);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2438, '2024-06-15', 1615073310, 1055237066, -1, 988954859, 99.674786, 796.553419, 577.602934, 1162591638, 625.532672, 822.122444, -2136247961, -1478011227, -2096405521, 1803796945, 338.437591, 799.667192, 703.189927, 311.951038, 618058035, 318.763195, 1553368934, 208.49371, 1908593332, 697257217, -451030047, 'be8yvkv42q7', -2060082151, -1122409769, 1849819405, 'us3auvmkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', -1793230843, -441521858, '2zob', '0', '0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 1056589776);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-01', -457369423, 1557188093, 499, 548968280, 138.537557, 515.131026, 501.709636, -1034034171, 789.706494, 680.281941, -1396673167, 412199481, 727608179, 456034296, 353.681528, 555.75468, 743.240647, 725.010524, -2061634386, 301.874779, -1216952047, 393.386546, -2140923099, -841516418, 152478847, '5wcgumbc3td', 1964331395, -1943814113, 1514371324, '603vzxw1r', 'e9yfk7', 'k162n', -516345261, -1191116453, 'u06dza', '5rmkio18', 'i2hy0', '8ftp6ewtqx', 'njabym', 'n2mfx7h', '3p6sto1c', 170892881);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '2024-06-15', -1643065004, -1438303683, 0, -515419519, 527.830294, 61.332474, 670.297308, -531932574, 425.077908, 583.223769, -1502591405, -2008781089, 1122899168, -161108900, 431.027804, 741.721165, 328.806478, 643.031153, 306260487, 771.998599, -499203870, 851.486083, 1432875972, 1032339628, 608093726, 'p', -845136979, -1042976410, -1670945624, 'wlic7dn2', 'p490', 'dmsqtg', -1872934808, -1974774786, 'qb9i9f2ccu', 'jq1', 'uik1y', 'hb08hlst1pq', 'mizt', 'vb6m4iz78aq', 'lud8f', -835782528);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1969-12-31', 192271618, -312228770, 499, 1618264449, 881.656954, 19.495363, 70.018028, 36589303, 760.996078, 141.988494, 364280973, 1592061050, -1451520332, -55270062, 243.463869, 827.119765, 178.023395, 951.537284, -996196097, 729.633445, 2042428747, 852.317741, 1228655416, -388527046, -1040951738, 'ncgc8s3b7v', 180947503, -622923312, 1789767331, 'b', 'h', '6j47n', -556370776, 1144507576, '0hsjhanz', 'dpunmw', 'wx', 'rlawk', '14r5dqt', 'mg97a', 'z2o20', -1079009577);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1969-12-31', -717865822, 2061102304, 499, -1204806277, 922.347497, 706.295383, 944.164129, 1265709623, 458.205677, 903.031128, 1388661799, -1574319760, 473443538, 1754053934, 781.008765, 340.48601, 883.2045, 960.01108, -471852873, 265.913399, 917675957, 846.162355, -1582954378, -1143329124, 1368469085, '63xyf', 1394459557, -1335280432, -614741184, '26mb', 'aj0ju0h3', '133ir', -270436559, -569461411, 'hpl2i9e', 'ap8pg', 'k', 'wtsr5', '4o6qjektb1', '2', 'zg3r', 294604606);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '2024-06-15', -1460437682, 1014069980, -1, 1070869226, 519.969066, 740.685871, 145.530816, -1517668312, 745.88721, 540.466711, -1971104604, -526608193, 1560573473, 472597763, 630.926892, 692.351046, 863.666767, 473.382328, -516707997, 736.293094, -583955995, 765.686658, -1935855834, 294818731, -563917514, '2v7t', 1770139230, -1680744918, -1136928894, '9fj', 'uun7k1', 'z2my1og', -489473841, -333485269, 'ez', 'x', '1', 'l', 'upgly78oit', 'xeilpe019cy', 'od033dlhd', -929713613);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1970-01-01', -1239290359, -1832294694, 499, 1188203659, 642.766569, 176.647154, 805.286956, -1066046077, 726.542267, 954.744224, 1032462616, 980224846, -169055351, -894726713, 367.690725, 246.280755, 461.542982, 22.436232, -607931326, 600.508152, 1659285381, 894.330875, 1718551923, 404445908, -1919229426, '61l2', 1069076646, 1574139922, -2106733603, '62ocagj', 'ev', 'zxlu49', -1459357985, -2051917235, '8c', 'e', 'uekhllbw', 'dpu5v0', 'du', 'y9v2z12983', '5xoepacxdb2f', -344881050);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1."First Date" FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.LDH < 500 ORDER BY T2.LDH DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
('2024-06-15',)
*/

-- Prediction Query
SELECT MIN(patient."First Date") AS first_date FROM patient INNER JOIN laboratory ON patient.id = laboratory.id WHERE laboratory.ldh = (SELECT MAX(ldh) FROM laboratory WHERE ldh < 500);

/*
Prediction Result:
('2023-11-09',)
*/