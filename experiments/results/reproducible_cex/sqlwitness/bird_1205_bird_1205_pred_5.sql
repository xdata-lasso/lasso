-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, 'default2', '2023-01-02', NULL, '2023-01-01', 'F', 'no'), (7, 'no', '2023-01-01', '2023-01-02', '2023-01-02', 'no', 'yes'), (9, 'default2', '2023-01-02', '2023-01-02', '2023-01-01', 'yes', 'default2'), (57266, 'default2', '2023-01-02', NULL, NULL, 'no', 'no');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (7, '2023-01-02', 1, 8, 7, 57265, NULL, 5.5, 9.0, 9, 5.5, NULL, 9, 57266, 7, 7, 57265.0, 1.0, 6.5, 7.5, 57265, 8.0, 57265, 0.0, 9, 57267, 1, 'yes', 1, 1, 57265, NULL, 'F', 'yes', 57266, 8, 'yes', 'F', NULL, 'F', 'M', 'F', 'default1', 8), (0, '2023-01-01', 7, 57265, NULL, 7, 7.0, NULL, 57266.0, 57265, 57267.0, 5.5, 8, 0, 8, 7, 6.5, 1.0, NULL, 57267.0, NULL, 57266.0, 1, 8.0, NULL, 9, 57266, 'default1', 8, 57267, 7, 'M', 'default1', 'default1', 8, 57265, 'F', 'default2', 'no', 'M', 'yes', NULL, NULL, 0), (57266, '2023-01-02', 57267, 1, 0, 0, 6.5, 6.5, 5.5, 1, 57265.0, 57267.0, 0, 0, 57266, 8, 7.0, 1.0, 0.0, 6.5, 9, 7.5, 0, 7.5, 7, NULL, 57265, 'default2', 7, 57267, 57266, 'M', 'no', 'M', 57267, 57265, 'yes', 'no', 'default2', 'F', 'F', 'F', 'default1', 57266), (9, '2023-01-02', 1, 8, 57267, NULL, 9.0, 9.0, 5.5, 1, 7.0, 1.0, 57266, 57265, 8, 9, 57267.0, 8.0, 57267.0, 0.0, 9, 7.5, 57267, NULL, 1, 57267, 1, NULL, 7, 9, 9, 'yes', NULL, 'default1', 57265, NULL, 'M', 'M', 'yes', 'F', 'F', 'no', NULL, 57267);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN (T1.SEX = 'F' AND T2.UA > 6.5) OR (T1.SEX = 'M' AND T2.UA < 8.0) THEN TRUE ELSE FALSE END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.ID = 57266;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT CASE WHEN T1.SEX = 'M' THEN CASE WHEN T2.UA > 8 THEN 'yes' ELSE 'no' END ELSE CASE WHEN T2.UA > 6.5 THEN 'yes' ELSE 'no' END END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.ID = 57266;

/*
Prediction Result:
('no',)
*/