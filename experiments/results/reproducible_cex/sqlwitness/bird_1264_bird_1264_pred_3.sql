-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (10, 'APS', '2023-01-01', '2023-01-01', '2023-01-01', '%APS%', NULL), (11, NULL, '2023-01-02', '2023-01-01', '2023-01-02', '%thrombosis%', '%thrombosis%'), (1, '%thrombosis%', '2023-01-02', NULL, '2023-01-01', 'default1', 'default1');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (11, '2023-01-01', NULL, 9, 1, 11, 9.0, 0.0, 0.0, NULL, 0.0, 10.0, 0, 9, NULL, 0, 10.0, 0.0, 0.0, 9.0, 10, 9.0, 0, 10.0, 10, 0, 9, '%APS%', 9, 0, 1, 'default2', NULL, 'default1', 10, 11, '%DVT%', '%APS%', '%DVT%', 'default1', '%APS%', NULL, '%thrombosis%', 1), (10, '2023-01-02', 11, 11, NULL, 9, 9.0, NULL, 1.0, 10, 0.0, 11.0, 10, 11, 0, NULL, 9.0, 1.0, 0.0, NULL, 0, 1.0, NULL, 11.0, NULL, 0, 1, 'default2', 0, NULL, 9, 'default2', 'default2', 'default1', 9, 11, '%APS%', 'APS', 'APS', '%DVT%', '%DVT%', NULL, '%APS%', 0), (10, '2023-01-01', 9, 11, 9, 10, 9.0, 0.0, 10.0, 10, 9.0, 9.0, NULL, 9, NULL, 0, NULL, 0.0, 1.0, 0.0, 10, 10.0, 1, 9.0, 11, 9, 9, NULL, 10, 0, 10, 'APS', NULL, '%thrombosis%', 0, 10, 'APS', '%APS%', '%DVT%', 'default1', '%thrombosis%', '%thrombosis%', NULL, NULL);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (1, '2023-01-02', 1.0, 1.0, NULL, 'APS', NULL, 'default2', 'default1', '%thrombosis%', 'APS', '%thrombosis%', 10), (11, '2023-01-01', 1.0, 0.0, 11, 'default2', 9, '%thrombosis%', '%APS%', '%DVT%', '%thrombosis%', NULL, 11), (11, NULL, 10.0, NULL, 11, NULL, 0, '%APS%', 'default1', 'APS', '%APS%', 'default2', 0), (11, NULL, 10.0, 1.0, 11, 'default1', NULL, 'default2', 'default1', 'default1', 'default1', '%APS%', 11), (NULL, '2023-01-01', 0.0, 1.0, 11, '%DVT%', NULL, '%thrombosis%', NULL, 'default2', 'default2', 'APS', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.C4 > 10 AND T1.Diagnosis = 'APS';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT e.ID) FROM Examination AS e JOIN Laboratory AS l ON e.ID = l.ID WHERE (e.Diagnosis LIKE '%thrombosis%' OR e.Diagnosis LIKE '%APS%' OR e.Diagnosis LIKE '%DVT%') AND l.C4 > 10;

/*
Prediction Result:
(1,)
*/