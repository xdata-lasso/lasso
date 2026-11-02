-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, State, MailState, Latitude, Longitude, DOC, DOCType, LastUpdate) VALUES ('1', 'Active', 'C1', 'D1', 'S_Sch1', 'City1', 'MCity1', 'NY', 'CA', 10.0, 100.0, '10', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, State, MailState, Latitude, Longitude, DOC, DOCType, LastUpdate) VALUES ('2', 'Active', 'C2', 'D2', 'S_Sch2', 'City2', 'MCity2', 'CA', 'NY', 20.0, 90.0, '10', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, State, MailState, Latitude, Longitude, DOC, DOCType, LastUpdate) VALUES ('3', 'Active', 'C3', 'D3', 'S_Sch3', 'City3', 'MCity3', 'CA', 'CA', 30.0, 10.0, '10', 'TypeA', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, State, MailState, Latitude, Longitude, DOC, DOCType, LastUpdate) VALUES ('4', 'Active', 'C4', 'D4', 'S_Sch4', 'City4', 'MCity4', 'CA', 'CA', 40.0, 5.0, '10', 'TypeA', '2020-01-01');
INSERT INTO frpm (CDSCode, "School Name", "Low Grade", "High Grade") VALUES ('1', 'F_Sch1', 'K', '5');
INSERT INTO frpm (CDSCode, "School Name", "Low Grade", "High Grade") VALUES ('3', 'F_Sch3', '1', '8');
INSERT INTO frpm (CDSCode, "School Name", "Low Grade", "High Grade") VALUES ('4', 'F_Sch4', '9', '12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.City, T1."Low Grade", T1."School Name" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.State = 'CA' ORDER BY T2.Latitude ASC, T1.cdscode NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
('City3', '1', 'F_Sch3')
*/

-- Prediction Query
SELECT "schools"."city", "schools"."school", "frpm"."low grade" FROM "schools" INNER JOIN "frpm" ON "schools"."cdscode" = "frpm"."cdscode" WHERE "schools"."state" = 'CA' ORDER BY "schools"."latitude" ASC, schools.cdscode NULLS LAST, frpm.cdscode NULLS LAST LIMIT 1;

/*
Prediction Result:
('City3', 'S_Sch3', '1')
*/