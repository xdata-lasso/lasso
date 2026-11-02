-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (53, NULL, NULL, '2023-01-02', NULL, NULL, 'default1'), (51, 'default2', '2025-01-01', '2023-01-02', '2023-01-01', '%Y', 'default2'), (3, 'default1', '2023-01-01', '2023-01-01', '2025-01-01', '2025-01-01 00:00:00', '2025-01-01 00:00:00'), (2, 'default2', '2023-01-02', '2023-01-02', '2025-01-01', '2025-01-01 00:00:00', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (51, '2025-01-01', 3, 52, 1, 0, 53.0, 52.0, 53.0, 0, NULL, 53.0, 0, 1, 2, 52, 53.0, 2.0, NULL, 52.0, 0, 0.0, 52, 1.0, NULL, 51, NULL, 'default1', 52, 53, 52, 'default2', '%Y', 'default1', NULL, 0, 'default2', 'default2', 'default1', 'default2', '%Y', 'default1', 'default2', 51), (3, '2025-01-01', 52, 52, NULL, NULL, 2.0, 1.0, 51.0, 51, NULL, 1.0, 53, NULL, 53, 53, 1.0, 52.0, 3.0, 0.0, 52, 3.0, 53, 2.0, 53, 3, 52, NULL, 52, 53, 53, 'default1', 'default2', '2025-01-01 00:00:00', 51, 3, NULL, NULL, '%Y', NULL, '%Y', NULL, 'default1', NULL), (51, '2023-01-02', 3, 3, 52, 3, 51.0, 0.0, 0.0, 0, 52.0, 53.0, 2, 1, 0, NULL, 51.0, 2.0, 3.0, 52.0, NULL, 51.0, 3, 53.0, 53, 52, 1, '2025-01-01 00:00:00', 53, 52, 3, 'default2', 'default1', '2025-01-01 00:00:00', 52, 0, '%Y', 'default2', NULL, 'default2', '%Y', 'default1', '2025-01-01 00:00:00', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.ID IN (SELECT ID FROM Laboratory WHERE HCT >= 52 GROUP BY ID HAVING COUNT(ID) >= 2);

/*
Gold Result:
(51, 0)
*/

-- Prediction Query
SELECT "patient"."id", (STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', "patient"."birthday")) AS age FROM "patient" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" WHERE "laboratory"."hct" >= 52 GROUP BY "patient"."id" HAVING COUNT("laboratory"."id") > 2;

/*
Prediction Result:
*/