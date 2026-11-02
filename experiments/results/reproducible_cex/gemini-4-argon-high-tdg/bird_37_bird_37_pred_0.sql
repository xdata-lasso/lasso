-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, Street, StreetAbr, City, Zip, State, MailStreet, MailStrAbr, MailCity, MailZip, MailState, DOC, DOCType, LastUpdate) VALUES ('0001', 'D1', 'S1', 'Active', 'Alameda', 'Dist A', 'Alpha High', '100 Main St', '100 Main', 'Oakland', '94601', 'CA', 'PO Box 1', 'POB 1', 'MailOak', '94699', 'NV', '50', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, Street, StreetAbr, City, Zip, State, MailStreet, MailStrAbr, MailCity, MailZip, MailState, DOC, DOCType, LastUpdate) VALUES ('0002', 'D2', 'S2', 'Active', 'Fresno', 'Dist B', 'Beta High', '200 Oak Ave', '200 Oak', 'Fresno', '93701', 'CA', 'PO Box 2', 'POB 2', 'MailFre', '93799', 'OR', '50', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, Street, StreetAbr, City, Zip, State, MailStreet, MailStrAbr, MailCity, MailZip, MailState, DOC, DOCType, LastUpdate) VALUES ('0003', 'D3', 'S3', 'Active', 'Kern', 'Dist C', 'Gamma High', '300 Pine Rd', '300 Pine', 'Bakersfield', '93301', 'CA', 'PO Box 3', 'POB 3', 'MailBak', '93399', 'WA', '50', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, Street, StreetAbr, City, Zip, State, MailStreet, MailStrAbr, MailCity, MailZip, MailState, DOC, DOCType, LastUpdate) VALUES ('0004', 'D4', 'S4', 'Active', 'Marin', 'Dist D', 'Delta High', '400 Elm Blvd', '400 Elm', 'San Rafael', '94901', 'CA', 'PO Box 4', 'POB 4', 'MailSan', '94999', 'AZ', '50', 'Unified', '2020-01-01');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('0001', 'S', 'Beta High', 'Dist A', 'Alameda', 500, 50, 400, 400, 400, 15);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('0002', 'S', 'Alpha High', 'Dist B', 'Fresno', 100, 100, 600, 600, 600, 20);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('0003', 'S', 'Gamma High', 'Dist C', 'Kern', 200, 100, 500, 500, 500, 90);
INSERT INTO frpm (CDSCode, "Academic Year", "County Name", "District Name", "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('0001', '2013-14', 'Alameda', 'Dist A', 'Alpha High', 500.0, 100.0, 120.0);
INSERT INTO frpm (CDSCode, "Academic Year", "County Name", "District Name", "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('0003', '2013-14', 'Kern', 'Dist C', 'Gamma High', 200.0, 80.0, 90.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Street, T2.City, T2.Zip, T2.State FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode ORDER BY CAST(T1.NumGE1500 AS REAL) / T1.NumTstTakr ASC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
('200 Oak Ave', 'Fresno', '93701', 'CA')
*/

-- Prediction Query
SELECT T2.Street, T2.City, T2.Zip, T2.State FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode ORDER BY T1.NumGE1500 / T1.NumTstTakr ASC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Prediction Result:
('100 Main St', 'Oakland', '94601', 'CA')
*/