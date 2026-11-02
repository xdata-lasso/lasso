-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (59, 'default1', NULL, '2023-01-02', '2023-01-01', NULL, 'default1'), (0, 'default2', '2023-01-02', '2023-01-01', '2023-01-01', 'default2', 'default2'), (60, 'default2', '2023-01-01', '2023-01-02', NULL, 'default2', 'default1'), (61, 'default1', NULL, '2023-01-02', '2023-01-01', NULL, NULL), (1, 'default1', '2023-01-02', '2023-01-01', '2023-01-02', 'default2', 'default1'), (2, NULL, NULL, NULL, '2023-01-01', NULL, NULL), (3, NULL, NULL, '2023-01-01', '2023-01-01', 'default2', 'default1'), (4, 'default1', '2023-01-02', '2023-01-01', '2023-01-02', 'default1', 'default2'), (5, 'default2', NULL, NULL, '2023-01-01', 'default2', 'default1'), (6, 'default2', '2023-01-01', NULL, NULL, 'default1', 'default2'), (7, 'default1', NULL, '2023-01-02', '2023-01-01', 'default2', 'default1'), (8, NULL, '2023-01-02', '2023-01-01', '2023-01-01', 'default1', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (2, '2023-01-02', 60, 61, 61, 59, 59.0, 1.0, 60.0, NULL, 59.0, 59.0, 61, 1, 61, 60, 0.0, 61.0, 60.0, NULL, 59, 0.0, 59, 61.0, 1, NULL, 59, 'default1', 1, 60, 60, 'default1', 'default2', 'default2', 1, 60, 'default2', 'default1', NULL, 'default1', NULL, 'default2', 'default2', 59), (3, '2023-01-01', 61, 1, 59, 1, 0.0, 61.0, 1.0, 61, 59.0, 0.0, 0, 59, 0, NULL, 59.0, NULL, NULL, 1.0, 59, 61.0, 61, 60.0, NULL, NULL, 0, 'default2', 59, 60, 59, NULL, 'default1', 'default2', 60, 59, 'default1', 'default1', 'default2', 'default2', 'default1', 'default1', NULL, NULL), (8, '2023-01-02', NULL, 61, 1, 0, 60.0, 61.0, 59.0, 61, 60.0, 0.0, 1, 0, 1, 0, 1.0, 61.0, 59.0, 0.0, 0, 1.0, 59, 0.0, 60, 60, 60, 'default2', 61, 60, 60, 'default1', 'default1', 'default1', 59, NULL, NULL, 'default2', 'default1', NULL, NULL, 'default2', 'default2', 1), (8, '2023-01-01', 59, 1, 61, 61, 1.0, 0.0, 61.0, 1, NULL, 1.0, 1, 61, 59, 61, 59.0, 0.0, 1.0, 59.0, 61, 1.0, NULL, 60.0, 60, 1, 1, 'default2', 60, 59, 1, 'default1', 'default1', 'default1', 60, 60, 'default2', 'default2', 'default2', NULL, 'default1', 'default1', NULL, 59), (0, '2023-01-01', 61, 61, NULL, 1, 1.0, 1.0, 60.0, 60, NULL, NULL, 60, 61, 0, 60, 1.0, 60.0, 0.0, 61.0, 60, 61.0, 0, 61.0, 59, 61, 61, 'default1', 61, 60, NULL, 'default2', 'default1', 'default2', NULL, NULL, 'default2', NULL, NULL, 'default2', 'default2', NULL, 'default2', NULL), (60, '2023-01-01', 60, 1, 0, 1, NULL, 60.0, NULL, 1, NULL, 60.0, NULL, 0, NULL, 1, NULL, 59.0, 1.0, 1.0, NULL, 1.0, 61, NULL, 60, 1, 61, 'default1', 60, 59, NULL, 'default1', 'default2', 'default1', NULL, 61, 'default1', NULL, 'default1', NULL, NULL, 'default2', 'default1', 60), (1, '2023-01-01', 0, 61, 61, 1, NULL, NULL, 61.0, 59, 61.0, NULL, 61, NULL, 59, 61, 60.0, 59.0, NULL, 60.0, 1, 0.0, NULL, 61.0, 1, 61, 1, 'default1', 1, 59, 59, 'default1', 'default1', 'default2', 61, 59, NULL, 'default2', 'default2', NULL, 'default1', 'default1', 'default2', 0), (1, '2023-01-02', 61, 60, 1, 61, NULL, NULL, 59.0, 61, 0.0, 60.0, 61, 0, 61, 1, 61.0, 60.0, 0.0, 61.0, 61, 61.0, 1, 60.0, 1, 59, 59, 'default1', 61, 61, 61, 'default1', 'default1', 'default2', 0, 60, NULL, NULL, NULL, 'default2', 'default2', 'default2', NULL, 1), (59, '2023-01-01', 61, 60, 60, 61, 60.0, 1.0, 60.0, 59, 0.0, NULL, NULL, 0, 60, 61, 59.0, 61.0, 59.0, 61.0, 0, 59.0, 60, 59.0, 60, 59, 61, NULL, 59, 1, 0, 'default1', 'default2', 'default2', NULL, 60, 'default2', NULL, 'default1', NULL, NULL, 'default2', NULL, NULL), (59, '2023-01-02', 61, 60, 60, NULL, 61.0, 59.0, 61.0, 0, 1.0, 59.0, 60, NULL, 61, 0, 1.0, 1.0, 59.0, 60.0, 61, 61.0, 60, 60.0, 0, 0, NULL, NULL, 59, 60, 0, 'default2', 'default2', 'default1', 60, 1, 'default1', 'default1', 'default1', NULL, 'default1', 'default1', 'default2', 1), (61, '2023-01-01', 59, 1, 59, 59, 59.0, 59.0, 1.0, NULL, 60.0, 1.0, 60, 59, 0, 1, 59.0, 60.0, 59.0, 59.0, 0, 60.0, NULL, 60.0, 1, 60, 59, NULL, 59, 59, 1, 'default2', 'default2', NULL, 60, 0, 'default1', 'default1', NULL, NULL, NULL, 'default1', NULL, 59), (2, '2023-01-01', 60, 0, NULL, 1, 59.0, 1.0, 1.0, 1, 61.0, NULL, 59, 1, 1, 59, 61.0, 61.0, 61.0, 60.0, 59, 60.0, 59, 61.0, 1, 60, 1, 'default1', 0, 61, 60, NULL, NULL, 'default1', NULL, 59, 'default2', 'default2', 'default2', NULL, 'default2', 'default1', 'default2', 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GPT > 60 ORDER BY T1.Birthday ASC, T1.Diagnosis NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT P.Diagnosis FROM Patient AS P INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE L.GPT > 60 ORDER BY P.Birthday ASC, P.id NULLS LAST, L.id NULLS LAST, L.date NULLS LAST;

/*
Prediction Result:
(None,)
('default2',)
('default1',)
(None,)
*/