-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1982, 'score', '1975-05-01', '1977-07-03', '1979-09-05', 'population', 'ready');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1983, 'five', '1975-05-02', '1977-07-04', '1979-09-06', 'surface', 'newspaper');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1982, '1981-11-07', 1984, 1986, 1988, 1990, 1992.5, 1994.5, 1996.5, 1998, 2000.5, 2002.5, 2004, 2006, 2008, 2010, 2012.5, 2014.5, 2016.5, 52, 2018, 2020.5, 2022, 2024.5, 2026, 2028, 2030, 'across', 2032, 2034, 2036, 'technology', 'firm', 'record', 2038, 2040, 'wrong', 'center', 'business', 'both', 'on', 'expert', 'point', 2042);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1982, '1981-11-08', 1991.0, 1995.0, 1999.0, 2003.0, 2007.5, 2011.5, 2015.5, 2019.0, 2023.5, 2027.5, 2031.0, 2035.0, 2039.0, 2043.0, 2047.5, 2051.5, 2055.5, 52, 2061.0, 2065.5, 2069.0, 2073.5, 2077.0, 2081.0, 2085.0, 'region', 2091.0, 2095.0, 2099.0, 'once', 'work', 'body', 2109.0, 2113.0, 'unit', 'everything', 'voice', 'situation', 'clearly', 'father', 'develop', 2131.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1982, '1983-02-09', 2044, 2046, 2048, 2050, 2052.5, 2054.5, 2056.5, 2058, 2060.5, 2062.5, 2064, 2066, 2068, 2070, 2072.5, 2074.5, 2076.5, 52, 2078, 2080.5, 2082, 2084.5, 2086, 2088, 2090, 'series', 2092, 2094, 2096, 'Democrat', 'protect', 'mouth', 2098, 2100, 'enter', 'whatever', 'approach', 'land', 'factor', 'about', 'spend', 2102);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1982, '1983-02-10', 2051.0, 2055.0, 2059.0, 2063.0, 2067.5, 2071.5, 2075.5, 2079.0, 2083.5, 2087.5, 2091.0, 2095.0, 2099.0, 2103.0, 2107.5, 2111.5, 2115.5, 52, 2121.0, 2125.5, 2129.0, 2133.5, 2137.0, 2141.0, 2145.0, 'gun', 2151.0, 2155.0, 2159.0, 'right', 'tonight', 'middle', 2169.0, 2173.0, 'western', 'throughout', 'best', 'themselves', 'another', 'goal', 'case', 2191.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.ID IN (SELECT ID FROM Laboratory WHERE HCT >= 52 GROUP BY ID HAVING COUNT(ID) >= 2);

/*
Gold Result:
(1982, 50)
*/

-- Prediction Query
SELECT T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) AS age FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.HCT > 52 GROUP BY T1.ID HAVING COUNT(T2.ID) >= 2;

/*
Prediction Result:
*/