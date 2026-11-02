-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (450, NULL, NULL, '2023-01-02', '2023-01-02', 'M', NULL), (451, NULL, '2023-01-01', NULL, NULL, 'default2', 'default2'), (449, 'default2', '2023-01-01', '2023-01-01', '2023-01-02', 'M', 'default2'), (150, 'default1', '2023-01-01', '2023-01-01', '2023-01-02', 'default2', 'M'), (149, NULL, '2023-01-02', NULL, '2023-01-02', 'default1', 'M');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (449, '2023-01-01', 149, 450, 450, 450, 149.0, 0.0, 150.0, 449, 450.0, 449.0, 149, 450, 149, NULL, 451.0, 149.0, 149.0, 149.0, 151, NULL, 151, 151.0, 449, 150, 151, 'M', NULL, 150, 450, 'M', 'default1', 'M', 0, 450, NULL, 'default1', 'default2', NULL, 'default2', 'M', 'default1', 451), (451, '2023-01-02', 451, 0, 149, 0, 2.5, 151.0, 151.0, 449, 449.0, 3.5, 150, 150, 1, 450, 0.0, 151.0, 150.0, 151.0, 151, 1.0, 451, 8.0, 150, 1, 151, 'M', 1, 0, 1, 'default2', 'default1', NULL, 150, NULL, 'default2', 'default1', 'default1', 'default2', 'M', 'M', NULL, 450), (450, '2023-01-01', 451, 151, 450, NULL, 2.5, 0.0, 450.0, 0, 451.0, 0.0, 450, 451, 149, 449, 151.0, 8.0, 450.0, 10.0, 449, 9.0, 151, 151.0, NULL, 150, 449, 'default1', 450, 0, 150, NULL, 'default2', 'default2', 450, NULL, 'default1', 'M', 'default1', 'M', 'M', 'M', NULL, 450);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.FG <= 150 OR T2.FG >= 450 AND T2.WBC > 3.5 AND T2.WBC < 9.0 AND T1.SEX = 'M';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.SEX = 'M' AND T2.WBC > 3.5 AND T2.WBC < 9.0 AND (T2.FG < 150 OR T2.FG >= 450);

/*
Prediction Result:
(0,)
*/