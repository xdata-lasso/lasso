-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (2000, 'default2', '2023-01-02', NULL, '2023-01-01', 'default1', 'default2'), (1999, NULL, '2023-01-01', '2023-01-01', NULL, 'default2', '+'), (900, 'default2', '2023-01-02', NULL, '2023-01-01', '+', '+');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (2000, '2023-01-02', 2001, 899, 7, 1, 9.0, 0.0, 1.0, 901, 7.0, 901.0, 2001, 0, 2001, 1, 900.0, 901.0, 900.0, 899.0, 1999, 1999.0, 901, 899.0, 8, 1, 900, '+', 1999, NULL, 9, 'default2', NULL, 'default2', 8, 7, 'default2', 'default1', 'default2', NULL, 'default2', 'default1', '+', 2001), (900, '2023-01-01', 8, 900, 1999, 9, 9.0, 0.0, 9.0, 2000, 2001.0, 8.0, 2000, 9, 2000, 8, 9.0, 9.0, 1.0, 7.0, 8, NULL, 2001, 2001.0, 0, 900, 0, 'default2', 1, 7, 7, '+', 'default2', 'default1', 901, 1999, 'default2', 'default2', 'default1', 'default2', '+', '+', 'default2', 900), (1999, '2023-01-02', 899, 901, 9, 899, NULL, 1.0, 9.0, 2001, 899.0, 900.0, 9, 2000, 1, 9, 2000.0, 2000.0, NULL, 2000.0, 901, 901.0, 900, 9.0, 7, 1, 1, 'default1', 901, 8, 1999, 'default2', NULL, '+', 1, 900, '+', NULL, 'default1', NULL, '+', 'default1', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2."DNA-II" >= 8 AND T1.Admission = '+';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT p.id) FROM patient AS p INNER JOIN laboratory AS l ON p.id = l.id WHERE p.admission = '+' AND l.igg > 900 AND l.igg < 2000;

/*
Prediction Result:
(0,)
*/