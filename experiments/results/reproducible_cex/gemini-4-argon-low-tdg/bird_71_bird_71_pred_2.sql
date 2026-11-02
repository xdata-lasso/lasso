-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (City = 'Fresno', Magnet = 0), NULL handling, and wrong column references (e.g., County/District/MailCity = 'Fresno', Charter = 0, IRC = 0)
INSERT INTO schools (CDSCode, StatusType, County, District, City, MailCity, Charter, DOC, DOCType, Magnet, LastUpdate) VALUES ('101', 'Active', 'Fresno', 'Fresno Unified', 'Fresno', 'Clovis', 1, '54', 'Unified', 0, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, MailCity, Charter, DOC, DOCType, Magnet, LastUpdate) VALUES ('102', 'Active', 'Fresno', 'Fresno Unified', 'Fresno', 'Fresno', 0, '54', 'Unified', 1, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, MailCity, Charter, DOC, DOCType, Magnet, LastUpdate) VALUES ('103', 'Active', 'Fresno', 'Fresno Unified', 'Fresno', 'Fresno', 0, '54', 'Unified', NULL, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, MailCity, Charter, DOC, DOCType, Magnet, LastUpdate) VALUES ('104', 'Active', 'Fresno', 'Fresno', 'Clovis', 'Fresno', 0, '54', 'Unified', 0, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, MailCity, Charter, DOC, DOCType, Magnet, LastUpdate) VALUES ('105', 'Active', 'Fresno', 'Fresno Unified', NULL, 'Fresno', 0, '54', 'Unified', 0, '2020-01-01');
INSERT INTO frpm (CDSCode, "District Code", "County Code", "School Code", "County Name", "District Name", "Charter School (Y/N)", IRC) VALUES ('101', 1001, '10', '01', 'Other', 'Other', 1, 1);
INSERT INTO frpm (CDSCode, "District Code", "County Code", "School Code", "County Name", "District Name", "Charter School (Y/N)", IRC) VALUES ('102', 1002, '10', '02', 'Fresno', 'Fresno', 0, 0);
INSERT INTO frpm (CDSCode, "District Code", "County Code", "School Code", "County Name", "District Name", "Charter School (Y/N)", IRC) VALUES ('103', 1003, '10', '03', 'Fresno', 'Fresno', 0, 0);
INSERT INTO frpm (CDSCode, "District Code", "County Code", "School Code", "County Name", "District Name", "Charter School (Y/N)", IRC) VALUES ('104', 1004, '10', '04', 'Fresno', 'Fresno', 0, 0);
INSERT INTO frpm (CDSCode, "District Code", "County Code", "School Code", "County Name", "District Name", "Charter School (Y/N)", IRC) VALUES ('105', 1005, '10', '05', 'Fresno', 'Fresno', 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1."District Code" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.City = 'Fresno' AND T2.Magnet = 0;

/*
Gold Result:
(1001,)
*/

-- Prediction Query
SELECT "district" FROM "schools" WHERE "magnet" = 0 AND "city" = 'Fresno';

/*
Prediction Result:
('Fresno Unified',)
*/