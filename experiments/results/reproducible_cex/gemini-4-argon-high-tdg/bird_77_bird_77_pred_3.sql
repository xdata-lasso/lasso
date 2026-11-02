-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, GSoffered, GSserved, DOC, DOCType, LastUpdate) VALUES ('1900001', 'Active', 'Los Angeles', 'LA Unified', 'Oak Creek School', 'K-9', 'K-9', '54', 'Unified School District', '2023-01-15');
INSERT INTO schools (CDSCode, StatusType, County, District, School, GSoffered, GSserved, DOC, DOCType, LastUpdate) VALUES ('1900002', 'Active', 'Los Angeles', 'LA Unified', 'Pine Valley Academy', 'K-9', 'K-9', '54', 'Unified School District', '2023-01-15');
INSERT INTO schools (CDSCode, StatusType, County, District, School, GSoffered, GSserved, DOC, DOCType, LastUpdate) VALUES ('1900003', 'Active', 'Los Angeles', 'LA Unified', 'Maple High', 'K-9', 'K-12', '54', 'Unified School District', '2023-01-15');
INSERT INTO schools (CDSCode, StatusType, County, District, School, GSoffered, GSserved, DOC, DOCType, LastUpdate) VALUES ('3000004', 'Active', 'Orange', 'OC Unified', 'Cedar Elementary', 'K-9', 'K-9', '54', 'Unified School District', '2023-01-15');
INSERT INTO schools (CDSCode, StatusType, County, District, School, GSoffered, GSserved, DOC, DOCType, LastUpdate) VALUES ('3700005', 'Active', 'San Diego', 'SD Unified', 'Birch Prep', 'K-8', 'K-8', '54', 'Unified School District', '2023-01-15');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Low Grade", "High Grade", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('1900001', 'Los Angeles', 'LA Unified', 'Oak Creek FRPM Name', 'K', '9', 100.0, 10.0, 0.10, 20.0, 0.20, 80.0, 15.0, 0.1875, 25.0, 0.3125);
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Low Grade", "High Grade", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('1900002', 'Los Angeles', 'LA Unified', 'Pine Valley FRPM Name', 'K', '9', 250.0, 50.0, 20.0, 100.0, 40.0, 200.0, 60.0, 30.0, 150.0, 0.75);
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Low Grade", "High Grade", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('1900003', 'Los Angeles', 'LA Unified', 'Maple High', 'K', '9', 500.0, 200.0, 40.0, 250.0, 50.0, 400.0, 100.0, 25.0, 200.0, 50.0);
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Low Grade", "High Grade", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('3000004', 'Los Angeles', 'OC Unified', 'Cedar Elementary', 'K', '9', 300.0, 90.0, 30.0, 120.0, 40.0, 250.0, 75.0, 30.0, 100.0, 40.0);
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Low Grade", "High Grade", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('3700005', 'San Diego', 'SD Unified', 'Birch Prep', 'K', '8', 150.0, 30.0, 20.0, 45.0, 30.0, 120.0, 24.0, 20.0, 36.0, 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School, T1."FRPM Count (Ages 5-17)" * 100 / T1."Enrollment (Ages 5-17)" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.County = 'Los Angeles' AND T2.GSserved = 'K-9';

/*
Gold Result:
('Oak Creek School', 31.25)
('Pine Valley Academy', 75.0)
*/

-- Prediction Query
SELECT T1.CDSCode, T2."Percent (%) Eligible FRPM (Ages 5-17)" FROM schools AS T1 INNER JOIN frpm AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1.County = 'Los Angeles' AND T1.GSserved = 'K-09';

/*
Prediction Result:
*/