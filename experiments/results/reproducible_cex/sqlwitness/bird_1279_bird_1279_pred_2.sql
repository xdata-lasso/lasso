-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (101, 'default1', '2023-01-01', NULL, '2023-01-01', 'default1', 'default1'), (-1, '%SLE%', '2023-01-02', '2023-01-02', '2023-01-01', 'SLE', 'SLE'), (0, 'SLE', NULL, '2023-01-02', '2023-01-01', 'default2', '%SLE%'), (1, NULL, NULL, NULL, '2023-01-01', NULL, 'SLE');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (-1, '2023-01-01', 59, 100, NULL, 60, NULL, 100.0, 1.0, 101, -1.0, -1.0, 99, 0, -1, 99, -1.0, 100.0, 61.0, 0.0, 60, 59.0, NULL, -1.0, 60, 60, 0, NULL, 61, 99, 60, NULL, '%SLE%', 'default2', NULL, 101, 'SLE', NULL, 'SLE', '%SLE%', '%SLE%', NULL, 'default1', -1), (101, '2023-01-01', NULL, 60, 60, 101, 60.0, 100.0, -1.0, 100, 61.0, 99.0, 59, 0, 1, NULL, 99.0, 61.0, -1.0, 59.0, 61, 101.0, 59, 60.0, 59, 100, -1, NULL, 60, 61, 1, NULL, '%SLE%', 'default1', 1, 59, NULL, NULL, '%SLE%', 'default1', NULL, 'SLE', '%SLE%', 101), (1, '2023-01-01', 99, 61, 100, 60, 1.0, 1.0, 59.0, 59, 0.0, 59.0, NULL, 61, -1, 101, 60.0, 1.0, 59.0, 61.0, 100, 0.0, 0, NULL, 59, 61, 100, '%SLE%', 61, 100, 59, 'SLE', 'SLE', '%SLE%', 101, 99, 'SLE', 'default1', '%SLE%', 'default2', 'default1', 'default1', '%SLE%', 101), (1, '2023-01-02', 101, 99, 0, 0, 101.0, 1.0, 101.0, -1, 100.0, 0.0, 59, NULL, NULL, 60, 100.0, 0.0, 99.0, 99.0, -1, 100.0, 100, 99.0, 0, 99, 59, NULL, 99, 60, 101, 'default2', NULL, '%SLE%', 100, 99, NULL, 'SLE', '%SLE%', 'default2', 'default2', 'SLE', 'SLE', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(CASE WHEN T1.Diagnosis LIKE '%SLE%' THEN T1.ID ELSE 0 END) / COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2."GOT" >= 60;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT CAST(COUNT(DISTINCT "patient"."id") AS REAL) * 100 / (SELECT COUNT(DISTINCT "laboratory"."id") FROM "laboratory" WHERE "laboratory"."got" >= 60) FROM "laboratory" INNER JOIN "patient" ON "laboratory"."id" = "patient"."id" WHERE "laboratory"."got" >= 60 AND "patient"."diagnosis" = 'SLE';

/*
Prediction Result:
(100.0,)
*/