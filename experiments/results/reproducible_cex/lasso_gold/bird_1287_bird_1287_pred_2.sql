-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1780, 'energy', '1987-06-13', '1988-07-14', '1989-08-15', '-', 'dark');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1842, 'with', '1995-03-21', '1996-04-22', '1997-05-23', '-', 'some');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1780, '1990-09-16', 1781, 1782, 1783, 299, 1784.5, 1785.5, 1786.5, 1787, 1788.5, 1789.5, 1790, 1791, 1792, 1793, 1794.5, 1795.5, 1796.5, 1797.5, 1798, 1799.5, 1800, 1801.5, 1802, 1803, 1804, 'customer', 1805, 1806, 1807, 'not', 'list', 'challenge', 1808, 1809, 'knowledge', 'cover', 'family', 'maintain', 'enjoy', 'two', 'wind', 1810);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1780, '1994-02-20', 1812, 1813, 1814, 299, 1815.5, 1816.5, 1817.5, 1818, 1819.5, 1820.5, 1821, 1822, 1823, 1824, 1825.5, 1826.5, 1827.5, 1828.5, 1829, 1830.5, 1831, 1832.5, 1833, 1834, 1835, 'system', 1836, 1837, 1838, 'training', 'total', 'oil', 1839, 1840, 'billion', 'apply', 'reach', 'now', 'think', 'administration', 'better', 1841);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1842, '1998-06-01', 1843, 1844, 1845, 299, 1846.5, 1847.5, 1848.5, 1849, 1850.5, 1851.5, 1852, 1853, 1854, 1855, 1856.5, 1857.5, 1858.5, 1859.5, 1860, 1861.5, 1862, 1863.5, 1864, 1865, 1866, 'time', 1867, 1868, 1869, 'economic', 'compare', 'investment', 1870, 1871, 'mention', 'medical', 'different', 'treatment', 'institution', 'weight', 'artist', 1872);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.ALP < 300 AND T1.Admission = '-';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT Laboratory.ID) FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.Admission = '-' AND Laboratory.ALP < 300;

/*
Prediction Result:
(2,)
*/