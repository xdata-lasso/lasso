-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (7, '%Y', '2023-01-01', '2023-01-02', '2023-01-01', 'default1', 'default1'), (1, '%Y', NULL, '2023-01-01', '2023-01-02', 'default1', 'default1'), (5, NULL, '1997-10-27', NULL, '2023-01-02', '%Y', '%Y'), (6, 'default1', NULL, '2023-01-02', NULL, 'default1', 'default1'), (0, 'default1', NULL, '1997-10-27', '2023-01-01', NULL, NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (6, '1997-10-27', 6, 6, 0, NULL, 7.5, 6.0, 8.5, 1, NULL, 7.5, NULL, NULL, 5, NULL, 1.0, 5.0, 8.5, 0.0, NULL, 7.5, 5, 1.0, 0, 0, 1, 'default2', NULL, 6, 1, '1997', 'default1', '%Y', 5, 6, 'default2', '1997', 'default2', 'default1', '%Y', 'default2', '1997', 0), (0, '1997-10-27', 1, NULL, NULL, 5, 0.0, 5.0, 8.5, 6, 7.5, 7.0, 6, 5, 7, 5, 6.0, NULL, 9.5, 8.5, 6, 5.0, 0, 9.5, 7, 0, 1, 'default2', 7, 1, 7, 'default1', 'default2', 'default2', NULL, 5, 'default1', '1997', '1997', '1997', 'default1', 'default1', NULL, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(ID) FROM Laboratory WHERE ALB <= 6.0 OR ALB >= 8.5 AND STRFTIME('%Y', Date) = '1997';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "patient"."id") FROM "laboratory" INNER JOIN "patient" ON "laboratory"."id" = "patient"."id" WHERE STRFTIME('%Y', "laboratory"."date") = '1997' AND ("laboratory"."tp" <= 6 OR "laboratory"."tp" >= 8.5);

/*
Prediction Result:
(1,)
*/