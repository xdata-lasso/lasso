-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (1, 'M', '2023-01-01', '2023-01-01', '2023-01-01', 'F', 'F'), (0, 'default1', '2023-01-01', '2023-01-02', NULL, 'M', 'default2'), (2, 'M', '2023-01-01', '2023-01-02', NULL, 'F', 'default1');
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (1, '2023-01-01', NULL, NULL, 0, 1, 5.5, 0.0, 6.5, 0, 5.5, 7.0, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 1.0, 0, 0, NULL, 'M', NULL, 1, 1, 'F', 'M', 'default2', 0, NULL, NULL, 'F', 'M', NULL, 'F', 'default2', 'default1', 1), (2, '2023-01-02', NULL, 1, 0, 1, 7.5, 7.5, 0.0, 0, NULL, 8.0, 0, 0, 1, NULL, 0.0, 6.5, 8.0, 9.0, 1, 7.5, 0, 1.0, 1, 1, NULL, 'default1', 0, 1, 1, 'default1', 'F', 'default1', 1, 1, NULL, 'default2', 'M', 'M', NULL, 'default2', 'default1', 1), (2, '2023-01-01', 1, NULL, NULL, 1, 7.5, 9.0, 6.5, 0, 9.0, 6.5, 0, 0, NULL, 1, 7.5, 5.5, 9.0, 9.0, 0, 9.0, 0, 5.5, NULL, 1, 1, 'F', 1, NULL, NULL, 'default1', 'default2', 'M', 0, 1, 'F', 'default1', 'F', 'M', 'default1', 'default1', 'M', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.UA) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.UA > 6.5 AND T1.SEX = 'F') OR (T2.UA > 8.0 AND T1.SEX = 'M') AND T2.Date = (SELECT MAX(Date) FROM Laboratory);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG("Laboratory"."UA") AS "average_UA_index" FROM "Laboratory" INNER JOIN "Patient" ON "Laboratory"."ID" = "Patient"."ID" WHERE ("Patient"."SEX" = 'M' AND "Laboratory"."UA" < 8.0) OR ("Patient"."SEX" = 'F' AND "Laboratory"."UA" < 6.5) AND "Laboratory"."Date" = (SELECT MAX("Date") FROM "Laboratory" WHERE "Laboratory"."ID" = "Patient"."ID");

/*
Prediction Result:
(4.333333333333333,)
*/