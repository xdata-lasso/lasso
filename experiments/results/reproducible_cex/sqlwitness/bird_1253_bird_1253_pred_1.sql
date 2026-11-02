-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (501, 'default2', NULL, '2023-01-02', '2023-01-02', 'default1', NULL), (500, 'default2', '2023-01-01', '2023-01-01', NULL, 'default2', 'default2'), (79, NULL, '2023-01-02', '2023-01-01', '2023-01-01', 'default1', 'default2'), (80, 'default1', NULL, '2023-01-01', '2023-01-02', 'default2', NULL), (81, NULL, NULL, '2023-01-01', '2023-01-02', 'default1', 'default2'), (2, NULL, '2023-01-02', NULL, '2023-01-01', 'default2', 'default1'), (1, 'default1', NULL, '2023-01-02', '2023-01-01', NULL, 'default1'), (0, 'default1', '2023-01-01', '2023-01-01', '2023-01-02', 'default2', 'default2'), (499, 'default2', NULL, NULL, '2023-01-01', NULL, 'default2'), (3, 'default1', '2023-01-01', NULL, '2023-01-01', 'default1', 'default1'), (4, 'default1', '2023-01-02', NULL, NULL, 'default1', 'default1');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (501, '2023-01-02', 1, 81, 81, 501, 2.0, 80.0, NULL, 2, 79.0, 501.0, 1, 79, 499, 80, 0.0, 0.0, 1.0, 0.0, 501, 79.0, 2, NULL, 501, 499, 79, 'default2', NULL, 500, NULL, 'default2', 'default1', 'default1', 81, 501, 'default2', 'default2', NULL, NULL, 'default2', 'default2', NULL, 0), (500, '2023-01-01', NULL, 1, NULL, 79, 80.0, 499.0, 81.0, 79, 79.0, 81.0, 81, 1, 81, 80, 501.0, 81.0, NULL, 80.0, 501, 2.0, 0, 1.0, 500, NULL, 79, NULL, 79, 500, 81, 'default2', NULL, NULL, 500, 81, 'default2', 'default2', 'default1', 'default2', 'default2', NULL, 'default1', 79), (3, '2023-01-02', 2, 1, 79, NULL, 500.0, 79.0, 1.0, 81, 2.0, 501.0, 1, 81, 501, 1, 79.0, 79.0, NULL, 2.0, 501, NULL, 499, NULL, 80, 80, 2, 'default2', 501, 0, 0, 'default2', 'default1', 'default2', 79, 80, 'default2', 'default2', 'default2', NULL, NULL, NULL, 'default1', 81), (81, '2023-01-01', 81, 80, 499, 500, 500.0, 1.0, NULL, 1, 79.0, 81.0, 499, 2, 501, 501, 500.0, 499.0, 1.0, NULL, 0, 79.0, 1, 80.0, 0, 79, 501, NULL, 501, 80, 500, 'default1', NULL, NULL, 2, 2, 'default2', 'default1', 'default1', 'default1', 'default1', NULL, 'default1', 0), (4, '2023-01-02', 2, 0, 501, 0, 2.0, 80.0, 79.0, 79, 1.0, 79.0, 80, 81, 2, 81, 79.0, 79.0, 80.0, 500.0, 0, 499.0, 81, 499.0, 499, 499, 500, 'default1', 2, 1, 81, 'default1', NULL, 'default2', 79, 499, 'default1', 'default2', 'default2', NULL, 'default2', 'default2', NULL, 79), (499, '2023-01-02', NULL, 2, 500, 501, 79.0, NULL, 0.0, 0, 1.0, NULL, 0, 500, 1, 501, 79.0, 2.0, 2.0, 501.0, 79, 1.0, 500, 500.0, 80, 81, 79, 'default2', 0, 79, 501, 'default1', NULL, 'default1', 79, 0, NULL, NULL, 'default1', NULL, 'default1', 'default1', 'default1', NULL), (500, '2023-01-02', 80, 81, 2, 1, 1.0, NULL, 1.0, 501, 1.0, 81.0, 499, 501, NULL, 2, 79.0, 500.0, 0.0, 500.0, NULL, 2.0, 501, 499.0, 79, NULL, 80, 'default1', 2, 2, 1, 'default2', 'default2', NULL, 501, 79, NULL, NULL, 'default2', 'default1', 'default1', NULL, NULL, 0), (501, '2023-01-01', 2, 2, 2, 0, 1.0, NULL, 2.0, 79, 2.0, 499.0, NULL, 0, 1, 80, 81.0, 2.0, 1.0, 500.0, 2, 1.0, 79, 79.0, 79, NULL, 1, 'default2', 80, 2, 0, 'default2', NULL, 'default1', NULL, 81, 'default1', 'default2', 'default2', NULL, 'default1', NULL, NULL, 79);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patientData.Diagnosis FROM Patient AS patientData INNER JOIN Laboratory AS labData ON patientData.ID = labData.ID WHERE labData.IGA BETWEEN 80 AND 500 ORDER BY labData.IGA DESC, patientData.id NULLS LAST, labData.id NULLS LAST, labData.date NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT P.Diagnosis FROM Patient AS P INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE L.IGA = (SELECT MAX(IGA) FROM Laboratory WHERE IGA BETWEEN 80 AND 500);

/*
Prediction Result:
(None,)
('default2',)
*/