-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, Charter, Magnet, LastUpdate) VALUES ('00000000000001', 'Active', 'Alameda', 'Dist 1', 'Real School 1', '54', 'Unified', 'F', 0, 0, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, Charter, Magnet, LastUpdate) VALUES ('00000000000002', 'Active', 'Alameda', 'Dist 1', 'Real School 2', '54', 'Unified', 'F', 1, 0, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, Charter, Magnet, LastUpdate) VALUES ('00000000000003', 'Active', 'Alameda', 'Dist 1', 'Real School 3', '54', 'Unified', 'F', 0, 1, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, Charter, Magnet, LastUpdate) VALUES ('00000000000004', 'Active', 'Alameda', 'Dist 1', 'Real School 4', '54', 'Unified', 'F', 1, 1, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, Charter, Magnet, LastUpdate) VALUES ('00000000000005', 'Active', 'Alameda', 'Dist 1', 'Real School 5', '54', 'Unified', 'F', NULL, NULL, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, Charter, Magnet, LastUpdate) VALUES ('00000000000006', 'Active', 'Alameda', 'Dist 1', 'Real School 6', '54', 'Unified', 'F', 0, 0, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, Charter, Magnet, LastUpdate) VALUES ('00000000000007', 'Active', 'Alameda', 'Dist 1', 'Real School 7', '54', 'Unified', 'F', 0, 0, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, Charter, Magnet, LastUpdate) VALUES ('00000000000008', 'Active', 'Alameda', 'Dist 1', 'Virtual V School', '54', 'Unified', 'V', 0, 0, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, Charter, Magnet, LastUpdate) VALUES ('00000000000009', 'Active', 'Alameda', 'Dist 1', 'Virtual C School', '54', 'Unified', 'C', 0, 0, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, Charter, Magnet, LastUpdate) VALUES ('00000000000010', 'Active', 'Alameda', 'Dist 1', 'Virtual N School', '54', 'Unified', 'N', 0, 0, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, Charter, Magnet, LastUpdate) VALUES ('00000000000011', 'Active', 'Alameda', 'Dist 1', 'Virtual NULL School', '54', 'Unified', NULL, 0, 0, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, Charter, Magnet, LastUpdate) VALUES ('00000000000012', 'Active', 'Alameda', 'Dist 1', 'Virtual Lowercase f', '54', 'Unified', 'f', 0, 0, '2020-01-01');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000001', 'S', 'SAT Name 1', 'Dist 1', 'Alameda', 100, 50, 700, 200, 200, 10);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000002', 'S', 'SAT Name 2', 'Dist 1', 'Alameda', 500, 400, 650, 800, 300, 350);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000003', 'S', 'SAT Name 3', 'Dist 1', 'Alameda', 200, 150, 600, 300, 800, 50);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000004', 'S', 'SAT Name 4', 'Dist 1', 'Alameda', 800, 700, 550, 400, 400, 600);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000005', 'S', 'SAT Name 5', 'Dist 1', 'Alameda', 300, 250, 500, 500, 500, 100);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000006', 'S', 'SAT Name 6', 'Dist 1', 'Alameda', 900, 850, 450, 750, 750, 800);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000007', 'S', 'SAT Name 7', 'Dist 1', 'Alameda', 950, 900, 95, 790, 790, 850);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000008', 'S', 'SAT Name 8', 'Dist 1', 'Alameda', 400, 390, 795, 795, 795, 380);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000009', 'S', 'SAT Name 9', 'Dist 1', 'Alameda', 400, 390, 790, 790, 790, 380);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000010', 'S', 'SAT Name 10', 'Dist 1', 'Alameda', 400, 390, 785, 785, 785, 380);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000011', 'S', 'SAT Name 11', 'Dist 1', 'Alameda', 400, 390, 780, 780, 780, 380);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000012', 'S', 'SAT Name 12', 'Dist 1', 'Alameda', 400, 390, 775, 775, 775, 380);
INSERT INTO frpm (CDSCode, "School Name") VALUES ('00000000000001', 'FRPM Name 1');
INSERT INTO frpm (CDSCode, "School Name") VALUES ('00000000000003', 'FRPM Name 3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.Virtual = 'F' ORDER BY T1.AvgScrRead DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 5;

/*
Gold Result:
('Real School 1',)
('Real School 2',)
('Real School 3',)
('Real School 4',)
('Real School 5',)
*/

-- Prediction Query
SELECT T1.School FROM schools AS T1 INNER JOIN satscores AS T2 ON T1.CDSCode = T2.cds WHERE T1.Virtual = 'F' AND T2.AvgScrRead IN (SELECT T3.AvgScrRead FROM satscores AS T3 WHERE T3.cname = T2.cname ORDER BY T3.AvgScrRead DESC, T3.cds NULLS LAST LIMIT 5);

/*
Prediction Result:
*/