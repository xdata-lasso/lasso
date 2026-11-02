-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1001, 'purpose', '1970-01-01', '1971-02-02', '1972-03-03', 'brother', 'ago');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1001, '1996-01-02', 1003, 1005, 1007, 1009, 1011.5, 1013.5, 1015.5, 1017, 1019.5, 1021.5, 1023, 1025, 1027, 1029, 1031.5, 1033.5, 1035.5, 1037.5, 1039, 1041.5, 1043, 1045.5, 1047, 1049, 1051, 'site', 1053, 1055, 1057, 'election', 'chair', 'blue', 1059, 1061, 'sit', 'offer', 'negative', 'performance', 'almost', 'better', 'early', 1063);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1001, '1996-01-03', 1010.0, 1014.0, 1018.0, 1022.0, 1026.5, 1030.5, 1034.5, 1038.0, 1042.5, 1046.5, 1050.0, 1054.0, 1058.0, 1062.0, 1066.5, 1070.5, 1074.5, 1078.5, 1082.0, 1086.5, 1090.0, 1094.5, 1098.0, 1102.0, 1106.0, 'face', 1112.0, 1116.0, 1120.0, 'dog', 'since', 'require', 1130.0, 1134.0, 'wait', 'begin', '0', 'knowledge', 'all', 'discover', 'mouth', 1152.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.SC170 IN ('negative', '0') AND T2.Date > 1997 - 01 - 01;

/*
Gold Result:
(1001,)
(1001,)
*/

-- Prediction Query
SELECT P.ID FROM Examination AS E INNER JOIN Patient AS P ON E.ID = P.ID INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE E."Examination Date" > '1997-01-01' AND L."SC170" IN ('negative', '0');

/*
Prediction Result:
*/