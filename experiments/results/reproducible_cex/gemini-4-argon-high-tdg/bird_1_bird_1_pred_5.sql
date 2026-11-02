-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EdOpsCode, EdOpsName, SOCType, LastUpdate) VALUES ('CDS05', 'Active', 'Alameda', 'Dist A', 'School 5', '54', 'Unified', 'TRAD', 'Traditional', 'High Schools', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EdOpsCode, EdOpsName, SOCType, LastUpdate) VALUES ('CDS04', 'Active', 'Alameda', 'Dist A', 'School 4', '54', 'Unified', 'TRAD', 'Traditional', 'High Schools', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EdOpsCode, EdOpsName, SOCType, LastUpdate) VALUES ('CDS03', 'Active', 'Alameda', 'Dist A', 'School 3', '54', 'Unified', 'TRAD', 'Traditional', 'High Schools', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EdOpsCode, EdOpsName, SOCType, LastUpdate) VALUES ('CDS02', 'Active', 'Alameda', 'Dist A', 'School 2', '54', 'Unified', 'CON', 'Continuation School', 'Continuation High Schools', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EdOpsCode, EdOpsName, SOCType, LastUpdate) VALUES ('CDS01', 'Active', 'Alameda', 'Dist A', 'School 1', '54', 'Unified', 'CON', 'Continuation School', 'Continuation High Schools', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, EdOpsCode, EdOpsName, SOCType, LastUpdate) VALUES ('CDS00', 'Active', 'Alameda', 'Dist A', 'School 0', '54', 'Unified', 'CON', 'Continuation School', 'Continuation School', '2020-01-01');
INSERT INTO frpm (CDSCode, "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS05', 'High Schools (Public)', 'Continuation School', 1000.0, 900.0, 90.0, 950.0, 95.0, 1000.0, 50.0, 85.0, 800.0, 80.0);
INSERT INTO frpm (CDSCode, "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS04', 'High Schools (Public)', 'Continuation School', 400.0, 320.0, 80.0, 360.0, 90.0, 400.0, 40.0, 75.0, 280.0, 70.0);
INSERT INTO frpm (CDSCode, "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS03', 'High Schools (Public)', 'Continuation School', 200.0, 140.0, 70.0, 160.0, 80.0, 200.0, 30.0, 65.0, 120.0, 60.0);
INSERT INTO frpm (CDSCode, "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS02', 'Continuation High Schools', 'Continuation School', 100.0, 10.0, 10.0, 15.0, 15.0, 100.0, 20.0, 5.0, 5.0, 5.0);
INSERT INTO frpm (CDSCode, "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS01', 'Continuation High Schools', 'Continuation School', 40.0, 1.0, 2.5, 2.0, 5.0, 40.0, 10.0, 2.5, 1.0, 2.5);
INSERT INTO frpm (CDSCode, "School Type", "Educational Option Type", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS00', 'Continuation School', 'Traditional', 500.0, 5.0, 1.0, 5.0, 1.0, 500.0, 5.0, 1.0, 5.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" FROM frpm WHERE "Educational Option Type" = 'Continuation School' AND NOT "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" IS NULL ORDER BY "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" ASC, frpm.cdscode NULLS LAST LIMIT 3;

/*
Gold Result:
(0.05,)
(0.1,)
(0.15,)
*/

-- Prediction Query
SELECT "Percent (%) Eligible Free (Ages 5-17)" FROM frpm WHERE "School Type" = 'Continuation High Schools' ORDER BY "Percent (%) Eligible Free (Ages 5-17)" ASC, frpm.cdscode NULLS LAST LIMIT 3;

/*
Prediction Result:
(2.5,)
(5.0,)
*/