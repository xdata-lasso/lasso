-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1385, 'none', '1979-09-05', '1995-11-09', '1972-06-15', 'expect', 'reveal');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1769, 'per', '1984-07-04', '1985-04-11', '1991-10-17', 'second', 'give');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1385, '1978-01-21', 1391, 1397, 1403, 1409, 1415.5, 1421.5, 1427.5, 1433, 1439.5, 1445.5, 1451, 1457, 1463, 1469, 1475.5, 1481.5, 1487.5, 1493.5, 1499, 1505.5, 1511, 1517.5, 1523, 1529, 1535, 'drop', 1541, 1547, 1553, 'executive', 'under', 'individual', 1559, 1565, 'evidence', 'everyone', 'inside', 'someone', 'collection', 'image', 'activity', 1571);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1385, '1973-03-22', 1583, 1589, 1595, 1601, 1607.5, 1613.5, 1619.5, 1625, 1631.5, 1637.5, 1643, 1649, 1655, 1661, 1667.5, 1673.5, 1679.5, 1685.5, 1691, 1697.5, 1703, 1709.5, 1715, 1721, 1727, 'while', 1733, 1739, 1745, 'purpose', 'start', 'game', 1751, 1757, 'theory', 'your', 'authority', 'receive', 'policy', 'forget', 'live', 1763);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1769, '1997-05-23', 1775, 1781, 1787, 1793, 1799.5, 1805.5, 1811.5, 1817, 1823.5, 1829.5, 1835, 1841, 1847, 1853, 1859.5, 1865.5, 1871.5, 1877.5, 1883, 1889.5, 1895, 1901.5, 1907, 1913, 1919, 'cause', 1925, 1931, 1937, 'material', 'bill', 'treat', 1943, 1949, 'ask', 'boy', 'enjoy', 'total', 'administration', 'compare', 'able', 1955);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE NOT T2.SM IN ('negative', '0') ORDER BY T1.Birthday DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 3;

/*
Gold Result:
(1769,)
(1385,)
(1385,)
*/

-- Prediction Query
SELECT DISTINCT p.ID FROM Patient AS p JOIN Laboratory AS l ON p.ID = l.ID WHERE NOT l.SM IN ('negative', '0') ORDER BY p.Birthday DESC, p.ID NULLS LAST LIMIT 3;

/*
Prediction Result:
(1769,)
(1385,)
*/