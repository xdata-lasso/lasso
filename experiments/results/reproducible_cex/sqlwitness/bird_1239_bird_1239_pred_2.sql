-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'default1', '2025-01-01', '2023-01-01', '2025-01-01', 'default1', '%Y'), (53, '%Y', '2025-01-01', '2023-01-01', '2023-01-02', NULL, NULL), (52, 'default2', NULL, '2023-01-01', '2023-01-02', 'default2', '2025-01-01 00:00:00'), (3, '2025-01-01 00:00:00', NULL, '2023-01-02', '2025-01-01', '%Y', 'default1'), (2, 'default2', '2025-01-01', '2023-01-02', NULL, NULL, 'default1'), (51, '2025-01-01 00:00:00', NULL, '2025-01-01', '2025-01-01', 'default2', '%Y'), (0, '2025-01-01 00:00:00', NULL, '2023-01-02', '2023-01-01', '%Y', 'default2'), (4, '%Y', '2023-01-01', '2023-01-02', '2023-01-01', '2025-01-01 00:00:00', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (1, '2025-01-01', 53, 52, 3, 51, 2.0, NULL, 51.0, 0, 53.0, 3.0, 52, 1, NULL, 2, 52.0, 1.0, NULL, NULL, 52, 2.0, 52, 0.0, 2, 53, 0, 'default1', 52, 53, NULL, NULL, '2025-01-01 00:00:00', 'default1', 51, 51, 'default2', '2025-01-01 00:00:00', 'default1', 'default2', 'default1', 'default1', 'default2', 1), (1, '2023-01-01', 1, 51, 1, 0, 1.0, 3.0, 2.0, 2, 53.0, NULL, 3, 51, 2, 52, 2.0, 2.0, 53.0, 52.0, 53, 3.0, 53, NULL, 53, NULL, 53, NULL, 1, 0, 2, NULL, 'default1', '2025-01-01 00:00:00', 2, 3, 'default1', 'default1', 'default2', 'default2', 'default2', 'default2', '2025-01-01 00:00:00', 51), (1, '2023-01-02', 0, 51, 2, NULL, 51.0, NULL, 0.0, NULL, 2.0, 3.0, 2, 52, NULL, 53, 51.0, 51.0, 3.0, 52.0, 52, 3.0, 1, 53.0, 51, 53, 3, NULL, 0, 0, 1, 'default1', '2025-01-01 00:00:00', 'default2', 52, 2, '2025-01-01 00:00:00', 'default2', 'default2', 'default2', 'default2', '2025-01-01 00:00:00', 'default1', NULL), (53, '2025-01-01', NULL, 3, 2, 2, 2.0, 51.0, 53.0, 3, 1.0, NULL, 52, 52, 52, 1, 51.0, 53.0, 53.0, 51.0, 53, 53.0, 0, NULL, NULL, 1, 1, NULL, 53, 3, 52, NULL, '%Y', 'default1', 1, 2, '2025-01-01 00:00:00', 'default1', 'default1', 'default2', '2025-01-01 00:00:00', 'default1', 'default1', NULL), (0, '2023-01-02', 51, 0, 2, 2, 52.0, NULL, NULL, 3, 2.0, 51.0, 0, 52, NULL, 0, 0.0, 51.0, 0.0, 53.0, 2, 53.0, 0, 3.0, 51, 51, 3, NULL, 1, 0, 0, '%Y', NULL, '%Y', 2, 3, '%Y', '%Y', 'default2', '2025-01-01 00:00:00', 'default1', '%Y', '%Y', 51);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.ID IN (SELECT ID FROM Laboratory WHERE HCT >= 52 GROUP BY ID HAVING COUNT(ID) >= 2);

/*
Gold Result:
(1, 0)
*/

-- Prediction Query
SELECT T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) AS age FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.HCT > 52 GROUP BY T1.ID HAVING COUNT(T2.ID) >= 2;

/*
Prediction Result:
*/