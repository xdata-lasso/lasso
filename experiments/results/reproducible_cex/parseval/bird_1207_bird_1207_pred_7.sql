-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 't1__138418', '2024-06-15', '2025-06-17', '2021-11-08', 'swwqcgsk', '9n8c4pgu7v');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483647, 't1__138418', '2024-06-15', '2020-03-04', '2023-07-07', '2dwyrq13pyu7', 'd99rljsl0');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 't1__138418', '2024-06-15', '2020-04-20', '2025-04-09', 'p5qi2rk', '9v');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'x58pz', '2024-08-06', '2020-12-28', '2021-08-12', 'gd', '1vy9uxj4');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, 't1__675891', '2024-06-15', '2022-01-03', '2025-07-25', 'amsorlwyng', '1');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 't1__675891', '2024-06-15', '2020-07-19', '2021-08-21', '9erhizgk1yoe', 'o6l0hdt');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (6, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (7, 'yp5qi2rk', '2021-01-15', '2023-10-06', '2022-12-15', 'x58pz0f8je', 'd2');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1994-01-01', 59, -1865039888, 1160656988, -992890117, 710.998147, 945.642658, 795.366812, 1219478689, 718.397869, 324.940703, -1670923962, 700293388, 906324270, 1908028688, 994.117864, 749.826493, 503.083789, 320.851235, -1659388584, 855.355181, -1377057208, 304.02808, -1364429300, -1257178728, 1236688122, 'dpos', -1576219117, -1823627488, -1209887326, 'klfa9000t', 'c4ecigce', '76nium52', -443340271, 757448742, '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -453362185);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '1994-01-01', 59, -1612443122, -2050247126, -736979194, 989.653112, 705.754562, 117.631729, 1298861365, 58.749749, 958.414393, -664193365, -1070063173, 555413010, 722884590, 635.267184, 210.05299, 866.804244, 269.734861, -841004020, 415.830002, 401805964, 154.065416, -1255130038, -1762857309, 806170397, 'qv0gcb98ozk', -155284187, 1686459626, -1554531873, 'yrkn6vck6ah0', '8j', 'wwlq7', 1255343543, -541746689, '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', -598313376);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2005-03-31', 59, 1972233925, 1792827279, 804529642, 457.141778, 410.094566, 426.421073, -1538707438, 774.445116, 461.908795, -1826414375, 357330522, -683007527, 2035306060, 735.057703, 369.761299, 854.793228, 983.924121, -47052816, 650.242697, 765724008, 528.552305, -1099855564, 87529806, -1957268147, 'c', 1303877941, -1284905200, 7929158, '0v', 'q8qdjpe1', 'o22', 2004147439, -691774480, 'ptt', '6b', 'ou5z', '36c', 'bfkfoacd', '7z2zezj', '7wgx', -57705450);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', -915385605, -2005628382, 1721638020, 983324983, 906.680956, 795.583622, 698.769833, -870767087, 104.37745, 703.796681, -1609653472, -1405314653, 1816660482, -1212676731, 893.960343, 197.278049, 167.377262, 492.8451, -1125548818, 848.622384, -95808609, 306.477948, -244633520, 418247369, -1524425594, 'a3o', -1428186898, -761353513, 362376128, 'mu2ne578lf', 'yz7zzb', '8y', -705922211, 1043710187, '42q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', 'a9n0jxfofws', 'do2zobb', 'q0k32od', -613916489);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '1994-01-01', 59, -795975227, 1294064538, 778835680, 908.792879, 852.508842, 793.946774, 450555855, 451.913941, 107.446882, -1250380401, 1718516876, -2076274980, 1731324803, 230.129952, 129.891173, 437.428969, 493.031806, -564679000, 118.293148, -251205568, 446.264042, 287256667, 1614799674, 1083479253, '9oaawg', 1044710644, 966412849, -2061634386, 'bindz', '9tajz9td', 'n5wcgumbc', 1295379066, 1071401016, 'w9603vz', 'xw1rxe9yfk7', 'k162n', '55', '3dohvu0', 'dza35rmki', '18ri', 1510892261);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '1994-02-24', 59, 1677948887, 389700824, -1853955201, 312.339174, 363.494801, 887.535529, -1485875026, 779.614625, 15.658016, 462225708, 1528227252, -1277305894, -1659775598, 453.840746, 909.594191, 243.029734, 875.955861, -891525031, 231.292236, -1971560508, 835.790392, 1728926031, -63214972, 1106724223, 'ys7dyyd1jmg', 729543907, -2108844113, 973811121, 'ta8y3a17v4', 'ygmayq3qdpu', 'p', -845136979, -1042976410, 'm5', 'wlic7dn2np', '90xdmsqt', 'el', 'u', 'qb9i9f2ccu', 'jq1', 1584429327);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (6, '1994-01-01', 60, 700293388, 906324270, 1908028688, 994.117864, 749.826493, 503.083789, -1659388584, 855.355181, 179.378884, -841692980, -1364429300, -1257178728, 1236688122, 986.066566, 666.330692, 46.9162, 776.327423, 907682809, 227.766936, 2026480202, 133.007885, -1823627488, -1209887326, -1399556171, 'a9000t5c4eci', 1149850321, -1833165707, 1155439218, 'um5', 'zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (7, '2044-08-31', 60, 1675430660, -688509700, -792092619, 585.18838, 152.494591, 124.573829, -2050247126, 328.40866, 989.653112, -1642259219, 1298861365, 1968874827, -664193365, 250.856497, 629.317167, 668.309685, 635.267184, -1245312912, 866.804244, -988981234, 304.188492, -361507387, 401805964, -1485777725, '8n2f3', 806170397, 513454646, -688216274, 'gcb98ozk3z', 'i', 'yrk', 32204797, -1672720816, '8j', 'wwlq7', 'xb72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', '8', -458359144);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.SEX, T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GOT < 60 AND STRFTIME('%Y', T2.Date) = '1994';

/*
Gold Result:
('t1__138418', '2024-06-15')
('x58pz', '2024-08-06')
('t1__675891', '2024-06-15')
*/

-- Prediction Query
SELECT T1.SEX, T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GOT < 60 AND STRFTIME('%Y', T2.Date) = '1994';

/*
Prediction Result:
('t1__138418', '2024-06-15')
('x58pz', '2024-08-06')
('t1__675891', '2024-06-15')
('t1__675891', '2024-06-15')
*/