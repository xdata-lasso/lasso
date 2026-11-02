-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (14, 'default2', '2023-01-02', '2023-01-01', '2023-01-01', 'default1', NULL), (-1, 'default2', '2023-01-02', NULL, NULL, 'default2', NULL), (2, 'default1', '2023-01-02', NULL, NULL, 'default1', 'default2'), (0, 'default1', '2023-01-01', NULL, '2023-01-02', 'default1', 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (14, '2023-01-02', -1, -1, -1, 3, -1.0, 3.0, 1.0, 2, 14.0, 14.0, 2, 1, 13, 0, 1.0, 2.0, 4.0, -1.0, NULL, 3.0, 0, 3.0, 4, -1, -1, NULL, 2, -1, NULL, 'default1', 'default1', 'default2', 13, NULL, 'default2', 'default2', 'default2', 'default1', 'default1', 'default1', 'default2', 13), (14, '2023-01-01', NULL, 13, 4, 3, 15.0, 0.0, 4.0, 1, 13.0, 15.0, 14, 13, 1, 3, NULL, NULL, 15.0, 3.0, 0, 2.0, 2, NULL, NULL, 15, 13, 'default1', -1, 0, 15, 'default2', 'default2', NULL, 0, 14, 'default1', NULL, 'default2', 'default1', NULL, 'default2', 'default1', 14), (-1, '2023-01-01', 1, 0, 1, 14, NULL, 0.0, 13.0, 3, 2.0, NULL, 3, NULL, 2, -1, 14.0, 0.0, 2.0, 0.0, 13, 3.0, 3, 3.0, 14, NULL, 14, 'default1', 2, 4, 0, NULL, NULL, NULL, 4, 0, 'default1', 'default2', 'default1', 'default1', NULL, NULL, NULL, NULL), (0, '2023-01-02', 3, 13, 4, 1, 4.0, 15.0, 2.0, -1, 0.0, 3.0, 14, -1, 15, -1, 14.0, 3.0, 13.0, 0.0, 2, 14.0, 4, 4.0, 0, 4, -1, NULL, 13, 4, 15, 'default2', NULL, 'default1', 13, 4, 'default1', 'default1', 'default2', 'default1', 'default2', NULL, NULL, 14);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (14, '2023-01-01', 3.0, 2.0, NULL, 'default1', 4, 'default1', 'default2', 'default1', 'default2', NULL, 2), (0, NULL, NULL, 0.0, 1, NULL, 14, NULL, 'default2', NULL, 'default1', 'default2', 0), (14, NULL, 14.0, -1.0, 3, 'default1', 14, 'default1', 'default1', NULL, NULL, 'default1', 15), (-1, NULL, NULL, 3.0, NULL, 'default2', 14, 'default1', 'default1', NULL, 'default1', NULL, 13), (NULL, '2023-01-02', 3.0, 4.0, 1, NULL, 3, 'default1', NULL, NULL, 'default1', 'default1', -1), (NULL, '2023-01-02', 0.0, -1.0, 1, NULL, 2, NULL, NULL, NULL, 'default2', 'default2', 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T2.PT < 14 AND T3.Thrombosis < 3 AND T3.Thrombosis > 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.ID) FROM Examination AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Thrombosis IN (1, 2) AND T2.PT < 14;

/*
Prediction Result:
(1,)
*/