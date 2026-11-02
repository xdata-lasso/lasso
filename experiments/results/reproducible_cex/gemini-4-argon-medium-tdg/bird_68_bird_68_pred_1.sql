-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2: Tests COUNT(School) vs COUNT(*) when School is NULL, and tests unnecessary JOINs with frpm/satscores.
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES
('20001', 'Closed', 'Fresno', 'Dist1', 'ValidSch1', '1960-01-01', '1982-05-10', '00', 'DocA', '11', '2000-01-01'),
('20002', 'Closed', 'Fresno', 'Dist1', 'ValidSch2', '1960-01-01', '1986-08-20', '00', 'DocA', '11', '2000-01-01'),
('20003', 'Closed', 'Glenn', 'Dist2', 'ValidSch3', '1960-01-01', '1981-02-15', '00', 'DocA', '11', '2000-01-01'),
('20004', 'Closed', 'Glenn', 'Dist2', NULL, '1960-01-01', '1983-04-10', '00', 'DocA', '11', '2000-01-01'),
('20005', 'Closed', 'Glenn', 'Dist2', NULL, '1960-01-01', '1987-11-30', '00', 'DocA', '11', '2000-01-01');
INSERT INTO frpm (CDSCode, "County Name") VALUES
('20003', 'Glenn'),
('20004', 'Glenn'),
('20005', 'Glenn');
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES
('20003', 'S', 100, 50),
('20004', 'S', 100, 50),
('20005', 'S', 100, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT County FROM schools WHERE STRFTIME('%Y', ClosedDate) BETWEEN '1980' AND '1989' AND StatusType = 'Closed' AND SOC = 11 GROUP BY County ORDER BY COUNT(School) DESC, County NULLS LAST LIMIT 1;

/*
Gold Result:
('Fresno',)
*/

-- Prediction Query
SELECT County FROM schools WHERE SOC = 11 AND StatusType = 'Closed' AND STRFTIME('%Y', ClosedDate) BETWEEN '1980' AND '1989' GROUP BY County ORDER BY COUNT(*) DESC, County NULLS LAST LIMIT 1;

/*
Prediction Result:
('Glenn',)
*/