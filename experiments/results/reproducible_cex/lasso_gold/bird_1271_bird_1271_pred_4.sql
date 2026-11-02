-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1129, 'play', '1974-05-05', '1975-06-06', '1976-07-07', 'agreement', 'option');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1130, 'play', '1974-05-05', '1975-06-06', '1976-07-07', 'agreement', 'option');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1065, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1129, '1988-12-31', 1067, 1069, 1071, 1073, 1075.5, 1077.5, 1079.5, 1081, 1083.5, 1085.5, 1087, 1089, 1091, 1093, 1095.5, 1097.5, 1099.5, 1101.5, 1103, 1105.5, 1107, 1109.5, 1111, 1113, 1115, 'decide', 1117, 1119, 1121, 'rate', 'offer', 'discussion', 1123, 1125, 'perform', 'table', 'according', 'negative', 'sure', 'save', 'grow', 1127);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1065, '1989-01-01', 1074.0, 1078.0, 1082.0, 1086.0, 1090.5, 1094.5, 1098.5, 1102.0, 1106.5, 1110.5, 1114.0, 1118.0, 1122.0, 1126.0, 1130.5, 1134.5, 1138.5, 1142.5, 1146.0, 1150.5, 1154.0, 1158.5, 1162.0, 1166.0, 1170.0, 'sense', 1176.0, 1180.0, 1184.0, 'science', 'kind', 'list', 1194.0, 1198.0, 'fall', 'true', 'song', '0', 'collection', 'knowledge', 'clearly', 1216.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1130, '1988-12-31', 1067, 1069, 1071, 1073, 1075.5, 1077.5, 1079.5, 1081, 1083.5, 1085.5, 1087, 1089, 1091, 1093, 1095.5, 1097.5, 1099.5, 1101.5, 1103, 1105.5, 1107, 1109.5, 1111, 1113, 1115, 'decide', 1117, 1119, 1121, 'rate', 'offer', 'discussion', 1123, 1125, 'perform', 'table', 'according', 'negative', 'sure', 'save', 'grow', 1127);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.SSA IN ('negative', '0') AND STRFTIME('%Y', T2.Date) < '1990';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT Patient.ID) FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.SSA IN ('-', '+-', '0', 'negative') AND STRFTIME('%Y', Patient."First Date") < '2000';

/*
Prediction Result:
(2,)
*/