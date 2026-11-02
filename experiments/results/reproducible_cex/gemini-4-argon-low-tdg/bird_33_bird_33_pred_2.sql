-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1: Boundary testing on Free Meal Count (Ages 5-17) (1900, 2000, 1950, 1899.9, 2000.1) and Website NULL check
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS1', 'Active', 'C1', 'D1', 'S1_Schools', 'http://w1.com', '00', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS2', 'Active', 'C1', 'D1', 'S2_Schools', 'http://w2.com', '00', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS3', 'Active', 'C1', 'D1', 'S3_Schools', 'http://w3.com', '00', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS4', 'Active', 'C1', 'D1', 'S4_Schools', 'http://w4.com', '00', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS5', 'Active', 'C1', 'D1', 'S5_Schools', 'http://w5.com', '00', 'DT1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Website, DOC, DOCType, LastUpdate) VALUES ('CDS6', 'Active', 'C1', 'D1', 'S6_Schools', NULL, '00', 'DT1', '2020-01-01');
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (Ages 5-17)", "FRPM Count (K-12)") VALUES ('CDS1', 'S1_FRPM', 1900.0, 500.0, 500.0, 500.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (Ages 5-17)", "FRPM Count (K-12)") VALUES ('CDS2', 'S2_FRPM', 2000.0, 500.0, 500.0, 500.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (Ages 5-17)", "FRPM Count (K-12)") VALUES ('CDS3', 'S3_FRPM', 1950.0, 500.0, 500.0, 500.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (Ages 5-17)", "FRPM Count (K-12)") VALUES ('CDS4', 'S4_FRPM', 1899.9, 1950.0, 1950.0, 1950.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (Ages 5-17)", "FRPM Count (K-12)") VALUES ('CDS5', 'S5_FRPM', 2000.1, 1950.0, 1950.0, 1950.0);
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (Ages 5-17)", "Free Meal Count (K-12)", "FRPM Count (Ages 5-17)", "FRPM Count (K-12)") VALUES ('CDS6', 'S6_FRPM', 1950.0, 1950.0, 1950.0, 1950.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Website, T1."School Name" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1."Free Meal Count (Ages 5-17)" BETWEEN 1900 AND 2000 AND NOT T2.Website IS NULL;

/*
Gold Result:
('http://w1.com', 'S1_FRPM')
('http://w2.com', 'S2_FRPM')
('http://w3.com', 'S3_FRPM')
*/

-- Prediction Query
SELECT "schools"."website", "schools"."school" FROM "schools" INNER JOIN "frpm" ON "schools"."cdscode" = "frpm"."cdscode" WHERE "frpm"."free meal count (ages 5-17)" BETWEEN 1900 AND 2000;

/*
Prediction Result:
('http://w1.com', 'S1_Schools')
('http://w2.com', 'S2_Schools')
('http://w3.com', 'S3_Schools')
(None, 'S6_Schools')
*/