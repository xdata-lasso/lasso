-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, MailStreet, Street, MailStrAbr, School) VALUES ('0000001', 'Active', 'CountyA', 'DistA', '00', 'DocTypeA', '2020-01-01', '100 Mail St', '100 Real St', '100 Mail Abr', 'School Alpha');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, MailStreet, Street, MailStrAbr, School) VALUES ('0000002', 'Active', 'CountyB', 'DistB', '00', 'DocTypeB', '2020-01-01', '200 Mail St', '200 Real St', '200 Mail Abr', 'School Beta');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, MailStreet, Street, MailStrAbr, School) VALUES ('0000003', 'Active', 'CountyC', 'DistC', '00', 'DocTypeC', '2020-01-01', '300 Mail St', '300 Real St', '300 Mail Abr', 'School Gamma');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, MailStreet, Street, MailStrAbr, School) VALUES ('0000004', 'Active', 'CountyD', 'DistD', '00', 'DocTypeD', '2020-01-01', '400 Mail St', '400 Real St', '400 Mail Abr', 'School Delta');
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('0000001', 'S', 'SatName Alpha', 100, 50, NULL, 200, 200);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('0000002', 'S', 'SatName Beta', 100, 50, 350, 600, 600);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('0000003', 'S', 'SatName Gamma', 100, 50, 500, 300, 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.MailStreet, T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE NOT T1.AvgScrRead IS NULL ORDER BY T1.AvgScrRead ASC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
('200 Mail St', 'School Beta')
*/

-- Prediction Query
SELECT schools.MailStreet, schools.School FROM schools INNER JOIN satscores ON schools.CDSCode = satscores.cds ORDER BY satscores.AvgScrRead ASC, schools.cdscode NULLS LAST, satscores.cds NULLS LAST LIMIT 1;

/*
Prediction Result:
('100 Mail St', 'School Alpha')
*/