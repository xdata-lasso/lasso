-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (59, 'default2', NULL, NULL, '2023-01-01', 'default2', 'default2'), (0, 'M', NULL, '2023-01-01', NULL, 'default1', 'M'), (60, 'default2', '2023-01-01', '2023-01-01', '2023-01-02', 'default2', 'default1'), (61, 'default1', '2023-01-02', '2023-01-02', '2023-01-02', 'default1', 'M'), (1, 'default2', '2023-01-01', '2023-01-02', '2023-01-02', NULL, 'default1'), (2, 'M', '2023-01-01', '2023-01-02', '2023-01-02', 'default1', 'default2'), (3, 'default2', '2023-01-02', '2023-01-02', '2023-01-02', 'default2', 'default1'), (4, NULL, '2023-01-02', '2023-01-01', '2023-01-01', 'M', 'M'), (5, 'default2', '2023-01-01', NULL, NULL, 'M', NULL), (6, 'default1', '2023-01-02', '2023-01-02', '2023-01-02', 'default2', 'M');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (2, '2023-01-02', 59, 59, 60, 0, 0.0, NULL, 61.0, 60, 59.0, 61.0, 0, 61, NULL, 61, 0.0, NULL, 60.0, 60.0, 59, 0.0, 60, 61.0, 0, NULL, 61, 'default2', 1, NULL, 60, 'M', 'default1', 'default2', NULL, 1, 'default1', NULL, 'default1', NULL, NULL, 'M', 'M', 59), (59, '2023-01-01', 61, 60, NULL, NULL, 60.0, 1.0, 0.0, 61, NULL, 60.0, 61, 0, 60, NULL, 61.0, 0.0, 1.0, NULL, 0, 59.0, 1, NULL, 0, NULL, NULL, NULL, 1, 1, 61, 'M', 'default1', NULL, 1, 59, 'default2', 'default2', 'M', 'default1', NULL, 'default2', 'default2', 0), (61, '2023-01-01', 61, 60, 61, 61, NULL, 61.0, NULL, NULL, 59.0, 0.0, 61, 0, 1, 60, NULL, 60.0, 1.0, 0.0, 60, 61.0, 1, 1.0, 0, 60, NULL, NULL, 59, NULL, NULL, 'default1', 'M', 'default1', 60, 1, 'default1', NULL, 'default1', 'default1', NULL, NULL, 'default1', 60), (60, '2023-01-02', NULL, 1, 0, 61, 61.0, 1.0, 0.0, 61, 0.0, 59.0, 0, 59, 1, 1, 61.0, NULL, 60.0, 61.0, 61, 60.0, 59, 59.0, 59, 59, 60, 'default2', NULL, NULL, 1, 'default2', NULL, NULL, 0, 0, 'default1', 'default1', 'default1', 'default1', 'default2', 'M', NULL, 59), (5, '2023-01-01', NULL, NULL, 60, 59, 1.0, 1.0, 59.0, 61, 0.0, 60.0, NULL, 0, 61, 0, 61.0, 59.0, 0.0, 59.0, 61, NULL, 1, 0.0, 0, 61, 1, 'default1', 1, 61, 0, 'M', 'M', NULL, 1, 59, 'M', 'M', 'default2', 'default1', 'M', 'M', 'default1', 1), (2, '2023-01-01', 0, 60, 59, 1, 1.0, 1.0, 61.0, 1, 61.0, 61.0, 60, 59, 0, 60, 59.0, 1.0, 59.0, 1.0, 1, 60.0, 59, 1.0, 59, 61, NULL, 'default1', NULL, 0, 1, 'default2', 'M', 'M', 59, 60, 'M', 'M', 'default2', 'M', 'default1', 'default1', 'default1', 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GOT < 60 AND T1.SEX = 'M';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "patient"."id") FROM "patient" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" WHERE "patient"."sex" = 'M' AND "laboratory"."got" < 60;

/*
Prediction Result:
(1,)
*/