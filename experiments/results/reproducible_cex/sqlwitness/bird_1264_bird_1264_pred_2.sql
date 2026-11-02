-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patient (id, sex, birthday, description, "first date", admission, diagnosis) VALUES (10, NULL, '2023-01-02', '2023-01-02', '2023-01-02', 'default2', 'APS'), (9, 'default1', '2023-01-01', '2023-01-01', NULL, 'APS', 'APS'), (11, 'APS', '2023-01-01', NULL, '2023-01-02', 'default2', 'default1'), (-1, 'default1', '2023-01-02', '2023-01-02', '2023-01-01', 'APS', 'APS'), (1, 'APS', '2023-01-01', NULL, '2023-01-01', NULL, 'default1'), (0, 'APS', NULL, '2023-01-01', NULL, 'APS', NULL);
INSERT INTO laboratory (id, date, got, gpt, ldh, alp, tp, alb, ua, un, cre, "t-bil", "t-cho", tg, cpk, glu, wbc, rbc, hgb, hct, plt, pt, aptt, fg, pic, tat, tat2, "u-pro", igg, iga, igm, crp, ra, rf, c3, c4, rnp, sm, sc170, ssa, ssb, centromea, dna, "dna-ii") VALUES (10, '2023-01-01', -1, NULL, 9, 11, 10.0, 9.0, 0.0, 1, 1.0, 0.0, NULL, 11, 10, 0, NULL, 1.0, 0.0, 11.0, 10, NULL, NULL, 0.0, 9, 10, 1, NULL, 1, 0, 11, 'default1', 'APS', 'default1', 9, 9, 'default2', NULL, NULL, 'default1', 'default2', NULL, 'default1', 0), (0, '2023-01-01', 11, 1, 10, 9, 11.0, 1.0, 9.0, -1, 0.0, 0.0, -1, 9, -1, 0, 9.0, 0.0, 10.0, -1.0, -1, NULL, 1, 10.0, NULL, NULL, 0, 'default2', 9, 9, 0, NULL, 'default2', NULL, -1, 9, NULL, 'default2', 'default2', 'APS', 'APS', 'default1', 'default1', 1), (10, '2023-01-02', -1, 9, NULL, 0, 0.0, 1.0, 11.0, -1, 11.0, 10.0, NULL, NULL, 9, -1, 11.0, 0.0, 1.0, 9.0, NULL, 11.0, 10, NULL, -1, 9, -1, 'default1', 11, 10, 11, NULL, 'default2', 'default2', 0, 11, 'APS', 'APS', 'default2', NULL, 'default2', NULL, 'default2', -1), (1, '2023-01-01', 1, 0, -1, -1, -1.0, NULL, -1.0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11.0, -1.0, 10.0, NULL, 0.0, 1, 10.0, 0, 0, 11, 'default1', 9, 10, 1, 'default2', NULL, NULL, 1, 9, 'default2', 'APS', 'default1', 'default1', NULL, NULL, NULL, NULL), (1, '2023-01-02', 10, 1, 0, 11, 10.0, 10.0, -1.0, -1, 0.0, 0.0, 0, 0, 1, -1, 0.0, 1.0, 0.0, 10.0, 11, 1.0, 10, 1.0, NULL, 1, 9, NULL, 11, 1, 10, NULL, 'default1', 'default2', NULL, 11, 'APS', NULL, 'APS', NULL, NULL, 'default2', 'default2', 0), (-1, '2023-01-02', 1, -1, 9, NULL, 10.0, 10.0, 11.0, 0, 0.0, 11.0, -1, 11, 11, 0, NULL, 0.0, 0.0, NULL, -1, 9.0, -1, 9.0, 9, 1, 10, NULL, 0, -1, NULL, NULL, 'default1', 'APS', 11, 0, 'default2', 'default2', 'APS', 'APS', 'default1', 'APS', NULL, 11);
INSERT INTO examination (id, "examination date", "acl igg", "acl igm", ana, "ana pattern", "acl iga", diagnosis, kct, rvvt, lac, symptoms, thrombosis) VALUES (-1, '2023-01-01', 11.0, 9.0, -1, NULL, 10, NULL, NULL, 'APS', 'default1', NULL, 9), (1, NULL, -1.0, 1.0, -1, 'APS', 10, 'APS', 'APS', 'default1', 'default1', NULL, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.C4 > 10 AND T1.Diagnosis = 'APS';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "patient"."id") FROM "patient" INNER JOIN "examination" ON "patient"."id" = "examination"."id" INNER JOIN "laboratory" ON "patient"."id" = "laboratory"."id" WHERE "examination"."thrombosis" > 0 AND "laboratory"."c4" > 10;

/*
Prediction Result:
(0,)
*/