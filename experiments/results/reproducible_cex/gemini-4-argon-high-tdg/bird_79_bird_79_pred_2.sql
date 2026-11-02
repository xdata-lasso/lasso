-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('01', 'Active', 'San Diego', 'SD Dist 1', '50', 'District', 'F', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('02', 'Active', 'San Diego', 'SD Dist 2', '50', 'District', 'F', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('03', 'Active', 'San Diego', 'SD Dist 3', '50', 'District', 'F', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('04', 'Active', 'San Diego', 'SD Dist 4', '50', 'District', 'V', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('05', 'Active', 'San Diego', 'SD Dist 5', '50', 'District', 'V', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('06', 'Active', 'San Diego', 'SD Dist 6', '50', 'District', NULL, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('07', 'Active', 'Santa Barbara', 'SB Dist 1', '50', 'District', 'F', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('08', 'Active', 'Santa Barbara', 'SB Dist 1', '50', 'District', 'F', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('09', 'Active', 'Santa Barbara', 'SB Dist 2', '50', 'District', 'V', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('10', 'Active', 'Santa Barbara', 'SB Dist 3', '50', 'District', 'V', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('11', 'Active', 'Santa Barbara', 'SB Dist 4', '50', 'District', 'V', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('12', 'Active', 'Santa Barbara', 'SB Dist 5', '50', 'District', 'V', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('13', 'Active', 'Santa Barbara', 'SB Dist 6', '50', 'District', 'V', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('14', 'Active', 'Los Angeles', 'LA Dist 1', '50', 'District', 'F', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('15', 'Active', 'Los Angeles', 'LA Dist 2', '50', 'District', 'F', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('16', 'Active', 'Los Angeles', 'LA Dist 3', '50', 'District', 'F', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, Virtual, LastUpdate) VALUES ('17', 'Active', 'Los Angeles', 'LA Dist 4', '50', 'District', 'F', '2020-01-01');
INSERT INTO frpm (CDSCode, "County Name") VALUES ('01', 'San Diego');
INSERT INTO frpm (CDSCode, "County Name") VALUES ('07', 'Santa Barbara');
INSERT INTO frpm (CDSCode, "County Name") VALUES ('08', 'Santa Barbara');
INSERT INTO satscores (cds, rtype, cname, enroll12, NumTstTakr) VALUES ('01', 'S', 'San Diego', 100, 50);
INSERT INTO satscores (cds, rtype, cname, enroll12, NumTstTakr) VALUES ('07', 'S', 'Santa Barbara', 100, 50);
INSERT INTO satscores (cds, rtype, cname, enroll12, NumTstTakr) VALUES ('08', 'S', 'Santa Barbara', 100, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT County, COUNT(Virtual) FROM schools WHERE (County = 'San Diego' OR County = 'Santa Barbara') AND Virtual = 'F' GROUP BY County ORDER BY COUNT(Virtual) DESC, County NULLS LAST LIMIT 1;

/*
Gold Result:
('San Diego', 3)
*/

-- Prediction Query
SELECT "County", COUNT("School") AS "NumberOfSchools" FROM "schools" WHERE "Virtual" = 'F' AND "County" IN ('San Diego', 'Santa Barbara') GROUP BY "County" ORDER BY "NumberOfSchools" DESC, "County" NULLS LAST, NumberOfSchools NULLS LAST LIMIT 1;

/*
Prediction Result:
('San Diego', 0)
*/