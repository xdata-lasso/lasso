-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core positive cases and join necessity:
-- Row 1: Matches all conditions with year 2009.
-- Row 2: Matches all conditions with year 2010.
-- Row 3: Matches all conditions in 'schools' table, but has no corresponding entry in 'frpm' (kills mutants that omit the INNER JOIN with frpm or use LEFT JOIN from schools).
INSERT INTO schools (CDSCode, StatusType, County, District, City, OpenDate, DOC, DOCType, SOC, AdmEmail1, AdmEmail2, AdmEmail3, LastUpdate) VALUES ('10000000000001', 'Active', 'San Bernardino', 'San Bernardino City Unified', 'San Bernardino', '2009-08-25', '54', 'Unified School District', '62', 'admin1_2009@sb.edu', 'wrong_col2@sb.edu', 'wrong_col3@sb.edu', '2015-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, OpenDate, DOC, DOCType, SOC, AdmEmail1, AdmEmail2, AdmEmail3, LastUpdate) VALUES ('10000000000002', 'Active', 'San Bernardino', 'San Bernardino City Unified', 'San Bernardino', '2010-01-15', '54', 'Unified School District', '62', 'admin1_2010@sb.edu', 'wrong2_col2@sb.edu', 'wrong2_col3@sb.edu', '2015-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, OpenDate, DOC, DOCType, SOC, AdmEmail1, LastUpdate) VALUES ('10000000000003', 'Active', 'San Bernardino', 'San Bernardino City Unified', 'San Bernardino', '2009-09-01', '54', 'Unified School District', '62', 'no_frpm_match@sb.edu', '2015-01-01');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name") VALUES ('10000000000001', 'San Bernardino', 'San Bernardino City Unified', 'School A');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name") VALUES ('10000000000002', 'San Bernardino', 'San Bernardino City Unified', 'School B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.AdmEmail1 FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.County = 'San Bernardino' AND T2.City = 'San Bernardino' AND T2.DOC = 54 AND STRFTIME('%Y', T2.OpenDate) BETWEEN '2009' AND '2010' AND T2.SOC = 62;

/*
Gold Result:
('admin1_2009@sb.edu',)
('admin1_2010@sb.edu',)
*/

-- Prediction Query
SELECT AdmEmail1 FROM schools WHERE County = 'San Bernardino' AND City = 'San Bernardino' AND OpenDate BETWEEN '2009-01-01' AND '2010-12-31' AND SOC = 62 AND DOC = 54;

/*
Prediction Result:
('admin1_2009@sb.edu',)
('admin1_2010@sb.edu',)
('no_frpm_match@sb.edu',)
*/