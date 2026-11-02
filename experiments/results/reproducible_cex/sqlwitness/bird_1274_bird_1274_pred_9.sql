-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, NULL, '2023-01-02', '2023-01-02', '2023-01-02', 'negative', 'default1'), (0, '0', '2023-01-02', NULL, NULL, NULL, 'default2'), (2, '0', '2023-01-02', NULL, '2023-01-01', NULL, '0'), (3, 'default2', NULL, NULL, '2023-01-02', 'default1', 'default2'), (4, 'default1', NULL, NULL, NULL, 'default2', 'negative'), (5, 'default1', '2023-01-02', '2023-01-02', NULL, NULL, 'default1'), (6, 'default1', '2023-01-02', '2023-01-02', '2023-01-02', 'default1', '0'), (7, '0', NULL, '2023-01-01', NULL, 'default1', NULL), (8, 'default2', NULL, NULL, '2023-01-01', 'negative', 'negative'), (9, '0', NULL, '2023-01-01', '2023-01-01', 'negative', 'default1'), (10, 'default2', NULL, '2023-01-01', '2023-01-02', 'default2', 'default1'), (11, NULL, '2023-01-02', '2023-01-01', '2023-01-02', 'negative', NULL), (12, 'default2', '2023-01-02', '2023-01-01', '2023-01-02', 'default1', 'negative');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (6, '2023-01-01', 1, 0, 0, NULL, NULL, 0.0, 1.0, 0, 1.0, NULL, NULL, 0, 0, 1, NULL, 0.0, 1.0, NULL, 0, 1.0, NULL, 0.0, 1, 1, NULL, 'default2', NULL, NULL, 1, NULL, NULL, NULL, 0, 0, '0', NULL, 'default1', NULL, '0', NULL, '0', 1), (2, '2023-01-02', 1, NULL, 0, 0, 1.0, 0.0, 1.0, 0, 0.0, 0.0, 0, 0, 0, 1, NULL, NULL, 1.0, NULL, NULL, 1.0, 0, 1.0, 1, 0, 0, 'default1', 1, 0, 1, 'default2', '0', NULL, 1, NULL, NULL, 'negative', 'default1', 'default2', '0', 'default2', 'default1', 0), (5, '2023-01-01', 0, NULL, 0, 0, 1.0, NULL, 0.0, NULL, NULL, NULL, 0, 1, 1, 1, 1.0, NULL, 0.0, NULL, 0, 0.0, NULL, 1.0, 0, 0, 0, 'negative', NULL, 0, NULL, 'default2', '0', NULL, 0, 0, NULL, 'negative', 'default1', 'default1', '0', 'default1', 'negative', 1), (1, '2023-01-01', NULL, 0, NULL, 1, 1.0, 1.0, 1.0, NULL, NULL, NULL, 0, 0, NULL, 1, NULL, 1.0, 1.0, 0.0, 0, 1.0, 0, 1.0, 1, 0, NULL, NULL, NULL, 1, NULL, '0', 'default2', 'negative', 0, 0, 'negative', 'negative', 'default2', 'default2', 'default1', '0', 'default2', 0), (5, '2023-01-02', 1, 0, 0, NULL, 0.0, NULL, 0.0, 0, 1.0, NULL, 1, 1, NULL, 1, 1.0, 0.0, NULL, 0.0, NULL, NULL, NULL, 0.0, 0, 1, NULL, 'default2', 0, 1, 1, 'default1', '0', 'default1', 1, NULL, 'default1', '0', 'default2', 'default1', 'negative', 'negative', NULL, 1), (3, '2023-01-01', 0, 0, 0, 0, 0.0, NULL, NULL, 1, 0.0, NULL, NULL, 0, 0, 1, 1.0, NULL, 1.0, 1.0, NULL, NULL, NULL, NULL, 1, 1, NULL, 'negative', 0, 1, NULL, 'default1', '0', 'negative', 1, 1, 'default1', '0', 'default1', 'negative', '0', 'default2', NULL, 0), (10, '2023-01-01', 0, 1, 0, 1, NULL, 0.0, 0.0, 0, 1.0, 1.0, 0, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 1.0, NULL, 1.0, 0, 0, 1, NULL, 1, 1, 0, NULL, '0', '0', 1, 0, '0', '0', '0', 'negative', 'default2', '0', NULL, 0);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (8, '2023-01-01', NULL, NULL, 0, '0', 1, 'negative', 'negative', 'default2', NULL, NULL, NULL), (6, NULL, 1.0, 0.0, 1, 'default2', 1, NULL, 'default1', 'default1', 'default1', 'negative', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Examination AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.SSB = 'negative' OR '0' AND NOT T1.Symptoms IS NULL;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.ID) FROM Examination AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID INNER JOIN Laboratory AS T3 ON T2.ID = T3.ID WHERE T3.SSB IN ('negative', '0') AND NOT T1.Symptoms IS NULL;

/*
Prediction Result:
(1,)
*/