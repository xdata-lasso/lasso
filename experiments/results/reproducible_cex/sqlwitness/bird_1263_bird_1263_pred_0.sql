-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (0, NULL, NULL, '2023-01-01', NULL, NULL, NULL), (1, NULL, '2023-01-01', '2023-01-02', '2023-01-02', NULL, 'default2'), (2, NULL, NULL, '2023-01-01', '2023-01-02', 'default1', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (2, '2023-01-02', NULL, 2, 2, 30, 52.0, NULL, 51.0, 52, 1.0, 51.0, NULL, 53, NULL, 28, 1.0, 51.0, 52.0, NULL, 28, 1.0, 52, 30.0, 2, 53, 1, 'default2', 52, 0, 1, 'default2', NULL, 'default1', 1, 0, 'default1', 'default1', 'default1', 'default1', NULL, NULL, 'default1', 28), (0, '2023-01-01', 1, NULL, 28, 1, 30.0, 2.0, 53.0, 53, 0.0, 53.0, 0, 52, 51, 52, 28.0, 1.0, 52.0, 2.0, 29, 30.0, 51, 52.0, 29, 53, 0, 'default1', 30, 29, 2, NULL, NULL, 'default2', 2, 28, NULL, 'default2', 'default2', 'default1', 'default1', NULL, 'default2', 29), (1, '2023-01-01', 52, 2, 0, 2, 2.0, 1.0, 52.0, 1, 29.0, 28.0, NULL, 52, NULL, 30, 1.0, 30.0, 29.0, 52.0, NULL, 2.0, NULL, 51.0, 30, 30, 53, 'default1', 51, 2, 0, 'default2', 'default1', 'default1', 51, 28, 'default2', 'default1', 'default2', NULL, 'default2', 'default2', 'default1', 30);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (0, NULL, 29.0, 51.0, 53, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1), (0, NULL, 53.0, 1.0, 28, NULL, 1, 'default2', NULL, 'default1', 'default2', 'default1', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID INNER JOIN Laboratory AS T3 ON T1.ID = T3.ID WHERE (T3.HCT >= 52 OR T3.HCT <= 29) ORDER BY T2."aCL IgA" DESC, T1.ID NULLS LAST LIMIT 1;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT E.ID FROM Examination AS E INNER JOIN Patient AS P ON E.ID = P.ID INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE (L.ALB < 29 AND L.ALB > 52) OR (L.ALB IS NULL) GROUP BY E.ID ORDER BY MAX(E."aCL IgA") DESC, E.ID NULLS LAST LIMIT 1;

/*
Prediction Result:
*/