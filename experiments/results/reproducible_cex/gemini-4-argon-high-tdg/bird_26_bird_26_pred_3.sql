-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, City, Zip, State, MailStreet, MailStrAbr, MailCity, MailZip, MailState, DOC, DOCType, SOCType, LastUpdate) VALUES ('CDS001', 'Active', 'Monterey', 'Monterey Peninsula Unified', 'Monterey High (Schools)', '100 Main Street', '100 Main St', 'Monterey', '93940', 'CA', 'PO Box 100', 'POB 100', 'Salinas', '93901', 'NV', '54', 'Unified School District', 'High Schools (Public)', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, City, Zip, State, MailStreet, MailStrAbr, MailCity, MailZip, MailState, DOC, DOCType, SOCType, LastUpdate) VALUES ('CDS002', 'Active', 'Monterey', 'Monterey Peninsula Unified', 'Boundary High', '200 Oak Avenue', '200 Oak Ave', 'Monterey', '93940', 'CA', '200 Oak Avenue', '200 Oak Ave', 'Monterey', '93940', 'CA', '54', 'Unified School District', 'High Schools (Public)', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, City, Zip, State, MailStreet, MailStrAbr, MailCity, MailZip, MailState, DOC, DOCType, SOCType, LastUpdate) VALUES ('CDS003', 'Active', 'Santa Cruz', 'Monterey', 'Wrong County High', '300 Pine Road', '300 Pine Rd', 'Monterey', '95060', 'CA', '300 Pine Road', '300 Pine Rd', 'Monterey', '95060', 'CA', '54', 'Unified School District', 'High Schools (Public)', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, City, Zip, State, MailStreet, MailStrAbr, MailCity, MailZip, MailState, DOC, DOCType, SOCType, LastUpdate) VALUES ('CDS004', 'Active', 'Monterey', 'Salinas Union', 'Junior High School', '400 Elm Street', '400 Elm St', 'Salinas', '93905', 'CA', '400 Elm Street', '400 Elm St', 'Salinas', '93905', 'CA', '54', 'High School District', 'Junior High Schools (Public)', '2023-01-01');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "District Type", "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "FRPM Count (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)") VALUES ('CDS001', 'Monterey', 'Monterey Peninsula Unified', 'Monterey High (FRPM)', 'Unified School District', 'High Schools (Public)', 'Traditional', 1200.0, 600.0, 600.0, 1100.0, 801.0, 600.0);
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "District Type", "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "FRPM Count (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)") VALUES ('CDS002', 'Monterey', 'Monterey Peninsula Unified', 'Boundary High', 'Unified School District', 'High Schools (Public)', 'Traditional', 1200.0, 950.0, 950.0, 1150.0, 800.0, 950.0);
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "District Type", "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "FRPM Count (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)") VALUES ('CDS003', 'Santa Cruz', 'Monterey', 'Wrong County High', 'Unified School District', 'High Schools (Public)', 'Traditional', 1000.0, 900.0, 950.0, 950.0, 900.0, 950.0);
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "District Type", "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "FRPM Count (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)") VALUES ('CDS004', 'Monterey', 'Salinas Union', 'Junior High School', 'High School District', 'Junior High Schools (Public)', 'Traditional', 1000.0, 900.0, 950.0, 950.0, 900.0, 950.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1."School Name", T2.Zip, T2.Street, T2.City, T2.State FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.County = 'Monterey' AND T1."Free Meal Count (Ages 5-17)" > 800 AND T1."School Type" = 'High Schools (Public)';

/*
Gold Result:
('Monterey High (FRPM)', '93940', '100 Main Street', 'Monterey', 'CA')
*/

-- Prediction Query
SELECT s.School, s.Street, s.City, s.State, s.Zip FROM schools AS s JOIN frpm AS f ON s.CDSCode = f.CDSCode WHERE s.County = 'Monterey' AND s.SOCType = 'High Schools (Public)' AND f."FRPM Count (Ages 5-17)" > 800;

/*
Prediction Result:
('Boundary High', '200 Oak Avenue', 'Monterey', 'CA', '93940')
*/