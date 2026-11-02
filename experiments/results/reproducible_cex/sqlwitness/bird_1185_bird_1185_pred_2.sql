-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, '1981-11-%', '1959-02-18', '1959-02-19', '1959-02-18', NULL, NULL), (1, '1981-12-%', '1959-02-18', NULL, '1959-02-19', '1981-11-%', '1981-12-%'), (-1, 'default2', '1959-02-18', NULL, NULL, '1981-11-%', NULL), (2, '1981-11-%', '2023-01-01', '2023-01-01', '1959-02-17', 'default1', 'default1'), (3, 'default1', '1959-02-17', '1959-02-19', '2023-01-01', '1981-11-%', 'default1'), (4, 'default2', '1959-02-18', NULL, '2023-01-02', 'default1', 'default2'), (5, '1981-12-%', NULL, '1959-02-18', '1959-02-19', NULL, '1959-02-18'), (6, NULL, '2023-01-02', NULL, '1959-02-17', '1981-11-%', 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (5, '1959-02-17', 1, -1, NULL, NULL, 0.0, 0.0, 1.0, -1, -1.0, -1.0, 0, 1, 0, -1, NULL, NULL, 0.0, NULL, 0, -1.0, 1, 1.0, -1, NULL, -1, 'default2', -1, 0, -1, '1959-02-18', 'default2', 'default2', 1, 1, NULL, '1959-02-18', 'default2', 'default1', '1981-12-%', NULL, '1981-11-%', 0), (2, '1959-02-18', -1, 0, 0, 1, 0.0, -1.0, NULL, 1, NULL, NULL, -1, 0, -1, 0, 1.0, 1.0, -1.0, -1.0, 0, 1.0, -1, -1.0, 0, NULL, NULL, '1981-11-%', 1, NULL, -1, '1981-12-%', NULL, 'default1', -1, 1, '1981-11-%', 'default2', '1981-12-%', '1959-02-18', '1959-02-18', '1981-12-%', 'default2', -1), (4, '1959-02-18', -1, 0, -1, -1, NULL, 1.0, 0.0, 0, NULL, 1.0, 1, 1, 1, -1, 0.0, NULL, 0.0, 0.0, 1, 0.0, -1, NULL, NULL, 1, 0, 'default2', 1, -1, NULL, 'default2', '1981-11-%', '1981-12-%', -1, 1, 'default2', '1959-02-18', '1981-11-%', 'default2', '1959-02-18', NULL, '1981-12-%', -1), (-1, '1959-02-18', NULL, 0, NULL, 1, NULL, -1.0, NULL, 1, 1.0, 0.0, 0, 0, 1, NULL, 0.0, 1.0, 0.0, 0.0, 0, -1.0, 1, 1.0, 1, 1, 1, '1981-11-%', 1, -1, 1, '1981-11-%', '1981-12-%', '1981-12-%', -1, NULL, '1981-12-%', 'default2', '1981-11-%', 'default2', 'default1', '1981-11-%', 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN T2.Date LIKE '1981-11-%' THEN T2."T-CHO" ELSE 0 END) - SUM(CASE WHEN T2.Date LIKE '1981-12-%' THEN T2."T-CHO" ELSE 0 END)) AS REAL) / SUM(CASE WHEN T2.Date LIKE '1981-12-%' THEN T2."T-CHO" ELSE 0 END) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Birthday = '1959-02-18';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN "laboratory"."date" LIKE '1981-11-%' THEN "laboratory"."t-cho" ELSE 0 END) - SUM(CASE WHEN "laboratory"."date" LIKE '1981-12-%' THEN "laboratory"."t-cho" ELSE 0 END)) AS decrease_rate FROM "laboratory" INNER JOIN "patient" ON "laboratory"."id" = "patient"."id" WHERE "patient"."birthday" = '1959-02-18';

/*
Prediction Result:
(0,)
*/