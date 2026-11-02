-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('1', 'Active', 'C', 'D', 'DOC', 'DOCT', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('2', 'Active', 'C', 'D', 'DOC', 'DOCT', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('3', 'Active', 'C', 'D', 'DOC', 'DOCT', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('4', 'Active', 'C', 'D', 'DOC', 'DOCT', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('5', 'Active', 'C', 'D', 'DOC', 'DOCT', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('6', 'Active', 'C', 'D', 'DOC', 'DOCT', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('7', 'Active', 'C', 'D', 'DOC', 'DOCT', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('8', 'Active', 'C', 'D', 'DOC', 'DOCT', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('9', 'Active', 'C', 'D', 'DOC', 'DOCT', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('10', 'Active', 'C', 'D', 'DOC', 'DOCT', '2020-01-01');
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)") VALUES ('1', 'S1', 100, 50);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)") VALUES ('2', 'S2', 90, 50);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)") VALUES ('3', 'S3', 80, 50);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)") VALUES ('4', 'S4', 70, 50);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)") VALUES ('5', 'S5', 60, 50);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)") VALUES ('6', 'S6', 50, 50);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)") VALUES ('7', 'S7', 40, 50);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)") VALUES ('8', 'S8', 30, 50);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)") VALUES ('9', 'S9', 20, 50);
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)") VALUES ('10', 'S10', 10, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST("Free Meal Count (K-12)" AS REAL) / "Enrollment (K-12)" FROM frpm ORDER BY "Enrollment (K-12)" DESC, frpm.cdscode NULLS LAST LIMIT 2 OFFSET 9;

/*
Gold Result:
(0.5,)
*/

-- Prediction Query
SELECT "School Name", "Free Meal Count (K-12)" / "Enrollment (K-12)" AS "Eligible Free Rate" FROM frpm ORDER BY "Enrollment (K-12)" DESC, frpm.cdscode NULLS LAST LIMIT 2 OFFSET 9;

/*
Prediction Result:
('S10', 0.5)
*/