-- Schema DDL
CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, LastUpdate) VALUES ('0100001', 'Active', 'Alameda', 'Oakland USD', 'Lincoln High', '54', 'Unified School District', 'F', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, LastUpdate) VALUES ('0100002', 'Active', 'Los Angeles', 'LA USD', 'Lincoln High', '54', 'Unified School District', 'F', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, LastUpdate) VALUES ('0100003', 'Active', 'San Diego', 'SD USD', 'Washington High', '54', 'Unified School District', 'F', '2023-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, Virtual, LastUpdate) VALUES ('0100004', 'Active', 'Fresno', 'Fresno USD', NULL, '54', 'Unified School District', 'F', '2023-01-01');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('0100001', 'S', 'Lincoln High North', 'Oakland USD', 'Alameda', 200, 100, 380, 350, 370, 10);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('0100002', 'S', 'Lincoln High South', 'LA USD', 'Los Angeles', 250, 120, 390, 380, 360, 15);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('0100003', 'S', 'Washington High', 'SD USD', 'San Diego', 180, 90, 360, 360, 350, 8);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('0100004', 'S', 'Unnamed School', 'Fresno USD', 'Fresno', 150, 70, 340, 340, 330, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.School) FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.Virtual = 'F' AND T1.AvgScrMath < 400;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.CDSCode) FROM schools AS T1 INNER JOIN satscores AS T2 ON T1.CDSCode = T2.cds WHERE T2.AvgScrMath < 400 AND T1.Virtual = 'F';

/*
Prediction Result:
(4,)
*/