-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests column mappings, exact string matching vs integer comparison ('0040' vs '40'), LIKE wildcard mutations ('%0040%'), and missing/extra INNER JOINs with frpm or satscores.
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmLName2, AdmLName3, LastUpdate) VALUES ('CDS1', 'Active', 'County_A', 'District_A', 'School_A', 1, '0040', '54', 'Unified', 'FirstName_A', 'LastName_A', 'WrongLName2_A', 'WrongLName3_A', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmLName2, AdmLName3, LastUpdate) VALUES ('CDS2', 'Active', 'County_B', 'District_B', 'School_B', 1, '40', '54', 'Unified', 'FirstName_B', 'LastName_B', 'WrongLName2_B', 'WrongLName3_B', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmLName2, AdmLName3, LastUpdate) VALUES ('CDS3', 'Active', 'County_C', 'District_C', 'School_C', 1, '0039', '54', 'Unified', 'FirstName_C', 'LastName_C', 'WrongLName2_C', 'WrongLName3_C', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmLName2, AdmLName3, LastUpdate) VALUES ('CDS4', 'Active', 'County_D', 'District_D', 'School_D', 1, '0041', '54', 'Unified', 'FirstName_D', 'LastName_D', 'WrongLName2_D', 'WrongLName3_D', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmLName2, AdmLName3, LastUpdate) VALUES ('CDS5', 'Active', 'County_E', 'District_E', 'School_E', 0, NULL, '54', 'Unified', 'FirstName_E', 'LastName_E', 'WrongLName2_E', 'WrongLName3_E', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmLName2, AdmLName3, LastUpdate) VALUES ('CDS6', 'Active', 'County_F', 'District_F', 'School_F', 1, '10040', '54', 'Unified', 'FirstName_F', 'LastName_F', 'WrongLName2_F', 'WrongLName3_F', '2023-01-01');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Charter School Number") VALUES ('CDS2', 'FRPM_County_B', 'FRPM_District_B', 'FRPM_School_B', '0040');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr) VALUES ('CDS2', 'S', 'SAT_School_B', 'SAT_District_B', 'SAT_County_B', 100, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AdmLName1, District, County, School FROM schools WHERE CharterNum = '0040';

/*
Gold Result:
('LastName_A', 'District_A', 'County_A', 'School_A')
*/

-- Prediction Query
SELECT s.AdmLName1, f."District Name", f."County Name", f."School Name" FROM schools AS s INNER JOIN frpm AS f ON s.CDSCode = f.CDSCode WHERE f."Charter School Number" = '40';

/*
Prediction Result:
*/