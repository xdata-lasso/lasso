-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (79, '1990-01-01', NULL, '1990-10-27', '1990-01-02', 'default2', NULL), (0, '%Y', '1989-12-31', '1990-10-27', '2023-01-02', NULL, NULL), (1, '1990-01-01', NULL, '1990-10-27', '2023-01-02', '1990', NULL), (499, 'default1', '1989-12-31', '2023-01-01', '1990-10-27', '1990', '1990-01-01'), (80, '%Y', '2023-01-01', NULL, '2023-01-01', NULL, '1990-01-01'), (81, '1990-01-01', '2023-01-02', NULL, '2023-01-01', 'default2', 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (0, '1990-01-01', 80, 79, 501, 500, 501.0, 501.0, 501.0, 499, 501.0, NULL, 500, 0, 499, 81, 79.0, 0.0, 0.0, 1.0, 499, 499.0, 500, 79.0, 500, 501, 501, '1990', 499, 80, 500, 'default2', '%Y', '1990', 81, 1, 'default2', '1990', '1990', '1990', '%Y', '1990-01-01', '1990-01-01', 501), (79, '1990-01-01', 499, 1, 0, 80, 499.0, 500.0, 81.0, 80, 79.0, 500.0, 0, 80, 501, 501, 80.0, 80.0, 79.0, 499.0, 1, 500.0, 81, 501.0, 500, 0, 79, '1990', 79, 501, 500, 'default1', '1990-01-01', 'default1', 1, 1, NULL, '%Y', '%Y', 'default2', '%Y', 'default1', '1990-01-01', 80), (79, '2023-01-01', NULL, 501, 79, 499, 79.0, 1.0, 501.0, 81, 499.0, 0.0, 80, 81, 81, 499, 500.0, 81.0, 0.0, 500.0, 500, NULL, 81, 79.0, 80, 500, 501, '1990', 0, 499, 499, 'default2', NULL, '%Y', 1, 1, NULL, '%Y', 'default2', '1990-01-01', '%Y', NULL, 'default1', 80), (80, '1990-01-01', 500, 79, 80, 500, 79.0, 501.0, 80.0, 499, 500.0, 79.0, 79, 0, 499, 501, 81.0, 81.0, 501.0, 499.0, 499, 501.0, 80, 499.0, 81, 79, 1, NULL, 500, 81, 499, 'default2', '1990-01-01', '%Y', 79, 1, '%Y', NULL, 'default2', 'default1', '%Y', '1990', '%Y', 79), (80, '1990-10-27', 0, 0, 1, 499, 500.0, NULL, 79.0, 500, 79.0, 500.0, 501, 79, 0, 500, 0.0, 80.0, NULL, 1.0, 500, 499.0, 499, NULL, 500, 501, 80, 'default1', 500, 81, NULL, '%Y', '1990', '%Y', 79, 501, '1990', 'default2', '%Y', '1990-01-01', '1990', 'default1', '1990-01-01', 81), (499, '1989-12-31', 499, 501, 500, 1, 1.0, 499.0, 81.0, 79, 81.0, 501.0, 500, NULL, 81, 499, 0.0, 80.0, 500.0, 501.0, 501, 501.0, NULL, 0.0, 499, NULL, 499, '1990-01-01', 80, 81, 81, 'default1', '1990-01-01', '1990-01-01', NULL, NULL, '1990', NULL, 'default1', '1990', '%Y', 'default1', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.IGA BETWEEN 80 AND 500 AND T1."First Date" > '1990-01-01';

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "patient"."id") FROM "patient" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" WHERE "laboratory"."iga" > 80 AND "laboratory"."iga" < 500 AND STRFTIME('%Y', "patient"."first date") >= '1990';

/*
Prediction Result:
(3,)
*/