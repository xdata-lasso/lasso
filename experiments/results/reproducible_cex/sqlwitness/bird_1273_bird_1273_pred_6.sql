-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'SLE', '2023-01-01', '2023-01-02', NULL, 'SLE', 'SLE'), (0, 'SLE', NULL, NULL, NULL, 'negative', '-'), (2, 'negative', '2023-01-02', '2023-01-02', '2023-01-01', 'SLE', '-'), (3, 'default1', '2023-01-01', '2023-01-01', '2023-01-02', NULL, 'default2'), (4, '0', '2023-01-02', '2023-01-01', '2023-01-02', 'default2', 'SLE'), (5, 'default1', '2023-01-01', '2023-01-02', NULL, 'negative', 'negative'), (6, 'default2', NULL, '2023-01-02', NULL, 'default2', 'SLE'), (7, '0', NULL, '2023-01-02', '2023-01-01', NULL, 'default2'), (8, '-', NULL, '2023-01-01', '2023-01-02', NULL, 'default2'), (9, '0', '2023-01-02', NULL, '2023-01-02', '0', '-'), (10, 'SLE', '2023-01-01', NULL, NULL, 'negative', 'SLE'), (11, '-', '2023-01-02', '2023-01-02', '2023-01-01', '0', '-'), (12, 'SLE', '2023-01-02', '2023-01-02', '2023-01-02', '-', 'default2'), (13, '-', NULL, '2023-01-02', '2023-01-01', 'negative', 'SLE'), (14, 'default1', NULL, '2023-01-01', '2023-01-02', 'default2', '-');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (9, '2023-01-01', 0, NULL, 1, 1, 1.0, 0.0, 1.0, NULL, 0.0, NULL, 1, 0, NULL, NULL, 1.0, NULL, 0.0, NULL, 0, 1.0, 1, NULL, 0, NULL, NULL, 'negative', 1, NULL, NULL, '-', '0', 'default1', 0, 0, '0', 'default1', 'negative', 'default1', NULL, '0', 'negative', 1), (14, '2023-01-02', 0, NULL, 0, 0, 0.0, 0.0, 1.0, 1, NULL, 0.0, 1, NULL, NULL, 0, 0.0, 1.0, NULL, 0.0, 1, 0.0, NULL, 0.0, NULL, 1, 0, 'default2', NULL, 1, 0, 'SLE', 'negative', '-', 0, NULL, 'negative', '-', 'default2', 'negative', '0', 'default1', 'default2', 0), (5, '2023-01-01', NULL, 1, 0, 0, 0.0, 1.0, 0.0, 0, 0.0, NULL, NULL, NULL, 1, 0, 1.0, 0.0, 0.0, NULL, 1, NULL, 0, 0.0, 1, 1, 1, '0', NULL, NULL, 0, '-', NULL, NULL, 0, 1, NULL, 'default1', 'SLE', '-', 'negative', 'default2', '0', 1), (11, '2023-01-01', 1, NULL, NULL, 1, 0.0, 0.0, 1.0, 1, NULL, 1.0, NULL, 1, NULL, 0, NULL, 1.0, 1.0, 1.0, 0, 1.0, 0, 1.0, 0, NULL, 1, 'default2', 0, 1, NULL, 'negative', '-', NULL, 0, 1, 'default2', 'default2', '0', '0', 'negative', NULL, '0', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.SSB = 'negative' OR '0' AND T1.Diagnosis = 'SLE';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT P.ID) FROM Patient AS P JOIN Laboratory AS L ON P.ID = L.ID WHERE P.Diagnosis = 'SLE' AND (L.SSB = '-' OR L.SSB = '0');

/*
Prediction Result:
(0,)
*/