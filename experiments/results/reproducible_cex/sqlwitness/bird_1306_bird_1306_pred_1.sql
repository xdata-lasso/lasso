-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (9, 'default1', '2023-01-02', '2023-01-01', NULL, NULL, 'default2'), (1, NULL, NULL, '2023-01-02', '2023-01-01', 'SLE', 'SLE'), (0, 'default2', '2023-01-01', '2023-01-02', NULL, 'default2', NULL), (8, 'default2', NULL, '2023-01-01', NULL, 'default1', 'SLE'), (10, 'default2', NULL, '2023-01-02', '2023-01-01', NULL, 'SLE'), (2, 'default1', NULL, '2023-01-01', '2023-01-01', 'default1', 'SLE'), (3, 'SLE', NULL, '2023-01-02', NULL, 'default2', 'SLE'), (4, NULL, '2023-01-01', '2023-01-02', NULL, 'SLE', 'SLE'), (5, NULL, '2023-01-02', NULL, NULL, 'SLE', 'default1');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (2, '2023-01-02', 10, 9, 8, 0, 10.0, 4.5, 3.5, NULL, 4.5, 8.0, NULL, 10, NULL, 10, 8.0, 4.5, 8.0, 8.0, 9, NULL, 10, 0.0, 9, 9, NULL, 'SLE', NULL, NULL, 0, 'default2', NULL, NULL, 8, 8, 'default2', 'default1', 'default2', 'default2', NULL, 'default2', 'default1', 9), (9, '2023-01-02', 0, 8, 0, 1, 10.0, 10.0, 2.5, 0, 10.0, 9.0, 1, 8, 8, 1, 2.5, 8.0, 9.0, 9.0, 0, 0.0, 0, 10.0, 0, 9, 9, 'default1', 10, NULL, 8, 'default1', NULL, NULL, 1, 10, 'SLE', 'default1', 'default1', 'default1', NULL, 'SLE', NULL, 9), (3, '2023-01-02', NULL, 1, 0, 8, NULL, NULL, 4.5, 0, 10.0, 0.0, 1, NULL, NULL, NULL, 9.0, 10.0, 8.0, 3.5, 1, NULL, 1, 2.5, 10, 8, 9, 'SLE', 10, 8, 10, 'default2', NULL, 'default1', 1, NULL, 'default1', 'SLE', NULL, 'SLE', 'SLE', 'SLE', NULL, NULL), (4, '2023-01-02', 10, 0, 0, 9, 2.5, 1.0, 0.0, NULL, 10.0, 10.0, NULL, 0, 9, 1, 3.5, 10.0, 2.5, 3.5, 8, 10.0, 10, 1.0, 1, 10, 9, NULL, 9, 1, 0, 'default1', NULL, 'default2', 1, 1, NULL, 'SLE', 'default2', 'default1', 'default2', 'SLE', 'default2', NULL), (9, '2023-01-01', 8, NULL, 8, 10, NULL, 9.0, 1.0, NULL, 0.0, 4.5, 8, 8, 0, 9, 3.5, 2.5, 1.0, 1.0, 1, 10.0, NULL, 10.0, 0, 8, 1, 'default2', NULL, 0, 9, NULL, 'SLE', 'default2', 9, 8, 'default1', 'default2', 'default2', 'default2', 'default1', 'default1', 'default1', 0), (4, '2023-01-01', 10, NULL, 0, 9, 10.0, 8.0, 2.5, NULL, 10.0, 4.5, 1, NULL, 0, 10, NULL, 0.0, 9.0, 1.0, 9, 4.5, 1, 3.5, NULL, 8, 8, 'SLE', 1, 1, 1, 'default1', 'SLE', 'default1', 9, 0, 'SLE', 'default1', 'default1', 'default2', 'SLE', 'default2', 'default1', NULL), (2, '2023-01-01', 10, 1, 8, 8, 1.0, 4.5, 1.0, 9, 1.0, 0.0, 10, 9, 0, 1, 9.0, 9.0, 2.5, 1.0, 8, 4.5, 10, 1.0, 8, 8, 1, NULL, 10, 8, 10, 'default2', NULL, 'default2', 9, 8, 'default2', 'default2', NULL, 'default2', NULL, 'SLE', 'default1', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Diagnosis = 'SLE' AND T2.WBC BETWEEN 3.5 AND 9;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT P.ID) AS Normal_WBC_Count FROM Patient AS P INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE P.Diagnosis = 'SLE' AND L.WBC BETWEEN 3.5 AND 9.0;

/*
Prediction Result:
(3,)
*/