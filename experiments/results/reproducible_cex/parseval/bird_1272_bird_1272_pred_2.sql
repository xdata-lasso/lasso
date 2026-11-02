-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2024-06-15', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, '9rljsl0b4', '2024-04-25', '2022-09-10', '1969-12-31', 'qi2rkf9v', 'x58pz');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483647, 'f8jegd2', '2024-11-12', '2023-10-23', '1970-01-01', '9uxj4hw', 'd');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-1, 'lph2gn', '2020-08-28', '2022-11-09', '2023-11-15', 'qcx5', 'hncprjtu0dz');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483644, 'okv8uttm', '2023-07-29', '2025-01-03', '1970-01-01', 'e578', 'fvy');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483643, '7zzbe8y', '2023-10-06', '2021-10-24', '1970-01-02', 'v42q7sx58b4p', 'aus3');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (0, 'u', '2023-10-12', '2022-04-09', '2021-10-20', 'rpdjwzw5ch', '9mo7');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483641, 'ta8y3a17v4', '2024-04-26', '2021-01-29', '1970-01-01', 'mayq3qdpua', '96rn');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'value', '2024-06-15', '2024-06-15', NULL, 'value', 'value');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 1644814318, 1465859724, -1349201381, 1019800248, 334.878198, 55.194297, 303.05704, -1610064545, 22.535764, 600.048938, 462974032, -1137908826, -918961358, -1602639011, 489.397796, 933.422701, 345.718563, 510.466242, 1151980946, 83.204633, 1620389964, 627.258639, 947159877, 1990080517, 1408123494, '4', 374105386, 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, 'liqa1', 'ryytoo3', '9hl7', 'A', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1969-12-31', -1748371085, -1742081330, 894242932, -211209314, 456.127515, 52.895335, 632.477228, -1056308489, 406.816852, 108.525871, -1454058168, -2078052421, -512640349, 1038566008, 615.222139, 203.331848, 507.498259, 34.258887, -1672720816, 92.94508, -1520489792, 346.706184, -1388029300, -566887085, 602161869, 'xa', 1294666887, -515895469, 1427161052, 'z16ni', 'jai', 'dh5ogrgj', -458359144, 600440952, 'f', 'og', 'itsj3', 'A', 'y', 'p1q430', 'jh3den8', 195720193);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (-1, '1970-01-01', 1774087382, 1732258051, -1762140823, 1371234901, 354.593207, 432.405958, 850.85096, 76996700, 398.637058, 689.065203, 1992637800, -820614248, 481546706, -1784554553, 806.601275, 443.518915, 415.494881, 337.342177, -1021978385, 632.482455, -1139855872, 432.865904, 1897687032, -241848752, 2004147439, 'tjpttg', -2033879835, 1798111945, 944975670, 'i36c4bf', 'foa', 'cd07z2zezjo7', 304189298, -542502665, 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', 'A', '58q', 's27p2r94gth2', 'najj', -1351793914);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-01', -354292049, 238533676, -1514700303, -1796351243, 82.48091, 296.34381, 397.200175, 2015094998, 778.650393, 735.315617, -1197954156, -2019656607, 375841374, -1449226553, 661.866863, 978.147884, 447.557622, 57.929422, 440115543, 622.950834, 292557306, 665.099697, -984562992, -605061107, -1689155697, 'dj9erhi', 1056589776, -499913447, -360096930, 't', 'fuqyxuzkb', '521gwnlas6e', 1468640756, 1048147204, 'eowi', '1z5', 'xih6', 'A', '2q2xlyoto', '9oaawg', '6aqb0tbin', -1897615568);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-02', 2085299664, 2038321753, 1376887048, 261633665, 49.319338, 206.468438, 674.193177, 1148916014, 36.996954, 314.953709, 989306270, 1147652228, 1378873397, 1964331395, 506.209886, 17.397119, 47.420505, 790.320515, 1514371324, 843.769504, -379749892, 594.051247, -541917667, -961629819, 2012400150, '9yfk7qk162n', -516345261, -1191116453, 1709667347, '06dza3', 'rmkio18r', 'i2hy08ftp6', -1853955201, -805997097, 'xnjaby', 'mzn2mfx7h3', 'p6sto1cj', 'A', 'sh5knzys7', 'y', 'yd1jmgjach8', 973811121);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2023-05-27', 1139012231, -951706262, -1324935647, -648564084, 133.593276, 520.723549, 794.50432, -1260548409, 828.220682, 570.042362, -1104749933, 379651188, -592014051, 1744849810, 840.039966, 964.892941, 260.74675, 107.568093, -1391541536, 321.654734, -1025517017, 554.543791, 1374676344, 238243966, -788896327, 'q1q', -796609690, -1459013972, -1670335771, '8hlst1p', 'qomiztvb6m', 'iz78aqql', -753065777, 190510318, 'tb8r9114qbre', '6bjeuuwsj8k', 'h85', 'pxlvri', 'surz0kaqtncg', 'c8s3b7v88k', 'dmdbdh', 313797011);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE NOT T1."First Date" IS NULL AND NOT T2.SSA IN ('negative', '0') ORDER BY T1."First Date" ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE NOT T2.SSA IN ('-', '+-') ORDER BY T1."First Date", T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/