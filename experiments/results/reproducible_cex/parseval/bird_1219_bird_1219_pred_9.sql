-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'F', '2025-06-17', '2021-11-08', '2025-06-13', 'wwqcg', 'k9n8c');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'pgu7vfe4', '2021-05-05', '2023-01-06', '2021-07-04', 'a2ypuzhsrwbb', 'p6luhvdlttil');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 'F', '2025-06-26', '2022-08-22', '2024-05-26', 'f8jegd2', 'vy9uxj4');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (4, 'M', '2024-09-24', '2022-11-12', '2025-04-30', '01jh3den', 'c68x8vacx');

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2024-06-15', 429706943, 462974032, -1137908826, -918961358, 126.856521, 489.397796, 9.0, 1861536320, 345.718563, 510.466242, 1151980946, 1620389964, 546571701, 947159877, 963.351729, 827.854302, 983.124993, 828.555322, -1964997180, 734.586266, 1149850321, 44.682291, -1833165707, 1155439218, 1313172851, 'm52zbu', -1179823637, 1119186446, 781505063, 'rofqyp5s5b', 'p', '02eutliqa11r', 2137741668, -525979501, 'oo3o9hl72kl', 'x1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 556727997);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-06-15', -1612443122, -2050247126, -736979194, 2103044118, 705.754562, 117.631729, 9.0, 1298861365, 58.749749, 958.414393, -664193365, -1070063173, 555413010, 722884590, 635.267184, 210.05299, 866.804244, 269.734861, -841004020, 415.830002, 401805964, 154.065416, -1255130038, -1762857309, 806170397, 'qv0gcb98ozk', -155284187, 1686459626, -1554531873, 'yrkn6vck6ah0', '8j', 'wwlq7', 1255343543, -541746689, '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', -598313376);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (4, '2025-10-14', 1523825314, 2078438287, -47052816, 645287482, 222.511261, 678.284012, 528.552305, -1099855564, 224.624401, 985.639995, 87529806, -1957268147, -1928431425, 1303877941, 695.452114, 200.834692, 102.360106, 501.846153, -1744557630, 935.463334, 820970595, 537.702873, 1421303999, -1488156735, -1858644047, 'o22', 2004147439, -691774480, -1523347137, 'ttg6bnou5zi3', 'c4bfkfoac', '0', 76987628, -253138337, 'zj', '7wgx', '5', 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 1817366143);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.UA) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.UA > 6.5 AND T1.SEX = 'F') OR (T2.UA > 8.0 AND T1.SEX = 'M') AND T2.Date = (SELECT MAX(Date) FROM Laboratory);

/*
Gold Result:
(268.7761525,)
*/

-- Prediction Query
SELECT AVG(T1.UA) FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T1.Date = (SELECT MAX(Date) FROM Laboratory WHERE ID = T1.ID) AND (T2.SEX = 'M' AND T1.UA < 8.0 OR T2.SEX = 'F' AND T1.UA < 6.5);

/*
Prediction Result:
(None,)
*/