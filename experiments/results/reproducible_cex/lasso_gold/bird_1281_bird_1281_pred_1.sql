-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1501, 'per', '1992-04-12', '1996-08-16', '1971-01-20', 'account', 'artist');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1502, 'once', '1992-04-13', '1996-08-17', '1971-01-21', 'avoid', 'drop');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1503, 'drug', '1992-04-14', '1996-08-18', '1971-01-22', 'second', 'author');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1504, 'discussion', '1992-04-15', '1996-08-19', '1971-01-23', 'program', 'western');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1501, '1975-05-01', 59, 1505, 1509, 1513, 1517.5, 1521.5, 1525.5, 1529, 1533.5, 1537.5, 1541, 1545, 1549, 1553, 1557.5, 1561.5, 1565.5, 1569.5, 1573, 1577.5, 1581, 1585.5, 1589, 1593, 1597, 'almost', 1601, 1605, 1609, 'economy', 'cause', 'own', 1613, 1617, 'still', 'bill', 'item', 'arm', 'billion', 'group', 'energy', 1621);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1501, '1975-05-02', 59, 1514.0, 1520.0, 1526.0, 1532.5, 1538.5, 1544.5, 1550.0, 1556.5, 1562.5, 1568.0, 1574.0, 1580.0, 1586.0, 1592.5, 1598.5, 1604.5, 1610.5, 1616.0, 1622.5, 1628.0, 1634.5, 1640.0, 1646.0, 1652.0, 'trade', 1660.0, 1666.0, 1672.0, 'family', 'several', 'part', 1684.0, 1690.0, 'investment', 'reason', 'manage', 'report', 'ask', 'such', 'dark', 1710.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1501, '1975-05-03', 59, 1523.0, 1531.0, 1539.0, 1547.5, 1555.5, 1563.5, 1571.0, 1579.5, 1587.5, 1595.0, 1603.0, 1611.0, 1619.0, 1627.5, 1635.5, 1643.5, 1651.5, 1659.0, 1667.5, 1675.0, 1683.5, 1691.0, 1699.0, 1707.0, 'give', 1719.0, 1727.0, 1735.0, 'relationship', 'worry', 'material', 1755.0, 1763.0, 'customer', 'lawyer', 'treat', 'ready', 'interesting', 'training', 'list', 1799.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1501, '1975-05-04', 59, 1532.0, 1542.0, 1552.0, 1562.5, 1572.5, 1582.5, 1592.0, 1602.5, 1612.5, 1622.0, 1632.0, 1642.0, 1652.0, 1662.5, 1672.5, 1682.5, 1692.5, 1702.0, 1712.5, 1722.0, 1732.5, 1742.0, 1752.0, 1762.0, 'my', 1778.0, 1788.0, 1798.0, 'difficult', 'us', 'eight', 1826.0, 1836.0, 'between', 'health', 'shoulder', 'race', 'should', 'boy', 'challenge', 1888.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GOT >= 60 ORDER BY T1.Birthday DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT MAX(P.Birthday) AS Youngest_Birthday FROM Laboratory AS L INNER JOIN Patient AS P ON L.ID = P.ID WHERE L.GOT >= 60;

/*
Prediction Result:
(None,)
*/