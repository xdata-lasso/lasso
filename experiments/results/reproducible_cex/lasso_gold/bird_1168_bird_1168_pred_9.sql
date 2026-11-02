-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1513, 'seven', '1976-10-19', '1980-03-23', '1984-07-04', 'sound', 'SJS_z');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1514, 'type', '1976-10-20', '1980-03-24', '1984-07-05', 'could', 'SJS_z');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1515, 'serve', '1976-10-21', '1980-03-25', '1984-07-06', 'movement', 'SJS_z');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1516, 'month', '1976-10-22', '1980-03-26', '1984-07-07', 'while', 'SJS_z');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1513, '1988-11-08', 1517, 1521, 1525, 1529, 1533.5, 1537.5, 1541.5, 1545, 1549.5, 1553.5, 1557, 1561, 1565, 1569, 1573.5, 1577.5, 1581.5, 1585.5, 1589, 1593.5, 1597, 1601.5, 1605, 1609, 1613, 'born', 1617, 1621, 1625, 'thought', 'hour', 'win', 1629, 1633, 'place', 'woman', 'surface', 'effect', 'bed', 'authority', 'car', 1637);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1513, '1988-11-09', 1524.0, 1530.0, 1536.0, 1542.0, 1548.5, 1554.5, 1560.5, 1566.0, 1572.5, 1578.5, 1584.0, 1590.0, 1596.0, 1602.0, 1608.5, 1614.5, 1620.5, 1626.5, 1632.0, 1638.5, 1644.0, 1650.5, 1656.0, 1662.0, 1668.0, 'truth', 1676.0, 1682.0, 1688.0, 'purpose', 'color', 'nice', 1700.0, 1706.0, 'game', 'him', 'food', 'our', 'sign', 'soon', 'career', 1726.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1513, '1988-11-10', 1531.0, 1539.0, 1547.0, 1555.0, 1563.5, 1571.5, 1579.5, 1587.0, 1595.5, 1603.5, 1611.0, 1619.0, 1627.0, 1635.0, 1643.5, 1651.5, 1659.5, 1667.5, 1675.0, 1683.5, 1691.0, 1699.5, 1707.0, 1715.0, 1723.0, 'process', 1735.0, 1743.0, 1751.0, 'politics', 'notice', 'why', 1771.0, 1779.0, 'middle', 'unit', 'education', 'your', 'mention', 'no', 'receive', 1815.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1513, '1988-11-11', 1538.0, 1548.0, 1558.0, 1568.0, 1578.5, 1588.5, 1598.5, 1608.0, 1618.5, 1628.5, 1638.0, 1648.0, 1658.0, 1668.0, 1678.5, 1688.5, 1698.5, 1708.5, 1718.0, 1728.5, 1738.0, 1748.5, 1758.0, 1768.0, 1778.0, 'fire', 1794.0, 1804.0, 1814.0, 'decide', 'start', 'a', 1842.0, 1852.0, 'after', 'theory', 'article', 'bar', 'team', 'space', 'may', 1904.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Date, STRFTIME('%Y', T2."First Date") - STRFTIME('%Y', T2.Birthday) FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T2.Diagnosis = 'SJS' AND NOT T2.Birthday IS NULL ORDER BY T2.Birthday ASC, T1.id NULLS LAST, T1.date NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Date, STRFTIME('%Y', T2."First Date") - STRFTIME('%Y', T2.Birthday) FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T2.Diagnosis LIKE '%SJS%' ORDER BY T2.Birthday, T1.id NULLS LAST, T1.date NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('1988-11-08', 8)
*/