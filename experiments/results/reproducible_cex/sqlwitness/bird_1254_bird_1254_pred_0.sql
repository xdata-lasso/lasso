-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (81, '%Y', '1989-12-31', '1989-12-31', '1990-01-01', 'default1', 'default1'), (500, '1990', '1990-01-02', '2023-01-01', NULL, NULL, '%Y'), (499, '1990-01-01', '1990-10-27', '2023-01-01', '2023-01-01', '1990-01-01', '%Y'), (0, '%Y', '2023-01-01', '2023-01-02', NULL, '1990', '1990-01-01'), (80, '1990', '1990-01-02', '1990-01-02', '1990-10-27', '1990-01-01', 'default1'), (79, NULL, '1989-12-31', '1990-01-02', '1990-01-01', '1990', '1990');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (500, '1989-12-31', 499, NULL, 80, 501, 81.0, 501.0, 0.0, 500, 500.0, 1.0, NULL, 80, NULL, NULL, 0.0, 0.0, 500.0, 501.0, 81, 500.0, 79, 79.0, 501, NULL, 0, 'default2', 1, 1, NULL, NULL, '%Y', 'default1', NULL, 500, 'default2', NULL, 'default2', 'default1', '%Y', NULL, 'default1', 501), (0, '2023-01-01', 81, NULL, 80, 501, NULL, 0.0, NULL, 79, 81.0, 81.0, 81, NULL, 81, NULL, 79.0, 501.0, 80.0, 81.0, 81, 499.0, 0, NULL, 499, 81, 81, '%Y', NULL, 79, 0, '1990-01-01', '1990', NULL, 81, 1, 'default1', '1990', '1990', '%Y', '1990', 'default1', NULL, 500), (0, '2023-01-02', 501, 501, 500, 499, 0.0, 499.0, 501.0, 501, 1.0, 80.0, 79, 1, 501, 499, 80.0, NULL, 499.0, 499.0, 0, 80.0, 501, 79.0, 500, 0, 79, 'default2', 1, 0, 80, 'default2', 'default2', 'default1', 499, 500, 'default2', 'default1', '1990', 'default2', '1990', '1990', '%Y', 1), (499, '1990-01-02', 80, 80, 500, NULL, 80.0, 79.0, 81.0, 81, 1.0, 0.0, 79, 0, 501, NULL, 80.0, 79.0, 499.0, 500.0, 80, 0.0, 79, 80.0, 79, 499, 81, '1990-01-01', 0, 500, 501, 'default2', 'default2', '1990', 79, 80, '1990-01-01', '1990-01-01', 'default2', 'default2', '%Y', 'default1', '1990-01-01', 79), (499, '2023-01-01', 501, 500, 501, 499, 501.0, 0.0, NULL, 500, 500.0, NULL, 501, NULL, 500, 501, 81.0, 80.0, 501.0, 501.0, 79, NULL, 501, 501.0, 1, 0, 80, 'default2', 81, 81, 81, '1990-01-01', '1990-01-01', '1990-01-01', 79, NULL, 'default1', '%Y', 'default2', '1990-01-01', NULL, 'default1', NULL, 501);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.IGA BETWEEN 80 AND 500 AND T1."First Date" > '1990-01-01';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.IGA BETWEEN 80 AND 500 AND STRFTIME('%Y', T1."First Date") >= '1990';

/*
Prediction Result:
(1,)
*/