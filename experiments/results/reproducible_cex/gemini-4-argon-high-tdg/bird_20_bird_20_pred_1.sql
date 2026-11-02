-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO schools (CDSCode, StatusType, County, District, School, GSoffered, GSserved, DOC, DOCType, LastUpdate) VALUES ('032001', 'Active', 'Amador', 'Amador County Unified', 'School A', '9-12', '9-12', '54', 'Unified School District', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, GSoffered, GSserved, DOC, DOCType, LastUpdate) VALUES ('032002', 'Active', 'Amador', 'Amador County Unified', 'School B', '9-12', '9-12', '54', 'Unified School District', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, GSoffered, GSserved, DOC, DOCType, LastUpdate) VALUES ('032003', 'Active', 'Amador', 'Amador County Unified', 'School C', '9-12', '9-12', '54', 'Unified School District', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, GSoffered, GSserved, DOC, DOCType, LastUpdate) VALUES ('032004', 'Active', 'Amador', 'Amador County Unified', NULL, '9-12', '9-12', '54', 'Unified School District', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, GSoffered, GSserved, DOC, DOCType, LastUpdate) VALUES ('032005', 'Active', 'Amador', 'Amador County Unified', 'School E', '9-12', '9-12', '54', 'Unified School District', '2023-01-01');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Low Grade", "High Grade") VALUES ('032001', 'Amador', 'Amador County Unified', 'Duplicate High', '9', '12');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Low Grade", "High Grade") VALUES ('032002', 'Amador', 'Amador County Unified', 'Duplicate High', '9', '12');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Low Grade", "High Grade") VALUES ('032003', 'Amador', 'Amador County Unified', 'Unique High', '9', '12');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Low Grade", "High Grade") VALUES ('032004', 'Amador', 'Amador County Unified', NULL, '9', '12');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Low Grade", "High Grade") VALUES ('032005', 'Amador', 'Amador County Unified', NULL, '9', '12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1."School Name") FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.County = 'Amador' AND T1."Low Grade" = 9 AND T1."High Grade" = 12;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.CDSCode) AS SchoolCount FROM schools AS T1 INNER JOIN frpm AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1.County = 'Amador' AND T2."Low Grade" = '9' AND T2."High Grade" = '12';

/*
Prediction Result:
(5,)
*/