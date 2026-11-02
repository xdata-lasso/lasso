-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EILCode, EILName, LastUpdate) VALUES ('CDS001', 'Active', 'San Diego', 'Dist1', 'School Alpha', '00', 'District', 'ELEM', 'Elementary', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EILCode, EILName, LastUpdate) VALUES ('CDS002', 'Active', 'San Diego', 'Dist1', 'School Alpha', '00', 'District', 'ELEM', 'Elementary', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EILCode, EILName, LastUpdate) VALUES ('CDS003', 'Active', 'San Diego', 'Dist2', 'School Beta', '00', 'District', 'HS', 'High School', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EILCode, EILName, LastUpdate) VALUES ('CDS004', 'Active', 'Orange', 'Dist3', 'School Gamma', '00', 'District', 'INT', 'Intermediate', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EILCode, EILName, LastUpdate) VALUES ('CDS005', 'Active', 'San Diego', 'Dist4', 'School Orphan', '00', 'District', 'ELEM', 'Elementary', '2020-01-01');
INSERT INTO frpm (CDSCode, "County Code", "District Code", "School Name", "NSLP Provision Status") VALUES ('CDS001', '37', 101, 'FRPM School Alpha 1', 'Breakfast Provision 2');
INSERT INTO frpm (CDSCode, "County Code", "District Code", "School Name", "NSLP Provision Status") VALUES ('CDS002', '37', 102, 'FRPM School Alpha 2', 'Breakfast Provision 2');
INSERT INTO frpm (CDSCode, "County Code", "District Code", "School Name", "NSLP Provision Status") VALUES ('CDS003', '37', 37, 'School Beta', 'Provision 2');
INSERT INTO frpm (CDSCode, "County Code", "District Code", "School Name", "NSLP Provision Status") VALUES ('CDS004', '30', 37, 'School Gamma', 'Breakfast Provision 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.EILName, T2.School FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1."NSLP Provision Status" = 'Breakfast Provision 2' AND T1."County Code" = 37;

/*
Gold Result:
('Elementary', 'School Alpha')
('Elementary', 'School Alpha')
*/

-- Prediction Query
SELECT s.School, s.EILName FROM schools AS s JOIN frpm AS f ON s.CDSCode = f.CDSCode WHERE f."NSLP Provision Status" = 'Breakfast Provision 2' AND f."County Code" = '37';

/*
Prediction Result:
('School Alpha', 'Elementary')
('School Alpha', 'Elementary')
*/