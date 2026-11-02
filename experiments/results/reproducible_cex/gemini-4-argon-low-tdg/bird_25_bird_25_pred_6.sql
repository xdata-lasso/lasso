-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inner join, WHERE LIKE 'Riverside%' prefix matching vs substring matching, and HAVING > 400 vs >= 400.
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, FundingType, DOC, DOCType, LastUpdate) VALUES
('CDS1', 'Active', 'Riverside', 'Riverside Unified', 'School A', 1, 'Directly funded', '01', 'District', '2020-01-01'),
('CDS2', 'Active', 'Riverside', 'Riverside County', 'School B', 1, 'Locally funded', '01', 'District', '2020-01-01'),
('CDS3', 'Active', 'Riverside', 'East Riverside', 'School C', 1, 'Directly funded', '01', 'District', '2020-01-01'),
('CDS4', 'Active', 'Riverside', 'Riverside Unified', 'School D', 1, 'Directly funded', '01', 'District', '2020-01-01'),
('CDS5', 'Active', 'Riverside', 'Riverside', 'School E', 0, 'Not Charter', '01', 'District', '2020-01-01');
INSERT INTO frpm (CDSCode, "District Name", "School Name", "Charter Funding Type") VALUES
('CDS1', 'Riverside Unified', 'School A', 'Directly funded'),
('CDS2', 'Riverside County', 'School B', 'Locally funded'),
('CDS3', 'East Riverside', 'School C', 'Directly funded'),
('CDS4', 'Riverside Unified', 'School D', 'Directly funded'),
('CDS5', 'Riverside', 'School E', 'Not Charter');
INSERT INTO satscores (cds, rtype, sname, dname, enroll12, NumTstTakr, AvgScrMath, AvgScrRead, AvgScrWrite) VALUES
('CDS1', 'S', 'School A', 'Riverside Unified', 100, 50, 450, 300, 300),
('CDS2', 'S', 'School B', 'Riverside County', 100, 50, 400, 450, 450),
('CDS3', 'S', 'School C', 'East Riverside', 100, 50, 500, 500, 500),
('CDS4', 'S', 'School D', 'Riverside Unified', 100, 50, 350, 500, 500),
('CDS5', 'S', 'School E', 'Riverside', 100, 50, 401, 400, 400);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.sname, T2."Charter Funding Type" FROM satscores AS T1 INNER JOIN frpm AS T2 ON T1.cds = T2.CDSCode WHERE T2."District Name" LIKE 'Riverside%' GROUP BY T1.sname, T2."Charter Funding Type" HAVING CAST(SUM(T1.AvgScrMath) AS REAL) / COUNT(T1.cds) > 400;

/*
Gold Result:
('School A', 'Directly funded')
('School E', 'Not Charter')
*/

-- Prediction Query
SELECT T2.School, T2.FundingType FROM satscores AS T1 JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.County = 'Riverside' AND T1.AvgScrMath > 400;

/*
Prediction Result:
('School A', 'Directly funded')
('School C', 'Directly funded')
('School E', 'Not Charter')
*/