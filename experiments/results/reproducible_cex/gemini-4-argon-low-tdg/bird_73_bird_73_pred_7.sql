-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic predicate logic (AND vs OR), partial condition matching, and column confusion (e.g., FRPM Count (K-12) vs Ages 5-17, Street vs MailStreet, SOC vs SOCType).
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, MailStreet, Street, MailStrAbr, SOCType, SOC, DOCType) VALUES ('CDS1', 'Active', 'County1', 'Dist1', '00', 'Other', '2020-01-01', 'PO Box 1040', 'Wrong Street', 'Wrong Abr', 'Youth Authority Facilities', 'Wrong SOC', 'Other');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, MailStreet, Street, MailStrAbr, SOCType, SOC) VALUES ('CDS2', 'Active', 'County1', 'Dist1', '00', 'Other', '2020-01-01', 'PO Box 1040', 'PO Box 1040', 'PO Box 1040', 'Other Type', 'Youth Authority Facilities');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, MailStreet, Street, MailStrAbr, SOCType, SOC) VALUES ('CDS3', 'Active', 'County1', 'Dist1', '00', 'Other', '2020-01-01', 'Other Box', 'PO Box 1040', 'PO Box 1040', 'Youth Authority Facilities', 'Youth Authority Facilities');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, MailStreet, Street, MailStrAbr, SOCType, SOC) VALUES ('CDS4', 'Active', 'County1', 'Dist1', '00', 'Other', '2020-01-01', NULL, 'PO Box 1040', 'PO Box 1040', NULL, 'Youth Authority Facilities');
INSERT INTO frpm (CDSCode, "FRPM Count (Ages 5-17)", "FRPM Count (K-12)", "Free Meal Count (Ages 5-17)", "Enrollment (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS1', 150.0, 250.0, 100.0, 300.0, 50.0);
INSERT INTO frpm (CDSCode, "FRPM Count (Ages 5-17)", "FRPM Count (K-12)", "Free Meal Count (Ages 5-17)", "Enrollment (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS2', 999.0, 999.0, 999.0, 999.0, 99.0);
INSERT INTO frpm (CDSCode, "FRPM Count (Ages 5-17)", "FRPM Count (K-12)", "Free Meal Count (Ages 5-17)", "Enrollment (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS3', 888.0, 888.0, 888.0, 888.0, 88.0);
INSERT INTO frpm (CDSCode, "FRPM Count (Ages 5-17)", "FRPM Count (K-12)", "Free Meal Count (Ages 5-17)", "Enrollment (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS4', 777.0, 777.0, 777.0, 777.0, 77.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1."FRPM Count (Ages 5-17)" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.MailStreet = 'PO Box 1040' AND T2.SOCType = 'Youth Authority Facilities';

/*
Gold Result:
(150.0,)
*/

-- Prediction Query
SELECT T1."FRPM Count (Ages 5-17)" FROM frpm AS T1 JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2."EdOpsName" = 'Youth Authority School' AND T2."MailStreet" = 'PO Box 1040';

/*
Prediction Result:
*/