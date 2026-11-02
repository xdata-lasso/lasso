-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests individual predicate omissions, duplicate city values (DISTINCT vs ALL), and column swap mutations (County/City, MailCity/City).
INSERT INTO schools (CDSCode, StatusType, County, District, City, MailCity, DOC, DOCType, EILCode, EILName, GSoffered, GSserved, LastUpdate) VALUES
('01', 'Active', 'Merced', 'D1', 'Atwater', 'AtwaterMail', '00', 'District', 'HS', 'High School', '9-12', '9-12', '2020-01-01'),
('02', 'Active', 'Merced', 'D1', 'Atwater', 'AtwaterMail', '00', 'District', 'HS', 'High School', '9-12', '9-12', '2020-01-01'),
('03', 'Active', 'Merced', 'D1', 'CityNoNSLP', 'Mail3', '00', 'District', 'HS', 'High School', '9-12', '9-12', '2020-01-01'),
('04', 'Active', 'Fresno', 'D1', 'CityNoCounty', 'Mail4', '00', 'District', 'HS', 'High School', '9-12', '9-12', '2020-01-01'),
('05', 'Active', 'Merced', 'D1', 'CityNoLow', 'Mail5', '00', 'District', 'HS', 'High School', '9-12', '9-12', '2020-01-01'),
('06', 'Active', 'Merced', 'D1', 'CityNoHigh', 'Mail6', '00', 'District', 'HS', 'High School', '9-12', '9-12', '2020-01-01'),
('07', 'Active', 'Merced', 'D1', 'CityNoEIL', 'Mail7', '00', 'District', 'ELEM', 'Elementary', '9-12', '9-12', '2020-01-01');
INSERT INTO frpm (CDSCode, "County Name", "NSLP Provision Status", "Low Grade", "High Grade") VALUES
('01', 'Merced', 'Lunch Provision 2', '9', '12'),
('02', 'WrongCountyInFRPM', 'Lunch Provision 2', '9', '12'),
('03', 'Merced', 'Provision 1', '9', '12'),
('04', 'Merced', 'Lunch Provision 2', '9', '12'),
('05', 'Merced', 'Lunch Provision 2', '10', '12'),
('06', 'Merced', 'Lunch Provision 2', '9', '11'),
('07', 'Merced', 'Lunch Provision 2', '9', '12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.City FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1."NSLP Provision Status" = 'Lunch Provision 2' AND T2.County = 'Merced' AND T1."Low Grade" = 9 AND T1."High Grade" = 12 AND T2.EILCode = 'HS';

/*
Gold Result:
('Atwater',)
('Atwater',)
*/

-- Prediction Query
SELECT schools.city FROM schools INNER JOIN frpm ON schools.cdscode = frpm.cdscode WHERE frpm."County Name" = 'Merced' AND frpm."NSLP Provision Status" = 'Lunch Provision 2' AND frpm."Low Grade" = '9' AND frpm."High Grade" = '12';

/*
Prediction Result:
('Atwater',)
('CityNoCounty',)
('CityNoEIL',)
*/