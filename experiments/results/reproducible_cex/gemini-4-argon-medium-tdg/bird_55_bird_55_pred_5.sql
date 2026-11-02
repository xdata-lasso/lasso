-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic floating-point division (2.0 / 3 = 0.6666...), MailState vs State filtering,
-- extra counties, and outer join vs inner join mutations (not all schools exist in frpm/satscores).
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, State, MailState) VALUES ('101', 'Active', 'Colusa', 'Dist1', '01', 'DocA', '2020-01-01', 'CA', 'CA');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, State, MailState) VALUES ('102', 'Active', 'Colusa', 'Dist2', '01', 'DocA', '2020-01-01', 'NV', 'CA');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, State, MailState) VALUES ('103', 'Active', 'Colusa', 'Dist1', '01', 'DocA', '2020-01-01', 'CA', 'NV');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, State, MailState) VALUES ('104', 'Active', 'Colusa', 'Dist1', '01', 'DocA', '2020-01-01', 'CA', NULL);
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, State, MailState) VALUES ('201', 'Active', 'Humboldt', 'Dist3', '01', 'DocA', '2020-01-01', 'CA', 'CA');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, State, MailState) VALUES ('202', 'Active', 'Humboldt', 'Dist3', '01', 'DocA', '2020-01-01', 'OR', 'CA');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, State, MailState) VALUES ('203', 'Active', 'Humboldt', 'Dist4', '01', 'DocA', '2020-01-01', 'CA', 'CA');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, State, MailState) VALUES ('204', 'Active', 'Humboldt', 'Dist4', '01', 'DocA', '2020-01-01', 'CA', 'OR');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, State, MailState) VALUES ('301', 'Active', 'Alameda', 'Dist5', '01', 'DocA', '2020-01-01', 'CA', 'CA');
INSERT INTO frpm (CDSCode, "County Name") VALUES ('101', 'Colusa');
INSERT INTO frpm (CDSCode, "County Name") VALUES ('201', 'Humboldt');
INSERT INTO satscores (cds, rtype, cname, enroll12, NumTstTakr) VALUES ('101', 'S', 'Colusa', 100, 50);
INSERT INTO satscores (cds, rtype, cname, enroll12, NumTstTakr) VALUES ('201', 'S', 'Humboldt', 120, 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN County = 'Colusa' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN County = 'Humboldt' THEN 1 ELSE 0 END) FROM schools WHERE MailState = 'CA';

/*
Gold Result:
(0.6666666666666666,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN s.County = 'Colusa' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN s.County = 'Humboldt' THEN 1 ELSE 0 END) AS ratio FROM schools AS s WHERE s.State = 'CA';

/*
Prediction Result:
(1.0,)
*/