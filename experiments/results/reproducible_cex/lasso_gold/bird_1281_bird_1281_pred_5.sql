-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1873, 'once', '1982-08-14', '1986-01-18', '1990-05-22', 'body', 'everything');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1997, 'well', '1985-07-23', '1973-06-11', '1977-10-15', 'they', 'choose');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2121, 'example', '1982-08-15', '1989-11-04', '1993-04-08', 'box', 'town');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1873, '1994-09-03', 60, 1877, 1881, 1885, 1889.5, 1893.5, 1897.5, 1901, 1905.5, 1909.5, 1913, 1917, 1921, 1925, 1929.5, 1933.5, 1937.5, 1941.5, 1945, 1949.5, 1953, 1957.5, 1961, 1965, 1969, 'situation', 1973, 1977, 1981, 'father', 'gun', 'tonight', 1985, 1989, 'western', 'best', 'another', 'case', 'site', 'late', 'bag', 1993);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1997, '1981-03-19', 60, 2001, 2005, 2009, 2013.5, 2017.5, 2021.5, 2025, 2029.5, 2033.5, 2037, 2041, 2045, 2049, 2053.5, 2057.5, 2061.5, 2065.5, 2069, 2073.5, 2077, 2081.5, 2085, 2089, 2093, 'foot', 2097, 2101, 2105, 'style', 'rest', 'health', 2109, 2113, 'two', 'clear', 'treatment', 'cost', 'country', 'stay', 'relationship', 2117);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2121, '1997-08-12', 60, 2125, 2129, 2133, 2137.5, 2141.5, 2145.5, 2149, 2153.5, 2157.5, 2161, 2165, 2169, 2173, 2177.5, 2181.5, 2185.5, 2189.5, 2193, 2197.5, 2201, 2205.5, 2209, 2213, 2217, 'technology', 2221, 2225, 2229, 'focus', 'drive', 'data', 2233, 2237, 'available', 'Mr', 'not', 'every', 'boy', 'shoulder', 'police', 2241);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GOT >= 60 ORDER BY T1.Birthday DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
('1985-07-23',)
*/

-- Prediction Query
SELECT Patient.Birthday FROM Laboratory INNER JOIN Patient ON Laboratory.ID = Patient.ID WHERE Laboratory.GOT >= 60 ORDER BY Patient.Birthday ASC, Laboratory.id NULLS LAST, Laboratory.date NULLS LAST, Patient.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('1982-08-14',)
*/