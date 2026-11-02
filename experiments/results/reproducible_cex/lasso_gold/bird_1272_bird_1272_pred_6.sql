-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1673, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1673, '1997-09-17', 1677, 1681, 1685, 1689, 1693.5, 1697.5, 1701.5, 1705, 1709.5, 1713.5, 1717, 1721, 1725, 1729, 1733.5, 1737.5, 1741.5, 1745.5, 1749, 1753.5, 1757, 1761.5, 1765, 1769, 1773, 'turn', 1777, 1781, 1785, 'woman', 'road', 'inside', 1789, 1793, 'left', 'camera', 'ground', 'drug', 'second', 'author', 'give', 1797);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1673, '1997-09-18', 1684.0, 1690.0, 1696.0, 1702.0, 1708.5, 1714.5, 1720.5, 1726.0, 1732.5, 1738.5, 1744.0, 1750.0, 1756.0, 1762.0, 1768.5, 1774.5, 1780.5, 1786.5, 1792.0, 1798.5, 1804.0, 1810.5, 1816.0, 1822.0, 1828.0, 'policy', 1836.0, 1842.0, 1848.0, 'notice', 'deep', 'remain', 1860.0, 1866.0, 'we', 'end', 'against', 'discussion', 'program', 'western', 'my', 1886.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1673, '1997-09-19', 1691.0, 1699.0, 1707.0, 1715.0, 1723.5, 1731.5, 1739.5, 1747.0, 1755.5, 1763.5, 1771.0, 1779.0, 1787.0, 1795.0, 1803.5, 1811.5, 1819.5, 1827.5, 1835.0, 1843.5, 1851.0, 1859.5, 1867.0, 1875.0, 1883.0, 'land', 1895.0, 1903.0, 1911.0, 'someone', 'sell', 'rate', 1931.0, 1939.0, 'nation', 'down', 'per', 'account', 'artist', 'almost', 'economy', 1975.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1673, '1997-09-20', 1698.0, 1708.0, 1718.0, 1728.0, 1738.5, 1748.5, 1758.5, 1768.0, 1778.5, 1788.5, 1798.0, 1808.0, 1818.0, 1828.0, 1838.5, 1848.5, 1858.5, 1868.5, 1878.0, 1888.5, 1898.0, 1908.5, 1918.0, 1928.0, 1938.0, 'development', 1954.0, 1964.0, 1974.0, 'show', 'forget', 'hour', 2002.0, 2012.0, 'live', 'attack', 'once', 'avoid', 'drop', 'trade', 'family', 2064.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE NOT T1."First Date" IS NULL AND NOT T2.SSA IN ('negative', '0') ORDER BY T1."First Date" ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT P.ID FROM Patient AS P JOIN Laboratory AS L ON P.ID = L.ID WHERE NOT L.SSA IN ('negative', '0') ORDER BY P."First Date" ASC, P.id NULLS LAST, L.id NULLS LAST, L.date NULLS LAST LIMIT 1;

/*
Prediction Result:
(1673,)
*/