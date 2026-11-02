-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1508, 'material', '1993-11-11', '1996-03-14', '1970-06-17', 'guy', 'oil');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1509, 'on', '1993-11-12', '1996-03-15', '1970-06-18', 'large', 'give');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1510, 'nice', '1993-11-13', '1996-03-16', '1970-06-19', 'skill', 'he');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1520, 'direction', '1976-01-23', '1979-04-03', '1982-07-06', 'factor', 'soon');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1521, 'single', '1976-01-24', '1979-04-04', '1982-07-07', 'shake', 'network');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1522, 'member', '1976-01-25', '1979-04-05', '1982-07-08', 'perform', 'picture');
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1508, '1973-09-20', 1511.5, 2.0, 1514, 'S', 1517, 'scientist', 'enter', 'set', 'call', 'sound', 2);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1508, '1973-09-21', 1518.5, 0.0, 1525.0, 'S', 1532.0, 'long', 'during', 'data', 'situation', 'road', 2);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1508, '1973-09-22', 1525.5, -2.0, 1536.0, 'S', 1547.0, 'experience', 'camera', 'four', 'north', 'crime', 2);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1520, '1985-10-09', 1523.5, 2.0, 1526, 'S', 1529, 'fear', 'daughter', 'herself', 'address', 'card', 2);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1520, '1985-10-10', 1530.5, 0.0, 1537.0, 'dark', 1544.0, 'black', 'fine', 'country', 'section', 'eye', 3);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1520, '1985-10-11', 1537.5, -2.0, 1548.0, 'S', 1559.0, 'there', 'dream', 'five', 'none', 'answer', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM Examination WHERE Thrombosis = 2 AND "ANA Pattern" = 'S' AND "aCL IgM" > (SELECT AVG("aCL IgM") * 1.2 FROM Examination WHERE Thrombosis = 2 AND "ANA Pattern" = 'S');

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Examination WHERE Thrombosis = 2 AND "ANA Pattern" = 'S' AND "aCL IgM" >= (SELECT AVG("aCL IgM") * 1.2 FROM Examination WHERE Thrombosis = 2 AND "ANA Pattern" = 'S');

/*
Prediction Result:
(3,)
*/