-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('01100170100001', 'Active', 'Alameda', 'CEA', 'Northern Facility', '500 Oak Rd', 'PO Box 1040', '31', 'State Agency', '40', 'Youth Authority Facilities', '2020-01-15');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('01100170100002', 'Active', 'Alameda', 'CEA', 'Southern Facility', '600 Pine Rd', 'PO Box 1040', '31', 'State Agency', '65', 'High Schools (Public)', '2020-01-15');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('01100170100003', 'Active', 'Alameda', 'CEA', 'Eastern Facility', '700 Cedar Rd', 'PO Box 2050', '31', 'State Agency', '40', 'Youth Authority Facilities', '2020-01-15');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('01100170100004', 'Active', 'Alameda', 'CEA', 'Western Facility', '800 Birch Rd', 'PO Box 2050', '31', 'State Agency', '65', 'High Schools (Public)', '2020-01-15');
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('01100170100001', 150.0, 110.0, 0.73, 125.0, 0.83, 140.0, 95.0, 0.68, 108.0, 0.77);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('01100170100002', 200.0, 160.0, 0.80, 175.0, 0.87, 190.0, 150.0, 0.79, 165.0, 0.86);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('01100170100003', 300.0, 210.0, 0.70, 225.0, 0.75, 280.0, 195.0, 0.69, 215.0, 0.76);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('01100170100004', 400.0, 310.0, 0.77, 325.0, 0.81, 380.0, 295.0, 0.77, 315.0, 0.82);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('01100170100002', 'S', 50, 25, 450, 460, 440, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1."FRPM Count (Ages 5-17)" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.MailStreet = 'PO Box 1040' AND T2.SOCType = 'Youth Authority Facilities';

/*
Gold Result:
(108.0,)
*/

-- Prediction Query
SELECT frpm."FRPM Count (Ages 5-17)" FROM frpm INNER JOIN schools ON frpm.cdscode = schools.cdscode WHERE schools.edopsname = 'Youth Authority School' AND schools.mailstreet = 'PO Box 1040';

/*
Prediction Result:
*/