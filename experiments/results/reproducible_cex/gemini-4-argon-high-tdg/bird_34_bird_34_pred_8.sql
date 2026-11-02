-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmFName1, AdmLName1, LastUpdate) VALUES ('01100170100001', 'Active', 'Alameda', 'Alameda Unified', 'Bayview High', '54', 'Unified School District', 'Kacey', 'Gibson', '2023-01-15');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmFName1, AdmLName1, LastUpdate) VALUES ('01100170100002', 'Active', 'Alameda', 'Alameda Unified', 'Ocean Elementary', '54', 'Unified School District', 'Robert', 'Chen', '2023-01-15');
INSERT INTO frpm (CDSCode, "Academic Year", "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('01100170100001', '2014-2015', '01', 10017, '0100001', 'Alameda', 'Alameda Unified', 'Bayview High', 250.0, 60.0, 24.0, 90.0, 36.0, 200.0, 45.0, 23.0, 70.0, 35.0);
INSERT INTO frpm (CDSCode, "Academic Year", "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('01100170100002', '2014-2015', '01', 10017, '0100002', 'Alameda', 'Alameda Unified', 'Ocean Elementary', 400.0, 120.0, 30.0, 160.0, 40.0, 300.0, 90.0, 30.0, 120.0, 40.0);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('01100170100002', 'S', 'Ocean Elementary', 'Alameda Unified', 'Alameda', 100, 80, 500, 510, 490, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(T2."Free Meal Count (Ages 5-17)" AS REAL) / T2."Enrollment (Ages 5-17)" FROM schools AS T1 INNER JOIN frpm AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1.AdmFName1 = 'Kacey' AND T1.AdmLName1 = 'Gibson';

/*
Gold Result:
(0.225,)
*/

-- Prediction Query
SELECT CAST(T1."Free Meal Count (Ages 5-17)" AS REAL) * 100 / T1."Enrollment (Ages 5-17)" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.AdmFName1 = 'Kacey' AND T2.AdmLName1 = 'Gibson';

/*
Prediction Result:
(22.5,)
*/