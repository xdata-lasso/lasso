-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (46, 'default1', '1996-12-31', NULL, '2023-01-01', NULL, 'default2'), (45, NULL, '2023-01-02', '2023-01-01', NULL, NULL, '1997-01-01'), (44, '1997-01-01', '2023-01-02', '2023-01-01', '1997-01-01', 'default1', 'default1'), (0, '1997-01-01', '2023-01-02', NULL, '1997-01-01', 'default1', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (46, '2023-01-01', NULL, 0, 46, 45, 0.0, 46.0, 45.0, 44, 0.0, 45.0, 45, NULL, NULL, 45, 44.0, 0.0, NULL, 45.0, 46, 1.0, 45, 46.0, NULL, 44, NULL, 'default2', 1, 45, 0, '1997-01-01', '1997-01-01', 'default1', 46, 1, NULL, '1997-01-01', 'default1', 'default2', NULL, '1997-01-01', 'default2', 45), (46, '1997-01-02', 44, 44, 44, NULL, 45.0, NULL, 44.0, 44, 1.0, 44.0, NULL, NULL, NULL, 0, 0.0, 1.0, 46.0, NULL, 0, 45.0, 45, NULL, 44, 46, 46, NULL, 1, 1, NULL, '1997-01-01', 'default2', '1997-01-01', 46, 0, 'default2', 'default2', NULL, 'default1', NULL, NULL, 'default1', 0), (0, '1997-01-02', 1, NULL, 45, 45, 46.0, 45.0, 44.0, NULL, 46.0, NULL, 46, 45, NULL, 46, 46.0, NULL, NULL, 0.0, 1, 45.0, NULL, 45.0, 45, 1, 46, 'default2', 0, 46, 46, '1997-01-01', 'default2', NULL, 1, 44, 'default1', 'default1', 'default2', 'default1', NULL, 'default2', '1997-01-01', NULL), (45, '1997-01-02', 0, 0, 44, 0, 44.0, 0.0, 46.0, 1, 46.0, NULL, 46, 44, 45, 1, 46.0, NULL, 46.0, 46.0, 44, 45.0, 45, 0.0, 44, 45, 1, 'default1', 0, 1, 46, NULL, 'default2', 'default2', 1, 1, 'default2', 'default2', NULL, 'default1', 'default1', 'default1', NULL, 44);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (44, '1997-01-02', NULL, 45.0, 44, 'default2', 44, '1997-01-01', 'default1', '1997-01-01', '1997-01-01', 'default2', NULL), (44, '1997-01-01', NULL, 44.0, 45, 'default1', 1, NULL, NULL, NULL, '1997-01-01', '1997-01-01', 44);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.Date > '1997-01-01' AND T2.APTT >= 45;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM examination INNER JOIN laboratory ON examination.id = laboratory.id WHERE examination."Examination Date" > '1997-01-01' AND laboratory.aptt >= 45;

/*
Prediction Result:
(0,)
*/