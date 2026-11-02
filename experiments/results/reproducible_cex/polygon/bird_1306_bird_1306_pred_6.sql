-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (65, '1000-06-13', NULL, 165, NULL, NULL, 168, 'SLE169', 'SLE170', 'SLE171', 'SLE172', 'SLE173', 174);
INSERT INTO "Examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (65, '1000-06-25', 176, 177, 178, 'SLE179', NULL, 'SLE181', 'SLE182', 'SLE183', 'SLE184', 'SLE185', 186);
INSERT INTO "Patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (65, 'SLE158', '1000-06-09', '1000-06-10', '1000-06-11', 'SLE162', 'SLE');
INSERT INTO "Patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (64, 'SLE65', '1000-03-07', '1000-03-07', '1000-03-07', 'SLE65', 'SLE65');
INSERT INTO "Laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (65, '1000-03-09', 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 9, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 'SLE96', 97, 98, 99, 'SLE100', 'SLE101', 'SLE102', 103, 104, 'SLE105', 'SLE106', 'SLE107', 'SLE108', 'SLE109', 'SLE110', 'SLE111', 112);
INSERT INTO "Laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (65, '1000-03-08', 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 4, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 'SLE137', 138, 139, 140, 'SLE141', 'SLE142', 'SLE143', 144, 145, 'SLE146', 'SLE147', 'SLE148', 'SLE149', 'SLE150', 'SLE151', 'SLE152', 153);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Diagnosis = 'SLE' AND T2.WBC BETWEEN 3.5 AND 9;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "patient"."id") FROM "patient" INNER JOIN "examination" ON "patient"."id" = "examination"."id" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" WHERE "patient"."diagnosis" = 'SLE' AND "laboratory"."wbc" BETWEEN 3.5 AND 9.0;

/*
Prediction Result:
(1,)
*/