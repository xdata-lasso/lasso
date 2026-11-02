-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 'M', '2025-06-17', '2021-11-08', '2025-06-13', 'wwqcg', 'k9n8c');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'M', '2023-01-20', '2022-01-18', '2021-08-18', 'l0b4y', 'p5qi2rkf9v');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'x58pz', '2024-08-06', '2020-12-28', '2021-08-12', 'gd', '1vy9uxj4');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, NULL, '2024-06-15', '2024-06-15', '2024-06-15', 'value', 'value');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 't1__e8e7c2', '2021-12-23', '2020-10-31', '2024-03-14', '4ji7zwa', '2dwyrq');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (6, NULL, '2024-06-15', '2024-06-15', '2024-06-15', 'value', 'value');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1998-01-01', -106629402, 1871297066, 809183447, 89267185, 86.520366, 65.761562, 779.409124, 1160656988, 268.82475, 710.998147, 1914020640, 1268590800, 1219478689, -1670923962, 663.049759, 711.020062, 944.247544, 994.117864, 1072996612, 503.083789, -1659388584, 855.355181, -1377057208, -841692980, -1364429300, 'nprmdposii', -1823627488, -1209887326, -1399556171, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 373262291, -472966518, 's5bbp02e', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '1998-01-01', -1612443122, -2050247126, -736979194, 2103044118, 705.754562, 117.631729, 109.083092, 1298861365, 58.749749, 958.414393, -664193365, -1070063173, 555413010, 722884590, 635.267184, 210.05299, 866.804244, 269.734861, -841004020, 415.830002, 401805964, 154.065416, -1255130038, -1762857309, 806170397, 'qv0gcb98ozk', -155284187, 1686459626, -1554531873, 'yrkn6vck6ah0', '8j', 'wwlq7', 1255343543, -541746689, '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', -598313376);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2000-06-29', 1972233925, 1792827279, 804529642, -1538707438, 774.445116, 461.908795, 881.248682, -1826414375, 544.095565, 583.19749, -683007527, 2035306060, 1523825314, 2078438287, 313.653498, 489.044661, 650.242697, 222.511261, 765724008, 528.552305, -1099855564, 224.624401, 87529806, -1957268147, -1928431425, 'mfg62', -1744557630, 1870300798, 820970595, 'qdjpe1io2', '78507cvt', 'ptt', 1467355421, -1171104889, '5zi36c4bfkfo', 'c', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', -176606723);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', -15162884, 1339733032, -1556979799, -55240145, 821.273487, 545.449043, 975.929586, 1817366143, 876.038555, 628.658254, 1055237066, 988954859, -1719383707, 1273687251, 577.602934, 193.695314, 770.686956, 625.532672, -2136247961, 155.873695, -2096405521, 588.850908, 1803796945, 872694102, 618058035, '2ne578', 1908593332, 697257217, -451030047, 'be8yvkv42q7', 'x58b4', 'pmaus3auvmkr', 609771851, -1934017803, 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', 211603887);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '1998-01-01', -55602865, -59984348, -664303813, -1022641847, 97.952323, 171.746906, 557.512061, -1980249628, 249.706432, 99.523333, -734455130, 1744686505, -1633151678, -252690330, 797.015047, 241.913711, 759.708817, 882.963176, 1465859724, 294.861575, -1349201381, 737.440743, -1910425938, -845863578, -1610064545, 'n', 462974032, -1137908826, -918961358, 'e5u', 'w6kl', 'a9', 1620389964, 546571701, '0t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 1178636309);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '2000-03-01', -1097120355, 244829661, -1362461264, -904834265, 419.361606, 470.165282, 384.969231, 1692174491, 495.297639, 261.217059, -227162283, 2056419640, 222415430, 556727997, 860.770887, 774.274643, 541.393553, 235.518744, 1836127587, 410.133844, -1529584866, 755.698226, 1196308825, 910894705, -283454505, '9uxj4hw', -2050247126, -736979194, 2103044118, 'h2gndqwnqcx5', 'hncprjtu0dz', '9fjgq8n2f', -1056308489, -1454058168, 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', -458359144);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (6, '2000-01-01', 600440952, 1568069663, -1794176801, -1194675273, 279.731401, 630.468925, 309.988616, -902895762, 453.914926, 991.735454, -598313376, 1972233925, 1792827279, 804529642, 457.141778, 410.094566, 426.421073, 617.644523, -1538707438, 774.445116, -163600466, 881.248682, -1826414375, 357330522, -683007527, 'x', -1762140823, 1371234901, -290314193, 'f77pzo72ctd', 't', 'mfg62g0v5q8q', -1488156735, -1858644047, 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', -405743609);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T1.ID) AS REAL) / 12 FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T2.Date) = '1998' AND T1.SEX = 'M';

/*
Gold Result:
(0.08333333333333333,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "laboratory"."id") / 12 FROM "laboratory" INNER JOIN "patient" ON "laboratory"."id" = "patient"."id" WHERE "patient"."sex" = 'M' AND "laboratory"."date" BETWEEN '1998-01-01' AND '1998-12-31';

/*
Prediction Result:
(0,)
*/