-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, '5k5swwqcgs', '2024-06-15', '2021-12-04', '2022-04-27', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'hsrwbbp', '2024-06-15', '2025-08-22', '2022-01-31', 'hvdltt', 'lbn');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 'rmdp', '2022-07-21', '2023-03-17', '2021-06-28', 'e5u', 'w6kl');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483645, 'f8jegd2', '1970-01-02', '2024-11-12', '2023-10-23', '9uxj4hw', 'd');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (0, 'lph2gn', '2020-08-28', '2022-11-09', '2023-11-15', 'qcx5', 'hncprjtu0dz');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483643, 'okv8uttm', '1970-01-02', '2023-07-29', '2025-01-03', 'e578', 'fvy');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483642, 'ri2hy08ft', '1970-01-01', '2022-09-10', '2025-09-01', 'wt', 'xxnja');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483641, 'bymzn2mfx7h3', '1970-01-01', '2025-02-01', '2022-09-22', '6sto1cj8sh5k', 'zys7');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', 1620389964, 546571701, 947159877, 1990080517, 827.854302, 983.124993, 828.555322, -1964997180, 734.586266, 767.720387, -1833165707, 1155439218, 1313172851, -761141909, 779.28645, 566.030342, 452.706544, 672.826911, -747753377, 478.908865, 902887186, 979.158161, -967741825, 775304493, 373262291, 'p5s5bbp', 882961052, 743312762, -1822992503, 'liqa1', 'ryytoo3', '9hl7', 1178636309, -1390245819, 'C', 'x14ji7zwau2d', 'yrq13p', 'u78d99r', 'jsl', 'b4yp5qi', 'rkf9vqx5', 1836127587);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-02', -1748371085, -1742081330, 894242932, -211209314, 456.127515, 52.895335, 632.477228, -1056308489, 406.816852, 108.525871, -1454058168, -2078052421, -512640349, 1038566008, 615.222139, 203.331848, 507.498259, 34.258887, -1672720816, 92.94508, -1520489792, 346.706184, -1388029300, -566887085, 602161869, 'xa', 1294666887, -515895469, 1427161052, 'z16ni', 'jai', 'dh5ogrgj', -458359144, 600440952, 'A', 'f', 'og', 'itsj3', 'y', 'p1q430', 'jh3den8', 195720193);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1970-01-01', 1774087382, 1732258051, -1762140823, 1371234901, 354.593207, 432.405958, 850.85096, 76996700, 398.637058, 689.065203, 1992637800, -820614248, 481546706, -1784554553, 806.601275, 443.518915, 415.494881, 337.342177, -1021978385, 632.482455, -1139855872, 432.865904, 1897687032, -241848752, 2004147439, 'tjpttg', -2033879835, 1798111945, 944975670, 'i36c4bf', 'foa', 'cd07z2zezjo7', 304189298, -542502665, 'A', 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 's27p2r94gth2', 'najj', -1351793914);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (0, '1970-01-01', -451030047, -2052653308, -489120589, -72442907, 258.625847, 783.973422, 282.68858, -2060082151, 710.005534, 238.668607, 1849819405, -929383517, -2090240067, -699574669, 160.717227, 564.003268, 641.973572, 49.701386, 1105964624, 401.500141, -663234145, 31.262264, 101754718, 628082526, -1245584612, 'xfo', -1793230843, -441521858, 2015094998, '2zobb0q0k32o', 'w', 'l', 895277769, 364043263, '!', 'sorlwyngc1', 'j', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', '521gwnlas6e', 1468640756);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '1969-12-31', 1048147204, -1814875250, -647898186, -1610380698, 393.510383, 862.561101, 627.816635, -1552469358, 515.131026, 501.709636, -1034034171, 1244279905, -1396673167, 412199481, 749.652116, 746.02004, 311.245446, 924.170456, 727608179, 886.204918, 456034296, 353.681528, 1044710644, 966412849, -2061634386, 'bindz', 2085299664, 2038321753, 1376887048, 'td8n5wcgu', 'bc3t', 'u', -1943814113, 1514371324, 'A', '603vzxw1r', 'e9yfk7', 'k162n', '55', '3dohvu0', 'dza35rmki', -1160642134);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.RNP <> '-' OR '+-' ORDER BY T1.Birthday DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
('2022-07-21',)
*/

-- Prediction Query
SELECT Birthday FROM Patient WHERE ID = (SELECT ID FROM Laboratory WHERE NOT RNP IN ('-', '+-') ORDER BY Date DESC, Laboratory.id NULLS LAST LIMIT 1) ORDER BY Birthday ASC, Patient.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('2022-07-21',)
*/