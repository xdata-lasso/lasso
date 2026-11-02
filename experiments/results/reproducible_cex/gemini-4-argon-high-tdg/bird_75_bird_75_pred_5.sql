-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EILCode, EILName, EdOpsCode, EdOpsName, LastUpdate) VALUES ('370001', 'Active', 'San Diego', 'San Diego Unified', 'Balboa Elementary', '54', 'Unified School District', 'ELEM', 'Elementary', 'TRAD', 'Traditional', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EILCode, EILName, EdOpsCode, EdOpsName, LastUpdate) VALUES ('360002', 'Active', 'San Bernardino', 'Fontana Unified', 'Sierra High', '54', 'Unified School District', 'HS', 'High School', 'TRAD', 'Traditional', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EILCode, EILName, EdOpsCode, EdOpsName, LastUpdate) VALUES ('380003', 'Active', 'San Francisco', 'SF Unified', 'Marina Middle', '54', 'Unified School District', 'INTMIDJR', 'Intermediate/Middle/Junior High', 'TRAD', 'Traditional', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EILCode, EILName, EdOpsCode, EdOpsName, LastUpdate) VALUES ('370004', 'Active', 'San Diego', 'Poway Unified', 'Sunset High', '54', 'Unified School District', 'HS', 'High School', 'TRAD', 'Traditional', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EILCode, EILName, EdOpsCode, EdOpsName, LastUpdate) VALUES ('370005', 'Active', 'San Diego', 'Grossmont Union', 'Foothills High', '56', 'High School District', 'HS', 'High School', 'TRAD', 'Traditional', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EILCode, EILName, EdOpsCode, EdOpsName, LastUpdate) VALUES ('370006', 'Active', 'San Diego', 'Chula Vista Elementary', 'Harbor View', '52', 'Elementary School District', 'ELEM', 'Elementary', 'TRAD', 'Traditional', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EILCode, EILName, EdOpsCode, EdOpsName, LastUpdate) VALUES ('370007', 'Active', 'San Diego', 'Oceanside Unified', 'Pacific Elementary', '54', 'Unified School District', 'ELEM', 'Elementary', 'TRAD', 'Traditional', '2020-01-01');
INSERT INTO frpm (CDSCode, "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "School Type", "Educational Option Type", "NSLP Provision Status") VALUES ('370001', '37', 1001, '0001', 'San Diego', 'San Diego Unified', 'Balboa Elem FRPM', 'Elementary Schools (Public)', 'Traditional', 'Breakfast Provision 2');
INSERT INTO frpm (CDSCode, "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "School Type", "Educational Option Type", "NSLP Provision Status") VALUES ('360002', '36', 1002, '0002', 'San Bernardino', 'Fontana Unified', 'Sierra High FRPM', 'High Schools (Public)', 'Traditional', 'Breakfast Provision 2');
INSERT INTO frpm (CDSCode, "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "School Type", "Educational Option Type", "NSLP Provision Status") VALUES ('380003', '38', 1003, '0003', 'San Francisco', 'SF Unified', 'Marina Middle FRPM', 'Intermediate/Middle Schools (Public)', 'Traditional', 'Breakfast Provision 2');
INSERT INTO frpm (CDSCode, "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "School Type", "Educational Option Type", "NSLP Provision Status") VALUES ('370004', '37', 1004, '0004', 'San Diego', 'Poway Unified', 'Sunset High FRPM', 'High Schools (Public)', 'Traditional', 'Lunch Provision 2');
INSERT INTO frpm (CDSCode, "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "School Type", "Educational Option Type", "NSLP Provision Status") VALUES ('370005', '37', 1005, '0005', 'San Diego', 'Grossmont Union', 'Foothills High FRPM', 'High Schools (Public)', 'Traditional', 'Breakfast Provision 1');
INSERT INTO frpm (CDSCode, "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "School Type", "Educational Option Type", "NSLP Provision Status") VALUES ('370006', NULL, 1006, '0006', 'San Diego', 'Chula Vista Elementary', 'Harbor View FRPM', 'Elementary Schools (Public)', 'Traditional', 'Breakfast Provision 2');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('360002', 'S', 'Sierra High', 'Fontana Unified', 'San Bernardino', 400, 200, 480, 490, 470, 90);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.EILName, T2.School FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1."NSLP Provision Status" = 'Breakfast Provision 2' AND T1."County Code" = 37;

/*
Gold Result:
('Elementary', 'Balboa Elementary')
*/

-- Prediction Query
SELECT T1.EILName, T2."School Name" FROM schools AS T1 INNER JOIN frpm AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2."County Code" = '37' AND T2."NSLP Provision Status" = 'Breakfast Provision 2';

/*
Prediction Result:
('Elementary', 'Balboa Elem FRPM')
*/