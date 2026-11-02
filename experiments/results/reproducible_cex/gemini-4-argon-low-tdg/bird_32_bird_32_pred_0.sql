-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. LIMIT 5 boundary (7 matching rows with SOC = '66').
-- 2. ORDER BY T1."FRPM Count (K-12)" DESC (is inverse to the calculated ratio and other metrics, distinguishing ordering by FRPM Count vs Ratio vs Enrollment vs Free Meal Count).
-- 3. Tie-breaking on T1.cdscode ASC when "FRPM Count (K-12)" is equal (CDS03 vs CDS04).
-- 4. Duplicate output ratio values (0.5 appears twice) to catch erroneous SELECT DISTINCT.
-- 5. Column confusion between (K-12) and (Ages 5-17), or "FRPM Count" and "Free Meal Count" / "Percent (%) Eligible FRPM".
-- 6. INNER JOIN vs LEFT/RIGHT JOIN (schools without frpm row).
-- 7. WHERE T2.SOC = 66 boundary (SOC = '65', '67', NULL).
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('CDS01', 'Active', 'CountyA', 'DistA', '01', 'DocTypeA', '66', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('CDS02', 'Active', 'CountyA', 'DistA', '01', 'DocTypeA', '66', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('CDS03', 'Active', 'CountyA', 'DistA', '01', 'DocTypeA', '66', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('CDS04', 'Active', 'CountyA', 'DistA', '01', 'DocTypeA', '66', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('CDS05', 'Active', 'CountyA', 'DistA', '01', 'DocTypeA', '66', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('CDS06', 'Active', 'CountyA', 'DistA', '01', 'DocTypeA', '66', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('CDS07', 'Active', 'CountyA', 'DistA', '01', 'DocTypeA', '66', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('CDS08', 'Active', 'CountyA', 'DistA', '01', 'DocTypeA', '65', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('CDS09', 'Active', 'CountyA', 'DistA', '01', 'DocTypeA', '67', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('CDS10', 'Active', 'CountyA', 'DistA', '01', 'DocTypeA', NULL, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, SOC, LastUpdate) VALUES ('CDS11', 'Active', 'CountyA', 'DistA', '01', 'DocTypeA', '66', '2020-01-01');
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS01', 1000.0, 100.0, 0.1, 500.0, 0.99, 800.0, 50.0, 100.0, 0.125);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS02', 800.0, 200.0, 0.25, 400.0, 0.88, 700.0, 150.0, 200.0, 0.285);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS04', 500.0, 300.0, 0.6, 300.0, 0.77, 400.0, 250.0, 300.0, 0.75);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS03', 400.0, 350.0, 0.875, 300.0, 0.66, 300.0, 260.0, 350.0, 1.16);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS05', 250.0, 400.0, 1.6, 200.0, 0.55, 200.0, 190.0, 400.0, 2.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS06', 150.0, 450.0, 3.0, 150.0, 0.44, 100.0, 95.0, 450.0, 4.5);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS07', 100.0, 500.0, 5.0, 90.0, 0.33, 50.0, 48.0, 500.0, 10.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS08', 1000.0, 900.0, 0.9, 950.0, 0.95, 900.0, 850.0, 900.0, 1.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS09', 1000.0, 900.0, 0.9, 960.0, 0.96, 900.0, 850.0, 900.0, 1.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS10', 1000.0, 900.0, 0.9, 970.0, 0.97, 900.0, 850.0, 900.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(T1."FRPM Count (K-12)" AS REAL) / T1."Enrollment (K-12)" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.SOC = 66 ORDER BY T1."FRPM Count (K-12)" DESC, T1.cdscode NULLS LAST, T2.cdscode NULLS LAST LIMIT 5;

/*
Gold Result:
(0.5,)
(0.5,)
(0.75,)
(0.6,)
(0.8,)
*/

-- Prediction Query
SELECT T1."School Name", (T1."FRPM Count (K-12)" / T1."Enrollment (K-12)") AS "Eligible FRPM Rate" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.DOC = '66' ORDER BY T1."FRPM Count (K-12)" DESC, T1.cdscode NULLS LAST, T2.cdscode NULLS LAST LIMIT 5;

/*
Prediction Result:
*/