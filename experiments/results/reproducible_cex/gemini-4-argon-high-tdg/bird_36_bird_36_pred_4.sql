-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmFName1, AdmLName1, AdmEmail1, AdmFName2, AdmLName2, AdmEmail2, AdmFName3, AdmLName3, AdmEmail3, LastUpdate) VALUES ('10000000000000', 'Active', 'Zero County', 'Zero Dist', 'Zero School', '00', 'District', 'Zack', 'Zero1', 'z1@zero.edu', 'Zoe', 'Zero2', 'z2@zero.edu', 'Zane', 'Zero3', 'z3@zero.edu', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmFName1, AdmLName1, AdmEmail1, AdmFName2, AdmLName2, AdmEmail2, AdmFName3, AdmLName3, AdmEmail3, LastUpdate) VALUES ('10000000000001', 'Active', 'Alpha County', 'Alpha Dist', 'Alpha School', '54', 'High School District', 'Alice', 'Anderson', 'a1@alpha.edu', 'Aaron', 'Adams', 'a2@alpha.edu', 'Amy', 'Allen', 'a3@alpha.edu', '2020-01-02');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmFName1, AdmLName1, AdmEmail1, AdmFName2, AdmLName2, AdmEmail2, AdmFName3, AdmLName3, AdmEmail3, LastUpdate) VALUES ('10000000000002', 'Active', 'Beta County', 'Beta Dist', 'Beta School', '54', 'High School District', 'Bob', 'Baker', 'b1@beta.edu', 'Brenda', 'Brooks', 'b2@beta.edu', 'Brian', 'Bell', 'b3@beta.edu', '2020-01-03');
INSERT INTO schools (CDSCode, StatusType, County, District, School, DOC, DOCType, AdmFName1, AdmLName1, AdmEmail1, AdmFName2, AdmLName2, AdmEmail2, AdmFName3, AdmLName3, AdmEmail3, LastUpdate) VALUES ('10000000000003', 'Active', 'Gamma County', 'Gamma Dist', 'Gamma School', '54', 'High School District', 'Charlie', 'Clark', 'c1@gamma.edu', 'Clara', 'Carter', 'c2@gamma.edu', 'Chris', 'Cooper', 'c3@gamma.edu', '2020-01-04');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('10000000000001', 'S', 'Alpha School', 'Alpha Dist', 'Alpha County', 1000, 800, 650, 660, 640, 90);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('10000000000002', 'S', 'Beta SchoolMismatch', 'Alpha Dist', 'Alpha County', 200, 150, 450, 460, 440, 100);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('10000000000003', 'S', 'Gamma School', 'Gamma Dist', 'Gamma County', 50, 50, 500, 500, 500, 50);
INSERT INTO frpm (CDSCode, "Academic Year", "Enrollment (K-12)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('10000000000001', '2014-2015', 1000.0, 500.0, 600.0);
INSERT INTO frpm (CDSCode, "Academic Year", "Enrollment (K-12)", "Free Meal Count (K-12)", "FRPM Count (K-12)") VALUES ('10000000000003', '2014-2015', 50.0, 25.0, 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.AdmFName1, T2.AdmLName1, T2.AdmFName2, T2.AdmLName2, T2.AdmFName3, T2.AdmLName3 FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode ORDER BY T1.NumGE1500 DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
('Bob', 'Baker', 'Brenda', 'Brooks', 'Brian', 'Bell')
*/

-- Prediction Query
SELECT T2.AdmFName1, T2.AdmLName1, T2.AdmFName2, T2.AdmLName2, T2.AdmFName3, T2.AdmLName3 FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T1.NumGE1500 >= 1500 ORDER BY T1.NumGE1500 DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Prediction Result:
*/