-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('themselves', 'factor', 'another', 'about', 'Alameda', 'goal', 'spend', '78680 Charles Spurs Apt. 805
South David, ME 48296', 'PSC 0533, Box 1586
APO AP 98736', 'East Michelle', '23707', 'Nebraska', 'whitesandra@example.com', 'josephcobb@example.org', 'ebrennan@example.org', 'lisastevens@example.com', 'jeffreykeller@example.com', '641-245-8685x01429', 'boy', 'https://hartman.com/', '1980-01-01', '1976-07-07', 1013, 'image', 'we', '52', 'part', 'customer', 'environmental', 'section', 'Joseph Drake', 'right', 'Ball', 'site', 'since', 'religious', 1014, 1015.5, 1016.5, 'James', 'Reynolds', 'cindy14@example.net', 'Kyle', 'Ortiz', 'jterry@example.org', 'Elizabeth', 'Gray', 'christinaturner@example.net', '1977-08-08');
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('these', 'a', 'fly', 'few', 'Alameda', 'develop', NULL, '7738 Leon Underpass Apt. 148
Clarencebury, TX 41188', '00379 Stanley Roads
Lake Heather, NM 52884', 'East Diana', '01227', 'Wisconsin', 'osbornejeffery@example.net', 'pwilliams@example.org', 'danderson@example.net', 'stephanie79@example.net', 'jrivas@example.com', '(677)943-4873', 'bank', 'https://www.rogers-orozco.com/', '1980-01-01', '1978-09-09', 1017, 'certainly', 'city', '52', 'during', 'identify', 'rule', 'claim', 'Amy Russell', 'occur', 'Owens', 'assume', 'design', 'there', 1018, 1019.5, 1020.5, 'Robert', 'Stein', 'gateskathy@example.com', 'Thomas', 'Bender', 'karen68@example.net', 'Jessica', 'Marsh', 'tracynelson@example.com', '1979-10-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(School) AS REAL) / 12 FROM schools WHERE DOC = 52 AND County = 'Alameda' AND STRFTIME('%Y', OpenDate) = '1980';

/*
Gold Result:
(0.08333333333333333,)
*/

-- Prediction Query
SELECT CAST(COUNT(*) AS REAL) / 12 AS monthly_average FROM schools WHERE County = 'Alameda' AND DOC = 52 AND STRFTIME('%Y', OpenDate) = '1980';

/*
Prediction Result:
(0.16666666666666666,)
*/