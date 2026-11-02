-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. LIMIT 5 boundary (more than 5 qualifying rows).
-- 2. WHERE T2.Virtual = 'F' vs 'V', 'N', NULL.
-- 3. INNER JOIN vs LEFT JOIN on schools (school without satscores).
-- 4. Duplicate school names (kills SELECT DISTINCT mutants).
-- 5. T2.School vs T1.sname vs T3."School Name" (frpm).
-- 6. T1.AvgScrRead vs AvgScrMath, AvgScrWrite, NumGE1500, enroll12, NumTstTakr.
-- 7. ORDER BY T1.AvgScrRead DESC vs ASC, and secondary tie-breaking on T1.cds ASC.
INSERT INTO schools (CDSCode, StatusType, County, District, School, Virtual, DOC, DOCType, LastUpdate) VALUES
('01', 'Active', 'C1', 'D1', 'Duplicate School Name', 'F', '00', 'Type', '2020-01-01'),
('02', 'Active', 'C1', 'D1', 'Duplicate School Name', 'F', '00', 'Type', '2020-01-01'),
('03', 'Active', 'C1', 'D1', 'Tie Read High B', 'F', '00', 'Type', '2020-01-01'),
('04', 'Active', 'C1', 'D1', 'Tie Read High A', 'F', '00', 'Type', '2020-01-01'),
('05', 'Active', 'C1', 'D1', 'Fifth School', 'F', '00', 'Type', '2020-01-01'),
('06', 'Active', 'C1', 'D1', 'Sixth School Cut By Limit', 'F', '00', 'Type', '2020-01-01'),
('07', 'Active', 'C1', 'D1', 'Seventh School Null Read', 'F', '00', 'Type', '2020-01-01'),
('08', 'Active', 'C1', 'D1', 'Virtual V School', 'V', '00', 'Type', '2020-01-01'),
('09', 'Active', 'C1', 'D1', 'Virtual Null School', NULL, '00', 'Type', '2020-01-01'),
('10', 'Active', 'C1', 'D1', 'No SAT Scores School', 'F', '00', 'Type', '2020-01-01');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES
('01', 'S', 'Wrong SName 1', 'D1', 'C1', 100, 50, 700, 300, 300, 10),
('02', 'S', 'Wrong SName 2', 'D1', 'C1', 100, 50, 650, 350, 350, 20),
('03', 'S', 'Wrong SName 3', 'D1', 'C1', 100, 50, 600, 800, 800, 90),
('04', 'S', 'Wrong SName 4', 'D1', 'C1', 100, 50, 600, 200, 200, 5),
('05', 'S', 'Wrong SName 5', 'D1', 'C1', 100, 50, 550, 750, 750, 80),
('06', 'S', 'Wrong SName 6', 'D1', 'C1', 100, 50, 500, 790, 790, 85),
('07', 'S', 'Wrong SName 7', 'D1', 'C1', 100, 50, NULL, 800, 800, 99),
('08', 'S', 'Wrong SName 8', 'D1', 'C1', 100, 50, 800, 800, 800, 100),
('09', 'S', 'Wrong SName 9', 'D1', 'C1', 100, 50, 790, 790, 790, 95);
INSERT INTO frpm (CDSCode, "School Name") VALUES
('01', 'FRPM Name 1'),
('02', 'FRPM Name 2'),
('03', 'FRPM Name 3'),
('04', 'FRPM Name 4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.Virtual = 'F' ORDER BY T1.AvgScrRead DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 5;

/*
Gold Result:
('Duplicate School Name',)
('Duplicate School Name',)
('Tie Read High B',)
('Tie Read High A',)
('Fifth School',)
*/

-- Prediction Query
SELECT sname FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.Virtual = 'F' ORDER BY T1.AvgScrRead DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 5;

/*
Prediction Result:
('Wrong SName 1',)
('Wrong SName 2',)
('Wrong SName 3',)
('Wrong SName 4',)
('Wrong SName 5',)
*/