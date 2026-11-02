-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, GSoffered, GSserved, DOC, DOCType, LastUpdate) VALUES ('031001', 'Active', 'Amador', 'Ione Unified', 'Amador High', 'K-12', 'K-12', '54', 'Unified School District', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, GSoffered, GSserved, DOC, DOCType, LastUpdate) VALUES ('031002', 'Active', 'Amador', 'Ione Unified', 'Argonaut High', '7-12', '7-12', '54', 'Unified School District', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, GSoffered, GSserved, DOC, DOCType, LastUpdate) VALUES ('031003', 'Active', 'Calaveras', 'Calaveras Unified', 'Calaveras High', '9-12', '9-12', '54', 'Unified School District', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, GSoffered, GSserved, DOC, DOCType, LastUpdate) VALUES ('031004', 'Active', 'Amador', 'Ione Unified', 'Sutter Creek Span', '9-12', '9-12', '54', 'Unified School District', '2023-01-01');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Low Grade", "High Grade") VALUES ('031001', 'Calaveras', 'Ione Unified', 'Amador High', '9', '12');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Low Grade", "High Grade") VALUES ('031002', 'Calaveras', 'Ione Unified', 'Argonaut High', '9', '12');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Low Grade", "High Grade") VALUES ('031003', 'Amador', 'Calaveras Unified', 'Calaveras High', '9', '12');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Low Grade", "High Grade") VALUES ('031004', 'Amador', 'Ione Unified', 'Sutter Creek Span', '7', '12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1."School Name") FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.County = 'Amador' AND T1."Low Grade" = 9 AND T1."High Grade" = 12;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM frpm WHERE "County Name" = 'Amador' AND "Low Grade" = '9' AND "High Grade" = '12';

/*
Prediction Result:
(1,)
*/