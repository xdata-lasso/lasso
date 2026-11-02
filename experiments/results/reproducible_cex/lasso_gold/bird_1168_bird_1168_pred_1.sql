-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1001, 'purpose', '1970-01-01', '1974-05-05', '1978-09-09', 'face', 'SJS');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1002, 'brother', '1970-01-02', '1974-05-06', '1978-09-10', 'election', 'SJS');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1003, 'ago', '1970-01-03', '1974-05-07', '1978-09-11', 'dog', 'SJS');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1004, 'site', '1970-01-04', '1974-05-08', '1978-09-12', 'chair', 'SJS');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1001, '1982-02-13', 1005, 1009, 1013, 1017, 1021.5, 1025.5, 1029.5, 1033, 1037.5, 1041.5, 1045, 1049, 1053, 1057, 1061.5, 1065.5, 1069.5, 1073.5, 1077, 1081.5, 1085, 1089.5, 1093, 1097, 1101, 'since', 1105, 1109, 1113, 'wait', 'knowledge', 'discover', 1117, 1121, 'agreement', 'rate', 'list', 'true', 'collection', 'dinner', 'husband', 1125);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1001, '1982-02-14', 1012.0, 1018.0, 1024.0, 1030.0, 1036.5, 1042.5, 1048.5, 1054.0, 1060.5, 1066.5, 1072.0, 1078.0, 1084.0, 1090.0, 1096.5, 1102.5, 1108.5, 1114.5, 1120.0, 1126.5, 1132.0, 1138.5, 1144.0, 1150.0, 1156.0, 'blue', 1164.0, 1170.0, 1176.0, 'offer', 'almost', 'early', 1188.0, 1194.0, 'option', 'science', 'perform', 'according', 'save', 'source', 'bill', 1214.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1001, '1982-02-15', 1019.0, 1027.0, 1035.0, 1043.0, 1051.5, 1059.5, 1067.5, 1075.0, 1083.5, 1091.5, 1099.0, 1107.0, 1115.0, 1123.0, 1131.5, 1139.5, 1147.5, 1155.5, 1163.0, 1171.5, 1179.0, 1187.5, 1195.0, 1203.0, 1211.0, 'require', 1223.0, 1231.0, 1239.0, 'begin', 'all', 'mouth', 1259.0, 1267.0, 'decide', 'kind', 'fall', 'song', 'grow', 'great', 'her', 1303.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1001, '1982-02-16', 1026.0, 1036.0, 1046.0, 1056.0, 1066.5, 1076.5, 1086.5, 1096.0, 1106.5, 1116.5, 1126.0, 1136.0, 1146.0, 1156.0, 1166.5, 1176.5, 1186.5, 1196.5, 1206.0, 1216.5, 1226.0, 1236.5, 1246.0, 1256.0, 1266.0, 'sit', 1282.0, 1292.0, 1302.0, 'performance', 'better', 'play', 1330.0, 1340.0, 'sense', 'discussion', 'table', 'sure', 'clearly', 'best', 'throw', 1392.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Date, STRFTIME('%Y', T2."First Date") - STRFTIME('%Y', T2.Birthday) FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T2.Diagnosis = 'SJS' AND NOT T2.Birthday IS NULL ORDER BY T2.Birthday ASC, T1.id NULLS LAST, T1.date NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('1982-02-13', 8)
*/

-- Prediction Query
SELECT L.Date AS "Laboratory Completion Date", STRFTIME('%Y', P."First Date") - STRFTIME('%Y', P.Birthday) AS "Age of Initial Arrival" FROM Patient AS P INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE P.Diagnosis = 'SJS' ORDER BY P.Birthday ASC, L.Date DESC, P.id NULLS LAST, L.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('1982-02-16', 8)
*/