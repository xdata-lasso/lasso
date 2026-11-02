-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, 'No', '1982-10-27', NULL, '2023-01-01', 'Yes', '1982'), (1, 'default1', NULL, NULL, NULL, '1982', 'default2'), (2, 'default1', NULL, '2023-01-02', '2023-01-01', '%Y', 'No');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (2, '2023-01-02', 1, NULL, NULL, 0, 1.0, 2.5, 1.0, NULL, 4.5, 2.5, NULL, 1, 0, NULL, 3.5, NULL, 4.5, 4.5, 1, 6.5, 1, 0.0, 1, 1, 0, 'default1', NULL, 1, 0, 'default2', 'normal', '%Y', NULL, 0, 'abnormal', 'normal', 'normal', 'default1', '%Y', NULL, 'normal', 0), (0, '2023-01-02', 1, 0, 1, 0, 5.5, 2.5, 5.5, NULL, 6.5, 0.0, 0, NULL, NULL, 0, NULL, 3.5, 4.5, 2.5, 1, 0.0, NULL, 2.5, 0, 0, NULL, 'Yes', NULL, NULL, 1, 'abnormal', 'Yes', NULL, 1, 0, 'default1', 'normal', '%Y', 'No', '%Y', 'No', 'normal', NULL), (0, '1982-10-27', NULL, 0, 1, 1, 6.5, 5.5, NULL, 1, 1.0, 6.5, 1, 0, NULL, 0, 2.5, 2.5, 3.5, NULL, 0, 5.5, 0, 1.0, NULL, 1, 1, 'No', NULL, 0, 1, 'abnormal', 'abnormal', 'normal', 0, 1, NULL, 'default2', 'default1', 'No', 'abnormal', 'default1', 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN T2.ALB >= 3.5 AND T2.ALB <= 5.5 THEN 'normal' ELSE 'abnormal' END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T1.Birthday) = '1982';

/*
Gold Result:
('abnormal',)
('normal',)
*/

-- Prediction Query
SELECT CASE WHEN T2.ALB BETWEEN 3.5 AND 5.5 THEN 'Yes' ELSE 'No' END AS within_normal_range FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T1.Birthday) = '1982';

/*
Prediction Result:
('No',)
('Yes',)
*/