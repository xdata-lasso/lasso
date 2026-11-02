-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, 'No', '1982-04-01', NULL, '2023-01-01', 'default2', 'default2'), (301, 'No', '2023-01-01', '2023-01-02', NULL, 'default2', 'default1'), (300, 'abNormal', '2023-01-01', '2023-01-01', NULL, 'Yes', 'Yes'), (299, 'default1', '1982-03-31', NULL, '2023-01-01', 'default2', NULL), (1, 'default2', '2023-01-01', '1982-04-01', NULL, 'No', 'No');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (299, '2023-01-02', 299, 0, 1, 0, 0.0, 300.0, 300.0, 1, NULL, 300.0, 300, 300, 0, 299, 301.0, 301.0, 1.0, 301.0, 301, 0.0, 1, 300.0, 1, 300, NULL, 'default2', NULL, 0, 299, 'Yes', 'default2', '1982-04-01', 0, NULL, '1982-04-01', 'No', 'Yes', 'No', 'abNormal', 'normal', NULL, NULL), (0, '1982-04-01', 1, 1, 299, 300, 1.0, 300.0, 300.0, 0, 299.0, 301.0, 0, 0, 300, NULL, 299.0, 299.0, 301.0, 0.0, 299, 0.0, 299, 1.0, 299, 300, NULL, 'No', 299, NULL, 0, 'normal', NULL, 'abNormal', 0, 300, '1982-04-01', 'abNormal', 'No', 'default1', 'default1', 'default1', '1982-04-01', 301), (299, '1982-03-31', 300, NULL, 301, 301, NULL, 300.0, 0.0, 0, 300.0, 300.0, 300, 300, 301, 1, 300.0, 1.0, 301.0, 1.0, 1, 300.0, 300, NULL, 301, NULL, 299, 'default2', 300, 0, 0, 'abNormal', NULL, '1982-04-01', 300, 0, 'normal', 'abNormal', 'default1', NULL, 'abNormal', 'abNormal', 'default2', 1), (299, '1982-04-01', 0, NULL, 301, 301, 301.0, 299.0, 299.0, 299, 301.0, 1.0, 300, 299, 0, 300, 301.0, 300.0, 301.0, 301.0, 300, NULL, 301, 299.0, 1, 300, 300, 'default1', 0, 0, NULL, NULL, 'No', 'Yes', 301, 300, 'No', '1982-04-01', 'No', 'Yes', 'abNormal', 'default2', '1982-04-01', NULL), (1, '1982-03-31', 301, NULL, 301, NULL, 299.0, NULL, 300.0, NULL, 301.0, 301.0, 0, 301, 0, 301, 299.0, 301.0, 299.0, NULL, 1, NULL, 1, 300.0, NULL, NULL, 0, NULL, 299, 299, 301, 'default1', 'default2', NULL, 299, 299, 'default1', 'Yes', 'abNormal', 'normal', '1982-04-01', NULL, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID, CASE WHEN T2.ALP < 300 THEN 'normal' ELSE 'abNormal' END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Birthday = '1982-04-01';

/*
Gold Result:
(0, 'abNormal')
*/

-- Prediction Query
SELECT T1.ID, CASE WHEN T2.ALP < 300 THEN 'Yes' ELSE 'No' END AS ALP_within_range FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Birthday = '1982-04-01';

/*
Prediction Result:
(0, 'No')
*/