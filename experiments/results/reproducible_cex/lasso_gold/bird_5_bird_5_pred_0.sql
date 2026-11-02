-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('step', 'only', 'recently', 'serious', 'message', 'clear', 'customer', '805 Brendan Neck
North Susan, CO 24857', '361 Beth Canyon
South Dianeshire, NC 41968', 'Jamesmouth', '31786', 'Kentucky', 'panderson@example.com', 'wstewart@example.org', 'ellisyolanda@example.org', 'medinawilliam@example.org', 'nicole35@example.com', '(378)449-8084', 'everything', 'http://www.tran.com/', '1976-07-07', '1977-08-08', 1019, 'Democrat', 'right', 'protect', 'tonight', 'mouth', 'middle', 'enter', 'Sarah Davis', 'land', 'Calderon', 'another', 'about', 'F', 1020, 1021.5, 1022.5, 'Matthew', 'Anderson', 'evan78@example.net', 'Ronald', 'Smith', 'landryhannah@example.org', 'Amy', 'Davenport', 'russellwilliams@example.com', '1978-09-09');
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('pressure', 'so', 'wish', 'wonder', 'economic', 'treatment', 'customer', '0256 Joseph Turnpike
South Monicafort, IN 26659', '4330 Raymond Harbors Apt. 458
Frazierside, MA 04118', 'West Gregoryview', '05515', 'Connecticut', 'yreed@example.com', 'gobrien@example.org', 'mlam@example.com', 'fletcheraaron@example.net', 'michaeljones@example.net', '895-814-8465x64823', 'research', 'http://kelley-smith.com/', '1979-10-10', '1980-11-11', 1028, 'develop', 'law', 'stock', 'particularly', 'policy', 'real', 'fund', 'Jeremy Lewis', 'material', 'Leon', 'style', 'simply', 'F', 1029, 1030.5, 1031.5, 'Gene', 'Miller', 'clarence34@example.org', 'Lindsay', 'Hernandez', 'sanchezthomas@example.org', 'Stanley', 'Mercado', 'jennifercruz@example.com', '1981-01-12');
INSERT INTO "satscores" ("cds", "rtype", "sname", "dname", "cname", "enroll12", "numtsttakr", "avgscrread", "avgscrmath", "avgscrwrite", "numge1500") VALUES ('step', 'way', 'Valerie Williams', 'Michael Estrada', 'Justin Baxter', 1023, 1024, 1025, 399, 1026, 1027);
INSERT INTO "satscores" ("cds", "rtype", "sname", "dname", "cname", "enroll12", "numtsttakr", "avgscrread", "avgscrmath", "avgscrwrite", "numge1500") VALUES ('pressure', 'either', 'Michael Stafford', 'Stacey Osborne', 'Robert Dominguez', 1032, 1033, 1034, 399, 1035, 1036);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.School) FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.Virtual = 'F' AND T1.AvgScrMath < 400;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.CDSCode) FROM schools AS T1 INNER JOIN satscores AS T2 ON T1.CDSCode = T2.cds WHERE T2.AvgScrMath < 400 AND T1.Virtual = 'F';

/*
Prediction Result:
(2,)
*/