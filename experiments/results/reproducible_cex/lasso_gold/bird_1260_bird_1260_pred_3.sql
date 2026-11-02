-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1385, 'question', '1963-01-01', '1977-04-14', '1978-05-15', 'low', 'character');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1385, '1979-06-16', 1386, 1387, 1388, 1389, 1390.5, 1391.5, 1392.5, 1393, 1394.5, 1395.5, 1396, 1397, 1398, 1399, 1400.5, 1401.5, 1402.5, 1403.5, 1404, 1405.5, 1406, 1407.5, 1408, 1409, 1410, 'evidence', 1411, 1412, 1413, 'chair', 'employee', 10, 1414, 1415, 'size', 'option', 'nothing', 'everyone', 'skin', 'pattern', 'later', 1416);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1385, '1980-07-17', 1386, 1387, 1388, 1389, 1390.5, 1391.5, 1392.5, 1393, 1394.5, 1395.5, 1396, 1397, 1398, 1399, 1400.5, 1401.5, 1402.5, 1403.5, 1404, 1405.5, 1406, 1407.5, 1408, 1409, 1410, 'evidence', 1411, 1412, 1413, 'chair', 'employee', 10, 1414, 1415, 'size', 'option', 'nothing', 'everyone', 'skin', 'pattern', 'later', 1416);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.RF < 20 AND STRFTIME('%Y', DATE('2025-01-01 00:00:00')) - STRFTIME('%Y', T1.Birthday) > 60;

/*
Gold Result:
(1385,)
(1385,)
*/

-- Prediction Query
SELECT DISTINCT p.ID FROM Patient AS p JOIN Laboratory AS l ON p.ID = l.ID WHERE l.RF < 20 AND CAST((STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', p.Birthday)) AS REAL) > 60;

/*
Prediction Result:
(1385,)
*/