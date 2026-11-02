-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, NULL, NULL, '2023-01-01', '2023-01-01', NULL, 'P'), (0, 'P', NULL, '2023-01-01', '2023-01-01', 'default1', 'default2'), (251, 'P', '2023-01-02', '2023-01-02', NULL, 'P', 'default1');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (251, '2023-01-02', 249, 249, NULL, 0, 249.0, 251.0, 250.0, 251, 1.0, 251.0, 249, 1, 250, 1, 0.0, NULL, 0.0, 1.0, 0, 249.0, NULL, 0.0, NULL, 251, 0, 'P', 249, 250, 251, 'default1', 'P', 'P', 251, 251, NULL, 'P', 'default2', 'default1', 'default1', 'default2', 'default2', 251), (251, '2023-01-01', NULL, 0, 0, 1, NULL, 250.0, 250.0, 250, 251.0, 250.0, 0, NULL, 0, 1, 249.0, NULL, 0.0, NULL, 249, 250.0, 1, NULL, NULL, 251, 250, NULL, 250, 1, 250, NULL, NULL, NULL, 251, 251, 'default1', 'default1', NULL, NULL, 'default1', NULL, 'default1', 250), (1, '2023-01-01', 1, 1, 249, 251, 0.0, NULL, 251.0, NULL, 251.0, 0.0, NULL, 251, NULL, 251, NULL, NULL, 0.0, 251.0, NULL, 251.0, 0, NULL, 251, 0, 249, 'default1', 0, 1, 1, 'default1', 'default2', 'default1', NULL, 1, NULL, 'P', 'default2', 'P', 'default1', 'default2', 'default1', 251);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (1, '2023-01-01', 0.0, 250.0, 251, 'P', 251, 'default2', 'default1', 'P', NULL, 'default1', 251), (NULL, '2023-01-02', 1.0, NULL, 250, NULL, 0, 'P', 'P', 'default1', 'default1', NULL, 251), (1, NULL, 249.0, 1.0, 250, 'P', 1, 'default2', NULL, 'default1', 'default1', 'default1', NULL), (251, '2023-01-01', 1.0, NULL, NULL, 'P', 250, 'P', 'P', 'P', NULL, 'default2', 249), (251, '2023-01-01', 1.0, 250.0, 250, 'P', 0, 'default1', 'default2', 'default1', NULL, 'default2', 251);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T3."ANA Pattern" = 'P' AND T2."T-CHO" < 250;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT laboratory.id) AS patientcount FROM laboratory INNER JOIN examination ON laboratory.id = examination.id WHERE laboratory."T-CHO" < 250 AND examination."ANA Pattern" = 'P';

/*
Prediction Result:
(1,)
*/