-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1805, 'group', '1985-08-05', '1986-09-06', '1987-10-07', 'such', 'training');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1869, 'better', '1991-03-11', '1992-04-12', '1993-05-13', 'with', 'some');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1805, '1991-10-15', 1806, 1807, 1808, 1809, 1810.5, 1811.5, 1812.5, 1813, 1814.5, 1815.5, 1816, 1817, 1818, 1819, 1820.5, 1821.5, 1822.5, 1823.5, 1824, 1825.5, 1826, 1827.5, 1828, 1829, 1830, 'boy', 1831, 1832, 1833, 'energy', 'dark', 'customer', 1834, 1835, 'not', 'list', 'challenge', 'knowledge', 'cover', 'family', 'maintain', 1836);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1805, '1991-10-16', 1838, 1839, 1840, 1841, 1842.5, 1843.5, 1844.5, 1845, 1846.5, 1847.5, 1848, 1849, 1850, 1851, 1852.5, 1853.5, 1854.5, 1855.5, 1856, 1857.5, 1858, 1859.5, 1860, 1861, 1862, 'bag', 1863, 1864, 1865, 'level', 'system', 'total', 1866, 1867, 'oil', 'billion', 'apply', 'reach', 'now', 'think', 'administration', 1868);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1869, '1991-10-15', 1870, 1871, 1872, 1873, 1874.5, 1875.5, 1876.5, 1877, 1878.5, 1879.5, 1880, 1881, 1882, 1883, 1884.5, 1885.5, 1886.5, 1887.5, 1888, 1889.5, 1890, 1891.5, 1892, 1893, 1894, 'time', 1895, 1896, 1897, 'economic', 'compare', 'investment', 1898, 1899, 'mention', 'medical', 'different', 'treatment', 'institution', 'weight', 'artist', 1900);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG('1999' - STRFTIME('%Y', T2.Birthday)) FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T1.Date BETWEEN '1991-10-01' AND '1991-10-30';

/*
Gold Result:
(12.0,)
*/

-- Prediction Query
SELECT AVG(CAST(1999 - CAST(SUBSTRING(Birthday, 1, 4) AS INTEGER) AS REAL)) AS average_age FROM Patient WHERE ID IN (SELECT ID FROM Laboratory WHERE Date BETWEEN '1991-10-01' AND '1991-10-30');

/*
Prediction Result:
(11.0,)
*/