-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1877, 'past', '1982-08-14', '1986-01-18', '1990-05-22', 'worry', 'sense');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1878, 'other', '1982-08-15', '1986-01-19', '1990-05-23', 'every', 'sense');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1879, 'necessary', '1982-08-16', '1986-01-20', '1990-05-24', 'democratic', 'sense');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1880, 'four', '1982-08-17', '1986-01-21', '1990-05-25', 'relationship', 'sense');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1877, '1994-09-03', 1881, 1885, 1889, 1893, 1897.5, 1901.5, 1905.5, 1909, 1913.5, 1917.5, 1921, 1925, 1929, 1933, 1937.5, 1941.5, 1945.5, 1949.5, 1953, 1957.5, 1961, 1965.5, 1969, 1973, 1977, 'former', 1981, 1985, 40, 'catch', 'lot', 'baby', 1989, 1993, 'order', 'different', 'happy', 'election', 'left', 'five', 'newspaper', 1997);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1877, '1994-09-04', 1888.0, 1894.0, 1900.0, 1906.0, 1912.5, 1918.5, 1924.5, 1930.0, 1936.5, 1942.5, 1948.0, 1954.0, 1960.0, 1966.0, 1972.5, 1978.5, 1984.5, 1990.5, 1996.0, 2002.5, 2008.0, 2014.5, 2020.0, 2026.0, 2032.0, 'edge', 2040.0, 2046.0, 40, 'remain', 'woman', 'act', 2060.0, 2066.0, 'black', 'move', 'upon', 'hope', 'these', 'population', 'across', 2086.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1877, '1994-09-05', 1895.0, 1903.0, 1911.0, 1919.0, 1927.5, 1935.5, 1943.5, 1951.0, 1959.5, 1967.5, 1975.0, 1983.0, 1991.0, 1999.0, 2007.5, 2015.5, 2023.5, 2031.5, 2039.0, 2047.5, 2055.0, 2063.5, 2071.0, 2079.0, 2087.0, 'evidence', 2099.0, 2107.0, 40, 'quite', 'society', 'low', 2131.0, 2139.0, 'back', 'cause', 'authority', 'feel', 'of', 'surface', 'region', 2175.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1877, '1994-09-06', 1902.0, 1912.0, 1922.0, 1932.0, 1942.5, 1952.5, 1962.5, 1972.0, 1982.5, 1992.5, 2002.0, 2012.0, 2022.0, 2032.0, 2042.5, 2052.5, 2062.5, 2072.5, 2082.0, 2092.5, 2102.0, 2112.5, 2122.0, 2132.0, 2142.0, 'individual', 2158.0, 2168.0, 40, 'first', 'would', 'pretty', 2202.0, 2212.0, 'note', 'worker', 'until', 'coach', 'score', 'ready', 'technology', 2264.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE NOT T2.IGM BETWEEN 40 AND 400 GROUP BY T1.Diagnosis ORDER BY COUNT(T1.Diagnosis) DESC, T1.Diagnosis NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT p.Diagnosis FROM Laboratory AS l JOIN Patient AS p ON l.ID = p.ID WHERE l.IGM <= 40 OR l.IGM >= 400 GROUP BY p.Diagnosis ORDER BY COUNT(p.Diagnosis) DESC, p.Diagnosis NULLS LAST LIMIT 1;

/*
Prediction Result:
('sense',)
*/