-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic matching, boundary values for SOC (30, 31, 32), NULL SOC, duplicate NCESDist values (kills DISTINCT), and missing foreign key rows in child tables (kills INNER JOIN mutants).
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('CDS001', 'DIST_100', 'SCH_1', 'Active', 'Alameda', 'Dist A', 'Sch 1', '31', 'TypeA', '31', 'Elem', '2020-01-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('CDS002', 'DIST_100', 'SCH_2', 'Closed', 'Alameda', 'Dist A', 'Sch 2', '00', 'TypeA', '31', 'Elem', '2020-01-02');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('CDS003', 'DIST_200', 'SCH_3', 'Active', 'Butte', 'Dist B', 'Sch 3', '31', 'TypeB', '30', 'High', '2020-01-03');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('CDS004', 'DIST_300', 'SCH_4', 'Active', 'Butte', 'Dist B', 'Sch 4', '31', 'TypeB', '32', 'Mid', '2020-01-04');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('CDS005', 'DIST_400', 'SCH_5', 'Active', 'Butte', 'Dist B', 'Sch 5', '31', 'TypeB', NULL, 'None', '2020-01-05');
INSERT INTO frpm (CDSCode, "District Code", "School Code") VALUES ('CDS001', 31, '31');
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('CDS003', 'S', 100, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NCESDist FROM schools WHERE SOC = 31;

/*
Gold Result:
('DIST_100',)
('DIST_100',)
*/

-- Prediction Query
SELECT NCESSchool FROM schools WHERE SOC = 31;

/*
Prediction Result:
('SCH_1',)
('SCH_2',)
*/