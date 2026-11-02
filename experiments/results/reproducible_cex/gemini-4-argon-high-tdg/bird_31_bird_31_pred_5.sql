-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C01', 'Active', 'Alameda', 'Dist1', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C02', 'Closed', 'Alameda', 'Dist1', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C03', 'Active', 'Butte', 'Dist2', '52', 'Elementary', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C04', 'Active', 'Butte', 'Dist2', '52', 'Elementary', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C05', 'Merged', 'Fresno', 'Dist3', '56', 'High', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C06', 'Active', 'Fresno', 'Dist3', '56', 'High', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C07', 'Active', 'Kern', 'Dist4', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C08', 'Closed', 'Kern', 'Dist4', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C09', 'Active', 'Marin', 'Dist5', '52', 'Elementary', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C10', 'Closed', 'Marin', 'Dist5', '52', 'Elementary', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C11', 'Active', 'Napa', 'Dist6', '56', 'High', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C12', 'Active', 'Napa', 'Dist6', '56', 'High', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C13', 'Active', 'Orange', 'Dist7', '54', 'Unified', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, DOC, DOCType, LastUpdate) VALUES ('C14', 'Active', 'Orange', 'Dist7', '54', 'Unified', '2020-01-01');
INSERT INTO frpm (CDSCode, "Academic Year", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C01', '2014-2015', 1, 2000.0, 200.0, 0.99, 300.0, 0.88, 100.0, 10.0, 0.77, 20.0, 0.66);
INSERT INTO frpm (CDSCode, "Academic Year", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C02', '2014-2015', 0, 1900.0, 380.0, 0.98, 400.0, 0.87, 200.0, 20.0, 0.76, 30.0, 0.65);
INSERT INTO frpm (CDSCode, "Academic Year", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C03', '2014-2015', 1, 1800.0, 540.0, 0.97, 600.0, 0.86, 300.0, 30.0, 0.75, 40.0, 0.64);
INSERT INTO frpm (CDSCode, "Academic Year", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C04', '2014-2015', 0, 1700.0, 170.0, 0.96, 250.0, 0.85, 400.0, 40.0, 0.74, 50.0, 0.63);
INSERT INTO frpm (CDSCode, "Academic Year", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C05', '2014-2015', 1, 1600.0, 400.0, 0.95, 500.0, 0.84, 500.0, 50.0, 0.73, 60.0, 0.62);
INSERT INTO frpm (CDSCode, "Academic Year", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C06', '2014-2015', 0, 1500.0, 750.0, 0.94, 800.0, 0.83, 600.0, 60.0, 0.72, 70.0, 0.61);
INSERT INTO frpm (CDSCode, "Academic Year", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C07', '2014-2015', 1, 1400.0, 350.0, 0.93, 450.0, 0.82, 700.0, 70.0, 0.71, 80.0, 0.60);
INSERT INTO frpm (CDSCode, "Academic Year", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C08', '2014-2015', 0, 1200.0, 300.0, 0.92, 420.0, 0.81, 800.0, 80.0, 0.70, 90.0, 0.59);
INSERT INTO frpm (CDSCode, "Academic Year", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C09', '2014-2015', 1, 1000.0, 125.0, 0.91, 225.0, 0.80, 900.0, 90.0, 0.69, 100.0, 0.58);
INSERT INTO frpm (CDSCode, "Academic Year", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C10', '2013-2014', 0, 800.0, 120.0, 0.90, 280.0, 0.79, 1000.0, 110.0, 0.68, 120.0, 0.57);
INSERT INTO frpm (CDSCode, "Academic Year", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C11', '2014-2015', 1, 500.0, 175.0, 0.89, 325.0, 0.78, 1100.0, 130.0, 0.67, 140.0, 0.56);
INSERT INTO frpm (CDSCode, "Academic Year", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C12', '2014-2015', 0, 400.0, 180.0, 0.88, 260.0, 0.77, 1200.0, 150.0, 0.66, 160.0, 0.55);
INSERT INTO frpm (CDSCode, "Academic Year", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C13', '2014-2015', 1, 250.0, 110.0, 0.87, 190.0, 0.76, 1300.0, 170.0, 0.65, 180.0, 0.54);
INSERT INTO frpm (CDSCode, "Academic Year", "Charter School (Y/N)", "Enrollment (K-12)", "Free Meal Count (K-12)", "Percent (%) Eligible Free (K-12)", "FRPM Count (K-12)", "Percent (%) Eligible FRPM (K-12)", "Enrollment (Ages 5-17)", "Free Meal Count (Ages 5-17)", "Percent (%) Eligible Free (Ages 5-17)", "FRPM Count (Ages 5-17)", "Percent (%) Eligible FRPM (Ages 5-17)") VALUES ('C14', '2014-2015', 0, 100.0, 63.0, 0.86, 85.0, 0.75, 1400.0, 190.0, 0.64, 200.0, 0.53);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C01', 'S', 50, 20);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C02', 'S', 60, 25);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C03', 'S', 70, 30);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C04', 'S', 80, 35);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C05', 'S', 90, 40);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C06', 'S', 100, 45);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C07', 'S', 110, 50);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C08', 'S', 120, 55);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C09', 'S', 130, 60);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C11', 'S', 150, 70);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C12', 'S', 160, 75);
INSERT INTO satscores (cds, rtype, enroll12, NumTstTakr) VALUES ('C13', 'S', 170, 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST("Free Meal Count (K-12)" AS REAL) / "Enrollment (K-12)" FROM frpm ORDER BY "Enrollment (K-12)" DESC, frpm.cdscode NULLS LAST LIMIT 2 OFFSET 9;

/*
Gold Result:
(0.15,)
(0.35,)
*/

-- Prediction Query
SELECT T1."Percent (%) Eligible Free (K-12)" FROM frpm AS T1 ORDER BY T1."Enrollment (K-12)" DESC, T1.cdscode NULLS LAST LIMIT 10 OFFSET 9;

/*
Prediction Result:
(0.9,)
(0.89,)
(0.88,)
(0.87,)
(0.86,)
*/