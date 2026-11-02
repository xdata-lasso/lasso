-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('CDS001', 'Active', 'CountyA', 'DistrictA', 'SchoolTrue', '00', 'DocTypeA', 'Ricci', 'Ulrich', 'OtherF2', 'OtherL2', 'OtherF3', 'OtherL3', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('CDS002', 'Active', 'CountyA', 'DistrictA', 'SchoolOnlyFirst', '00', 'DocTypeA', 'Ricci', 'Smith', 'Ricci', 'Ulrich', 'OtherF3', 'OtherL3', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('CDS003', 'Active', 'CountyB', 'DistrictB', 'SchoolOnlyLast', '00', 'DocTypeB', 'John', 'Ulrich', 'OtherF2', 'OtherL2', 'Ricci', 'Ulrich', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('CDS004', 'Active', 'CountyB', 'DistrictB', 'SchoolSwapped', '00', 'DocTypeB', 'Ulrich', 'Ricci', NULL, NULL, NULL, NULL, '2023-01-01');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('CDS001', 'S', 'WrongSName1', 'DistrictA', 'CountyA', 100, 50, 510, 520, 530, 25);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('CDS002', 'S', 'WrongSName2', 'DistrictA', 'CountyA', 120, 60, 410, 420, 430, 15);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('CDS003', 'S', 'WrongSName3', 'DistrictB', 'CountyB', 140, 70, 610, 620, 630, 35);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('CDS004', 'S', 'WrongSName4', 'DistrictB', 'CountyB', 160, 80, 310, 320, 330, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School, T1.AvgScrWrite FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.AdmFName1 = 'Ricci' AND T2.AdmLName1 = 'Ulrich';

/*
Gold Result:
('SchoolTrue', 530)
*/

-- Prediction Query
SELECT T1.School, AVG(T2.AvgScrWrite) AS AvgWritingScore FROM schools AS T1 INNER JOIN satscores AS T2 ON T1.CDSCode = T2.cds AND T1.School = T2.sname WHERE T1.AdmFName1 = 'Ricci' AND T1.AdmLName1 = 'Ulrich' GROUP BY T1.School;

/*
Prediction Result:
*/