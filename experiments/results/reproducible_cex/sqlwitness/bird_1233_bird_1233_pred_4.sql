-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, '1991%', NULL, NULL, '2023-01-02', '1991', '1991%'), (1, '1991', NULL, '2023-01-02', NULL, NULL, 'default2'), (181, 'default2', NULL, '2023-01-02', '2023-01-02', 'default1', 'default2'), (179, NULL, '2023-01-01', NULL, '2023-01-02', 'default1', '1991'), (180, NULL, '2023-01-01', '1991-10-27', '2023-01-01', '%Y', 'default1'), (2, '1991%', '1991-10-27', NULL, '2023-01-01', '1991%', '1991%'), (3, NULL, '1991-10-27', '2023-01-02', '2023-01-01', NULL, 'default1'), (4, 'default2', '1991-10-27', NULL, '1991-10-27', 'default2', NULL), (5, NULL, '1991-10-27', '2023-01-02', NULL, '1991%', '1991');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (4, '1991-10-27', 180, 179, 1, 181, 180.0, 180.0, 1.0, 181, 0.0, 181.0, 0, 0, 1, 0, 1.0, 180.0, 0.0, 180.0, 1, 180.0, 0, 181.0, 181, 181, NULL, 'default1', 1, 179, 0, '1991', 'default2', 'default2', 180, NULL, NULL, NULL, NULL, 'default1', 'default2', '%Y', 'default1', 181), (181, '2023-01-01', NULL, 0, 0, 180, 179.0, 180.0, 0.0, NULL, 0.0, 179.0, 179, 181, 179, 1, 181.0, 179.0, NULL, 179.0, NULL, 181.0, 180, NULL, 179, 0, 1, '1991', 1, 180, 0, 'default2', '1991', '1991', 179, 181, '1991%', 'default2', '1991', 'default2', NULL, '1991', 'default2', 181), (0, '1991-10-27', 0, 0, 181, 179, 179.0, 1.0, 0.0, 1, 179.0, 1.0, 180, 0, 180, 179, 180.0, 1.0, 1.0, 1.0, 180, 181.0, 181, 0.0, NULL, 179, 181, '1991%', 1, 1, 181, 'default2', NULL, 'default1', NULL, 0, '%Y', NULL, NULL, '1991', '%Y', '1991', '%Y', 1), (181, '2023-01-02', 0, 180, 181, 181, 0.0, 180.0, NULL, NULL, 0.0, 179.0, NULL, 179, 181, 0, 1.0, 1.0, 179.0, 179.0, 1, 1.0, 1, 181.0, 0, 181, 179, 'default1', NULL, 180, 181, 'default1', '1991%', '1991%', NULL, 0, '1991', '1991%', NULL, '1991', '%Y', '1991%', 'default2', NULL), (5, '2023-01-02', 180, NULL, 180, 1, 180.0, 1.0, 180.0, 179, 181.0, 179.0, 1, 181, 0, 1, 179.0, 179.0, 181.0, 180.0, 180, NULL, 179, NULL, 0, 181, 181, 'default1', NULL, NULL, 0, '%Y', 'default1', '1991', 179, 180, '1991%', 'default1', '1991', '1991', 'default2', 'default2', '1991%', 0), (2, '1991-10-27', 181, NULL, 0, 181, 180.0, 0.0, 179.0, 0, 0.0, 1.0, 1, 181, NULL, 0, 181.0, 179.0, NULL, 181.0, 1, 180.0, 179, NULL, 181, 181, 179, NULL, NULL, 0, 180, 'default2', '1991', '1991%', 1, NULL, 'default1', 'default1', NULL, 'default1', '%Y', '1991', '%Y', 180), (5, '1991-10-27', NULL, NULL, 179, 180, 181.0, 1.0, 0.0, 0, 179.0, 180.0, 179, 0, 0, 180, 181.0, 1.0, 0.0, 181.0, 180, 1.0, NULL, 180.0, 1, 0, 179, NULL, 181, 180, 0, 'default1', 'default2', '1991', 180, 1, 'default2', NULL, '1991', '1991', 'default1', '1991%', 'default2', 181), (179, '2023-01-01', 0, 180, 180, 181, 0.0, 0.0, 0.0, 0, 1.0, 180.0, NULL, 180, 0, 179, 0.0, 181.0, NULL, 181.0, 180, 1.0, 0, NULL, 180, 0, 179, '1991', 1, 180, 179, 'default2', 'default2', NULL, NULL, 180, '1991%', 'default1', '%Y', 'default1', 'default1', 'default2', 'default1', 179);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T2.GLU FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T1."First Date") = '1991' AND T2.GLU < 180;

/*
Gold Result:
(4, 0)
*/

-- Prediction Query
SELECT Patient.ID, Laboratory.GLU FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.Description LIKE '1991%' AND Laboratory.GLU < 180;

/*
Prediction Result:
*/