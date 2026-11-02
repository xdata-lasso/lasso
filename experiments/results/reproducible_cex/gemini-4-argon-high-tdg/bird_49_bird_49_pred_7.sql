-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, ClosedDate, OpenDate, DOC, DOCType, LastUpdate) VALUES ('19000010000001', 'Closed', 'Los Angeles', 'LA Unified', 'Alpha High', '2018-06-30', '1990-09-01', '54', 'Unified School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, ClosedDate, OpenDate, DOC, DOCType, LastUpdate) VALUES ('19000010000002', 'Closed', 'Los Angeles', 'LA Unified', 'Beta High', '2019-06-30', '1995-09-01', '54', 'Unified School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, ClosedDate, OpenDate, DOC, DOCType, LastUpdate) VALUES ('19000010000003', 'Closed', 'Los Angeles', 'LA Unified', 'Gamma High', '2020-06-30', '2000-09-01', '54', 'Unified School District', '2020-07-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, ClosedDate, OpenDate, DOC, DOCType, LastUpdate) VALUES ('19000010000004', 'Active', 'Los Angeles', 'LA Unified', 'Delta High', NULL, '2005-09-01', '54', 'Unified School District', '2020-07-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, ClosedDate, OpenDate, DOC, DOCType, LastUpdate) VALUES ('19000010000005', 'Closed', 'Los Angeles', 'LA Unified', NULL, '2017-06-30', '1980-09-01', '54', 'Unified School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, ClosedDate, OpenDate, DOC, DOCType, LastUpdate) VALUES ('30000010000001', 'Closed', 'Orange', 'Irvine Unified', 'Epsilon High', '2016-06-30', '1985-09-01', '54', 'Unified School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, ClosedDate, OpenDate, DOC, DOCType, LastUpdate) VALUES ('30000010000002', 'Closed', 'Orange', 'Irvine Unified', 'Zeta High', '2015-06-30', '1988-09-01', '54', 'Unified School District', '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT County, School, ClosedDate FROM schools WHERE County = (SELECT County FROM schools WHERE StatusType = 'Closed' GROUP BY County ORDER BY COUNT(School) DESC, County NULLS LAST LIMIT 1) AND StatusType = 'Closed' AND NOT school IS NULL;

/*
Gold Result:
('Los Angeles', 'Alpha High', '2018-06-30')
('Los Angeles', 'Beta High', '2019-06-30')
('Los Angeles', 'Gamma High', '2020-06-30')
*/

-- Prediction Query
SELECT s.county, s.school, s.closeddate FROM schools AS s JOIN (SELECT county, COUNT(cdscode) AS closed_count FROM schools WHERE statustype = 'Closed' GROUP BY county ORDER BY closed_count DESC, county NULLS LAST LIMIT 1) AS top_county ON s.county = top_county.county WHERE s.statustype = 'Closed';

/*
Prediction Result:
('Los Angeles', 'Alpha High', '2018-06-30')
('Los Angeles', 'Beta High', '2019-06-30')
('Los Angeles', 'Gamma High', '2020-06-30')
('Los Angeles', None, '2017-06-30')
*/