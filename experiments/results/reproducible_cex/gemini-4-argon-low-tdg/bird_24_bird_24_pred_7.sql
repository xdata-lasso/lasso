-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive match, exact boundary conditions (0.1 and 0), and potential column mix-ups (Ages 5-17 vs K-12, FRPM vs Free Meal, school name sources).
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('CDS001', 'Active', 'Alameda', 'Alameda Unified', 'Schools_Table_Name_1', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('CDS002', 'Active', 'Alameda', 'Alameda Unified', 'Schools_Table_Name_2', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, LastUpdate) VALUES ('CDS003', 'Active', 'Alameda', 'Alameda Unified', 'Schools_Table_Name_3', '54', 'Unified', '2020-01-01');
-- Positive match: ratio = 11/100 = 0.11 > 0.1, NumGE1500 = 1 > 0.
-- Distinguishes T2."School Name" from T1.sname and schools.School.
-- Sets Ages 5-17 and FRPM columns to 0/low values to kill mutants using wrong columns.
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS001', 'FRPM_Valid_School', 100.0, 11.0, 0.05, 5.0, 0.05, 100.0, 5.0, 0.05, 5.0, 0.05);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('CDS001', 'S', 'SAT_Valid_School', 50, 20, 1);
-- Boundary fail 1: ratio = 10/100 = 0.1 (fails > 0.1, would pass >= 0.1).
-- Sets FRPM Count and Ages 5-17 to high values to catch mutants referencing those instead.
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('CDS002', 'FRPM_Boundary_Ratio', 100.0, 10.0, 25.0, 50.0, 50.0, 100.0, 50.0, 50.0, 50.0, 50.0);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('CDS002', 'S', 'SAT_Boundary_Ratio', 10, 20, 5);
-- Boundary fail 2: NumGE1500 = 0 (fails > 0, would pass >= 0).
INSERT INTO frpm (CDSCode, "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)") VALUES ('CDS003', 'FRPM_Boundary_SAT', 100.0, 50.0);
INSERT INTO satscores (cds, rtype, sname, enroll12, NumTstTakr, NumGE1500) VALUES ('CDS003', 'S', 'SAT_Boundary_SAT', 100, 50, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2."School Name" FROM satscores AS T1 INNER JOIN frpm AS T2 ON T1.cds = T2.CDSCode WHERE CAST(T2."Free Meal Count (K-12)" AS REAL) / T2."Enrollment (K-12)" > 0.1 AND T1.NumGE1500 > 0;

/*
Gold Result:
('FRPM_Valid_School',)
*/

-- Prediction Query
SELECT T1."School Name" FROM frpm AS T1 INNER JOIN satscores AS T2 ON T1.CDSCode = T2.cds WHERE T1."Percent (%) Eligible Free (K-12)" > 0.1 AND T2.NumGE1500 >= 1;

/*
Prediction Result:
('FRPM_Boundary_Ratio',)
*/