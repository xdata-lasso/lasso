-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (61, NULL, NULL, NULL, '2023-01-02', 'default1', 'default1'), (60, 'default1', '2023-01-02', '2023-01-01', '2023-01-02', NULL, 'default2'), (48473, NULL, NULL, '2023-01-01', '2023-01-01', 'default1', 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (61, '2023-01-01', 48472, 1, 48473, 48473, 48473.0, 48472.0, NULL, 48473, 60.0, 0.0, 61, 48472, 48472, NULL, 59.0, 61.0, 59.0, 48472.0, 0, 48474.0, 60, 59.0, NULL, 48472, 59, 'default1', 59, 0, NULL, 'default2', 'default1', NULL, 1, 0, 'default2', 'default2', 'default2', 'default1', 'default1', 'default1', NULL, 48474), (48473, '2023-01-01', 60, 1, 1, 1, 61.0, 48473.0, 60.0, 0, 59.0, 48474.0, NULL, 60, 61, NULL, 0.0, 61.0, 1.0, 61.0, 48474, 48473.0, 0, 60.0, NULL, 1, 0, 'default1', 48473, 59, 60, 'default2', NULL, 'default1', 59, 59, 'default2', 'default1', 'default1', NULL, 'default2', 'default1', NULL, 48473);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Date FROM Laboratory WHERE ID = 48473 AND GOT >= 60;

/*
Gold Result:
('2023-01-01',)
*/

-- Prediction Query
SELECT Laboratory.Date FROM Laboratory INNER JOIN Patient ON Laboratory.ID = Patient.ID WHERE Patient.ID = 48473 AND Laboratory.GOT > 60;

/*
Prediction Result:
*/