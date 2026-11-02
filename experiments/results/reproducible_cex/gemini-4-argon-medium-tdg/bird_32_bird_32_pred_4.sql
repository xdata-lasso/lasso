-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('100001', 'Active', 'Alameda', 'DistA', '10', 'Unified', '66', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('100002', 'Active', 'Alameda', 'DistA', '10', 'Unified', '66', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('100003', 'Active', 'Alameda', 'DistA', '10', 'Unified', '66', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('100004', 'Active', 'Alameda', 'DistA', '10', 'Unified', '66', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('100005', 'Active', 'Alameda', 'DistA', '10', 'Unified', '66', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('100006', 'Active', 'Alameda', 'DistA', '10', 'Unified', '66', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('100007', 'Active', 'Alameda', 'DistA', '10', 'Unified', '66', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('100008', 'Active', 'Alameda', 'DistA', '10', 'Unified', '65', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('100009', 'Active', 'Alameda', 'DistA', '10', 'Unified', NULL, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('100010', 'Active', 'Alameda', 'DistA', '10', 'Unified', '66', '2020-01-01');
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "FRPM Count (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Percent (%) Eligible Free (K-12)", "Enrollment (Ages 5-17)", "FRPM Count (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100001', 1000.0, 500.0, 200.0, 0.99, 0.20, 800.0, 400.0, 150.0, 0.50);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "FRPM Count (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Percent (%) Eligible Free (K-12)", "Enrollment (Ages 5-17)", "FRPM Count (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100002', 450.0, 400.0, 350.0, 0.11, 0.77, 400.0, 350.0, 300.0, 0.875);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "FRPM Count (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Percent (%) Eligible Free (K-12)", "Enrollment (Ages 5-17)", "FRPM Count (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100003', 500.0, 300.0, 100.0, 0.55, 0.20, 450.0, 250.0, 90.0, 0.55);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "FRPM Count (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Percent (%) Eligible Free (K-12)", "Enrollment (Ages 5-17)", "FRPM Count (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100004', 600.0, 300.0, 250.0, 0.44, 0.41, 550.0, 280.0, 200.0, 0.50);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "FRPM Count (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Percent (%) Eligible Free (K-12)", "Enrollment (Ages 5-17)", "FRPM Count (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100005', 250.0, 200.0, 180.0, 0.22, 0.72, 200.0, 190.0, 170.0, 0.95);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "FRPM Count (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Percent (%) Eligible Free (K-12)", "Enrollment (Ages 5-17)", "FRPM Count (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100006', 110.0, 100.0, 90.0, 0.33, 0.81, 100.0, 95.0, 85.0, 0.95);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "FRPM Count (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Percent (%) Eligible Free (K-12)", "Enrollment (Ages 5-17)", "FRPM Count (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100007', 55.0, 50.0, 45.0, 0.66, 0.81, 50.0, 48.0, 40.0, 0.96);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "FRPM Count (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Percent (%) Eligible Free (K-12)", "Enrollment (Ages 5-17)", "FRPM Count (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100008', 1000.0, 900.0, 850.0, 0.90, 0.85, 950.0, 880.0, 800.0, 0.92);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "FRPM Count (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Percent (%) Eligible Free (K-12)", "Enrollment (Ages 5-17)", "FRPM Count (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100009', 1000.0, 950.0, 900.0, 0.95, 0.90, 950.0, 920.0, 880.0, 0.96);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(T1."FRPM Count (K-12)" AS REAL) / T1."Enrollment (K-12)" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.SOC = 66 ORDER BY T1."FRPM Count (K-12)" DESC, T1.cdscode NULLS LAST, T2.cdscode NULLS LAST LIMIT 5;

/*
Gold Result:
(0.5,)
(0.8888888888888888,)
(0.6,)
(0.5,)
(0.8,)
*/

-- Prediction Query
SELECT frpm."School Name", CAST(frpm."FRPM Count (K-12)" AS REAL) / CAST(frpm."Enrollment (K-12)" AS REAL) AS Eligible_Free_Rate FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE schools.SOC = '66' ORDER BY frpm."FRPM Count (K-12)" DESC, frpm.cdscode NULLS LAST, schools.cdscode NULLS LAST LIMIT 5;

/*
Prediction Result:
(None, 0.5)
(None, 0.8888888888888888)
(None, 0.6)
(None, 0.5)
(None, 0.8)
*/