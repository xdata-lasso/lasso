-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('30000000000001', 'Merged', 'Orange', 'Irvine Unified', 'School A', '54', 'Unified School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('30000000000002', 'Merged', 'Orange', 'Anaheim Union', 'School B', '54', 'High School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('30000000000003', 'Merged', 'Orange', 'Fullerton Elementary', 'School C', '52', 'Elementary School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('30000000000004', 'Merged', 'Orange', 'Brea Olinda', 'School D', '52', 'Elementary School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('30000000000005', 'Merged', 'Orange', 'Cypress Elementary', 'School E', '52', 'Elementary School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('30000000000006', 'Merged', 'Orange', 'OCDE', 'School F', '00', 'County Office of Education', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('30000000000007', 'Active', 'Orange', 'Tustin Unified', 'School G', '54', 'Unified School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('19000000000008', 'Merged', 'Los Angeles', 'LA Unified', 'School H', '54', 'Unified School District', '2020-01-01');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name") VALUES ('30000000000001', 'Orange', 'Irvine Unified', 'School A');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr) VALUES ('30000000000001', 'S', 'School A', 'Irvine Unified', 'Orange', 100, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN DOC = 54 THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN DOC = 52 THEN 1 ELSE 0 END) FROM schools WHERE StatusType = 'Merged' AND County = 'Orange';

/*
Gold Result:
(0.6666666666666666,)
*/

-- Prediction Query
SELECT CAST((SELECT COUNT(*) FROM schools WHERE County = 'Orange' AND DOC = 54) AS REAL) / CAST((SELECT COUNT(*) FROM schools WHERE DOC = 52) AS REAL);

/*
Prediction Result:
(1.0,)
*/