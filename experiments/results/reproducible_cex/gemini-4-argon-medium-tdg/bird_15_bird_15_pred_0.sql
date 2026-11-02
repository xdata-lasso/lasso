-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. WHERE T1.StatusType = 'Active' filter (by having 'Closed' and 'Merged' rows with higher AvgScrRead).
-- 2. INNER JOIN vs LEFT JOIN on schools (by having an Active school with no satscores row and a lower CDSCode).
-- 3. ORDER BY AvgScrRead DESC vs ASC, and AvgScrRead vs AvgScrMath/Write/NumGE1500/NumTstTakr.
-- 4. SELECT T1.District vs T2.dname / T1.County / T1.School.
-- 5. Missing JOIN condition (Cartesian product) or wrong join key.
-- 6. Unnecessary INNER JOIN with `frpm` table (the winning school '03' is intentionally omitted from `frpm`).
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES
('01', 'Closed', 'County1', 'Dist_Closed_HighRead', 'School1', '01', 'DocType1', '2020-01-01'),
('02', 'Active', 'County2', 'Dist_Active_NoSAT', 'School2', '02', 'DocType2', '2020-01-01'),
('03', 'Active', 'County3', 'Dist_Winner', 'School3', '03', 'DocType3', '2020-01-01'),
('04', 'Active', 'County4', 'Dist_Active_LowRead_HighMath', 'School4', '04', 'DocType4', '2020-01-01'),
('05', 'Merged', 'County5', 'Dist_Merged_MaxRead', 'School5', '05', 'DocType5', '2020-01-01');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES
('01', 'S', 'SName1', 'DName_Wrong1', 'CName1', 100, 50, 700, 500, 500, 40),
('03', 'S', 'SName3', 'DName_Wrong3', 'CName3', 100, 50, 600, 400, 400, 20),
('04', 'S', 'SName4', 'DName_Wrong4', 'CName4', 500, 400, 500, 800, 800, 350),
('05', 'S', 'SName5', 'DName_Wrong5', 'CName5', 100, 50, 750, 750, 750, 45);
INSERT INTO frpm (CDSCode, "District Name") VALUES
('04', 'Dist_Active_LowRead_HighMath');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.District FROM schools AS T1 INNER JOIN satscores AS T2 ON T1.CDSCode = T2.cds WHERE T1.StatusType = 'Active' ORDER BY T2.AvgScrRead DESC, T1.cdscode NULLS LAST, T2.cds NULLS LAST LIMIT 1;

/*
Gold Result:
('Dist_Winner',)
*/

-- Prediction Query
SELECT dname FROM satscores WHERE cds IN (SELECT CDSCode FROM schools WHERE StatusType = 'Active') ORDER BY AvgScrRead DESC, satscores.cds NULLS LAST LIMIT 1;

/*
Prediction Result:
('DName_Wrong3',)
*/