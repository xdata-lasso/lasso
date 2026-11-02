-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (2, 'default2', '2023-01-01', '2023-01-01', NULL, 'F', 'default1'), (99, 'default1', NULL, NULL, '2023-01-02', 'default2', 'default2'), (101, 'F', '2023-01-02', '2023-01-02', '2023-01-02', NULL, 'default1'), (0, NULL, '2023-01-02', NULL, NULL, 'default1', 'F'), (1, 'default1', NULL, '2023-01-02', '2023-01-01', 'default2', NULL), (100, 'default2', '2023-01-01', '2023-01-01', NULL, 'F', 'default2'), (-1, 'F', '2023-01-02', NULL, '2023-01-02', NULL, NULL), (3, 'F', '2023-01-02', '2023-01-02', '2023-01-01', 'default2', 'default1');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (-1, '2023-01-01', -1, 100, 1, -1, 6.5, 99.0, 0.0, 101, 6.5, 0.0, -1, -1, 1, NULL, 101.0, 8.0, 7.0, 6.5, 1, 1.0, NULL, 7.5, 101, 0, 100, 'default2', -1, -1, -1, 'default2', 'default2', 'F', 2, 101, NULL, 'default1', 'default1', 'default2', NULL, 'default2', 'default2', NULL), (3, '2023-01-01', 101, 1, 0, 2, 7.0, 101.0, 7.0, NULL, 1.0, 5.5, 2, 100, 101, 99, -1.0, 2.0, -1.0, 7.5, NULL, 101.0, 101, 2.0, 101, 2, 99, 'F', 101, -1, 2, 'default1', 'default1', NULL, 99, 2, 'default2', 'default1', NULL, 'default1', 'default1', 'default2', 'default1', 101), (2, '2023-01-02', 101, 0, 101, 99, 6.5, 99.0, 5.5, -1, 1.0, NULL, 2, 0, 100, -1, 5.5, 99.0, 7.5, 5.5, 99, -1.0, 2, 6.5, NULL, 99, NULL, 'default2', 99, -1, NULL, 'F', 'default1', 'default1', 1, 2, 'F', 'F', 'default1', 'default2', 'default2', 'F', 'default1', 1), (0, '2023-01-01', 101, 1, 99, -1, 5.5, 9.0, 101.0, -1, 1.0, 7.0, 0, NULL, -1, 1, NULL, -1.0, 7.0, 101.0, 0, 101.0, 101, 100.0, -1, 101, NULL, 'F', NULL, 99, NULL, 'default2', NULL, 'F', 99, 1, 'default1', 'default2', NULL, NULL, 'F', 'default1', 'default2', 99), (1, '2023-01-01', NULL, 99, 100, 101, 100.0, 7.5, 5.5, -1, 2.0, NULL, NULL, -1, NULL, 0, 99.0, 2.0, 9.0, 6.5, 101, 7.0, -1, -1.0, 100, 100, 1, 'default2', 100, 100, 101, 'default2', 'default2', 'F', 100, 101, 'default2', 'default2', NULL, NULL, 'default2', 'default1', NULL, 2), (101, '2023-01-01', 2, -1, 2, 100, 6.5, 101.0, 6.5, 99, 99.0, 8.0, NULL, 99, 2, 101, 6.5, -1.0, -1.0, 1.0, 1, -1.0, 2, 100.0, -1, 1, 100, 'F', 100, 101, 1, 'F', NULL, NULL, NULL, 0, 'F', 'default1', 'default1', NULL, 'default2', NULL, 'default2', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.UA > 6.5 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.SEX = 'F';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN T2.UA > 8.0 THEN 1 END) AS REAL) * 100.0 / COUNT(*) AS percentage FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Sex = 'F';

/*
Prediction Result:
(0.0,)
*/