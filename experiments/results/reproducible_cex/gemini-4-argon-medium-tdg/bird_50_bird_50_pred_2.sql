-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, DOC, DOCType, LastUpdate) VALUES
('01', 'Active', 'C1', 'D1', 'School 1', '100 Main St', 'PO Box 1', '54', 'Unified', '2020-01-01'),
('02', 'Active', 'C1', 'D1', 'School 2', '200 Main St', 'PO Box 2', '54', 'Unified', '2020-01-01'),
('03', 'Active', 'C1', 'D1', 'School 3', '300 Main St', 'PO Box 3', '54', 'Unified', '2020-01-01'),
('04', 'Active', 'C1', 'D1', 'School 4', '400 Main St', 'PO Box 4', '54', 'Unified', '2020-01-01'),
('05', 'Active', 'C1', 'D1', 'School 5', '500 Main St', 'PO Box 5', '54', 'Unified', '2020-01-01'),
('06', 'Active', 'C1', 'D1', 'School 6', '600 Main St', 'PO Box 6', '54', 'Unified', '2020-01-01'),
('07', 'Active', 'C1', 'D1', 'School 7', '700 Main St', 'PO Box 7', '54', 'Unified', '2020-01-01'),
('08', 'Active', 'C1', 'D1', 'School 8', '800 Main St', 'PO Box 8', '54', 'Unified', '2020-01-01');
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES
('01', 'S', 'SatName 1', 100, 50, 400, 800, 400, 10),
('02', 'S', 'SatName 2', 100, 50, 410, 750, 410, 20),
('03', 'S', 'SatName 3', 100, 50, 420, 700, 420, 30),
('04', 'S', 'SatName 4', 100, 50, 430, 650, 430, 40),
('05', 'S', 'SatName 5', 100, 50, 440, 600, 440, 50),
('06', 'S', 'SatName 6', 100, 50, 450, 550, 450, 60),
('07', 'S', 'SatName 7', 100, 50, 460, 500, 460, 70);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.MailStreet, T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode ORDER BY T1.AvgScrMath DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1 OFFSET 5;

/*
Gold Result:
('PO Box 6', 'School 6')
*/

-- Prediction Query
SELECT "schools"."street", "schools"."school" FROM "satscores" INNER JOIN "schools" ON "satscores"."cds" = "schools"."cdscode" ORDER BY "satscores"."avgscrmath" DESC, satscores.cds NULLS LAST, schools.cdscode NULLS LAST LIMIT 1 OFFSET 6;

/*
Prediction Result:
('700 Main St', 'School 7')
*/