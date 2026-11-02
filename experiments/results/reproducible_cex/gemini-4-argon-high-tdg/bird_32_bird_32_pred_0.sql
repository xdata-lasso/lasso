-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('100001', 'Active', 'Alameda', 'Dist A', 'School A', '54', 'District', '66', 'High Schools', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('100002', 'Active', 'Alameda', 'Dist B', 'School B', '54', 'District', '66', 'High Schools', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('100003', 'Active', 'Alameda', 'Dist C', 'School C', '54', 'District', '66', 'High Schools', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('100004', 'Active', 'Alameda', 'Dist D', 'School D', '54', 'District', '66', 'High Schools', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('100005', 'Active', 'Alameda', 'Dist E', 'School E', '54', 'District', '66', 'High Schools', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('100006', 'Active', 'Alameda', 'Dist F', 'School F', '54', 'District', '66', 'High Schools', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('100007', 'Active', 'Alameda', 'Dist G', 'School G', '54', 'District', '66', 'High Schools', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('100008', 'Active', 'Alameda', 'Dist H', 'School H', '66', 'District', '65', 'High Schools', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('100009', 'Active', 'Alameda', 'Dist I', 'School I', '54', 'District', NULL, '66', '2020-01-01');
INSERT INTO frpm (CDSCode, "School Code", "District Code", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100001', '66', 10, 2400.0, 100.0, 0.04, 600.0, 25.0, 2000.0, 90.0, 0.045, 100.0, 5.0);
INSERT INTO frpm (CDSCode, "School Code", "District Code", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100002', '66', 20, 625.0, 450.0, 0.72, 500.0, 80.0, 600.0, 400.0, 0.66, 200.0, 33.3);
INSERT INTO frpm (CDSCode, "School Code", "District Code", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100003', '66', 30, 1000.0, 350.0, 0.35, 400.0, 40.0, 900.0, 300.0, 0.33, 800.0, 88.8);
INSERT INTO frpm (CDSCode, "School Code", "District Code", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100004', '66', 40, 400.0, 250.0, 0.625, 300.0, 75.0, 350.0, 200.0, 0.57, 700.0, 200.0);
INSERT INTO frpm (CDSCode, "School Code", "District Code", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100005', '66', 50, 1600.0, 180.0, 0.1125, 200.0, 12.5, 1500.0, 150.0, 0.10, 650.0, 43.3);
INSERT INTO frpm (CDSCode, "School Code", "District Code", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100006', '66', 60, 160.0, 140.0, 0.875, 150.0, 93.75, 155.0, 130.0, 0.83, 900.0, 580.6);
INSERT INTO frpm (CDSCode, "School Code", "District Code", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100007', '66', 70, 125.0, 95.0, 0.76, 100.0, 80.0, 120.0, 90.0, 0.75, 950.0, 791.6);
INSERT INTO frpm (CDSCode, "School Code", "District Code", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100008', '66', 66, 2000.0, 1800.0, 0.90, 1900.0, 95.0, 1950.0, 1750.0, 0.89, 1850.0, 94.8);
INSERT INTO frpm (CDSCode, "School Code", "District Code", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('100009', '66', 66, 3000.0, 2700.0, 0.90, 2800.0, 93.3, 2900.0, 2600.0, 0.89, 2750.0, 94.8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(T1."FRPM Count (K-12)" AS REAL) / T1."Enrollment (K-12)" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.SOC = 66 ORDER BY T1."FRPM Count (K-12)" DESC, T1.cdscode NULLS LAST, T2.cdscode NULLS LAST LIMIT 5;

/*
Gold Result:
(0.25,)
(0.8,)
(0.4,)
(0.75,)
(0.125,)
*/

-- Prediction Query
SELECT T1."School Name", (T1."FRPM Count (K-12)" / T1."Enrollment (K-12)") AS "Eligible FRPM Rate" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.DOC = '66' ORDER BY T1."FRPM Count (K-12)" DESC, T1.cdscode NULLS LAST, T2.cdscode NULLS LAST LIMIT 5;

/*
Prediction Result:
(None, 0.95)
*/