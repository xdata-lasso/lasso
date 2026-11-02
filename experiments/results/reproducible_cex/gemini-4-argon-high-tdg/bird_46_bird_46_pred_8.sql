-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('10000000000001', 'Active', 'Alameda', 'District A', 'Alpha School', '31', 'County Community', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('10000000000002', 'Active', 'Alameda', 'District B', 'Beta School', '31', 'County Community', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('10000000000003', 'Active', 'Alameda', 'District C', 'Gamma School', '31', 'County Community', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('10000000000004', 'Active', 'Alameda', 'District D', 'Delta School', '54', 'Unified School District', '2020-01-01');
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('10000000000001', 'FRPM Alpha', 500.0, 2000.0, 450.0, 480.0);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('10000000000002', 'FRPM Beta', 900.0, 850.0, 300.0, 320.0);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('10000000000003', 'FRPM Gamma', 1000.0, 400.0, 100.0, 110.0);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('10000000000004', 'FRPM Delta', 5000.0, 4900.0, 900.0, 950.0);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr) VALUES ('10000000000001', 'S', 'SAT Alpha', 'District A', 'Alameda', 500, 200);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr) VALUES ('10000000000002', 'S', 'SAT Beta', 'District B', 'Alameda', 300, 150);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr) VALUES ('10000000000003', 'S', 'SAT Gamma', 'District C', 'Alameda', 100, 50);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr) VALUES ('10000000000004', 'S', 'SAT Delta', 'District D', 'Alameda', 900, 400);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.DOC = 31 ORDER BY T1."Enrollment (K-12)" DESC, T1.cdscode NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
('Gamma School',)
*/

-- Prediction Query
SELECT s.School FROM schools AS s JOIN satscores AS sa ON s.CDSCode = sa.cds WHERE s.DOC = '31' AND s.GSserved = 'K-12' ORDER BY sa.enroll12 DESC, s.cdscode NULLS LAST, sa.cds NULLS LAST LIMIT 1;

/*
Prediction Result:
*/