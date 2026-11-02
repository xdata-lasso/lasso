-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests:
-- 1. Zero numerator edge case: "Free Meal Count (Ages 5-17)" = 0.0 (ratio is 0.0, which is NOT NULL, but falsy if a mutant checks WHERE count / enrollment or WHERE count > 0).
-- 2. Unnecessary INNER JOIN with satscores (satscores is empty for some valid frpm rows).
-- 3. String matching precision on 'Continuation School' (case sensitivity, substrings like 'Continuation School - Alternative', NULLs).
-- 4. Sorting by ratio vs sorting by raw numerator ("Free Meal Count (Ages 5-17)") or denominator ("Enrollment (Ages 5-17)").
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S01', 'Active', 'C1', 'D1', '01', 'T1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S02', 'Active', 'C1', 'D1', '01', 'T1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S03', 'Active', 'C1', 'D1', '01', 'T1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S04', 'Active', 'C1', 'D1', '01', 'T1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S05', 'Active', 'C1', 'D1', '01', 'T1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S06', 'Active', 'C1', 'D1', '01', 'T1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('S07', 'Active', 'C1', 'D1', '01', 'T1', '2020-01-01');
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('S03', 'S', 100, 50);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('S04', 'S', 100, 50);
INSERT INTO frpm (CDSCode, "Educational Option Type", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)") VALUES ('S01', 'Continuation School', 50.0, 0.0);
INSERT INTO frpm (CDSCode, "Educational Option Type", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)") VALUES ('S02', 'Continuation School', 1000.0, 50.0);
INSERT INTO frpm (CDSCode, "Educational Option Type", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)") VALUES ('S03', 'Continuation School', 10.0, 2.0);
INSERT INTO frpm (CDSCode, "Educational Option Type", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)") VALUES ('S04', 'Continuation School', 100.0, 30.0);
INSERT INTO frpm (CDSCode, "Educational Option Type", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)") VALUES ('S05', 'continuation school', 100.0, 1.0);
INSERT INTO frpm (CDSCode, "Educational Option Type", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)") VALUES ('S06', 'Continuation School - Alt', 100.0, 1.0);
INSERT INTO frpm (CDSCode, "Educational Option Type", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)") VALUES ('S07', NULL, 100.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" FROM frpm WHERE "Educational Option Type" = 'Continuation School' AND NOT "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" IS NULL ORDER BY "Free Meal Count (Ages 5-17)" / "Enrollment (Ages 5-17)" ASC, frpm.cdscode NULLS LAST LIMIT 3;

/*
Gold Result:
(0.0,)
(0.05,)
(0.2,)
*/

-- Prediction Query
SELECT T2."Free Meal Count (Ages 5-17)" / T2."Enrollment (Ages 5-17)" AS EligibleFreeRate FROM schools AS T1 INNER JOIN frpm AS T2 ON T1.CDSCode = T2.CDSCode WHERE T1.EdOpsName = 'Continuation School' AND T2."Enrollment (Ages 5-17)" > 0 AND NOT T2."Free Meal Count (Ages 5-17)" IS NULL AND NOT T2."Enrollment (Ages 5-17)" IS NULL ORDER BY EligibleFreeRate ASC, T1.cdscode NULLS LAST, T2.cdscode NULLS LAST LIMIT 3;

/*
Prediction Result:
*/