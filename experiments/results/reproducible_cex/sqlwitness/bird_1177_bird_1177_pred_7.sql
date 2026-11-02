-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (2927464, 'Normal', NULL, '1995-09-03', '2023-01-01', 'Normal', 'Normal'), (2927465, 'default1', '2023-01-02', '1995-09-03', '2023-01-02', 'default2', 'default2'), (1, NULL, '1995-09-03', '1995-09-05', NULL, NULL, 'default2'), (249, 'Abnormal', '2023-01-01', '1995-09-03', '2023-01-01', 'default1', 'default1'), (250, 'default1', NULL, NULL, NULL, NULL, 'Not Normal');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (249, '2023-01-02', 251, 1, 1, NULL, 2927463.0, 250.0, 2927463.0, 1, 2927465.0, 1.0, 2927463, 0, 2927465, 2927464, 2927464.0, 0.0, 1.0, NULL, 0, NULL, 2927464, 1.0, 2927465, 250, 2927464, 'default1', 251, 251, 250, 'Normal', 'default1', 'Not Normal', 250, 1, '1995-09-04', NULL, 'default2', 'Abnormal', 'Normal', 'Abnormal', 'Not Normal', 2927464), (250, '1995-09-03', 2927465, 2927465, 1, 251, 2927463.0, 251.0, 249.0, 1, NULL, 249.0, 250, 0, 249, 1, 2927465.0, 2927463.0, 250.0, 249.0, 2927463, 2927464.0, 2927463, 2927465.0, 2927463, 1, 2927463, '1995-09-04', 2927464, 2927465, NULL, 'Abnormal', NULL, 'Abnormal', 2927464, 2927463, 'Abnormal', 'Abnormal', '1995-09-04', 'default1', 'Normal', '1995-09-04', 'default2', 2927465), (2927465, '1995-09-03', 2927465, 0, NULL, 1, 2927464.0, 250.0, 251.0, NULL, 0.0, 1.0, 2927465, 250, 249, 251, 2927465.0, 0.0, 251.0, 251.0, NULL, 250.0, 249, 2927463.0, 251, 0, 249, 'Normal', NULL, 0, 2927464, 'default1', 'default2', 'Not Normal', 2927464, 0, 'Abnormal', 'default2', 'Normal', '1995-09-04', 'Normal', '1995-09-04', NULL, 250), (2927464, '1995-09-04', 2927464, 2927463, 2927464, NULL, 2927465.0, 1.0, 1.0, 0, 2927464.0, 1.0, 2927464, 2927464, 251, 2927463, 249.0, 250.0, 2927464.0, 1.0, 2927464, 2927464.0, 1, 0.0, 250, 2927464, 250, 'Normal', 2927463, 0, 250, 'default1', 'default2', '1995-09-04', 0, 1, 'Normal', 'Not Normal', 'Abnormal', 'default2', 'default2', 'Normal', 'Not Normal', 249), (249, '1995-09-05', 1, NULL, 2927465, 2927465, 250.0, 250.0, 2927464.0, 2927465, NULL, 249.0, 1, 1, 0, 2927463, 2927464.0, 0.0, 2927464.0, 249.0, 2927464, 2927463.0, 249, 2927463.0, 1, 249, 2927464, 'Not Normal', 249, 2927464, 251, NULL, 'default1', 'default2', 2927465, 2927463, 'Normal', NULL, '1995-09-04', 'Normal', 'Abnormal', '1995-09-04', 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN "T-CHO" < 250 THEN 'Normal' ELSE 'Abnormal' END FROM Laboratory WHERE ID = 2927464 AND Date = '1995-09-04';

/*
Gold Result:
('Abnormal',)
*/

-- Prediction Query
SELECT CASE WHEN "Laboratory"."T-CHO" < 250 THEN 'Normal' ELSE 'Not Normal' END AS tcho_status FROM "Laboratory" WHERE "Laboratory"."ID" = 2927464 AND "Laboratory"."Date" = '1995-09-04';

/*
Prediction Result:
('Not Normal',)
*/