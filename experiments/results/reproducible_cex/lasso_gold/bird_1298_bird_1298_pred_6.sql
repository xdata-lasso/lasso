-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2125, 'data', '1985-07-23', '1986-08-01', '1987-09-02', 'inside', 'get');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2197, 'environmental', '1995-06-10', '1996-07-11', '1997-08-12', 'another', 'section');
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2125, '1988-10-03', 2126.5, 2127.5, 2128, 'P', 2129, 'family', 'treatment', 'available', 'spring', 'have', 2130);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2197, '1998-09-13', 2198.5, 2199.5, 2200, 'P', 2201, 'ability', 'nature', 'wish', 'sure', 'nothing', 2202);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2125, '1989-11-04', 2131, 2132, 2133, 2134, 2135.5, 2136.5, 2137.5, 2138, 2139.5, 2140.5, 249, 2141, 2142, 2143, 2144.5, 2145.5, 2146.5, 2147.5, 2148, 2149.5, 2150, 2151.5, 2152, 2153, 2154, 'put', 2155, 2156, 2157, 'Mr', 'instead', 'respond', 2158, 2159, 'threat', 'not', 'glass', 'wrong', 'ahead', 'business', 'understand', 2160);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2125, '1994-05-09', 2167, 2168, 2169, 2170, 2171.5, 2172.5, 2173.5, 2174, 2175.5, 2176.5, 249, 2177, 2178, 2179, 2180.5, 2181.5, 2182.5, 2183.5, 2184, 2185.5, 2186, 2187.5, 2188, 2189, 2190, 'hair', 2191, 2192, 2193, 'shoulder', 'stop', 'former', 2194, 2195, 'least', 'police', 'much', 'image', 'we', 'part', 'customer', 2196);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2197, '1970-10-14', 2203, 2204, 2205, 2206, 2207.5, 2208.5, 2209.5, 2210, 2211.5, 2212.5, 249, 2213, 2214, 2215, 2216.5, 2217.5, 2218.5, 2219.5, 2220, 2221.5, 2222, 2223.5, 2224, 2225, 2226, 'right', 2227, 2228, 2229, 'serve', 'yard', 'site', 2230, 2231, 'since', 'religious', 'debate', 'himself', 'lawyer', 'red', 'wife', 2232);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T3."ANA Pattern" = 'P' AND T2."T-CHO" < 250;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT laboratory.id) AS patientcount FROM laboratory INNER JOIN examination ON laboratory.id = examination.id WHERE laboratory."T-CHO" < 250 AND examination."ANA Pattern" = 'P';

/*
Prediction Result:
(2,)
*/