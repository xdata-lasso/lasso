-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'F', '2023-01-01', NULL, '2023-01-01', 'F', 'default1'), (0, 'F', '2023-01-02', NULL, '2023-01-01', 'default2', 'default1'), (101, 'default2', '2023-01-02', '2023-01-01', '2023-01-01', 'F', 'default1');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (1, '2023-01-01', 101, NULL, -1, 101, 5.5, 1.0, 100.0, 99, 101.0, -1.0, -1, 100, NULL, 101, 100.0, 101.0, -1.0, 100.0, 2, 99.0, 99, NULL, 101, 100, -1, 'default2', NULL, 2, 1, NULL, NULL, 'default2', 1, 101, NULL, 'default2', 'default1', 'F', 'F', 'F', 'default1', -1), (0, '2023-01-02', 2, 0, 99, 2, 6.5, 1.0, 1.0, 1, 101.0, 1.0, 101, 99, 100, 101, 101.0, 101.0, 2.0, 100.0, 2, 6.5, 100, 7.5, 2, -1, 99, 'default1', -1, 99, 100, 'F', NULL, NULL, 100, 101, 'F', 'F', NULL, NULL, 'default1', NULL, NULL, 99), (1, '2023-01-02', 2, -1, 101, 99, 0.0, 0.0, 99.0, 99, 2.0, 99.0, 99, 1, 99, 101, NULL, 1.0, 0.0, 1.0, 101, 5.5, 101, 5.5, -1, -1, 1, 'default1', 2, 101, 99, 'default2', NULL, 'default1', 2, -1, 'F', 'default1', 'default2', 'default1', 'default1', 'default1', 'default2', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.UA > 6.5 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.SEX = 'F';

/*
Gold Result:
(66.66666666666667,)
*/

-- Prediction Query
SELECT (SELECT COUNT(*) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.SEX = 'F' AND T2.UA > 6.5) / (SELECT COUNT(*) FROM Patient WHERE SEX = 'F') * 100 AS percentage_female_UA_beyond_normal_range;

/*
Prediction Result:
(100,)
*/