-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('01', 'Active', 'Alameda', 'Alameda Unified', 'Alameda High', '54', 'Unified School District', '2015-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('02', 'Active', 'Contra Costa', 'Antioch Unified', NULL, '54', 'Unified School District', '2015-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('03', 'Active', 'Contra Costa', 'Antioch Unified', 'Deer Valley High', '54', 'Unified School District', '2015-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('04', 'Active', 'Contra Costa', 'San Ramon Valley Unified', 'Monte Vista High', '54', 'Unified School District', '2015-01-01');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name") VALUES ('01', 'Alameda', 'Alameda Unified', 'Alameda High');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name") VALUES ('02', 'Contra Costa', 'Antioch Unified', NULL);
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name") VALUES ('03', 'Contra Costa', 'Antioch Unified', 'Deer Valley High');
INSERT INTO frpm (CDSCode, "County Name", "District Name", "School Name") VALUES ('04', 'Contra Costa', 'San Ramon Valley Unified', 'Monte Vista High');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('01', 'S', 'Alameda High', 'Alameda Unified', 'Alameda', 2500, 2000, 550, 560, 540, 1500);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('02', 'D', NULL, 'Antioch Unified', 'Contra Costa', 2000, 1500, 500, 500, 500, 1000);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('03', 'S', 'Deer Valley High', 'Antioch Unified', 'Contra Costa', 600, 800, 480, 490, 470, 200);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('04', 'S', 'Monte Vista High', 'San Ramon Valley Unified', 'Contra Costa', 1200, 500, 620, 640, 630, 450);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sname FROM satscores WHERE cname = 'Contra Costa' AND NOT sname IS NULL ORDER BY NumTstTakr DESC, satscores.cds NULLS LAST LIMIT 1;

/*
Gold Result:
('Deer Valley High',)
*/

-- Prediction Query
SELECT sname, numtsttakr FROM satscores WHERE cname = 'Contra Costa' AND numtsttakr = (SELECT MAX(numtsttakr) FROM satscores WHERE cname = 'Contra Costa');

/*
Prediction Result:
(None, 1500)
*/