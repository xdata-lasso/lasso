-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO schools (CDSCode, StatusType, County, District, School, Zip, MailZip, Charter, DOC, DOCType, LastUpdate) VALUES ('10101010000011', 'Active', 'Fresno', 'Fresno Unified', 'Discrepancy School 1', '93711', '93799', 0, '00', 'County Office of Education (COE)', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Zip, MailZip, Charter, DOC, DOCType, LastUpdate) VALUES ('10101010000012', 'Active', 'Fresno', 'Fresno County Office of Education', 'Discrepancy School 2', '93712', '93798', 1, '00', 'County Office of Education (COE)', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Zip, MailZip, Charter, DOC, DOCType, LastUpdate) VALUES ('10101010000013', 'Active', 'Fresno', 'Fresno County Office of Education', 'Discrepancy School 3', '93713', '93797', 1, '00', 'County Office of Education (COE)', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Zip, MailZip, Charter, DOC, DOCType, LastUpdate) VALUES ('10101010000014', 'Active', 'Fresno', 'Fresno County Office of Education', 'Unjoined School 4', '93714', '93796', 1, '00', 'County Office of Education (COE)', '2020-01-01');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Charter School (Y/N)") VALUES ('10101010000011', 'Fresno', 'Fresno County Office of Education', 'Discrepancy School 1', 1);
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Charter School (Y/N)") VALUES ('10101010000012', 'Fresno', 'Fresno Unified', 'Discrepancy School 2', 1);
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Charter School (Y/N)") VALUES ('10101010000013', 'Fresno', 'Fresno County Office of Education', 'Discrepancy School 3', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Zip FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1."District Name" = 'Fresno County Office of Education' AND T1."Charter School (Y/N)" = 1;

/*
Gold Result:
('93711',)
*/

-- Prediction Query
SELECT s.Zip FROM schools AS s JOIN frpm AS f ON s.CDSCode = f.CDSCode WHERE f."Charter School (Y/N)" = 1 AND s.County = 'Fresno' AND s.District = 'Fresno County Office of Education';

/*
Prediction Result:
('93712',)
*/