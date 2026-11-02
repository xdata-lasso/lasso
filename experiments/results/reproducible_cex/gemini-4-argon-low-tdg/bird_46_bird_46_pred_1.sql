-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. WHERE T2.DOC = 31 (filters out non-31 even if it has higher enrollment).
-- 2. INNER JOIN vs LEFT JOIN (school without frpm row has DOC='31').
-- 3. Column selection (T2.School vs T1."School Name").
-- 4. Metric column selection (Enrollment (K-12) vs Enrollment (Ages 5-17), Free Meal Count, FRPM Count).
-- 5. Numeric vs Lexicographical ordering (1000.0 > 200.0 vs '200.0' > '1000.0').
-- 6. ORDER BY DESC vs ASC and LIMIT 1.
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('CDS_HIGH_NO_DOC31', 'Active', 'C1', 'D1', 'Wrong_DOC_School', '52', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('CDS_NO_FRPM', 'Active', 'C1', 'D1', 'Unjoined_School', '31', 'TypeB', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('CDS_TARGET', 'Active', 'C1', 'D1', 'Correct_Target_School', '31', 'TypeB', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('CDS_LOW_ENROLL', 'Active', 'C1', 'D1', 'Wrong_Low_School', '31', 'TypeB', '2020-01-01');
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('CDS_HIGH_NO_DOC31', 'FRPM_Wrong_DOC', 5000.0, 5000.0, 5000.0, 5000.0);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('CDS_TARGET', 'FRPM_Name_Mismatch_1', 1000.0, 100.0, 50.0, 60.0);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('CDS_LOW_ENROLL', 'FRPM_Name_Mismatch_2', 200.0, 3000.0, 2500.0, 2600.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.DOC = 31 ORDER BY T1."Enrollment (K-12)" DESC, T1.cdscode NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
('Correct_Target_School',)
*/

-- Prediction Query
SELECT s.School FROM schools AS s INNER JOIN frpm AS f ON s.CDSCode = f.CDSCode WHERE s.DOC = '31' AND s.DOCType = 'State Special Schools' ORDER BY f."Enrollment (K-12)" DESC, s.cdscode NULLS LAST, f.cdscode NULLS LAST LIMIT 1;

/*
Prediction Result:
*/