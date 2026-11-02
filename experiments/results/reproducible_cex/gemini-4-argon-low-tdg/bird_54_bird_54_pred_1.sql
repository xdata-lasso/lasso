-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core test: Evaluates logical AND vs OR, column swapping (Zip vs MailZip, Adm1 vs Adm2/Adm3, FName vs LName), and missing inner joins with frpm/satscores.
INSERT INTO schools (CDSCode, StatusType, County, District, School, Zip, MailZip, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('10000000000001', 'Active', 'Los Angeles', 'LA Unified', 'Target High School', '90001', '90002-1234', '54', 'Unified', 'Avetik', 'Atoian', 'John', 'Doe', 'Jane', 'Smith', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Zip, MailZip, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('10000000000002', 'Active', 'Los Angeles', 'LA Unified', 'Only First Name Match', '90003', '90004', '54', 'Unified', 'Avetik', 'Smith', 'Avetik', 'Atoian', 'Jane', 'Doe', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Zip, MailZip, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('10000000000003', 'Active', 'Los Angeles', 'LA Unified', 'Only Last Name Match', '90005', '90006', '54', 'Unified', 'John', 'Atoian', 'Jane', 'Doe', 'Avetik', 'Atoian', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Zip, MailZip, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('10000000000004', 'Active', 'Los Angeles', 'LA Unified', 'Swapped First Last Match', '90007', '90008', '54', 'Unified', 'Atoian', 'Avetik', 'John', 'Doe', 'Jane', 'Smith', '2023-01-01');
INSERT INTO frpm (CDSCode, "School Name") VALUES ('10000000000002', 'Only First Name Match FRPM');
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr) VALUES ('10000000000002', 'S', 'Only First Name Match SAT', 100, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT School, MailZip FROM schools WHERE AdmFName1 = 'Avetik' AND AdmLName1 = 'Atoian';

/*
Gold Result:
('Target High School', '90002-1234')
*/

-- Prediction Query
SELECT T1.School, T1.MailZip FROM schools AS T1 JOIN frpm AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1.AdmFName1 = 'Avetik' AND T1.AdmLName1 = 'Atoian';

/*
Prediction Result:
*/