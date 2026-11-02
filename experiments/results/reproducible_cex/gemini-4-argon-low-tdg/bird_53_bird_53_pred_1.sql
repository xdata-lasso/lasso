-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests column confusion (MailCity vs City vs County vs cname), INNER JOIN vs LEFT JOIN (school without satscores), and duplicate NumTstTakr values (SELECT vs SELECT DISTINCT).
INSERT INTO schools (CDSCode, StatusType, County, District, City, MailCity, DOC, DOCType, LastUpdate) VALUES ('10001', 'Active', 'Madera', 'Dist1', 'Clovis', 'Fresno', '01', 'DocA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, MailCity, DOC, DOCType, LastUpdate) VALUES ('10002', 'Active', 'Madera', 'Dist2', 'Clovis', 'Fresno', '01', 'DocA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, MailCity, DOC, DOCType, LastUpdate) VALUES ('10003', 'Active', 'Fresno', 'Fresno', 'Fresno', 'Clovis', '01', 'DocA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, City, MailCity, DOC, DOCType, LastUpdate) VALUES ('10004', 'Active', 'Fresno', 'Dist4', 'Clovis', 'Fresno', '01', 'DocA', '2020-01-01');
INSERT INTO satscores (cds, rtype, cname, enroll12, NumTstTakr, NumGE1500) VALUES ('10001', 'S', 'Madera', 500, 120, 50);
INSERT INTO satscores (cds, rtype, cname, enroll12, NumTstTakr, NumGE1500) VALUES ('10002', 'S', 'Madera', 600, 120, 60);
INSERT INTO satscores (cds, rtype, cname, enroll12, NumTstTakr, NumGE1500) VALUES ('10003', 'S', 'Fresno', 700, 250, 70);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.NumTstTakr FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.MailCity = 'Fresno';

/*
Gold Result:
(120,)
(120,)
*/

-- Prediction Query
SELECT SUM(satscores.NumTstTakr) AS TotalTestTakers FROM satscores INNER JOIN schools ON satscores.cds = schools.CDSCode WHERE schools.MailCity = 'Fresno';

/*
Prediction Result:
(240,)
*/