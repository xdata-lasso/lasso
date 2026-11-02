-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard ordering, LIMIT/OFFSET boundaries, column confusion (K-12 vs Ages 5-17, Free Meal vs FRPM, Percent vs Ratio), and extra rows in parent table (schools) not in frpm.
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S01', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S02', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S03', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S04', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S05', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S06', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S07', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S08', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S09', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S10', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S11', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S12', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S13_NO_FRPM', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)") VALUES ('S01', 1200, 100, 99.1, 500, 88.1, 100, 50, 50.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)") VALUES ('S02', 1100, 110, 99.2, 510, 88.2, 200, 50, 25.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)") VALUES ('S03', 1000, 120, 99.3, 520, 88.3, 300, 50, 16.6);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)") VALUES ('S04', 900, 130, 99.4, 530, 88.4, 400, 50, 12.5);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)") VALUES ('S05', 800, 140, 99.5, 540, 88.5, 500, 50, 10.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)") VALUES ('S06', 700, 150, 99.6, 550, 88.6, 600, 50, 8.3);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)") VALUES ('S07', 600, 160, 99.7, 560, 88.7, 700, 50, 7.1);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)") VALUES ('S08', 500, 170, 99.8, 570, 88.8, 800, 50, 6.2);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)") VALUES ('S09', 400, 180, 99.9, 580, 88.9, 900, 50, 5.5);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)") VALUES ('S10', 300, 75, 25.0, 150, 50.0, 1000, 900, 90.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)") VALUES ('S11', 200, 50, 25.0, 120, 60.0, 1100, 990, 90.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)") VALUES ('S12', 100, 90, 90.0, 95, 95.0, 1200, 600, 50.0);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('S01', 'S', 100, 50);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('S02', 'S', 100, 50);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('S03', 'S', 100, 50);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('S04', 'S', 100, 50);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('S05', 'S', 100, 50);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('S06', 'S', 100, 50);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('S07', 'S', 100, 50);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('S08', 'S', 100, 50);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('S09', 'S', 100, 50);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('S11', 'S', 100, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST("Free Meal Count (K-12)" AS REAL) / "Enrollment (K-12)" FROM frpm ORDER BY "Enrollment (K-12)" DESC, frpm.cdscode NULLS LAST LIMIT 2 OFFSET 9;

/*
Gold Result:
(0.25,)
(0.25,)
*/

-- Prediction Query
SELECT "School Name", "Free Meal Count (K-12)" / "Enrollment (K-12)" AS eligible_free_rate FROM frpm ORDER BY "Enrollment (K-12)" DESC, frpm.cdscode NULLS LAST LIMIT 2 OFFSET 9;

/*
Prediction Result:
(None, 0.25)
(None, 0.25)
*/