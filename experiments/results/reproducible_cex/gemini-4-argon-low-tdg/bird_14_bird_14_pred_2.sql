-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests:
-- 1. NULL handling in ORDER BY T2."Enrollment (Ages 5-17)" DESC (in SQLite, NULLs are considered smallest, so DESC puts NULLs at the bottom; mutations adding NULLS FIRST or COALESCE/IS NOT NULL filters will be caught when total rows <= 5 or around the limit boundary).
-- 2. NULL values in T1.NCESSchool (mutations filtering WHERE NCESSchool IS NOT NULL will be killed).
-- 3. Unnecessary JOIN with satscores (some rows have satscores, some do not; mutations joining satscores will drop rows without satscores).
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S_A', 'D_A', 'NCES_1', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S_B', 'D_B', NULL, 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S_C', 'D_C', 'NCES_3', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S_D', 'D_D', 'NCES_4', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S_E', 'D_E', 'NCES_5', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S_F', 'D_F', 'NCES_6', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01');
INSERT INTO frpm (CDSCode, "Enrollment (Ages 5-17)", "Enrollment (K-12)") VALUES ('S_A', 500.0, 500.0);
INSERT INTO frpm (CDSCode, "Enrollment (Ages 5-17)", "Enrollment (K-12)") VALUES ('S_B', 400.0, 400.0);
INSERT INTO frpm (CDSCode, "Enrollment (Ages 5-17)", "Enrollment (K-12)") VALUES ('S_C', 300.0, 300.0);
INSERT INTO frpm (CDSCode, "Enrollment (Ages 5-17)", "Enrollment (K-12)") VALUES ('S_D', NULL, 900.0);
INSERT INTO frpm (CDSCode, "Enrollment (Ages 5-17)", "Enrollment (K-12)") VALUES ('S_E', NULL, 800.0);
INSERT INTO frpm (CDSCode, "Enrollment (Ages 5-17)", "Enrollment (K-12)") VALUES ('S_F', NULL, 700.0);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('S_A', 'S', 100, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.NCESSchool FROM schools AS T1 INNER JOIN frpm AS T2 ON T1.CDSCode = T2.CDSCode ORDER BY T2."Enrollment (Ages 5-17)" DESC, T1.cdscode NULLS LAST, T2.cdscode NULLS LAST LIMIT 5;

/*
Gold Result:
('NCES_1',)
(None,)
('NCES_3',)
('NCES_4',)
('NCES_5',)
*/

-- Prediction Query
SELECT T2.NCESSchool FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE NOT T1."Enrollment (Ages 5-17)" IS NULL ORDER BY T1."Enrollment (Ages 5-17)" DESC, T1.cdscode NULLS LAST, T2.cdscode NULLS LAST LIMIT 5;

/*
Prediction Result:
('NCES_1',)
(None,)
('NCES_3',)
*/