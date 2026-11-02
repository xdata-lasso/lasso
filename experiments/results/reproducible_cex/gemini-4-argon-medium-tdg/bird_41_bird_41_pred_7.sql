-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests:
-- 1. All rows having identical AvgScrRead to strictly test secondary sort key (T1.cds NULLS LAST) and LIMIT 5 cutoff on tie-breakers.
-- 2. String sorting vs numeric sorting on CDSCode/cds ('10' vs '2' vs '05').
-- 3. Other columns having various values to kill mutants that filter on Charter, Magnet, StatusType, or rtype.
INSERT INTO schools (CDSCode, StatusType, County, District, School, Virtual, Charter, Magnet, DOC, DOCType, LastUpdate) VALUES
('2', 'Closed', 'C1', 'D1', 'School CDS 2', 'F', 1, 1, '00', 'Type', '2020-01-01'),
('10', 'Active', 'C1', 'D1', 'School CDS 10', 'F', 0, 0, '00', 'Type', '2020-01-01'),
('05', 'Pending', 'C2', 'D2', 'School CDS 05', 'F', NULL, NULL, '00', 'Type', '2020-01-01'),
('20', 'Active', 'C2', 'D2', 'School CDS 20', 'F', 1, 0, '00', 'Type', '2020-01-01'),
('15', 'Active', 'C3', 'D3', 'School CDS 15', 'F', 0, 1, '00', 'Type', '2020-01-01'),
('3', 'Active', 'C3', 'D3', 'School CDS 3', 'F', 1, 1, '00', 'Type', '2020-01-01');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES
('2', 'D', 'S2', 'D1', 'C1', 0, 0, 500, 600, 700, 0),
('10', 'S', 'S10', 'D1', 'C1', 500, 400, 500, 500, 500, 200),
('05', 'C', 'S05', 'D2', 'C2', 10, 5, 500, 400, 300, 1),
('20', 'S', 'S20', 'D2', 'C2', 200, 150, 500, 800, 200, 50),
('15', 'S', 'S15', 'D3', 'C3', 300, 250, 500, 300, 800, 100),
('3', 'S', 'S3', 'D3', 'C3', 400, 350, 500, 700, 600, 150);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.Virtual = 'F' ORDER BY T1.AvgScrRead DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 5;

/*
Gold Result:
('School CDS 05',)
('School CDS 10',)
('School CDS 15',)
('School CDS 2',)
('School CDS 20',)
*/

-- Prediction Query
SELECT school FROM (SELECT schools.school, ROW_NUMBER() OVER (PARTITION BY schools.county ORDER BY satscores.avgscrread DESC) AS rn FROM schools INNER JOIN satscores ON schools.cdscode = satscores.cds WHERE schools.virtual = 'F') WHERE rn <= 5;

/*
Prediction Result:
('School CDS 2',)
('School CDS 10',)
('School CDS 05',)
('School CDS 20',)
('School CDS 15',)
('School CDS 3',)
*/