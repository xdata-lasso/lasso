-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (300, 'default2', NULL, NULL, '1982-03-31', 'abNormal', NULL), (1, '1982-04-01', '1982-04-01', '1982-04-01', '2023-01-01', 'default2', NULL), (299, 'default1', '1982-03-31', '2023-01-01', '1982-04-02', 'abNormal', 'normal'), (301, NULL, '2023-01-01', '2023-01-01', '1982-04-02', '1982-04-01', '1982-04-01'), (0, '1982-04-01', '1982-04-01', '1982-03-31', '1982-04-01', '1982-04-01', 'normal'), (2, 'default2', '1982-04-02', '1982-03-31', '2023-01-02', 'default1', 'Outside Normal Range'), (3, 'default1', '1982-03-31', '1982-04-02', NULL, 'normal', 'default2'), (4, NULL, '2023-01-01', '1982-03-31', '1982-04-02', 'abNormal', 'abNormal');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (1, '1982-03-31', 1, 299, 299, 0, 0.0, 299.0, 1.0, 1, 300.0, 300.0, 1, 0, 300, 1, 300.0, 1.0, 1.0, 0.0, 0, NULL, NULL, 1.0, 0, 0, NULL, NULL, 0, 300, 300, 'abNormal', 'normal', 'default1', 1, 301, 'Within Normal Range', 'Within Normal Range', '1982-04-01', 'Within Normal Range', '1982-04-01', 'abNormal', NULL, 299), (300, '1982-04-01', 299, 300, 301, 299, NULL, 301.0, 1.0, 1, 0.0, 1.0, NULL, 301, 300, 301, NULL, 0.0, NULL, 1.0, 301, NULL, 1, 300.0, 299, 0, 300, NULL, 301, 299, NULL, 'Within Normal Range', 'abNormal', 'default1', 1, 300, 'abNormal', 'normal', 'Outside Normal Range', 'abNormal', 'normal', '1982-04-01', 'abNormal', NULL), (0, '1982-03-31', NULL, 299, NULL, 301, 0.0, 0.0, 300.0, 1, 1.0, 301.0, 1, 300, 1, 299, NULL, 300.0, 0.0, NULL, 301, 301.0, NULL, 300.0, 299, 301, 1, 'abNormal', 300, NULL, 300, 'Outside Normal Range', 'default1', '1982-04-01', 299, 299, 'default2', 'normal', 'default2', 'abNormal', 'default2', '1982-04-01', 'normal', NULL), (2, '1982-03-31', 300, 299, 0, 299, NULL, 300.0, 301.0, 300, 301.0, 299.0, 0, 300, 301, 0, 1.0, 1.0, NULL, 0.0, 0, 301.0, 299, 301.0, 299, NULL, 300, 'normal', NULL, 1, 301, 'abNormal', 'default2', 'Within Normal Range', 0, 301, 'normal', 'default2', 'Within Normal Range', 'default1', 'default1', 'Outside Normal Range', NULL, 0), (300, '2023-01-02', NULL, 301, 1, 0, NULL, 300.0, 1.0, 1, 0.0, 301.0, 301, 301, NULL, 299, 0.0, 299.0, 0.0, 299.0, 0, NULL, 299, 0.0, 299, 299, 301, NULL, 299, 1, 299, 'default2', NULL, 'Outside Normal Range', 300, 0, 'Within Normal Range', 'abNormal', 'Within Normal Range', 'Within Normal Range', NULL, 'normal', NULL, 300), (299, '1982-03-31', 300, 1, 1, 299, 299.0, 301.0, 299.0, NULL, 299.0, 300.0, 0, 301, 301, 1, 1.0, 299.0, NULL, 301.0, 0, 301.0, 1, 300.0, 1, 0, 300, 'normal', 1, 301, 0, 'default2', '1982-04-01', '1982-04-01', NULL, 301, '1982-04-01', NULL, 'normal', 'default1', 'Outside Normal Range', 'default2', '1982-04-01', NULL), (300, '1982-04-02', 0, 301, NULL, 299, 300.0, 300.0, 300.0, 1, 299.0, 301.0, 301, 299, 299, 300, 299.0, 299.0, NULL, 0.0, 0, 0.0, NULL, 300.0, 299, 301, 1, 'Outside Normal Range', 0, 301, 1, 'Within Normal Range', 'default1', 'Within Normal Range', 300, 300, 'default1', 'abNormal', 'default2', 'default2', 'Within Normal Range', 'abNormal', '1982-04-01', 300), (301, '1982-04-02', 0, 301, NULL, 299, 299.0, 301.0, 300.0, 299, 300.0, NULL, NULL, 301, 300, 300, NULL, 301.0, 0.0, 299.0, 301, 300.0, 301, 1.0, NULL, NULL, 300, 'default2', 0, 0, 1, '1982-04-01', NULL, NULL, 301, NULL, '1982-04-01', 'Outside Normal Range', 'normal', 'normal', 'default2', 'Outside Normal Range', 'abNormal', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID, CASE WHEN T2.ALP < 300 THEN 'normal' ELSE 'abNormal' END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.Birthday = '1982-04-01';

/*
Gold Result:
(0, 'abNormal')
(1, 'normal')
*/

-- Prediction Query
SELECT P.ID, CASE WHEN L.ALP < 300 THEN 'Within Normal Range' ELSE 'Outside Normal Range' END AS ALP_Status FROM Patient AS P INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE P.Birthday = '1982-04-01';

/*
Prediction Result:
(0, 'Outside Normal Range')
(1, 'Within Normal Range')
*/