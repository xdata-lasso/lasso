-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, 'default1', '2023-01-02', '2023-01-01', NULL, '%Y', 'default1'), (251, 'default1', '1937-10-27', NULL, '1937-10-27', 'default2', NULL), (1, 'default1', '1937-10-27', '1937-10-27', NULL, NULL, 'default2'), (250, 'default2', '1937-10-27', NULL, NULL, 'default2', '1937'), (249, '%Y', '2023-01-01', NULL, NULL, 'default2', 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (0, '1937-10-27', NULL, 0, NULL, 251, 1.0, 250.0, 249.0, NULL, 251.0, 0.0, 249, NULL, 1, 1, 0.0, 1.0, 1.0, 250.0, 1, 251.0, 1, 250.0, 1, 250, 249, NULL, NULL, 249, 1, NULL, 'default1', '%Y', NULL, 251, 'default1', 'default2', 'default1', 'default1', '%Y', '%Y', 'default2', 251), (1, '2023-01-01', 249, 249, 251, 251, 0.0, 249.0, 1.0, 1, 249.0, 250.0, 251, 1, 251, 0, 249.0, NULL, 0.0, NULL, 251, 251.0, 250, 1.0, 250, 250, 1, '1937', 0, 250, 249, 'default1', 'default1', '1937', NULL, 251, '%Y', 'default2', 'default2', '1937', 'default1', NULL, '%Y', 251), (250, '1937-10-27', 1, 0, 249, 249, 251.0, 249.0, 250.0, 1, 249.0, 251.0, 251, NULL, 1, NULL, 251.0, 249.0, 1.0, 251.0, 250, 249.0, 251, 0.0, 0, 251, 1, '%Y', 251, 249, NULL, '%Y', '1937', 'default1', 251, 0, NULL, NULL, 'default2', 'default1', NULL, 'default1', '1937', 1), (250, '2023-01-01', 250, 249, 250, 1, NULL, 1.0, 250.0, 0, 250.0, 1.0, 249, 251, 250, 250, 249.0, 250.0, 249.0, 249.0, NULL, 249.0, NULL, 1.0, 249, 250, 249, '%Y', 250, 251, 249, NULL, '1937', '1937', 1, 0, '%Y', 'default2', 'default2', NULL, 'default2', NULL, '1937', 1), (251, '2023-01-01', 250, 250, 0, 249, 250.0, 251.0, 0.0, 0, 250.0, 1.0, 1, 250, 249, 0, 1.0, 0.0, 1.0, NULL, 250, 251.0, 1, 1.0, 249, 0, 249, 'default1', 251, 1, 1, '1937', NULL, '1937', 1, 250, '1937', NULL, 'default2', '1937', 'default2', 'default2', NULL, 251);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T1.Birthday) = '1937' AND T2."T-CHO" >= 250;

/*
Gold Result:
(1,)
(250,)
*/

-- Prediction Query
SELECT DISTINCT p.ID, p.SEX, p.Birthday FROM Patient AS p JOIN Laboratory AS l ON p.ID = l.ID WHERE STRFTIME('%Y', p.Birthday) = '1937' AND l."T-CHO" >= 250;

/*
Prediction Result:
(1, 'default1', '1937-10-27')
(250, 'default2', '1937-10-27')
*/