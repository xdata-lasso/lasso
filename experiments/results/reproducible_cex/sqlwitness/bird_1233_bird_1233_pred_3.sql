-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, 'default1', '2023-01-02', '1991-10-27', NULL, NULL, '1991'), (181, 'default1', NULL, '1991-10-27', NULL, NULL, 'default2'), (180, '1991', NULL, '2023-01-02', '2023-01-02', 'default2', 'default2'), (179, 'default2', '2023-01-01', NULL, '2023-01-02', '1991', 'default1');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (181, '1991-10-27', NULL, 180, 1, 0, 181.0, 1.0, 181.0, NULL, 1.0, 180.0, 179, 179, NULL, 179, 179.0, 1.0, NULL, 181.0, 179, 180.0, 0, 180.0, 181, NULL, 1, '1991', 180, 180, NULL, 'default2', '1991', NULL, 0, 180, '%Y', '%Y', NULL, NULL, 'default1', '%Y', '1991', 1), (0, '1991-10-27', 180, 179, 180, 179, 180.0, 1.0, 179.0, 1, 0.0, 0.0, 181, 181, 1, 1, 181.0, 180.0, NULL, 180.0, 1, 1.0, NULL, 181.0, 181, 0, 181, 'default1', 1, 179, 0, 'default2', '1991', NULL, 181, 180, 'default1', 'default2', '%Y', 'default1', NULL, '1991', NULL, 1), (180, '2023-01-01', 180, 179, 1, 180, NULL, 181.0, 180.0, NULL, 179.0, 179.0, NULL, 1, 181, NULL, 0.0, 0.0, NULL, 179.0, 0, NULL, 1, 0.0, 1, NULL, 179, 'default2', 181, NULL, 181, NULL, '1991', 'default2', 1, NULL, 'default1', 'default2', 'default1', '1991', 'default2', 'default2', '%Y', 179);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, T2.GLU FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T1."First Date") = '1991' AND T2.GLU < 180;

/*
Gold Result:
*/

-- Prediction Query
SELECT L.ID, L.GLU FROM Laboratory AS L JOIN Patient AS P ON L.ID = P.ID WHERE L.GLU < 180 AND STRFTIME('%Y', P.Description) = '1991';

/*
Prediction Result:
(181, 179)
(0, 1)
*/