-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, Phone, DOC, DOCType, LastUpdate) VALUES ('01', 'Active', 'CountyA', 'DistA', 'School One', '555-0001', '10', 'Unified', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Phone, DOC, DOCType, LastUpdate) VALUES ('02', 'Active', 'CountyB', 'DistB', 'School Two', '555-0002', '10', 'Unified', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Phone, DOC, DOCType, LastUpdate) VALUES ('03', 'Active', 'CountyC', 'DistC', 'School Three', '555-0003', '10', 'Unified', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Phone, DOC, DOCType, LastUpdate) VALUES ('04', 'Active', 'CountyD', 'DistD', 'School Four', '555-0004', '10', 'Unified', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Phone, DOC, DOCType, LastUpdate) VALUES ('05', 'Active', 'CountyE', 'DistE', 'School Five', '555-0005', '10', 'Unified', '2023-01-01');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('01', 'S', 'School Five', 'DistE', 'CountyE', 400, 1000, 700, 700, 700, 400);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('02', 'S', 'School Four', 'DistD', 'CountyD', 300, 500, 650, 650, 650, 250);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('03', 'S', 'School Three', 'DistC', 'CountyC', 300, 200, 600, 600, 600, 140);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('04', 'S', 'School Two', 'DistB', 'CountyB', 500, 100, 550, 550, 550, 85);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('05', 'S', 'School One', 'DistA', 'CountyA', 1000, 50, 500, 500, 500, 49);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Phone FROM schools AS T1 INNER JOIN satscores AS T2 ON T1.CDSCode = T2.cds ORDER BY CAST(T2.NumGE1500 AS REAL) / T2.NumTstTakr DESC, T1.cdscode NULLS LAST, T2.cds NULLS LAST LIMIT 3;

/*
Gold Result:
('555-0005',)
('555-0004',)
('555-0003',)
*/

-- Prediction Query
SELECT schools.phone FROM satscores INNER JOIN schools ON satscores.cds = schools.cdscode ORDER BY (satscores.numge1500 / satscores.numtsttakr) DESC, satscores.cds NULLS LAST, schools.cdscode NULLS LAST LIMIT 3;

/*
Prediction Result:
('555-0001',)
('555-0002',)
('555-0003',)
*/