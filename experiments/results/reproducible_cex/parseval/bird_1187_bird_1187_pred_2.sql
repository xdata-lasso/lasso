-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483648, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483647, 'f', '2021-02-13', '2022-06-27', '2021-03-06', 'itsj3', 'y');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483646, 'cmr0oz', '2023-05-02', '2020-07-20', '2021-03-03', '5i3', 'q5l');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483645, 'rhizgk1yoey', '2022-07-24', '2025-10-08', '2022-02-04', 'hdt6fuq', 'xuzkb52');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-2147483648, '1987-07-06', 700293388, 31, 906324270, 1908028688, 994.117864, 3.99, 749.826493, 13244799, 320.851235, 113.643485, 1526238907, -1377057208, -841692980, -1364429300, 998.421621, 207.290264, 787.938887, 986.066566, 907682809, 227.766936, 2026480202, 133.007885, -1823627488, -1209887326, -1399556171, 'a9000t5c4eci', 1149850321, -1833165707, 1155439218, 'um5', 'zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-2147483648, '1996-02-01', 1649269347, 31, -1116181514, 1255852738, 137.842122, 3.99, 272.94048, -705985602, 604.643336, 829.94159, 537874887, -461695645, 836513442, 176555546, 75.31458, 913.624896, 97.626408, 48.958826, 1675430660, 339.69384, -792092619, 585.18838, -1492524358, -1612443122, -2050247126, 'lph2gn', 1968874827, -664193365, -1070063173, 'x5hncprjtu0', 'z', '9fjgq8n2f', -1056308489, -1454058168, 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', -458359144);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-2147483647, '1987-07-06', -598313376, 30, 1972233925, 1792827279, 632.340892, 3.99, 687.319156, -1538707438, 774.445116, 461.908795, -1826414375, 357330522, -683007527, 2035306060, 735.057703, 369.761299, 854.793228, 983.924121, -47052816, 650.242697, 765724008, 528.552305, -1099855564, 87529806, -1957268147, 'c', 1303877941, -1284905200, 7929158, '0v', 'q8qdjpe1', 'o22', 2004147439, -691774480, 'ptt', '6b', 'ou5z', '36c', 'bfkfoacd', '7z2zezj', '7wgx', -57705450);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-2147483646, '1987-07-06', 1339733032, 31, -1556979799, -55240145, 821.273487, 4.0, 545.449043, 1817366143, 876.038555, 628.658254, 1055237066, 988954859, -1719383707, 1273687251, 577.602934, 193.695314, 770.686956, 625.532672, -2136247961, 155.873695, -2096405521, 588.850908, 1803796945, 872694102, 618058035, '2ne578', 1908593332, 697257217, -451030047, 'be8yvkv42q7', 'x58b4', 'pmaus3auvmkr', 609771851, -1934017803, 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', 211603887);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-2147483645, '1987-07-06', -277407746, 31, -670154354, -2140468103, 509.069144, 3.99, 609.392845, 1468640756, 744.040787, 228.334858, -1814875250, -647898186, -1610380698, -457369423, 862.561101, 627.816635, 138.537557, 515.131026, 7342822, 259.245161, 1244279905, 680.281941, -1396673167, 412199481, 727608179, 'awg96aqb0tbi', 503053726, -1897615568, 2085299664, 'j', '9td8n5w', 'g', -794767771, 989306270, 'tdu6bd0w96', '3vzxw1r', 'e9yfk7', 'k162n', '55', '3dohvu0', 'dza35rmki', -1160642134);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT ID FROM Laboratory WHERE Date BETWEEN '1987-07-06' AND '1996-01-31' AND GPT > 30 AND ALB < 4;

/*
Gold Result:
(-2147483648,)
(-2147483645,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Laboratory WHERE Date BETWEEN '1987-07-06' AND '1996-01-31' AND GPT > 30 AND ALB < 4;

/*
Prediction Result:
(2,)
*/