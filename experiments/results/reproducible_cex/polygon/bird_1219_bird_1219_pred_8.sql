-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (53, '1000-02-23', 53, 53, 53, 'M53', 53, 'M53', 'M53', 'M53', 'M53', 'M53', 53);
INSERT INTO "Examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (53, '1000-02-23', 53, 53, 53, 'M53', 53, 'M53', 'M53', 'M53', 'M53', 'M53', 53);
INSERT INTO "Patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (53, 'F', '1000-03-01', '1000-03-02', '1000-03-03', 'F62', 'M63');
INSERT INTO "Patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (54, 'M53', '1000-02-23', '1000-02-23', '1000-02-23', 'M53', 'M53');
INSERT INTO "Laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (53, '0998-01-10', NULL, 65, NULL, NULL, 68, 69, 6, 70, NULL, 72, 73, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 90, 91, NULL, 'M93', 'F94', NULL, NULL, 'M97', NULL, NULL, NULL, NULL, 'F102', NULL, 104);
INSERT INTO "Laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (53, '1001-02-09', 118, 119, 120, 121, 122, 123, -61, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 'F142', 143, 144, 145, 'F146', 'M147', 'F148', 149, 150, 'M151', 'F152', 'M153', 'F154', 'M155', 'F156', 'M157', 158);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.UA) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.UA > 6.5 AND T1.SEX = 'F') OR (T2.UA > 8.0 AND T1.SEX = 'M') AND T2.Date = (SELECT MAX(Date) FROM Laboratory);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(l.UA) AS average_UA_index FROM (SELECT ID, MAX(Date) AS latest_date FROM Laboratory GROUP BY ID) AS latest_exams JOIN Laboratory AS l ON latest_exams.ID = l.ID AND latest_exams.latest_date = l.Date JOIN Patient AS p ON l.ID = p.ID WHERE (p.SEX = 'M' AND l.UA < 8.0) OR (p.SEX = 'F' AND l.UA < 6.5);

/*
Prediction Result:
(-61.0,)
*/