-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive case, distinct column names across tables (School Name vs sname vs School), and boundary conditions (> 0.1 vs >= 0.1, > 0 vs >= 0).
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('1001', 'Active', 'Alameda', 'DistA', 'Schools_Name_1', '00', 'District', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('1002', 'Active', 'Alameda', 'DistA', 'Schools_Name_2', '00', 'District', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('1003', 'Active', 'Alameda', 'DistA', 'Schools_Name_3', '00', 'District', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('1004', 'Active', 'Alameda', 'DistA', 'Schools_Name_4', '00', 'District', '2023-01-01');
-- 1001: Matches all conditions (Ratio = 0.25 > 0.1, NumGE1500 = 1 > 0)
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (K-12)", "Enrollment (K-12)") VALUES ('1001', 'FRPM_Target_School', 25.0, 100.0);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('1001', 'S', 'SAT_School_1', 100, 50, 1);
-- 1002: Boundary fail on ratio (Ratio = 0.1, which is NOT > 0.1, NumGE1500 = 5 > 0)
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (K-12)", "Enrollment (K-12)") VALUES ('1002', 'FRPM_Boundary_Ratio', 10.0, 100.0);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('1002', 'S', 'SAT_School_2', 100, 50, 5);
-- 1003: Boundary fail on NumGE1500 (Ratio = 0.5 > 0.1, NumGE1500 = 0, which is NOT > 0)
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (K-12)", "Enrollment (K-12)") VALUES ('1003', 'FRPM_Boundary_NumGE', 50.0, 100.0);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('1003', 'S', 'SAT_School_3', 100, 50, 0);
-- 1004: Fails both conditions (Ratio = 0.05 < 0.1, NumGE1500 = -1 < 0)
INSERT INTO frpm (CDSCode, "School Name", "Free Meal Count (K-12)", "Enrollment (K-12)") VALUES ('1004', 'FRPM_Fail_Both', 5.0, 100.0);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('1004', 'S', 'SAT_School_4', 100, 50, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2."School Name" FROM satscores AS T1 INNER JOIN frpm AS T2 ON T1.cds = T2.CDSCode WHERE CAST(T2."Free Meal Count (K-12)" AS REAL) / T2."Enrollment (K-12)" > 0.1 AND T1.NumGE1500 > 0;

/*
Gold Result:
('FRPM_Target_School',)
*/

-- Prediction Query
SELECT T1."School Name" FROM frpm AS T1 INNER JOIN satscores AS T2 ON T1.CDSCode = T2.cds WHERE T1."Percent (%) Eligible Free (K-12)" > 0.1 AND T2.NumGE1500 >= 1500;

/*
Prediction Result:
*/