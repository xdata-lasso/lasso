-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (15, '%Y', '1993-01-01', '2023-01-02', '2023-01-01', '1992', '%Y'), (13, NULL, NULL, '2023-01-02', '1992-12-31', 'default1', 'default1'), (0, '1992-12-31', '1992-12-31', '2023-01-01', '1992-12-31', '1992', 'default1'), (1, '1992', '1993-01-01', '1993-01-01', '2023-01-02', '1992-12-31', NULL), (14, 'default2', '1993-01-01', NULL, '1993-01-01', 'default1', '1992'), (2, NULL, '2023-01-02', '2023-01-02', '1992-12-31', 'default2', '%Y'), (3, '1992-12-31', '1992-12-30', '1992-12-30', '1993-01-01', '1992-12-31', NULL), (4, '1992', '2023-01-01', '1992-10-27', NULL, 'default2', 'default1'), (5, NULL, '1992-12-31', '1992-10-27', '1992-12-31', '%Y', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (5, '1993-01-01', 13, 1, NULL, 13, 0.0, 0.0, NULL, 14, 13.0, 1.0, 1, 14, 14, NULL, 13.0, 1.0, 0.0, 1.0, 1, 1.0, 1, 14.0, 13, 13, 1, 'default2', 14, 15, 1, 'default2', '1992-12-31', '1992-12-31', 1, 15, 'default2', '%Y', '1992', '1992-12-31', '1992', 'default1', '1992', 15), (3, '1992-10-27', 14, 13, NULL, 15, 13.0, 13.0, 1.0, 13, 14.0, 14.0, 15, 14, NULL, NULL, NULL, 15.0, 13.0, NULL, 13, 0.0, 15, 14.0, 13, 14, 0, '1992-12-31', NULL, 14, 1, NULL, 'default1', '%Y', NULL, 15, '1992-12-31', '1992-12-31', '1992', '1992', 'default2', '1992-12-31', NULL, 1), (3, '1992-12-31', 0, 0, 1, 1, 13.0, NULL, 15.0, 0, 15.0, NULL, 14, 13, 0, 1, NULL, 15.0, 1.0, NULL, NULL, 1.0, 1, 15.0, 1, 15, 15, '1992-12-31', NULL, 14, 1, NULL, 'default2', '%Y', 13, 1, '%Y', '%Y', NULL, 'default2', '1992-12-31', 'default1', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T1."First Date") > '1992' AND T2.PT < 14;

/*
Gold Result:
(3,)
(3,)
*/

-- Prediction Query
SELECT DISTINCT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1."First Date" > '1992-12-31' AND T2.PT < 14;

/*
Prediction Result:
(3,)
*/