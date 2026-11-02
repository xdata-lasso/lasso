-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. COUNT(AdmFName1) vs COUNT(*) when NULLs are the most frequent (4 NULLs).
-- 2. Outer DISTINCT (Alice appears twice in DistA).
-- 3. Multiple districts for a top AdmFName1 (Alice in DistA and DistB).
-- 4. Tie-breaking in ORDER BY: Bob (count 2) vs Charlie (count 2) -> Bob wins alphabetically.
-- 5. LIMIT 2 vs LIMIT 1 or no limit (David has count 1, Charlie has count 2).
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, AdmFName1, LastUpdate) VALUES ('1', 'Active', 'C1', 'DistA', '00', 'TypeA', 'Alice', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, AdmFName1, LastUpdate) VALUES ('2', 'Active', 'C1', 'DistA', '00', 'TypeA', 'Alice', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, AdmFName1, LastUpdate) VALUES ('3', 'Active', 'C1', 'DistB', '00', 'TypeA', 'Alice', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, AdmFName1, LastUpdate) VALUES ('4', 'Active', 'C1', 'DistC', '00', 'TypeA', 'Bob', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, AdmFName1, LastUpdate) VALUES ('5', 'Active', 'C1', 'DistD', '00', 'TypeA', 'Bob', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, AdmFName1, LastUpdate) VALUES ('6', 'Active', 'C1', 'DistE', '00', 'TypeA', 'Charlie', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, AdmFName1, LastUpdate) VALUES ('7', 'Active', 'C1', 'DistE', '00', 'TypeA', 'Charlie', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, AdmFName1, LastUpdate) VALUES ('8', 'Active', 'C1', 'DistF', '00', 'TypeA', 'David', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, AdmFName1, LastUpdate) VALUES ('9', 'Active', 'C1', 'DistG', '00', 'TypeA', NULL, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, AdmFName1, LastUpdate) VALUES ('10', 'Active', 'C1', 'DistG', '00', 'TypeA', NULL, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, AdmFName1, LastUpdate) VALUES ('11', 'Active', 'C1', 'DistG', '00', 'TypeA', NULL, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, AdmFName1, LastUpdate) VALUES ('12', 'Active', 'C1', 'DistG', '00', 'TypeA', NULL, '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.AdmFName1, T1.District FROM schools AS T1 INNER JOIN (SELECT admfname1 FROM schools GROUP BY admfname1 ORDER BY COUNT(admfname1) DESC, admfname1 NULLS LAST LIMIT 2) AS T2 ON T1.AdmFName1 = T2.admfname1;

/*
Gold Result:
('Alice', 'DistA')
('Alice', 'DistB')
('Bob', 'DistC')
('Bob', 'DistD')
*/

-- Prediction Query
SELECT AdmFName, District, COUNT(*) AS NameCount FROM (SELECT AdmFName1 AS AdmFName, District FROM schools WHERE NOT AdmFName1 IS NULL UNION ALL SELECT AdmFName2, District FROM schools WHERE NOT AdmFName2 IS NULL UNION ALL SELECT AdmFName3, District FROM schools WHERE NOT AdmFName3 IS NULL) GROUP BY AdmFName, District ORDER BY NameCount DESC, AdmFName NULLS LAST, District NULLS LAST LIMIT 2;

/*
Prediction Result:
('Alice', 'DistA', 2)
('Charlie', 'DistE', 2)
*/