-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, OpenDate, ClosedDate, Charter, Magnet, DOC, DOCType, LastUpdate) VALUES ('01100170100001', '0600001', '00001', 'Active', 'Alameda', 'Oakland Unified', 'Oak High', '2005-09-01', NULL, 0, 0, '54', 'Unified School District', '2021-01-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, OpenDate, ClosedDate, Charter, Magnet, DOC, DOCType, LastUpdate) VALUES ('01100170100002', '0600002', '00002', 'Active', 'Alameda', 'Oakland Unified', 'Bay Tech', '2015-08-15', '2022-05-30', 1, 1, '54', 'Unified School District', '2022-06-01');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, OpenDate, ClosedDate, Charter, Magnet, DOC, DOCType, LastUpdate) VALUES ('01100170100003', '0600003', '00003', 'Active', 'Alameda', 'Oakland Unified', 'Pine Elementary', '1995-01-10', '2010-12-31', 0, 0, '52', 'Elementary School District', '2019-03-15');
INSERT INTO schools (CDSCode, NCESDist, NCESSchool, StatusType, County, District, School, OpenDate, ClosedDate, Charter, Magnet, DOC, DOCType, LastUpdate) VALUES ('01100170100004', '0600004', '00004', 'Active', 'Alameda', 'Oakland Unified', 'Unlisted Academy', '2023-01-01', NULL, 0, 0, '54', 'Unified School District', '2023-02-01');
INSERT INTO frpm (CDSCode, "Academic Year", "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)") VALUES ('01100170100001', '2014-15', '01', 10017, '0100001', 'Alameda', 'Oakland Unified', 'Oak High', 0, 1200.0, 400.0, 33.3, 500.0, 41.7, 1100.0, 380.0, 480.0);
INSERT INTO frpm (CDSCode, "Academic Year", "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)") VALUES ('01100170100002', '2014-15', '01', 10017, '0100002', 'Alameda', 'Oakland Unified', 'Bay Tech', 1, 850.0, 800.0, 94.1, 820.0, 96.5, 1500.0, 790.0, 810.0);
INSERT INTO frpm (CDSCode, "Academic Year", "County Code", "District Code", "School Code", "County Name", "District Name", "School Name", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "FRPM Count (Ages 5-17)") VALUES ('01100170100003', '2014-15', '01', 10017, '0100003', 'Alameda', 'Oakland Unified', 'Pine Elementary', 0, 300.0, 290.0, 96.7, 295.0, 98.3, 280.0, 270.0, 275.0);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('01100170100002', 'S', 'Bay Tech', 'Oakland Unified', 'Alameda', 2500, 500, 520, 530, 510, 300);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('01100170100004', 'S', 'Unlisted Academy', 'Oakland Unified', 'Alameda', 5000, 900, 600, 610, 590, 700);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.OpenDate FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode ORDER BY T1."Enrollment (K-12)" DESC, T1.cdscode NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
('2005-09-01',)
*/

-- Prediction Query
SELECT OpenDate FROM schools WHERE GSoffered = 'K-12' AND CDSCode = (SELECT CDSCode FROM frpm ORDER BY "Enrollment (K-12)" DESC, frpm.cdscode NULLS LAST LIMIT 1) LIMIT 1;

/*
Prediction Result:
*/