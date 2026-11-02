-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'M', '2023-01-02', '2023-01-01', NULL, NULL, NULL), (0, 'F', NULL, NULL, '2023-01-01', 'M', NULL), (2, 'default2', NULL, NULL, '2023-01-02', 'default2', 'default1'), (3, 'M', NULL, NULL, '2023-01-02', 'default1', 'default1'), (4, 'default1', '2023-01-02', '2023-01-01', '2023-01-02', 'default1', 'default2'), (5, 'default1', '2023-01-01', '2023-01-01', '2023-01-02', NULL, NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (3, '2023-01-01', NULL, NULL, NULL, 0, 2.0, 3.0, 1.0, NULL, 2.0, NULL, 1, NULL, NULL, 1, 2.0, 2.0, 0.0, 3.0, 1, NULL, 0, 3.0, 0, 0, NULL, 'default2', NULL, NULL, NULL, 'F', 'F', 'F', 0, 1, 'default1', NULL, 'F', 'default1', NULL, 'F', 'M', NULL), (5, '2023-01-02', 0, 1, 1, 1, 1.0, 3.0, 1.0, 1, 1.0, 3.0, 1, 0, 0, 1, 0.0, 1.0, 2.0, 1.0, 0, 3.0, 1, 0.0, 1, 1, 0, 'default1', NULL, 0, NULL, 'default2', NULL, 'default2', 0, NULL, 'F', 'F', 'default1', 'F', 'default1', 'default1', 'default2', 0), (1, '2023-01-01', 1, 0, NULL, NULL, 3.0, 0.0, 1.0, NULL, NULL, 0.0, 0, NULL, 1, 1, NULL, 1.0, 3.0, 2.0, 0, 1.0, NULL, 2.0, 1, NULL, 0, 'M', 1, 0, NULL, 'M', 'default2', NULL, 0, 1, 'F', NULL, 'default2', 'M', NULL, 'F', NULL, 1), (1, '2023-01-02', NULL, 0, NULL, 1, 0.0, 3.0, 0.0, 1, 0.0, 1.0, NULL, NULL, 1, NULL, NULL, 1.0, 1.0, 2.0, 1, 2.0, NULL, 3.0, NULL, 0, 0, 'F', NULL, 1, NULL, 'M', 'default1', NULL, 0, NULL, NULL, 'M', 'M', 'F', 'default2', 'default1', 'default2', 1), (4, '2023-01-02', 1, 1, 0, 0, NULL, NULL, 2.0, 1, 2.0, 1.0, NULL, 1, 1, NULL, 0.0, 0.0, 0.0, 3.0, NULL, 0.0, 0, 0.0, 0, NULL, 0, 'F', 1, NULL, 1, NULL, 'default2', 'M', NULL, NULL, 'M', 'default1', 'M', 'default1', 'default1', 'F', 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT CASE WHEN T1.SEX = 'F' THEN T1.ID END, CASE WHEN T1.SEX = 'M' THEN T1.ID END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2."T-BIL" >= 2.0;

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT "patient"."sex", GROUP_CONCAT(DISTINCT "patient"."id") FROM "patient" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" WHERE "laboratory"."t-bil" >= 2.0 GROUP BY "patient"."sex";

/*
Prediction Result:
('default1', '5')
*/