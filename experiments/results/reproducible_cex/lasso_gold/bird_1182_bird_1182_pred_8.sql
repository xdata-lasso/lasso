-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1033, 'offer', '1972-03-03', '1973-04-04', '1991-06-13', 'begin', 'SJS');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1065, 'decide', '1974-05-05', '1975-06-06', '1991-06-13', 'sense', 'SJS');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1033, '1995-01-01', 1034, 1035, 1036, 1037, 1038.5, 1039.5, 1040.5, 1041, 1042.5, 1043.5, 1044, 1045, 1046, 1047, 1048.5, 1049.5, 1050.5, 1051.5, 1052, 1053.5, 1054, 1055.5, 1056, 1057, 1058, 'performance', 1059, 1060, 1061, 'knowledge', 'almost', 'all', 1062, 1063, 'better', 'discover', 'early', 'mouth', 'play', 'agreement', 'option', 1064);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1065, '1995-01-01', NULL, 1067, 1068, 1069, 1070.5, 1071.5, 1072.5, 1073, 1074.5, 1075.5, 1076, 1077, 1078, 1079, 1080.5, 1081.5, 1082.5, 1083.5, 1084, 1085.5, 1086, 1087.5, 1088, 1089, 1090, 'rate', 1091, 1092, 1093, 'science', 'kind', 'discussion', 1094, 1095, 'list', 'perform', 'fall', 'table', 'true', 'according', 'song', 1096);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM Laboratory WHERE ID = (SELECT ID FROM Patient WHERE "First Date" = '1991-06-13' AND Diagnosis = 'SJS') AND STRFTIME('%Y', Date) = '1995';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(ID) FROM Laboratory WHERE ID IN (SELECT ID FROM Patient WHERE "First Date" = '1991-06-13' AND Diagnosis = 'SJS') AND "Date" LIKE '1995%';

/*
Prediction Result:
(2,)
*/