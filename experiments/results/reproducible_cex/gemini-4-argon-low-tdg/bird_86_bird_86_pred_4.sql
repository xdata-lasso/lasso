-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic selection, column projection (AdmLName1 vs AdmFName1/AdmLName2), string vs integer comparison ('0040' vs '40'), LIKE vs = ('00401'), and unnecessary INNER JOINs with frpm or satscores (which are empty here).
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmLName2, LastUpdate) VALUES ('CDS001', 'Active', 'County_Target', 'District_Target', 'School_Target', 1, '0040', '00', 'DOC_A', 'First_1', 'Last_1', 'Last_2', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmLName2, LastUpdate) VALUES ('CDS002', 'Active', 'County_Wrong1', 'District_Wrong1', 'School_Wrong1', 1, '40', '00', 'DOC_A', 'First_W1', 'Last_W1', 'Last_W2', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmLName2, LastUpdate) VALUES ('CDS003', 'Active', 'County_Wrong2', 'District_Wrong2', 'School_Wrong2', 1, '00401', '00', 'DOC_A', 'First_W2', 'Last_W2', 'Last_W3', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Charter, CharterNum, DOC, DOCType, AdmFName1, AdmLName1, AdmLName2, LastUpdate) VALUES ('CDS004', 'Active', 'County_Null', 'District_Null', 'School_Null', 0, NULL, '00', 'DOC_A', 'First_N', 'Last_N', 'Last_N2', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AdmLName1, District, County, School FROM schools WHERE CharterNum = '0040';

/*
Gold Result:
('Last_1', 'District_Target', 'County_Target', 'School_Target')
*/

-- Prediction Query
SELECT s.AdmLName1, f."District Name", f."County Name", f."School Name" FROM schools AS s INNER JOIN frpm AS f ON s.CDSCode = f.CDSCode WHERE f."Charter School Number" = '40';

/*
Prediction Result:
*/