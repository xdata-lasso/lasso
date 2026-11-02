-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "satscores" ("cds", "rtype", "sname", "dname", "cname", "enroll12", "numtsttakr", "avgscrread", "avgscrmath", "avgscrwrite", "numge1500") VALUES ('Ulrich73', 'Ricci64', 'Ulrich79', 'Ulrich65', 'Ricci66', 67, 68, 69, 70, NULL, 72);
INSERT INTO "satscores" ("cds", "rtype", "sname", "dname", "cname", "enroll12", "numtsttakr", "avgscrread", "avgscrmath", "avgscrwrite", "numge1500") VALUES ('Ricci130', 'Ricci120', 'Ulrich121', 'Ricci122', 'Ulrich123', 124, 125, 126, 127, NULL, 129);
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('Ricci130', 'Ulrich131', 'Ricci132', 'Ulrich133', 'Ricci134', 'Ulrich135', 'Ulrich79', 'Ricci136', NULL, 'Ricci138', 'Ulrich139', NULL, 'Ulrich141', 'Ricci142', 'Ulrich143', 'Ricci144', 'Ulrich145', NULL, NULL, NULL, '1000-05-30', '1000-05-31', 151, 'Ricci152', 'Ulrich153', 'Ricci154', 'Ulrich155', 'Ricci156', 'Ulrich157', 'Ricci158', 'Ulrich159', 'Ricci160', NULL, 'Ricci162', 'Ulrich163', NULL, NULL, 166, 167, 'Ricci', 'Ulrich', NULL, 'Ulrich169', NULL, 'Ulrich171', 'Ricci172', NULL, 'Ricci174', '1000-06-25');
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('Ulrich73', 'Ricci74', 'Ulrich75', 'Ricci76', 'Ulrich77', 'Ricci78', 'Ulrich79', 'Ricci80', 'Ulrich81', 'Ricci82', 'Ulrich83', 'Ricci84', 'Ulrich85', 'Ricci86', 'Ulrich87', 'Ricci88', 'Ulrich89', 'Ricci90', 'Ulrich91', 'Ricci92', '1000-04-04', '1000-04-05', 95, 'Ricci96', 'Ulrich97', 'Ricci98', 'Ulrich99', 'Ricci100', 'Ulrich101', 'Ricci102', 'Ulrich103', 'Ricci104', 'Ulrich105', 'Ricci106', 'Ulrich107', 'Ricci108', 109, NULL, 111, 'Ricci', 'Ulrich', 'Ricci112', 'Ulrich113', 'Ricci114', 'Ulrich115', 'Ricci116', 'Ulrich117', 'Ricci118', '1000-04-30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School, T1.AvgScrWrite FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.AdmFName1 = 'Ricci' AND T2.AdmLName1 = 'Ulrich';

/*
Gold Result:
('Ulrich79', None)
('Ulrich79', None)
*/

-- Prediction Query
SELECT T1.sname, AVG(T1.AvgScrWrite) AS AverageWritingScore FROM satscores AS T1 INNER JOIN schools AS T3 ON T1.cds = T3.CDSCode WHERE T3.AdmFName1 = 'Ricci' AND T3.AdmLName1 = 'Ulrich' GROUP BY T1.sname;

/*
Prediction Result:
('Ulrich121', None)
('Ulrich79', None)
*/