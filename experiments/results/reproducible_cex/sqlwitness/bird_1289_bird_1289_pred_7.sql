-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'default2', NULL, NULL, NULL, 'SJS', 'default2'), (0, 'SJS', '2023-01-01', NULL, NULL, 'default1', 'default2'), (2, 'SJS', '2023-01-02', '2023-01-01', '2023-01-01', NULL, 'SJS');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (0, '2023-01-02', NULL, 1, NULL, 1, 5.0, 9.5, 1.0, 0, 7.0, NULL, 1, 1, 1, NULL, 1.0, 5.0, 8.5, 7.5, 1, 7.0, 0, 0.0, 0, NULL, NULL, 'default1', NULL, NULL, NULL, NULL, 'default1', NULL, 0, NULL, 'default1', 'SJS', 'default1', 'default2', NULL, 'SJS', 'default2', NULL), (2, '2023-01-01', NULL, 1, 1, 0, 6.0, 7.5, 6.0, NULL, 9.5, 8.5, 0, NULL, 1, NULL, 6.0, 1.0, 7.0, 0.0, 0, NULL, 1, 0.0, 0, 0, NULL, 'SJS', 1, 0, 0, NULL, 'default2', 'SJS', 1, NULL, NULL, NULL, 'SJS', 'default1', 'default2', 'default2', 'SJS', NULL), (2, '2023-01-02', 1, 1, 1, 0, 7.0, 0.0, 7.5, 0, 1.0, NULL, NULL, NULL, 0, 0, 7.0, 7.5, 5.0, NULL, NULL, 0.0, 1, 0.0, NULL, 0, 1, NULL, 0, 1, NULL, 'default2', NULL, 'SJS', NULL, 1, 'default2', 'default1', 'SJS', 'default2', NULL, 'SJS', 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Diagnosis = 'SJS' AND T2.TP > 6.0 AND T2.TP < 8.5;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.ID) FROM Patient AS T1 JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Diagnosis = 'SJS' AND T2.TP BETWEEN 6.0 AND 8.5;

/*
Prediction Result:
(2,)
*/