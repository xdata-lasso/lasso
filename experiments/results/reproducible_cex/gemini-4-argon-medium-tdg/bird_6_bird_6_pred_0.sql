-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, DOC, DOCType, Magnet, LastUpdate) VALUES ('CDS001', 'Active', 'Los Angeles', 'LAUSD', 'Target School_Sch', 0, '54', 'Unified', 1, '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, DOC, DOCType, Magnet, LastUpdate) VALUES ('CDS002', 'Active', 'Los Angeles', 'LAUSD', 'Boundary 500 School', 0, '54', 'Unified', 1, '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, DOC, DOCType, Magnet, LastUpdate) VALUES ('CDS003', 'Active', 'Los Angeles', 'LAUSD', 'Low Test Takers School', 0, '54', 'Unified', 1, '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, DOC, DOCType, Magnet, LastUpdate) VALUES ('CDS004', 'Active', 'Los Angeles', 'LAUSD', 'Non Magnet School', 1, '54', 'Unified', 0, '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, DOC, DOCType, Magnet, LastUpdate) VALUES ('CDS005', 'Active', 'Los Angeles', 'LAUSD', 'Null Magnet School', 0, '54', 'Unified', NULL, '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, DOC, DOCType, Magnet, LastUpdate) VALUES ('CDS006', 'Active', 'Los Angeles', 'LAUSD', 'Unjoined School', 0, '54', 'Unified', 1, '2023-01-01');
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('CDS001', 'S', 'Target School_SAT', 100, 501, 200);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('CDS002', 'S', 'Boundary 500_SAT', 600, 500, 600);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('CDS003', 'S', 'Low Test Takers_SAT', 600, 499, 600);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('CDS004', 'S', 'Non Magnet_SAT', 800, 700, 400);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('CDS005', 'S', 'Null Magnet_SAT', 800, 700, 400);
INSERT INTO frpm (CDSCode, "School Name", "Charter School (Y/N)", IRC) VALUES ('CDS004', 'Non Magnet_FRPM', 1, 1);
INSERT INTO frpm (CDSCode, "School Name", "Charter School (Y/N)", IRC) VALUES ('CDS002', 'Boundary 500_FRPM', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.Magnet = 1 AND T1.NumTstTakr > 500;

/*
Gold Result:
('Target School_Sch',)
*/

-- Prediction Query
SELECT sname FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T1.NumTstTakr > 500 AND T2.Magnet = 1;

/*
Prediction Result:
('Target School_SAT',)
*/