-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, LastUpdate) VALUES
('1', 'Active', 'County1', 'Dist1', 'School1', '01', 'TypeA', 'F', '2023-01-01'),
('2', 'Active', 'County1', 'Dist1', 'School2', '01', 'TypeA', 'F', '2023-01-01'),
('3', 'Active', 'County1', 'Dist1', 'School3', '01', 'TypeA', 'F', '2023-01-01'),
('4', 'Active', 'County1', 'Dist1', 'School4', '01', 'TypeA', 'F', '2023-01-01'),
('5', 'Active', 'County1', 'Dist1', 'School5', '01', 'TypeA', 'F', '2023-01-01'),
('6', 'Active', 'County2', 'Dist2', 'School6', '01', 'TypeA', 'F', '2023-01-01');
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, AvgScrRead) VALUES
('1', 'S', 100, 50, 600),
('2', 'S', 100, 50, 590),
('3', 'S', 100, 50, 580),
('4', 'S', 100, 50, 570),
('5', 'S', 100, 50, 560),
('6', 'S', 100, 50, 550);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.Virtual = 'F' ORDER BY T1.AvgScrRead DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 5;

/*
Gold Result:
('School1',)
('School2',)
('School3',)
('School4',)
('School5',)
*/

-- Prediction Query
WITH RankedSchools AS (SELECT s.School, s.County, ss.AvgScrRead, ROW_NUMBER() OVER (PARTITION BY s.County ORDER BY ss.AvgScrRead DESC) AS rank FROM schools AS s INNER JOIN satscores AS ss ON s.CDSCode = ss.cds WHERE s.Virtual = 'F') SELECT School FROM RankedSchools WHERE rank <= 5;

/*
Prediction Result:
('School1',)
('School2',)
('School3',)
('School4',)
('School5',)
('School6',)
*/