-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (16, 'guy', '1986-06-17', '1990-10-21', '1994-03-02', 'animal', 'SLE');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1126, 'PM', '1986-06-18', '1990-10-22', '1994-03-03', 'show', 'SLE');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1127, 'everything', '1986-06-19', '1990-10-23', '1994-03-04', 'machine', 'SLE');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1128, 'surface', '1986-06-20', '1990-10-24', '1994-03-05', 'not', 'SLE');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (16, '1998-07-06', 1129, 1133, 1137, 1141, 1145.5, 1149.5, 1153.5, 1157, 1161.5, 1165.5, 1169, 1173, 1177, 1181, 1185.5, 1189.5, 1125, 1193.5, 1197, 1201.5, 1205, 1209.5, 1213, 1217, 1221, 'capital', 1225, 1229, 1233, 'old', 'present', 'participant', 1237, 1241, 'answer', 'figure', 'trial', 'long', 'commercial', 'religious', 'result', 1245);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (16, '1998-07-07', 1136.0, 1142.0, 1148.0, 1154.0, 1160.5, 1166.5, 1172.5, 1178.0, 1184.5, 1190.5, 1196.0, 1202.0, 1208.0, 1214.0, 1220.5, 1226.5, 1125, 1234.5, 1240.0, 1246.5, 1252.0, 1258.5, 1264.0, 1270.0, 1276.0, 'win', 1284.0, 1290.0, 1296.0, 'finally', 'value', 'dark', 1308.0, 1314.0, 'recently', 'base', 'blood', 'prove', 'hospital', 'example', 'raise', 1334.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (16, '1998-07-08', 1143.0, 1151.0, 1159.0, 1167.0, 1175.5, 1183.5, 1191.5, 1199.0, 1207.5, 1215.5, 1223.0, 1231.0, 1239.0, 1247.0, 1255.5, 1263.5, 1125, 1275.5, 1283.0, 1291.5, 1299.0, 1307.5, 1315.0, 1323.0, 1331.0, 'human', 1343.0, 1351.0, 1359.0, 'themselves', 'training', 'sea', 1379.0, 1387.0, 'drive', 'top', 'husband', 'they', 'hear', 'science', 'away', 1423.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (16, '1998-07-09', 1150.0, 1160.0, 1170.0, 1180.0, 1190.5, 1200.5, 1210.5, 1220.0, 1230.5, 1240.5, 1250.0, 1260.0, 1270.0, 1280.0, 1290.5, 1300.5, 1125, 1316.5, 1326.0, 1336.5, 1346.0, 1356.5, 1366.0, 1376.0, 1386.0, 'bar', 1402.0, 1412.0, 1422.0, 'production', 'high', 'available', 1450.0, 1460.0, 'spring', 'early', 'fall', 'his', 'determine', 'write', 'politics', 1512.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID, T1.SEX FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Diagnosis = 'SLE' AND T2.HGB > 10 AND T2.HGB < 17 ORDER BY T1.Birthday ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.ID, T1.SEX FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Diagnosis = 'SLE' AND 10 < T2.HGB < 17 ORDER BY T1.Birthday ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Prediction Result:
(16, 'guy')
*/