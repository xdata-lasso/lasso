-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('smile', 'contain', 'outside', 'Merged', 'Orange', 'into', 'these', '9957 Ramos Forest
Leonburgh, TN 11615', '63287 Angela Vista
South Dennismouth, TN 70117', 'Colebury', '64018', 'Kansas', 'sjones@example.org', 'jessebenson@example.net', 'nperry@example.com', 'gateskathy@example.com', 'acastaneda@example.net', '2658627298', 'generation', 'https://juarez-gray.biz/', '1982-02-13', '1984-04-15', 1017, 'door', 'authority', '52', 'reach', 'somebody', 'end', 'those', 'Cynthia Wells', 'establish', 'Wood', 'small', 'building', 'tell', 1019, 1021.5, 1023.5, 'Tami', 'Johnson', 'tsanders@example.org', 'Curtis', 'Jefferson', 'hoganashlee@example.org', 'Deborah', 'Fisher', 'oyu@example.com', '1986-06-17');
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('weight', 'power', 'fish', 'Merged', 'Orange', 'official', 'a', '34332 Brandon Mountains Apt. 769
Lake Heather, NM 52884', 'Unit 9579 Box 8687
DPO AE 97973', 'Katiehaven', '82650', 'Louisiana', 'matthew81@example.org', 'calebrussell@example.net', 'lstein@example.net', 'wsmith@example.com', 'tracynelson@example.com', '001-690-816-2720', 'development', 'https://www.smith-ryan.com/', '1982-02-14', '1984-04-16', 1064.0, 'rate', 'statement', '54', 'amount', 'allow', 'decision', 'again', 'Travis Marshall', 'speak', 'Obrien', 'serious', 'star', 'common', 1094.0, 1098.5, 1102.5, 'Daniel', 'Collins', 'vargasmaria@example.org', 'Kendra', 'Burke', 'amanda51@example.net', 'Alexander', 'Henry', 'ryangross@example.net', '1986-06-18');
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('expect', 'contain', 'outside', 'Merged', 'Orange', 'into', 'these', '9957 Ramos Forest
Leonburgh, TN 11615', '63287 Angela Vista
South Dennismouth, TN 70117', 'Colebury', '64018', 'Kansas', 'sjones@example.org', 'jessebenson@example.net', 'nperry@example.com', 'gateskathy@example.com', 'acastaneda@example.net', '2658627298', 'generation', 'https://juarez-gray.biz/', '1982-02-13', '1984-04-15', 1017, 'door', 'authority', '52', 'reach', 'somebody', 'end', 'those', 'Cynthia Wells', 'establish', 'Wood', 'small', 'building', 'tell', 1019, 1021.5, 1023.5, 'Tami', 'Johnson', 'tsanders@example.org', 'Curtis', 'Jefferson', 'hoganashlee@example.org', 'Deborah', 'Fisher', 'oyu@example.com', '1986-06-17');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN DOC = 54 THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN DOC = 52 THEN 1 ELSE 0 END) FROM schools WHERE StatusType = 'Merged' AND County = 'Orange';

/*
Gold Result:
(0.5,)
*/

-- Prediction Query
SELECT (SELECT COUNT(*) FROM schools WHERE DOC = 54 AND County = 'Orange') / (SELECT COUNT(*) FROM schools WHERE DOC = 52 AND County = 'Orange') AS Ratio;

/*
Prediction Result:
(0,)
*/