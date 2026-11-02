-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('101', 'Active', 'County A', 'District A', 'School 101', '00', 'District', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('102', 'Active', 'County A', 'District A', 'School 102', '00', 'District', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('103', 'Active', 'County A', 'District A', 'School 103', '00', 'District', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('104', 'Active', 'County A', 'District A', 'School 104', '00', 'District', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('105', 'Active', 'County A', 'District A', 'School 105', '00', 'District', '2023-01-01');
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (K-12)", "Enrollment (K-12)") VALUES ('101', 'Valid High', 20.0, 100.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (K-12)", "Enrollment (K-12)") VALUES ('102', 'Boundary Ratio 0.1 High', 10.0, 100.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (K-12)", "Enrollment (K-12)") VALUES ('103', 'Boundary Zero GE1500 High', 25.0, 100.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (K-12)", "Enrollment (K-12)") VALUES ('104', 'Low Ratio High', 5.0, 100.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (K-12)", "Enrollment (K-12)") VALUES ('105', 'Null GE1500 High', 30.0, 100.0);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('101', 'S', 'Valid High', 100, 50, 1);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('102', 'S', 'Boundary Ratio 0.1 High', 100, 50, 5);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('103', 'S', 'Boundary Zero GE1500 High', 100, 50, 0);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('104', 'S', 'Low Ratio High', 100, 50, 10);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('105', 'S', 'Null GE1500 High', 100, 50, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2."School Name" FROM satscores AS T1 INNER JOIN frpm AS T2 ON T1.cds = T2.CDSCode WHERE CAST(T2."Free Meal Count (K-12)" AS REAL) / T2."Enrollment (K-12)" > 0.1 AND T1.NumGE1500 > 0;

/*
Gold Result:
('Valid High',)
*/

-- Prediction Query
SELECT T3.School FROM satscores AS T1 INNER JOIN frpm AS T2 ON T1.cds = T2.CDSCode INNER JOIN schools AS T3 ON T1.cds = T3.CDSCode WHERE T2."Percent (%) Eligible Free (K-12)" > 0.1 AND T1.NumGE1500 > 0;

/*
Prediction Result:
*/