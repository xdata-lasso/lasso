-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (StatusType, SOC, ClosedDate vs OpenDate), ORDER BY direction (DESC vs ASC), and LIMIT 1.
-- County_Loser has more total rows if any filter (StatusType, SOC, Date range) is omitted, or if OpenDate is used instead of ClosedDate.
-- County_Winner has 2 valid rows. County_RunnerUp has 1 valid row (catches ORDER BY ASC and missing LIMIT 1).
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES
('101', 'Closed', 'County_Winner', 'D1', 'S1', '1970-01-01', '1980-01-01', '00', 'Doc', '11', '2020-01-01'),
('102', 'Closed', 'County_Winner', 'D1', 'S2', '1970-01-01', '1989-12-31', '00', 'Doc', '11', '2020-01-01'),
('103', 'Closed', 'County_RunnerUp', 'D2', 'S3', '1970-01-01', '1985-06-15', '00', 'Doc', '11', '2020-01-01'),
('104', 'Active', 'County_Loser', 'D3', 'S4', '1982-01-01', '1985-01-01', '00', 'Doc', '11', '2020-01-01'),
('105', 'Active', 'County_Loser', 'D3', 'S5', '1983-01-01', '1986-01-01', '00', 'Doc', '11', '2020-01-01'),
('106', 'Active', 'County_Loser', 'D3', 'S6', '1984-01-01', '1987-01-01', '00', 'Doc', '11', '2020-01-01'),
('107', 'Closed', 'County_Loser', 'D3', 'S7', '1985-01-01', '1985-01-01', '00', 'Doc', '12', '2020-01-01'),
('108', 'Closed', 'County_Loser', 'D3', 'S8', '1985-01-01', '1985-01-01', '00', 'Doc', '12', '2020-01-01'),
('109', 'Closed', 'County_Loser', 'D3', 'S9', '1985-01-01', '1985-01-01', '00', 'Doc', '12', '2020-01-01'),
('110', 'Closed', 'County_Loser', 'D3', 'S10', '1985-01-01', '1979-12-31', '00', 'Doc', '11', '2020-01-01'),
('111', 'Closed', 'County_Loser', 'D3', 'S11', '1985-01-01', '1990-01-01', '00', 'Doc', '11', '2020-01-01'),
('112', 'Closed', 'County_Loser', 'D3', 'S12', '1985-01-01', '1991-01-01', '00', 'Doc', '11', '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT County FROM schools WHERE STRFTIME('%Y', ClosedDate) BETWEEN '1980' AND '1989' AND StatusType = 'Closed' AND SOC = 11 GROUP BY County ORDER BY COUNT(School) DESC, County NULLS LAST LIMIT 1;

/*
Gold Result:
('County_Winner',)
*/

-- Prediction Query
SELECT County FROM schools WHERE SOC = '11' AND STRFTIME('%Y', ClosedDate) BETWEEN '1980' AND '1989' GROUP BY County ORDER BY COUNT(CDSCode) DESC, County NULLS LAST LIMIT 1;

/*
Prediction Result:
('County_Loser',)
*/