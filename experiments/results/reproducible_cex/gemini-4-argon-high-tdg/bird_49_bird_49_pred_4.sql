-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO schools (CDSCode, StatusType, County, District, School, ClosedDate, DOC, DOCType, LastUpdate) VALUES ('34000010000001', 'Closed', 'Sacramento', 'Sac City Unified', 'River Oak Elementary', '2019-06-30', '54', 'Unified School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, ClosedDate, DOC, DOCType, LastUpdate) VALUES ('34000010000002', 'Closed', 'Sacramento', 'Sac City Unified', 'Capital Prep', '2020-06-30', '54', 'Unified School District', '2020-07-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, ClosedDate, DOC, DOCType, LastUpdate) VALUES ('37000010000001', 'Closed', 'San Diego', 'SD Unified', 'Harbor View School', '2018-06-30', '54', 'Unified School District', '2019-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, ClosedDate, DOC, DOCType, LastUpdate) VALUES ('37000010000002', 'Active', 'San Diego', 'SD Unified', 'Pacific Beach High', NULL, '54', 'Unified School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, ClosedDate, DOC, DOCType, LastUpdate) VALUES ('37000010000003', 'Active', 'San Diego', 'SD Unified', 'Mission Bay Academy', NULL, '54', 'Unified School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, ClosedDate, DOC, DOCType, LastUpdate) VALUES ('37000010000004', 'Active', 'San Diego', 'SD Unified', 'Coronado Middle', NULL, '54', 'Unified School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, ClosedDate, DOC, DOCType, LastUpdate) VALUES ('37000010000005', 'Active', 'San Diego', 'SD Unified', 'La Jolla Elementary', NULL, '54', 'Unified School District', '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT County, School, ClosedDate FROM schools WHERE County = (SELECT County FROM schools WHERE StatusType = 'Closed' GROUP BY County ORDER BY COUNT(School) DESC, County NULLS LAST LIMIT 1) AND StatusType = 'Closed' AND NOT school IS NULL;

/*
Gold Result:
('Sacramento', 'River Oak Elementary', '2019-06-30')
('Sacramento', 'Capital Prep', '2020-06-30')
*/

-- Prediction Query
SELECT County, School, ClosedDate FROM schools WHERE StatusType = 'Closed' AND NOT School IS NULL AND NOT ClosedDate IS NULL AND County = (SELECT County FROM schools WHERE StatusType = 'Closed' GROUP BY County ORDER BY COUNT(CDSCode) DESC, County NULLS LAST LIMIT 1) ORDER BY School, schools.cdscode NULLS LAST;

/*
Prediction Result:
('Sacramento', 'Capital Prep', '2020-06-30')
('Sacramento', 'River Oak Elementary', '2019-06-30')
*/