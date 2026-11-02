-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, OpenDate, ClosedDate, DOC, DOCType, LastUpdate) VALUES ('38000060000001', 'Closed', 'San Francisco', 'SF CCD', NULL, 'San Francisco', '1970-01-01', '1989-03-15', '68', 'Community College District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, OpenDate, ClosedDate, DOC, DOCType, LastUpdate) VALUES ('38000060000002', 'Closed', 'San Francisco', 'SF CCD', 'Valid School 1', 'San Francisco', '1970-01-01', '1989-08-20', '68', 'Community College District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, OpenDate, ClosedDate, DOC, DOCType, LastUpdate) VALUES ('38000060000003', 'Closed', 'San Francisco', 'SF CCD', 'Valid School 2', 'San Francisco', '1970-01-01', '1989-11-11', '68', 'Community College District', '2020-01-01');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "District Type") VALUES ('38000060000001', 'San Francisco', 'SF CCD', 'FRPM School', 'Community College District');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "District Type") VALUES ('38000060000002', 'San Francisco', 'SF CCD', NULL, 'Community College District');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "District Type") VALUES ('38000060000003', 'San Francisco', 'SF CCD', NULL, 'Community College District');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr) VALUES ('38000060000001', 'S', 'SAT School', 'SF CCD', 'San Francisco', 150, 80);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr) VALUES ('38000060000002', 'S', NULL, 'SF CCD', 'San Francisco', 150, 80);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr) VALUES ('38000060000003', 'S', NULL, 'SF CCD', 'San Francisco', 150, 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(School) FROM schools WHERE STRFTIME('%Y', ClosedDate) = '1989' AND City = 'San Francisco' AND DOCType = 'Community College District';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) AS ClosureCount FROM schools WHERE StatusType = 'Closed' AND DOCType = 'Community College District' AND City = 'San Francisco' AND STRFTIME('%Y', ClosedDate) = '1989';

/*
Prediction Result:
(3,)
*/