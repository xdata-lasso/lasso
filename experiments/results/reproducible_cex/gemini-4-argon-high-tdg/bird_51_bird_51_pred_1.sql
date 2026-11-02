-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, MailStreet, MailStrAbr, City, MailCity, Zip, MailZip, State, MailState, DOC, DOCType, LastUpdate) VALUES ('01100170100001', 'Active', 'Alameda', 'Oakland Unified', 'Oak Null High', '10 Physical Way', '10 Phys Way', '10 PO Box St', '10 POB St', 'Oakland', 'Oakland', '94601', '94601', 'CA', 'CA', '54', 'Unified School District', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, MailStreet, MailStrAbr, City, MailCity, Zip, MailZip, State, MailState, DOC, DOCType, LastUpdate) VALUES ('01100170100002', 'Active', 'Alameda', 'Oakland Unified', 'Lincoln High', '200 Physical Rd', '200 Phys Rd', '100 POB Avenue', '100 POB Ave', 'Oakland', 'Berkeley', '94602', '94701', 'CA', 'CA', '54', 'Unified School District', '2020-01-02');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, MailStreet, MailStrAbr, City, MailCity, Zip, MailZip, State, MailState, DOC, DOCType, LastUpdate) VALUES ('01100170100003', 'Active', 'Los Angeles', 'LA Unified', 'Washington Prep', '300 Sunset Blvd', '300 Sunset', '300 Mail Blvd', '300 Mail', 'Los Angeles', 'Los Angeles', '90001', '90001', 'CA', 'CA', '54', 'Unified School District', '2020-01-03');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, StreetAbr, MailStreet, MailStrAbr, City, MailCity, Zip, MailZip, State, MailState, DOC, DOCType, LastUpdate) VALUES ('01100170100004', 'Active', 'San Diego', 'SD Unified', 'Unmatched School', '400 Harbor Dr', '400 Harbor', '400 Mail Harbor', '400 Mail Hbr', 'San Diego', 'San Diego', '92101', '92101', 'CA', 'CA', '54', 'Unified School District', '2020-01-04');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('01100170100001', 'S', 'Oak Null Alt Name', 'Oakland Unified', 'Alameda', 10, 5, NULL, 200, 200, 0);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('01100170100002', 'S', 'Lincoln Senior High', 'Oakland Unified', 'Alameda', 200, 120, 310, 550, 540, 50);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('01100170100003', 'S', 'Washington Alt Name', 'LA Unified', 'Los Angeles', 60, 30, 420, 300, 290, 10);
INSERT INTO frpm (CDSCode, "Academic Year", "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('01100170100001', '2014-2015', 'Oak Null High', 100.0, 50.0, 60.0);
INSERT INTO frpm (CDSCode, "Academic Year", "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('01100170100003', '2014-2015', 'Washington Prep', 500.0, 400.0, 450.0);
INSERT INTO frpm (CDSCode, "Academic Year", "School Name", "Enrollment (K-12)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('01100170100004', '2014-2015', 'Unmatched School', 300.0, 100.0, 120.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.MailStreet, T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE NOT T1.AvgScrRead IS NULL ORDER BY T1.AvgScrRead ASC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
('100 POB Avenue', 'Lincoln High')
*/

-- Prediction Query
SELECT schools.MailStreet, schools.School FROM schools INNER JOIN satscores ON schools.CDSCode = satscores.cds ORDER BY satscores.AvgScrRead ASC, schools.cdscode NULLS LAST, satscores.cds NULLS LAST LIMIT 1;

/*
Prediction Result:
('10 PO Box St', 'Oak Null High')
*/