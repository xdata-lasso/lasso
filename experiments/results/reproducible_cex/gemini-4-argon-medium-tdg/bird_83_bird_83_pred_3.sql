-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core group by, multiple rows in one city, single row in another, and boundary/single-condition failures
INSERT INTO schools (CDSCode, StatusType, County, District, City, DOC, DOCType, GSoffered, GSserved, Magnet, LastUpdate) VALUES ('S1', 'Active', 'C1', 'D1', 'Los Angeles', '01', 'District', 'K-8', 'K-12', 1, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, DOC, DOCType, GSoffered, GSserved, Magnet, LastUpdate) VALUES ('S2', 'Active', 'C1', 'D1', 'Los Angeles', '01', 'District', 'K-8', 'K-8', 1, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, DOC, DOCType, GSoffered, GSserved, Magnet, LastUpdate) VALUES ('S3', 'Active', 'C2', 'D2', 'San Diego', '01', 'District', 'K-8', 'K-8', 1, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, DOC, DOCType, GSoffered, GSserved, Magnet, LastUpdate) VALUES ('S4', 'Active', 'C1', 'D1', 'Los Angeles', '01', 'District', 'K-8', 'K-8', 0, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, DOC, DOCType, GSoffered, GSserved, Magnet, LastUpdate) VALUES ('S5', 'Active', 'C1', 'D1', 'Los Angeles', '01', 'District', 'K-12', 'K-8', 1, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, DOC, DOCType, GSoffered, GSserved, Magnet, LastUpdate) VALUES ('S6', 'Active', 'C1', 'D1', 'Los Angeles', '01', 'District', 'K-8', 'K-8', 1, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, DOC, DOCType, GSoffered, GSserved, Magnet, LastUpdate) VALUES ('S7', 'Active', 'C3', 'D3', 'Fresno', '01', 'District', 'K-8', 'K-8', 1, '2020-01-01');
INSERT INTO frpm (CDSCode, "NSLP Provision Status") VALUES ('S1', 'Multiple Provision Types');
INSERT INTO frpm (CDSCode, "NSLP Provision Status") VALUES ('S2', 'Multiple Provision Types');
INSERT INTO frpm (CDSCode, "NSLP Provision Status") VALUES ('S3', 'Multiple Provision Types');
INSERT INTO frpm (CDSCode, "NSLP Provision Status") VALUES ('S4', 'Multiple Provision Types');
INSERT INTO frpm (CDSCode, "NSLP Provision Status") VALUES ('S5', 'Multiple Provision Types');
INSERT INTO frpm (CDSCode, "NSLP Provision Status") VALUES ('S6', 'Provision 2');
-- S7 intentionally omitted from frpm to test INNER JOIN vs LEFT JOIN;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.City, COUNT(T2.CDSCode) FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.Magnet = 1 AND T2.GSoffered = 'K-8' AND T1."NSLP Provision Status" = 'Multiple Provision Types' GROUP BY T2.City;

/*
Gold Result:
('Los Angeles', 2)
('San Diego', 1)
*/

-- Prediction Query
SELECT City, COUNT(School) FROM schools WHERE GSoffered = 'K-8' AND Magnet = 1 GROUP BY City;

/*
Prediction Result:
('Fresno', 0)
('Los Angeles', 0)
('San Diego', 0)
*/