-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (900, 'default1', '2023-01-01', '2023-01-02', '2023-01-02', NULL, NULL), (0, 'default2', '2023-01-02', NULL, '2023-01-02', 'default2', NULL), (2000, 'default2', NULL, '2023-01-02', '2023-01-01', NULL, 'default1'), (899, NULL, '2023-01-01', '2023-01-01', '2023-01-01', NULL, NULL), (1999, 'default2', NULL, NULL, '2023-01-01', 'default2', 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (2000, '2023-01-01', 0, 900, 901, 899, 899.0, 1999.0, 899.0, 2000, 1.0, 901.0, 0, 1, 901, 2000, 2001.0, 0.0, 900.0, 899.0, 2001, 2001.0, 901, 2001.0, 2000, 900, 901, 'default1', 1, 1, 900, 'default1', 'default1', 'default1', 1999, 1, NULL, NULL, 'default1', 'default2', 'default1', 'default1', 'default1', 0), (899, '2023-01-01', 2001, NULL, 2001, 1, 2000.0, 899.0, 900.0, 2001, 2001.0, 2000.0, 2000, 2001, 2001, 901, 901.0, 2000.0, 901.0, 901.0, 2001, 900.0, 899, 899.0, 0, 899, 900, 'default1', 1999, 900, 1, NULL, NULL, NULL, 901, 1, NULL, NULL, 'default1', NULL, 'default2', 'default2', NULL, 2000), (899, '2023-01-02', 2001, 1, 900, 1, 0.0, 899.0, 899.0, NULL, 2000.0, 901.0, 899, 899, NULL, 0, 2001.0, 900.0, 901.0, 2001.0, 0, 900.0, 1, 1999.0, 0, NULL, 1, 'default1', 901, 900, 1999, NULL, 'default1', 'default2', 1, 0, 'default2', NULL, NULL, 'default2', NULL, 'default1', 'default1', 1), (900, '2023-01-01', 1, 0, 2001, 901, 0.0, 2001.0, 899.0, 2000, 1999.0, 901.0, 2000, 2001, 899, 2001, 1999.0, 900.0, 2000.0, 2000.0, 899, 899.0, 1999, 1.0, 1999, 2001, 899, NULL, NULL, 901, 2001, 'default2', NULL, 'default1', 1999, 900, 'default1', 'default2', 'default2', 'default2', 'default2', 'default1', 'default1', 1), (900, '2023-01-02', 2000, 0, 899, 1999, 0.0, 2000.0, 1999.0, 1, 1999.0, 0.0, NULL, 0, 901, NULL, 1.0, 900.0, 0.0, 901.0, 2001, 900.0, 0, 2000.0, 899, NULL, 1999, NULL, 0, 2000, 2001, 'default1', 'default2', NULL, 2000, 0, NULL, 'default1', NULL, NULL, 'default1', 'default2', 'default2', 0);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (2000, '2023-01-02', 899.0, 2000.0, 1, NULL, 2001, 'default1', 'default2', NULL, 'default2', 'default2', 2000), (2000, '2023-01-02', 899.0, 0.0, 901, 'default1', 0, 'default2', 'default1', 'default2', NULL, 'default2', 0), (1999, NULL, 899.0, 901.0, 901, 'default2', 0, 'default1', 'default2', NULL, NULL, 'default2', 1999), (899, NULL, NULL, NULL, NULL, 'default1', 1, 'default2', 'default1', 'default2', 'default1', NULL, 0), (899, '2023-01-01', 2001.0, NULL, 1999, 'default2', 2000, 'default2', NULL, 'default2', 'default1', 'default1', 1999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T3.ID = T2.ID WHERE T2.IGG BETWEEN 900 AND 2000 AND NOT T3.Symptoms IS NULL;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT t1.id) FROM laboratory AS t1 INNER JOIN examination AS t2 ON t1.id = t2.id WHERE t1.igg > 900 AND t1.igg < 2000 AND NOT t2.symptoms IS NULL;

/*
Prediction Result:
(1,)
*/