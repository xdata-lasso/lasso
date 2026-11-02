-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'Normal', '2023-01-02', '2023-01-02', '2023-01-01', NULL, 'abnormal'), (0, 'Normal', '2023-01-01', NULL, NULL, 'normal', NULL), (2, 'Normal', '1982-10-27', '2023-01-01', NULL, 'Abnormal', '%Y'), (3, 'Normal', '1982-10-27', '1982-10-27', '2023-01-01', 'Normal', '%Y'), (4, 'Abnormal', '1982-10-27', NULL, '2023-01-01', '%Y', 'abnormal');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (0, '2023-01-01', 1, NULL, NULL, NULL, 6.5, 4.5, NULL, NULL, 5.5, 3.5, 0, 1, NULL, 1, 3.5, 4.5, 1.0, 4.5, NULL, 1.0, 1, 3.5, 0, 0, 0, 'default1', 1, 0, 1, 'default2', '1982', '1982', NULL, 0, 'normal', NULL, 'Abnormal', 'default1', NULL, 'Abnormal', 'normal', 0), (3, '1982-10-27', 1, 1, NULL, 0, 0.0, 6.5, NULL, NULL, NULL, 6.5, NULL, 1, 1, NULL, 0.0, 1.0, 1.0, 6.5, 0, 4.5, 1, 1.0, 1, NULL, 1, 'Abnormal', 1, 1, NULL, 'Abnormal', 'Normal', 'Abnormal', NULL, NULL, 'default1', 'abnormal', '1982', '1982', 'Abnormal', 'default1', 'default1', 1), (3, '2023-01-02', 1, NULL, 0, 0, 5.5, 6.5, 4.5, 1, 6.5, 0.0, 0, 1, NULL, NULL, NULL, NULL, NULL, 3.5, 0, 1.0, NULL, 5.5, 0, NULL, NULL, 'Abnormal', NULL, 1, 0, 'default2', NULL, '%Y', 0, NULL, 'Abnormal', NULL, '%Y', 'default1', '1982', NULL, 'normal', 1), (4, '2023-01-01', 0, 1, 1, 1, NULL, 2.5, 2.5, 1, NULL, 2.5, 1, NULL, NULL, NULL, 6.5, 3.5, 6.5, NULL, NULL, 6.5, 0, 4.5, NULL, NULL, 1, NULL, 0, NULL, 0, '1982', 'abnormal', NULL, 0, NULL, 'Abnormal', '1982', 'normal', '1982', 'Abnormal', NULL, 'abnormal', 1), (4, '2023-01-02', NULL, 1, 1, NULL, 4.5, 6.5, 4.5, 1, 1.0, 1.0, 0, NULL, 1, NULL, 6.5, 2.5, 0.0, 5.5, NULL, NULL, 0, 5.5, 1, 0, NULL, NULL, 1, 0, NULL, 'Normal', 'default1', 'abnormal', 0, 0, 'normal', 'Normal', 'default2', NULL, 'abnormal', 'abnormal', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN T2.ALB >= 3.5 AND T2.ALB <= 5.5 THEN 'normal' ELSE 'abnormal' END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T1.Birthday) = '1982';

/*
Gold Result:
('abnormal',)
('abnormal',)
('abnormal',)
('abnormal',)
*/

-- Prediction Query
SELECT p.ID, CASE WHEN l.ALB BETWEEN 3.5 AND 5.5 THEN 'Normal' ELSE 'Abnormal' END AS Albumin_Status FROM Patient AS p JOIN Laboratory AS l ON p.ID = l.ID WHERE STRFTIME('%Y', p.Birthday) = '1982';

/*
Prediction Result:
(3, 'Abnormal')
(3, 'Abnormal')
(4, 'Abnormal')
(4, 'Abnormal')
*/