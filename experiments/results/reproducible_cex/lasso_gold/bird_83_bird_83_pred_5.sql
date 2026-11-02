-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('idea', 'morning', 'news', 'kid', 'color', 'technology', 'decision', '0758 Jennifer Path
West Christopherburgh, KY 59394', 'PSC 2613, Box 7506
APO AE 52465', 'K-8', '66300', 'Kansas', 'xvang@example.org', 'florescory@example.net', 'lacey20@example.com', 'ihorton@example.net', 'awest@example.org', '6435289861', 'fish', 'http://www.barnes.info/', '1977-04-14', '1978-05-15', 1203, 'at', 'bring', 'think', 'west', 'money', 'picture', 'north', 'Jose Allen', 'charge', 'Carter', 'father', 'ability', 'possible', 1, 1204.5, 1205.5, 'Michael', 'Duncan', 'elizabethmiller@example.com', 'Carlos', 'Fox', 'myerstheodore@example.net', 'Paul', 'Brooks', 'kellycarlos@example.org', '1979-06-16');
INSERT INTO "frpm" ("cdscode", "academic year", "county code", "district code", "school code", "county name", "district name", "school name", "district type", "school type", "educational option type", "nslp provision status", "charter school (y/n)", "charter school number", "charter funding type", "irc", "low grade", "high grade", "enrollment (k-12)", "free meal count (k-12)", "percent (%) eligible free (k-12)", "frpm count (k-12)", "percent (%) eligible frpm (k-12)", "enrollment (ages 5-17)", "free meal count (ages 5-17)", "percent (%) eligible free (ages 5-17)", "frpm count (ages 5-17)", "percent (%) eligible frpm (ages 5-17)", "2013-14 calpads fall 1 certification status") VALUES ('idea', 'significant', 'sport', 1206, 'party', 'Evelyn Williams', 'Robin Thompson', 'Julie Dominguez', 'program', 'court', 'talk', 'Multiple Provision Types', 1207, 'sense', 'yet', 1208, 'lot', 'although', 1209.5, 1210.5, 1211.5, 1212.5, 1213.5, 1214.5, 1215.5, 1216.5, 1217.5, 1218.5, 1219);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.City, COUNT(T2.CDSCode) FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.Magnet = 1 AND T2.GSoffered = 'K-8' AND T1."NSLP Provision Status" = 'Multiple Provision Types' GROUP BY T2.City;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(T1.CDSCode), T2.City FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1."NSLP Provision Status" = 'Multiple Provision Types' AND T2.Magnet = 1 GROUP BY T2.City;

/*
Prediction Result:
(1, 'K-8')
*/