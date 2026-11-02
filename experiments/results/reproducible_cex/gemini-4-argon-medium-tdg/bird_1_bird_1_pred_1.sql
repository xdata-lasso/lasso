-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests column confusion (K-12 vs Ages 5-17, Free Meal vs FRPM, Computed Ratio vs Precomputed Percent),
-- Educational Option Type vs School Type/EdOpsName, NULL filtering (numerator NULL, denominator NULL, division by zero),
-- ORDER BY direction, and LIMIT 3 boundary.
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, EdOpsName, SOCType, LastUpdate) VALUES
('01', 'Active', 'C1', 'D1', '00', 'District', 'Continuation School', 'Continuation High Schools', '2020-01-01'),
('02', 'Active', 'C1', 'D1', '00', 'District', 'Traditional', 'High Schools', '2020-01-01'),
('03', 'Active', 'C1', 'D1', '00', 'District', 'Continuation School', 'Continuation High Schools', '2020-01-01'),
('04', 'Active', 'C1', 'D1', '00', 'District', 'Continuation School', 'Continuation High Schools', '2020-01-01'),
('05', 'Active', 'C1', 'D1', '00', 'District', 'Continuation School', 'Continuation High Schools', '2020-01-01'),
('06', 'Active', 'C1', 'D1', '00', 'District', 'Continuation School', 'Continuation High Schools', '2020-01-01'),
('07', 'Active', 'C1', 'D1', '00', 'District', 'Continuation School', 'Continuation High Schools', '2020-01-01'),
('08', 'Active', 'C1', 'D1', '00', 'District', 'Continuation School', 'Continuation High Schools', '2020-01-01'),
('09', 'Active', 'C1', 'D1', '00', 'District', 'Continuation School', 'Continuation High Schools', '2020-01-01');
INSERT INTO frpm (CDSCode, "Educational Option Type", "School Type", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)") VALUES
-- Valid Continuation Schools with distinct ratios and deliberately inverted K-12 / FRPM / Percent values to kill column-swap mutants
('01', 'Continuation School', 'High Schools', 100.0, 15.0, 0.99, 90.0, 0.90, 100.0, 85.0, 0.85, 95.0, 0.95),
('03', 'Continuation School', 'High Schools', 200.0, 50.0, 0.88, 160.0, 0.80, 200.0, 150.0, 0.75, 180.0, 0.90),
('04', 'Continuation School', 'High Schools', 100.0, 35.0, 0.77, 70.0, 0.70, 100.0, 65.0, 0.65, 75.0, 0.75),
('05', 'Continuation School', 'High Schools', 100.0, 45.0, 0.10, 10.0, 0.10, 100.0, 5.0, 0.05, 10.0, 0.10),
-- Wrong Educational Option Type, but School Type and schools.EdOpsName say Continuation School (very low ratio 0.01 to tempt inclusion)
('02', 'Traditional', 'Continuation School', 100.0, 1.0, 0.01, 1.0, 0.01, 100.0, 1.0, 0.01, 1.0, 0.01),
-- NULL Free Meal Count (Ages 5-17)
('06', 'Continuation School', 'High Schools', 100.0, NULL, 0.02, 2.0, 0.02, 100.0, 2.0, 0.02, 2.0, 0.02),
-- NULL Enrollment (Ages 5-17)
('07', 'Continuation School', 'High Schools', NULL, 10.0, 0.03, 3.0, 0.03, 100.0, 3.0, 0.03, 3.0, 0.03),
-- Zero Enrollment (Ages 5-17) -> In SQLite, X / 0.0 evaluates to NULL, testing division-by-zero IS NOT NULL filtering
('08', 'Continuation School', 'High Schools', 0.0, 10.0, 0.04, 4.0, 0.04, 100.0, 4.0, 0.04, 4.0, 0.04),
-- Zero Free Meal Count (Ages 5-17) -> Evaluates to 0.0 (NOT NULL), tests that 0.0 is kept and not mistaken for NULL
('09', 'Continuation School', 'High Schools', 100.0, 0.0, 0.50, 50.0, 0.50, 100.0, 50.0, 0.50, 50.0, 0.50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" FROM frpm WHERE "Educational Option Type" = 'Continuation School' AND NOT "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" IS NULL ORDER BY "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" ASC, frpm.cdscode NULLS LAST LIMIT 3;

/*
Gold Result:
(0.0,)
(0.15,)
(0.25,)
*/

-- Prediction Query
SELECT CAST("Free Meal Count (Ages 5-17)" AS REAL) / "Enrollment (Ages 5-17)" AS EligibleFreeRate FROM frpm INNER JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE schools.EdOpsName = 'Continuation School' AND "Enrollment (Ages 5-17)" > 0 ORDER BY EligibleFreeRate ASC, frpm.cdscode NULLS LAST, schools.cdscode NULLS LAST LIMIT 3;

/*
Prediction Result:
(None,)
(0.0,)
(0.15,)
*/