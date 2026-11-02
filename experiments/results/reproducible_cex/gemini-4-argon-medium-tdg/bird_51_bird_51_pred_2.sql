-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. WHERE NOT T1.AvgScrRead IS NULL (CDS0 exists with NULL AvgScrRead, in SQLite NULLs sort first in ASC, so omitting the WHERE clause picks CDS0).
-- 2. INNER JOIN vs LEFT JOIN on schools (CDS_UNMATCHED has no satscores row).
-- 3. ORDER BY AvgScrRead ASC vs DESC (CDS1 has 300, CDS3 has 500).
-- 4. ORDER BY AvgScrRead vs AvgScrMath / AvgScrWrite / enroll12 / NumTstTakr / NumGE1500 (CDS3 has smaller values in all other numeric columns).
-- 5. Tie-breaking on T1.cds ASC (CDS1 and CDS2 both have AvgScrRead = 300).
-- 6. Column projection: T2.MailStreet vs T2.Street / T2.MailStrAbr, and T2.School vs T1.sname / T2.District.
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, MailStrAbr, DOC, DOCType, LastUpdate) VALUES ('CDS_UNMATCHED', 'Active', 'CountyU', 'DistU', 'School_Unmatched', 'Phys_U', 'Mail_U', 'Abr_U', '00', 'TypeU', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, MailStrAbr, DOC, DOCType, LastUpdate) VALUES ('CDS0', 'Active', 'County0', 'Dist0', 'School_NullRead', 'Phys_0', 'Mail_0', 'Abr_0', '00', 'Type0', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, MailStrAbr, DOC, DOCType, LastUpdate) VALUES ('CDS1', 'Active', 'County1', 'Dist1', 'School_One_Target', 'Phys_1', 'Mail_1_Target', 'Abr_1', '00', 'Type1', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, MailStrAbr, DOC, DOCType, LastUpdate) VALUES ('CDS2', 'Active', 'County2', 'Dist2', 'School_Two_Tie', 'Phys_2', 'Mail_2_Tie', 'Abr_2', '00', 'Type2', '2020-01-01');
INSERT INTO schools (CDSCode, StatusType, County, District, School, Street, MailStreet, MailStrAbr, DOC, DOCType, LastUpdate) VALUES ('CDS3', 'Active', 'County3', 'Dist3', 'School_Three_High', 'Phys_3', 'Mail_3_High', 'Abr_3', '00', 'Type3', '2020-01-01');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('CDS0', 'S', 'SatName_0', 'D0', 'C0', 50, 10, NULL, 100, 100, 1);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('CDS1', 'S', 'SatName_1', 'D1', 'C1', 500, 400, 300, 700, 700, 200);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('CDS2', 'S', 'SatName_2', 'D2', 'C2', 400, 300, 300, 600, 600, 150);
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, NumTstTakr, AvgScrRead, AvgScrMath, AvgScrWrite, NumGE1500) VALUES ('CDS3', 'S', 'SatName_3', 'D3', 'C3', 100, 50, 500, 200, 200, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.MailStreet, T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE NOT T1.AvgScrRead IS NULL ORDER BY T1.AvgScrRead ASC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
('Mail_1_Target', 'School_One_Target')
*/

-- Prediction Query
SELECT "schools"."mailstreet", "schools"."school" FROM "satscores" INNER JOIN "schools" ON "satscores"."cds" = "schools"."cdscode" ORDER BY "satscores"."avgscrread" ASC, satscores.cds NULLS LAST, schools.cdscode NULLS LAST LIMIT 1;

/*
Prediction Result:
('Mail_0', 'School_NullRead')
*/