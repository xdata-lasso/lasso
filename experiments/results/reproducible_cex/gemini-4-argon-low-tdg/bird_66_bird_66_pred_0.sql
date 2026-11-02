-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests date boundaries (inclusive bounds, off-by-one years, string vs date comparison), NULL OpenDate, and ClosedDate confusion
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, FundingType, DOC, DOCType, LastUpdate) VALUES ('101', 'Active', 'Stanislaus', 'Dist1', 'School 1999', '1999-12-31', '2002-05-01', 'Directly funded', '50', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, FundingType, DOC, DOCType, LastUpdate) VALUES ('102', 'Active', 'Stanislaus', 'Dist1', 'School 2000 Start', '2000-01-01', '1999-01-01', 'Directly funded', '50', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, FundingType, DOC, DOCType, LastUpdate) VALUES ('103', 'Active', 'Stanislaus', 'Dist1', 'School 2003 Mid', '2003-06-15', '2006-06-15', 'Directly funded', '50', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, FundingType, DOC, DOCType, LastUpdate) VALUES ('104', 'Active', 'Stanislaus', 'Dist1', 'School 2005 Start', '2005-01-01', '2006-01-01', 'Directly funded', '50', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, FundingType, DOC, DOCType, LastUpdate) VALUES ('105', 'Active', 'Stanislaus', 'Dist1', 'School 2005 End', '2005-12-31', '2006-12-31', 'Directly funded', '50', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, FundingType, DOC, DOCType, LastUpdate) VALUES ('106', 'Active', 'Stanislaus', 'Dist1', 'School 2006 Start', '2006-01-01', '2003-01-01', 'Directly funded', '50', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, FundingType, DOC, DOCType, LastUpdate) VALUES ('107', 'Active', 'Stanislaus', 'Dist1', 'School Null Date', NULL, '2003-01-01', 'Directly funded', '50', 'Unified', '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(School) FROM schools WHERE STRFTIME('%Y', OpenDate) BETWEEN '2000' AND '2005' AND County = 'Stanislaus' AND FundingType = 'Directly funded';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM schools WHERE County = 'Stanislaus' AND FundingType = 'Directly Funded' AND OpenDate BETWEEN '2000-01-01' AND '2005-12-31';

/*
Prediction Result:
(0,)
*/