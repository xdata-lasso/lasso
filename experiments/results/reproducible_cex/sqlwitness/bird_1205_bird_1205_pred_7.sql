-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (57266, NULL, NULL, '2023-01-02', NULL, 'F', 'default2'), (0, 'M', NULL, '2023-01-02', '2023-01-02', 'Yes', 'F'), (57265, 'No', '2023-01-02', NULL, '2023-01-01', 'default1', 'default1'), (57267, 'Yes', '2023-01-02', '2023-01-02', NULL, NULL, 'No'), (1, 'M', NULL, '2023-01-02', NULL, 'default1', 'Yes'), (2, NULL, '2023-01-02', NULL, '2023-01-02', 'M', 'M');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (57266, '2023-01-01', 0, 57267, 0, 1, 1.0, 6.5, 6.5, 57265, 57266.0, NULL, 1, 0, 57265, NULL, 6.5, 1.0, 8.0, NULL, 0, NULL, 1, 7.5, 57267, 57265, 57267, NULL, 57266, NULL, 57265, 'Yes', 'default1', 'F', 57267, 0, 'default1', NULL, 'M', 'No', 'No', 'F', 'No', NULL), (2, '2023-01-01', 0, 0, 1, NULL, 9.0, 8.0, 1.0, 57266, 1.0, 1.0, 57266, 57265, 57265, 57267, 7.5, NULL, NULL, 9.0, 0, 0.0, 57265, 8.0, 0, NULL, 0, 'M', 57266, 57266, 57267, 'M', 'default2', 'No', 57266, NULL, NULL, 'default2', 'default1', NULL, 'F', 'F', 'F', 57266);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN (T1.SEX = 'F' AND T2.UA > 6.5) OR (T1.SEX = 'M' AND T2.UA < 8.0) THEN TRUE ELSE FALSE END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.ID = 57266;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT CASE WHEN (patient.sex = 'M' AND laboratory.ua > 8.0) OR (patient.sex = 'F' AND laboratory.ua > 6.5) THEN 'Yes' ELSE 'No' END AS is_within_normal_range FROM patient INNER JOIN laboratory ON patient.id = laboratory.id WHERE patient.id = 57266;

/*
Prediction Result:
('No',)
*/