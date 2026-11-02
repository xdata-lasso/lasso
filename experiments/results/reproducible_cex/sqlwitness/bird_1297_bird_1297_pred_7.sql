-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (251, 'default1', '2023-01-01', '2023-01-02', '2023-01-02', 'default1', '-'), (0, '-', NULL, NULL, NULL, 'default2', 'default2'), (249, '-', NULL, NULL, '2023-01-02', NULL, '-'), (1, 'default2', NULL, '2023-01-01', '2023-01-02', '-', 'default2'), (250, '-', '2023-01-02', '2023-01-02', NULL, 'default2', NULL), (2, 'default1', NULL, '2023-01-01', '2023-01-01', '-', '-'), (3, '-', '2023-01-02', '2023-01-01', '2023-01-01', 'default2', 'default2'), (4, 'default1', '2023-01-02', '2023-01-01', '2023-01-01', NULL, NULL), (5, '-', '2023-01-01', '2023-01-02', '2023-01-01', '-', 'default1');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (249, '2023-01-02', 0, 251, 250, 0, 0.0, 0.0, NULL, NULL, 1.0, 249.0, 250, 249, NULL, 0, NULL, NULL, 250.0, 1.0, 0, 0.0, 251, 249.0, 249, 250, 249, 'default2', NULL, 250, 249, 'default2', NULL, '-', 1, 251, 'default1', '-', NULL, 'default2', 'default2', 'default1', '-', NULL), (251, '2023-01-02', 1, 1, 1, 251, NULL, 251.0, NULL, 1, 0.0, 251.0, 1, 251, 249, 1, 1.0, 249.0, 1.0, 249.0, NULL, 249.0, 1, 250.0, 249, 250, 251, NULL, 251, NULL, 250, 'default1', 'default2', '-', 1, 1, '-', '-', 'default1', 'default2', 'default1', 'default2', '-', 249), (0, '2023-01-01', 251, 0, NULL, 1, NULL, 251.0, 251.0, 0, NULL, 249.0, 250, 250, 0, 0, 249.0, 0.0, 249.0, 250.0, 0, 1.0, NULL, 250.0, 0, 251, 249, NULL, 250, NULL, 250, 'default1', NULL, 'default2', NULL, 1, '-', NULL, '-', 'default1', 'default2', 'default1', 'default2', 250), (0, '2023-01-02', 250, 250, NULL, 251, 1.0, 251.0, NULL, 251, 249.0, 1.0, 251, 250, 250, 0, 1.0, 1.0, 1.0, 1.0, 1, NULL, NULL, 251.0, 251, 250, NULL, 'default1', 1, 1, 249, 'default2', 'default2', 'default1', 1, 250, NULL, NULL, '-', 'default1', NULL, 'default1', NULL, 251), (251, '2023-01-01', 251, 1, 250, 0, NULL, NULL, 0.0, 1, 249.0, 251.0, NULL, 1, 249, 0, 0.0, 0.0, 251.0, 1.0, 1, 251.0, 0, 249.0, 250, 251, NULL, 'default1', 1, 1, 0, '-', '-', '-', NULL, 0, '-', 'default2', '-', 'default2', 'default1', 'default2', 'default2', 249), (2, '2023-01-01', 250, 1, NULL, NULL, 1.0, NULL, NULL, 249, 1.0, NULL, 0, 1, 0, 251, 1.0, 251.0, 0.0, 1.0, 251, 0.0, 1, 250.0, 1, 251, 0, 'default2', 251, 0, 249, '-', NULL, '-', 1, 0, 'default2', 'default1', '-', '-', 'default1', NULL, 'default2', 0);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (4, '2023-01-01', 1.0, 1.0, 250, 'default1', 251, '-', 'default1', NULL, 'default1', 'default2', NULL), (249, '2023-01-02', 251.0, 0.0, 249, '-', 250, 'default2', 'default1', 'default1', 'default2', 'default2', 1), (4, '2023-01-01', 250.0, 0.0, 1, '-', 250, NULL, 'default1', 'default2', NULL, NULL, 250), (0, NULL, 0.0, 251.0, NULL, NULL, 249, 'default1', '-', '-', '-', '-', NULL), (1, '2023-01-01', 0.0, 0.0, 251, NULL, 249, 'default2', NULL, NULL, 'default2', 'default2', 250), (250, '2023-01-01', 249.0, 1.0, 251, NULL, 1, 'default2', '-', 'default2', 'default2', 'default1', 1), (249, NULL, 250.0, 1.0, 251, '-', 1, NULL, 'default2', 'default1', '-', '-', 250), (251, '2023-01-02', 1.0, 251.0, 1, '-', NULL, NULL, 'default1', 'default1', NULL, 'default1', 251), (1, '2023-01-02', 1.0, NULL, 0, 'default2', NULL, NULL, '-', 'default1', 'default2', NULL, 1), (5, '2023-01-02', 249.0, 249.0, 250, 'default1', 250, 'default2', 'default2', NULL, 'default1', '-', 251);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T2."T-CHO" >= 250 AND T3.KCT = '-';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT l.id) FROM laboratory AS l INNER JOIN examination AS e ON l.id = e.id WHERE l."T-CHO" >= 250 AND e.kct = '-';

/*
Prediction Result:
(1,)
*/