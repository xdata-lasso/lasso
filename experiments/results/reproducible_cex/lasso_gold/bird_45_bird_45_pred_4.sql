-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('kind', 'purpose', 'student', 'prevent', 'lot', 'at', 'bring', '808 Jennifer Highway Suite 095
New Robert, TN 88085', '88888 Peter Mountains Apt. 654
West Kristinastad, IA 96569', 'Port Bonniemouth', '17987', 'Arizona', 'amy27@example.net', 'zwelch@example.org', 'baldwinsherry@example.org', 'james30@example.com', 'zachary87@example.com', '8348505415', 'six', 'https://beltran-crawford.info/', '1986-02-23', '1987-03-01', 1151, 'hold', 'window', 'subject', 'natural', 'example', 'suddenly', 'beautiful', 'Angela Morrison', 'test', 'White', 'finally', 'full', 'board', 1152, 1153.5, 1154.5, 'Ricci', 'Ulrich', 'murphykenneth@example.com', 'Carrie', 'Simmons', 'cbell@example.net', 'Molly', 'Gomez', 'yhill@example.org', '1988-04-02');
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('card', 'purpose', 'student', 'prevent', 'lot', 'at', 'bring', '808 Jennifer Highway Suite 095
New Robert, TN 88085', '88888 Peter Mountains Apt. 654
West Kristinastad, IA 96569', 'Port Bonniemouth', '17987', 'Arizona', 'amy27@example.net', 'zwelch@example.org', 'baldwinsherry@example.org', 'james30@example.com', 'zachary87@example.com', '8348505415', 'six', 'https://beltran-crawford.info/', '1986-02-23', '1987-03-01', 1151, 'hold', 'window', 'subject', 'natural', 'example', 'suddenly', 'beautiful', 'Angela Morrison', 'test', 'White', 'finally', 'full', 'board', 1152, 1153.5, 1154.5, 'Ricci', 'Ulrich', 'murphykenneth@example.com', 'Carrie', 'Simmons', 'cbell@example.net', 'Molly', 'Gomez', 'yhill@example.org', '1988-04-02');
INSERT INTO "satscores" ("cds", "rtype", "sname", "dname", "cname", "enroll12", "numtsttakr", "avgscrread", "avgscrmath", "avgscrwrite", "numge1500") VALUES ('kind', 'bad', 'Jennifer Palmer', 'Caitlin Johnson', 'Megan Kim', 1155, 1156, 1157, 1158, 1159, 1160);
INSERT INTO "satscores" ("cds", "rtype", "sname", "dname", "cname", "enroll12", "numtsttakr", "avgscrread", "avgscrmath", "avgscrwrite", "numge1500") VALUES ('card', 'bad', 'Jennifer Palmer', 'Caitlin Johnson', 'Megan Kim', 1155, 1156, 1157, 1158, 1159, 1160);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School, T1.AvgScrWrite FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.AdmFName1 = 'Ricci' AND T2.AdmLName1 = 'Ulrich';

/*
Gold Result:
('bring', 1159)
('bring', 1159)
*/

-- Prediction Query
SELECT s.School, AVG(sc.AvgScrWrite) AS AvgScrWrite FROM schools AS s INNER JOIN satscores AS sc ON s.CDSCode = sc.cds WHERE s.AdmFName1 = 'Ricci' AND s.AdmLName1 = 'Ulrich' GROUP BY s.School;

/*
Prediction Result:
('bring', 1159.0)
*/