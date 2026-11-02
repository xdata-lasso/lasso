-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (499, 'animal', '1986-06-17', '1990-10-21', '1994-03-02', 'capital', 'old');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1126, 'show', '1986-06-18', '1990-10-22', '1994-03-03', 'win', 'finally');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1127, 'machine', '1986-06-19', '1990-10-23', '1994-03-04', 'human', 'themselves');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1128, 'not', '1986-06-20', '1990-10-24', '1994-03-05', 'bar', 'production');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (499, '1998-07-06', 1129, 1133, 1125, 1137, 1141.5, 1145.5, 1149.5, 1153, 1157.5, 1161.5, 1165, 1169, 1173, 1177, 1181.5, 1185.5, 1189.5, 1193.5, 1197, 1201.5, 1205, 1209.5, 1213, 1217, 1221, 'present', 1225, 1229, 1233, 'participant', 'answer', 'figure', 1237, 1241, 'trial', 'long', 'commercial', 'religious', 'result', 'Congress', 'common', 1245);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (499, '1998-07-07', 1136.0, 1142.0, 1125, 1150.0, 1156.5, 1162.5, 1168.5, 1174.0, 1180.5, 1186.5, 1192.0, 1198.0, 1204.0, 1210.0, 1216.5, 1222.5, 1228.5, 1234.5, 1240.0, 1246.5, 1252.0, 1258.5, 1264.0, 1270.0, 1276.0, 'value', 1284.0, 1290.0, 1296.0, 'dark', 'recently', 'base', 1308.0, 1314.0, 'blood', 'prove', 'hospital', 'example', 'raise', 'none', 'maintain', 1334.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (499, '1998-07-08', 1143.0, 1151.0, 1125, 1163.0, 1171.5, 1179.5, 1187.5, 1195.0, 1203.5, 1211.5, 1219.0, 1227.0, 1235.0, 1243.0, 1251.5, 1259.5, 1267.5, 1275.5, 1283.0, 1291.5, 1299.0, 1307.5, 1315.0, 1323.0, 1331.0, 'training', 1343.0, 1351.0, 1359.0, 'sea', 'drive', 'top', 1379.0, 1387.0, 'husband', 'they', 'hear', 'science', 'away', 'shoulder', 'hundred', 1423.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (499, '1998-07-09', 1150.0, 1160.0, 1125, 1176.0, 1186.5, 1196.5, 1206.5, 1216.0, 1226.5, 1236.5, 1246.0, 1256.0, 1266.0, 1276.0, 1286.5, 1296.5, 1306.5, 1316.5, 1326.0, 1336.5, 1346.0, 1356.5, 1366.0, 1376.0, 1386.0, 'high', 1402.0, 1412.0, 1422.0, 'available', 'spring', 'early', 1450.0, 1460.0, 'fall', 'his', 'determine', 'write', 'politics', 'election', 'expect', 1512.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1."First Date" FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.LDH < 500 ORDER BY T2.LDH DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT MIN("First Date") FROM Patient WHERE ID = (SELECT ID FROM Laboratory WHERE LDH < 500 ORDER BY LDH DESC, Laboratory.id NULLS LAST, Laboratory.date NULLS LAST LIMIT 1);

/*
Prediction Result:
(None,)
*/