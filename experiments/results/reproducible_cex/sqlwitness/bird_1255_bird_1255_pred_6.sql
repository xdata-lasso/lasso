-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'default2', '2023-01-02', '2023-01-01', NULL, 'default2', 'default1'), (41, 'default1', NULL, '2023-01-01', '2023-01-02', NULL, 'default1'), (40, NULL, NULL, '2023-01-01', '2023-01-01', 'default2', NULL), (39, 'default1', NULL, '2023-01-01', '2023-01-01', NULL, NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (41, '2023-01-01', 401, 41, 0, 39, 39.0, 399.0, NULL, 399, 0.0, 399.0, 0, 0, 39, 399, NULL, 39.0, 399.0, 401.0, 400, 401.0, 401, 39.0, NULL, 2, NULL, 'default1', 40, 399, 40, NULL, 'default2', 'default1', 2, 2, NULL, 'default2', 'default1', 'default2', 'default1', 'default1', NULL, 39), (1, '2023-01-01', NULL, 40, 401, 1, NULL, 40.0, 400.0, 40, 39.0, 40.0, 0, 2, 39, NULL, 0.0, 2.0, 2.0, 41.0, 39, 40.0, 400, 0.0, 0, 2, 1, 'default1', 2, 0, 40, 'default1', NULL, 'default2', 401, 0, 'default1', 'default1', 'default1', 'default1', 'default2', NULL, 'default2', NULL), (1, '2023-01-02', 0, 41, 1, 400, 41.0, 39.0, 2.0, 399, 0.0, 0.0, 1, 400, 400, 401, 39.0, 39.0, 1.0, 40.0, NULL, 401.0, 2, 2.0, 400, 0, 2, NULL, 39, 2, 399, 'default2', NULL, 'default2', 0, 2, 'default2', 'default1', 'default2', 'default1', NULL, 'default2', 'default1', 400), (39, '2023-01-02', 0, 399, 400, 2, 0.0, 0.0, 41.0, 2, 40.0, 401.0, 401, 400, 1, 0, 400.0, 40.0, 41.0, 400.0, 1, 399.0, 401, NULL, 400, 399, 0, NULL, 399, 39, 399, 'default2', 'default1', NULL, 1, 41, NULL, 'default2', 'default2', 'default1', 'default1', 'default1', 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE NOT T2.IGM BETWEEN 40 AND 400 GROUP BY T1.Diagnosis ORDER BY COUNT(T1.Diagnosis) DESC, T1.Diagnosis NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Diagnosis FROM Patient AS T1 JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.IGM <= 40 OR T2.IGM >= 400 GROUP BY T1.Diagnosis ORDER BY COUNT(*) DESC, T1.Diagnosis NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/