-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, City, Magnet, GSoffered, GSserved, Charter, MailCity) VALUES ('1', 'Active', 'Alameda', 'D1', '01', 'District', '2020-01-01', 'Los Angeles', 1, 'K-8', 'K-12', 0, 'MailLA');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, City, Magnet, GSoffered, GSserved, Charter, MailCity) VALUES ('2', 'Active', 'Alameda', 'D1', '01', 'District', '2020-01-01', 'Los Angeles', 1, 'K-8', 'K-8', 1, 'MailLA2');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, City, Magnet, GSoffered, GSserved, Charter, MailCity) VALUES ('3', 'Active', 'Alameda', 'D1', '01', 'District', '2020-01-01', 'San Diego', 1, 'K-8', '9-12', 0, 'MailSD');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, City, Magnet, GSoffered, GSserved, Charter, MailCity) VALUES ('4', 'Active', 'Alameda', 'D1', '01', 'District', '2020-01-01', 'San Jose', 0, 'K-8', 'K-8', 1, 'MailSJ');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, City, Magnet, GSoffered, GSserved, Charter, MailCity) VALUES ('5', 'Active', 'Alameda', 'D1', '01', 'District', '2020-01-01', 'Fresno', 1, 'K-12', 'K-8', 1, 'MailFR');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, City, Magnet, GSoffered, GSserved, Charter, MailCity) VALUES ('6', 'Active', 'Alameda', 'D1', '01', 'District', '2020-01-01', 'Sacramento', 1, 'K-8', 'K-8', 1, 'MailSAC');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, City, Magnet, GSoffered, GSserved, Charter, MailCity) VALUES ('7', 'Active', 'Alameda', 'D1', '01', 'District', '2020-01-01', 'Oakland', 1, 'K-8', 'K-8', 1, 'MailOAK');
INSERT INTO frpm (CDSCode, "NSLP Provision Status") VALUES ('1', 'Multiple Provision Types');
INSERT INTO frpm (CDSCode, "NSLP Provision Status") VALUES ('2', 'Multiple Provision Types');
INSERT INTO frpm (CDSCode, "NSLP Provision Status") VALUES ('3', 'Multiple Provision Types');
INSERT INTO frpm (CDSCode, "NSLP Provision Status") VALUES ('4', 'Multiple Provision Types');
INSERT INTO frpm (CDSCode, "NSLP Provision Status") VALUES ('5', 'Multiple Provision Types');
INSERT INTO frpm (CDSCode, "NSLP Provision Status") VALUES ('6', 'Provision 2');
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
('Los Angeles', 0)
('Oakland', 0)
('Sacramento', 0)
('San Diego', 0)
*/