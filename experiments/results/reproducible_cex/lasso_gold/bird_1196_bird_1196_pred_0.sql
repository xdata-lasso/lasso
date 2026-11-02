-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1073, 'blood', '1989-05-03', '1993-09-07', '1997-02-11', 'prove', 'hospital');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1074, 'husband', '1989-05-04', '1993-09-08', '1997-02-12', 'they', 'hear');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1075, 'fall', '1989-05-05', '1993-09-09', '1997-02-13', 'his', 'determine');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1076, 'long', '1989-05-06', '1993-09-10', '1997-02-14', 'commercial', 'religious');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1097, 'rise', '1976-10-19', '1980-03-23', '1984-07-04', 'garden', 'arrive');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1098, 'onto', '1976-10-20', '1980-03-24', '1984-07-05', 'threat', 'drop');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1099, 'discuss', '1976-10-21', '1980-03-25', '1984-07-06', 'special', 'term');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1100, 'reveal', '1976-10-22', '1980-03-26', '1984-07-07', 'stand', 'almost');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1121, 'who', '1992-04-12', '1996-08-16', '1971-01-20', 'evidence', 'option');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1122, 'question', '1992-04-13', '1996-08-17', '1971-01-21', 'chair', 'nothing');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1123, 'low', '1992-04-14', '1996-08-18', '1971-01-22', 'employee', 'everyone');
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1124, 'character', '1992-04-15', '1996-08-19', '1971-01-23', 'size', 'skin');
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1073, '1972-06-15', 1077.5, 1081.5, 1085, 'example', 1089, 'SLE', 'raise', 'none', 'maintain', 'push', 1093);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1073, '1972-06-16', 1084.5, 1090.5, 1096.0, 'science', 1104.0, 'SLE', 'away', 'shoulder', 'hundred', 'push', 1120.0);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1073, '1972-06-17', 1091.5, 1099.5, 1107.0, 'write', 1119.0, 'SLE', 'politics', 'election', 'expect', 'push', 1147.0);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1073, '1972-06-18', 1098.5, 1108.5, 1118.0, 'result', 1134.0, 'SLE', 'Congress', 'common', 'wish', 'push', 1174.0);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1097, '1988-11-08', 1101.5, 1105.5, 1109, 'support', 1113, 'SLE', 'attorney', 'our', 'difference', NULL, 1117);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1097, '1988-11-09', 1108.5, 1114.5, 1120.0, 'four', 1128.0, 'SLE', 'development', 'under', 'reality', NULL, 1144.0);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1097, '1988-11-10', 1115.5, 1123.5, 1131.0, 'institution', 1143.0, 'SLE', 'white', 'serious', 'money', NULL, 1171.0);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1097, '1988-11-11', 1122.5, 1132.5, 1142.0, 'executive', 1158.0, 'SLE', 'yes', 'forward', 'individual', NULL, 1198.0);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1121, '1975-05-01', 1125.5, 1129.5, 1133, 'pattern', 1137, 'SLE', 'inside', 'minute', 'traditional', NULL, 1141);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1121, '1975-05-02', 1132.5, 1138.5, 1144.0, 'later', 1152.0, 'SLE', 'high', 'benefit', 'break', NULL, 1168.0);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1121, '1975-05-03', 1139.5, 1147.5, 1155.0, 'water', 1167.0, 'SLE', 'certainly', 'someone', 'claim', NULL, 1195.0);
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1121, '1975-05-04', 1146.5, 1156.5, 1166.0, 'past', 1182.0, 'SLE', 'Mr', 'anyone', 'product', NULL, 1222.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Symptoms FROM Examination WHERE Diagnosis = 'SLE' GROUP BY Symptoms ORDER BY COUNT(Symptoms) DESC, Symptoms NULLS LAST LIMIT 1;

/*
Gold Result:
('push',)
*/

-- Prediction Query
SELECT Symptoms FROM Examination WHERE Diagnosis = 'SLE' GROUP BY Symptoms ORDER BY COUNT(*) DESC, Symptoms NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/