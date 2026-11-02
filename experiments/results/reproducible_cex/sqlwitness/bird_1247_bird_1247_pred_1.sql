-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (450, 'M', '2023-01-01', '2023-01-01', '2023-01-01', 'default1', 'M'), (0, NULL, NULL, NULL, '2023-01-02', NULL, 'M'), (449, 'M', NULL, NULL, NULL, 'M', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (450, '2023-01-02', 151, 150, 150, 450, NULL, 4.5, 150.0, 449, 2.5, 2.5, 1, 149, 1, 451, 10.0, 8.0, 151.0, 2.5, NULL, 2.5, 449, 1.0, 450, 151, 451, 'default1', 450, 149, 1, 'default1', 'M', 'default1', 150, 151, 'default2', NULL, 'default2', 'M', 'default1', 'default2', 'default1', 0), (0, '2023-01-02', NULL, 451, 151, 451, 151.0, 10.0, 4.5, 0, 150.0, 3.5, 1, 0, 0, 0, 1.0, 149.0, 3.5, 1.0, 151, 10.0, NULL, 9.0, 450, 151, 449, 'M', 449, 450, NULL, NULL, 'default1', 'default1', 151, 1, 'default1', 'default2', NULL, 'M', NULL, 'default2', NULL, 449), (450, '2023-01-01', 449, 449, 449, NULL, 450.0, 151.0, 0.0, 150, 451.0, 150.0, 450, NULL, 1, 450, 8.0, 149.0, 451.0, NULL, 151, 150.0, 150, 151.0, 149, 1, NULL, 'default2', 451, 150, NULL, 'default2', 'M', NULL, 449, 0, NULL, 'default1', NULL, 'M', 'M', 'default2', 'M', 451);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.FG <= 150 OR T2.FG >= 450 AND T2.WBC > 3.5 AND T2.WBC < 9.0 AND T1.SEX = 'M';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT Patient.ID) AS MalePatientsWithAbnormalFibrinogen FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.SEX = 'M' AND Laboratory.WBC > 3.5 AND Laboratory.WBC < 9.0 AND (Laboratory.FG <= 150 OR Laboratory.FG >= 450);

/*
Prediction Result:
(0,)
*/