-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 'F', '1980-01-01', '2025-06-17', '2021-11-08', 'swwqcgsk', '9n8c4pgu7v');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'F', '1980-01-01', '2020-11-04', '2025-06-27', 'nw6klf', 'a9000t5c4eci');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'gce376nium52', '2024-06-13', '2020-03-30', '2023-08-27', '4nrq', 'rofqyp5s5b');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2020-12-20', 906.21648, 483.665643, -1633151678, 't2__80e62a', -252690330, 'uzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', -1576219117);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2020-04-03', 797.364011, 236.803246, 328305758, 't2__80e62a', -751275471, 'iqa', '1ryytoo', 'o9hl72kl', 'x1', 'ji7zwau2', 364869063);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2023-02-12', 262.105498, 591.461096, 2142703426, 't2__80e62a', -533293970, '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', -1612443122);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2020-04-02', 50.647649, 185.427628, 1581736075, 't2__80e62a', -261132974, 'dqwn', 'cx5hn', 'p', 'jtu0d', '79fjgq8', -1255130038);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2021-01-01', 456.127515, 52.895335, -1056308489, 't2__80e62a', -1454058168, 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 2011234363);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2021-09-25', 7.367195, 906.609226, 1360271423, 't2__80e62a', 1583472758, 'rg', 'd8y', 't1afgog', 'itsj3', 'y', -598313376);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-09-24', 917.425128, 632.340892, 804529642, 't2__3ed9fa', -1538707438, 'den8c68x', 'vacx7afu5', '1of77p', 'o72ctdc', 'mfg62', -1744557630);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-10-13', 492.883123, 691.147113, 1421303999, 't2__80e62a', -1488156735, '1i', '2278', '07cvtjpt', 'tg6bnou5zi', '6c4bfkfo', -1950324754);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-08-20', 668.776683, 517.925079, -253138337, 't2__3ed9fa', 641521863, 'o7w', 'xd', 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', -1125548818);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-01-31', 555.274052, 477.692813, -244633520, 't2__80e62a', 418247369, 'jla', 'okv8uttm', '2ne578', 'fvy', '7zzbe8y', -705922211);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-09-24', 574.117269, 445.606673, 79330142, 't2__3ed9fa', 1735561423, '58b4pmaus3a', 'vmkrpd', 'wzw', 'chn9mo70', 'a9n0jxfo', -1793230843);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-04-28', 900.422166, 55.294573, -210159774, 't2__80e62a', 270415200, 'b', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 1483450542);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2022-07-24', 514.470353, 667.211392, 1428194830, 't2__3ed9fa', -1614619556, '6fuqy', 'uzkb52', 'gwnlas6', 'elboeowii1', '5nxih66', -251205568);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-01-01', 789.706494, 680.281941, -1396673167, 'P', 412199481, 'tow9oaawg96a', 'qb0tbindz39t', 'j', '9td8n5w', 'g', -794767771);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2020-05-05', 950.098522, 714.781282, 1295379066, 't2__80e62a', 1071401016, 'w9603vz', 'xw1rxe9yfk7', 'k162n', '55', '3dohvu0', 30861410);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-06-17', 6.073642, 485.223245, 1595632888, 't2__80e62a', 2072023304, 'io18ri2hy08', 'tp', 'ewtqxxnja', 'bymzn2mfx7h3', 'p6sto1cj', 1728926031);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2."ANA Pattern" <> 'P' AND STRFTIME('%Y', T1.Birthday) BETWEEN '1980' AND '1989' AND T1.SEX = 'F';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2."ANA Pattern" <> 'P' AND T1.SEX = 'F' AND STRFTIME('%Y', T1.Birthday) BETWEEN '1980' AND '1989';

/*
Prediction Result:
(11,)
*/