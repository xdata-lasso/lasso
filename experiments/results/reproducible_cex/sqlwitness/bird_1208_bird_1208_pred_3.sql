-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (61, 'M', NULL, '2023-01-01', '2023-01-01', NULL, 'default1'), (59, 'default2', '2023-01-02', '2023-01-01', NULL, NULL, NULL), (0, 'M', '2023-01-02', NULL, '2023-01-01', 'default1', 'default2'), (1, 'default2', NULL, NULL, '2023-01-01', 'M', 'default1'), (60, 'default2', NULL, NULL, NULL, 'M', 'M'), (2, 'default1', NULL, '2023-01-01', '2023-01-02', 'M', 'default2'), (3, NULL, '2023-01-02', '2023-01-01', '2023-01-01', 'default1', 'default1'), (4, 'default1', '2023-01-01', '2023-01-02', '2023-01-01', NULL, 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (3, '2023-01-01', 59, 59, 1, 60, 59.0, 60.0, 59.0, NULL, 0.0, 59.0, NULL, 59, 0, 61, 0.0, 1.0, 0.0, NULL, 59, NULL, 59, 1.0, 61, 59, NULL, NULL, NULL, 60, 61, NULL, 'M', 'default1', 61, 1, 'default2', 'M', 'default2', 'M', 'default2', 'default1', 'default1', 0), (3, '2023-01-02', 59, NULL, 1, 60, 61.0, 59.0, 0.0, NULL, 60.0, 61.0, 60, 61, 0, 1, NULL, 1.0, 0.0, 59.0, NULL, 0.0, 1, 61.0, 60, 59, 60, NULL, 1, 1, NULL, 'default1', NULL, 'M', 59, 59, 'default2', 'M', 'default1', NULL, 'M', NULL, 'default1', 60), (60, '2023-01-01', 0, NULL, 59, NULL, 59.0, NULL, 0.0, 59, 60.0, 61.0, 59, 60, 0, 1, 1.0, 60.0, 0.0, 61.0, 60, NULL, NULL, NULL, 61, 61, NULL, NULL, NULL, 0, NULL, 'default1', 'default1', 'default2', 60, 61, 'default1', NULL, 'default2', 'M', 'M', NULL, 'default1', 60), (1, '2023-01-01', 59, 59, 60, 0, NULL, 59.0, 60.0, 60, 61.0, 1.0, 0, 1, 61, 59, 59.0, 60.0, 1.0, NULL, 1, 59.0, 61, 0.0, 1, 0, 61, 'default1', NULL, NULL, 0, 'default1', 'M', 'default2', 59, 0, 'default1', 'default2', 'default1', 'M', 'default2', 'default2', 'default2', 0), (59, '2023-01-01', 1, 59, 0, 0, 61.0, NULL, 59.0, 59, NULL, 1.0, 59, 59, NULL, NULL, 0.0, 60.0, 61.0, NULL, 60, 61.0, 1, 61.0, 1, 60, 61, 'default2', NULL, 59, 1, 'default2', 'default2', 'M', 61, NULL, NULL, 'default2', 'default1', 'default2', NULL, 'M', 'default1', 60), (61, '2023-01-01', 59, NULL, 1, 61, 1.0, NULL, NULL, 61, 59.0, 61.0, 59, NULL, 59, 1, 0.0, 61.0, 0.0, 60.0, 1, 59.0, 60, 60.0, 60, 0, 61, 'M', 0, 59, 59, 'default2', 'default1', 'M', 60, 60, 'M', NULL, 'default1', 'default1', 'default1', 'default1', 'default1', 1), (61, '2023-01-02', 61, 60, 60, NULL, 0.0, 0.0, 59.0, 59, 60.0, 1.0, 0, 60, 60, 1, 0.0, 59.0, 60.0, 59.0, 0, 61.0, 59, 1.0, 60, 60, 1, 'default2', 60, 0, 61, NULL, 'default1', 'default2', NULL, 59, 'M', 'M', 'default1', NULL, 'default2', NULL, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.SEX = 'M' AND T2.GPT >= 60;

/*
Gold Result:
(61,)
*/

-- Prediction Query
SELECT Patient.ID FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.SEX = 'M' AND Laboratory.GPT > 60;

/*
Prediction Result:
*/