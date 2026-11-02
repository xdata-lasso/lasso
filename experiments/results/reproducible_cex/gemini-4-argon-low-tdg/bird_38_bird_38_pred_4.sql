-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Focus: Duplicate Website values (kills SELECT DISTINCT mutants), NULL Website handling, and extra joins with frpm (kills mutants that unnecessarily INNER JOIN frpm).
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Website) VALUES ('CDS1', 'Active', 'Los Angeles', 'LAUSD', '00', 'District', '2020-01-01', 'http://duplicate.edu');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Website) VALUES ('CDS2', 'Active', 'Los Angeles', 'LAUSD', '00', 'District', '2020-01-01', 'http://duplicate.edu');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Website) VALUES ('CDS3', 'Active', 'Los Angeles', 'LAUSD', '00', 'District', '2020-01-01', NULL);
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Website) VALUES ('CDS4', 'Active', 'Los Angeles', 'LAUSD', '00', 'District', '2020-01-01', 'http://no_frpm.edu');
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('CDS1', 'S', 3000, 2200);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('CDS2', 'D', 3000, 2800);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('CDS3', 'S', 3000, 2500);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('CDS4', 'S', 3000, 2600);
INSERT INTO frpm (CDSCode, "County Name") VALUES ('CDS1', 'Los Angeles');
INSERT INTO frpm (CDSCode, "County Name") VALUES ('CDS2', 'Los Angeles');
INSERT INTO frpm (CDSCode, "County Name") VALUES ('CDS3', 'Los Angeles');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Website FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T1.NumTstTakr BETWEEN 2000 AND 3000 AND T2.County = 'Los Angeles';

/*
Gold Result:
('http://duplicate.edu',)
('http://duplicate.edu',)
(None,)
('http://no_frpm.edu',)
*/

-- Prediction Query
SELECT DISTINCT schools.website FROM schools INNER JOIN satscores ON schools.cdscode = satscores.cds WHERE schools.county = 'Los Angeles' AND satscores.numtsttakr BETWEEN 2000 AND 3000;

/*
Prediction Result:
('http://duplicate.edu',)
(None,)
('http://no_frpm.edu',)
*/