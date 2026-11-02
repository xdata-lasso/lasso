-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, City, OpenDate, DOC, DOCType, SOC, AdmEmail1, LastUpdate) VALUES ('CDS001', 'Active', 'San Bernardino', 'SB District', 'San Bernardino', '2009-01-01', '54', 'Unified', '62', 'admin2009@sb.edu', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, OpenDate, DOC, DOCType, SOC, AdmEmail1, LastUpdate) VALUES ('CDS002', 'Active', 'San Bernardino', 'SB District', 'San Bernardino', '2010-12-31', '54', 'Unified', '62', 'admin2010@sb.edu', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, OpenDate, DOC, DOCType, SOC, AdmEmail1, LastUpdate) VALUES ('CDS003', 'Active', 'San Bernardino', 'SB District', 'San Bernardino', '2008-12-31', '54', 'Unified', '62', 'wrong_year_2008@sb.edu', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, OpenDate, DOC, DOCType, SOC, AdmEmail1, LastUpdate) VALUES ('CDS004', 'Active', 'San Bernardino', 'SB District', 'San Bernardino', '2011-01-01', '54', 'Unified', '62', 'wrong_year_2011@sb.edu', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, OpenDate, DOC, DOCType, SOC, AdmEmail1, LastUpdate) VALUES ('CDS005', 'Active', 'San Bernardino', 'SB District', 'San Bernardino', NULL, '54', 'Unified', '62', 'null_date@sb.edu', '2020-01-01');
INSERT INTO frpm (CDSCode) VALUES ('CDS001');
INSERT INTO frpm (CDSCode) VALUES ('CDS002');
INSERT INTO frpm (CDSCode) VALUES ('CDS003');
INSERT INTO frpm (CDSCode) VALUES ('CDS004');
INSERT INTO frpm (CDSCode) VALUES ('CDS005');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.AdmEmail1 FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.County = 'San Bernardino' AND T2.City = 'San Bernardino' AND T2.DOC = 54 AND STRFTIME('%Y', T2.OpenDate) BETWEEN '2009' AND '2010' AND T2.SOC = 62;

/*
Gold Result:
('admin2009@sb.edu',)
('admin2010@sb.edu',)
*/

-- Prediction Query
SELECT AdmEmail1 FROM schools WHERE County = 'San Bernardino' AND District = 'San Bernardino City Unified' AND OpenDate BETWEEN '2009-01-01' AND '2010-12-31' AND (SOC = '62' OR DOC = '54');

/*
Prediction Result:
*/