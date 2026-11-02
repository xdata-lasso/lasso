-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, NULL, '2023-01-02', '2023-01-01', NULL, NULL, '%Y'), (59, NULL, NULL, '2023-01-02', '2023-01-01', 'default1', 'default1'), (61, NULL, NULL, '1994-10-27', NULL, NULL, '%Y'), (60, NULL, '2023-01-02', '2023-01-01', '2023-01-02', NULL, NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (59, '2023-01-02', NULL, 1, 0, 0, 60.0, 60.0, 0.0, 61, 61.0, 0.0, 59, NULL, 59, 0, 61.0, 61.0, 60.0, 60.0, 61, 1.0, 1, 59.0, NULL, 61, 1, NULL, NULL, 61, 60, '1994', 'default2', '1994', 0, 61, 'default2', 'default1', NULL, 'default1', '1994', 'default2', 'default2', NULL), (60, '1994-10-27', 59, 61, 1, NULL, 1.0, 60.0, 1.0, 0, 60.0, 1.0, 60, 60, NULL, 1, 0.0, 60.0, 1.0, 0.0, 0, 61.0, 1, NULL, 1, 0, 59, '1994', 59, 0, 59, 'default1', '%Y', '1994', 0, 60, 'default2', 'default2', 'default2', 'default2', '%Y', 'default2', NULL, NULL), (0, '1994-10-27', 59, NULL, NULL, 1, 1.0, 60.0, 60.0, 0, 60.0, 61.0, NULL, NULL, 60, 61, 60.0, 0.0, NULL, 1.0, 60, 1.0, 1, NULL, 60, 60, 1, NULL, 0, NULL, 61, NULL, '%Y', 'default1', 59, 60, '1994', 'default2', NULL, 'default1', NULL, 'default2', '%Y', 61), (61, '2023-01-02', NULL, NULL, 61, 59, 60.0, NULL, 59.0, 1, NULL, NULL, 0, NULL, 1, 60, 61.0, 60.0, 59.0, 0.0, 61, 61.0, 0, 1.0, 61, 61, 61, '1994', 59, NULL, NULL, '%Y', NULL, '1994', 1, 59, NULL, '%Y', '%Y', NULL, '%Y', 'default1', '1994', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.SEX, T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GOT < 60 AND STRFTIME('%Y', T2.Date) = '1994';

/*
Gold Result:
(None, '2023-01-02')
*/

-- Prediction Query
SELECT patient.sex, patient.birthday FROM patient INNER JOIN laboratory ON patient.id = laboratory.id WHERE STRFTIME('%Y', laboratory.date) = '1994' AND laboratory.got < 60;

/*
Prediction Result:
(None, '2023-01-02')
(None, '2023-01-02')
*/