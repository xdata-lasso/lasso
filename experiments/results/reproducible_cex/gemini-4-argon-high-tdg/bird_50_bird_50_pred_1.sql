-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, MailStreet, MailStrAbr, DOC, DOCType, LastUpdate) VALUES ('00000000000001', 'Active', 'CountyA', 'DistA', 'Alpha School', '10 Real St', '10 Real', '10 Mail St', '10 Mail', '01', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, MailStreet, MailStrAbr, DOC, DOCType, LastUpdate) VALUES ('00000000000002', 'Active', 'CountyB', 'DistB', 'Beta School', '20 Real St', '20 Real', '20 Mail St', '20 Mail', '01', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, MailStreet, MailStrAbr, DOC, DOCType, LastUpdate) VALUES ('00000000000003', 'Active', 'CountyC', 'DistC', 'Gamma School', '30 Real St', '30 Real', '30 Mail St', '30 Mail', '01', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, MailStreet, MailStrAbr, DOC, DOCType, LastUpdate) VALUES ('00000000000004', 'Active', 'CountyD', 'DistD', 'Delta School', '40 Real St', '40 Real', '40 Mail St', '40 Mail', '01', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, MailStreet, MailStrAbr, DOC, DOCType, LastUpdate) VALUES ('00000000000005', 'Active', 'CountyE', 'DistE', 'Epsilon School', '50 Real St', '50 Real', '50 Mail St', '50 Mail', '01', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, MailStreet, MailStrAbr, DOC, DOCType, LastUpdate) VALUES ('00000000000006', 'Active', 'CountyF', 'DistF', 'Zeta School', '60 Real St', '60 Real', '60 Mail St', '60 Mail', '01', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, MailStreet, MailStrAbr, DOC, DOCType, LastUpdate) VALUES ('00000000000007', 'Active', 'CountyG', 'DistG', 'Eta School', '70 Real St', '70 Real', '70 Mail St', '70 Mail', '01', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, MailStreet, MailStrAbr, DOC, DOCType, LastUpdate) VALUES ('00000000000008', 'Active', 'CountyH', 'DistH', 'Theta School', '80 Real St', '80 Real', '80 Mail St', '80 Mail', '01', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, MailStreet, MailStrAbr, DOC, DOCType, LastUpdate) VALUES ('00000000000000', 'Active', 'CountyZ', 'DistZ', 'Unmatched Early', '00 Real St', '00 Real', '00 Mail St', '00 Mail', '01', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, MailStreet, MailStrAbr, DOC, DOCType, LastUpdate) VALUES ('00000000000099', 'Active', 'CountyY', 'DistY', 'Unmatched Late', '99 Real St', '99 Real', '99 Mail St', '99 Mail', '01', 'TypeA', '2020-01-01');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000004', 'S', 'SAT Delta', 'DistD', 'CountyD', 100, 50, 400, 1002, 400, 10);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000002', 'S', 'SAT Beta', 'DistB', 'CountyB', 800, 400, 700, 1001, 700, 200);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000007', 'S', 'SAT Eta', 'DistG', 'CountyG', 200, 150, 650, 750, 500, 90);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000001', 'S', 'SAT Alpha', 'DistA', 'CountyA', 500, 300, 500, 700, 650, 120);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000008', 'S', 'SAT Theta', 'DistH', 'CountyH', 300, 250, 550, 650, 600, 80);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000003', 'S', 'SAT Gamma', 'DistC', 'CountyC', 900, 100, 800, 600, 800, 95);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000006', 'S', 'SAT Zeta', 'DistF', 'CountyF', 400, 200, 600, 550, 550, 60);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('00000000000005', 'S', 'SAT Epsilon', 'DistE', 'CountyE', 600, 350, 750, 500, 750, 150);
INSERT INTO frpm (CDSCode, "School Name") VALUES ('00000000000005', 'FRPM Epsilon');
INSERT INTO frpm (CDSCode, "School Name") VALUES ('00000000000006', 'FRPM Zeta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.MailStreet, T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode ORDER BY T1.AvgScrMath DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1 OFFSET 5;

/*
Gold Result:
('30 Mail St', 'Gamma School')
*/

-- Prediction Query
SELECT schools.Street, schools.School FROM schools INNER JOIN satscores ON schools.CDSCode = satscores.cds ORDER BY satscores.AvgScrMath DESC, schools.cdscode NULLS LAST, satscores.cds NULLS LAST LIMIT 1 OFFSET 6;

/*
Prediction Result:
('60 Real St', 'Zeta School')
*/