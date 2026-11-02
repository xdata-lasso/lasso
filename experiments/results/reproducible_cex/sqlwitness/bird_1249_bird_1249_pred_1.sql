-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'default2', '2023-01-01', '2023-01-01', '2023-01-01', 'default2', 'default1'), (31, 'default2', '2023-01-02', NULL, '2023-01-02', 'default2', 'default1'), (0, NULL, '2023-01-01', '2023-01-01', '2023-01-02', 'default2', 'default2'), (29, 'default1', NULL, '2023-01-01', '2023-01-02', 'default2', NULL), (30, NULL, NULL, NULL, '2023-01-02', 'default1', 'default1'), (2, 'default2', NULL, '2023-01-02', '2023-01-02', 'default1', NULL), (3, 'default2', '2023-01-01', '2023-01-02', NULL, NULL, 'default1'), (4, 'default1', '2023-01-01', '2023-01-01', NULL, 'default2', 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (30, '2023-01-01', 31, 1, NULL, 29, 29.0, 31.0, 1.0, 29, 31.0, 31.0, 30, 29, 29, 0, 29.0, 29.0, 29.0, 29.0, 1, 30.0, 0, 30.0, 31, NULL, 31, 'default2', NULL, 1, 30, 'default2', NULL, 'default1', 29, NULL, NULL, NULL, NULL, NULL, 'default1', 'default1', 'default1', 29), (2, '2023-01-02', NULL, 29, 29, 31, 1.0, 0.0, 0.0, NULL, NULL, 0.0, 1, 30, 0, 29, 29.0, 0.0, 0.0, 29.0, 0, 0.0, 0, 1.0, 30, 30, 0, NULL, 1, NULL, 30, 'default1', 'default2', 'default1', 30, 29, NULL, 'default1', 'default1', NULL, NULL, 'default2', 'default2', NULL), (3, '2023-01-02', 0, 31, 31, 31, 30.0, 31.0, 0.0, 29, 29.0, 1.0, 31, 29, 1, NULL, NULL, 30.0, NULL, 0.0, 30, 29.0, 29, 31.0, 0, 0, 30, 'default1', 0, 30, 1, 'default2', NULL, 'default2', NULL, NULL, 'default2', 'default2', 'default1', NULL, 'default2', NULL, 'default1', 1), (31, '2023-01-01', 29, 1, 0, 30, NULL, 31.0, 29.0, NULL, 0.0, 0.0, 29, 29, 1, 29, 29.0, 0.0, 1.0, 1.0, 30, 29.0, 0, 30.0, 1, 29, 29, 'default1', 1, 29, 0, 'default1', 'default2', 'default2', NULL, 0, NULL, NULL, 'default1', 'default2', NULL, 'default2', 'default1', 0), (1, '2023-01-01', 29, 1, 1, 29, NULL, 30.0, 31.0, 29, 1.0, 30.0, 30, 29, NULL, 30, 30.0, 29.0, 0.0, 0.0, 31, NULL, 0, 1.0, 30, 0, 31, NULL, 29, 31, 30, 'default1', 'default2', NULL, NULL, 29, NULL, 'default1', 'default2', 'default1', NULL, 'default1', 'default1', 31), (1, '2023-01-02', 1, NULL, 31, NULL, 0.0, 29.0, 0.0, 31, 0.0, 0.0, 1, 31, 30, 1, 1.0, 29.0, NULL, 31.0, 29, 0.0, NULL, NULL, 31, 0, 29, 'default2', NULL, 29, 1, NULL, 'default2', NULL, NULL, 1, NULL, 'default1', 'default1', NULL, NULL, NULL, NULL, 0), (0, '2023-01-02', 31, 31, 29, 29, 31.0, 29.0, NULL, 31, 0.0, 1.0, 30, NULL, 29, 29, 31.0, 0.0, 29.0, 0.0, 29, 31.0, 29, 30.0, 29, 30, 0, NULL, 29, 1, 1, NULL, 'default1', NULL, 30, 0, 'default2', 'default1', 'default1', 'default1', NULL, NULL, 'default1', 31), (2, '2023-01-01', NULL, 0, NULL, 31, NULL, 1.0, 30.0, 29, 1.0, NULL, 29, 31, 31, NULL, 30.0, 31.0, 0.0, 0.0, 29, 1.0, 1, 0.0, 29, 30, 31, NULL, 0, 0, 31, 'default1', NULL, 'default2', 30, 29, 'default1', NULL, 'default2', NULL, 'default2', 'default1', 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2."U-PRO" >= 30;

/*
Gold Result:
('default1',)
('default1',)
('default1',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT Patient.Diagnosis FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory."U-PRO" >= 30;

/*
Prediction Result:
('default1',)
*/