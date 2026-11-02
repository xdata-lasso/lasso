-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (2927463, 'yes', '1995-09-03', '2023-01-01', '1995-09-05', 'default1', 'yes'), (249, 'no', '2023-01-02', '2023-01-02', '2023-01-01', 'yes', 'default2'), (2927464, 'default1', '2023-01-01', '2023-01-02', '1995-09-03', '1995-09-04', 'Abnormal');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (2927464, '1995-09-04', 2927463, 251, 1, 2927465, 2927464.0, 1.0, 250.0, 249, 0.0, 250.0, 249, NULL, 2927464, 0, 2927464.0, 249.0, 249.0, 1.0, 2927464, 250.0, 2927465, 251.0, 251, 249, 2927463, 'Abnormal', 2927464, 250, 250, 'no', 'Normal', 'default2', 249, 2927465, NULL, '1995-09-04', 'no', 'Normal', 'Abnormal', 'Abnormal', 'default1', 250), (249, '2023-01-01', 251, 249, 1, 0, 0.0, 250.0, 2927463.0, 1, 0.0, 2927464.0, 250, 0, 251, 0, NULL, 250.0, 249.0, 0.0, 249, NULL, 2927465, NULL, 251, 1, 2927464, 'Abnormal', 1, 249, 0, 'Normal', 'default1', 'yes', 249, 0, '1995-09-04', '1995-09-04', 'default2', '1995-09-04', '1995-09-04', 'Abnormal', 'Normal', 2927464), (2927463, '1995-09-03', 249, 2927465, 249, 1, 249.0, 250.0, 2927463.0, 251, 250.0, NULL, 0, 0, 2927465, 2927464, 2927464.0, 249.0, 250.0, 251.0, 2927464, 251.0, 1, 2927464.0, 251, 250, 2927464, 'Abnormal', 1, 251, 249, '1995-09-04', 'yes', 'yes', NULL, 1, NULL, 'Normal', 'yes', 'default2', 'Normal', 'no', 'Abnormal', 251);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN "T-CHO" < 250 THEN 'Normal' ELSE 'Abnormal' END FROM Laboratory WHERE ID = 2927464 AND Date = '1995-09-04';

/*
Gold Result:
('Normal',)
*/

-- Prediction Query
SELECT CASE WHEN T1."T-CHO" < 250 THEN 'yes' ELSE 'no' END FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T2.ID = 2927464 AND T1.Date = '1995-09-04';

/*
Prediction Result:
('yes',)
*/