-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (61, NULL, '2023-01-01', '1994-10-27', '1994-10-27', '1994', 'default2'), (60, '1994', NULL, '2023-01-02', NULL, 'default1', '%Y'), (0, 'default2', '1994-10-27', NULL, '2023-01-02', '1994', 'default1'), (1, 'default1', '2023-01-02', '2023-01-01', '1994-10-27', '1994', '1994'), (59, NULL, '2023-01-01', '2023-01-02', NULL, NULL, 'default1'), (2, '%Y', '1994-10-27', NULL, NULL, 'default2', 'default2'), (3, '%Y', NULL, '1994-10-27', '2023-01-02', NULL, '%Y');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (60, '2023-01-02', 59, 0, 59, 60, 61.0, 59.0, 0.0, 1, 59.0, 59.0, 0, 1, 1, 59, 60.0, 59.0, 1.0, 60.0, NULL, 59.0, 61, 1.0, 59, 1, 0, 'default1', 60, 60, 59, '1994', '1994', NULL, 60, 1, '1994', 'default2', '%Y', '%Y', '1994', NULL, 'default2', NULL), (2, '1994-10-27', 59, 1, 61, NULL, 60.0, NULL, 61.0, 0, 61.0, 1.0, 0, 59, 60, 61, 60.0, 1.0, 59.0, NULL, 0, 60.0, 61, 59.0, 59, 60, 60, '%Y', 59, 61, 59, 'default1', 'default2', 'default1', 1, NULL, 'default2', '1994', NULL, '%Y', '1994', 'default1', NULL, 1), (61, '1994-10-27', 60, NULL, 0, 60, 60.0, 59.0, NULL, NULL, NULL, 1.0, 59, 61, 1, 59, 1.0, NULL, 59.0, NULL, NULL, 59.0, 0, 1.0, 60, 59, 1, '1994', 60, 59, 59, '1994', '1994', 'default1', 1, 61, 'default2', NULL, 'default1', NULL, 'default1', 'default1', 'default2', 60), (0, '1994-10-27', 61, 60, 61, 1, 1.0, 61.0, 60.0, NULL, NULL, 0.0, 0, NULL, 61, 61, 59.0, 1.0, 1.0, NULL, 0, 61.0, 59, 60.0, 1, 0, 0, NULL, 0, 1, 60, '%Y', 'default2', '1994', 1, 1, 'default2', '1994', '%Y', NULL, 'default2', 'default1', '%Y', 60), (59, '2023-01-01', 59, 0, NULL, 0, 0.0, 60.0, 0.0, 61, 1.0, 60.0, 60, 0, 1, 1, 59.0, 59.0, 1.0, 61.0, 1, 59.0, 0, 60.0, NULL, NULL, 60, 'default2', 61, 61, 60, 'default1', '%Y', 'default2', 59, 61, '1994', NULL, NULL, 'default2', NULL, 'default2', 'default1', 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.SEX, T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GOT < 60 AND STRFTIME('%Y', T2.Date) = '1994';

/*
Gold Result:
('%Y', '1994-10-27')
*/

-- Prediction Query
SELECT "patient"."id", "patient"."sex", "patient"."birthday" FROM "patient" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" WHERE "laboratory"."got" < 60 AND STRFTIME('%Y', "laboratory"."date") = '1994';

/*
Prediction Result:
(2, '%Y', '1994-10-27')
*/