-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, EdOpsCode, DOC, DOCType, LastUpdate) VALUES ('01100170100001', 'Active', 'Alameda', 'Fremont Unified', 'Fremont Special 1', 'Fremont', 'SSS', '54', 'Unified School District', '2015-06-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, EdOpsCode, DOC, DOCType, LastUpdate) VALUES ('01100170100002', 'Active', 'Alameda', 'Fremont Unified', 'Fremont Special 2', 'Fremont', 'SSS', '54', 'Unified School District', '2015-06-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, EdOpsCode, DOC, DOCType, LastUpdate) VALUES ('01100170100003', 'Active', 'Alameda', 'Fremont Unified', 'Fremont Special 3', 'Fremont', 'SSS', '54', 'Unified School District', '2015-06-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, EdOpsCode, DOC, DOCType, LastUpdate) VALUES ('01100170100004', 'Active', 'Alameda', 'Fremont Unified', 'Fremont Old', 'Fremont', 'SSS', '54', 'Unified School District', '2015-06-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, EdOpsCode, DOC, DOCType, LastUpdate) VALUES ('01100170100005', 'Active', 'Alameda', 'Fremont Unified', 'Fremont Span Old', 'Fremont', 'SSS', '54', 'Unified School District', '2015-06-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, EdOpsCode, DOC, DOCType, LastUpdate) VALUES ('01100170100006', 'Active', 'Alameda', 'Fremont Unified', 'Fremont Span New', 'Fremont', 'SSS', '54', 'Unified School District', '2015-06-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, EdOpsCode, DOC, DOCType, LastUpdate) VALUES ('01100170100007', 'Active', 'Alameda', 'Fremont Unified', 'Fremont New', 'Fremont', 'SSS', '54', 'Unified School District', '2015-06-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, EdOpsCode, DOC, DOCType, LastUpdate) VALUES ('01100170100008', 'Active', 'Alameda', 'Fremont Unified', 'Fremont Trad', 'Fremont', 'TRAD', '54', 'Unified School District', '2015-06-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, EdOpsCode, DOC, DOCType, LastUpdate) VALUES ('01100170100009', 'Active', 'Alameda', 'Oakland Unified', 'Oakland Special', 'Oakland', 'SSS', '54', 'Unified School District', '2015-06-01');
INSERT INTO frpm (CDSCode, "Academic Year", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('01100170100001', '2014', 500.0, 200.0, 0.4, 250.0, 0.5, 480.0, 190.0, 0.395, 240.0, 0.5);
INSERT INTO frpm (CDSCode, "Academic Year", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('01100170100002', '2015', 610.0, 300.0, 0.49, 350.0, 0.57, 595.0, 290.0, 0.487, 340.0, 0.571);
INSERT INTO frpm (CDSCode, "Academic Year", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('01100170100003', '2014-2015', 720.0, 400.0, 0.55, 450.0, 0.625, 705.0, 390.0, 0.553, 440.0, 0.624);
INSERT INTO frpm (CDSCode, "Academic Year", "Enrollment (K-12)", "Enrollment (Ages 5-17)") VALUES ('01100170100004', '2013', 310.0, 300.0);
INSERT INTO frpm (CDSCode, "Academic Year", "Enrollment (K-12)", "Enrollment (Ages 5-17)") VALUES ('01100170100005', '2013-2014', 320.0, 315.0);
INSERT INTO frpm (CDSCode, "Academic Year", "Enrollment (K-12)", "Enrollment (Ages 5-17)") VALUES ('01100170100006', '2015-2016', 330.0, 325.0);
INSERT INTO frpm (CDSCode, "Academic Year", "Enrollment (K-12)", "Enrollment (Ages 5-17)") VALUES ('01100170100007', '2016', 340.0, 335.0);
INSERT INTO frpm (CDSCode, "Academic Year", "Enrollment (K-12)", "Enrollment (Ages 5-17)") VALUES ('01100170100008', '2014', 800.0, 780.0);
INSERT INTO frpm (CDSCode, "Academic Year", "Enrollment (K-12)", "Enrollment (Ages 5-17)") VALUES ('01100170100009', '2014', 900.0, 880.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1."Enrollment (Ages 5-17)" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.EdOpsCode = 'SSS' AND T2.City = 'Fremont' AND T1."Academic Year" BETWEEN 2014 AND 2015;

/*
Gold Result:
(480.0,)
(595.0,)
(705.0,)
*/

-- Prediction Query
SELECT T1."Enrollment (Ages 5-17)" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.City = 'Fremont' AND T2.EdOpsCode = 'SSS' AND T1."Academic Year" = '2014-2015';

/*
Prediction Result:
(705.0,)
*/