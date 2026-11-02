-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, City, MailCity, Charter, DOC, DOCType, Virtual, Magnet, LastUpdate) VALUES ('10000010000001', '0600001', '00001', 'Active', 'Madera', 'Central Unified', 'Roosevelt High', 'Fresno', 'Clovis', 1, '54', 'Unified School District', 'Y', 0, '2015-06-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, City, MailCity, Charter, DOC, DOCType, Virtual, Magnet, LastUpdate) VALUES ('10000010000002', '0600002', '00002', 'Active', 'Fresno', 'Fresno Unified', 'Bullard High', 'Fresno', 'Fresno', 0, '54', 'Unified School District', 'N', 1, '2015-06-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, City, MailCity, Charter, DOC, DOCType, Virtual, Magnet, LastUpdate) VALUES ('10000010000003', '0600003', '00003', 'Active', 'Fresno', 'Fresno', 'Clovis West', 'Clovis', 'Fresno', 0, '54', 'Unified School District', 'N', 0, '2015-06-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, City, MailCity, Charter, DOC, DOCType, Virtual, Magnet, LastUpdate) VALUES ('10000010000004', '0600004', '00004', 'Active', 'Fresno', 'Fresno Unified', 'Edison High', 'Fresno', 'Fresno', 0, '54', 'Unified School District', 'N', NULL, '2015-06-01');
INSERT INTO frpm (CDSCode, "Academic Year", "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "Charter School (Y/N)", IRC, "2013-14 CALPADS Fall 1 Certification Status") VALUES ('10000010000001', '2014-2015', '20', 62166, '0100001', 'Madera', 'Central Unified', 'Roosevelt High', 1, 1, 1);
INSERT INTO frpm (CDSCode, "Academic Year", "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "Charter School (Y/N)", IRC, "2013-14 CALPADS Fall 1 Certification Status") VALUES ('10000010000002', '2014-2015', '10', 62170, '0100002', 'Fresno', 'Fresno Unified', 'Bullard High', 0, 0, 0);
INSERT INTO frpm (CDSCode, "Academic Year", "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "Charter School (Y/N)", IRC, "2013-14 CALPADS Fall 1 Certification Status") VALUES ('10000010000003', '2014-2015', '10', 62180, '0100003', 'Fresno', 'Fresno', 'Clovis West', 0, 0, 0);
INSERT INTO frpm (CDSCode, "Academic Year", "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "Charter School (Y/N)", IRC, "2013-14 CALPADS Fall 1 Certification Status") VALUES ('10000010000004', '2014-2015', '10', 62190, '0100004', 'Fresno', 'Fresno Unified', 'Edison High', 0, 0, 0);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('10000010000002', 'S', 'Bullard High', 'Fresno Unified', 'Fresno', 400, 250, 500, 510, 490, 120);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1."District Code" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.City = 'Fresno' AND T2.Magnet = 0;

/*
Gold Result:
(62166,)
*/

-- Prediction Query
SELECT DISTINCT DOC FROM schools WHERE City = 'Fresno' AND Magnet = 0;

/*
Prediction Result:
('54',)
*/