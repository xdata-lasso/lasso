-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1075, 'according', '1980-11-11', '1981-01-12', '1982-02-13', 'song', 'sure');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1148, 'PM', '1985-05-16', '1986-06-17', '1987-07-18', 'everything', 'surface');
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1075, '1983-03-14', 1076.5, 1077.5, 1078, 'collection', 1079, 'save', 'knowledge', 'grow', 'fall', 'clearly', 1080);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1075, '1988-08-19', 1112.5, 1113.5, 1114, 'animal', 1115, 'show', 'machine', 'not', 'capital', 'win', 1116);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1075, '1984-04-15', 1081, 1082, 1083, 1084, 1085.5, 1086.5, 1087.5, 1088, 1089.5, 1090.5, 1091, 1092, 1093, 1094, 1095.5, 1096.5, 1097.5, 1098.5, 1099, 1100.5, 1101, 1102.5, 1103, 1104, 1105, 'dinner', 1106, 1107, 1108, 'source', 'great', 'blue', 1109, 1110, 'best', 'husband', 'bill', 'her', 'negative', 'throw', 'guy', 1111);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1075, '1989-09-20', 1117, 1118, 1119, 1120, 1121.5, 1122.5, 1123.5, 1124, 1125.5, 1126.5, 1127, 1128, 1129, 1130, 1131.5, 1132.5, 1133.5, 1134.5, 1135, 1136.5, 1137, 1138.5, 1139, 1140, 1141, 'human', 1142, 1143, 1144, 'bar', 'old', 'finally', 1145, 1146, 'themselves', 'production', 'present', 'value', 'negative', 'training', 'high', 1147);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Examination AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.SSB = 'negative' OR '0' AND NOT T1.Symptoms IS NULL;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) AS symptom_count FROM Examination AS E INNER JOIN Laboratory AS L ON E.ID = L.ID WHERE L.SSB IN ('negative', '0') AND NOT E.Symptoms IS NULL;

/*
Prediction Result:
(4,)
*/