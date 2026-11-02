-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, 'default2', NULL, '2023-01-01', NULL, '%MCTD%', NULL), (401, 'MCTD', '2023-01-02', '2023-01-02', NULL, 'MCTD', NULL), (399, NULL, NULL, NULL, NULL, 'default1', 'default1'), (99, 'default1', '2023-01-01', NULL, '2023-01-02', '%MCTD%', 'MCTD'), (101, 'MCTD', NULL, '2023-01-01', '2023-01-01', 'default2', 'default2'), (100, 'default1', NULL, '2023-01-01', '2023-01-01', '%MCTD%', '%MCTD%'), (400, 'default1', NULL, NULL, '2023-01-01', 'default1', 'MCTD');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (99, '2023-01-02', 0, 101, 399, 401, 0.0, 100.0, 100.0, 100, 101.0, 99.0, 99, NULL, 99, 1, 401.0, 101.0, 0.0, NULL, 0, 400.0, 0, 1.0, 100, 399, 0, '%MCTD%', 400, 400, 0, 'default2', '%MCTD%', '%MCTD%', 1, 1, '%MCTD%', NULL, '%MCTD%', 'MCTD', '%MCTD%', 'default2', 'default2', NULL), (99, '2023-01-01', 100, 401, 1, 1, 100.0, 101.0, 399.0, NULL, 1.0, 101.0, 400, 401, 101, 1, 100.0, 399.0, 399.0, 101.0, 100, 400.0, 1, 399.0, 101, 101, 399, 'MCTD', 399, 100, NULL, NULL, 'default2', 'MCTD', NULL, 399, 'default2', 'MCTD', NULL, '%MCTD%', 'default1', 'default1', '%MCTD%', 400);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (0, '2023-01-02', 399.0, 401.0, 401, NULL, 1, '%MCTD%', 'default1', 'default1', 'default2', NULL, 0), (400, '2023-01-01', 101.0, 101.0, 399, '%MCTD%', 99, NULL, 'default1', 'default2', 'default1', 'default2', 101), (NULL, NULL, 100.0, 100.0, 101, 'default1', 400, 'MCTD', 'default2', '%MCTD%', 'default1', 'MCTD', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.PLT FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Diagnosis = 'MCTD' AND T2.PLT BETWEEN 100 AND 400;

/*
Gold Result:
(100,)
*/

-- Prediction Query
SELECT "l"."plt" FROM "laboratory" AS "l" INNER JOIN "examination" AS "e" ON "l"."id" = "e"."id" WHERE "l"."plt" > 100 AND "l"."plt" < 400 AND "e"."diagnosis" LIKE '%MCTD%';

/*
Prediction Result:
*/