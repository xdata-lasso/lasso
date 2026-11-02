-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1253, 'claim', '1989-05-03', '1993-09-07', '1997-02-11', 'response', 'image');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1254, 'product', '1989-05-04', '1993-09-08', '1997-02-12', 'knowledge', 'I');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1255, 'collection', '1989-05-05', '1993-09-09', '1997-02-13', 'pick', 'management');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1256, 'structure', '1989-05-06', '1993-09-10', '1997-02-14', 'attack', 'newspaper');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1253, '1972-06-15', 1257, 1261, 1265, 1269, 1273.5, 1277.5, 1281.5, 1285, 1289.5, 1293.5, 1297, 1301, 1305, 180, 1309.5, 1313.5, 1317.5, 1321.5, 1325, 1329.5, 1333, 1337.5, 1341, 1345, 1349, 'enter', 1353, 1357, 1361, 'activity', 'value', 'specific', 1365, 1369, 'finally', 'about', 'everyone', 'movement', 'process', 'politics', 'notice', 1373);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1253, '1972-06-16', 1264.0, 1270.0, 1276.0, 1282.0, 1288.5, 1294.5, 1300.5, 1306.0, 1312.5, 1318.5, 1324.0, 1330.0, 1336.0, 180, 1344.5, 1350.5, 1356.5, 1362.5, 1368.0, 1374.5, 1380.0, 1386.5, 1392.0, 1398.0, 1404.0, 'on', 1412.0, 1418.0, 1424.0, 'set', 'not', 'put', 1436.0, 1442.0, 'learn', 'seven', 'month', 'while', 'fire', 'decide', 'start', 1462.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1253, '1972-06-17', 1271.0, 1279.0, 1287.0, 1295.0, 1303.5, 1311.5, 1319.5, 1327.0, 1335.5, 1343.5, 1351.0, 1359.0, 1367.0, 180, 1379.5, 1387.5, 1395.5, 1403.5, 1411.0, 1419.5, 1427.0, 1435.5, 1443.0, 1451.0, 1459.0, 'traditional', 1471.0, 1479.0, 1487.0, 'building', 'social', 'grow', 1507.0, 1515.0, 'coach', 'type', 'sound', 'born', 'thought', 'hour', 'win', 1551.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1253, '1972-06-18', 1278.0, 1288.0, 1298.0, 1308.0, 1318.5, 1328.5, 1338.5, 1348.0, 1358.5, 1368.5, 1378.0, 1388.0, 1398.0, 180, 1414.5, 1424.5, 1434.5, 1444.5, 1454.0, 1464.5, 1474.0, 1484.5, 1494.0, 1504.0, 1514.0, 'yes', 1530.0, 1540.0, 1550.0, 'rest', 'example', 'brother', 1578.0, 1588.0, 'long', 'serve', 'could', 'truth', 'purpose', 'color', 'nice', 1640.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GLU > 180 ORDER BY T1.Birthday ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT MIN("patient"."birthday") FROM "patient" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" WHERE "laboratory"."glu" > 180;

/*
Prediction Result:
(None,)
*/