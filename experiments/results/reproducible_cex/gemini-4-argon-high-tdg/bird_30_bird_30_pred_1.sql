-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('001', 'Active', 'C1', 'D1', 'S1', 'Zeta', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('002', 'Active', 'C1', 'D1', 'S2', 'Delta', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('003', 'Active', 'C1', 'D1', 'S3', 'Delta', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('004', 'Active', 'C2', 'D2', 'S4', 'Beta', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('005', 'Active', 'C2', 'D2', 'S5', 'Beta', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('006', 'Active', 'C2', 'D2', 'S6', 'Beta', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('007', 'Active', 'C3', 'D3', 'S7', 'Epsilon', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('008', 'Active', 'C3', 'D3', 'S8', 'Epsilon', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('009', 'Active', 'C4', 'D4', 'S9', 'Alpha', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('010', 'Active', 'C4', 'D4', 'S10', 'Alpha', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('011', 'Active', 'C5', 'D5', 'S11', 'Gamma', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('012', 'Active', 'C5', 'D5', 'S12', 'Gamma', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('013', 'Active', 'C6', 'D6', 'S13', 'Eta', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('014', 'Active', 'C6', 'D6', 'S14', 'Eta', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('015', 'Active', 'C6', 'D6', 'S15', 'Eta', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('016', 'Active', 'C6', 'D6', 'S16', 'Eta', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, DOC, DOCType, LastUpdate) VALUES ('017', 'Active', 'C7', 'D7', 'S17', 'Omega', '54', 'Unified', '2020-01-01');
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('001', 30.0, 900.0, 800.0, 850.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('002', 20.0, 400.0, 350.0, 380.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('003', 20.0, 400.0, 350.0, 380.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('004', 5.0, 200.0, 180.0, 190.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('005', 20.0, 200.0, 180.0, 190.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('006', 25.0, 300.0, 240.0, 260.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('007', 10.0, 300.0, 250.0, 270.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('008', 50.0, 300.0, 250.0, 270.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('009', 35.0, 250.0, 200.0, 220.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('010', 35.0, 250.0, 200.0, 220.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('011', 15.0, 100.0, 80.0, 90.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('012', 65.0, 100.0, 80.0, 90.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('013', 1.0, 10.0, 5.0, 6.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('014', 2.0, 10.0, 5.0, 6.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('015', 3.0, 10.0, 5.0, 6.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('016', 94.0, 10.0, 5.0, 6.0);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('001', 'S', 900, 100);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('002', 'S', 800, 100);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('004', 'S', 700, 100);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('007', 'S', 600, 100);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('009', 'S', 500, 100);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('011', 'S', 200, 50);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('013', 'S', 10, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.City FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode GROUP BY T2.City ORDER BY SUM(T1."Enrollment (K-12)") ASC, T2.City NULLS LAST LIMIT 5;

/*
Gold Result:
('Zeta',)
('Delta',)
('Beta',)
('Epsilon',)
('Alpha',)
*/

-- Prediction Query
SELECT DISTINCT schools.City FROM frpm INNER JOIN schools ON frpm.CDSCode = schools.CDSCode ORDER BY frpm."Enrollment (K-12)" ASC, schools.City NULLS LAST LIMIT 5;

/*
Prediction Result:
('Eta',)
('Beta',)
('Epsilon',)
('Gamma',)
('Delta',)
*/