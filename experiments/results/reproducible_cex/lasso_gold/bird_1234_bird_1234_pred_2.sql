-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1499, 'theory', '1981-04-01', '1982-05-02', '1983-06-03', 'surface', 'food');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1530, 'theory', '1985-08-05', '1986-09-06', '1987-10-07', 'authority', 'soon');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1499, '1984-07-04', 1500, 1501, 1502, 1503, 1504.5, 1505.5, 1506.5, 1507, 1508.5, 1509.5, 1510, 1511, 1512, 1513, 0.0, 1514.5, 1515.5, 1516.5, 1517, 1518.5, 1519, 1520.5, 1521, 1522, 1523, 'education', 1524, 1525, 1526, 'article', 'effect', 'unit', 1527, 1528, 'our', 'your', 'bar', 'bed', 'sign', 'mention', 'team', 1529);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1530, '1988-11-08', 1531, 1532, 1533, 1534, 1535.5, 1536.5, 1537.5, 1538, 1539.5, 1540.5, 1541, 1542, 1543, 1544, 0.0, 1545.5, 1546.5, 1547.5, 1548, 1549.5, 1550, 1551.5, 1552, 1553, 1554, 'no', 1555, 1556, 1557, 'space', 'car', 'career', 1558, 1559, 'receive', 'may', 'often', 'company', 'evidence', 'news', 'turn', 1560);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T1.SEX, T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.WBC <= 3.5 OR T2.WBC >= 9.0 GROUP BY T1.SEX, T1.ID ORDER BY T1.Birthday ASC, T1.ID NULLS LAST, T1.SEX NULLS LAST;

/*
Gold Result:
(1499, 'theory', '1981-04-01')
(1530, 'theory', '1985-08-05')
*/

-- Prediction Query
SELECT "patient"."id", "patient"."sex", "patient"."birthday" FROM "patient" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" WHERE "laboratory"."wbc" <= 3.5 OR "laboratory"."wbc" >= 9.0 GROUP BY "patient"."sex" ORDER BY "patient"."birthday" ASC, "patient"."id" NULLS LAST, "patient"."sex" NULLS LAST;

/*
Prediction Result:
(1499, 'theory', '1981-04-01')
*/