-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (301, 'default1', '2023-01-01', '2023-01-02', '2023-01-02', 'default1', 'default2'), (1, 'default2', NULL, '2023-01-01', '2023-01-01', NULL, 'default2'), (299, 'default2', '2023-01-01', NULL, '2023-01-02', NULL, 'default1'), (0, 'default1', '2023-01-02', NULL, '2023-01-01', NULL, NULL), (300, 'default2', '2023-01-01', NULL, NULL, NULL, 'default2'), (2, NULL, '2023-01-01', NULL, '2023-01-01', 'default1', 'default2'), (3, 'default1', NULL, '2023-01-01', '2023-01-02', NULL, 'default2'), (4, 'default1', NULL, '2023-01-02', NULL, NULL, NULL), (5, 'default1', NULL, '2023-01-02', NULL, NULL, 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (299, '2023-01-01', NULL, 1, 299, 1, 0.0, 0.0, NULL, 0, 300.0, NULL, NULL, 299, 0, 301, 301.0, 301.0, 1.0, NULL, 0, 299.0, 300, NULL, 1, NULL, NULL, NULL, 1, 0, 300, NULL, NULL, NULL, 1, 300, 'default2', 'default2', 'default2', 'default1', NULL, 'default2', NULL, 301), (299, '2023-01-02', 0, 301, NULL, 0, 0.0, 300.0, NULL, NULL, 1.0, NULL, 299, 301, NULL, 301, 301.0, 300.0, 300.0, 300.0, 300, 299.0, 0, 300.0, 0, 300, NULL, 'default1', 299, 1, NULL, NULL, NULL, 'default1', 301, 1, 'default2', NULL, 'default1', 'default2', NULL, 'default2', 'default2', NULL), (5, '2023-01-02', 300, 0, 0, NULL, NULL, NULL, 300.0, 301, 299.0, 0.0, NULL, 299, 301, NULL, 300.0, 299.0, 299.0, 301.0, 301, 300.0, 1, 0.0, 0, 299, 1, 'default1', 300, 0, 0, 'default2', 'default1', NULL, 1, NULL, NULL, NULL, 'default1', 'default1', NULL, 'default1', 'default2', 301), (1, '2023-01-01', 0, 1, 299, 300, 1.0, 0.0, 300.0, 1, 300.0, 300.0, NULL, 300, NULL, 0, 301.0, 300.0, 299.0, 300.0, 301, 0.0, 0, NULL, 300, 0, 299, 'default1', 300, NULL, 1, 'default2', NULL, 'default1', 0, NULL, 'default1', 'default2', 'default2', NULL, 'default2', 'default1', 'default1', 1), (1, '2023-01-02', 1, 299, 1, 301, 299.0, NULL, 0.0, 299, 300.0, 299.0, 300, 1, 0, 0, 300.0, 1.0, 0.0, 0.0, 300, 301.0, 301, 0.0, 300, NULL, 299, NULL, 0, NULL, NULL, NULL, 'default1', 'default2', 300, 0, 'default1', 'default2', 'default2', 'default1', NULL, 'default2', 'default1', 301), (301, '2023-01-01', NULL, 1, 299, 0, 1.0, 300.0, 300.0, 0, 301.0, 1.0, NULL, 299, 299, 0, 1.0, 301.0, 301.0, NULL, NULL, 300.0, 299, 299.0, 301, 299, 1, 'default2', NULL, 1, NULL, 'default2', 'default1', 'default1', 301, 300, 'default1', 'default2', 'default2', 'default2', 'default2', NULL, 'default1', NULL), (0, '2023-01-01', 0, 1, 299, 301, 300.0, NULL, 300.0, NULL, NULL, 1.0, 300, NULL, 299, 301, 1.0, 1.0, 1.0, 0.0, 299, 1.0, 1, 300.0, 300, 299, 299, NULL, 0, 300, 301, 'default1', NULL, 'default1', 0, 1, 'default1', NULL, NULL, NULL, NULL, NULL, 'default1', 0), (301, '2023-01-02', 300, 300, 1, 299, 1.0, 301.0, 1.0, NULL, NULL, 300.0, 300, 299, 0, NULL, NULL, 300.0, 301.0, 300.0, 301, 301.0, 0, NULL, 299, 301, 299, NULL, 300, 1, 0, 'default1', 'default1', 'default2', NULL, 0, 'default2', 'default1', 'default1', 'default2', 'default2', 'default2', 'default2', 300), (0, '2023-01-02', 301, 301, 300, 299, 299.0, 0.0, 301.0, 299, 0.0, 0.0, 1, 299, 299, NULL, 301.0, 300.0, 300.0, NULL, 0, 299.0, 1, 301.0, 0, 0, 299, NULL, 1, 301, NULL, NULL, 'default2', NULL, 0, 300, NULL, 'default2', NULL, 'default1', 'default1', 'default2', 'default1', 301);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Admission FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.ALP < 300;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default1',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT P.Admission FROM Laboratory AS L INNER JOIN Patient AS P ON L.ID = P.ID WHERE L.ALP < 300;

/*
Prediction Result:
(None,)
('default1',)
*/