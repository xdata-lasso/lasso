-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, NULL, '2023-01-02', '2023-01-02', '2023-01-02', '2+', 'default2'), (122, 'default1', '2023-01-02', '2023-01-01', '2023-01-01', '2+', 'PSS'), (3, 'default2', '2023-01-02', '2023-01-01', '2023-01-01', 'default2', 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (1, '2023-01-01', 2, 2, 0, 124, 3.0, 123.0, 123.0, 123, NULL, 1.0, NULL, 124, 3, 0, 124.0, 3.0, 2.0, NULL, 2, 3.0, 3, 0.0, 0, 2, 1, 'default1', 123, NULL, 2, NULL, NULL, 'PSS', 3, 2, NULL, 'default2', '2+', 'default1', 'default1', 'default1', 'default2', 2), (3, '2023-01-02', 3, 124, NULL, 123, 123.0, 2.0, 122.0, 1, 1.0, 124.0, NULL, 0, 122, 0, 3.0, 123.0, 2.0, 123.0, 3, 2.0, 123, 124.0, 1, 1, 124, 'default1', 123, 124, 122, NULL, '2+', 'PSS', 0, 2, '2+', '2+', '2+', NULL, 'default1', '2+', 'PSS', 2), (1, '2023-01-02', 124, 122, 123, 1, 2.0, 2.0, 3.0, 123, 1.0, 0.0, 2, 3, 3, NULL, 0.0, 3.0, 122.0, 123.0, 2, 1.0, 2, 3.0, 2, 2, NULL, 'default1', 2, 124, NULL, 'PSS', NULL, 'default2', 1, 2, 'default1', 'default1', 'PSS', 'default2', 'default1', 'default1', '2+', 124);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (1, NULL, 122.0, NULL, 1, 'PSS', 1, 'PSS', 'default1', 'default2', 'default1', 'default1', 0), (1, '2023-01-02', 2.0, 2.0, 3, '2+', NULL, 'default2', '2+', NULL, 'PSS', 'default2', 0), (3, '2023-01-02', 2.0, 3.0, 0, '2+', 0, 'default2', '2+', 'default1', 'default2', 'PSS', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.SEX FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID INNER JOIN Laboratory AS T3 ON T3.ID = T2.ID WHERE T2.Diagnosis = 'PSS' AND T3.CRP = '2+' AND T3.CRE = 1.0 AND T3.LDH = 123;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T1.SEX FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T3.Diagnosis = 'PSS' AND T2.CRP > 2 AND T2.CRE = 1 AND T2.LDH = 123;

/*
Prediction Result:
(None,)
*/