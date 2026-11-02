-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (250, NULL, '1995-09-04', '1995-09-04', '1995-09-03', 'default2', 'Abnormal'), (2927463, 'default1', '1995-09-04', '1995-09-05', '2023-01-01', 'default2', 'default1'), (249, 'default2', '1995-09-03', '1995-09-03', '2023-01-01', 'Normal', '1995-09-04'), (2927464, NULL, '2023-01-02', '2023-01-01', '1995-09-04', 'Abnormal', 'default1'), (1, NULL, '1995-09-04', '2023-01-02', '1995-09-03', 'default2', 'default1'), (2927465, '1995-09-04', '2023-01-01', NULL, '2023-01-02', 'default1', '1995-09-04'), (251, 'Abnormal', '2023-01-02', '2023-01-02', '2023-01-01', 'default1', 'default1');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (2927464, '1995-09-04', 2927465, 249, NULL, 250, 1.0, 2927463.0, 2927463.0, 250, 250.0, 2927463.0, 1, 250, 2927463, 2927464, 250.0, 2927465.0, 1.0, 250.0, 0, NULL, 251, 251.0, 251, 1, 2927465, 'default1', 2927464, 251, 2927465, 'default1', 'default2', 'default1', 2927463, 251, NULL, NULL, NULL, 'default1', 'Abnormal', NULL, 'default1', 2927464), (250, '1995-09-05', 0, 0, 251, NULL, 250.0, 251.0, 251.0, 2927463, 250.0, 2927464.0, 249, 250, 250, NULL, 2927465.0, 1.0, 251.0, 251.0, 2927465, 2927465.0, 250, 0.0, 2927463, 0, 251, 'default1', 250, 2927464, 2927464, 'Normal', 'Normal', 'Abnormal', 0, 1, 'default2', '1995-09-04', 'Abnormal', 'Normal', 'default2', NULL, 'Normal', 251), (251, '2023-01-02', 251, 0, 251, 0, 0.0, 0.0, 1.0, 2927465, NULL, 2927465.0, 251, NULL, 0, 2927463, NULL, 2927464.0, 249.0, 2927463.0, 0, 1.0, 2927463, 2927465.0, 0, 2927463, 2927463, 'Normal', 250, 2927464, 2927463, 'default2', 'Normal', 'default2', 249, 1, 'default1', '1995-09-04', 'default2', 'Normal', '1995-09-04', 'Abnormal', NULL, 2927464), (2927464, '2023-01-02', 2927465, 2927465, 2927465, 251, NULL, 2927463.0, NULL, 0, 0.0, 2927463.0, 250, 1, NULL, 2927463, 250.0, 250.0, 2927465.0, 0.0, 251, 251.0, 250, 1.0, 249, NULL, 2927465, 'default2', 0, 1, 2927463, 'default1', 'default1', '1995-09-04', 2927465, 2927464, NULL, 'Abnormal', 'default1', 'Abnormal', 'default1', NULL, 'Normal', 2927463), (1, '1995-09-03', 1, 2927464, NULL, 250, 1.0, 0.0, 251.0, NULL, 2927465.0, 1.0, 2927464, 2927464, 2927465, 250, 2927465.0, 251.0, 2927464.0, 2927463.0, 250, NULL, 2927465, 1.0, 1, 0, 2927464, 'default2', 250, 0, 2927463, 'default1', 'Normal', NULL, 2927465, 1, NULL, NULL, 'Abnormal', '1995-09-04', 'Normal', '1995-09-04', '1995-09-04', 250), (2927465, '2023-01-02', NULL, 249, 1, NULL, 1.0, 0.0, 250.0, 2927465, 249.0, 249.0, 2927464, 251, 249, 0, 1.0, 250.0, 250.0, 2927464.0, 249, 251.0, 2927465, 2927463.0, 1, 1, 2927463, NULL, 251, 251, 250, 'default2', '1995-09-04', NULL, 249, 2927465, 'default2', NULL, 'default2', 'Normal', 'Abnormal', '1995-09-04', 'Abnormal', 249), (2927463, '2023-01-01', NULL, 251, 250, 2927463, 1.0, NULL, 2927463.0, 249, 2927463.0, 1.0, 250, 2927465, 2927463, 2927465, NULL, 249.0, 1.0, 250.0, NULL, 249.0, 251, 251.0, 2927464, 249, 2927464, '1995-09-04', 1, 2927464, 249, 'default2', 'Abnormal', 'Normal', 250, 251, 'Abnormal', 'default1', 'default1', NULL, 'Normal', 'default1', NULL, 251);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN "T-CHO" < 250 THEN 'Normal' ELSE 'Abnormal' END FROM Laboratory WHERE ID = 2927464 AND Date = '1995-09-04';

/*
Gold Result:
('Normal',)
*/

-- Prediction Query
SELECT "T-CHO" < 250 AS is_normal FROM Laboratory WHERE ID = 2927464 AND Date = '1995-09-04';

/*
Prediction Result:
(1,)
*/