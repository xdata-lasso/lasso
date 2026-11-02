-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'F', NULL, '2023-01-01', '2023-01-01', 'F', 'default2'), (0, 'F', NULL, '2023-01-02', '2023-01-01', NULL, 'M'), (2, 'M', NULL, '2023-01-02', '2023-01-02', 'default2', 'F'), (3, 'M', '2023-01-01', NULL, NULL, NULL, NULL), (4, 'F', NULL, '2023-01-02', '2023-01-01', 'F', 'M'), (5, 'default2', '2023-01-02', '2023-01-01', NULL, 'default1', 'default1');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (2, '2023-01-02', NULL, 0, 0, NULL, 7.5, NULL, 6.5, NULL, 7.0, 5.5, NULL, 0, NULL, 1, 9.0, 7.5, 5.5, 1.0, NULL, 8.0, NULL, 5.5, NULL, 1, 1, 'default1', 0, NULL, 0, 'default1', 'M', 'M', 0, 0, 'default1', NULL, 'default1', 'F', 'F', 'default2', 'M', 0), (5, '2023-01-02', NULL, 0, NULL, NULL, 7.0, 7.5, 7.5, 0, 7.0, 6.5, 0, 0, NULL, 0, 7.0, 6.5, 8.0, 1.0, 0, 6.5, NULL, 7.5, 1, 0, 1, 'default2', 0, 0, NULL, 'default1', 'F', NULL, 0, NULL, 'default2', 'F', 'default2', NULL, 'default2', NULL, 'default2', NULL), (1, '2023-01-01', 1, 0, 0, 1, 5.5, 5.5, 9.0, 0, 7.5, 7.5, NULL, 0, NULL, 0, 1.0, 9.0, NULL, 0.0, 0, 7.0, NULL, 8.0, 0, 0, 0, NULL, 1, NULL, 0, NULL, 'default1', 'M', 0, NULL, 'default2', NULL, 'M', NULL, 'F', NULL, 'default2', 1), (1, '2023-01-02', NULL, 1, 0, NULL, 8.0, 5.5, 7.0, NULL, 0.0, 7.0, NULL, NULL, 1, 0, 9.0, 8.0, 7.5, 9.0, 1, 7.0, 0, 9.0, 0, NULL, NULL, 'F', 1, 1, 0, 'default1', NULL, NULL, NULL, NULL, 'default2', 'M', NULL, 'F', NULL, 'default1', NULL, 0), (4, '2023-01-02', NULL, 1, 0, 1, 5.5, 8.0, 7.0, 1, 1.0, 9.0, 1, 0, NULL, NULL, 9.0, NULL, 0.0, 0.0, NULL, 7.5, 0, 1.0, NULL, NULL, 0, 'M', 0, 1, 0, 'default1', NULL, NULL, 0, NULL, 'default1', NULL, 'default2', 'F', 'F', 'M', NULL, 1), (0, '2023-01-02', 1, NULL, 0, 0, NULL, 7.5, 6.5, NULL, 7.0, 7.5, NULL, 1, 1, 1, 5.5, 6.5, 7.0, 7.5, 0, 6.5, 1, 0.0, 0, NULL, NULL, NULL, 1, NULL, NULL, 'default2', 'default1', 'default2', 1, 1, 'F', NULL, 'F', NULL, NULL, 'default2', 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.UA) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.UA > 6.5 AND T1.SEX = 'F') OR (T2.UA > 8.0 AND T1.SEX = 'M') AND T2.Date = (SELECT MAX(Date) FROM Laboratory);

/*
Gold Result:
(7.666666666666667,)
*/

-- Prediction Query
SELECT AVG(T1.UA) FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T1.Date = (SELECT MAX(Date) FROM Laboratory WHERE ID = T1.ID) AND (T2.SEX = 'M' AND T1.UA < 8.0 OR T2.SEX = 'F' AND T1.UA < 6.5);

/*
Prediction Result:
(6.5,)
*/