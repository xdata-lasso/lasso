-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: schools --
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('sat_6b6ed4', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', '2024-12-21', '2021-11-06', -1390245819, 'x14ji7zwau2d', 'yrq13p', 'u78d99r', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', 722884590, 635.267184, 210.05299, 'rjtu', 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', '2021-09-12');

INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('C', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', '2022-02-07', '2023-01-12', 983324983, 'ztdg', '5i3', 'q5l', 'pim5', '58q', 's27p2r94gth2', 'najj', 'a3o', 'v8u', 'tmu2n', '57', 'lfvyz7zzb', '8y', -705922211, 743.007715, 574.117269, 'q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', 'a9n0jxfofws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '2020-10-18');

INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('sat_d8c786', 'as6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', '2020-03-05', '2024-03-23', 462225708, 'n2mfx7h', '3p6sto1c', '8sh', 'knzys7dy', 'yd1jmgjach8', 'qta8y3a17v4y', 'ma', 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', -1872934808, 40.211911, 598.265359, '9', 'i9f2ccukjq1q', 'ik1yhb', '8hlst1p', 'qomiztvb6m', 'iz78aqql', 'd8ftb8', '9114q', 'r', '2020-10-13');

-- Inserting into table: satscores --
INSERT INTO "satscores" ("cds", "rtype", "sname", "dname", "cname", "enroll12", "numtsttakr", "avgscrread", "avgscrmath", "avgscrwrite", "numge1500") VALUES ('sat_6b6ed4', 'ai5', 'sat_89398f', 'h', 'Contra Costa', 1583472758, 1, 1449284300, -977470238, -1478247928, 1074760385);

INSERT INTO "satscores" ("cds", "rtype", "sname", "dname", "cname", "enroll12", "numtsttakr", "avgscrread", "avgscrmath", "avgscrwrite", "numge1500") VALUES ('C', 'rhizgk1yoey', 'sat_89398f', 'o6l0hdt6fu', 'Contra Costa', -477129795, 1, -1418927432, -30041412, -277407746, -670154354);

INSERT INTO "satscores" ("cds", "rtype", "sname", "dname", "cname", "enroll12", "numtsttakr", "avgscrread", "avgscrmath", "avgscrwrite", "numge1500") VALUES ('sat_d8c786', '6bjeuuwsj8k', 'sat_e0ab98', 'h85', 'Contra Costa', -609840352, 1, 486475144, -679850352, 1205111943, -459075802);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sname FROM satscores WHERE cname = 'Contra Costa' AND NOT sname IS NULL ORDER BY NumTstTakr DESC, satscores.cds NULLS LAST LIMIT 1;

/*
Gold Result:
('sat_89398f',)
*/

-- Prediction Query
SELECT sname, numtsttakr FROM satscores WHERE cname = 'Contra Costa' AND numtsttakr = (SELECT MAX(numtsttakr) FROM satscores WHERE cname = 'Contra Costa');

/*
Prediction Result:
('sat_89398f', 1)
('sat_89398f', 1)
('sat_e0ab98', 1)
*/