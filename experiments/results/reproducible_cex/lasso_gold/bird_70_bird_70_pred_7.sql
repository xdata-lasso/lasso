-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('purpose', 'ago', 'face', 'Closed', 'Alpine', 'dog', 'since', '600 Jeffery Parkways
New Jamesside, MT 29394', '1849 Ray Squares
North Donnaport, CO 31013', 'Lake Mark', '53082', 'California', 'jason76@example.net', 'julie69@example.com', 'camposmichelle@example.org', 'djames@example.net', 'kayla51@example.com', '001-248-728-1489x3252', 'receive', 'http://brennan.net/', '1970-01-01', '1972-03-03', 1001, 'we', 'live', 'end', 'attack', 'against', 'once', 'discussion', 'Mark Perez', 'economy', 'Caldwell', 'cause', 'worry', 'own', 1003, 1005.5, 1007.5, 'Thomas', 'Aguirre', 'hopkinsmichael@example.com', 'Denise', 'Brown', 'wrightjames@example.com', 'Nancy', 'Morton', 'williamsyvette@example.org', '1974-05-05');
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('brother', 'site', 'election', 'Active', 'Alpine', 'chair', 'blue', '26542 Susan Junction Apt. 161
Melanieview, AS 06196', '7525 Clark Grove Apt. 928
East Steven, KY 84387', 'East Lydiamouth', '35594', 'Indiana', 'ithomas@example.org', 'jeffrey28@example.com', 'laurahenderson@example.org', 'tasha01@example.net', 'amoore@example.net', '401.454.3039x1171', 'may', 'http://carney-santos.info/', '1970-01-02', '1972-03-04', 1048.0, 'nation', 'camera', 'down', 'ground', 'per', 'drug', 'account', 'Shannon Jones', 'family', 'Lewis', 'several', 'us', 'part', 1078.0, 1082.5, 1086.5, 'Kristen', 'Lee', 'dshields@example.net', 'Debbie', 'Chandler', 'robertramirez@example.org', 'Charles', 'Chase', 'housemelinda@example.org', '1974-05-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(School) FROM schools WHERE (StatusType = 'Closed' OR StatusType = 'Active') AND County = 'Alpine';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(CDSCode) FROM schools WHERE County = 'Alpine' AND StatusType IN ('Closed', 'Active') AND SOCType = 'District Community Day Schools';

/*
Prediction Result:
(0,)
*/