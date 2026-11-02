-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmEmail1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('10000000000001', 'Active', 'Alameda', 'Oakland Unified', 'Alpha Charter', 'Oakland', 'Berkeley', 1, '00D2', '54', 'Unified', 'John', 'Doe', 'jdoe@alpha.edu', 'Jane', 'Smith', 'Bob', 'Johnson', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmEmail1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('10000000000002', 'Active', 'Alameda', 'Oakland Unified', 'Beta School', 'San Francisco', 'San Jose', 0, '00D2', '54', 'Unified', 'Alice', 'Brown', 'abrown@beta.edu', 'Tom', 'White', 'Sam', 'Green', '2023-01-02');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmEmail1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('10000000000003', 'Active', 'Sacramento', 'Sac City Unified', 'Gamma Charter', 'Sacramento', 'Davis', 1, '00D3', '54', 'Unified', 'Charlie', 'Black', 'cblack@gamma.edu', 'Eve', 'Adams', 'Mallory', 'Clark', '2023-01-03');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmEmail1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, LastUpdate) VALUES ('10000000000004', 'Active', 'Los Angeles', 'LA Unified', 'Delta High', 'Los Angeles', 'Pasadena', 0, '0000', '54', 'Unified', 'David', 'Wilson', 'dwilson@delta.edu', 'Grace', 'Lee', 'Frank', 'Miller', '2023-01-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AdmFName1, AdmLName1, School, City FROM schools WHERE Charter = 1 AND CharterNum = '00D2';

/*
Gold Result:
('John', 'Doe', 'Alpha Charter', 'Oakland')
*/

-- Prediction Query
SELECT AdmFName1, AdmLName1, AdmFName2, AdmLName2, AdmFName3, AdmLName3, School, City FROM schools WHERE Charter = 1 AND CharterNum = '00D2';

/*
Prediction Result:
('John', 'Doe', 'Jane', 'Smith', 'Bob', 'Johnson', 'Alpha Charter', 'Oakland')
*/