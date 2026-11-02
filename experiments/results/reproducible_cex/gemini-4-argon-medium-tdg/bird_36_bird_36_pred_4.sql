-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- General case: Tests INNER JOIN, LEFT JOIN vs INNER JOIN (via unmatched schools), column projection order, and ORDER BY NumGE1500 DESC vs other columns (enroll12, NumTstTakr, AvgScr*).
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3) VALUES ('001', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01', 'Alice1', 'Smith1', 'Bob1', 'Jones1', 'Charlie1', 'Brown1');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3) VALUES ('002', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01', 'Alice2', 'Smith2', 'Bob2', 'Jones2', 'Charlie2', 'Brown2');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3) VALUES ('003', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01', 'Alice3', 'Smith3', 'Bob3', 'Jones3', 'Charlie3', 'Brown3');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3) VALUES ('000', 'Active', 'C1', 'D1', '01', 'DT1', '2020-01-01', 'UnmatchedF1', 'UnmatchedL1', 'UnmatchedF2', 'UnmatchedL2', 'UnmatchedF3', 'UnmatchedL3');
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('001', 'S', 500, 400, 600, 600, 600, 100);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('002', 'S', 100, 90, 400, 400, 400, 300);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('003', 'S', 300, 200, 500, 500, 500, 200);
INSERT INTO frpm (CDSCode) VALUES ('001');
INSERT INTO frpm (CDSCode) VALUES ('003');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.AdmFName1, T2.AdmLName1, T2.AdmFName2, T2.AdmLName2, T2.AdmFName3, T2.AdmLName3 FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode ORDER BY T1.NumGE1500 DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
('Alice2', 'Smith2', 'Bob2', 'Jones2', 'Charlie2', 'Brown2')
*/

-- Prediction Query
SELECT T2.AdmFName1, T2.AdmLName1, T2.AdmFName2, T2.AdmLName2, T2.AdmFName3, T2.AdmLName3 FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T1.NumGE1500 >= 1500 ORDER BY T1.NumGE1500 DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Prediction Result:
*/