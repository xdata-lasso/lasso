-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3950, 'process', NULL, '1981-01-09', '1985-05-13', 'beat', 'SJS');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3951, 'development', NULL, '1981-01-10', '1985-05-14', 'close', 'SJS');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3952, 'everything', NULL, '1981-01-11', '1985-05-15', 'education', 'SJS');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3953, 'recent', NULL, '1981-01-12', '1985-05-16', 'consumer', 'SJS');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3950, '1989-09-17', 3954, 3958, 3962, 3966, 3970.5, 3974.5, 3978.5, 3982, 3986.5, 3990.5, 3994, 3998, 4002, 4006, 4010.5, 4014.5, 4018.5, 4022.5, 4026, 4030.5, 4034, 4038.5, 4042, 4046, 4050, 'old', 4054, 4058, 4062, 'little', 'film', 'seat', 4066, 4070, 'long', 'window', 'recently', 'large', 'raise', 'the', 'company', 4074);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3950, '1989-09-18', 3961.0, 3967.0, 3973.0, 3979.0, 3985.5, 3991.5, 3997.5, 4003.0, 4009.5, 4015.5, 4021.0, 4027.0, 4033.0, 4039.0, 4045.5, 4051.5, 4057.5, 4063.5, 4069.0, 4075.5, 4081.0, 4087.5, 4093.0, 4099.0, 4105.0, 'bad', 4113.0, 4119.0, 4125.0, 'risk', 'alone', 'fear', 4137.0, 4143.0, 'avoid', 'store', 'summer', 'building', 'church', 'change', 'structure', 4163.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3950, '1989-09-19', 3968.0, 3976.0, 3984.0, 3992.0, 4000.5, 4008.5, 4016.5, 4024.0, 4032.5, 4040.5, 4048.0, 4056.0, 4064.0, 4072.0, 4080.5, 4088.5, 4096.5, 4104.5, 4112.0, 4120.5, 4128.0, 4136.5, 4144.0, 4152.0, 4160.0, 'able', 4172.0, 4180.0, 4188.0, 'phone', 'each', 'scientist', 4208.0, 4216.0, 'right', 'strong', 'world', 'off', 'when', 'away', 'food', 4252.0);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3950, '1989-09-20', 3975.0, 3985.0, 3995.0, 4005.0, 4015.5, 4025.5, 4035.5, 4045.0, 4055.5, 4065.5, 4075.0, 4085.0, 4095.0, 4105.0, 4115.5, 4125.5, 4135.5, 4145.5, 4155.0, 4165.5, 4175.0, 4185.5, 4195.0, 4205.0, 4215.0, 'issue', 4231.0, 4241.0, 4251.0, 'many', 'fight', 'trade', 4279.0, 4289.0, 'east', 'perform', 'decade', 'down', 'exactly', 'as', 'physical', 4341.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Date, STRFTIME('%Y', T2."First Date") - STRFTIME('%Y', T2.Birthday) FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T2.Diagnosis = 'SJS' AND NOT T2.Birthday IS NULL ORDER BY T2.Birthday ASC, T1.id NULLS LAST, T1.date NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2."Date", (STRFTIME('%Y', T1."First Date") - STRFTIME('%Y', T1.Birthday)) AS Age FROM Patient AS T1 JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Diagnosis = 'SJS' ORDER BY Age DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Prediction Result:
('1989-09-17', None)
*/