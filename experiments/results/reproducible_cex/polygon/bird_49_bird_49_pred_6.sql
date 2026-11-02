-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('Closed49', 'Closed54', 'Closed54', 'Closed51', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', '1000-02-24', '1000-02-24', 54, 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 54, 54, 54, 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', 'Closed54', '1000-02-24');
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('Closed50', 'Closed52', 'Closed53', 'Closed', 'Closed54', 'Closed55', 'Closed56', 'Closed57', 'Closed58', 'Closed59', 'Closed60', 'Closed61', 'Closed62', 'Closed63', 'Closed64', 'Closed65', 'Closed66', 'Closed67', 'Closed68', 'Closed69', '1000-03-12', '1000-03-13', 72, 'Closed73', 'Closed74', 'Closed75', 'Closed76', 'Closed77', 'Closed78', 'Closed79', 'Closed80', 'Closed81', 'Closed82', 'Closed83', 'Closed84', 'Closed85', 86, 87, 88, 'Closed89', 'Closed90', 'Closed91', 'Closed92', 'Closed93', 'Closed94', 'Closed95', 'Closed96', 'Closed97', '1000-04-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT County, School, ClosedDate FROM schools WHERE County = (SELECT County FROM schools WHERE StatusType = 'Closed' GROUP BY County ORDER BY COUNT(School) DESC, County NULLS LAST LIMIT 1) AND StatusType = 'Closed' AND NOT school IS NULL;

/*
Gold Result:
('Closed54', 'Closed56', '1000-03-13')
*/

-- Prediction Query
SELECT T1.County, T1.School, T1.ClosedDate FROM schools AS T1 WHERE T1.StatusType = 'Closed' GROUP BY T1.County ORDER BY COUNT(T1.School) DESC, T1.County NULLS LAST, T1.School NULLS LAST, T1.ClosedDate NULLS LAST LIMIT 1;

/*
Prediction Result:
('Closed54', 'Closed56', '1000-03-13')
*/