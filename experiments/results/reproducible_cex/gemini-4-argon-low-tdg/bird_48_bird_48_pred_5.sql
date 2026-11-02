-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Filter and Join mutation test:
-- Target rows have NO matching entries in 'frpm' or 'satscores' (kills unnecessary INNER JOINs).
-- Includes non-target rows with StatusType != 'Merged' and County != 'Orange' that DO have DOC 54 and 52 (kills missing/weakened WHERE predicates or OR instead of AND).
-- Ratio for target rows is 2 / 3 = 0.6666...
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('201', 'Merged', 'Orange', 'DistA', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('202', 'Merged', 'Orange', 'DistB', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('203', 'Merged', 'Orange', 'DistC', '52', 'Elementary', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('204', 'Merged', 'Orange', 'DistD', '52', 'Elementary', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('205', 'Merged', 'Orange', 'DistE', '52', 'Elementary', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('206', 'Active', 'Orange', 'DistF', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('207', 'Active', 'Orange', 'DistG', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('208', 'Merged', 'Los Angeles', 'DistH', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('209', 'Merged', 'Los Angeles', 'DistI', '52', 'Elementary', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('210', 'Active', 'Los Angeles', 'DistJ', '54', 'Unified', '2020-01-01');
INSERT INTO frpm (CDSCode, "Academic Year", "County Name") VALUES ('206', '2013-14', 'Orange');
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('208', 'S', 100, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN DOC = 54 THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN DOC = 52 THEN 1 ELSE 0 END) FROM schools WHERE StatusType = 'Merged' AND County = 'Orange';

/*
Gold Result:
(0.6666666666666666,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN s.DOC = 54 THEN 1 END) AS REAL) / COUNT(CASE WHEN s.DOC = 52 THEN 1 END) AS ratio FROM schools AS s WHERE s.County = 'Orange';

/*
Prediction Result:
(1.3333333333333333,)
*/