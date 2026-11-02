-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, '-', '2023-01-02', '2023-01-02', '1990-10-27', '0', NULL), (0, '2000', NULL, '1990-10-27', '2023-01-02', '%Y', 'negative'), (2, 'negative', '2000-10-27', NULL, '2000-10-27', 'default2', '1990'), (3, '1990', '2023-01-01', '2023-01-02', '2000-10-27', '2000', '2000'), (4, '%Y', '2000-10-27', '2000-10-27', '2023-01-02', NULL, NULL), (5, '%Y', '1990-10-27', NULL, '1990-10-27', '%Y', '2000'), (6, 'default1', NULL, '2023-01-02', '2023-01-01', 'default1', '%Y');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (0, '2023-01-01', NULL, 0, 1, 0, NULL, 1.0, 0.0, 1, 0.0, 0.0, 0, 0, 0, NULL, NULL, 0.0, NULL, 0.0, 1, NULL, NULL, NULL, NULL, 1, 0, '%Y', 1, NULL, 1, '0', '%Y', '-', 1, 0, '0', '1990', 'default2', '-', '1990', NULL, 'default1', NULL), (1, '2023-01-01', 1, 0, NULL, NULL, 1.0, 1.0, 1.0, 0, 1.0, 0.0, 1, 1, 0, 0, NULL, NULL, 1.0, 1.0, NULL, 0.0, 0, 1.0, 1, 0, 0, '0', NULL, NULL, 1, '%Y', '0', 'default2', 0, 0, NULL, NULL, '1990', '%Y', 'default1', 'negative', '-', 0), (1, '2023-01-02', 0, 0, NULL, 1, 1.0, 1.0, NULL, 1, 1.0, 1.0, NULL, 0, NULL, 0, 0.0, 0.0, 0.0, NULL, NULL, 0.0, 0, 0.0, 1, 0, NULL, 'default1', 1, 0, NULL, '%Y', 'negative', NULL, NULL, 0, '1990', NULL, '-', 'negative', '2000', 'negative', '%Y', 1), (5, '1990-10-27', 1, 1, NULL, NULL, 1.0, 0.0, 0.0, 0, 0.0, NULL, 0, NULL, NULL, 1, 1.0, 0.0, NULL, 1.0, 1, NULL, 1, 0.0, NULL, 0, NULL, '2000', NULL, NULL, 1, 'default2', '2000', '0', 0, NULL, '%Y', 'negative', '0', '0', '0', 'default2', '0', 1), (0, '2023-01-02', 1, 0, 1, 0, 1.0, 0.0, 1.0, 1, 1.0, NULL, NULL, 1, 1, NULL, NULL, NULL, 0.0, NULL, 1, 1.0, 1, 1.0, 0, 0, 0, '-', 0, 1, 0, '2000', '0', '-', NULL, NULL, 'default1', 'default1', '0', 'negative', '2000', 'default2', '0', NULL), (4, '2023-01-01', NULL, NULL, 0, NULL, 0.0, NULL, 0.0, NULL, 0.0, 0.0, 1, NULL, 0, NULL, 1.0, 0.0, 0.0, 1.0, 1, 1.0, 0, 1.0, NULL, 0, NULL, 'default2', 0, 1, 0, 'default1', '1990', 'negative', NULL, 1, NULL, '1990', '-', 'default1', 'negative', '-', '-', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.SSA IN ('negative', '0') AND STRFTIME('%Y', T2.Date) < '1990';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT P.ID) AS patient_count FROM Patient AS P INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE L.SSA IN ('0', '-') AND STRFTIME('%Y', P."First Date") < '2000';

/*
Prediction Result:
(1,)
*/