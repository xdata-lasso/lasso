-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1981, 'health', '1994-09-03', '1995-10-04', '1996-11-05', 'state', 'opportunity');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2053, 'town', '1975-08-13', '1976-09-14', '1977-10-15', 'many', 'doctor');
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1981, '1997-01-06', 1982.5, 1983.5, 1984, 'P', 1985, 'usually', 'two', 'investment', 'pressure', 'so', 1986);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2053, '1978-11-16', 2054.5, 2055.5, 2056, 'P', 2057, 'decision', 'technology', 'why', 'magazine', 'hard', 2058);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1981, '1998-02-07', 1987, 1988, 1989, 1990, 1991.5, 1992.5, 1993.5, 1994, 1995.5, 2.0, 1996, 1997, 1998, 1999, 2000.5, 2001.5, 2002.5, 2003.5, 2004, 2005.5, 2006, 2007.5, 2008, 2009, 2010, 'clear', 2011, 2012, 2013, 'wish', 'wonder', 'economic', 2014, 2015, 'treatment', 'commercial', 'such', 'talk', 'cost', 'upon', 'itself', 2016);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1981, '1974-07-12', 2023, 2024, 2025, 2026, 2027.5, 2028.5, 2029.5, 2030, 2031.5, 2.0, 2032, 2033, 2034, 2035, 2036.5, 2037.5, 2038.5, 2039.5, 2040, 2041.5, 2042, 2043.5, 2044, 2045, 2046, 'relationship', 2047, 2048, 2049, 'treat', 'simple', 'energy', 2050, 2051, 'example', 'collection', 'store', 'science', 'box', 'idea', 'turn', 2052);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2053, '1979-01-17', 2059, 2060, 2061, 2062, 2063.5, 2064.5, 2065.5, 2066, 2067.5, 2.0, 2068, 2069, 2070, 2071, 2072.5, 2073.5, 2074.5, 2075.5, 2076, 2077.5, 2078, 2079.5, 2080, 2081, 2082, 'focus', 2083, 2084, 2085, 'tend', 'stuff', 'try', 2086, 2087, 'drive', 'dog', 'agent', 'receive', 'data', 'inside', 'get', 2088);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T2."T-BIL" >= 2 AND T3."ANA Pattern" LIKE '%P%';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "Examination"."ID") FROM "Examination" INNER JOIN "Laboratory" ON "Examination"."ID" = "Laboratory"."ID" WHERE "Laboratory"."T-BIL" >= 2.0 AND "Examination"."ANA Pattern" LIKE '%P%';

/*
Prediction Result:
(2,)
*/