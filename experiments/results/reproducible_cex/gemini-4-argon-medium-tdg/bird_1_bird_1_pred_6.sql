-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests DISTINCT vs ALL (duplicate ratios in top 3), unjoined tables (if mutant INNER JOINs satscores, rows without satscores vanish),
-- and tie-breaking / secondary sort behavior.
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES
('10', 'Active', 'C1', 'D1', '00', 'District', '2020-01-01'),
('20', 'Active', 'C1', 'D1', '00', 'District', '2020-01-01'),
('30', 'Active', 'C1', 'D1', '00', 'District', '2020-01-01'),
('40', 'Active', 'C1', 'D1', '00', 'District', '2020-01-01');
INSERT INTO frpm (CDSCode, "Educational Option Type", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)") VALUES
-- Two schools with the exact same ratio (0.20), derived from different counts (20/100 vs 40/200)
-- Kills mutants using SELECT DISTINCT or GROUP BY, or sorting by numerator/denominator alone instead of the ratio
('20', 'Continuation School', 200.0, 40.0, 20.0),
('10', 'Continuation School', 100.0, 20.0, 20.0),
-- Third school with ratio 0.25 (derived from 75/300 -> higher numerator than '40' which has 50/100=0.50)
('30', 'Continuation School', 300.0, 75.0, 25.0),
-- Fourth school with ratio 0.50, but smaller numerator (50) and smaller denominator (100) than '30'
('40', 'Continuation School', 100.0, 50.0, 50.0);
-- Only provide satscores for '30' and '40' to kill mutants that unnecessarily INNER JOIN satscores
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES
('30', 'S', 100, 50),
('40', 'S', 100, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" FROM frpm WHERE "Educational Option Type" = 'Continuation School' AND NOT "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" IS NULL ORDER BY "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" ASC, frpm.cdscode NULLS LAST LIMIT 3;

/*
Gold Result:
(0.2,)
(0.2,)
(0.25,)
*/

-- Prediction Query
SELECT (t1."Free Meal Count (Ages 5-17)" / t1."Enrollment (Ages 5-17)") AS eligiblefreerate FROM frpm AS t1 INNER JOIN schools AS t2 ON t1.cdscode = t2.cdscode WHERE t2.soctype = 'Continuation High Schools' AND NOT t1."Free Meal Count (Ages 5-17)" IS NULL AND NOT t1."Enrollment (Ages 5-17)" IS NULL AND t1."Enrollment (Ages 5-17)" > 0 ORDER BY eligiblefreerate ASC, t1.cdscode NULLS LAST, t2.cdscode NULLS LAST LIMIT 3;

/*
Prediction Result:
*/