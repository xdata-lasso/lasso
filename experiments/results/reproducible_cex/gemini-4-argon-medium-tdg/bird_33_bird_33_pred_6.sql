-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for BETWEEN 1900 AND 2000 (inclusive vs exclusive), just outside boundaries, and NULL handling for both the numeric range and Website column.
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS001', 'Active', 'Alameda', 'Dist1', 'Schools_Name_1', 'http://school1.edu', '01', 'DocA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS002', 'Active', 'Alameda', 'Dist1', 'Schools_Name_2', 'http://school2.edu', '01', 'DocA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS003', 'Active', 'Alameda', 'Dist1', 'Schools_Name_3', 'http://school3.edu', '01', 'DocA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS004', 'Active', 'Alameda', 'Dist1', 'Schools_Name_4', 'http://school4.edu', '01', 'DocA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS005', 'Active', 'Alameda', 'Dist1', 'Schools_Name_5', 'http://school5.edu', '01', 'DocA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS006', 'Active', 'Alameda', 'Dist1', 'Schools_Name_6', NULL, '01', 'DocA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS007', 'Active', 'Alameda', 'Dist1', 'Schools_Name_7', 'http://school7.edu', '01', 'DocA', '2020-01-01');
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (Ages 5-17)") VALUES ('CDS001', 'FRPM_School_1900', 1900.0, 500.0, 500.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (Ages 5-17)") VALUES ('CDS002', 'FRPM_School_2000', 2000.0, 500.0, 500.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (Ages 5-17)") VALUES ('CDS003', 'FRPM_School_1950', 1950.0, 500.0, 500.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (Ages 5-17)") VALUES ('CDS004', 'FRPM_School_1899', 1899.9, 1950.0, 1950.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (Ages 5-17)") VALUES ('CDS005', 'FRPM_School_2001', 2000.1, 1950.0, 1950.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (Ages 5-17)") VALUES ('CDS006', 'FRPM_School_NullWeb', 1950.0, 1950.0, 1950.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (Ages 5-17)") VALUES ('CDS007', 'FRPM_School_NullCount', NULL, 1950.0, 1950.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Website, T1."School Name" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1."Free Meal Count (Ages 5-17)" BETWEEN 1900 AND 2000 AND NOT T2.Website IS NULL;

/*
Gold Result:
('http://school1.edu', 'FRPM_School_1900')
('http://school2.edu', 'FRPM_School_2000')
('http://school3.edu', 'FRPM_School_1950')
*/

-- Prediction Query
SELECT T2.Website, T2.School FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1."Free Meal Count (Ages 5-17)" BETWEEN 1900 AND 2000;

/*
Prediction Result:
('http://school1.edu', 'Schools_Name_1')
('http://school2.edu', 'Schools_Name_2')
('http://school3.edu', 'Schools_Name_3')
(None, 'Schools_Name_6')
*/