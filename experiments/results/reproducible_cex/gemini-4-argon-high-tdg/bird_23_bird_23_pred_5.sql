-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, DOC, DOCType, LastUpdate) VALUES ('CDS001', 'Active', 'Alameda', 'District A', 'School 001', '101 First Avenue', '101 1st Ave', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, DOC, DOCType, LastUpdate) VALUES ('CDS002', 'Active', 'Alameda', 'District A', 'School 002', '102 Second Avenue', '102 2nd Ave', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, DOC, DOCType, LastUpdate) VALUES ('CDS003', 'Active', 'Alameda', 'District A', 'School 003', '103 Third Avenue', '103 3rd Ave', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, DOC, DOCType, LastUpdate) VALUES ('CDS004', 'Active', 'Alameda', 'District A', 'School 004', '104 Fourth Avenue', '104 4th Ave', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, DOC, DOCType, LastUpdate) VALUES ('CDS005', 'Active', 'Alameda', 'District A', 'School 005', '105 Fifth Avenue', '105 5th Ave', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, DOC, DOCType, LastUpdate) VALUES ('CDS006', 'Active', 'Alameda', 'District A', 'School 006', '106 Sixth Avenue', '106 6th Ave', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, DOC, DOCType, LastUpdate) VALUES ('CDS007', 'Active', 'Alameda', 'District A', 'School 007', '107 Seventh Avenue', '107 7th Ave', '54', 'Unified', '2020-01-01');
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Enrollment (Ages 5-17)") VALUES ('CDS001', 'School 001', 131.0, 100.0);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Enrollment (Ages 5-17)") VALUES ('CDS002', 'School 002', 130.5, 100.0);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Enrollment (Ages 5-17)") VALUES ('CDS003', 'School 003', 130.0, 100.0);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Enrollment (Ages 5-17)") VALUES ('CDS004', 'School 004', 129.5, 100.0);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Enrollment (Ages 5-17)") VALUES ('CDS005', 'School 005', 100.0, 150.0);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Enrollment (Ages 5-17)") VALUES ('CDS006', 'School 006', 20.0, 15.0);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Enrollment (Ages 5-17)") VALUES ('CDS007', 'School 007', 35.0, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.School, T1.StreetAbr FROM schools AS T1 INNER JOIN frpm AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2."Enrollment (K-12)" - T2."Enrollment (Ages 5-17)" > 30;

/*
Gold Result:
('School 001', '101 1st Ave')
('School 002', '102 2nd Ave')
('School 007', '107 7th Ave')
*/

-- Prediction Query
SELECT schools.school, schools.street FROM schools INNER JOIN frpm ON schools.cdscode = frpm.cdscode WHERE (frpm."Enrollment (K-12)" - frpm."Enrollment (Ages 5-17)") > 30;

/*
Prediction Result:
('School 001', '101 First Avenue')
('School 002', '102 Second Avenue')
('School 007', '107 Seventh Avenue')
*/