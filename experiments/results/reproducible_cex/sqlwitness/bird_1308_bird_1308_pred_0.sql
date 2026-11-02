-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (101, 'default2', '2023-01-01', '2023-01-02', '2023-01-02', 'default1', 'default1'), (99, 'default1', NULL, '2023-01-01', '2023-01-02', 'default1', 'default1'), (399, 'default1', '2023-01-02', '2023-01-01', NULL, 'default2', NULL), (1, 'default2', '2023-01-01', NULL, '2023-01-01', 'default1', NULL), (400, 'default1', '2023-01-02', '2023-01-01', NULL, 'default2', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (101, '2023-01-01', 401, 399, 400, 399, 400.0, 0.0, 401.0, 401, 1.0, 401.0, 99, 100, 399, 400, 399.0, 399.0, 99.0, NULL, 400, 101.0, 401, 399.0, 400, NULL, 100, 'default2', 0, 0, 0, 'default1', 'default1', NULL, 0, 399, NULL, 'default2', 'default1', 'default1', 'default1', 'default2', 'default1', 0), (101, '2023-01-02', NULL, 100, NULL, 401, 401.0, 400.0, 400.0, 99, 399.0, 1.0, 100, 400, 401, 1, 1.0, 399.0, 0.0, NULL, 401, 1.0, 1, 1.0, 0, 399, 401, 'default2', 99, 0, 99, 'default2', 'default2', 'default1', NULL, 100, NULL, NULL, 'default2', NULL, 'default2', 'default2', NULL, 99), (399, '2023-01-01', 100, 400, 400, 1, 101.0, 101.0, 401.0, 400, 101.0, 100.0, 401, 0, 399, 99, 399.0, 0.0, NULL, 399.0, 0, NULL, 400, 401.0, 0, 100, 101, 'default2', 100, 100, 99, 'default2', NULL, 'default2', 399, 101, NULL, 'default1', 'default2', NULL, 'default2', 'default1', 'default1', 1), (1, '2023-01-01', 401, 100, 401, 0, 1.0, 399.0, NULL, 399, 401.0, 100.0, 99, 400, 0, NULL, 99.0, NULL, NULL, 1.0, 399, NULL, 0, 101.0, 1, 400, 401, 'default2', 100, 1, 99, NULL, 'default2', NULL, NULL, 101, 'default2', 'default2', 'default1', NULL, 'default2', 'default1', 'default2', 100), (99, '2023-01-01', 101, 399, 101, 100, 399.0, 100.0, 400.0, NULL, 101.0, 100.0, 0, 399, 401, 101, 1.0, NULL, 99.0, 400.0, 0, NULL, 399, 399.0, 400, 400, 101, 'default2', NULL, 101, 400, 'default1', 'default2', 'default2', 401, 400, 'default2', 'default2', 'default2', 'default2', 'default2', NULL, 'default2', 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.PLT BETWEEN 100 AND 400 AND NOT T1.Diagnosis IS NULL;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.PLT > 100 AND T2.PLT < 400 AND NOT T1.Diagnosis IS NULL;

/*
Prediction Result:
(0,)
*/