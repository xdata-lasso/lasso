-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (151, NULL, '1979-12-31', '1980-01-02', '2023-01-01', NULL, NULL), (0, 'default2', NULL, NULL, '1980-01-01', NULL, NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (0, '1979-12-31', 0, NULL, 0, 149, 1.0, 449.0, 1.0, 451, 150.0, 449.0, 150, 150, 150, 150, 1.0, 0.0, NULL, 449.0, 0, 149.0, 0, NULL, NULL, 449, 149, 'default1', 0, 1, 1, 'default1', '1980-01-01', 'default2', 449, 451, 'default2', '1980-01-01', '1980-01-01', 'default1', 'default2', '1980-01-01', NULL, 150), (151, '2023-01-02', 1, 150, 450, 450, 450.0, 151.0, 150.0, 0, 450.0, 149.0, 151, 451, 1, 0, 1.0, 150.0, 451.0, 449.0, 151, 451.0, 151, 1.0, 450, 0, 150, 'default2', NULL, NULL, NULL, 'default1', '1980-01-01', '1980-01-01', NULL, 151, 'default2', 'default2', 'default2', 'default2', '1980-01-01', '1980-01-01', '1980-01-01', 450);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.FG <= 150 OR T2.FG >= 450 AND T1.Birthday > '1980-01-01';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "patient"."id") FROM "patient" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" WHERE "patient"."birthday" > '1980-01-01' AND ("laboratory"."fg" < 150 OR "laboratory"."fg" > 450 OR "laboratory"."fg" IS NULL);

/*
Prediction Result:
(0,)
*/