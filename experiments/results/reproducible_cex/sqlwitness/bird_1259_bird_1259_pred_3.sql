-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1995, '-', '1994-12-31', '2023-01-01', NULL, '1995-01-01', '-'), (0, '-', NULL, '1995-01-02', '1995-01-02', '1995-01-01', 'default1'), (1994, '-', '2023-01-02', '1995-01-02', '2023-01-01', '+-', '-'), (2, '+-', '1995-01-02', '1994-12-31', '1994-12-31', '+-', NULL), (1, '-', '1995-01-02', '1994-12-31', '2023-01-01', 'default1', '+-'), (1996, '1995-01-01', '1995-01-01', '2023-01-02', '2023-01-02', 'default2', '1995-01-01'), (3, 'default2', '1995-01-01', '1995-01-02', '1994-12-31', '+-', NULL), (4, NULL, NULL, '1995-01-02', NULL, '+-', '-'), (5, 'default1', '2023-01-02', NULL, NULL, '1995-01-01', 'default1'), (6, '-', '2023-01-01', '1995-01-01', NULL, '-', 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (5, '1995-01-02', 1, 1995, 1996, 1, 1996.0, 1.0, 0.0, 1996, 1994.0, 1994.0, 0, 1995, 1995, 1994, NULL, 0.0, 1995.0, 0.0, 1995, 1.0, 1, NULL, 0, 2, 1996, NULL, 1, 1996, 0, 'default2', '+-', '+-', 1, 0, '+-', '+-', '+-', '1995-01-01', NULL, NULL, 'default2', 1994), (1, '1995-01-02', 1, NULL, 1994, 2, 1996.0, 2.0, 1.0, 1996, 2.0, 1995.0, 1, 0, NULL, 2, 1.0, 2.0, 2.0, NULL, 0, 1.0, 1994, 1995.0, 1, 1, 0, '1995-01-01', 0, NULL, 1996, NULL, '+-', 'default2', 1, 1, 'default2', 'default1', '1995-01-01', 'default2', '-', '+-', NULL, 1996), (1995, '1995-01-01', 1994, 1995, 1996, NULL, 1.0, 1995.0, 1995.0, 1996, 1.0, 1.0, 1996, 1996, NULL, NULL, 0.0, NULL, 1995.0, 2.0, 2, NULL, 1994, 2.0, NULL, 0, 1, '+-', 1, 1994, 1994, '1995-01-01', '+-', '+-', 1, 1995, 'default1', '-', '1995-01-01', '-', NULL, '+-', '+-', NULL), (5, '2023-01-02', 0, 2, 1994, 1994, 0.0, 1996.0, 0.0, 1994, 2.0, 2.0, 0, 0, 0, 1, 1.0, 1996.0, NULL, NULL, 0, 2.0, NULL, 0.0, 1996, 1996, 1995, '1995-01-01', 1996, 1996, 1994, '-', '-', 'default1', 0, NULL, 'default1', '-', '-', NULL, 'default2', '1995-01-01', 'default1', NULL), (1995, '1994-12-31', 1996, 1994, 1996, 1995, 1996.0, 1995.0, 0.0, 1996, 1994.0, 0.0, 1995, 0, 1996, 1995, 1994.0, NULL, 1.0, 0.0, 1996, 1.0, 2, 1.0, 1996, 2, 1996, '1995-01-01', 0, 1996, 1996, '1995-01-01', '-', 'default1', 1996, 2, 'default2', 'default2', NULL, NULL, 'default1', NULL, 'default2', NULL), (1996, '2023-01-01', 1994, NULL, 1994, 1994, 0.0, 2.0, 1994.0, NULL, 1996.0, 1994.0, 1995, 1, NULL, NULL, 1994.0, 2.0, 1995.0, NULL, NULL, 1996.0, 1, 0.0, 1996, 0, 0, '1995-01-01', 0, 1995, NULL, NULL, 'default1', 'default2', 0, NULL, '-', 'default1', '-', NULL, '-', 'default2', 'default2', 1), (3, '1995-01-01', 1995, 1, NULL, 1995, 1.0, 0.0, NULL, 1995, NULL, 1994.0, 1994, 0, 1994, 2, 0.0, NULL, 0.0, 1994.0, 0, 2.0, NULL, NULL, 0, 0, 1995, 'default2', 1996, 1, 1994, '1995-01-01', 'default1', NULL, 1, 1, 'default1', NULL, '+-', 'default2', 'default1', NULL, 'default1', 1995), (6, '1995-01-01', 1995, 0, 1, 1996, 0.0, 1994.0, 1995.0, 1995, 1995.0, 1995.0, 1995, 2, NULL, 1995, 1.0, 1.0, 1.0, 1.0, 2, 0.0, 2, 1995.0, 1995, NULL, 1996, NULL, NULL, 2, 0, 'default1', '1995-01-01', NULL, NULL, 1995, '+-', '-', 'default2', 'default2', 'default2', '-', 'default2', 1995), (1, '1995-01-01', 1995, 2, NULL, 2, 1.0, 1995.0, 1996.0, 1995, 2.0, NULL, 2, 1, NULL, 2, 1995.0, 1996.0, 2.0, 1995.0, 1994, 2.0, 1995, 1.0, 0, 1995, 1995, NULL, 1996, 2, 1996, 'default1', '+-', '1995-01-01', NULL, 1995, NULL, '-', '+-', '1995-01-01', '1995-01-01', 'default1', '1995-01-01', 1994), (1994, '2023-01-01', 1996, 1996, 1994, 1, NULL, 1994.0, 1994.0, 1, 1994.0, 2.0, 1995, 2, 1994, 2, 1996.0, 2.0, 0.0, 1994.0, 1996, 1994.0, 1994, 1994.0, 1994, 1996, 1, 'default1', 1994, 1994, 1994, 'default1', 'default1', '1995-01-01', 1996, NULL, '+-', NULL, 'default2', '+-', NULL, NULL, 'default2', 1995);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.RA = '-' OR T2.RA = '+-') AND T1.Birthday > 1995 - 01 - 01;

/*
Gold Result:
('default1',)
('+-',)
('-',)
('default1',)
('-',)
('+-',)
*/

-- Prediction Query
SELECT DISTINCT T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Birthday >= '1995-01-01' AND T2.RA IN ('-', '+-');

/*
Prediction Result:
('default1',)
('+-',)
*/