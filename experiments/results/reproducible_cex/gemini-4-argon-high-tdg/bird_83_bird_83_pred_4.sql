-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, DOC, DOCType, GSoffered, GSserved, Magnet, LastUpdate) VALUES ('01000010000001', 'Active', 'Los Angeles', 'LA Unified', 'Alpha Magnet', 'Los Angeles', 'LA Mail 1', 0, '54', 'Unified School District', 'K-8', 'K-6', 1, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, DOC, DOCType, GSoffered, GSserved, Magnet, LastUpdate) VALUES ('01000010000002', 'Active', 'Los Angeles', 'LA Unified', 'Beta Magnet', 'Los Angeles', 'LA Mail 2', 1, '54', 'Unified School District', 'K-8', 'K-8', 1, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, DOC, DOCType, GSoffered, GSserved, Magnet, LastUpdate) VALUES ('02000020000001', 'Active', 'San Diego', 'SD Unified', 'Gamma Magnet', 'San Diego', 'SD Mail 1', 0, '54', 'Unified School District', 'K-8', 'K-8', 1, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, DOC, DOCType, GSoffered, GSserved, Magnet, LastUpdate) VALUES ('03000030000001', 'Active', 'Fresno', 'Fresno Unified', 'Delta Charter', 'Fresno', 'Fresno', 1, '54', 'Unified School District', 'K-8', 'K-8', 0, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, DOC, DOCType, GSoffered, GSserved, Magnet, LastUpdate) VALUES ('04000040000001', 'Active', 'Alameda', 'Oakland Unified', 'Epsilon Magnet', 'Oakland', 'Oakland', 1, '54', 'Unified School District', 'K-12', 'K-8', 1, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, DOC, DOCType, GSoffered, GSserved, Magnet, LastUpdate) VALUES ('05000050000001', 'Active', 'Sacramento', 'Sac Unified', 'Zeta Magnet', 'Sacramento', 'Sacramento', 1, '54', 'Unified School District', 'K-8', 'K-8', 1, '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, City, MailCity, Charter, DOC, DOCType, GSoffered, GSserved, Magnet, LastUpdate) VALUES ('02000020000002', 'Active', 'San Diego', 'SD Unified', 'Unjoined Magnet', 'San Diego', 'SD Mail 2', 1, '54', 'Unified School District', 'K-8', 'K-8', 1, '2020-01-01');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Educational Option Type", "NSLP Provision Status", "Charter School (Y/N)", "Low Grade", "High Grade") VALUES ('01000010000001', 'Los Angeles', 'LA Unified', 'Alpha Magnet', 'Traditional', 'Multiple Provision Types', 0, '1', '6');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Educational Option Type", "NSLP Provision Status", "Charter School (Y/N)", "Low Grade", "High Grade") VALUES ('01000010000002', 'Los Angeles', 'LA Unified', 'Beta Magnet', 'Traditional', 'Multiple Provision Types', 1, 'K', '8');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Educational Option Type", "NSLP Provision Status", "Charter School (Y/N)", "Low Grade", "High Grade") VALUES ('02000020000001', 'San Diego', 'SD Unified', 'Gamma Magnet', 'Traditional', 'Multiple Provision Types', 0, 'K', '8');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Educational Option Type", "NSLP Provision Status", "Charter School (Y/N)", "Low Grade", "High Grade") VALUES ('03000030000001', 'Fresno', 'Fresno Unified', 'Delta Charter', 'Traditional', 'Multiple Provision Types', 1, 'K', '8');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Educational Option Type", "NSLP Provision Status", "Charter School (Y/N)", "Low Grade", "High Grade") VALUES ('04000040000001', 'Alameda', 'Oakland Unified', 'Epsilon Magnet', 'Traditional', 'Multiple Provision Types', 1, 'K', '8');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name", "Educational Option Type", "NSLP Provision Status", "Charter School (Y/N)", "Low Grade", "High Grade") VALUES ('05000050000001', 'Sacramento', 'Sac Unified', 'Zeta Magnet', 'Multiple Provision Types', 'Provision 2', 1, 'K', '8');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr) VALUES ('01000010000001', 'S', 'Alpha Magnet', 'LA Unified', 'Los Angeles', 100, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.City, COUNT(T2.CDSCode) FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.Magnet = 1 AND T2.GSoffered = 'K-8' AND T1."NSLP Provision Status" = 'Multiple Provision Types' GROUP BY T2.City;

/*
Gold Result:
('Los Angeles', 2)
('San Diego', 1)
*/

-- Prediction Query
SELECT COUNT(DISTINCT CASE WHEN f."NSLP Provision Status" = 'Multiple Provision Types' THEN s.CDSCode END) AS num_schools_with_multiple_provision_types, COUNT(DISTINCT s.City) AS num_cities_with_k8_span, s.City, COUNT(s.CDSCode) AS num_schools_per_city FROM schools AS s JOIN frpm AS f ON s.CDSCode = f.CDSCode WHERE s.Magnet = 1 AND s.GSserved = 'K-8' GROUP BY s.City;

/*
Prediction Result:
(1, 1, 'Los Angeles', 1)
(1, 1, 'Oakland', 1)
(0, 1, 'Sacramento', 1)
(1, 1, 'San Diego', 1)
*/