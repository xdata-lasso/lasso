-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'negative', '2023-01-01', '2023-01-02', '2023-01-01', 'negative', 'default2'), (2, 'default2', '2023-01-01', '2023-01-01', '2023-01-02', NULL, '0'), (0, 'default1', '2023-01-02', '2023-01-02', '2023-01-02', 'default1', 'default2'), (3, 'negative', NULL, '2023-01-02', '2023-01-01', NULL, 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (0, '2023-01-01', 1, 3, 0, 0, NULL, 0.0, 3.0, 4, 2.0, 2.0, 0, 0, 1, 4, 2.0, 4.0, 4.0, 1.0, NULL, 4.0, 3, 4.0, NULL, 2, 1, 'negative', 2, 3, 2, 'default2', '0', NULL, 4, 0, 'default1', 'default1', 'default1', NULL, NULL, 'default2', '0', 0), (1, '2023-01-01', 1, NULL, 4, 4, 4.0, NULL, NULL, 0, 0.0, 0.0, 1, 3, NULL, 4, 2.0, 1.0, 0.0, 0.0, 4, 4.0, 3, 0.0, 4, 3, 4, 'negative', 1, 0, 0, 'default1', 'negative', '0', 0, 0, NULL, 'default1', NULL, 'negative', 'negative', 'negative', 'default1', 4), (0, '2023-01-02', 1, 4, 0, 2, 2.0, 1.0, NULL, 3, 1.0, NULL, NULL, 0, 1, 4, 0.0, NULL, 2.0, 1.0, 4, 1.0, NULL, 2.0, 1, 2, 1, 'default1', 4, 0, 0, 'default1', '0', 'default1', 4, 2, 'default2', NULL, 'default2', NULL, 'negative', 'negative', 'negative', 1), (1, '2023-01-02', 1, 2, 0, NULL, 4.0, 1.0, 0.0, 2, 0.0, 1.0, 4, 2, 0, 1, 0.0, NULL, 3.0, 0.0, 4, 1.0, NULL, 3.0, 0, 1, 3, 'negative', 1, 2, NULL, 'negative', '0', '0', 0, 1, 'default1', 'default2', 'default2', 'default1', 'default2', NULL, 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE NOT T2.SM IN ('negative', '0') ORDER BY T1.Birthday DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 3;

/*
Gold Result:
(0,)
(1,)
(1,)
*/

-- Prediction Query
SELECT DISTINCT p.ID FROM Patient AS p JOIN Laboratory AS l ON p.ID = l.ID WHERE NOT l.SM IN ('negative', '0') ORDER BY p.Birthday DESC, p.ID NULLS LAST LIMIT 3;

/*
Prediction Result:
(0,)
(1,)
*/