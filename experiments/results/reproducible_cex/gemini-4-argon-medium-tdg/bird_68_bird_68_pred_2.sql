-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1: Tests basic filtering (StatusType, SOC, ClosedDate boundaries 1979/1980/1989/1990) and COUNT(School) DESC ordering vs ASC or no-filter mutants.
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES
('10001', 'Closed', 'Alameda', 'Dist1', 'Sch1', '1970-01-01', '1980-01-01', '11', 'DocA', '11', '1985-01-01'),
('10002', 'Closed', 'Alameda', 'Dist1', 'Sch2', '1970-01-01', '1989-12-31', '11', 'DocA', '11', '1985-01-01'),
('10003', 'Closed', 'Butte', 'Dist2', 'Sch3', '1985-01-01', '1979-12-31', '11', 'DocA', '11', '1985-01-01'),
('10004', 'Closed', 'Butte', 'Dist2', 'Sch4', '1985-01-01', '1990-01-01', '11', 'DocA', '11', '1985-01-01'),
('10005', 'Closed', 'Butte', 'Dist2', 'Sch5', '1970-01-01', '1985-06-15', '11', 'DocA', '11', '1985-01-01'),
('10006', 'Active', 'Contra Costa', 'Dist3', 'Sch6', '1970-01-01', '1984-05-01', '11', 'DocA', '11', '1985-01-01'),
('10007', 'Active', 'Contra Costa', 'Dist3', 'Sch7', '1970-01-01', '1984-05-02', '11', 'DocA', '11', '1985-01-01'),
('10008', 'Active', 'Contra Costa', 'Dist3', 'Sch8', '1970-01-01', '1984-05-03', '11', 'DocA', '11', '1985-01-01'),
('10009', 'Closed', 'Del Norte', 'Dist4', 'Sch9', '1970-01-01', '1983-03-01', '11', 'DocA', '12', '1985-01-01'),
('10010', 'Closed', 'Del Norte', 'Dist4', 'Sch10', '1970-01-01', '1983-03-02', '11', 'DocA', '12', '1985-01-01'),
('10011', 'Closed', 'Del Norte', 'Dist4', 'Sch11', '1970-01-01', '1983-03-03', '11', 'DocA', '12', '1985-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT County FROM schools WHERE STRFTIME('%Y', ClosedDate) BETWEEN '1980' AND '1989' AND StatusType = 'Closed' AND SOC = 11 GROUP BY County ORDER BY COUNT(School) DESC, County NULLS LAST LIMIT 1;

/*
Gold Result:
('Alameda',)
*/

-- Prediction Query
SELECT "county" FROM "schools" WHERE "soc" = 11 AND "closeddate" BETWEEN '1980-01-01' AND '1989-12-31' GROUP BY "county" ORDER BY COUNT("closeddate") DESC, "county" NULLS LAST LIMIT 1;

/*
Prediction Result:
('Contra Costa',)
*/