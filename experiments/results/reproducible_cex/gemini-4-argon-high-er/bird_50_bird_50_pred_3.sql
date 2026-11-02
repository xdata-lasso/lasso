-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES ('1', 'Active', 'C1', 'D1', 'S1', 'Street1', 'Mail1', '00', 'State', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES ('2', 'Active', 'C1', 'D1', 'S2', 'Street2', 'Mail2', '00', 'State', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES ('3', 'Active', 'C1', 'D1', 'S3', 'Street3', 'Mail3', '00', 'State', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES ('4', 'Active', 'C1', 'D1', 'S4', 'Street4', 'Mail4', '00', 'State', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES ('5', 'Active', 'C1', 'D1', 'S5', 'Street5', 'Mail5', '00', 'State', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES ('6', 'Active', 'C1', 'D1', 'S6', 'Street6', 'Mail6', '00', 'State', '2020-01-01');
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, AvgScrMath) VALUES ('1', 'S', 100, 50, 600);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, AvgScrMath) VALUES ('2', 'S', 100, 50, 500);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, AvgScrMath) VALUES ('3', 'S', 100, 50, 400);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, AvgScrMath) VALUES ('4', 'S', 100, 50, 300);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, AvgScrMath) VALUES ('5', 'S', 100, 50, 200);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, AvgScrMath) VALUES ('6', 'S', 100, 50, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.MailStreet, T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode ORDER BY T1.AvgScrMath DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1 OFFSET 5;

/*
Gold Result:
('Mail6', 'S6')
*/

-- Prediction Query
SELECT T2.Street, T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE NOT T1.AvgScrMath IS NULL ORDER BY T1.AvgScrMath DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1 OFFSET 5;

/*
Prediction Result:
('Street6', 'S6')
*/