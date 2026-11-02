-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO schools (CDSCode, StatusType, County, District, School, FundingType, DOC, DOCType, LastUpdate) VALUES ('1', 'Active', 'C1', 'D1', 'S1', 'Locally funded', '00', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, FundingType, DOC, DOCType, LastUpdate) VALUES ('2', 'Active', 'C1', 'D1', 'S2', 'Locally funded', '00', 'TypeA', '2020-01-01');
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)") VALUES ('1', 100.0, 50.0);
INSERT INTO frpm (CDSCode, "Enrollment (K-12)", "Enrollment (Ages 5-17)") VALUES ('2', 100.0, 90.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School, T2.DOC FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.FundingType = 'Locally funded' AND (T1."Enrollment (K-12)" - T1."Enrollment (Ages 5-17)") > (SELECT AVG(T3."Enrollment (K-12)" - T3."Enrollment (Ages 5-17)") FROM frpm AS T3 INNER JOIN schools AS T4 ON T3.CDSCode = T4.CDSCode WHERE T4.FundingType = 'Locally funded');

/*
Gold Result:
('S1', '00')
*/

-- Prediction Query
SELECT s.School, s.DOCType FROM schools AS s INNER JOIN frpm AS f ON s.CDSCode = f.CDSCode WHERE s.FundingType = 'Locally funded' AND (f."Enrollment (K-12)" - f."Enrollment (Ages 5-17)") > (SELECT AVG(f2."Enrollment (K-12)" - f2."Enrollment (Ages 5-17)") FROM frpm AS f2 INNER JOIN schools AS s2 ON s2.CDSCode = f2.CDSCode WHERE s2.FundingType = 'Locally funded');

/*
Prediction Result:
('S1', 'TypeA')
*/