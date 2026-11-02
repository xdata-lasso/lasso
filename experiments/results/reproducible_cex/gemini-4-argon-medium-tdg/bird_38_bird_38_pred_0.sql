-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS001', 'Active', 'Los Angeles', 'LAUSD', 'High School 1', 'http://hs1.edu', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS002', 'Active', 'Los Angeles', 'LAUSD', 'High School 2', 'http://hs2.edu', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS003', 'Active', 'Los Angeles', 'LAUSD', 'High School 3', 'http://hs3.edu', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS004', 'Active', 'Los Angeles', 'LAUSD', 'High School 4', 'http://hs4.edu', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS005', 'Active', 'Los Angeles', 'LAUSD', 'High School 5', 'http://hs5.edu', '54', 'Unified', '2020-01-01');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('CDS001', 'S', 'High School 1', 'LAUSD', 'Los Angeles', 2500, 1999, 500, 500, 500, 2500);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('CDS002', 'S', 'High School 2', 'LAUSD', 'Los Angeles', 1500, 2000, 500, 500, 500, 1000);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('CDS003', 'S', 'High School 3', 'LAUSD', 'Los Angeles', 1500, 2500, 500, 500, 500, 1000);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('CDS004', 'S', 'High School 4', 'LAUSD', 'Los Angeles', 1500, 3000, 500, 500, 500, 1000);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('CDS005', 'S', 'High School 5', 'LAUSD', 'Los Angeles', 2500, 3001, 500, 500, 500, 2500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Website FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T1.NumTstTakr BETWEEN 2000 AND 3000 AND T2.County = 'Los Angeles';

/*
Gold Result:
('http://hs2.edu',)
('http://hs3.edu',)
('http://hs4.edu',)
*/

-- Prediction Query
SELECT T3.Website FROM satscores AS T1 INNER JOIN frpm AS T2 ON T1.cds = T2.CDSCode INNER JOIN schools AS T3 ON T1.cds = T3.CDSCode WHERE T2."County Name" = 'Los Angeles' AND T1.NumTstTakr BETWEEN 2000 AND 3000;

/*
Prediction Result:
*/