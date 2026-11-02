-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1001, 'purpose', '1970-01-01', '1976-07-07', '1982-02-13', 'dog', 'wait');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1002, 'brother', '1970-01-02', '1976-07-08', '1982-02-14', 'chair', 'offer');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1003, 'ago', '1970-01-03', '1976-07-09', '1982-02-15', 'since', 'begin');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1004, 'site', '1970-01-04', '1976-07-10', '1982-02-16', 'blue', 'performance');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1005, 'face', '1970-01-05', '1976-07-11', '1982-02-17', 'require', 'knowledge');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1006, 'election', '1970-01-06', '1976-07-12', '1982-02-18', 'sit', 'almost');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1001, '1988-08-19', 1007, 1013, 1019, 1025, 1031.5, 1037.5, 1043.5, 1049, 1055.5, 1061.5, 1067, 1073, 1079, 1085, 1091.5, 1097.5, 1103.5, 1109.5, 1115, 1121.5, 1127, 1133.5, 1139, 1145, 1151, 'all', 1157, 1163, 1169, 'agreement', 'kind', 'true', 1175, 1181, 'grow', 'husband', 'everything', 'capital', 'themselves', 'participant', 'drive', 1187);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1002, '1988-08-20', 1014.0, 1022.0, 1030.0, 1038.0, 1046.5, 1054.5, 1062.5, 1070.0, 1078.5, 1086.5, 1094.0, 1102.0, 1110.0, 1118.0, 1126.5, 1134.5, 1142.5, 1150.5, 1158.0, 1166.5, 1174.0, 1182.5, 1190.0, 1198.0, 1206.0, 'better', 1216.0, 1224.0, 1232.0, 'option', 'discussion', 'according', 1246.0, 1254.0, 'clearly', 'bill', 'surface', 'win', 'production', 'dark', 'spring', 1276.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1003, '1988-08-21', 1021.0, 1031.0, 1041.0, 1051.0, 1061.5, 1071.5, 1081.5, 1091.0, 1101.5, 1111.5, 1121.0, 1131.0, 1141.0, 1151.0, 1161.5, 1171.5, 1181.5, 1191.5, 1201.0, 1211.5, 1221.0, 1231.5, 1241.0, 1251.0, 1261.0, 'discover', 1275.0, 1285.0, 1295.0, 'decide', 'list', 'song', 1317.0, 1327.0, 'dinner', 'her', 'animal', 'human', 'present', 'sea', 'figure', 1365.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1004, '1988-08-22', 1028.0, 1040.0, 1052.0, 1064.0, 1076.5, 1088.5, 1100.5, 1112.0, 1124.5, 1136.5, 1148.0, 1160.0, 1172.0, 1184.0, 1196.5, 1208.5, 1220.5, 1232.5, 1244.0, 1256.5, 1268.0, 1280.5, 1292.0, 1304.0, 1316.0, 'early', 1334.0, 1346.0, 1358.0, 'sense', 'perform', 'sure', 1388.0, 1400.0, 'source', 'throw', 'show', 'bar', 'value', 'available', 'base', 1454.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1005, '1988-08-23', 1035.0, 1049.0, 1063.0, 1077.0, 1091.5, 1105.5, 1119.5, 1133.0, 1147.5, 1161.5, 1175.0, 1189.0, 1203.0, 1217.0, 1231.5, 1245.5, 1259.5, 1273.5, 1287.0, 1301.5, 1315.0, 1329.5, 1343.0, 1357.0, 1371.0, 'mouth', 1393.0, 1407.0, 1421.0, 'rate', 'fall', 'collection', 1459.0, 1473.0, 'great', 'guy', 'machine', 'old', 'training', 'answer', 'top', 1543.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1006, '1988-08-24', 1042.0, 1058.0, 1074.0, 1090.0, 1106.5, 1122.5, 1138.5, 1154.0, 1170.5, 1186.5, 1202.0, 1218.0, 1234.0, 1250.0, 1266.5, 1282.5, 1298.5, 1314.5, 1330.0, 1346.5, 1362.0, 1378.5, 1394.0, 1410.0, 1426.0, 'play', 1452.0, 1468.0, 1484.0, 'science', 'table', 'save', 1530.0, 1546.0, 'best', 'PM', 'not', 'finally', 'high', 'recently', 'trial', 1632.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE NOT T2.SM IN ('negative', '0') ORDER BY T1.Birthday DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 3;

/*
Gold Result:
(1006,)
(1005,)
(1004,)
*/

-- Prediction Query
SELECT DISTINCT t2.id FROM laboratory AS t1 INNER JOIN patient AS t2 ON t1.id = t2.id WHERE NOT t1.sm IN ('negative', '0') ORDER BY t2.birthday ASC, t2.id NULLS LAST LIMIT 3;

/*
Prediction Result:
(1001,)
(1002,)
(1003,)
*/