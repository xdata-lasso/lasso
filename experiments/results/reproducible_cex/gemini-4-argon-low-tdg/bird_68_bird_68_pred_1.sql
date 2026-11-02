-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests COUNT(School) vs COUNT(*) vs COUNT(DISTINCT School), and secondary sort tie-breaking (County ASC).
-- County_Nulls has 3 rows, but 2 have NULL School (COUNT(School) = 1, COUNT(*) = 3).
-- County_Dups_B has 2 valid rows with identical School names (COUNT(School) = 2, COUNT(DISTINCT School) = 1).
-- County_Dups_A has 2 valid rows with distinct School names (COUNT(School) = 2, COUNT(DISTINCT School) = 2).
-- Because County_Dups_A and County_Dups_B tie at COUNT(School) = 2, secondary sort on County ASC picks County_Dups_A.
INSERT INTO schools (CDSCode, StatusType, County, District, School, OpenDate, ClosedDate, DOC, DOCType, SOC, LastUpdate) VALUES
('201', 'Closed', 'County_Nulls', 'D1', 'S1', '1970-01-01', '1984-05-05', '00', 'Doc', '11', '2020-01-01'),
('202', 'Closed', 'County_Nulls', 'D1', NULL, '1970-01-01', '1984-05-05', '00', 'Doc', '11', '2020-01-01'),
('203', 'Closed', 'County_Nulls', 'D1', NULL, '1970-01-01', '1984-05-05', '00', 'Doc', '11', '2020-01-01'),
('204', 'Closed', 'County_Dups_B', 'D2', 'SameName', '1970-01-01', '1982-03-15', '00', 'Doc', '11', '2020-01-01'),
('205', 'Closed', 'County_Dups_B', 'D2', 'SameName', '1970-01-01', '1988-11-20', '00', 'Doc', '11', '2020-01-01'),
('206', 'Closed', 'County_Dups_A', 'D3', 'Unique1', '1970-01-01', '1981-07-01', '00', 'Doc', '11', '2020-01-01'),
('207', 'Closed', 'County_Dups_A', 'D3', 'Unique2', '1970-01-01', '1986-09-10', '00', 'Doc', '11', '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT County FROM schools WHERE STRFTIME('%Y', ClosedDate) BETWEEN '1980' AND '1989' AND StatusType = 'Closed' AND SOC = 11 GROUP BY County ORDER BY COUNT(School) DESC, County NULLS LAST LIMIT 1;

/*
Gold Result:
('County_Dups_A',)
*/

-- Prediction Query
SELECT County FROM schools WHERE SOC = 11 AND StatusType = 'Closed' AND STRFTIME('%Y', ClosedDate) BETWEEN '1980' AND '1989' GROUP BY County ORDER BY COUNT(*) DESC, County NULLS LAST LIMIT 1;

/*
Prediction Result:
('County_Nulls',)
*/