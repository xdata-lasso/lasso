-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Focus: Boundary Value Analysis on NumTstTakr (1999, 2000, 2500, 3000, 3001) and column confusion (enroll12, NumGE1500 vs NumTstTakr).
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Website) VALUES ('CDS1', 'Active', 'Los Angeles', 'LAUSD', '00', 'District', '2020-01-01', 'http://1999.edu');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Website) VALUES ('CDS2', 'Active', 'Los Angeles', 'LAUSD', '00', 'District', '2020-01-01', 'http://2000.edu');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Website) VALUES ('CDS3', 'Active', 'Los Angeles', 'LAUSD', '00', 'District', '2020-01-01', 'http://2500.edu');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Website) VALUES ('CDS4', 'Active', 'Los Angeles', 'LAUSD', '00', 'District', '2020-01-01', 'http://3000.edu');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Website) VALUES ('CDS5', 'Active', 'Los Angeles', 'LAUSD', '00', 'District', '2020-01-01', 'http://3001.edu');
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, NumGE1500) VALUES ('CDS1', 'S', 2500, 1999, 2500);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, NumGE1500) VALUES ('CDS2', 'S', 1000, 2000, 1000);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, NumGE1500) VALUES ('CDS3', 'S', 1000, 2500, 1000);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, NumGE1500) VALUES ('CDS4', 'S', 1000, 3000, 1000);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, NumGE1500) VALUES ('CDS5', 'S', 2500, 3001, 2500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Website FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T1.NumTstTakr BETWEEN 2000 AND 3000 AND T2.County = 'Los Angeles';

/*
Gold Result:
('http://2000.edu',)
('http://2500.edu',)
('http://3000.edu',)
*/

-- Prediction Query
SELECT T3.Website FROM satscores AS T1 INNER JOIN frpm AS T2 ON T1.cds = T2.CDSCode INNER JOIN schools AS T3 ON T1.cds = T3.CDSCode WHERE T2."County Name" = 'Los Angeles' AND T1.NumTstTakr BETWEEN 2000 AND 3000;

/*
Prediction Result:
*/