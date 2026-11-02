-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1158, 'figure', '1994-03-02', '1995-04-03', '1996-05-04', 'base', 'top');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1189, 'religious', '1998-07-06', '1970-08-07', '1971-09-08', 'example', 'science');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1158, '1997-06-05', 1159, 1160, 1161, 1162, 1163.5, 1164.5, 1165.5, 1166, 1167.5, 1168.5, 1169, 1170, 1171, 1172, 0.0, 1173.5, 1174.5, 1175.5, 1176, 1177.5, 1178, 1179.5, 1180, 1181, 1182, 'early', 1183, 1184, 1185, 'trial', 'blood', 'long', 1186, 1187, 'prove', 'they', 'his', 'commercial', 'hospital', 'hear', 'determine', 1188);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1189, '1972-10-09', 1190, 1191, 1192, 1193, 1194.5, 1195.5, 1196.5, 1197, 1198.5, 1199.5, 1200, 1201, 1202, 1203, -3.5, 1204.5, 1205.5, 1206.5, 1207, 1208.5, 1209, 1210.5, 1211, 1212, 1213, 'write', 1214, 1215, 1216, 'result', 'raise', 'away', 1217, 1218, 'politics', 'Congress', 'none', 'shoulder', 'election', 'common', 'maintain', 1219);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T1.SEX, T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.WBC <= 3.5 OR T2.WBC >= 9.0 GROUP BY T1.SEX, T1.ID ORDER BY T1.Birthday ASC, T1.ID NULLS LAST, T1.SEX NULLS LAST;

/*
Gold Result:
(1158, 'figure', '1994-03-02')
(1189, 'religious', '1998-07-06')
*/

-- Prediction Query
SELECT P.ID, P.SEX, P.Birthday FROM Patient AS P INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE L.WBC <= 3.5 OR L.WBC >= 9.0 GROUP BY P.SEX ORDER BY CAST(STRFTIME('%Y', '2025-01-01 00:00:00') AS INTEGER) - CAST(STRFTIME('%Y', P.Birthday) AS INTEGER), P.ID NULLS LAST, P.SEX NULLS LAST, P.Birthday NULLS LAST;

/*
Prediction Result:
(1189, 'religious', '1998-07-06')
(1158, 'figure', '1994-03-02')
*/