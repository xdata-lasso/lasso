-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core Positive Match & Column/Table Disambiguation
-- Tests:
-- 1. Selecting T1."School Name" vs T2.School
-- 2. Selecting T2.Zip, Street, City, State vs T2.MailZip, MailStreet, MailCity, MailState
-- 3. Filtering on T2.County vs T1."County Name"
-- 4. Filtering on T1."Free Meal Count (Ages 5-17)" vs T1."Free Meal Count (K-12)" or "FRPM Count (Ages 5-17)"
-- 5. Filtering on T1."School Type" vs T2.SOCType or T1."Educational Option Type"
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, City, Zip, State, MailStreet, MailCity, MailZip, MailState, DOC, DOCType, SOCType, LastUpdate) VALUES
('CDS101', 'Active', 'Monterey', 'Monterey Unified', 'T2_School_Wrong', '123 Main St', 'Salinas', '93901', 'CA', 'PO Box 999', 'MontereyMail', '93902', 'NV', '01', 'Unified', 'Wrong SOCType', '2023-01-01'),
('CDS102', 'Active', 'Santa Cruz', 'SC Unified', 'SC High', '456 Ocean St', 'Santa Cruz', '95060', 'CA', '456 Ocean St', 'Santa Cruz', '95060', 'CA', '01', 'Unified', 'High Schools (Public)', '2023-01-01');
INSERT INTO frpm (CDSCode, "County Name", "School Name", "School Type", "Educational Option Type", "Free Meal Count (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (Ages 5-17)", "FRPM Count (K-12)") VALUES
('CDS101', 'Wrong_T1_County', 'T1_School_Correct', 'High Schools (Public)', 'Traditional', 850.0, 500.0, 500.0, 500.0),
('CDS102', 'Monterey', 'Decoy_T1_County_School', 'High Schools (Public)', 'High Schools (Public)', 900.0, 900.0, 900.0, 900.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1."School Name", T2.Zip, T2.Street, T2.City, T2.State FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.County = 'Monterey' AND T1."Free Meal Count (Ages 5-17)" > 800 AND T1."School Type" = 'High Schools (Public)';

/*
Gold Result:
('T1_School_Correct', '93901', '123 Main St', 'Salinas', 'CA')
*/

-- Prediction Query
SELECT schools.School, schools.Street, schools.City, schools.State, schools.Zip FROM frpm INNER JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE schools.County = 'Monterey' AND schools.EILName = 'High School' AND frpm."FRPM Count (Ages 5-17)" > 800;

/*
Prediction Result:
*/