-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmEmail1, AdmEmail2, AdmEmail3, LastUpdate) VALUES ('1001', 'Active', 'CountyA', 'DistA', 'Alpha High', '54', 'Unified', 'admin1_alpha@school.edu', 'admin2_alpha@school.edu', 'admin3_alpha@school.edu', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmEmail1, AdmEmail2, AdmEmail3, LastUpdate) VALUES ('1002', 'Active', 'CountyB', 'DistB', 'Beta High', '54', 'Unified', 'admin1_beta@school.edu', 'admin2_beta@school.edu', 'admin3_beta@school.edu', '2023-01-02');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmEmail1, AdmEmail2, AdmEmail3, LastUpdate) VALUES ('1003', 'Active', 'CountyC', 'DistC', 'Gamma High', '54', 'Unified', 'admin1_gamma@school.edu', 'admin2_gamma@school.edu', 'admin3_gamma@school.edu', '2023-01-03');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('1001', 'S', 'Sname Alpha', 'DistA', 'CountyA', 500, 400, 600, 600, 600, 150);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('1002', 'S', 'Sname Beta', 'DistB', 'CountyB', 200, 180, 450, 450, 450, 175);
INSERT INTO frpm (CDSCode, "School Name") VALUES ('1001', 'FRPM Alpha');
INSERT INTO frpm (CDSCode, "School Name") VALUES ('1002', 'FRPM Beta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.AdmEmail1, T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode ORDER BY T1.NumGE1500 DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
('admin1_beta@school.edu', 'Beta High')
*/

-- Prediction Query
SELECT s.AdmEmail1, ss.sname FROM schools AS s JOIN satscores AS ss ON s.CDSCode = ss.cds WHERE ss.cds = (SELECT cds FROM satscores ORDER BY NumGE1500 DESC, satscores.cds NULLS LAST LIMIT 1);

/*
Prediction Result:
('admin1_beta@school.edu', 'Sname Beta')
*/