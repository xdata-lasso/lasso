-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1126, 'F', '1968-01-01', '1984-04-15', '1985-05-16', 'throw', 'guy');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1405, 'F', '1968-01-01', '1982-09-19', '1983-10-20', 'claim', 'product');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1126, '1986-06-17', 1127, 1128, 1129, 1130, 1131.5, 1132.5, 1133.5, 1134, 1135.5, 1136.5, 1137, 1138, 1139, 1140, 1141.5, 1142.5, 1143.5, 1144.5, 1145, 15, 1146, 1147.5, 1148, 1149, 1150, 'PM', 1151, 1152, 1153, 'everything', 'surface', 'animal', 1154, 1155, 'show', 'machine', 'not', 'capital', 'win', 'human', 'bar', 1156);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1405, '1984-11-21', 1406, 1407, 1408, 1409, 1410.5, 1411.5, 1412.5, 1413, 1414.5, 1415.5, 1416, 1417, 1418, 1419, 1420.5, 1421.5, 1422.5, 1423.5, 1424, NULL, 1425, 1426.5, 1427, 1428, 1429, 'collection', 1430, 1431, 1432, 'structure', 'response', 'knowledge', 1433, 1434, 'pick', 'attack', 'image', 'I', 'management', 'newspaper', 'enter', 1435);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.PT >= 14 AND T1.SEX = 'F' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) > 55;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN PT >= 14 AND SEX = 'F' THEN 1 ELSE 0 END) * 100.0 / CAST(SUM(CASE WHEN PT >= 14 THEN 1 ELSE 0 END) AS REAL)) AS female_percentage_with_abnormal_PT FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE (STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', Birthday)) > 55;

/*
Prediction Result:
(100.0,)
*/