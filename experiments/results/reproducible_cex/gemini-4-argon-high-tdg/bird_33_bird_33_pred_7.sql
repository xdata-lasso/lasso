-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('10000000000001', 'Active', 'Alameda', 'District A', 'School 1', 'http://s1.edu', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('10000000000002', 'Active', 'Alameda', 'District A', 'School 2', 'http://s2.edu', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('10000000000003', 'Active', 'Alameda', 'District A', 'School 3', 'http://s3.edu', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('10000000000004', 'Active', 'Alameda', 'District A', 'School 4', 'http://s4.edu', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('10000000000005', 'Active', 'Alameda', 'District A', 'School 5', 'http://s5.edu', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('10000000000006', 'Active', 'Alameda', 'District A', 'School 6', 'http://s6.edu', '54', 'Unified', '2020-01-01');
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)") VALUES ('10000000000001', 'Exact Lower Bound', 1900.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)") VALUES ('10000000000002', 'Exact Upper Bound', 2000.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)") VALUES ('10000000000003', 'Mid Range', 1950.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)") VALUES ('10000000000004', 'Just Below Lower', 1899.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)") VALUES ('10000000000005', 'Just Above Upper', 2001.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)") VALUES ('10000000000006', 'Null Meal Count', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Website, T1."School Name" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1."Free Meal Count (Ages 5-17)" BETWEEN 1900 AND 2000 AND NOT T2.Website IS NULL;

/*
Gold Result:
('http://s1.edu', 'Exact Lower Bound')
('http://s2.edu', 'Exact Upper Bound')
('http://s3.edu', 'Mid Range')
*/

-- Prediction Query
SELECT T2.Website, T2.School FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1."Free Meal Count (Ages 5-17)" BETWEEN 1900 AND 2000;

/*
Prediction Result:
('http://s1.edu', 'School 1')
('http://s2.edu', 'School 2')
('http://s3.edu', 'School 3')
*/