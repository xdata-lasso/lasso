-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (400, NULL, '2025-01-01', '1984-10-27', '1984-10-27', '%Y', 'default1'), (51, '1984', NULL, '2023-01-01', '1984-10-27', 'default1', '2025-01-01 00:00:00'), (399, '%Y', '2025-01-01', '2023-01-01', '2023-01-02', '1984', 'default2'), (50, '1984', '2025-01-01', '2025-01-01', '2023-01-01', '2025-01-01 00:00:00', '2025-01-01 00:00:00'), (101, '2025-01-01 00:00:00', '2023-01-01', '2023-01-01', '2025-01-01', '1984', '1984'), (49, '%Y', '2025-01-01', NULL, NULL, 'default2', NULL), (401, '%Y', NULL, '2023-01-02', NULL, '2025-01-01 00:00:00', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (50, '1984-10-27', 50, 401, 100, 100, 1.0, 49.0, 100.0, 401, 51.0, 99.0, 50, 51, 401, 100, 100.0, NULL, 399.0, 49.0, 0, 99.0, 1, 50.0, 399, 400, 49, '2025-01-01 00:00:00', NULL, 1, 49, '2025-01-01 00:00:00', '1984', 'default1', 49, 1, '1984', 'default1', NULL, '2025-01-01 00:00:00', 'default1', '2025-01-01 00:00:00', '%Y', NULL), (399, '2023-01-01', 400, 1, 50, 400, 100.0, 51.0, 401.0, 401, 49.0, 51.0, 100, 400, 49, 399, 50.0, 400.0, 0.0, 99.0, 400, 0.0, 49, 1.0, NULL, 401, 0, 'default2', 101, 101, 401, 'default1', '1984', '%Y', 400, 400, 'default1', '1984', '%Y', 'default2', '2025-01-01 00:00:00', NULL, NULL, 0), (400, '2025-01-01', 101, 100, 399, 50, 50.0, 100.0, 400.0, 0, 100.0, 1.0, 1, 50, 49, 0, 51.0, 50.0, 99.0, 101.0, 49, 1.0, 49, 399.0, 1, NULL, 101, '1984', 51, 50, 1, '2025-01-01 00:00:00', 'default2', '2025-01-01 00:00:00', 50, 50, '1984', '2025-01-01 00:00:00', '%Y', '%Y', '%Y', 'default1', '1984', 49), (49, '1984-10-27', 49, 399, 1, 1, 100.0, 399.0, 99.0, 101, 399.0, 50.0, 49, NULL, 51, 101, 100.0, 400.0, 100.0, 400.0, 399, 101.0, NULL, 401.0, 399, 49, 1, '%Y', 400, 401, 50, 'default1', 'default1', NULL, 399, 100, '%Y', '%Y', 'default2', '%Y', '%Y', '2025-01-01 00:00:00', 'default2', 100), (400, '2023-01-01', NULL, 0, 51, 400, 401.0, 49.0, 49.0, 399, 99.0, 401.0, 400, 49, NULL, 50, 50.0, 399.0, 100.0, 399.0, 101, 0.0, 399, 100.0, 50, 100, 101, '1984', 401, 401, 0, 'default1', NULL, '%Y', 50, 401, 'default1', 'default2', '2025-01-01 00:00:00', 'default2', '1984', '2025-01-01 00:00:00', 'default1', 1), (399, '2025-01-01', 49, 1, NULL, 51, 99.0, 1.0, 50.0, 51, 49.0, 401.0, 100, NULL, 51, 50, 1.0, NULL, 101.0, 401.0, 51, 50.0, 101, NULL, 400, 100, 401, '%Y', 100, 0, 399, '2025-01-01 00:00:00', '2025-01-01 00:00:00', 'default1', 0, 399, '1984', '2025-01-01 00:00:00', NULL, 'default1', 'default1', NULL, 'default2', 50), (401, '1984-10-27', 99, 50, 399, NULL, 101.0, 49.0, 0.0, 50, 49.0, 49.0, 50, 51, NULL, 100, 100.0, 0.0, 99.0, 99.0, 401, 400.0, 99, 399.0, 99, 101, 99, NULL, NULL, 51, 100, 'default2', '1984', 'default1', 51, 49, '2025-01-01 00:00:00', '2025-01-01 00:00:00', '2025-01-01 00:00:00', '2025-01-01 00:00:00', '%Y', '2025-01-01 00:00:00', 'default1', 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.PLT BETWEEN 100 AND 400 AND STRFTIME('%Y', T2.Date) - STRFTIME('%Y', T1.Birthday) < 50 AND STRFTIME('%Y', T2.Date) = '1984';

/*
Gold Result:
(49,)
*/

-- Prediction Query
SELECT T2.ID, T2.SEX, T2.Birthday, T2.Description, T2."First Date", T2.Admission, T2.Diagnosis FROM Laboratory AS T1 INNER JOIN Patient AS T2 ON T1.ID = T2.ID WHERE STRFTIME('%Y', T1.Date) = '1984' AND (STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T2.Birthday)) < 50 AND T1.PLT BETWEEN 100 AND 400;

/*
Prediction Result:
(49, '%Y', '2025-01-01', None, None, 'default2', None)
*/