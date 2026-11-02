-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1: Distinct AvgScrMath values, testing INNER JOIN filtering (unmatched schools), column projections (Street vs MailStreet, sname vs School, AvgScrMath vs Read/Write), and LIMIT/OFFSET boundaries.
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES ('CDS_UNMATCHED_HIGH', 'Active', 'CountyU', 'DistU', 'Unmatched High School', '999 Phys St', '999 Mail St', '00', 'DOC', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES ('CDS_1', 'Active', 'CountyA', 'DistA', 'School One', '101 Phys St', '101 Mail St', '00', 'DOC', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES ('CDS_2', 'Active', 'CountyA', 'DistA', 'School Two', '102 Phys St', '102 Mail St', '00', 'DOC', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES ('CDS_3', 'Active', 'CountyA', 'DistA', 'School Three', '103 Phys St', '103 Mail St', '00', 'DOC', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES ('CDS_4', 'Active', 'CountyA', 'DistA', 'School Four', '104 Phys St', '104 Mail St', '00', 'DOC', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES ('CDS_5', 'Active', 'CountyA', 'DistA', 'School Five', '105 Phys St', '105 Mail St', '00', 'DOC', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES ('CDS_6', 'Active', 'CountyA', 'DistA', 'School Six Target', '106 Phys St', '106 Mail St Target', '00', 'DOC', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES ('CDS_7', 'Active', 'CountyA', 'DistA', 'School Seven', '107 Phys St', '107 Mail St', '00', 'DOC', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES ('CDS_8', 'Active', 'CountyA', 'DistA', 'School Eight', '108 Phys St', '108 Mail St', '00', 'DOC', '2023-01-01');
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS_1', 'S', 'SAT Name 1', 100, 50, 400, 800, 400);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS_2', 'S', 'SAT Name 2', 100, 50, 450, 750, 450);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS_3', 'S', 'SAT Name 3', 100, 50, 500, 700, 500);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS_4', 'S', 'SAT Name 4', 100, 50, 550, 650, 550);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS_5', 'S', 'SAT Name 5', 100, 50, 600, 600, 600);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS_6', 'S', 'SAT Name 6', 100, 50, 650, 550, 650);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS_7', 'S', 'SAT Name 7', 100, 50, 700, 500, 700);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS_8', 'S', 'SAT Name 8', 100, 50, 750, 450, 750);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.MailStreet, T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode ORDER BY T1.AvgScrMath DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1 OFFSET 5;

/*
Gold Result:
('106 Mail St Target', 'School Six Target')
*/

-- Prediction Query
SELECT schools.Street, schools.School FROM schools INNER JOIN satscores ON schools.CDSCode = satscores.cds ORDER BY satscores.AvgScrMath DESC, schools.cdscode NULLS LAST, satscores.cds NULLS LAST LIMIT 1 OFFSET 6;

/*
Prediction Result:
('107 Phys St', 'School Seven')
*/