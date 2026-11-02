-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO schools (cdscode, ncesdist, ncesschool, statustype, county, district, school, street, streetabr, city, zip, state, mailstreet, mailstrabr, mailcity, mailzip, mailstate, phone, ext, website, opendate, closeddate, charter, charternum, fundingtype, doc, doctype, soc, soctype, edopscode, edopsname, eilcode, eilname, gsoffered, gsserved, "virtual", magnet, latitude, longitude, admfname1, admlname1, admemail1, admfname2, admlname2, admemail2, admfname3, admlname3, admemail3, lastupdate) VALUES ('F', NULL, 'default2', 'F', 'default2', 'default2', 'default2', 'F', 'default1', 'F', 'default2', 'F', 'default1', 'default1', 'F', 'F', 'F', 'default1', 'default2', NULL, '2023-01-02', '2023-01-02', 1, 'default2', NULL, 'F', 'default2', 'default1', 'default1', 'default1', NULL, 'default1', NULL, 'F', 'default1', 'F', 5, 6.0, 0.0, 'F', 'F', NULL, 'F', 'default1', NULL, NULL, NULL, 'default2', '2023-01-01'), ('default2', 'F', NULL, 'default2', 'default2', 'default1', 'F', 'default1', NULL, 'default1', 'default1', NULL, 'F', 'default2', 'F', 'default2', 'default1', 'default1', NULL, NULL, '2023-01-02', '2023-01-01', 1, 'F', 'default1', 'default1', 'default2', 'F', 'default2', NULL, NULL, 'default1', NULL, 'default1', 'F', NULL, 0, 4.0, NULL, 'default1', 'F', NULL, 'default1', 'F', 'default2', 'default1', NULL, 'default2', '2023-01-02'), ('default1', 'F', 'F', 'default2', 'F', 'default2', NULL, 'default1', 'default2', NULL, 'F', 'F', 'default1', 'F', NULL, NULL, 'default2', 'F', 'F', 'default1', NULL, '2023-01-02', 6, NULL, 'default2', 'default2', 'default1', 'default1', 'F', 'F', NULL, 'default2', NULL, 'default1', 'F', 'F', 6, 4.0, 4.0, 'default1', NULL, 'default1', NULL, 'F', 'default2', 'default2', 'F', 'F', '2023-01-01'), ('unique_3', 'default1', 'F', 'default2', 'F', 'default1', 'default1', 'default2', 'default2', 'F', 'default1', 'default2', 'default1', 'default2', 'default1', NULL, 'default2', 'default1', 'default2', 'default1', '2023-01-02', '2023-01-01', 5, NULL, 'default1', 'default1', 'default2', 'F', 'F', NULL, 'default1', 'default2', 'default1', 'default2', 'F', 'default1', NULL, 0.0, 4.0, 'F', 'default2', NULL, 'default2', 'F', NULL, 'default2', 'default2', 'default2', '2023-01-02');
INSERT INTO satscores (cds, rtype, sname, dname, cname, enroll12, numtsttakr, avgscrread, avgscrmath, avgscrwrite, numge1500) VALUES ('default2', 'default2', 'default1', NULL, 'default1', 0, 6, 1, 6, 6, 6), ('F', 'default1', 'default2', NULL, 'F', 0, 1, 5, 1, 6, 6), ('unique_3', 'default2', 'F', 'default1', 'default1', 5, 4, 0, 6, NULL, 0), ('default1', 'default2', 'default2', 'default1', 'default1', 1, 0, 6, 0, 5, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.School FROM satscores AS T1 INNER JOIN schools AS T2 ON T1.cds = T2.CDSCode WHERE T2.Virtual = 'F' ORDER BY T1.AvgScrRead DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 5;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT sname FROM satscores JOIN schools ON satscores.cds = schools.CDSCode WHERE Virtual = 'F' AND (SELECT COUNT(*) FROM satscores AS sub WHERE sub.cname = satscores.cname AND sub.AvgScrRead > satscores.AvgScrRead) < 5 ORDER BY cname, AvgScrRead DESC, satscores.cds NULLS LAST, schools.cdscode NULLS LAST;

/*
Prediction Result:
('default2',)
('default2',)
*/