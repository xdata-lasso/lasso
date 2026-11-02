-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1: Comprehensive test for LIMIT 5, WHERE Virtual = 'F', INNER JOIN vs OUTER JOIN, column disambiguation (School vs sname), and score column disambiguation (AvgScrRead vs Math/Write).
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, LastUpdate) VALUES ('CDS01', 'Active', 'C1', 'D1', 'Alpha High', '01', 'Doc', 'F', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, LastUpdate) VALUES ('CDS02', 'Active', 'C1', 'D1', 'Beta High', '01', 'Doc', 'F', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, LastUpdate) VALUES ('CDS03', 'Active', 'C1', 'D1', 'Gamma High', '01', 'Doc', 'F', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, LastUpdate) VALUES ('CDS04', 'Active', 'C1', 'D1', 'Delta High', '01', 'Doc', 'F', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, LastUpdate) VALUES ('CDS05', 'Active', 'C1', 'D1', 'Epsilon High', '01', 'Doc', 'F', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, LastUpdate) VALUES ('CDS06', 'Active', 'C1', 'D1', 'Zeta High', '01', 'Doc', 'F', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, LastUpdate) VALUES ('CDS07', 'Active', 'C1', 'D1', 'Virtual V High', '01', 'Doc', 'V', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, LastUpdate) VALUES ('CDS08', 'Active', 'C1', 'D1', 'Virtual Null High', '01', 'Doc', NULL, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, LastUpdate) VALUES ('CDS09', 'Active', 'C1', 'D1', 'No SAT High', '01', 'Doc', 'F', '2020-01-01');
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS01', 'S', 'Wrong Alpha', 100, 50, 600, 400, 400);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS02', 'S', 'Wrong Beta', 100, 50, 580, 420, 420);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS03', 'S', 'Wrong Gamma', 100, 50, 560, 440, 440);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS04', 'S', 'Wrong Delta', 100, 50, 540, 460, 460);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS05', 'S', 'Wrong Epsilon', 100, 50, 520, 480, 480);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS06', 'S', 'Wrong Zeta', 100, 50, 500, 700, 700);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS07', 'S', 'Wrong Virtual V', 100, 50, 800, 800, 800);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite) VALUES ('CDS08', 'S', 'Wrong Virtual Null', 100, 50, 790, 790, 790);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.Virtual = 'F' ORDER BY T1.AvgScrRead DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 5;

/*
Gold Result:
('Alpha High',)
('Beta High',)
('Gamma High',)
('Delta High',)
('Epsilon High',)
*/

-- Prediction Query
SELECT sname FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.Virtual = 'F' ORDER BY T1.AvgScrRead DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 5;

/*
Prediction Result:
('Wrong Alpha',)
('Wrong Beta',)
('Wrong Gamma',)
('Wrong Delta',)
('Wrong Epsilon',)
*/