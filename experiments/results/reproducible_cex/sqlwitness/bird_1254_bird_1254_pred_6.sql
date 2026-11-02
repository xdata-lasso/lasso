-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, 'default2', '2023-01-01', '1990-01-01', '1990-01-01', '1990-01-01', 'default2'), (1, 'default1', '1989-12-31', NULL, '2023-01-02', 'default1', 'default2'), (499, '1990-01-01', '1990-01-01', NULL, '1990-01-01', '1990-01-01', 'default2'), (80, 'default1', '2023-01-01', '1990-01-02', '1989-12-31', 'default2', '1990-01-01');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (0, '1990-01-01', 1, 80, 0, 501, 81.0, 500.0, 1.0, 80, 79.0, 81.0, 501, 79, 1, NULL, 80.0, 81.0, 81.0, 79.0, 1, 500.0, 81, 500.0, NULL, 0, 499, NULL, 79, 1, 500, 'default1', NULL, NULL, 1, 79, NULL, 'default1', 'default2', 'default1', NULL, 'default2', '1990-01-01', 80), (1, '2023-01-01', 499, 80, 81, 500, NULL, 0.0, 80.0, 1, 80.0, 0.0, NULL, 81, 81, 500, 81.0, 1.0, NULL, 79.0, 499, 499.0, 500, 79.0, 1, 81, 80, '1990-01-01', 501, NULL, 80, 'default1', '1990-01-01', '1990-01-01', 80, 0, 'default2', '1990-01-01', NULL, 'default2', '1990-01-01', NULL, '1990-01-01', 500), (0, '2023-01-02', 499, 1, 500, 0, 1.0, NULL, 499.0, 0, 499.0, 0.0, 1, 81, 500, NULL, 79.0, 79.0, 80.0, 81.0, 1, 500.0, 1, 81.0, 79, 81, NULL, 'default2', 81, 81, 0, NULL, 'default2', 'default2', 0, NULL, '1990-01-01', 'default1', 'default2', 'default2', 'default1', '1990-01-01', 'default2', 81);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.IGA BETWEEN 80 AND 500 AND T1."First Date" > '1990-01-01';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) AS result FROM Patient AS P INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE P."First Date" >= '1990-01-01' AND L."IGA" > 80 AND L."IGA" < 500;

/*
Prediction Result:
(1,)
*/