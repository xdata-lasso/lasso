-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, 'abnormal', '1982-10-27', NULL, '2023-01-02', 'Normal', 'default2'), (1, 'Abnormal', NULL, '2023-01-02', '2023-01-02', 'Normal', 'Abnormal'), (2, 'normal', '2023-01-01', '2023-01-01', '2023-01-02', NULL, 'default2'), (3, 'default1', NULL, '2023-01-01', NULL, 'abnormal', 'Normal');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (0, '1982-10-27', 0, 1, 1, NULL, 2.5, 4.5, 4.5, 0, 1.0, 1.0, 0, 1, NULL, 1, 1.0, 4.5, 6.5, 2.5, 0, NULL, NULL, 2.5, NULL, 1, NULL, 'default2', 0, NULL, NULL, '%Y', 'Normal', 'Normal', 1, 0, '1982', 'normal', 'default2', 'default1', 'normal', '%Y', 'Abnormal', 1), (3, '2023-01-02', 1, 1, 1, NULL, 5.5, 2.5, 3.5, NULL, 6.5, 2.5, 1, 0, 0, NULL, 5.5, 6.5, NULL, 1.0, 0, 3.5, 1, 3.5, 1, NULL, 1, NULL, 1, 0, 1, 'normal', 'abnormal', 'Abnormal', 1, NULL, 'Normal', 'abnormal', '1982', 'normal', 'abnormal', 'Abnormal', 'default2', NULL), (3, '1982-10-27', 1, NULL, 1, 0, 5.5, 5.5, 5.5, NULL, 6.5, 2.5, 1, 1, 1, 0, 4.5, 2.5, 0.0, 3.5, 1, 4.5, NULL, 5.5, 1, 1, 1, 'default1', NULL, 1, NULL, 'abnormal', NULL, 'normal', 1, NULL, 'Normal', '%Y', 'default1', '%Y', 'Normal', '1982', 'Abnormal', 1), (1, '1982-10-27', NULL, NULL, 1, 1, 5.5, 6.5, 5.5, 0, 2.5, 5.5, 1, 0, 1, 1, 3.5, 6.5, 3.5, 0.0, 1, NULL, NULL, 1.0, NULL, 0, 0, 'Abnormal', 1, 0, 1, '1982', NULL, 'normal', 0, 0, '%Y', 'default1', 'abnormal', NULL, 'Abnormal', 'default2', 'Abnormal', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN T2.ALB >= 3.5 AND T2.ALB <= 5.5 THEN 'normal' ELSE 'abnormal' END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T1.Birthday) = '1982';

/*
Gold Result:
('normal',)
*/

-- Prediction Query
SELECT T1.ID, CASE WHEN T2.ALB BETWEEN 3.5 AND 5.5 THEN 'Normal' ELSE 'Abnormal' END AS Albumin_Level FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T1.Birthday) = '1982';

/*
Prediction Result:
(0, 'Normal')
*/