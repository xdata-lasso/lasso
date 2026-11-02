-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, 'default2', '2023-01-01', '2023-01-02', '2023-01-01', NULL, '+'), (250, 'default2', '2023-01-02', '2023-01-01', '2023-01-02', '+', NULL), (1, NULL, '2023-01-01', '2023-01-01', NULL, 'default2', 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (1, '2023-01-02', NULL, 249, 251, 0, 251.0, 249.0, NULL, 0, 250.0, 250.0, 250, 0, 0, 1, 1.0, 0.0, 250.0, 250.0, 1, 0.0, 0, 251.0, 251, 1, 251, NULL, 249, 249, 251, 'default2', NULL, 'default2', 250, 250, 'default1', 'default2', 'default2', '+', 'default2', 'default1', 'default2', 0), (1, '2023-01-01', 1, 249, 1, 251, 249.0, 251.0, NULL, NULL, 0.0, NULL, 0, 0, 0, 0, 250.0, NULL, 251.0, 1.0, 1, 249.0, NULL, 249.0, 251, 249, 249, 'default2', 250, 0, 1, 'default2', 'default1', 'default2', 249, 249, '+', '+', '+', 'default1', NULL, '+', 'default2', 1), (250, '2023-01-01', 249, 0, 1, 0, 250.0, 249.0, 1.0, NULL, 249.0, 250.0, 1, 249, 250, 1, 251.0, 1.0, 249.0, 0.0, 0, 1.0, 0, 249.0, 249, 249, 250, '+', 249, 250, 1, '+', '+', 'default2', 249, 249, 'default2', 'default2', 'default2', 'default1', NULL, 'default1', 'default2', 1);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (250, '2023-01-01', NULL, NULL, 250, NULL, 251, 'default1', '+', '+', NULL, NULL, 249), (0, '2023-01-02', 249.0, 249.0, 250, 'default2', 250, 'default2', 'default2', NULL, NULL, 'default2', NULL), (250, '2023-01-01', 251.0, NULL, 250, NULL, 0, 'default2', 'default2', 'default2', 'default2', 'default2', 250), (NULL, NULL, 0.0, 0.0, 251, 'default2', 1, NULL, 'default1', NULL, 'default2', 'default1', 0), (NULL, NULL, NULL, 0.0, 251, 'default2', 250, 'default1', 'default2', '+', 'default1', 'default2', 250), (0, '2023-01-01', 250.0, 249.0, 250, 'default2', 0, '+', 'default2', 'default1', 'default2', '+', 249), (0, '2023-01-01', 250.0, 249.0, 251, 'default2', 250, 'default1', 'default2', 'default1', 'default1', '+', 249), (1, '2023-01-01', 249.0, 251.0, 249, 'default1', 249, 'default1', NULL, 'default2', '+', 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T2.CPK < 250 AND (T3.KCT = '+' OR T3.RVVT = '+' OR T3.LAC = '+');

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.ID) FROM Laboratory AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T1.CPK < 250 AND (T2.KCT = '+' OR T2.RVVT = '+' OR T2.LAC = '+');

/*
Prediction Result:
(1,)
*/