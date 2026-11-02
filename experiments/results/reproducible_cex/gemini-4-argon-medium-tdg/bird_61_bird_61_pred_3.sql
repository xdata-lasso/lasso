-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic matching row, partial matches (missing one condition each: DOC, Charter, City), NULL values in predicates, and inner join traps (no rows in frpm or satscores).
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, Charter, DOC, DOCType, LastUpdate) VALUES ('100001', 'Active', 'Stanislaus', 'Hickman Community Charter', 'Hickman Elem', 'Hickman', 1, '52', 'Elementary School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, Charter, DOC, DOCType, LastUpdate) VALUES ('100002', 'Active', 'Stanislaus', 'Hickman Community Charter', 'Wrong DOC School', 'Hickman', 1, '54', 'Unified School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, Charter, DOC, DOCType, LastUpdate) VALUES ('100003', 'Active', 'Stanislaus', 'Hickman Community Charter', 'Non-Charter School', 'Hickman', 0, '52', 'Elementary School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, Charter, DOC, DOCType, LastUpdate) VALUES ('100004', 'Active', 'Stanislaus', 'Hickman Community Charter', 'NULL Charter School', 'Hickman', NULL, '52', 'Elementary School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, Charter, DOC, DOCType, LastUpdate) VALUES ('100005', 'Active', 'Stanislaus', 'Hickman Community Charter', 'Wrong City School', 'Modesto', 1, '52', 'Elementary School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, Charter, DOC, DOCType, LastUpdate) VALUES ('100006', 'Active', 'Stanislaus', 'Hickman Community Charter', 'NULL City School', NULL, 1, '52', 'Elementary School District', '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(School) FROM schools WHERE DOC = 52 AND Charter = 1 AND City = 'Hickman';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM schools AS T1 INNER JOIN frpm AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1.Charter = 1 AND T1.City = 'Hickman' AND T1.DOC = 52;

/*
Prediction Result:
(0,)
*/