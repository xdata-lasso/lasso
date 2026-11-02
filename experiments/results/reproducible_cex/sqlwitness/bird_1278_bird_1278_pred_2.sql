-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (8, 'default1', '2023-01-02', '2023-01-01', '2023-01-02', NULL, 'default2'), (1999, 'default1', NULL, '2023-01-01', NULL, 'default2', 'default2'), (0, NULL, NULL, NULL, NULL, 'default1', 'default2'), (2000, NULL, '2023-01-01', NULL, '2023-01-02', '+', 'default1');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (0, '2023-01-02', 7, 7, 7, 0, 1999.0, 899.0, 1.0, 2000, 9.0, 0.0, 2001, 9, 1999, 8, 900.0, 9.0, 2000.0, 1999.0, 8, 899.0, 9, 0.0, 7, 1, 1, 'default1', 1999, 900, 0, '+', 'default1', 'default1', 8, 0, 'default2', NULL, 'default2', 'default1', 'default2', 'default1', '+', 0), (8, '2023-01-01', 2001, 1, 900, 7, 2001.0, 899.0, 2000.0, 0, 9.0, 900.0, 1, 2001, 901, 1, 899.0, 1.0, 8.0, 2000.0, 1, 1.0, NULL, 2000.0, 0, 8, NULL, 'default2', 900, 900, 2000, '+', '+', 'default1', 8, 900, 'default2', '+', 'default2', 'default1', '+', 'default2', 'default2', 2001), (1999, '2023-01-01', 0, 2001, 9, NULL, 901.0, 7.0, 0.0, 899, 901.0, 8.0, 900, 8, 0, 2000, 7.0, 2000.0, 899.0, 2000.0, 1999, 1999.0, 9, 900.0, 8, 8, NULL, 'default1', 7, 900, 1999, 'default1', NULL, NULL, NULL, 899, NULL, 'default2', 'default2', '+', 'default2', 'default2', NULL, 899), (2000, '2023-01-01', 2000, 8, 901, 901, 0.0, 2001.0, 2001.0, 0, 8.0, 901.0, 2001, 901, 7, 7, 0.0, 0.0, 2000.0, 899.0, 8, 901.0, 901, 0.0, 1, 899, 899, '+', 900, 1, 899, NULL, 'default2', NULL, 2001, 2000, NULL, 'default2', '+', 'default1', 'default2', '+', NULL, 2000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2."DNA-II" >= 8 AND T1.Admission = '+';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT Patient.ID) FROM Laboratory INNER JOIN Patient ON Laboratory.ID = Patient.ID WHERE Laboratory.IGG > 900 AND Laboratory.IGG < 2000 AND Patient.Admission = '+';

/*
Prediction Result:
(0,)
*/