-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, EdOpsCode, EdOpsName, EILCode, GSoffered, GSserved, LastUpdate) VALUES ('CDS001', '613360', '00001', 'Active', 'Alameda', 'DistA', 'SchoolA', '54', 'Unified', '60', 'Elem', 'SPECON', 'Special Ed', 'ELEM', '01-08', '01-08', '2020-01-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, EdOpsCode, EdOpsName, EILCode, GSoffered, GSserved, LastUpdate) VALUES ('CDS002', '613360', '00002', 'Active', 'Alameda', 'DistA', 'SchoolB', '54', 'Unified', '60', 'Elem', 'SPECON', 'Special Ed', 'ELEM', '09-12', '09-12', '2020-01-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, EdOpsCode, EdOpsName, EILCode, GSoffered, GSserved, LastUpdate) VALUES ('CDS003', '613360', '00003', 'Active', 'Alameda', 'DistB', 'SchoolC', '54', 'SPECON', 'SPECON', 'SPECON', 'TRAD', 'SPECON', 'SPECON', 'K-12', 'K-12', '2020-01-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, EdOpsCode, EdOpsName, EILCode, GSoffered, GSserved, LastUpdate) VALUES ('CDS004', '500000', '613360', 'Active', 'Alameda', 'DistC', 'SchoolD', '613360', 'Unified', '60', 'Elem', 'SPECON', 'Special Ed', 'ELEM', 'K-12', 'K-12', '2020-01-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, EdOpsCode, EdOpsName, EILCode, GSoffered, GSserved, LastUpdate) VALUES ('CDS005', '700000', '00005', 'Active', 'Alameda', 'DistD', 'SchoolE', '54', 'Unified', '60', 'Elem', 'SPECON', 'Special Ed', 'ELEM', 'K-12', 'K-12', '2020-01-01');
INSERT INTO frpm (CDSCode, "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "Educational Option Type", "Low Grade", "High Grade") VALUES ('CDS001', '01', 10001, '00001', 'Alameda', 'DistA', 'SchoolA', 'Special Education', '08', '01');
INSERT INTO frpm (CDSCode, "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "Educational Option Type", "Low Grade", "High Grade") VALUES ('CDS002', '01', 10002, '00002', 'OtherCounty', 'OtherDist', 'OtherSchool', 'Special Education', '03', '12');
INSERT INTO frpm (CDSCode, "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "Educational Option Type", "Low Grade", "High Grade") VALUES ('CDS003', '01', 10003, '00003', 'Alameda', 'DistB', 'SchoolC', 'SPECON', '01', '05');
INSERT INTO frpm (CDSCode, "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "Educational Option Type", "Low Grade", "High Grade") VALUES ('CDS004', '613360', 613360, '613360', 'Alameda', 'DistC', 'SchoolD', 'SPECON', '01', '05');
INSERT INTO frpm (CDSCode, "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "Educational Option Type", "Low Grade", "High Grade") VALUES ('CDS005', '01', 10005, '00002', 'Alameda', 'DistA', 'SchoolB', 'SPECON', '01', '05');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('CDS001', 'S', 'SchoolA', 'DistA', 'Alameda', 100, 50, 500, 500, 500, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(T1."Low Grade") FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.NCESDist = 613360 AND T2.EdOpsCode = 'SPECON';

/*
Gold Result:
('03',)
*/

-- Prediction Query
SELECT T1."Low Grade" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.NCESDist = '0613360' AND T2.EdOpsCode = 'SPECON' ORDER BY T1."Low Grade" ASC, T1.cdscode NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Prediction Result:
*/