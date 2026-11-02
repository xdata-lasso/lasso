-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1502, 'hour', '1992-04-12', '1996-08-16', '1971-01-20', 'live', 'SLE');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1503, 'left', '1992-04-13', '1996-08-17', '1971-01-21', 'camera', 'SLE');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1504, 'we', '1992-04-14', '1996-08-18', '1971-01-22', 'end', 'SLE');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1505, 'nation', '1992-04-15', '1996-08-19', '1971-01-23', 'down', 'SLE');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1502, '1975-05-01', 1506, 1510, 1514, 1518, 1522.5, 1526.5, 1530.5, 1534, 1538.5, 1542.5, 1546, 1550, 1554, 1558, 1562.5, 1566.5, 17, 1570.5, 1574, 1578.5, 1582, 1586.5, 1590, 1594, 1598, 'attack', 1602, 1606, 1610, 'once', 'avoid', 'drop', 1614, 1618, 'trade', 'family', 'notice', 'us', 'eight', 'customer', 'lawyer', 1622);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1502, '1975-05-02', 1513.0, 1519.0, 1525.0, 1531.0, 1537.5, 1543.5, 1549.5, 1555.0, 1561.5, 1567.5, 1573.0, 1579.0, 1585.0, 1591.0, 1597.5, 1603.5, 17, 1611.5, 1617.0, 1623.5, 1629.0, 1635.5, 1641.0, 1647.0, 1653.0, 'ground', 1661.0, 1667.0, 1673.0, 'drug', 'second', 'author', 1685.0, 1691.0, 'give', 'relationship', 'cause', 'own', 'still', 'between', 'health', 1711.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1502, '1975-05-03', 1520.0, 1528.0, 1536.0, 1544.0, 1552.5, 1560.5, 1568.5, 1576.0, 1584.5, 1592.5, 1600.0, 1608.0, 1616.0, 1624.0, 1632.5, 1640.5, 17, 1652.5, 1660.0, 1668.5, 1676.0, 1684.5, 1692.0, 1700.0, 1708.0, 'against', 1720.0, 1728.0, 1736.0, 'discussion', 'program', 'western', 1756.0, 1764.0, 'my', 'mention', 'several', 'part', 'surface', 'bill', 'land', 1800.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1502, '1975-05-04', 1527.0, 1537.0, 1547.0, 1557.0, 1567.5, 1577.5, 1587.5, 1597.0, 1607.5, 1617.5, 1627.0, 1637.0, 1647.0, 1657.0, 1667.5, 1677.5, 17, 1693.5, 1703.0, 1713.5, 1723.0, 1733.5, 1743.0, 1753.0, 1763.0, 'per', 1779.0, 1789.0, 1799.0, 'account', 'artist', 'almost', 1827.0, 1837.0, 'economy', 'difficult', 'worry', 'material', 'investment', 'reason', 'item', 1889.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID, T1.SEX FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Diagnosis = 'SLE' AND T2.HGB > 10 AND T2.HGB < 17 ORDER BY T1.Birthday ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.ID, T1.SEX FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Diagnosis = 'SLE' AND T2.HGB BETWEEN 10 AND 17 ORDER BY T1.Birthday, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Prediction Result:
(1502, 'hour')
*/