-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1996, '1985', '1985-10-27', NULL, '2023-01-02', '+-', 'default1'), (1, '1985', '1985-10-27', '1985-10-27', '2023-01-01', 'default1', '+-');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (1996, '2023-01-02', 1994, 1996, 0, 1995, NULL, 2.0, 0.0, 1994, 2.0, 1994.0, 2, 1, 2, NULL, NULL, 2.0, 1995.0, 2.0, 1996, NULL, 2, 2.0, 1994, 1995, 1, '1985', 1996, 1996, 1995, '+-', '-', 'default2', 1996, NULL, '%Y', NULL, '-', '+-', '-', '%Y', 'default2', 1994), (1, '2023-01-02', 2, NULL, 2, 0, 1995.0, 1995.0, 1.0, 1, 2.0, 1.0, 2, NULL, NULL, 1996, NULL, 1994.0, NULL, 0.0, 1994, 1994.0, NULL, 1994.0, 1, 1, NULL, 'default1', 1994, 1995, NULL, '1985', '-', '%Y', 0, 1, '-', '1985', 'default2', NULL, 'default1', 'default1', '+-', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.RA = '-' OR T2.RA = '+-') AND T1.Birthday > 1995 - 01 - 01;

/*
Gold Result:
('default1',)
('+-',)
*/

-- Prediction Query
SELECT DISTINCT "Patient"."Diagnosis" FROM "Patient" INNER JOIN "Laboratory" ON "Patient"."ID" = "Laboratory"."ID" WHERE STRFTIME('%Y', "Patient"."Birthday") > '1985' AND "Laboratory"."RA" IN ('-', '+-');

/*
Prediction Result:
*/