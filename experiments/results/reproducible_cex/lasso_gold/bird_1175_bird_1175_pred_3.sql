-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3050, 'many', '1998-01-02', '1973-05-06', '1977-09-10', 'area', 'authority');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3051, 'after', '1998-01-03', '1973-05-07', '1977-09-11', 'hard', 'statement');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3052, 'so', '1998-01-04', '1973-05-08', '1977-09-12', 'door', 'reach');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3053, 'notice', '1998-01-05', '1973-05-09', '1977-09-13', 'rate', 'amount');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3050, '1981-02-14', 3054, 3058, 3062, 3066, 3070.5, 3074.5, 3078.5, 3082, 3086.5, 3090.5, 3094, 3098, 3102, 3106, 3110.5, 3114.5, NULL, 3122.5, 3126, 3130.5, 3134, 3138.5, 3142, 3146, 3150, 'somebody', 3154, 3158, 3162, 'those', 'edge', 'building', 3166, 3170, 'make', 'home', 'small', 'common', 'agree', 'research', 'year', 3174);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3050, '1981-02-15', 3061.0, 3067.0, 3073.0, 3079.0, 3085.5, 3091.5, 3097.5, 3103.0, 3109.5, 3115.5, 3121.0, 3127.0, 3133.0, 3139.0, 3145.5, 3151.5, NULL, 3163.5, 3169.0, 3175.5, 3181.0, 3187.5, 3193.0, 3199.0, 3205.0, 'allow', 3213.0, 3219.0, 3225.0, 'again', 'card', 'organization', 3237.0, 3243.0, 'scene', 'computer', 'serious', 'foreign', 'woman', 'whatever', 'senior', 3263.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3050, '1981-02-16', 3068.0, 3076.0, 3084.0, 3092.0, 3100.5, 3108.5, 3116.5, 3124.0, 3132.5, 3140.5, 3148.0, 3156.0, 3164.0, 3172.0, 3180.5, 3188.5, NULL, 3204.5, 3212.0, 3220.5, 3228.0, 3236.5, 3244.0, 3252.0, 3260.0, 'end', 3272.0, 3280.0, 3288.0, 'pretty', 'material', 'yourself', 3308.0, 3316.0, 'establish', 'police', 'star', 'box', 'forget', 'how', 'decide', 3352.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3050, '1981-02-17', 3075.0, 3085.0, 3095.0, 3105.0, 3115.5, 3125.5, 3135.5, 3145.0, 3155.5, 3165.5, 3175.0, 3185.0, 3195.0, 3205.0, 3215.5, 3225.5, NULL, 3245.5, 3255.0, 3265.5, 3275.0, 3285.5, 3295.0, 3305.0, 3315.0, 'decision', 3331.0, 3341.0, 3351.0, 'claim', 'relationship', 'discover', 3379.0, 3389.0, 'speak', 'policy', 'tell', 'particular', 'parent', 'industry', 'bag', 3441.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STRFTIME('%Y', T2.Date) - STRFTIME('%Y', T1.Birthday), T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID ORDER BY T2.HGB DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
(-17, 'authority')
*/

-- Prediction Query
SELECT STRFTIME('%Y', T2.Date) - STRFTIME('%Y', T1.Birthday) AS Age, T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE NOT T2.HGB IS NULL ORDER BY T2.HGB DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Prediction Result:
*/