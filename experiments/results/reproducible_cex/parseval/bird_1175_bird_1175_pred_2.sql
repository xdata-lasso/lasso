-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2024-06-15', '2021-12-04', '2022-04-27', '8c4pgu7vfe', 't1__1cff5d');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'au2dwyrq13', '2024-06-15', '2022-09-28', '2024-03-19', '78d99r', 't1__1cff5d');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2438, 'jsl', '2024-06-15', '2024-09-13', '2020-04-20', 'yp5qi2rk', 't1__045937');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2437, '1q43', '2024-06-15', '2024-08-06', '2024-10-12', 'jh3den8c68', 't1__045937');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483644, '2mnajjla3o', '2024-06-15', '2021-11-16', '2023-10-18', 'uttmu2ne5', 't1__045937');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-1, '78lfvyz7zz', '2020-03-31', '2020-10-14', '2024-04-30', 'kv42q7', 'x58b4');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483642, '9tajz9td', '2024-06-15', '2022-04-25', '2025-06-14', 'cgumbc', 't1__045937');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483641, '3tdu6bd0w960', '2024-06-15', '2025-03-01', '2023-09-09', 'xw1rxe9', 't1__045937');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483640, 'fk7qk16', '2024-06-15', '2024-12-18', '2022-05-23', '55', 't1__045937');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'value', '2024-06-15', '2024-06-15', '2024-06-15', 'value', NULL);

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', -1633151678, -252690330, 1115440883, 1644814318, 841.297061, 294.861575, 268.234631, -1349201381, 737.440743, 334.878198, -1910425938, -845863578, -1610064545, 429706943, 240.969194, 267.815776, 192.379301, 607.794538, -1137908826, 619.836822, -918961358, 126.856521, -45536098, 1861536320, 44952191, 'fa9', 1620389964, 546571701, 947159877, '5c4ec', 'gce', '76nium52', -443340271, 757448742, '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -453362185);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2438, '2024-06-15', -705985602, 537874887, -461695645, 836513442, 707.476301, 541.107536, 75.31458, -1937207087, 890.091601, 339.69384, -792092619, -1492524358, -1612443122, -2050247126, 328.40866, 989.653112, 0.5, 705.754562, -1642259219, 109.083092, 1298861365, 58.749749, 1968874827, -664193365, -1070063173, 'x5hncprjtu0', -1898531797, -1748371085, -1742081330, 'n2f3dqv0g', 'cb98ozk3zbil', 'yrkn6vck6ah0', -1520489792, -658391922, 'q7x', '7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3', -491938169);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2437, '2024-06-15', -683007527, 2035306060, 1523825314, 2078438287, 313.653498, 489.044661, 650.242697, 765724008, 528.552305, 243.919919, 87529806, -1957268147, -1928431425, 1303877941, 695.452114, 200.834692, 0.0, 102.360106, 7929158, 93.813527, 1870300798, 492.883123, 820970595, 1421303999, -1488156735, '1i', 1897687032, -241848752, 2004147439, 'tjpttg', 'bnou5zi36', '4', -2072838897, -1173368267, 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5', '3lq', '5lnpim5k58qs', '7p2r94gt', 1273687251);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '2024-06-15', -1122409769, 1849819405, -929383517, -2090240067, 337.117577, 160.717227, 564.003268, 609771851, 49.701386, 736.632717, 1105964624, -663234145, -2013213247, 101754718, 486.420817, 646.236852, 0.0, 648.64235, -1245584612, 903.226183, -582376271, 228.613802, -634585028, 1719800120, -210159774, 'obb0q0k32o', -1898678660, 440115543, 292557306, 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', -795975227, 1294064538, 'uzkb52', 'gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', '6aqb0tbin', -1897615568);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2025-06-17', -1437333179, -921145356, 1258409369, -1981402255, 292.730571, 572.766956, 206.939346, 1610062532, 475.173408, 935.695299, 809183447, 89267185, -1865039888, 1160656988, 268.82475, 710.998147, 945.642658, 795.366812, 1219478689, 718.397869, -1670923962, 663.049759, 906324270, 1908028688, 2122220075, 'p6luhvdlttil', 429706943, 462974032, -1137908826, 'siie5unw6k', 'fa9', '00t5c4e', 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -453362185);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STRFTIME('%Y', T2.Date) - STRFTIME('%Y', T1.Birthday), T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID ORDER BY T2.HGB DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
SELECT (CAST(STRFTIME('%Y', E."Examination Date") AS INTEGER) - CAST(STRFTIME('%Y', P.Birthday) AS INTEGER)) AS Age, P.Diagnosis FROM Laboratory AS L INNER JOIN Patient AS P ON L.ID = P.ID INNER JOIN Examination AS E ON L.ID = E.ID WHERE L.HGB = (SELECT MAX(HGB) FROM Laboratory);

/*
Prediction Result:
*/