-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1032, 'M', '1978-09-09', '1975-06-06', '1976-07-07', 'offer', 'begin');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1063, 'M', '1979-10-10', '1975-06-06', '1976-07-07', 'offer', 'begin');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1032, '1977-08-08', 1033, 1034, 1035, 1036, 1037.5, 1038.5, 1039.5, 1040, 1041.5, 1042.5, 250, 1043, 1044, 1045, 1046.5, 1047.5, 1048.5, 1049.5, 1050, 1051.5, 1052, 1053.5, 1054, 1055, 1056, 'performance', 1057, 1058, 1059, 'knowledge', 'almost', 'all', 1060, 1061, 'better', 'discover', 'early', 'mouth', 'play', 'agreement', 'option', 1062);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1063, '1977-08-08', 1033, 1034, 1035, 1036, 1037.5, 1038.5, 1039.5, 1040, 1041.5, 1042.5, 250, 1043, 1044, 1045, 1046.5, 1047.5, 1048.5, 1049.5, 1050, 1051.5, 1052, 1053.5, 1054, 1055, 1056, 'performance', 1057, 1058, 1059, 'knowledge', 'almost', 'all', 1060, 1061, 'better', 'discover', 'early', 'mouth', 'play', 'agreement', 'option', 1062);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday)) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2."T-CHO" >= 250 AND T1.SEX = 'M';

/*
Gold Result:
(46.5,)
*/

-- Prediction Query
SELECT SUM(STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', "patient"."birthday")) / COUNT("patient"."id") FROM "patient" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" WHERE "patient"."sex" = 'M' AND "laboratory"."t-cho" >= 250;

/*
Prediction Result:
(46,)
*/