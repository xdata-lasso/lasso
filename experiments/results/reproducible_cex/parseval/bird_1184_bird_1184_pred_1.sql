-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '1959-03-01', '2021-12-04', '2022-04-27', '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483647, 'uo4nrqrofqy', '1959-03-01', '2022-09-19', '2025-06-25', '5bbp0', '2eutliqa11r');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'ph2', '1959-03-01', '2021-03-22', '2022-04-21', 'q', 'nqcx5h');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'cprj', '2023-05-30', '2023-07-15', '2024-08-30', 'z', '9fjgq8n2f');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1993-09-27', 882.963176, 841.297061, -1349201381, 'hvdlttilbnpr', 2087640001, 'dposiie5unw', 'klfa9000t', 'c4ecigce', '76nium52', 't2__c5aa32', -443340271);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1993-09-27', 997.73177, 881.232072, -525979501, 'oo3o9hl72kl', -305670381, 'i7z', 'au2dwy', 'q13py', '78d99r', 't2__c5aa32', -1362461264);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1993-09-27', 943.791649, 289.326855, -346339240, 'yp5qi2rk', -705985602, 'x58pz0f8je', 'd2', 'vy9uxj4', 'wb', 't2__c5aa32', -1929953647);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '1993-09-27', 456.127515, 52.895335, -1056308489, 'gcb98oz', 1443629118, 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 't2__c5aa32', 564390026);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '1993-09-27', 569.30821, 206.755818, 2011234363, 'ai5', 1360271423, 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 't2__c5aa32', -598313376);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '1993-09-27', 959.196496, 917.425128, 804529642, '01jh3den', 357330522, '68x8vacx7a', 'u5', '1of77p', 'o72ctdc', 't2__c5aa32', 1303877941);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1993-09-27', 695.452114, 200.834692, 7929158, '0v', 820970595, 'qdjpe1io2', '78507cvt', 'ptt', '6b', 't2__c5aa32', -1171104889);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1993-09-27', 813.864654, 493.191521, 1691780814, '6c4bfkfo', -1950324754, '7z2zezj', '7wgx', '5', 'sxcmr0o', 't2__ad2363', 853709925);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1993-09-27', 297.258735, 104.37745, 875300074, '3lq', 1816660482, 'npi', '5k58', 's27p2', '94gth', 't2__c5aa32', 333302050);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1993-09-27', 193.695314, 770.686956, -2136247961, 'la3', 1803796945, '8uttmu', 'ne578lfv', 'yz7zzbe8yvk', 'v42q7sx58b4p', 't2__ad2363', 319284352);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1993-09-27', 771.198983, 453.245856, -790819470, 'krpd', -609553675, 'w5chn9mo705a', '9n0jxfofwsz', 'o', '2zobb0q0k32o', 't2__c5aa32', -1898678660);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1993-09-27', 38.169466, 179.038075, 440115543, 'msorlwyngc', -323362455, 'j9erhizgk1', 'yoeyo6l0hdt6', 'uq', 'xuzkb52', 't2__ad2363', -277407746);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '1993-09-27', 343.967529, 176.569118, -2140468103, 'elboeowii', -268740517, 'nxih662q', 'xlyotow9', 'aawg', '6aqb0tbin', 't2__c5aa32', -1897615568);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-15', 466.613431, 985.521662, 2038321753, 'z9t', 748154000, 'cgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', 't2__c5aa32', -516345261);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Symptoms FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T1.Birthday = '1959-03-01' AND T2."Examination Date" = '1993-09-27';

/*
Gold Result:
('t2__c5aa32',)
('t2__c5aa32',)
('t2__c5aa32',)
('t2__c5aa32',)
('t2__ad2363',)
('t2__c5aa32',)
('t2__ad2363',)
('t2__c5aa32',)
('t2__ad2363',)
('t2__c5aa32',)
*/

-- Prediction Query
SELECT Symptoms FROM Examination WHERE ID = (SELECT ID FROM Patient WHERE Birthday = '1959-03-01') AND "Examination Date" = '1993-09-27';

/*
Prediction Result:
*/