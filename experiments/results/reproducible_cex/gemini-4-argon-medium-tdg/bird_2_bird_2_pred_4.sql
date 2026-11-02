-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, Zip, MailZip, Charter, DOC, DOCType, LastUpdate) VALUES ('CDS1', 'Active', 'Fresno', 'Other District', '93721', '93700', 0, '00', 'County', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, Zip, MailZip, Charter, DOC, DOCType, LastUpdate) VALUES ('CDS2', 'Active', 'Fresno', 'Fresno County Office of Education', '93721', '93700', 0, '00', 'County', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, Zip, MailZip, Charter, DOC, DOCType, LastUpdate) VALUES ('CDS3', 'Active', 'Fresno', 'Fresno County Office of Education', '93722', '93701', 1, '00', 'County', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, Zip, MailZip, Charter, DOC, DOCType, LastUpdate) VALUES ('CDS4', 'Active', 'Fresno', 'Other District', '93723', '93702', 0, '00', 'County', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, Zip, MailZip, Charter, DOC, DOCType, LastUpdate) VALUES ('CDS5', 'Active', 'Fresno', 'Fresno County Office of Education', '93724', '93703', 1, '00', 'County', '2023-01-01');
INSERT INTO frpm (CDSCode, "District Name", "Charter School (Y/N)") VALUES ('CDS1', 'Fresno County Office of Education', 1);
INSERT INTO frpm (CDSCode, "District Name", "Charter School (Y/N)") VALUES ('CDS2', 'Fresno County Office of Education', 1);
INSERT INTO frpm (CDSCode, "District Name", "Charter School (Y/N)") VALUES ('CDS3', 'Fresno County Office of Education', 0);
INSERT INTO frpm (CDSCode, "District Name", "Charter School (Y/N)") VALUES ('CDS4', 'Other District', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Zip FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1."District Name" = 'Fresno County Office of Education' AND T1."Charter School (Y/N)" = 1;

/*
Gold Result:
('93721',)
('93721',)
*/

-- Prediction Query
SELECT s.Zip FROM schools AS s JOIN frpm AS f ON s.CDSCode = f.CDSCode WHERE f."Charter School (Y/N)" = 1 AND s.County = 'Fresno' AND s.District = 'Fresno County Office of Education';

/*
Prediction Result:
('93721',)
*/