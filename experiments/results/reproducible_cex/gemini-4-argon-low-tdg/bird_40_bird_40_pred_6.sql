-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core test: Multiple matching rows in Fresno Unified, NULL AvgScrRead, non-matching District, and a school with no SAT scores.
-- Tests: INNER JOIN vs LEFT JOIN, WHERE District = 'Fresno Unified', NOT AvgScrRead IS NULL, ORDER BY AvgScrRead ASC vs DESC, LIMIT 1, and wrong score columns (Math/Write).
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Phone) VALUES ('101', 'Active', 'Fresno', 'Fresno Unified', '01', 'District', '2020-01-01', '559-000-0101');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Phone) VALUES ('102', 'Active', 'Fresno', 'Fresno Unified', '01', 'District', '2020-01-01', '559-000-0102');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Phone) VALUES ('103', 'Active', 'Fresno', 'Fresno Unified', '01', 'District', '2020-01-01', '559-000-0103');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Phone) VALUES ('104', 'Active', 'Fresno', 'Clovis Unified', '01', 'District', '2020-01-01', '559-000-0104');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Phone) VALUES ('105', 'Active', 'Fresno', 'Fresno Unified', '01', 'District', '2020-01-01', '559-000-0105');
INSERT INTO satscores (cds, rtype, dname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('101', 'S', 'Other District', 100, 50, NULL, 200, 200, 10);
INSERT INTO satscores (cds, rtype, dname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('102', 'S', 'Other District', 200, 100, 500, 300, 300, 20);
INSERT INTO satscores (cds, rtype, dname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('103', 'S', 'Other District', 150, 80, 400, 600, 600, 30);
INSERT INTO satscores (cds, rtype, dname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('104', 'S', 'Fresno Unified', 120, 60, 300, 400, 400, 15);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Phone FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.District = 'Fresno Unified' AND NOT T1.AvgScrRead IS NULL ORDER BY T1.AvgScrRead ASC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
('559-000-0103',)
*/

-- Prediction Query
SELECT phone FROM schools WHERE cdscode = (SELECT a.cds FROM satscores AS a INNER JOIN schools AS s ON a.cds = s.cdscode WHERE s.district = 'Fresno Unified' ORDER BY a.avgscrread ASC, a.cds NULLS LAST, s.cdscode NULLS LAST LIMIT 1);

/*
Prediction Result:
('559-000-0101',)
*/