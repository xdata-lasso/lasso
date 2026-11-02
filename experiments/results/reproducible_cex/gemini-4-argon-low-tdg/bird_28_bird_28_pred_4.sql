-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, FundingType, DOC, DOCType, LastUpdate) VALUES
('C1', 'Active', 'Cty1', 'Dist1', 'School_Low', 'Locally funded', 'D1', 'DT1', '2020-01-01'),
('C2', 'Active', 'Cty2', 'Dist2', 'School_Exact', 'Locally funded', 'D2', 'DT2', '2020-01-01'),
('C3', 'Active', 'Cty3', 'Dist3', 'School_High', 'Locally funded', 'D3', 'DT3', '2020-01-01');
INSERT INTO frpm (CDSCode, "School Name", "Charter Funding Type", "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES
('C1', 'Diff_Low', 'Directly funded', 100.0, 90.0, 80.0, 85.0),
('C2', 'Diff_Exact', 'Directly funded', 200.0, 180.0, 150.0, 160.0),
('C3', 'Diff_High', 'Directly funded', 150.0, 120.0, 100.0, 110.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School, T2.DOC FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.FundingType = 'Locally funded' AND (T1."Enrollment (K-12)" - T1."Enrollment (Ages 5-17)") > (SELECT AVG(T3."Enrollment (K-12)" - T3."Enrollment (Ages 5-17)") FROM frpm AS T3 INNER JOIN schools AS T4 ON T3.CDSCode = T4.CDSCode WHERE T4.FundingType = 'Locally funded');

/*
Gold Result:
('School_High', 'D3')
*/

-- Prediction Query
SELECT School, DOCType FROM schools JOIN frpm ON schools.CDSCode = frpm.CDSCode WHERE FundingType = 'Locally funded' AND (CAST(frpm."Enrollment (K-12)" AS REAL) - CAST(frpm."Enrollment (Ages 5-17)" AS REAL)) > (SELECT AVG(CAST(frpm."Enrollment (K-12)" AS REAL) - CAST(frpm."Enrollment (Ages 5-17)" AS REAL)) FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE FundingType = 'Locally funded');

/*
Prediction Result:
('School_High', 'DT3')
*/