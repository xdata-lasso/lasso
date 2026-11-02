-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (449, 'M', NULL, '2023-01-02', NULL, 'default1', NULL), (451, NULL, NULL, '2023-01-01', '2023-01-02', 'M', 'default2'), (0, 'default2', '2023-01-02', NULL, '2023-01-02', 'default2', NULL), (150, 'default2', NULL, '2023-01-02', '2023-01-01', 'default2', 'M'), (450, 'default2', '2023-01-02', '2023-01-01', '2023-01-02', 'default1', 'default2');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (449, '2023-01-01', 450, 451, 151, 450, 0.0, 0.0, 150.0, 451, 4.5, 2.5, 149, 151, NULL, 449, 10.0, 4.5, 450.0, 0.0, NULL, 1.0, 451, 2.5, 450, 150, 151, NULL, 0, 449, 149, 'M', NULL, 'default1', 150, 149, 'default2', 'default1', 'M', NULL, NULL, 'default1', 'default1', 151), (451, '2023-01-02', 450, 151, 0, 0, 449.0, 8.0, 451.0, 449, 9.0, 149.0, 449, 451, 151, 451, 3.5, 0.0, 151.0, 1.0, 150, NULL, NULL, 4.5, 451, 151, 1, 'M', 1, 151, NULL, NULL, NULL, 'M', 1, 0, NULL, 'M', 'default1', 'default2', 'default2', NULL, NULL, 150), (451, '2023-01-01', 151, 151, 150, 0, 9.0, 9.0, 0.0, 150, 3.5, 3.5, 151, 451, 0, 149, 9.0, 449.0, 10.0, 8.0, 149, 3.5, 1, 450.0, 451, NULL, 0, 'M', 449, 151, 450, 'M', 'default1', 'default2', 151, 151, NULL, 'default2', 'M', 'default1', 'default1', 'default2', 'default1', 1), (150, '2023-01-01', 149, 151, 0, 0, 3.5, NULL, 0.0, NULL, 449.0, 10.0, 149, 1, NULL, 149, 0.0, 9.0, 3.5, 450.0, 150, 9.0, NULL, 150.0, 151, 449, 450, NULL, 1, 150, 451, 'default2', 'default1', 'default2', 449, 449, NULL, 'default2', NULL, 'M', NULL, 'default1', 'default1', 151), (0, '2023-01-01', 150, 451, NULL, 0, 0.0, 450.0, 150.0, 451, 8.0, 8.0, 451, 0, 1, 450, 451.0, NULL, 1.0, 1.0, 450, 8.0, 451, 150.0, 150, 449, 151, 'default1', 450, 1, 151, 'M', 'M', 'default2', 450, 149, 'M', 'default2', 'default2', 'default2', 'M', 'M', 'M', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.FG <= 150 OR T2.FG >= 450 AND T2.WBC > 3.5 AND T2.WBC < 9.0 AND T1.SEX = 'M';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT p.ID) FROM Patient AS p INNER JOIN Laboratory AS l ON p.ID = l.ID WHERE p.SEX = 'M' AND l.WBC > 3.5 AND l.WBC < 9.0 AND (l.FG <= 150 OR l.FG >= 450);

/*
Prediction Result:
(0,)
*/