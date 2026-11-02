-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (5, NULL, '1997-10-27', '1997-10-27', '2023-01-02', '1997', 'default1'), (1, 'default2', '1997-10-27', '2023-01-02', '1997-10-27', '%Y', '1997'), (6, 'default1', '1997-10-27', '2023-01-01', '1997-10-27', '%Y', 'default2'), (7, '%Y', '2023-01-02', '1997-10-27', '2023-01-02', 'default1', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (5, '1997-10-27', NULL, 6, NULL, NULL, 7.0, 6.0, 7.0, 7, 5.0, 7.0, 1, 6, 0, NULL, 6.0, 5.0, 8.5, NULL, 0, 7.5, 5, NULL, 0, NULL, 1, NULL, NULL, 6, 1, '1997', 'default1', '%Y', 7, 5, '%Y', '1997', 'default1', 'default1', 'default1', 'default1', 'default1', 1), (6, '2023-01-01', 6, 0, 0, 0, 6.0, 0.0, 7.5, 6, 0.0, 8.5, NULL, 5, 7, NULL, 7.0, 6.0, NULL, 6.0, 5, 1.0, NULL, 7.0, 1, 1, NULL, 'default1', 1, 0, NULL, 'default1', 'default1', 'default1', 5, 5, 'default1', 'default1', '%Y', '1997', 'default2', NULL, '%Y', 5), (1, '1997-10-27', 6, 0, NULL, 5, 0.0, 5.0, 6.0, NULL, NULL, 9.5, 6, 1, 5, NULL, 8.5, 6.0, 8.5, 5.0, 7, NULL, NULL, 9.5, 5, 6, 1, '1997', 6, 7, 7, '1997', 'default1', '%Y', 5, 0, '1997', 'default2', 'default1', '1997', '%Y', NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(ID) FROM Laboratory WHERE ALB <= 6.0 OR ALB >= 8.5 AND STRFTIME('%Y', Date) = '1997';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT ID) FROM Laboratory WHERE STRFTIME('%Y', Date) = '1997' AND (TP <= 6 OR TP >= 8.5);

/*
Prediction Result:
(1,)
*/