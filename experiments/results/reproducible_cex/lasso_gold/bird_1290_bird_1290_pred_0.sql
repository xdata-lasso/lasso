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
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1001, '1982-02-13', 1005, 1009, 1013, 1017, 1021.5, 3.5, 1025.5, 1029, 1033.5, 1037.5, 1041, 1045, 1049, 1053, 1057.5, 1061.5, 1065.5, 1069.5, 1073, 1077.5, 1081, 1085.5, 1089, 1093, 1097, 'wait', 1101, 1105, 1109, 'knowledge', 'discover', 'agreement', 1113, 1117, 'rate', 'list', 'true', 'collection', 'dinner', 'husband', 'guy', 1121);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1001, '1982-02-14', 1012.0, 1018.0, 1024.0, 1030.0, 1036.5, 3.5, 1044.5, 1050.0, 1056.5, 1062.5, 1068.0, 1074.0, 1080.0, 1086.0, 1092.5, 1098.5, 1104.5, 1110.5, 1116.0, 1122.5, 1128.0, 1134.5, 1140.0, 1146.0, 1152.0, 'offer', 1160.0, 1166.0, 1172.0, 'almost', 'early', 'option', 1184.0, 1190.0, 'science', 'perform', 'according', 'save', 'source', 'bill', 'PM', 1210.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1001, '1982-02-15', 1019.0, 1027.0, 1035.0, 1043.0, 1051.5, 3.5, 1063.5, 1071.0, 1079.5, 1087.5, 1095.0, 1103.0, 1111.0, 1119.0, 1127.5, 1135.5, 1143.5, 1151.5, 1159.0, 1167.5, 1175.0, 1183.5, 1191.0, 1199.0, 1207.0, 'begin', 1219.0, 1227.0, 1235.0, 'all', 'mouth', 'decide', 1255.0, 1263.0, 'kind', 'fall', 'song', 'grow', 'great', 'her', 'everything', 1299.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1001, '1982-02-16', 1026.0, 1036.0, 1046.0, 1056.0, 1066.5, 3.5, 1082.5, 1092.0, 1102.5, 1112.5, 1122.0, 1132.0, 1142.0, 1152.0, 1162.5, 1172.5, 1182.5, 1192.5, 1202.0, 1212.5, 1222.0, 1232.5, 1242.0, 1252.0, 1262.0, 'performance', 1278.0, 1288.0, 1298.0, 'better', 'play', 'sense', 1326.0, 1336.0, 'discussion', 'table', 'sure', 'clearly', 'best', 'throw', 'surface', 1388.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Date FROM Laboratory WHERE ALB BETWEEN 3.5 AND 5.5 ORDER BY ALB DESC, Laboratory.id NULLS LAST, Laboratory.date NULLS LAST LIMIT 1;

/*
Gold Result:
('1982-02-13',)
*/

-- Prediction Query
SELECT Date FROM Laboratory WHERE ALB = (SELECT MAX(ALB) FROM Laboratory WHERE ALB > 3.5 AND ALB < 5.5);

/*
Prediction Result:
*/