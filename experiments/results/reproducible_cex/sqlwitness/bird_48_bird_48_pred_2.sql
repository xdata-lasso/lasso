-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO schools (cdscode, ncesdist, ncesschool, statustype, county, district, school, street, streetabr, city, zip, state, mailstreet, mailstrabr, mailcity, mailzip, mailstate, phone, ext, website, opendate, closeddate, charter, charternum, fundingtype, doc, doctype, soc, soctype, edopscode, edopsname, eilcode, eilname, gsoffered, gsserved, "virtual", magnet, latitude, longitude, admfname1, admlname1, admemail1, admfname2, admlname2, admemail2, admfname3, admlname3, admemail3, lastupdate) VALUES ('default2', 'Orange', '54', 'default2', 'default1', '54', 'Merged', 'default1', 'default1', 'default2', 'default1', 'Orange', 'Orange', 'default1', 'Orange', '52', '52', 'default1', '54', 'Orange', '2023-01-02', '2023-01-02', 51, 'Orange', 'default2', '54', '52', '54', '52', 'default1', 'Merged', 'Orange', 'Merged', 'default2', '52', 'Merged', 1, 53.0, 2.0, 'Merged', '52', '54', 'default2', 'default1', 'Orange', '54', '54', 'default2', '2054-11-01'), ('Merged', '54', '54', 'default1', 'default1', 'Merged', 'default1', 'Orange', 'Orange', 'Orange', 'Merged', 'default1', '54', 'default1', '54', 'Orange', '54', '52', '52', 'default2', '2023-01-02', '2054-11-01', 55, 'Merged', NULL, 'Merged', '54', NULL, 'default2', 'default1', 'default1', 'default2', 'default1', '52', '52', 'Orange', NULL, 0.0, NULL, '54', 'Orange', 'default1', 'Merged', '52', '52', '52', '52', 'Orange', '2054-11-01'), ('Orange', 'default2', 'default2', 'default1', '52', 'default1', 'Merged', '52', 'Merged', '54', '52', '52', 'Merged', 'Merged', 'default2', 'Merged', 'default2', NULL, 'default2', 'Merged', '2054-11-01', '2054-11-01', 53, 'Orange', 'default1', '54', '54', 'Orange', 'Orange', '52', '52', 'default2', 'Merged', 'default2', NULL, '54', 52, 53.0, 55.0, 'Merged', 'default1', '52', 'default2', NULL, NULL, 'Merged', 'Orange', NULL, '2054-11-01'), ('52', NULL, '52', 'default2', 'Orange', '52', NULL, 'Orange', '54', '54', 'default1', '54', 'Orange', '52', '52', 'Merged', 'Orange', NULL, 'Orange', 'Orange', '2023-01-01', '2023-01-02', -1, 'Orange', 'default2', '52', '54', '52', 'default2', 'default1', 'default2', '52', 'Merged', 'default1', 'default2', '54', 53, 0.0, 53.0, 'Orange', '54', 'default1', 'Merged', '52', 'Merged', '52', 'Orange', 'default2', '2054-11-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN DOC = 54 THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN DOC = 52 THEN 1 ELSE 0 END) FROM schools WHERE StatusType = 'Merged' AND County = 'Orange';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT (SELECT COUNT(*) FROM schools WHERE "county" = 'Orange' AND "doc" = '54') * 1.0 / (SELECT COUNT(*) FROM schools WHERE "county" = 'Orange' AND "doc" = '52') AS ratio;

/*
Prediction Result:
(0.0,)
*/