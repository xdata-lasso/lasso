-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (2, 'default1', NULL, '2023-01-02', NULL, 'default2', 'default2'), (501, NULL, '2023-01-01', NULL, '2023-01-01', 'default1', 'default1'), (500, 'default1', '2023-01-01', NULL, '2023-01-01', NULL, 'default2'), (80, NULL, '2023-01-01', NULL, '2023-01-01', 'default1', NULL), (79, 'default1', NULL, '2023-01-02', NULL, 'default1', NULL), (81, NULL, '2023-01-01', NULL, '2023-01-01', 'default1', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (501, '2023-01-02', 2, NULL, 79, 2, 79.0, 1.0, 0.0, 79, 81.0, NULL, 2, NULL, 501, 80, 2.0, 499.0, 80.0, 1.0, 1, 2.0, 499, NULL, 0, 2, 80, 'default2', 81, 0, 500, NULL, 'default1', NULL, 80, 1, 'default1', 'default1', NULL, NULL, 'default1', 'default1', NULL, 2), (2, '2023-01-02', 501, 2, 81, 79, 1.0, 500.0, 0.0, 2, 81.0, NULL, 499, 81, NULL, 501, 80.0, 2.0, 1.0, 500.0, 81, 501.0, 2, 80.0, 500, 1, 2, 'default1', NULL, 499, 1, NULL, 'default1', 'default1', 81, 81, 'default1', 'default1', NULL, 'default1', NULL, 'default2', NULL, 1), (500, '2023-01-01', NULL, 1, 499, 80, 499.0, 80.0, 499.0, 81, 0.0, 79.0, 501, NULL, 2, NULL, 499.0, 1.0, 499.0, 0.0, 1, 80.0, 1, 81.0, 501, 79, 79, NULL, 79, 80, 80, 'default1', 'default1', 'default2', 501, 0, 'default1', NULL, 'default2', NULL, 'default1', NULL, 'default2', 79), (80, '2023-01-02', 500, 500, 79, 0, 81.0, 0.0, 81.0, 2, 500.0, 501.0, NULL, 0, 1, 80, 79.0, 1.0, 80.0, 1.0, 501, 81.0, 499, 499.0, 0, 2, NULL, 'default1', 501, 500, 2, NULL, NULL, NULL, 80, 79, NULL, NULL, NULL, NULL, NULL, 'default1', 'default2', 1), (500, '2023-01-02', 499, 500, 81, 0, 500.0, 79.0, 2.0, 0, 81.0, 0.0, 499, NULL, 2, 2, 79.0, 499.0, NULL, 1.0, 79, 2.0, 80, 1.0, NULL, 0, 500, 'default2', 499, 500, 501, 'default1', NULL, 'default2', 500, 501, 'default2', 'default2', NULL, NULL, 'default2', 'default2', NULL, 2), (2, '2023-01-01', 0, 501, 500, 80, 1.0, 0.0, 1.0, 499, 1.0, 500.0, 79, 499, 79, 0, 80.0, 79.0, 500.0, NULL, 79, 501.0, 81, 81.0, 80, 81, 80, 'default2', 2, 500, 501, NULL, 'default1', NULL, 1, 499, 'default2', NULL, NULL, 'default1', 'default2', NULL, NULL, 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patientData.Diagnosis FROM Patient AS patientData INNER JOIN Laboratory AS labData ON patientData.ID = labData.ID WHERE labData.IGA BETWEEN 80 AND 500 ORDER BY labData.IGA DESC, patientData.id NULLS LAST, labData.id NULLS LAST, labData.date NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT Diagnosis FROM Patient WHERE ID = (SELECT ID FROM Laboratory WHERE IGA = (SELECT MAX(IGA) FROM Laboratory WHERE IGA BETWEEN 80 AND 500));

/*
Prediction Result:
(None,)
*/