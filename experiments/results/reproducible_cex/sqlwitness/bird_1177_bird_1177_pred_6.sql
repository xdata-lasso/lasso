-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'default1', '2023-01-01', '2023-01-02', '1995-09-03', 'Abnormal', 'Abnormal'), (2927465, '1995-09-04', '1995-09-03', '1995-09-04', '2023-01-02', 'default1', NULL), (249, 'default1', '1995-09-03', '1995-09-05', '2023-01-01', 'Normal', 'Normal'), (2927464, 'default2', '1995-09-04', NULL, '1995-09-04', NULL, 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (1, '1995-09-05', 2927465, 251, 2927464, 2927463, 2927463.0, 1.0, 2927464.0, 0, 251.0, 2927463.0, 2927464, 251, NULL, NULL, 249.0, 251.0, 1.0, 0.0, 2927464, 2927465.0, 250, 251.0, 251, 249, NULL, NULL, 1, 1, 0, 'default1', 'default2', NULL, 0, 249, 'Abnormal', '1995-09-04', 'Abnormal', 'Normal', 'default2', 'Normal', 'Abnormal', 251), (2927464, '1995-09-04', 1, 2927463, 251, 1, 1.0, 249.0, 250.0, 251, NULL, 2927464.0, NULL, 1, 249, 251, 251.0, 251.0, 2927464.0, 251.0, 2927465, 250.0, 2927464, 1.0, 2927465, 1, 2927463, 'Abnormal', 249, NULL, NULL, 'default2', 'default2', NULL, 251, 251, '1995-09-04', 'default2', 'default1', 'Normal', '1995-09-04', NULL, 'Abnormal', 1), (2927464, '1995-09-03', 249, 2927464, NULL, 0, 2927463.0, 2927465.0, 1.0, 0, 250.0, 2927465.0, 1, 249, NULL, 2927463, 250.0, 1.0, 251.0, 251.0, NULL, 0.0, NULL, 249.0, 2927463, 0, NULL, NULL, NULL, 0, 2927465, '1995-09-04', 'Abnormal', 'Normal', 0, 251, 'default1', 'Abnormal', NULL, 'Normal', 'Normal', 'default2', 'Abnormal', 1), (2927465, '2023-01-02', 0, 2927463, 250, 249, NULL, 0.0, 2927463.0, 2927464, NULL, 251.0, 0, 249, NULL, 1, 249.0, 1.0, 0.0, 2927464.0, 251, NULL, 1, 2927465.0, 1, 249, NULL, 'default1', 251, 2927463, 0, '1995-09-04', NULL, NULL, 2927465, 0, '1995-09-04', NULL, '1995-09-04', 'Abnormal', NULL, NULL, 'Abnormal', 249);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN "T-CHO" < 250 THEN 'Normal' ELSE 'Abnormal' END FROM Laboratory WHERE ID = 2927464 AND Date = '1995-09-04';

/*
Gold Result:
('Abnormal',)
*/

-- Prediction Query
SELECT T1."T-CHO" FROM Laboratory AS T1 WHERE T1.ID = 2927464 AND T1."Date" = '1995-09-04' AND T1."T-CHO" < 250;

/*
Prediction Result:
*/