-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Duplicate Projection & Unmatched Join Rows: Tests DISTINCT mutations (two valid schools with the same phone number), LEFT/RIGHT JOIN mutations (school without frpm), and unnecessary join to satscores.
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Phone, OpenDate, Charter, FundingType) VALUES ('CDS1', 'Active', 'CountyA', 'DistA', '00', 'DocTypeA', '2020-01-01', '999-999-9999', '2010-01-01', 1, 'Directly funded');
INSERT INTO frpm (CDSCode, "Charter Funding Type", "Charter School (Y/N)") VALUES ('CDS1', 'Directly funded', 1);
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Phone, OpenDate, Charter, FundingType) VALUES ('CDS2', 'Active', 'CountyA', 'DistA', '00', 'DocTypeA', '2020-01-01', '999-999-9999', '2012-01-01', 1, 'Directly funded');
INSERT INTO frpm (CDSCode, "Charter Funding Type", "Charter School (Y/N)") VALUES ('CDS2', 'Directly funded', 1);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('CDS2', 'S', 100, 50);
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate, Phone, OpenDate, Charter, FundingType) VALUES ('CDS3', 'Active', 'CountyA', 'DistA', '00', 'DocTypeA', '2020-01-01', '888-888-8888', '2015-01-01', 1, 'Directly funded');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Phone FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1."Charter Funding Type" = 'Directly funded' AND T1."Charter School (Y/N)" = 1 AND T2.OpenDate > '2000-01-01';

/*
Gold Result:
('999-999-9999',)
('999-999-9999',)
*/

-- Prediction Query
SELECT DISTINCT "schools"."phone" FROM "schools" INNER JOIN "frpm" ON "schools"."cdscode" = "frpm"."cdscode" WHERE "frpm"."charter school (y/n)" = 1 AND "frpm"."charter funding type" = 'Directly funded' AND "schools"."opendate" > '2000-01-01';

/*
Prediction Result:
('999-999-9999',)
*/