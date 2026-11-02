-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES ('01001', 'Closed', 'Alameda', 'Alameda Dist', 'Alameda 1', '1960-01-01', '1985-05-01', '54', 'Unified', '11', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES ('01002', 'Merged', 'Alameda', 'Alameda Dist', 'Alameda 2', '1960-01-01', '1985-05-01', '54', 'Unified', '11', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES ('01003', 'Merged', 'Alameda', 'Alameda Dist', 'Alameda 3', '1960-01-01', '1986-05-01', '54', 'Unified', '11', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES ('01004', 'Active', 'Alameda', 'Alameda Dist', 'Alameda 4', '1960-01-01', '1987-05-01', '54', 'Unified', '11', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES ('04001', 'Closed', 'Butte', 'Butte Dist', 'Butte 1', '1960-01-01', '1985-05-01', '54', 'Unified', '11', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES ('04002', 'Closed', 'Butte', 'Butte Dist', 'Butte 2', '1960-01-01', '1985-05-01', '11', 'Unified', '65', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES ('04003', 'Closed', 'Butte', 'Butte Dist', 'Butte 3', '1960-01-01', '1986-05-01', '11', 'Unified', '65', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES ('04004', 'Closed', 'Butte', 'Butte Dist', 'Butte 4', '1960-01-01', '1987-05-01', '11', 'Unified', '65', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES ('06001', 'Closed', 'Colusa', 'Colusa Dist', 'Colusa 1', '1960-01-01', '1985-05-01', '54', 'Unified', '11', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES ('06002', 'Closed', 'Colusa', 'Colusa Dist', 'Colusa 2', '1960-01-01', '1979-12-31', '54', 'Unified', '11', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES ('06003', 'Closed', 'Colusa', 'Colusa Dist', 'Colusa 3', '1960-01-01', '1990-01-01', '54', 'Unified', '11', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES ('06004', 'Closed', 'Colusa', 'Colusa Dist', 'Colusa 4', '1960-01-01', '1991-06-01', '54', 'Unified', '11', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES ('57001', 'Closed', 'Yolo', 'Yolo Dist', 'Yolo 1', '1960-01-01', '1984-05-01', '54', 'Unified', '11', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES ('57002', 'Closed', 'Yolo', 'Yolo Dist', 'Yolo 2', '1960-01-01', '1986-05-01', '54', 'Unified', '11', '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT County FROM schools WHERE STRFTIME('%Y', ClosedDate) BETWEEN '1980' AND '1989' AND StatusType = 'Closed' AND SOC = 11 GROUP BY County ORDER BY COUNT(School) DESC, County NULLS LAST LIMIT 1;

/*
Gold Result:
('Yolo',)
*/

-- Prediction Query
SELECT County FROM schools WHERE SOC = 11 AND ClosedDate BETWEEN '1980-01-01' AND '1989-12-31' GROUP BY County ORDER BY COUNT(*) DESC, County NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alameda',)
*/