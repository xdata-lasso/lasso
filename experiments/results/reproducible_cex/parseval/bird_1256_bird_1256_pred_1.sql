-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2024-06-15', '2022-04-27', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'value', '2024-06-15', NULL, '2024-06-15', 'value', 'value');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'value', '2024-06-15', NULL, '2024-06-15', 'value', 'value');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, 'value', '2024-06-15', NULL, '2024-06-15', 'value', 'value');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 'value', '2024-06-15', NULL, '2024-06-15', 'value', 'value');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (6, 'value', '2024-06-15', NULL, '2024-06-15', 'value', 'value');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (7, 'value', '2024-06-15', NULL, '2024-06-15', 'value', 'value');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (8, 'value', '2024-06-15', NULL, '2024-06-15', 'value', 'value');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-23', 1465859724, -1349201381, 1019800248, -1910425938, 303.05704, 125.12763, 22.535764, 429706943, 240.969194, 267.815776, 462974032, -1137908826, -918961358, -1602639011, 489.397796, 933.422701, 345.718563, 510.466242, 1151980946, 83.204633, 1620389964, 627.258639, 947159877, 1990080517, 1408123494, '4', 374105386, 1274489983, -1683203397, '+', 'e376nium52', 'zbuo4nrqrof', 373262291, -472966518, 's5bbp02e', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2023-01-20', -1362461264, -904834265, -346339240, 1692174491, 495.297639, 261.217059, 447.109657, 2056419640, 551.785129, 263.638479, 556727997, 1178000634, 1836127587, -1529584866, 755.698226, 778.537349, 712.084197, 452.27611, -283454505, 390.34832, 233994589, 367.405851, 1442655647, -87647544, -629784617, 'v', 1581736075, -261132974, -1264842910, 'wnqcx', '5hncprjtu0d', '79fjgq8', -1255130038, -1762857309, 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 1746373317);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2025-06-17', -1437333179, -921145356, 1258409369, -1981402255, 292.730571, 572.766956, 206.939346, 1610062532, 475.173408, 935.695299, 809183447, 89267185, -1865039888, 1160656988, 268.82475, 710.998147, 945.642658, 795.366812, 1219478689, 718.397869, -1670923962, 663.049759, 906324270, 1908028688, 2122220075, 'p6luhvdlttil', 429706943, 462974032, -1137908826, '+', 'siie5unw6k', 'fa9', 1620389964, 546571701, '0t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 1178636309);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2021-12-23', -305670381, -1525670226, -453362185, 481163439, 313.384575, 994.345214, 920.013763, 364869063, 278.010437, 433.533777, -1097120355, 244829661, -1362461264, -904834265, 419.361606, 470.165282, 384.969231, 893.990071, -1025564911, 447.109657, 2056419640, 551.785129, 556727997, 1178000634, 1836127587, 'f8jegd2', 1675430660, -688509700, -792092619, '+', 'j4hwbdvlph', 'gndqwnqc', 555413010, 722884590, 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', 1255343543);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '2020-03-27', 602161869, 1350414441, 2094425101, -961217731, 86.816079, 60.297953, 680.944245, 61479715, 130.468488, 151.555666, -2115841792, 1746373317, 1360271423, 1583472758, 837.437794, 272.414976, 155.818582, 917.457483, 1074760385, 763.019095, 1250290042, 100.07927, -1696173285, 710458518, 678047687, '3ay', -598313376, 1972233925, 1792827279, '+', '4301jh3den8', 'c68x8vacx7', 1523825314, 2078438287, '5w1of7', 'pzo72ctdc', 'mfg62', '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 1582582341);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (6, '2023-05-24', 1467355421, -1171104889, -29242208, 1691780814, 464.719657, 952.850618, 900.959264, -2072838897, 166.297151, 91.430825, -1173368267, 382831862, -406331049, -461418236, 703.87087, 774.592762, 390.871884, 837.309049, -604098478, 790.772456, -57705450, 286.870177, -2005628382, 1721638020, 983324983, 'ztdg', -20116244, -176606723, -15162884, '+', 'pim5', '58q', 1817366143, 1615073310, '7p2r94gth2m', 'ajjl', '3', 'okv8uttmu2', 'e578', 'fvy', '7zzbe8y', -705922211);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (7, '2023-09-24', 318331233, -233617564, 79330142, 1735561423, 927.310086, 676.067095, 762.654945, 782684333, 476.006677, 658.696966, 319284352, 1164790775, -200807520, -790819470, 202.422113, 995.150295, 273.34105, 234.434389, -609553675, 730.273808, -55494714, 110.207708, 234957614, 823835795, -354292049, 'a9n0jxfofws', 1719800120, -210159774, 270415200, '+', 'b', 'q0k32od', -613916489, 2061558815, '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 1557188093);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (8, '2024-02-18', -1552469358, 7342822, -1034034171, 1244279905, 680.281941, 174.811686, 595.972666, 727608179, 886.204918, 606.178753, -628433041, 1044710644, 966412849, -2061634386, 301.874779, 602.319566, 134.404723, 216.656268, -457901285, 555.680342, -2140923099, 770.531988, -841516418, 152478847, -625404808, 'um', 989306270, 1147652228, 1378873397, '+', 'u6bd0w9603', 'vzxw1rxe9y', -1046720861, 643589729, 'h55y', 'dohvu06d', 'a35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', -2080232972);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.CRP = '-' OR T2.CRP = '+-' OR T2.CRP < 1.0) AND T1.Description IS NULL;

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT L.ID) FROM Laboratory AS L JOIN Patient AS P ON L.ID = P.ID WHERE L.CRP = '+' AND P.Description IS NULL;

/*
Prediction Result:
(5,)
*/