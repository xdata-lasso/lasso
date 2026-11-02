-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1001, 'purpose', '1970-01-01', '1974-05-05', '1978-09-09', 'face', 'since');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1002, 'brother', '1970-01-02', '1974-05-06', '1978-09-10', 'election', 'blue');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1003, 'ago', '1970-01-03', '1974-05-07', '1978-09-11', 'dog', 'require');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1004, 'site', '1970-01-04', '1974-05-08', '1978-09-12', 'chair', 'sit');
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1001, '1982-02-13', 1005.5, 1009.5, 1013, 'wait', 1017, 'knowledge', 'discover', 'agreement', 'rate', 'list', 1021);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1001, '1982-02-14', 1012.5, 1018.5, 1024.0, 'offer', 1032.0, 'almost', 'early', 'option', 'science', 'perform', 1048.0);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1001, '1982-02-15', 1019.5, 1027.5, 1035.0, 'begin', 1047.0, 'all', 'mouth', 'decide', 'kind', 'fall', 1075.0);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1001, '1982-02-16', 1026.5, 1036.5, 1046.0, 'performance', 1062.0, 'better', 'play', 'sense', 'discussion', 'table', 1102.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1001, '1986-06-17', 1025, 1029, 1033, 1037, 1041.5, 1045.5, 1049.5, 1053, 1057.5, 1061.5, 1065, 1069, 1073, 1077, 1081.5, 1085.5, 1089.5, 52.0, 1093, 1097.5, 1101, 1105.5, 1109, 1113, 1117, 'true', 1121, 1125, 1129, 'collection', 'dinner', 'husband', 1133, 1137, 'guy', 'animal', 'capital', 'old', 'present', 'participant', 'answer', 1141);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1001, '1986-06-18', 1032.0, 1038.0, 1044.0, 1050.0, 1056.5, 1062.5, 1068.5, 1074.0, 1080.5, 1086.5, 1092.0, 1098.0, 1104.0, 1110.0, 1116.5, 1122.5, 1128.5, 52.0, 1136.0, 1142.5, 1148.0, 1154.5, 1160.0, 1166.0, 1172.0, 'according', 1180.0, 1186.0, 1192.0, 'save', 'source', 'bill', 1204.0, 1210.0, 'PM', 'show', 'win', 'finally', 'value', 'dark', 'recently', 1230.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1001, '1986-06-19', 1039.0, 1047.0, 1055.0, 1063.0, 1071.5, 1079.5, 1087.5, 1095.0, 1103.5, 1111.5, 1119.0, 1127.0, 1135.0, 1143.0, 1151.5, 1159.5, 1167.5, 52.0, 1179.0, 1187.5, 1195.0, 1203.5, 1211.0, 1219.0, 1227.0, 'song', 1239.0, 1247.0, 1255.0, 'grow', 'great', 'her', 1275.0, 1283.0, 'everything', 'machine', 'human', 'themselves', 'training', 'sea', 'drive', 1319.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1001, '1986-06-20', 1046.0, 1056.0, 1066.0, 1076.0, 1086.5, 1096.5, 1106.5, 1116.0, 1126.5, 1136.5, 1146.0, 1156.0, 1166.0, 1176.0, 1186.5, 1196.5, 1206.5, 52.0, 1222.0, 1232.5, 1242.0, 1252.5, 1262.0, 1272.0, 1282.0, 'sure', 1298.0, 1308.0, 1318.0, 'clearly', 'best', 'throw', 1346.0, 1356.0, 'surface', 'not', 'bar', 'production', 'high', 'available', 'spring', 1408.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID INNER JOIN Laboratory AS T3 ON T1.ID = T3.ID WHERE (T3.HCT >= 52 OR T3.HCT <= 29) ORDER BY T2."aCL IgA" DESC, T1.ID NULLS LAST LIMIT 1;

/*
Gold Result:
(1001,)
*/

-- Prediction Query
SELECT E.ID FROM Examination AS E INNER JOIN Patient AS P ON E.ID = P.ID INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE (L.ALB < 29 AND L.ALB > 52) OR (L.ALB IS NULL) GROUP BY E.ID ORDER BY MAX(E."aCL IgA") DESC, E.ID NULLS LAST LIMIT 1;

/*
Prediction Result:
*/