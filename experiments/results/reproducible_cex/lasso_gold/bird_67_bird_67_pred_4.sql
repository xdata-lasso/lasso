-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('both', 'situation', 'on', 'clearly', 'expert', 'father', 'point', '48740 Cynthia Village Suite 005
Lake Tina, GA 97655', '011 Amy Village Suite 982
Andersonport, MN 05730', 'San Francisco', '47399', 'Indiana', 'elizabethgomez@example.net', 'vdickson@example.org', 'michellecherry@example.org', 'vjohnson@example.com', 'vpham@example.org', '521-260-7337x543', 'receive', 'http://ramirez-jones.com/', '1976-07-07', '1989-01-01', 1013, 'have', 'put', 'Mr', 'Community College District', 'instead', 'respond', 'threat', 'Teresa Wilson', 'every', 'White', 'evidence', 'American', 'boy', 1014, 1015.5, 1016.5, 'Candace', 'Reed', 'samuel81@example.com', 'Rachel', 'Lee', 'fletcheraaron@example.net', 'Gloria', 'Bentley', 'michaeljones@example.net', '1977-08-08');
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('wife', 'give', 'price', 'former', 'record', 'thus', NULL, '465 Terry Plaza Apt. 366
New Ashley, MO 72320', '3699 Marshall Mills Apt. 872
West Zacharymouth, CO 98954', 'San Francisco', '31285', 'Utah', 'jeffrey32@example.org', 'sanchezthomas@example.org', 'operry@example.net', 'jennifercruz@example.com', 'dylanwatts@example.org', '001-763-928-7083x17278', 'position', 'https://manning.info/', '1978-09-09', '1989-01-01', 1017, 'event', 'society', 'end', 'Community College District', 'though', 'public', 'factor', 'Kelly Sims', 'face', 'Gonzales', 'sell', 'feeling', 'easy', 1018, 1019.5, 1020.5, 'Joseph', 'Flores', 'taylorjesse@example.net', 'Eric', 'Lewis', 'irussell@example.com', 'Robert', 'Clark', 'xprice@example.net', '1979-10-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(School) FROM schools WHERE STRFTIME('%Y', ClosedDate) = '1989' AND City = 'San Francisco' AND DOCType = 'Community College District';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM schools WHERE DOCType = 'Community College District' AND STRFTIME('%Y', ClosedDate) = '1989' AND City = 'San Francisco';

/*
Prediction Result:
(2,)
*/