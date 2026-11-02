-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Comprehensive dataset:
-- Tests floating-point division vs integer division (1 / 2 = 0.5 vs 0)
-- Tests MailState vs State filter (CA vs NV/OR/NULL)
-- Tests County filter in numerator/denominator vs total row count (Alameda included)
-- Tests schools vs frpm/satscores tables (disjoint and overlapping rows, contradicting County Name/cname)
-- Tests COUNT(DISTINCT School) vs SUM(1) via duplicate School names and NULL School names
INSERT INTO schools (CDSCode, StatusType, County, District, School, State, MailState, DOC, DOCType, LastUpdate) VALUES ('1', 'Active', 'Colusa', 'Dist1', 'SchA', 'NV', 'CA', '00', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, State, MailState, DOC, DOCType, LastUpdate) VALUES ('2', 'Active', 'Humboldt', 'Dist2', 'SchA', 'CA', 'CA', '00', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, State, MailState, DOC, DOCType, LastUpdate) VALUES ('3', 'Active', 'Humboldt', 'Dist2', NULL, 'OR', 'CA', '00', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, State, MailState, DOC, DOCType, LastUpdate) VALUES ('4', 'Active', 'Alameda', 'Dist3', 'SchB', 'CA', 'CA', '00', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, State, MailState, DOC, DOCType, LastUpdate) VALUES ('5', 'Active', 'Colusa', 'Dist1', 'SchC', 'CA', 'NV', '00', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, State, MailState, DOC, DOCType, LastUpdate) VALUES ('6', 'Active', 'Colusa', 'Dist1', 'SchD', 'CA', NULL, '00', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, State, MailState, DOC, DOCType, LastUpdate) VALUES ('7', 'Closed', 'Humboldt', 'Dist2', 'SchE', 'CA', 'NV', '00', 'TypeA', '2020-01-01');
INSERT INTO frpm (CDSCode, "County Name", "School Name") VALUES ('1', 'Humboldt', 'SchA');
INSERT INTO frpm (CDSCode, "County Name", "School Name") VALUES ('5', 'Colusa', 'SchC');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr) VALUES ('2', 'S', 'SchA', 'Dist2', 'Colusa', 100, 50);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr) VALUES ('7', 'S', 'SchE', 'Dist2', 'Humboldt', 100, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN County = 'Colusa' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN County = 'Humboldt' THEN 1 ELSE 0 END) FROM schools WHERE MailState = 'CA';

/*
Gold Result:
(0.5,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN s.County = 'Colusa' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN s.County = 'Humboldt' THEN 1 ELSE 0 END) AS ratio FROM schools AS s WHERE s.State = 'CA';

/*
Prediction Result:
(1.0,)
*/