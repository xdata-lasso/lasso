-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (501, 'default1', '2023-01-02', NULL, '2023-01-02', 'default1', NULL), (500, 'default2', NULL, NULL, '2023-01-02', NULL, 'default2'), (2, NULL, NULL, NULL, '2023-01-02', 'default2', 'default2'), (79, 'default1', '2023-01-02', '2023-01-01', '2023-01-02', NULL, 'default1'), (0, NULL, '2023-01-01', '2023-01-01', NULL, 'default2', 'default2'), (80, 'default1', '2023-01-02', NULL, '2023-01-02', 'default1', NULL), (81, NULL, '2023-01-02', '2023-01-02', NULL, 'default1', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (501, '2023-01-02', 81, 500, 2, 80, 0.0, 80.0, 1.0, 80, 80.0, NULL, 80, 500, 2, 81, 499.0, 81.0, 501.0, 499.0, 81, 499.0, NULL, 1.0, NULL, 79, 500, 'default2', 0, 81, 500, 'default2', 'default1', 'default1', 2, 500, NULL, NULL, 'default1', 'default1', NULL, 'default1', NULL, 499), (500, '2023-01-01', 500, 81, NULL, 501, 1.0, 80.0, 80.0, 500, 80.0, 0.0, 2, 80, 81, 80, 80.0, 81.0, 1.0, 500.0, 499, 79.0, 79, 2.0, 81, 499, 2, 'default2', 80, 79, 501, NULL, 'default1', NULL, 79, NULL, NULL, 'default1', NULL, 'default1', 'default2', 'default1', 'default1', 2), (80, '2023-01-02', 499, 81, 500, 80, 1.0, 501.0, 79.0, 0, 2.0, 81.0, 0, 81, 500, 500, 0.0, 79.0, 0.0, 2.0, 80, 0.0, 1, 79.0, 499, 81, 500, NULL, 81, 80, 1, NULL, NULL, NULL, 1, 0, 'default1', 'default1', 'default1', 'default1', 'default2', 'default1', 'default1', 2), (81, '2023-01-02', 81, 81, 499, 79, 79.0, 500.0, 79.0, 81, 81.0, 501.0, 499, 499, 0, 0, 501.0, 1.0, 500.0, 0.0, 499, 80.0, 501, 81.0, 1, 80, 1, NULL, 81, 79, 0, NULL, NULL, 'default2', 1, 2, 'default2', 'default1', 'default2', NULL, 'default1', 'default2', NULL, 80), (0, '2023-01-02', 499, NULL, 1, 500, 500.0, 81.0, 499.0, 1, 499.0, 2.0, NULL, 79, 80, 499, 499.0, 81.0, 499.0, 79.0, 79, 2.0, 1, NULL, 79, 0, 81, 'default2', 501, 81, 499, 'default1', 'default2', 'default1', 2, 0, NULL, 'default2', 'default2', 'default1', NULL, 'default2', NULL, 80), (501, '2023-01-01', 81, 501, NULL, 80, 81.0, 81.0, 499.0, 0, 81.0, 0.0, 0, 81, 0, 79, 79.0, 0.0, NULL, 79.0, 0, 1.0, 79, 0.0, 81, 80, 79, 'default1', 80, 79, 81, 'default2', 'default2', 'default2', 501, 80, 'default1', 'default1', 'default1', 'default1', 'default1', NULL, 'default2', 501), (2, '2023-01-01', 0, 501, 499, 80, 81.0, 79.0, 501.0, 2, 1.0, 2.0, 0, 2, 81, 81, 1.0, 0.0, 2.0, 81.0, 79, 1.0, 499, 2.0, NULL, 0, 79, NULL, 501, 501, 80, NULL, 'default1', 'default2', NULL, 81, 'default1', 'default2', 'default1', 'default1', 'default2', 'default1', NULL, 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patientData.Diagnosis FROM Patient AS patientData INNER JOIN Laboratory AS labData ON patientData.ID = labData.ID WHERE labData.IGA BETWEEN 80 AND 500 ORDER BY labData.IGA DESC, patientData.id NULLS LAST, labData.id NULLS LAST, labData.date NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT patient.diagnosis FROM patient INNER JOIN laboratory ON patient.id = laboratory.id WHERE laboratory.iga = (SELECT MAX(iga) FROM laboratory WHERE iga BETWEEN 80 AND 500);

/*
Prediction Result:
(None,)
('default2',)
*/