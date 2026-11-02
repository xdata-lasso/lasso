-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, '%Y', NULL, '2023-01-01', '2023-01-02', 'default2', 'default2'), (1996, NULL, '1985-10-27', '2023-01-02', NULL, 'default2', 'default2'), (1995, '%Y', '1985-10-27', '2023-01-01', NULL, '-', '-'), (2, 'default1', '2023-01-02', NULL, NULL, 'default1', 'default2'), (1994, 'default2', '2023-01-01', '2023-01-01', '2023-01-02', 'default1', '+-'), (1, 'default2', NULL, '1985-10-27', '1985-10-27', '+-', '%Y'), (3, '%Y', '2023-01-01', NULL, '2023-01-01', '-', '-'), (4, 'default2', '2023-01-01', '2023-01-02', '1985-10-27', '%Y', '+-'), (5, NULL, '2023-01-02', '2023-01-02', NULL, '-', 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (5, '1985-10-27', 1995, 1996, NULL, NULL, 1995.0, NULL, NULL, 2, 1996.0, 0.0, 0, 1, 1995, 1994, 1.0, 1995.0, 0.0, 1995.0, 1994, 1996.0, 1995, 0.0, 1, 1995, 1995, '-', 1994, NULL, 2, NULL, 'default2', 'default1', NULL, 2, '%Y', '+-', '-', NULL, NULL, '1985', 'default1', 1), (3, '2023-01-01', 2, 0, 2, 2, 1996.0, NULL, 1995.0, 1994, 1994.0, NULL, 1995, 1995, 0, NULL, 1.0, 1996.0, 1.0, 1994.0, 1995, 2.0, 1996, 0.0, 0, 1, 1994, '-', NULL, 1994, NULL, '+-', '+-', '-', 0, NULL, '%Y', '-', 'default1', '+-', '-', '+-', '%Y', 2), (1995, '1985-10-27', 1996, NULL, 0, 0, NULL, 1994.0, 1994.0, 1, 1996.0, 0.0, 1994, 1995, 0, 1994, 1996.0, 0.0, 1994.0, 0.0, 2, NULL, 1996, 1994.0, 0, 2, 2, '%Y', 2, 1995, NULL, '+-', '+-', NULL, 1994, 2, '%Y', '+-', '+-', '1985', 'default2', '+-', '+-', 1995), (1996, '2023-01-01', 0, 1994, 1, 1995, 1.0, NULL, NULL, 1, 1.0, 1995.0, 1994, NULL, 1995, 1996, 0.0, 1996.0, 0.0, NULL, 2, 1995.0, 1, NULL, 2, 1995, 1994, 'default1', 1995, 2, 2, NULL, '+-', '-', 2, 0, NULL, 'default2', '1985', '%Y', 'default2', '%Y', '+-', 0), (5, '2023-01-01', 1995, 2, 2, 1, 0.0, 1994.0, 1.0, 1995, 1.0, 1994.0, 1994, 1995, 1, NULL, 1995.0, 1.0, 1.0, 1995.0, 1995, NULL, NULL, 1995.0, 1995, 1996, 0, '1985', 2, 1994, NULL, 'default1', '+-', 'default2', 2, 0, '%Y', '-', 'default2', '1985', '1985', '-', '%Y', NULL), (2, '1985-10-27', 2, 0, 0, 1, 1994.0, 2.0, 1996.0, 0, NULL, 1995.0, 2, 0, 1994, 1995, 1995.0, 2.0, NULL, 2.0, 2, 1995.0, 1995, 1994.0, 0, 1995, 1, NULL, 1995, 1, 1996, '-', '+-', '+-', NULL, 2, NULL, 'default2', NULL, 'default1', 'default1', '-', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.RA = '-' OR T2.RA = '+-') AND T1.Birthday > 1995 - 01 - 01;

/*
Gold Result:
('-',)
('-',)
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T1.Birthday) >= '1985' AND T2.RA IN ('-', '+-');

/*
Prediction Result:
('-',)
('default2',)
*/