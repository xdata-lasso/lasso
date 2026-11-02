-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2024-06-15', '2021-12-04', '2022-04-27', '8c4pgu7vfe', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483647, 'au2dwyrq13', '2024-06-15', '2022-09-28', '2024-03-19', '78d99r', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'jsl', '2024-06-15', '2024-09-13', '2020-04-20', 'yp5qi2rk', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483646, '9v', '2024-06-15', '2022-12-15', '2024-02-23', '8pz0f8je', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (0, 'd2', '2024-11-12', '2023-10-23', '2024-05-17', '9uxj4hwbdvl', 'h2gn');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483643, 'uttmu2ne5', '2024-06-15', '2025-11-10', '2025-12-24', 'fvy', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-1, '7zzbe8y', '2023-10-06', '2021-10-24', '2023-09-24', '42q7sx58b4', 'pmaus3auvmkr');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483641, 'ta8y3a17v4', '2024-06-15', '2024-04-26', '2021-01-29', 'mayq3qdpua', 'SJS');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483640, '96rn', '2024-06-15', '2023-05-27', '2020-07-30', 'rhm5w', 'SJS');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', -1633151678, -252690330, 1115440883, 1644814318, 841.297061, 294.861575, 268.234631, -1349201381, 737.440743, 334.878198, -1910425938, -845863578, -1610064545, 429706943, 240.969194, 267.815776, 192.379301, 607.794538, -1137908826, 619.836822, -918961358, 126.856521, -45536098, 1861536320, 44952191, 'fa9', 1620389964, 546571701, 947159877, '5c4ec', 'gce', '76nium52', -443340271, 757448742, '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -453362185);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-01', 1968874827, -664193365, -1070063173, 555413010, 668.309685, 635.267184, 210.05299, 1575412235, 269.734861, 304.188492, -361507387, 401805964, -1485777725, -1255130038, 89.552801, 687.701166, 656.638403, 619.547972, -688216274, 577.256099, 1382410067, 879.800692, 172461907, 1606439408, 1443629118, 'zbilyrkn', -688098735, 1784916884, 37673509, 'h0f8jswwlq', 'xb72fxa7r', 'fdrz16n', -1496556994, -2115841792, 'dh5ogrgj', '8', 'yzt1afgogrit', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7', 'f', -47052816);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-02', 645287482, 765724008, -1099855564, 87529806, 752.977863, 723.045103, 44.287997, -1928431425, 803.582738, 695.452114, -1284905200, 7929158, -1744557630, 1870300798, 492.883123, 691.147113, 537.702873, 830.92312, -1488156735, 67.250709, -1180042408, 445.968654, 199672698, 2119806856, -1962347906, 'jpttg', -2033879835, 1798111945, 944975670, 'i36c4bf', 'foa', 'cd07z2zezjo7', 304189298, -542502665, 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 's27p2r94gth2', 'najj', 'a3o', -1428186898);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1970-01-01', 609771851, -1934017803, 1105964624, -663234145, 31.262264, 212.848854, 191.1711, 101754718, 486.420817, 646.236852, -1245584612, 1731843275, -582376271, -1165594842, 352.249155, 900.422166, 55.294573, 221.713281, -210159774, 562.960947, -2071531094, 407.368744, -366775518, 575038073, -1161141730, 'cl5ams', 709097796, -984562992, -605061107, 'gc1d', 'j9erhizgk1', 'yoeyo6l0hdt6', 1435223075, 1617348603, 'yxuzk', '5', '1gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', 1044710644);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1970-01-02', 966412849, -2061634386, -850941333, -1216952047, 393.386546, 555.680342, 302.335933, -2140923099, 770.531988, 393.978704, -841516418, 152478847, -625404808, -1694533100, 203.071475, 950.098522, 714.781282, 619.508764, 1295379066, 749.454983, 40558455, 460.649748, 740386991, 2018368241, 920097188, '1rxe9y', -1046720861, 643589729, -1231488097, '55y3dohvu06d', 'a35rmki', '18ri', 1510892261, 1677948887, 'y08ftp6ewt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', 973811121);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Date, STRFTIME('%Y', T2."First Date") - STRFTIME('%Y', T2.Birthday) FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T2.Diagnosis = 'SJS' AND NOT T2.Birthday IS NULL ORDER BY T2.Birthday ASC, T1.id NULLS LAST, T1.date NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('2024-06-15', -2)
*/

-- Prediction Query
SELECT T2.Date, STRFTIME('%Y', T2.Date) - STRFTIME('%Y', T1.Birthday) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Diagnosis = 'SJS' ORDER BY T1.Birthday, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Prediction Result:
('2024-06-15', 0)
*/