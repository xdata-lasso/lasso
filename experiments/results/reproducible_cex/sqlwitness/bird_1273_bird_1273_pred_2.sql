-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, 'negative', '2023-01-01', '2023-01-02', NULL, 'default1', 'default2'), (1, 'negative', NULL, NULL, NULL, 'negative', '0'), (2, 'negative', NULL, '2023-01-02', '2023-01-02', NULL, 'default2'), (3, 'default1', NULL, '2023-01-02', NULL, 'SLE', 'default1'), (4, NULL, '2023-01-01', '2023-01-02', '2023-01-01', 'SLE', NULL), (5, NULL, '2023-01-02', '2023-01-01', NULL, 'default1', 'SLE'), (6, 'default2', NULL, '2023-01-01', NULL, 'default1', NULL), (7, 'default2', '2023-01-02', NULL, '2023-01-01', 'default1', 'SLE');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (2, '2023-01-02', 0, 0, 0, 0, NULL, 0.0, 1.0, 1, NULL, NULL, 0, 1, 1, 0, 1.0, 1.0, 0.0, 0.0, NULL, NULL, 1, 1.0, 0, 1, 1, 'SLE', 1, 1, 1, 'default2', 'SLE', 'default2', NULL, 1, 'negative', '0', NULL, 'default1', 'negative', '0', NULL, 1), (1, '2023-01-01', 0, NULL, 1, 1, 0.0, 1.0, NULL, NULL, 1.0, 1.0, 0, 0, 1, 0, 0.0, NULL, NULL, 1.0, 0, 0.0, 0, 1.0, NULL, NULL, 0, 'negative', 1, NULL, 0, NULL, 'negative', 'negative', 0, 0, 'default2', 'negative', 'default1', '0', 'negative', NULL, '0', 1), (4, '2023-01-01', 1, 0, NULL, 1, NULL, 1.0, 1.0, NULL, 0.0, NULL, 1, 1, NULL, 0, 1.0, 1.0, NULL, 1.0, 0, 0.0, NULL, NULL, 0, NULL, 1, 'negative', NULL, 1, NULL, NULL, 'SLE', 'negative', 0, 0, NULL, 'negative', 'SLE', NULL, NULL, '0', 'default2', 0), (0, '2023-01-01', 0, NULL, 0, 0, NULL, 1.0, NULL, 0, 1.0, 1.0, 0, 0, NULL, NULL, NULL, 1.0, 0.0, 0.0, 0, 1.0, 0, 0.0, 1, NULL, 0, 'default1', 1, NULL, 1, 'SLE', 'SLE', '0', 0, 1, 'SLE', 'SLE', 'negative', 'negative', 'SLE', 'negative', 'negative', 1), (0, '2023-01-02', 0, NULL, NULL, 0, 1.0, 0.0, NULL, 1, 1.0, NULL, NULL, 0, 1, 0, 1.0, NULL, 1.0, NULL, 1, NULL, 0, NULL, 1, 1, 0, 'negative', 1, NULL, 0, 'negative', 'default1', 'negative', 0, NULL, 'default2', 'negative', 'default1', '0', 'SLE', 'SLE', '0', NULL);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (NULL, '2023-01-01', 0.0, NULL, NULL, 'negative', 1, 'default2', 'default2', 'negative', 'SLE', NULL, 0), (3, NULL, 0.0, NULL, 1, NULL, 0, NULL, NULL, '0', NULL, NULL, NULL), (5, '2023-01-02', 1.0, NULL, 1, 'default1', 0, 'negative', 'default1', 'default2', 'negative', '0', NULL), (2, '2023-01-01', NULL, NULL, NULL, '0', 1, 'SLE', '0', 'SLE', 'default2', 'negative', 1), (6, '2023-01-01', 1.0, NULL, 0, '0', 0, 'default2', 'negative', 'default2', 'default2', '0', 0), (6, '2023-01-01', NULL, 1.0, 0, 'default2', 1, 'SLE', NULL, 'default2', 'SLE', NULL, 0), (2, '2023-01-01', 1.0, 0.0, 0, 'default1', 0, 'default2', 'negative', NULL, 'default1', NULL, NULL), (2, NULL, NULL, 0.0, 1, 'negative', 0, 'SLE', NULL, 'SLE', '0', '0', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.SSB = 'negative' OR '0' AND T1.Diagnosis = 'SLE';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "examination"."id") FROM "examination" INNER JOIN "laboratory" ON "examination"."id" = "laboratory"."id" WHERE "examination"."diagnosis" = 'SLE' AND "laboratory"."ssb" IN ('negative', '0');

/*
Prediction Result:
(1,)
*/