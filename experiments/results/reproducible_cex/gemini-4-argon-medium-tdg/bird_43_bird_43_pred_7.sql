-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by the sum of all three SAT scores, verifying that individual low scores in Math, Read, or Write do not incorrectly determine the minimum total score, and filters out NULL AvgScrMath.
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S001', 'Active', 'County_LowMath_HighTotal', 'Dist1', '01', 'DocA', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S002', 'Active', 'County_LowRead_HighTotal', 'Dist1', '01', 'DocA', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S003', 'Active', 'County_LowWrite_HighTotal', 'Dist1', '01', 'DocA', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S004', 'Active', 'County_Winner_LowestTotal', 'Dist1', '01', 'DocA', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S005', 'Active', 'County_NullMath', 'Dist1', '01', 'DocA', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S006', 'Active', 'County_NoSAT', 'Dist1', '01', 'DocA', '2023-01-01');
INSERT INTO satscores (cds, rtype, cname, enroll12, NumTstTakr, AvgScrMath, AvgScrRead, AvgScrWrite, NumGE1500) VALUES ('S001', 'S', 'WrongCounty1', 100, 50, 200, 600, 600, 10);
INSERT INTO satscores (cds, rtype, cname, enroll12, NumTstTakr, AvgScrMath, AvgScrRead, AvgScrWrite, NumGE1500) VALUES ('S002', 'S', 'WrongCounty2', 100, 50, 600, 200, 600, 10);
INSERT INTO satscores (cds, rtype, cname, enroll12, NumTstTakr, AvgScrMath, AvgScrRead, AvgScrWrite, NumGE1500) VALUES ('S003', 'S', 'WrongCounty3', 100, 50, 600, 600, 200, 10);
INSERT INTO satscores (cds, rtype, cname, enroll12, NumTstTakr, AvgScrMath, AvgScrRead, AvgScrWrite, NumGE1500) VALUES ('S004', 'S', 'WrongCounty4', 100, 50, 350, 350, 350, 5);
INSERT INTO satscores (cds, rtype, cname, enroll12, NumTstTakr, AvgScrMath, AvgScrRead, AvgScrWrite, NumGE1500) VALUES ('S005', 'S', 'WrongCounty5', 100, 50, NULL, 200, 200, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.AvgScrMath, T2.County FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE NOT T1.AvgScrMath IS NULL ORDER BY T1.AvgScrMath + T1.AvgScrRead + T1.AvgScrWrite ASC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
(350, 'County_Winner_LowestTotal')
*/

-- Prediction Query
SELECT T2.AvgScrMath, T2.cname FROM (SELECT cds, AvgScrMath + AvgScrRead + AvgScrWrite AS total_score FROM satscores ORDER BY total_score ASC, satscores.cds NULLS LAST LIMIT 1) AS T1 INNER JOIN satscores AS T2 ON T1.cds = T2.cds;

/*
Prediction Result:
(None, 'WrongCounty5')
*/