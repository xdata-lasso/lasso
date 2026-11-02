-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (99, 'default1', '2023-01-01', '2023-01-02', '2023-01-01', 'default1', 'default2'), (399, 'default2', '2023-01-01', '2023-01-02', NULL, 'default1', 'default2'), (0, 'default1', '2023-01-01', NULL, NULL, 'default1', NULL), (400, NULL, '2023-01-02', '2023-01-02', '2023-01-01', 'default2', 'default1'), (1, 'default1', NULL, '2023-01-01', '2023-01-02', 'default2', NULL), (401, 'default1', '2023-01-02', NULL, '2023-01-02', NULL, NULL), (100, 'default1', '2023-01-01', NULL, '2023-01-02', 'default2', 'default1'), (101, 'default2', '2023-01-02', NULL, '2023-01-01', 'default1', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (100, '2023-01-02', NULL, 0, 1, 1, 1.0, 401.0, 101.0, 399, 0.0, 0.0, NULL, 0, 101, 100, 399.0, 400.0, 99.0, 400.0, 100, 1.0, 401, 401.0, 399, 401, 99, 'default1', 401, 0, 0, 'default1', 'default1', 'default2', 1, 1, 'default1', 'default1', NULL, 'default2', 'default1', NULL, 'default2', 400), (101, '2023-01-02', 400, 399, 100, 100, NULL, 400.0, 99.0, 100, 100.0, 101.0, 0, 0, 101, 100, NULL, 401.0, 400.0, 99.0, NULL, 401.0, 99, 401.0, 399, 0, 101, NULL, 399, NULL, 400, NULL, 'default1', 'default1', 99, 99, 'default1', 'default2', 'default2', 'default1', 'default1', 'default1', 'default2', 101), (1, '2023-01-01', NULL, 400, 101, 101, 400.0, 1.0, 101.0, 100, 0.0, 400.0, 400, 399, 399, 1, 101.0, 100.0, 101.0, 0.0, 400, 401.0, 401, NULL, 99, 400, 1, 'default1', 1, 401, 101, 'default2', NULL, 'default2', 100, 1, 'default2', 'default2', 'default2', 'default2', 'default1', 'default2', NULL, 400), (0, '2023-01-02', 401, 400, 101, 401, 400.0, NULL, 1.0, 100, 1.0, 399.0, 101, NULL, 100, 0, 400.0, NULL, 1.0, 400.0, 101, 0.0, 100, 0.0, 1, 400, 399, NULL, 400, 100, 101, 'default2', 'default2', 'default1', 101, 101, 'default2', NULL, 'default1', NULL, 'default1', 'default2', 'default1', 399), (99, '2023-01-01', 99, 400, 0, 1, 1.0, 0.0, 401.0, 0, 401.0, NULL, 99, 0, 0, 100, NULL, 399.0, 400.0, 399.0, 401, 401.0, 100, NULL, 99, 400, 401, 'default2', 0, 100, 400, 'default2', 'default1', 'default2', 399, 399, 'default1', 'default2', 'default1', 'default2', NULL, 'default2', NULL, 400), (99, '2023-01-02', 401, 99, 0, 401, NULL, 401.0, 401.0, 1, 400.0, 101.0, 401, 99, 100, NULL, 400.0, 99.0, 0.0, 0.0, 401, 100.0, 1, 99.0, 99, 401, 400, NULL, 1, 99, 100, 'default1', 'default2', 'default1', 400, 400, 'default1', NULL, 'default1', 'default1', NULL, 'default2', 'default2', 99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.PLT BETWEEN 100 AND 400 AND NOT T1.Diagnosis IS NULL;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.PLT > 100 AND T2.PLT < 400 AND NOT T1.Diagnosis IS NULL;

/*
Prediction Result:
(0,)
*/