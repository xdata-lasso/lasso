-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, '%Y', '1999-10-27', '2023-01-02', '1991-11-01', '1991-10-31', '1991-10-31'), (1, 'default1', '1991-10-30', '1991-09-30', '2023-01-01', 'default1', '1991-10-01'), (2, '%Y', '2023-01-02', '2023-01-02', '2023-01-02', '1999', '1991-10-31'), (3, '%Y', '2023-01-01', '2023-01-02', '2023-01-02', 'default1', 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (1, '1991-10-29', 0, 1, NULL, 1, NULL, NULL, NULL, 1, 0.0, NULL, 0, 1, 0, 0, NULL, 1.0, 1.0, NULL, NULL, NULL, 1, 0.0, 0, 0, 1, '1991-10-31', NULL, 1, 0, '1991-10-30', 'default2', '1999', 1, NULL, NULL, 'default1', 'default2', '1991-10-31', '1991-10-30', '1991-10-30', 'default2', 0), (0, '1999-10-27', 0, 1, 0, NULL, NULL, 1.0, 0.0, NULL, 1.0, NULL, 0, 1, NULL, 1, 0.0, 1.0, 1.0, 1.0, NULL, 0.0, 0, NULL, 0, 0, 0, '1999', NULL, 0, 0, '1991-10-01', NULL, 'default2', NULL, NULL, '1991-10-31', '1999', '1999', '1991-10-30', '1991-10-31', '1991-10-30', '1991-10-01', 0), (1, '1991-10-02', NULL, NULL, NULL, NULL, 1.0, 1.0, 1.0, NULL, 0.0, 1.0, NULL, NULL, 0, 1, 1.0, 1.0, 0.0, NULL, NULL, 1.0, NULL, NULL, 1, NULL, NULL, '1991-10-30', 1, NULL, 1, '1991-10-01', '1991-10-01', '1991-10-30', 0, 1, '1991-10-01', '%Y', NULL, NULL, '1999', '%Y', '%Y', 1), (2, '1991-09-30', 0, NULL, 1, NULL, 0.0, 1.0, 0.0, 0, NULL, 0.0, NULL, 1, 1, NULL, NULL, 1.0, 0.0, 1.0, NULL, 1.0, NULL, 0.0, 1, NULL, NULL, '%Y', 1, 0, 1, '%Y', '%Y', 'default1', 0, 0, '%Y', '1991-10-01', '1991-10-01', 'default1', '1991-10-01', 'default2', '%Y', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG('1999' - STRFTIME('%Y', T2.Birthday)) FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE T1.Date BETWEEN '1991-10-01' AND '1991-10-30';

/*
Gold Result:
(8.0,)
*/

-- Prediction Query
SELECT AVG(CAST(STRFTIME('%Y', T2.Date) AS INTEGER) - STRFTIME('%Y', T1.Birthday)) AS Average_Age FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.Date BETWEEN '1991-10-01' AND '1991-10-31';

/*
Prediction Result:
(0.0,)
*/