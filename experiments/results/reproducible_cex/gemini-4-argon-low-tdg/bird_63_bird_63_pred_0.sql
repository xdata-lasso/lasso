-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, LastUpdate) VALUES ('10000000000001', 'Active', 'Los Angeles', 'LA Unified', 'Target Charter School', 'Los Angeles', 'Pasadena', 1, '00D2', '54', 'Unified School District', 'Alice', 'Smith', 'Bob', 'Jones', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, LastUpdate) VALUES ('10000000000002', 'Active', 'Los Angeles', 'LA Unified', 'Non-Charter 00D2', 'Santa Monica', 'Beverly Hills', 0, '00D2', '54', 'Unified School District', 'Charlie', 'Brown', 'David', 'Wilson', '2023-01-02');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, LastUpdate) VALUES ('10000000000003', 'Active', 'Orange', 'Irvine Unified', 'Other Charter School', 'Irvine', 'Tustin', 1, '00D3', '54', 'Unified School District', 'Eve', 'Davis', 'Frank', 'Miller', '2023-01-03');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, LastUpdate) VALUES ('10000000000004', 'Closed', 'San Diego', 'SD Unified', 'Null Charter School', 'San Diego', 'La Jolla', NULL, '00D2', '54', 'Unified School District', 'Grace', 'Taylor', 'Heidi', 'Moore', '2023-01-04');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmFName2, AdmLName2, LastUpdate) VALUES ('10000000000005', 'Active', 'San Diego', 'SD Unified', 'Null Num School', 'Chula Vista', 'Coronado', 1, NULL, '54', 'Unified School District', 'Ivan', 'Anderson', 'Judy', 'Thomas', '2023-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AdmFName1, AdmLName1, School, City FROM schools WHERE Charter = 1 AND CharterNum = '00D2';

/*
Gold Result:
('Alice', 'Smith', 'Target Charter School', 'Los Angeles')
*/

-- Prediction Query
SELECT T1.School, T1.City, T1.AdmFName1, T1.AdmLName1, T1.AdmFName2, T1.AdmLName2, T1.AdmFName3, T1.AdmLName3 FROM schools AS T1 WHERE T1.Charter = 1 AND T1.CharterNum = '00D2';

/*
Prediction Result:
('Target Charter School', 'Los Angeles', 'Alice', 'Smith', 'Bob', 'Jones', None, None)
*/