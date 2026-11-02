-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (299, 'abNormal', '1982-04-01', '2023-01-01', NULL, 'abNormal', 'abNormal'), (0, '1982-04-01', '2023-01-01', '1982-03-31', '1982-03-31', 'default1', 'abNormal'), (1, 'normal', '2023-01-02', '1982-03-31', '2023-01-01', 'abNormal', NULL), (301, 'abNormal', '1982-04-02', '1982-04-02', '2023-01-02', 'abNormal', 'default2'), (300, NULL, '1982-04-01', '1982-04-01', '1982-03-31', 'abNormal', NULL), (2, 'abNormal', '1982-04-01', '2023-01-01', NULL, 'default1', '1982-04-01'), (3, 'default2', '2023-01-01', '2023-01-02', '1982-04-01', 'normal', NULL), (4, 'default1', NULL, '2023-01-02', '1982-03-31', '1982-04-01', 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (2, '2023-01-01', 0, 0, 0, 0, 0.0, NULL, NULL, 301, 0.0, 301.0, 301, NULL, 301, 0, 300.0, 1.0, 301.0, 299.0, 0, 301.0, 300, 0.0, 300, 300, 0, 'normal', 0, 1, NULL, 'default2', 'abNormal', '1982-04-01', 299, 1, '1982-04-01', NULL, 'default2', 'default2', 'default1', 'normal', 'normal', 300), (4, '2023-01-02', 1, 301, 1, 0, NULL, 1.0, 1.0, 301, 1.0, 301.0, 1, 301, 301, 0, NULL, 1.0, 1.0, 0.0, NULL, 300.0, 299, 301.0, NULL, 299, 299, '1982-04-01', 1, NULL, 300, 'default2', NULL, 'abNormal', 300, 1, 'normal', '1982-04-01', 'default2', 'abNormal', 'normal', 'normal', 'default2', 301);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID, CASE WHEN T2.ALP < 300 THEN 'normal' ELSE 'abNormal' END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Birthday = '1982-04-01';

/*
Gold Result:
(2, 'normal')
*/

-- Prediction Query
SELECT P.ID, L.ALP < 300 AS ALP_within_normal_range FROM Patient AS P JOIN Laboratory AS L ON P.ID = L.ID WHERE P.Birthday = '1982-04-01';

/*
Prediction Result:
(2, 1)
*/