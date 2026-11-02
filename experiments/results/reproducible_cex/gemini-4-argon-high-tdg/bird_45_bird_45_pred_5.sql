-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('1001', 'Active', 'CountyA', 'DistA', 'Alpha High', '01', 'DocA', 'Ricci', 'Ulrich', 'Jane', 'Doe', 'Bob', 'Smith', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('1002', 'Active', 'CountyA', 'DistA', 'Beta High', '01', 'DocA', 'Ricci', 'NotUlrich', NULL, NULL, NULL, NULL, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('1003', 'Active', 'CountyA', 'DistA', 'Gamma High', '01', 'DocA', 'NotRicci', 'Ulrich', NULL, NULL, NULL, NULL, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('1004', 'Active', 'CountyA', 'DistA', 'Delta High', '01', 'DocA', 'Other', 'Person', 'Ricci', 'Ulrich', 'Ricci', 'Ulrich', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('1005', 'Active', 'CountyA', 'DistA', 'Epsilon High', '01', 'DocA', 'Ulrich', 'Ricci', NULL, NULL, NULL, NULL, '2020-01-01');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('1001', 'S', 'Wrong Sat Name', 'DistA', 'CountyA', 100, 80, 400, 500, 600, 50);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('1002', 'S', 'Alpha High', 'DistA', 'CountyA', 120, 90, 410, 510, 450, 40);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('1003', 'S', 'Gamma High', 'DistA', 'CountyA', 130, 85, 420, 520, 460, 45);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('1004', 'S', 'Delta High', 'DistA', 'CountyA', 140, 95, 430, 530, 470, 55);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('1005', 'S', 'Epsilon High', 'DistA', 'CountyA', 150, 75, 440, 540, 480, 35);
INSERT INTO frpm (CDSCode, "School Name") VALUES ('1002', 'Beta High');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School, T1.AvgScrWrite FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.AdmFName1 = 'Ricci' AND T2.AdmLName1 = 'Ulrich';

/*
Gold Result:
('Alpha High', 600)
*/

-- Prediction Query
SELECT T1.sname, AVG(T1.AvgScrWrite) AS AverageWritingScore FROM satscores AS T1 INNER JOIN schools AS T3 ON T1.cds = T3.CDSCode WHERE T3.AdmFName1 = 'Ricci' AND T3.AdmLName1 = 'Ulrich' GROUP BY T1.sname;

/*
Prediction Result:
('Wrong Sat Name', 600.0)
*/