-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, 'default2', '1990-10-27', NULL, '2023-01-02', 'default1', 'negative'), (1, '1990', '1990-10-27', NULL, '2023-01-02', '%Y', 'default2'), (2, '%Y', '2023-01-01', '2000-10-27', '2023-01-01', 'negative', NULL), (3, 'default1', '2000-10-27', '2023-01-02', '2000-10-27', '%Y', '1990'), (4, '1990', '2000-10-27', '2023-01-01', '2023-01-01', '-', 'negative'), (5, '0', '1990-10-27', '2023-01-01', '2000-10-27', 'default1', 'default2'), (6, '+-', '2000-10-27', NULL, '2000-10-27', 'default2', 'default2'), (7, '%Y', '1990-10-27', '2023-01-02', '1990-10-27', '-', 'default1');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (1, '2023-01-02', 0, 1, 1, 1, 0.0, 0.0, 1.0, 0, 0.0, NULL, NULL, 0, 0, 1, NULL, 1.0, NULL, 0.0, 1, 0.0, 0, 1.0, 0, 0, 1, NULL, 0, 1, NULL, 'default2', '%Y', 'default1', NULL, 0, '0', '2000', '%Y', '%Y', NULL, 'default1', NULL, NULL), (3, '2023-01-02', 0, NULL, 1, NULL, NULL, 1.0, NULL, NULL, 1.0, 0.0, NULL, 1, 1, 0, 1.0, NULL, NULL, 0.0, NULL, 1.0, 1, 1.0, 1, 1, 1, NULL, 0, 0, NULL, '+-', '2000', '-', 1, NULL, 'default2', '-', 'negative', NULL, '2000', '0', NULL, 1), (6, '2023-01-01', 0, 0, 1, 1, 1.0, 1.0, 1.0, 0, NULL, 1.0, 0, 0, 0, 0, 1.0, NULL, 1.0, 1.0, 1, 0.0, 1, NULL, NULL, 0, 1, '2000', 1, NULL, NULL, 'default2', 'default2', '1990', 1, NULL, 'default2', '0', 'negative', 'default1', 'default2', '%Y', 'default1', 0), (7, '2023-01-02', 1, NULL, 1, NULL, NULL, 1.0, NULL, 1, 1.0, NULL, 1, 1, 1, 1, 0.0, 1.0, 1.0, 1.0, NULL, 1.0, 1, 0.0, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, '-', '0', 1, 1, '1990', '2000', '+-', '-', '+-', '-', '-', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.SSA IN ('negative', '0') AND STRFTIME('%Y', T2.Date) < '1990';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT Patient.ID) FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.SSA IN ('-', '+-', '0', 'negative') AND STRFTIME('%Y', Patient."First Date") < '2000';

/*
Prediction Result:
(1,)
*/