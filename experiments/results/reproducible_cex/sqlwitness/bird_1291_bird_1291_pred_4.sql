-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'default2', '2023-01-02', NULL, '2023-01-01', 'default2', NULL), (0, 'M', '2023-01-01', '2023-01-02', '2023-01-01', 'default2', NULL), (2, 'M', '2023-01-02', '2023-01-01', '2023-01-02', 'default1', 'default1'), (3, 'default2', '2023-01-02', '2023-01-01', '2023-01-02', 'M', 'default2'), (4, 'M', NULL, '2023-01-02', '2023-01-02', 'M', NULL), (5, NULL, NULL, '2023-01-01', '2023-01-02', NULL, 'default1'), (6, 'M', '2023-01-01', '2023-01-02', NULL, 'M', 'default2'), (7, 'M', '2023-01-01', '2023-01-01', '2023-01-02', NULL, 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (1, '2023-01-01', 0, 1, NULL, 1, 8.5, NULL, 9.5, 1, 3.5, 2.5, NULL, 1, 1, 1, 0.0, 6.5, 6.0, 7.0, 1, 7.5, NULL, NULL, 0, NULL, 1, NULL, NULL, NULL, 1, NULL, 'default1', 'default1', 0, NULL, 'default2', 'M', 'default2', 'M', 'default1', 'M', NULL, NULL), (0, '2023-01-02', NULL, 0, 1, 0, 5.5, 5.5, 8.5, 1, 2.5, 4.5, 1, 0, 1, 1, 0.0, 2.5, 5.0, 1.0, 1, 6.0, 0, 9.5, 1, 1, NULL, NULL, NULL, 0, NULL, 'default1', NULL, 'M', 1, 0, 'default2', 'default1', 'default1', NULL, 'M', 'M', 'M', 0), (1, '2023-01-02', NULL, NULL, NULL, 0, 5.5, 1.0, 5.5, NULL, 7.0, 7.5, NULL, NULL, NULL, 0, 5.5, NULL, 7.0, 6.0, 1, NULL, NULL, 9.5, 0, NULL, NULL, 'default2', NULL, NULL, 1, 'default2', 'default1', NULL, 0, 0, 'M', 'default2', 'default2', 'M', 'default2', 'M', 'default2', 1), (7, '2023-01-01', NULL, 0, 0, 1, 8.5, 3.5, 7.0, 0, 5.0, 6.0, 0, 0, 0, 1, 6.0, 9.5, 3.5, 9.5, 0, 2.5, 0, 8.5, 1, NULL, 1, 'M', NULL, 0, 0, 'M', 'default1', 'default2', 0, 0, 'default2', NULL, NULL, 'default2', 'default2', 'M', 'M', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.SEX = 'M' AND T2.ALB BETWEEN 3.5 AND 5.5 AND T2.TP BETWEEN 6.0 AND 8.5;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.SEX = 'M' AND T2.ALB > 3.5 AND T2.ALB < 5.5 AND T2.TP BETWEEN 6.0 AND 8.5;

/*
Prediction Result:
(0,)
*/