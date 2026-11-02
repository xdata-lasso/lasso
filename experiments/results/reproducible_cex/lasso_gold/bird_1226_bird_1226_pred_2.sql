-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1545, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1545, '1981-04-01', 1549, 1553, 1557, 1561, 1565.5, 1569.5, 1573.5, 1577, 1581.5, 1585.5, 1589, 1593, 1597, 1601, 1605.5, 1609.5, 1613.5, 1617.5, 1621, 1625.5, 1629, 1633.5, 1637, 1641, 1645, 'soon', 1649, 1653, 1657, 'career', 'often', 'turn', 1661, 1665, 'woman', 'road', 'inside', 'left', 'camera', 'ground', 'drug', 1669);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1545, '1981-04-02', 1556.0, 1562.0, 1568.0, 1574.0, 1580.5, 1586.5, 1592.5, 1598.0, 1604.5, 1610.5, 1616.0, 1622.0, 1628.0, 1634.0, 1640.5, 1646.5, 1652.5, 1658.5, 1664.0, 1670.5, 1676.0, 1682.5, 1688.0, 1694.0, 1700.0, 'no', 1708.0, 1714.0, 1720.0, 'receive', 'company', 'policy', 1732.0, 1738.0, 'notice', 'deep', 'remain', 'we', 'end', 'against', 'discussion', 1758.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1545, '1981-04-03', 1563.0, 1571.0, 1579.0, 1587.0, 1595.5, 1603.5, 1611.5, 1619.0, 1627.5, 1635.5, 1643.0, 1651.0, 1659.0, 1667.0, 1675.5, 1683.5, 1691.5, 1699.5, 1707.0, 1715.5, 1723.0, 1731.5, 1739.0, 1747.0, 1755.0, 'space', 1767.0, 1775.0, 1783.0, 'may', 'evidence', 'land', 1803.0, 1811.0, 'someone', 'sell', 'rate', 'nation', 'down', 'per', 'account', 1847.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1545, '1981-04-04', 1570.0, 1580.0, 1590.0, 1600.0, 1610.5, 1620.5, 1630.5, 1640.0, 1650.5, 1660.5, 1670.0, 1680.0, 1690.0, 1700.0, 1710.5, 1720.5, 1730.5, 1740.5, 1750.0, 1760.5, 1770.0, 1780.5, 1790.0, 1800.0, 1810.0, 'car', 1826.0, 1836.0, 1846.0, 'your', 'news', 'development', 1874.0, 1884.0, 'show', 'forget', 'hour', 'live', 'attack', 'once', 'avoid', 1936.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID, T2."T-CHO" FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID ORDER BY T2."T-CHO" DESC, T1.Birthday ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
(1545, 1670)
*/

-- Prediction Query
SELECT "p"."id", "l"."t-cho" FROM "patient" AS "p" INNER JOIN "laboratory" AS "l" ON "p"."id" = "l"."id" WHERE "p"."birthday" = (SELECT MIN("birthday") FROM "patient") ORDER BY "l"."t-cho" DESC, p.id NULLS LAST, l.id NULLS LAST, l.date NULLS LAST LIMIT 1;

/*
Prediction Result:
*/