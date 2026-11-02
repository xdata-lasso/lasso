-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, '1981-12-%', '2023-01-01', NULL, '1981-11-27', NULL, 'default1'), (-1, 'default2', '2023-01-02', '1981-12-27', NULL, 'default1', NULL), (6, 'default1', '2023-01-02', '1981-11-27', '1959-02-17', '1959-02-18', '1981-11'), (0, NULL, '1981-11-27', '2023-01-01', '1959-02-19', '1981-11-%', '1959-02-18'), (2, NULL, '2023-01-02', '1981-11-27', '2023-01-02', 'default2', '1959-02-18'), (8, '1981-12', '1981-11-27', '1959-02-17', '1981-12-27', '1981-11', '1981-11-%'), (7, '1959-02-18', '1959-02-18', '2023-01-01', '1981-12-27', NULL, NULL), (3, '1981-11-%', '2023-01-02', '1959-02-18', '1959-02-18', '1981-11-%', 'default1'), (4, 'default2', '1959-02-19', '1959-02-19', '2023-01-01', '1981-11', '1981-12-%'), (5, '1981-11-%', '1981-12-27', '1959-02-19', '1959-02-19', '1981-11-%', 'default2'), (9, NULL, '1959-02-19', '2023-01-01', '1981-12-27', 'default1', '1981-12'), (10, NULL, '1981-11-27', '1981-11-27', NULL, '1981-12-%', '1959-02-18'), (11, '1981-11-%', '1959-02-18', '1981-11-27', '2023-01-02', 'default2', '1981-12-%'), (12, 'default1', '1981-12-27', '1959-02-19', NULL, NULL, 'default1'), (13, '1959-02-18', NULL, '1959-02-17', '1959-02-18', '1981-12-%', '1981-11-%'), (14, '1981-11', '2023-01-01', '2023-01-01', '1981-11-27', '1981-11-%', '1981-12-%'), (15, NULL, '1959-02-17', NULL, '1959-02-17', '1981-12-%', '1981-11-%'), (16, 'default2', '1981-11-27', '1959-02-18', '1981-12-27', '1981-11', '1959-02-18');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (9, '1959-02-17', 1, 0, 7, 8, 6.0, 6.0, -1.0, 0, 1.0, NULL, 6, 6, 6, 8, 6.0, 8.0, NULL, 1.0, 8, 0.0, 0, 0.0, 8, 1, 2, '1959-02-18', 1, 6, 1, 'default1', '1959-02-18', '1981-12-%', -1, 8, 'default1', 'default1', '1959-02-18', '1981-12', 'default2', 'default2', '1981-12-%', NULL), (11, '1981-12-27', 2, -1, 0, 6, 1.0, 7.0, NULL, 7, 7.0, 7.0, 8, 7, 8, 7, -1.0, 8.0, -1.0, 0.0, 8, 1.0, 1, 6.0, 2, 1, 7, NULL, -1, 7, 1, '1959-02-18', NULL, '1959-02-18', 7, 6, '1981-12', '1981-11-%', 'default1', '1981-11-%', NULL, 'default1', '1981-12', 8), (10, '1981-11-27', -1, -1, 2, 2, 2.0, 7.0, 0.0, 7, -1.0, 6.0, 0, 8, 8, 0, 0.0, 0.0, 2.0, 1.0, 2, 1.0, 2, 7.0, 1, 8, 6, '1959-02-18', 8, -1, 2, '1959-02-18', '1981-11', '1981-11-%', -1, 2, '1981-12-%', '1959-02-18', '1981-11', '1981-12', 'default2', '1981-12-%', 'default1', 0), (15, '1959-02-17', 6, -1, 8, -1, 0.0, -1.0, 0.0, 2, 6.0, 7.0, NULL, 6, 7, 0, 6.0, -1.0, 2.0, NULL, 1, 8.0, 7, NULL, 0, 2, 2, 'default2', 7, 2, 6, 'default2', 'default2', '1981-12', -1, 7, '1981-11', 'default1', NULL, '1981-11-%', '1981-12', '1981-12', '1981-12-%', 8), (2, '1959-02-19', NULL, NULL, 6, -1, 1.0, 7.0, -1.0, 2, 6.0, 1.0, NULL, 1, 1, NULL, 7.0, NULL, 8.0, 6.0, 1, 1.0, NULL, 6.0, 8, 7, 1, '1981-11', 2, 1, 7, '1981-11', '1981-12-%', '1959-02-18', 7, NULL, 'default2', NULL, '1981-11-%', '1981-12', '1981-12-%', '1981-11', '1981-11', -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN T2.Date LIKE '1981-11-%' THEN T2."T-CHO" ELSE 0 END) - SUM(CASE WHEN T2.Date LIKE '1981-12-%' THEN T2."T-CHO" ELSE 0 END)) AS REAL) / SUM(CASE WHEN T2.Date LIKE '1981-12-%' THEN T2."T-CHO" ELSE 0 END) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Birthday = '1959-02-18';

/*
Gold Result:
(-1.0,)
*/

-- Prediction Query
SELECT AVG(CASE WHEN SUBSTRING(T2."Date", 1, 7) = '1981-11' THEN T2."T-CHO" ELSE NULL END) - AVG(CASE WHEN SUBSTRING(T2."Date", 1, 7) = '1981-12' THEN T2."T-CHO" ELSE NULL END) AS decrease_rate FROM Laboratory AS T2 INNER JOIN Patient AS T1 ON T1.ID = T2.ID WHERE T1.Birthday = '1959-02-18';

/*
Prediction Result:
(None,)
*/