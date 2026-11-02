-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C001', 'Active', 'Alameda', 'Dist1', '01', 'DocType1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C002', 'Active', 'Alameda', 'Dist1', '01', 'DocType1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C003', 'Active', 'Alameda', 'Dist1', '01', 'DocType1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C004', 'Active', 'Alameda', 'Dist1', '01', 'DocType1', '2020-01-01');
INSERT INTO frpm (CDSCode, "FRPM Count (K-12)", "FRPM Count (Ages 5-17)", "Free Meal Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (K-12)") VALUES ('C001', 150.0, 900.0, 900.0, 95.0, 1000.0);
INSERT INTO frpm (CDSCode, "FRPM Count (K-12)", "FRPM Count (Ages 5-17)", "Free Meal Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (K-12)") VALUES ('C002', 500.0, 100.0, 100.0, 20.0, 200.0);
INSERT INTO frpm (CDSCode, "FRPM Count (K-12)", "FRPM Count (Ages 5-17)", "Free Meal Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (K-12)") VALUES ('C003', 300.0, 300.0, 300.0, 50.0, 500.0);
INSERT INTO frpm (CDSCode, "FRPM Count (K-12)", "FRPM Count (Ages 5-17)", "Free Meal Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (K-12)") VALUES ('C004', NULL, 999.0, 999.0, 99.0, 999.0);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C001', 'S', 100, 10);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C002', 'S', 200, 25);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C003', 'S', 300, 35);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C004', 'S', 400, 45);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NumTstTakr FROM satscores WHERE cds = (SELECT CDSCode FROM frpm ORDER BY "FRPM Count (K-12)" DESC, frpm.cdscode NULLS LAST LIMIT 1);

/*
Gold Result:
(25,)
*/

-- Prediction Query
SELECT SUM("satscores"."numtsttakr") FROM "satscores" INNER JOIN "frpm" ON "satscores"."cds" = "frpm"."cdscode" ORDER BY "frpm"."frpm count (k-12)" DESC, satscores.cds NULLS LAST, frpm.cdscode NULLS LAST LIMIT 1;

/*
Prediction Result:
(115,)
*/