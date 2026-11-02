-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core Predicate & Boundary Testing:
-- Row 1: Exact match for all predicates. Also differentiates similar columns (School Name vs School, County vs County Name, Free Meal Count Ages 5-17 vs K-12 vs FRPM Count, Mail address vs physical address).
-- Row 2: Boundary test for "Free Meal Count (Ages 5-17)" = 800 (should fail > 800).
-- Row 3: County predicate test (T2.County != 'Monterey', even though T1."County Name" = 'Monterey').
-- Row 4: School Type predicate test (T1."School Type" != 'High Schools (Public)', even though T2.SOCType = 'High Schools (Public)').
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, City, Zip, State, MailStreet, MailCity, MailZip, MailState, DOC, DOCType, SOCType, LastUpdate) VALUES
('CDS001', 'Active', 'Monterey', 'Dist1', 'Schools Table Name 1', '123 Main St', 'Salinas', '93901', 'CA', 'PO Box 1', 'MailCity1', '99991', 'NV', '00', 'District', 'Other Type', '2020-01-01'),
('CDS002', 'Active', 'Monterey', 'Dist1', 'Schools Table Name 2', '456 Oak St', 'Salinas', '93902', 'CA', 'PO Box 2', 'MailCity2', '99992', 'NV', '00', 'District', 'High Schools (Public)', '2020-01-01'),
('CDS003', 'Active', 'Santa Cruz', 'Dist2', 'Schools Table Name 3', '789 Pine St', 'watsonville', '95076', 'CA', 'PO Box 3', 'MailCity3', '99993', 'NV', '00', 'District', 'High Schools (Public)', '2020-01-01'),
('CDS004', 'Active', 'Monterey', 'Dist1', 'Schools Table Name 4', '101 Maple St', 'Monterey', '93940', 'CA', 'PO Box 4', 'MailCity4', '99994', 'NV', '00', 'District', 'High Schools (Public)', '2020-01-01');
INSERT INTO frpm (CDSCode, "County Name", "School Name", "School Type", "Educational Option Type", "Free Meal Count (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (Ages 5-17)", "FRPM Count (K-12)") VALUES
('CDS001', 'Not Monterey', 'FRPM School Name 1', 'High Schools (Public)', 'Other Option', 800.5, 500.0, 500.0, 500.0),
('CDS002', 'Monterey', 'FRPM School Name 2', 'High Schools (Public)', 'High Schools (Public)', 800.0, 900.0, 900.0, 900.0),
('CDS003', 'Monterey', 'FRPM School Name 3', 'High Schools (Public)', 'High Schools (Public)', 950.0, 950.0, 950.0, 950.0),
('CDS004', 'Monterey', 'FRPM School Name 4', 'Elementary Schools (Public)', 'High Schools (Public)', 950.0, 950.0, 950.0, 950.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1."School Name", T2.Zip, T2.Street, T2.City, T2.State FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.County = 'Monterey' AND T1."Free Meal Count (Ages 5-17)" > 800 AND T1."School Type" = 'High Schools (Public)';

/*
Gold Result:
('FRPM School Name 1', '93901', '123 Main St', 'Salinas', 'CA')
*/

-- Prediction Query
SELECT T1.School, T1.Street, T1.City, T1.State, T1.Zip FROM schools AS T1 JOIN frpm AS T2 ON T1.CDSCode = T2.CDSCode WHERE COALESCE(T2."Free Meal Count (Ages 5-17)", 0) > 800 AND T1.City = 'Monterey' AND T2."School Type" = 'High School';

/*
Prediction Result:
*/