-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (251, 'default2', '2023-01-01', '2023-01-01', '1995-09-03', '1995-9-4', '1995-9-4'), (0, 'Normal', NULL, '2023-01-01', '1995-09-04', 'default2', '1995-9-4'), (249, 'Above Normal', '1995-09-03', '2023-01-02', '2023-01-01', 'Normal', NULL), (2927465, '1995-09-04', '1995-09-04', '1995-09-03', '2023-01-02', 'Above Normal', 'Abnormal'), (2927464, 'Normal', '2023-01-01', '2023-01-02', '2023-01-01', NULL, 'Abnormal'), (250, 'default2', '1995-09-05', '1995-09-04', '1995-09-03', 'Above Normal', 'Normal'), (2927463, 'default2', '1995-09-05', '1995-09-03', '1995-09-03', '1995-9-4', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (251, '1995-09-04', 2927465, 1, 251, 0, 2927464.0, 2927465.0, 250.0, 2927464, 251.0, NULL, 251, 1, 2927463, 251, 1.0, 2927465.0, 249.0, 2927464.0, 251, 2927465.0, 249, NULL, 250, NULL, 2927464, 'default1', 1, 2927463, 0, 'default2', 'Above Normal', NULL, 2927465, 249, 'Normal', NULL, 'default2', 'Abnormal', 'Abnormal', 'default1', 'Above Normal', 251), (250, '2023-01-01', 2927464, 249, 2927465, 251, NULL, 0.0, 1.0, 249, 0.0, 1.0, 2927464, 251, NULL, 250, 2927465.0, 0.0, 249.0, 2927465.0, 1, 249.0, 0, 250.0, 249, 2927464, 1, 'Above Normal', 249, NULL, 1, 'default1', 'Above Normal', '1995-09-04', 1, 2927465, 'Above Normal', NULL, 'default2', 'Normal', '1995-09-04', 'Abnormal', '1995-09-04', 2927463), (0, '2023-01-02', 2927464, NULL, 250, 251, 251.0, NULL, 249.0, 250, 249.0, 2927464.0, NULL, 1, 251, 2927463, 2927464.0, 1.0, NULL, 2927465.0, 249, 250.0, 251, 1.0, 249, NULL, 2927465, 'Normal', 2927464, 249, 2927463, 'default1', '1995-09-04', 'default2', 2927465, 2927463, 'Abnormal', '1995-09-04', 'Abnormal', 'Abnormal', 'Above Normal', NULL, 'default1', 250), (2927465, '1995-09-03', 2927465, 250, 249, 250, 2927463.0, 251.0, 2927465.0, 250, 250.0, 2927465.0, 2927465, 0, 2927463, 2927463, 2927465.0, 0.0, 2927464.0, 2927465.0, 2927464, 1.0, 250, 2927463.0, 250, 2927463, 2927463, 'Above Normal', 2927464, 250, 2927463, '1995-9-4', '1995-09-04', '1995-9-4', 2927465, 251, NULL, NULL, 'default2', '1995-09-04', 'Normal', 'Abnormal', '1995-09-04', 0), (2927464, '1995-09-04', 250, 0, 2927464, 251, 2927464.0, 251.0, 251.0, 249, NULL, 2927464.0, 2927463, 0, 250, 2927463, 2927465.0, 251.0, 2927463.0, 0.0, 250, 2927465.0, NULL, 1.0, NULL, 249, 2927465, 'Above Normal', 251, 250, 0, 'default2', '1995-09-04', 'Above Normal', 2927463, 251, 'Abnormal', '1995-9-4', 'Abnormal', '1995-09-04', 'Above Normal', NULL, NULL, NULL), (2927463, '2023-01-02', 2927465, 251, 1, 0, 1.0, 249.0, 1.0, 1, 2927464.0, 251.0, 250, NULL, 2927465, 2927463, 0.0, 2927464.0, 251.0, 2927463.0, 2927465, 2927463.0, NULL, 249.0, 2927463, NULL, 1, NULL, 2927463, 251, 2927465, 'Normal', 'default2', 'Abnormal', 251, 2927465, 'default2', 'default2', '1995-9-4', 'default2', 'Abnormal', 'default1', 'Above Normal', 251);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN "T-CHO" < 250 THEN 'Normal' ELSE 'Abnormal' END FROM Laboratory WHERE ID = 2927464 AND Date = '1995-09-04';

/*
Gold Result:
('Abnormal',)
*/

-- Prediction Query
SELECT CASE WHEN "T-CHO" < 250 THEN 'Normal' ELSE 'Above Normal' END AS "Cholesterol Status" FROM Laboratory WHERE ID = 2927464 AND Date = '1995-9-4';

/*
Prediction Result:
*/