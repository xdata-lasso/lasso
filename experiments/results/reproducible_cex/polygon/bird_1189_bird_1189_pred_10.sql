-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (20, '1000-01-24', 24, -5, 25, 'S', 26, 'S27', 'S28', 'S29', 'S30', 'S31', 2);
INSERT INTO "Examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (21, '1000-02-02', 33, NULL, 34, 'S', 35, 'S36', 'S37', 'S38', 'S39', 'S40', 2);
INSERT INTO "Patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (20, 'S57', '1000-02-28', '1000-03-01', '1000-03-02', 'S61', 'S62');
INSERT INTO "Patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (21, 'S63', '1000-03-06', '1000-03-07', '1000-03-08', 'S67', NULL);
INSERT INTO "Laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (20, '0001-01-01', -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, -5992687993564613340, 'S', -5992687993564613340, -5992687993564613340, -5992687993564613340, 'S', 'S', 'S', -5992687993564613340, -5992687993564613340, 'S', 'S', 'S', 'S', 'S', 'S', 'S', -5992687993564613340);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM Examination WHERE Thrombosis = 2 AND "ANA Pattern" = 'S' AND "aCL IgM" > (SELECT AVG("aCL IgM") * 1.2 FROM Examination WHERE Thrombosis = 2 AND "ANA Pattern" = 'S');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "examination"."id") FROM "examination" INNER JOIN "patient" ON "examination"."id" = "patient"."id" WHERE "examination"."thrombosis" = 2 AND "examination"."ana pattern" = 'S' AND "examination"."acl igm" > (SELECT AVG("acl igm") * 1.2 FROM "examination");

/*
Prediction Result:
(1,)
*/