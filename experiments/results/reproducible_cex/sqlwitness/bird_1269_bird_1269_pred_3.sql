-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, '0', NULL, '2023-01-02', '2023-01-02', NULL, 'default1'), (1997, NULL, '1997-01-01', '2023-01-01', '1997-01-02', '1997-01-01', 'default2'), (1998, 'default2', '1997-01-02', '1996-12-31', '2023-01-02', '1997-01-01', 'negative'), (0, '0', '2023-01-01', '1997-01-01', '2023-01-02', NULL, '0'), (2, 'default2', '1997-01-02', '1997-01-02', '1997-01-02', 'default1', 'default1'), (1996, '0', '1996-12-31', '2023-01-01', '1997-01-02', 'default1', '0'), (3, 'default2', '1997-01-02', '2023-01-02', '1996-12-31', 'default2', NULL), (4, 'default2', '1997-01-01', '1997-01-01', '2023-01-02', '0', '1997-01-01'), (5, 'negative', NULL, '2023-01-02', '1997-01-02', 'negative', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (1998, '2023-01-02', 0, 1998, 0, 1, 1996.0, 1997.0, 0.0, 1, NULL, 0.0, 0, 2, NULL, 1996, 1996.0, 2.0, 2.0, 1998.0, 1996, 1997.0, 0, 1998.0, 1997, 1996, 1996, NULL, 1996, NULL, 1997, 'default2', 'default2', 'default2', NULL, 1996, NULL, 'default1', '0', NULL, 'negative', NULL, 'default1', 2), (2, '2023-01-02', NULL, 2, NULL, 1996, 1998.0, 1998.0, 1.0, 1998, 1997.0, 1996.0, 1, 2, 1, 2, 1998.0, 1996.0, NULL, NULL, NULL, NULL, NULL, 1998.0, 1998, 2, 1997, NULL, 1996, 1, 1998, NULL, 'default2', '0', 1997, 1, '1997-01-01', NULL, 'default2', NULL, '1997-01-01', 'default2', 'default1', 2), (1, '2023-01-01', 0, NULL, 1998, NULL, 2.0, 1997.0, NULL, NULL, 1.0, 0.0, 2, 1, 2, NULL, 1996.0, 2.0, 1998.0, 2.0, 1997, NULL, 1996, NULL, 1997, 1997, 0, 'negative', 1997, 1998, NULL, NULL, NULL, '1997-01-01', NULL, NULL, '1997-01-01', 'negative', NULL, '0', '0', '0', 'default2', 2), (1, '2023-01-02', 1, NULL, 0, 1998, 1997.0, NULL, 1.0, 1, 2.0, 1.0, NULL, 0, 1998, 1997, 1997.0, 1998.0, 1997.0, 2.0, 2, 1.0, 1997, NULL, 1, 1, 1996, '0', 0, 1997, 1997, 'negative', '1997-01-01', 'default1', 1, 1997, 'default2', '0', 'negative', '0', 'default2', NULL, 'default2', 1998), (3, '1996-12-31', NULL, 1997, 1996, 2, 1996.0, 2.0, 1997.0, NULL, 1998.0, 2.0, 1998, 1998, 1998, 0, NULL, 1996.0, NULL, 1997.0, 1998, 1996.0, 1996, 0.0, 1998, 1997, 1996, NULL, 1997, 1996, 2, '1997-01-01', 'default2', NULL, 1996, 1996, '1997-01-01', '1997-01-01', 'negative', NULL, 'negative', '0', 'default1', 1996);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (4, '2023-01-02', 2.0, 1998.0, 1, NULL, 0, 'negative', 'default2', '0', '0', 'default2', 1998), (1, '2023-01-01', NULL, 1998.0, 1998, '0', 0, '1997-01-01', 'default1', 'default1', NULL, NULL, 1997), (4, '2023-01-01', 0.0, 2.0, 1, 'negative', NULL, NULL, 'default1', NULL, 'negative', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.SC170 IN ('negative', '0') AND T2.Date > 1997 - 01 - 01;

/*
Gold Result:
(1998,)
(1,)
(3,)
*/

-- Prediction Query
SELECT DISTINCT e.ID FROM Examination AS e JOIN Laboratory AS l ON e.ID = l.ID WHERE e."Examination Date" > '1997-01-01' AND l.SC170 IN ('negative', '0');

/*
Prediction Result:
(1,)
*/