-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'F', '2023-01-01', NULL, '2023-01-02', NULL, 'default2'), (57266, 'F', '2023-01-01', NULL, '2023-01-01', 'default1', 'default2'), (0, 'M', '2023-01-02', '2023-01-01', '2023-01-02', 'NO', 'M'), (57265, 'default1', '2023-01-02', NULL, '2023-01-02', 'default1', 'default2'), (57267, 'default1', '2023-01-02', NULL, '2023-01-01', 'NO', 'M'), (2, 'YES', NULL, '2023-01-01', '2023-01-01', 'YES', 'YES');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (57266, '2023-01-02', NULL, 1, 57267, NULL, NULL, 9.0, 6.5, 57265, 6.5, 1.0, NULL, 1, 57266, 1, 7.0, 9.0, 57267.0, 8.0, 57265, NULL, NULL, 57266.0, 0, 0, 57265, 'default1', 57266, NULL, 0, 'YES', 'YES', 'F', 57266, NULL, 'YES', 'YES', 'NO', 'YES', 'F', 'M', 'default1', NULL), (1, '2023-01-02', 0, NULL, 0, 1, 8.0, 0.0, 57265.0, 57267, 5.5, 57267.0, 57266, 57267, 0, 57265, 7.5, 57267.0, 8.0, 57267.0, 57265, 7.5, NULL, 7.5, 57266, 57265, 57265, 'default1', 57266, 0, 57266, NULL, 'M', 'NO', 57266, NULL, 'default2', 'default2', 'M', 'YES', 'default1', 'NO', 'YES', 0), (57265, '2023-01-01', 57266, 1, 1, 57265, 6.5, 7.0, 8.0, 57267, 7.5, 1.0, 0, 57267, 57265, 57265, 1.0, 57266.0, 57265.0, 7.0, 57265, 1.0, 57266, 57265.0, 57265, 1, 0, 'default2', NULL, 57267, 0, 'NO', NULL, NULL, 57267, 57265, 'default2', 'NO', 'M', 'F', 'default1', 'F', 'default2', 57265), (1, '2023-01-01', 57267, NULL, 57267, 57265, 9.0, 57266.0, 57266.0, 57267, 57266.0, 0.0, 0, 1, 1, 57265, 57266.0, 6.5, 8.0, 9.0, 1, 9.0, 57267, 7.0, NULL, 57267, NULL, 'default1', 0, 57265, 57266, NULL, 'YES', 'M', 1, 1, 'NO', 'M', 'default1', 'default1', 'NO', 'M', 'NO', 57267);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN (T1.SEX = 'F' AND T2.UA > 6.5) OR (T1.SEX = 'M' AND T2.UA < 8.0) THEN TRUE ELSE FALSE END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.ID = 57266;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT IIF(T1.SEX = 'M', IIF(T2.UA > 8.0, 'YES', 'NO'), IIF(T2.UA > 6.5, 'YES', 'NO')) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.ID = 57266;

/*
Prediction Result:
('NO',)
*/