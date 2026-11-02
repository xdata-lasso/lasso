-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests column confusion (FRPM vs Free Meal, K-12 vs Ages 5-17, schools.County vs frpm."County Name") and OR vs AND logical mutations
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S1', 'Active', 'Orange', 'OUSD', '01', 'District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S2', 'Active', 'Los Angeles', 'LAUSD', '01', 'District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S3', 'Active', 'Los Angeles', 'LAUSD', '01', 'District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S4', 'Active', 'Los Angeles', 'LAUSD', '01', 'District', '2020-01-01');
INSERT INTO frpm (CDSCode, "County Name", "Free Meal Count (K-12)", "FRPM Count (K-12)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)") VALUES ('S1', 'Los Angeles', 600.0, 100.0, 100.0, 100.0);
INSERT INTO frpm (CDSCode, "County Name", "Free Meal Count (K-12)", "FRPM Count (K-12)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)") VALUES ('S2', 'Orange', 600.0, 600.0, 600.0, 600.0);
INSERT INTO frpm (CDSCode, "County Name", "Free Meal Count (K-12)", "FRPM Count (K-12)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)") VALUES ('S3', 'Los Angeles', 400.0, 600.0, 600.0, 600.0);
INSERT INTO frpm (CDSCode, "County Name", "Free Meal Count (K-12)", "FRPM Count (K-12)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)") VALUES ('S4', 'Los Angeles', 800.0, 600.0, 600.0, 600.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(CDSCode) FROM frpm WHERE "County Name" = 'Los Angeles' AND "Free Meal Count (K-12)" > 500 AND "Free Meal Count (K-12)" < 700;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM schools AS s INNER JOIN frpm AS f ON s.CDSCode = f.CDSCode WHERE s.County = 'Los Angeles' AND f."Free Meal Count (K-12)" > 500 AND f."FRPM Count (K-12)" < 700;

/*
Prediction Result:
(2,)
*/