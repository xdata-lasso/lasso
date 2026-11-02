-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. NULL filtering: Free Meal Count IS NULL, Enrollment IS NULL, and Enrollment = 0 (which produces NULL upon division in SQLite).
-- 2. WHERE clause filtering on "Educational Option Type" (and checks if mutant mistakenly uses "School Type" or schools.EdOpsName).
-- 3. ORDER BY direction (ASC vs DESC) and LIMIT 3 boundary (5 valid rows present).
-- 4. Duplicate ratios across different CDSCodes (tests if mutant erroneously uses SELECT DISTINCT).
-- 5. Conflicting values in similar columns: K-12 vs Ages 5-17, FRPM Count vs Free Meal Count, and pre-calculated Percent (%) columns vs raw division.
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, EdOpsName, LastUpdate) VALUES ('C01', 'Active', 'C1', 'D1', '01', 'T1', 'Traditional', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, EdOpsName, LastUpdate) VALUES ('C02', 'Active', 'C1', 'D1', '01', 'T1', 'Continuation School', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, EdOpsName, LastUpdate) VALUES ('C03', 'Active', 'C1', 'D1', '01', 'T1', 'Continuation School', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, EdOpsName, LastUpdate) VALUES ('C04', 'Active', 'C1', 'D1', '01', 'T1', 'Continuation School', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, EdOpsName, LastUpdate) VALUES ('C05', 'Active', 'C1', 'D1', '01', 'T1', 'Continuation School', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, EdOpsName, LastUpdate) VALUES ('C06', 'Active', 'C1', 'D1', '01', 'T1', 'Continuation School', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, EdOpsName, LastUpdate) VALUES ('C07', 'Active', 'C1', 'D1', '01', 'T1', 'Continuation School', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, EdOpsName, LastUpdate) VALUES ('C08', 'Active', 'C1', 'D1', '01', 'T1', 'Continuation School', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, EdOpsName, LastUpdate) VALUES ('C09', 'Active', 'C1', 'D1', '01', 'T1', 'Continuation School', '2020-01-01');
INSERT INTO frpm (CDSCode, "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C01', 'Continuation School', 'Traditional', 100.0, 5.0, 5.0, 5.0, 5.0, 100.0, 1.0, 1.0, 1.0, 1.0);
INSERT INTO frpm (CDSCode, "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C02', 'High School', 'Continuation School', 100.0, 10.0, 10.0, 10.0, 10.0, 100.0, NULL, 2.0, 2.0, 2.0);
INSERT INTO frpm (CDSCode, "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C03', 'High School', 'Continuation School', 100.0, 15.0, 15.0, 15.0, 15.0, NULL, 10.0, 3.0, 3.0, 3.0);
INSERT INTO frpm (CDSCode, "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C04', 'High School', 'Continuation School', 100.0, 20.0, 20.0, 20.0, 20.0, 0.0, 10.0, 4.0, 4.0, 4.0);
INSERT INTO frpm (CDSCode, "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C05', 'High School', 'Continuation School', 100.0, 90.0, 90.0, 95.0, 95.0, 100.0, 10.0, 80.0, 85.0, 85.0);
INSERT INTO frpm (CDSCode, "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C06', 'High School', 'Continuation School', 100.0, 80.0, 80.0, 85.0, 85.0, 200.0, 20.0, 70.0, 75.0, 75.0);
INSERT INTO frpm (CDSCode, "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C07', 'High School', 'Continuation School', 100.0, 70.0, 70.0, 75.0, 75.0, 100.0, 25.0, 60.0, 65.0, 65.0);
INSERT INTO frpm (CDSCode, "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C08', 'High School', 'Continuation School', 100.0, 60.0, 60.0, 65.0, 65.0, 100.0, 40.0, 50.0, 55.0, 55.0);
INSERT INTO frpm (CDSCode, "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C09', 'High School', 'Continuation School', 100.0, 50.0, 50.0, 55.0, 55.0, 100.0, 50.0, 40.0, 45.0, 45.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" FROM frpm WHERE "Educational Option Type" = 'Continuation School' AND NOT "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" IS NULL ORDER BY "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" ASC, frpm.cdscode NULLS LAST LIMIT 3;

/*
Gold Result:
(0.1,)
(0.1,)
(0.25,)
*/

-- Prediction Query
SELECT "School Name", "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" AS FreeRate FROM frpm WHERE "School Type" = 'Continuation' ORDER BY FreeRate ASC, frpm.cdscode NULLS LAST LIMIT 3;

/*
Prediction Result:
*/