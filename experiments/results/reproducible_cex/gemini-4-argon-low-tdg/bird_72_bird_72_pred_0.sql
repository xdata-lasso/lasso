-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core condition mutations: EdOpsCode, City, Academic Year boundaries, Enrollment vs other columns, and duplicates (DISTINCT vs ALL).
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, EdOpsCode, EdOpsName, City, MailCity) VALUES
('1001', 'Active', 'Alameda', 'Fremont Unified', '54', 'Unified', '2020-01-01', 'SSS', 'State Special School', 'Fremont', 'Newark'),
('1002', 'Active', 'Alameda', 'Fremont Unified', '54', 'Unified', '2020-01-01', 'SSS', 'State Special School', 'Fremont', 'Fremont'),
('1003', 'Active', 'Alameda', 'Fremont Unified', '54', 'Unified', '2020-01-01', 'TRAD', 'State Special School', 'Fremont', 'Fremont'),
('1004', 'Active', 'Alameda', 'Fremont Unified', '54', 'Unified', '2020-01-01', 'SSS', 'State Special School', 'Newark', 'Fremont'),
('1005', 'Active', 'Alameda', 'Fremont Unified', '54', 'Unified', '2020-01-01', 'SSS', 'State Special School', 'Fremont', 'Fremont'),
('1006', 'Active', 'Alameda', 'Fremont Unified', '54', 'Unified', '2020-01-01', 'SSS', 'State Special School', 'Fremont', 'Fremont');
INSERT INTO frpm (CDSCode, "Academic Year", "Enrollment (Ages 5-17)", "Enrollment (K-12)", "FRPM Count (Ages 5-17)", "Free Meal Count (Ages 5-17)") VALUES
('1001', '2014', 450.0, 500.0, 120.0, 100.0),
('1002', '2015', 450.0, 480.0, 130.0, 110.0),
('1003', '2014', 300.0, 320.0, 80.0, 70.0),
('1004', '2014', 600.0, 650.0, 200.0, 180.0),
('1005', '2013', 700.0, 750.0, 250.0, 220.0),
('1006', '2016', 800.0, 850.0, 300.0, 280.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1."Enrollment (Ages 5-17)" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.EdOpsCode = 'SSS' AND T2.City = 'Fremont' AND T1."Academic Year" BETWEEN 2014 AND 2015;

/*
Gold Result:
(450.0,)
(450.0,)
*/

-- Prediction Query
SELECT "Enrollment (Ages 5-17)" FROM frpm INNER JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE "Academic Year" = '2014-2015' AND City = 'Fremont' AND EdOpsCode = 'SSS';

/*
Prediction Result:
*/