-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "frpm" ("cdscode", "academic year", "county code", "district code", "school code", "county name", "district name", "school name", "district type", "school type", "educational option type", "nslp provision status", "charter school (y/n)", "charter school number", "charter funding type", "irc", "low grade", "high grade", "enrollment (k-12)", "free meal count (k-12)", "percent (%) eligible free (k-12)", "frpm count (k-12)", "percent (%) eligible frpm (k-12)", "enrollment (ages 5-17)", "free meal count (ages 5-17)", "percent (%) eligible free (ages 5-17)", "frpm count (ages 5-17)", "percent (%) eligible frpm (ages 5-17)", "2013-14 calpads fall 1 certification status") VALUES ('Fremont109', '2014-2015', '2014-201583', 84, 'Fremont85', '2014-201586', 'SSS87', 'Fremont88', '2014-201589', 'SSS90', 'Fremont91', '2014-201592', 93, 'Fremont94', '2014-201595', 96, 'Fremont97', '2014-201598', 99, 100, 101, 102, 103, -814, 104, 105, 106, 107, 108);
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('Fremont109', '2014-2015110', 'SSS111', 'Fremont112', '2014-2015113', 'SSS114', 'Fremont115', '2014-2015116', 'SSS117', 'Fremont', 'Fremont118', '2014-2015119', 'SSS120', 'Fremont121', '2014-2015122', 'SSS123', 'Fremont124', '2014-2015125', 'SSS126', 'Fremont127', '1000-05-09', '1000-05-10', 130, '2014-2015131', 'SSS132', 'Fremont133', '2014-2015134', 'SSS135', 'Fremont136', 'SSS', '2014-2015137', 'SSS138', 'Fremont139', '2014-2015140', 'SSS141', 'Fremont142', 143, 144, 145, '2014-2015146', 'SSS147', 'Fremont148', '2014-2015149', 'SSS150', 'Fremont151', '2014-2015152', 'SSS153', 'Fremont154', '1000-06-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1."Enrollment (Ages 5-17)" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.EdOpsCode = 'SSS' AND T2.City = 'Fremont' AND T1."Academic Year" BETWEEN 2014 AND 2015;

/*
Gold Result:
(-814.0,)
*/

-- Prediction Query
SELECT SUM(T1."Enrollment (Ages 5-17)") FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.City = 'Fremont' AND T2.EdOpsCode = 'SSS' AND T1."Academic Year" = '2014-2015';

/*
Prediction Result:
(-814.0,)
*/