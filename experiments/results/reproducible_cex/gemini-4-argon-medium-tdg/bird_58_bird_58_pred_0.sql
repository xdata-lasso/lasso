-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic selection, projection, and filtering against MailZip and prefix/partial Zip matches (e.g. LIKE '95203%').
INSERT INTO schools (CDSCode, StatusType, County, District, School, Zip, MailZip, Phone, Ext, DOC, DOCType, LastUpdate) VALUES ('CDS001', 'Active', 'San Joaquin', 'Stockton Unified', 'Stockton High', '95203-3704', '95202-0000', '209-555-0101', '101', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Zip, MailZip, Phone, Ext, DOC, DOCType, LastUpdate) VALUES ('CDS002', 'Active', 'San Joaquin', 'Stockton Unified', 'MailZip Match School', '95203', '95203-3704', '209-555-0102', '102', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Zip, MailZip, Phone, Ext, DOC, DOCType, LastUpdate) VALUES ('CDS003', 'Active', 'San Joaquin', 'Stockton Unified', 'Prefix Zip School', '95203-3704-99', '95200', '209-555-0103', '103', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Zip, MailZip, Phone, Ext, DOC, DOCType, LastUpdate) VALUES ('CDS004', 'Active', 'San Joaquin', 'Stockton Unified', 'Null Zip School', NULL, '95203-3704', '209-555-0104', '104', '54', 'Unified', '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Phone, Ext, School FROM schools WHERE Zip = '95203-3704';

/*
Gold Result:
('209-555-0101', '101', 'Stockton High')
*/

-- Prediction Query
SELECT T1.School, T1.Phone, T1.Ext FROM schools AS T1 WHERE T1.Zip = '95203-3704';

/*
Prediction Result:
('Stockton High', '209-555-0101', '101')
*/