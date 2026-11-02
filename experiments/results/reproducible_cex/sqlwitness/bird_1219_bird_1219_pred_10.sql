-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, 'M', '2023-01-01', '2023-01-02', '2023-01-02', 'default1', 'default1'), (1, 'default2', '2023-01-01', '2023-01-02', NULL, 'F', 'F');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (0, '2023-01-01', 0, 1, 1, 0, 7.5, 6.5, 0.0, 0, 1.0, 9.0, 0, 1, 1, NULL, NULL, 9.0, 9.0, NULL, 1, 1.0, 1, 9.0, NULL, NULL, NULL, 'M', NULL, 1, NULL, NULL, NULL, 'F', 1, 1, 'F', 'M', 'default2', 'default2', 'M', 'default2', NULL, NULL), (0, '2023-01-02', 0, NULL, 0, 1, 8.0, 5.5, 9.0, NULL, 9.0, 7.5, 1, NULL, 0, 0, 9.0, 5.5, 9.0, NULL, 1, 5.5, 0, 1.0, 0, NULL, NULL, 'M', NULL, 1, 0, 'default2', 'default1', 'default2', NULL, 1, 'default1', 'default2', 'default1', 'default2', NULL, 'default1', 'M', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.UA) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.UA > 6.5 AND T1.SEX = 'F') OR (T2.UA > 8.0 AND T1.SEX = 'M') AND T2.Date = (SELECT MAX(Date) FROM Laboratory);

/*
Gold Result:
(9.0,)
*/

-- Prediction Query
SELECT AVG(l.UA) AS average_UA_index FROM (SELECT ID, MAX(Date) AS latest_date FROM Laboratory GROUP BY ID) AS latest_exams JOIN Laboratory AS l ON latest_exams.ID = l.ID AND latest_exams.latest_date = l.Date JOIN Patient AS p ON l.ID = p.ID WHERE (p.SEX = 'M' AND l.UA < 8.0) OR (p.SEX = 'F' AND l.UA < 6.5);

/*
Prediction Result:
(None,)
*/