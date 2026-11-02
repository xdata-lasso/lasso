-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (123, 'default1', NULL, '2023-01-01', '2023-01-02', 'default1', 'default1'), (1, '2+', '2023-01-01', '2023-01-02', NULL, '2+', NULL), (122, 'default1', '2023-01-01', '2023-01-01', '2023-01-02', 'PSS', NULL), (124, 'PSS', '2023-01-02', '2023-01-01', NULL, NULL, 'PSS'), (0, NULL, '2023-01-02', '2023-01-02', '2023-01-02', 'PSS', 'default1'), (2, 'PSS', '2023-01-02', '2023-01-02', NULL, NULL, 'default1'), (3, 'default2', NULL, '2023-01-02', NULL, 'default1', 'PSS'), (4, 'PSS', NULL, '2023-01-01', '2023-01-01', 'default2', 'default2'), (5, 'PSS', NULL, '2023-01-02', '2023-01-01', 'default1', 'default2'), (6, '2+', '2023-01-01', '2023-01-01', '2023-01-02', NULL, 'default1'), (7, '2+', '2023-01-01', NULL, '2023-01-01', 'default2', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (124, '2023-01-02', 0, 2, 0, 122, 124.0, NULL, NULL, NULL, 0.0, 2.0, 123, 123, 124, NULL, 2.0, 1.0, 1.0, 1.0, 1, 1.0, 0, 2.0, 0, 122, 2, 'default1', 1, 0, 123, 'default1', 'default1', 'default2', 122, 0, 'default1', 'default1', 'default2', 'default2', NULL, 'default2', NULL, NULL), (3, '2023-01-01', NULL, 1, 2, 123, 1.0, 124.0, NULL, 122, 124.0, 2.0, 2, 1, 122, 122, 124.0, NULL, 1.0, 2.0, 123, 0.0, 122, 0.0, 0, NULL, 123, 'PSS', 123, 0, NULL, 'default1', NULL, 'default2', 1, 123, 'default1', NULL, NULL, 'default1', 'default2', 'PSS', 'default2', 1), (123, '2023-01-01', 0, 124, 124, 124, 2.0, 122.0, 124.0, 0, 123.0, 2.0, 122, 2, 2, 0, NULL, 2.0, 0.0, 123.0, 122, NULL, 124, 124.0, 123, 2, 2, 'PSS', 1, 123, 122, 'PSS', NULL, 'PSS', 0, 123, 'default2', 'default2', 'PSS', 'default2', 'PSS', NULL, 'PSS', 124), (122, '2023-01-02', 122, 2, 2, 123, 123.0, 1.0, 123.0, 2, 1.0, NULL, 0, 1, 122, 2, 124.0, 122.0, 1.0, 1.0, 1, 0.0, 0, NULL, 123, 123, 124, 'default1', 124, NULL, 124, 'default2', '2+', 'PSS', 124, 124, 'default1', '2+', NULL, 'default2', 'PSS', 'default2', 'default1', 123), (1, '2023-01-02', 124, 122, 123, 1, 123.0, 2.0, 0.0, 0, 124.0, 122.0, NULL, 0, 124, 1, NULL, NULL, 2.0, 1.0, 122, 2.0, 2, 1.0, 0, 123, 122, NULL, 123, 123, 2, 'default1', 'default2', 'default2', NULL, 122, 'PSS', 'default1', 'PSS', '2+', 'PSS', 'default2', 'PSS', 0), (0, '2023-01-02', 0, 0, 123, 124, 1.0, 122.0, 122.0, 123, 1.0, 1.0, 123, 0, NULL, 1, 2.0, 2.0, 2.0, 1.0, 124, 2.0, 123, 1.0, NULL, NULL, 124, NULL, 122, 123, 2, NULL, NULL, '2+', 1, 0, '2+', 'default2', 'default2', 'default2', 'default2', 'PSS', 'PSS', 123);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (124, '2023-01-01', 122.0, NULL, 0, NULL, 0, '2+', '2+', 'default1', 'default1', 'default2', 2), (1, '2023-01-02', 0.0, NULL, 123, 'PSS', 0, NULL, '2+', NULL, 'default1', 'default2', 122), (122, NULL, 0.0, 123.0, 122, NULL, 2, NULL, 'PSS', NULL, NULL, 'PSS', NULL), (1, NULL, NULL, 0.0, 1, '2+', 2, '2+', NULL, 'PSS', '2+', NULL, 0), (5, '2023-01-02', 1.0, 2.0, 2, 'default2', NULL, 'PSS', NULL, 'default2', 'default1', 'default2', 0), (5, NULL, 124.0, 1.0, 124, 'default2', NULL, 'PSS', 'default1', 'default2', 'PSS', 'default2', NULL), (0, '2023-01-02', NULL, 0.0, NULL, 'default1', 122, 'PSS', 'PSS', 'PSS', 'PSS', '2+', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.SEX FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID INNER JOIN Laboratory AS T3 ON T3.ID = T2.ID WHERE T2.Diagnosis = 'PSS' AND T3.CRP = '2+' AND T3.CRE = 1.0 AND T3.LDH = 123;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT patient.sex FROM patient INNER JOIN examination ON patient.id = examination.id INNER JOIN laboratory ON patient.id = laboratory.id WHERE examination.diagnosis = 'PSS' AND laboratory.cre = 1;

/*
Prediction Result:
(None,)
*/