-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO schools (cdscode, ncesdist, ncesschool, statustype, county, district, school, street, streetabr, city, zip, state, mailstreet, mailstrabr, mailcity, mailzip, mailstate, phone, ext, website, opendate, closeddate, charter, charternum, fundingtype, doc, doctype, soc, soctype, edopscode, edopsname, eilcode, eilname, gsoffered, gsserved, "virtual", magnet, latitude, longitude, admfname1, admlname1, admemail1, admfname2, admlname2, admemail2, admfname3, admlname3, admemail3, lastupdate) VALUES ('default2', 'default1', 'default2', 'default2', 'default1', 'Alvarez', 'Larson', 'Alvarez', 'default1', NULL, 'default2', 'default1', 'Dante', 'Larson', NULL, 'Mike', 'default1', 'Dante', 'Alvarez', 'Larson', NULL, '2023-01-01', 0, NULL, 'default2', 'Mike', 'Dante', 'Larson', 'default2', 'Mike', 'Larson', 'default1', 'default1', 'Dante', NULL, 'Alvarez', 1, NULL, 1.0, 'default2', 'Larson', 'default1', 'default1', NULL, NULL, NULL, 'Mike', 'Alvarez', '2023-01-02'), ('Dante', 'Larson', 'Larson', 'default2', 'Dante', 'Mike', 'default2', 'default1', 'Dante', 'Dante', 'default1', NULL, 'default2', 'Larson', NULL, 'Mike', 'Mike', 'Dante', 'Alvarez', 'Mike', '2023-01-01', NULL, 0, 'Alvarez', 'default2', 'default2', 'default2', 'Mike', NULL, 'Mike', 'Larson', 'Larson', 'Larson', 'default1', 'Mike', 'Alvarez', 0, 1.0, NULL, NULL, 'Dante', 'Mike', 'default2', 'Dante', 'Alvarez', 'Alvarez', 'default1', 'Larson', '2023-01-01'), ('Alvarez', 'default2', 'Dante', 'Larson', 'Larson', 'Mike', 'Alvarez', 'Alvarez', 'Dante', 'Dante', 'Larson', 'Mike', 'Alvarez', 'default1', 'Dante', NULL, 'Alvarez', 'default2', 'Mike', 'Larson', '2023-01-02', '2023-01-02', NULL, 'Mike', 'Dante', 'Dante', 'Dante', 'default1', NULL, 'Alvarez', 'Larson', 'Dante', 'Alvarez', 'Mike', NULL, 'Dante', 0, 1.0, 1.0, NULL, 'Mike', NULL, NULL, 'Mike', 'default2', 'Dante', 'Alvarez', 'default2', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Website FROM schools WHERE (AdmFName1 = 'Mike' AND AdmLName1 = 'Larson') OR (AdmFName1 = 'Dante' AND AdmLName1 = 'Alvarez');

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Website FROM schools AS T1 WHERE (T1.AdmFName1 = 'Mike' AND T1.AdmLName1 = 'Larson') OR (T1.AdmFName2 = 'Dante' AND T1.AdmLName2 = 'Alvarez') OR (T1.AdmFName3 = 'Mike' AND T1.AdmLName3 = 'Larson') OR (T1.AdmFName3 = 'Dante' AND T1.AdmLName3 = 'Alvarez');

/*
Prediction Result:
('Larson',)
*/