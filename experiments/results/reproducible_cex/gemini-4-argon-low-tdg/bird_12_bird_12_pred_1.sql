-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests column selection, MAX vs MIN/SUM/AVG/COUNT, WHERE filter (> 0.3 vs < 0.3), and floating point vs integer division in WHERE.
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('101', 'Active', 'C1', 'D1', '01', 'T1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('102', 'Active', 'C1', 'D1', '01', 'T1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('103', 'Active', 'C1', 'D1', '01', 'T1', '2020-01-01');
-- Row 101: Passing WHERE (40/100 = 0.4 > 0.3). Target ratio = 20/100 = 0.2.
-- Other FRPM columns have higher ratios (0.9, 0.8, 0.7) to kill column-swap mutants.
INSERT INTO frpm (CDSCode, "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)", "Enrollment (K-12)", "Free Meal Count (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible Free (K-12)", "Percent (%) Eligible FRPM (K-12)") VALUES ('101', 100.0, 20.0, 90.0, 0.9, 0.9, 100.0, 80.0, 85.0, 0.8, 0.85);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, NumGE1500) VALUES ('101', 'S', 120, 100, 40);
-- Row 102: Passing WHERE (50/100 = 0.5 > 0.3). Target ratio = 50/100 = 0.5 (Expected MAX).
-- Other FRPM columns have lower ratios (0.1) to kill column-swap mutants.
INSERT INTO frpm (CDSCode, "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)", "Enrollment (K-12)", "Free Meal Count (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible Free (K-12)", "Percent (%) Eligible FRPM (K-12)") VALUES ('102', 100.0, 50.0, 10.0, 0.1, 0.1, 100.0, 10.0, 15.0, 0.1, 0.15);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, NumGE1500) VALUES ('102', 'S', 120, 100, 50);
-- Row 103: Failing WHERE (20/100 = 0.2 <= 0.3). Target ratio = 95/100 = 0.95 (Trap if WHERE is omitted or reversed).
INSERT INTO frpm (CDSCode, "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)", "Enrollment (K-12)", "Free Meal Count (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible Free (K-12)", "Percent (%) Eligible FRPM (K-12)") VALUES ('103', 100.0, 95.0, 95.0, 0.95, 0.95, 100.0, 95.0, 95.0, 0.95, 0.95);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, NumGE1500) VALUES ('103', 'S', 120, 100, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MAX(CAST(T1."Free Meal Count (Ages 5-17)" AS REAL) / T1."Enrollment (Ages 5-17)") FROM frpm AS T1 INNER JOIN satscores AS T2 ON T1.CDSCode = T2.cds WHERE CAST(T2.NumGE1500 AS REAL) / T2.NumTstTakr > 0.3;

/*
Gold Result:
(0.5,)
*/

-- Prediction Query
SELECT MAX(fpm."Free Meal Count (Ages 5-17)" / fpm."Enrollment (Ages 5-17)") AS MaxFreeRate FROM satscores AS sat INNER JOIN frpm AS fpm ON sat.cds = fpm.CDSCode WHERE sat.NumGE1500 / sat.NumTstTakr > 0.3;

/*
Prediction Result:
(None,)
*/