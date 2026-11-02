-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('01100170100001', '0600020', '00001', 'Active', 'Alameda', 'Alameda County Office of Education', 'Juvenile Hall', '00', 'County Office of Education', '31', 'Juvenile Court Schools', '2020-01-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('01100170100002', '0600010', '00002', 'Active', 'Alameda', 'Alameda Unified', 'Oak High', '54', 'Unified School District', '31', 'Juvenile Court Schools', '2020-01-02');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('01100170100003', '0600030', '00003', 'Active', 'Alameda', 'Berkeley Unified', 'Pine Elem', '54', 'Unified School District', '31', 'Juvenile Court Schools', '2020-01-03');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('01100170100004', '0600040', '00004', 'Active', 'Alameda', 'Castro Valley Unified', 'Cedar Middle', '54', 'Unified School District', '30', 'Alternative Schools', '2020-01-04');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('01100170100005', '0600050', '00005', 'Active', 'Alameda', 'Dublin Unified', 'Elm High', '54', 'Unified School District', '32', 'Vocational Schools', '2020-01-05');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, DOC, DOCType, SOC, SOCType, LastUpdate) VALUES ('01100170100006', '0600060', '00006', 'Active', 'Alameda', 'Emery Unified', 'Birch School', '54', 'Unified School District', NULL, NULL, '2020-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NCESDist FROM schools WHERE SOC = 31;

/*
Gold Result:
('0600020',)
('0600010',)
('0600030',)
*/

-- Prediction Query
SELECT NCESSchool FROM schools WHERE SOC = 31;

/*
Prediction Result:
('00001',)
('00002',)
('00003',)
*/