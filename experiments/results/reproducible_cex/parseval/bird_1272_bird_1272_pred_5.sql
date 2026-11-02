-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2024-06-15', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, '9rljsl0b4', '2024-04-25', '2022-09-10', '2024-06-15', 'qi2rkf9v', 'x58pz');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483647, 'f8jegd2', '2024-11-12', '2023-10-23', '1970-01-01', '9uxj4hw', 'd');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'lph2gn', '2020-08-28', '2022-11-09', '2023-11-15', 'qcx5', 'hncprjtu0dz');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483644, 'okv8uttm', '2023-07-29', '2025-01-03', '1970-01-02', 'e578', 'fvy');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483643, '7zzbe8y', '2023-10-06', '2021-10-24', '1970-01-02', 'v42q7sx58b4p', 'aus3');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483642, 'u', '2023-10-12', '2022-04-09', '1970-01-01', 'rpd', 'wzw');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, 'value', '2024-06-15', '2024-06-15', NULL, 'value', 'value');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (5, 'qb0tbindz39t', '2020-01-07', '2021-09-14', '2024-06-01', 'td8n5wcgu', 'bc3t');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (6, 'value', '2024-06-15', '2024-06-15', NULL, 'value', 'value');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 1644814318, 1465859724, -1349201381, 1019800248, 334.878198, 55.194297, 303.05704, -1610064545, 22.535764, 600.048938, 462974032, -1137908826, -918961358, -1602639011, 489.397796, 933.422701, 345.718563, 510.466242, 1151980946, 83.204633, 1620389964, 627.258639, 947159877, 1990080517, 1408123494, '4', 374105386, 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, 'liqa1', 'ryytoo3', '9hl7', 'A', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2024-06-15', -1748371085, -1742081330, 894242932, -211209314, 456.127515, 52.895335, 632.477228, -1056308489, 406.816852, 108.525871, -1454058168, -2078052421, -512640349, 1038566008, 615.222139, 203.331848, 507.498259, 34.258887, -1672720816, 92.94508, -1520489792, 346.706184, -1388029300, -566887085, 602161869, 'xa', 1294666887, -515895469, 1427161052, 'z16ni', 'jai', 'dh5ogrgj', -458359144, 600440952, 'f', 'og', 'itsj3', 'A', 'y', 'p1q430', 'jh3den8', 195720193);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '1970-01-02', 1774087382, 1732258051, -1762140823, 1371234901, 354.593207, 432.405958, 850.85096, 76996700, 398.637058, 689.065203, 1992637800, -820614248, 481546706, -1784554553, 806.601275, 443.518915, 415.494881, 337.342177, -1021978385, 632.482455, -1139855872, 432.865904, 1897687032, -241848752, 2004147439, 'tjpttg', -2033879835, 1798111945, 944975670, 'i36c4bf', 'foa', 'cd07z2zezjo7', 304189298, -542502665, 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', 'A', '58q', 's27p2r94gth2', 'najj', -1351793914);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '2025-06-18', -2013213247, 101754718, 628082526, -1245584612, 903.226183, 364.404955, 228.613802, -634585028, 900.422166, 55.294573, -210159774, 270415200, -2071531094, -397848196, 983.253685, 651.034963, 414.603421, 457.250518, 575038073, 229.650617, -613916489, 979.99406, 895277769, 364043263, -1177989415, 'wyn', 1953495465, -1960313034, 681061317, 'iz', 'k1', 'yoeyo6l0hdt6', 1435223075, 1617348603, 'yxuzk', '5', '1gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', 1044710644);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (5, '2020-08-27', 1964331395, -1943814113, 1514371324, -379749892, 594.051247, 329.082644, 754.799388, -541917667, 433.981179, 276.103112, 2012400150, -505019168, 1968783602, 125495479, 167.639352, 878.981937, 572.830427, 702.028088, -246257698, 111.965818, -516345261, 48.647907, -1191116453, 1709667347, -1934709172, '3', 1595632888, 2072023304, 789756515, '18ri', 'hy08ftp6', 'wt', -1051623642, 2013745856, 'b', 'mzn2mfx', 'h33p6sto1', '0', 'j', 'sh5knzys7', 'y', -531932574);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (6, '2025-06-17', -1437333179, -921145356, 1258409369, -1981402255, 292.730571, 572.766956, 206.939346, 1610062532, 475.173408, 935.695299, 809183447, 89267185, -1865039888, 1160656988, 268.82475, 710.998147, 945.642658, 795.366812, 1219478689, 718.397869, -1670923962, 663.049759, 906324270, 1908028688, 2122220075, 'p6luhvdlttil', 429706943, 462974032, -1137908826, 'siie5unw6k', 'fa9', '00t5c4e', 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '0', '2eutliqa11r', 'ytoo3o9', 'l7', 1178636309);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE NOT T1."First Date" IS NULL AND NOT T2.SSA IN ('negative', '0') ORDER BY T1."First Date" ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT p.id FROM patient AS p INNER JOIN laboratory AS l ON p.id = l.id WHERE NOT l.ssa IN ('negative', '0') ORDER BY p."First Date" ASC, p.id NULLS LAST, l.id NULLS LAST, l.date NULLS LAST LIMIT 1;

/*
Prediction Result:
(4,)
*/