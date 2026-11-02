-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('purpose', 'face', 'since', 'Closed', 'wait', 'offer', 'almost', '386 Shane Harbors
Port Lindachester, MA 36922', '76724 John Points Suite 969
Coxberg, NY 65187', 'New Stacey', '80008', 'Wisconsin', 'raymond57@example.net', 'carlosjohnson@example.com', 'clintonhopkins@example.com', 'dwhite@example.org', 'ntucker@example.com', '4982050097', 'worker', 'http://moore-bass.com/', '1970-01-01', '1974-05-05', 1001, 'protect', 'another', 'case', 'letter', 'option', 'use', 'also', 'Jessica Williams', 'two', 'Moore', 'talk', 'window', 'its', 1005, 1009.5, 1013.5, 'Jill', 'Reyes', 'ybailey@example.org', 'Sheila', 'Estes', 'samuel81@example.com', 'Kyle', 'Martinez', 'christinaturner@example.net', '1978-09-09');
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('brother', 'election', 'blue', 'Closed', 'wait', 'begin', 'all', '16155 Roman Stream Suite 816
New Kellystad, OK 25704', '22691 James Mountain
Tashatown, TX 94967', 'Lake Toddland', '55962', 'Washington', 'omartinez@example.org', 'palmerjoshua@example.com', 'ujenkins@example.org', 'ramosmichelle@example.net', 'martinaaron@example.com', '312.819.1361x93990', 'happy', 'http://garcia.com/', '1970-01-02', '1974-05-06', 1048.0, 'land', 'about', 'public', 'ok', 'act', 'rock', 'they', 'Timothy Stanton', 'investment', 'Spears', 'cost', 'go', 'suffer', 1080.0, 1086.5, 1092.5, 'John', 'Williams', 'andrewlee@example.com', 'Darrell', 'Baker', 'jonathanfletcher@example.org', 'Ricky', 'Fisher', 'torresjason@example.net', '1978-09-10');
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('ago', 'dog', 'require', 'Closed', 'wait', 'performance', 'better', '341 Michelle Light
Shawnstad, GA 49021', '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572', 'East Donna', '28261', 'Vermont', 'andrew83@example.net', 'ambercummings@example.net', 'brownjessica@example.org', 'williamsyvette@example.org', 'sara74@example.com', '+1-799-385-4353x46247', 'upon', 'http://jacobs-robbins.com/', '1970-01-03', '1974-05-07', 1095.0, 'themselves', 'goal', 'everybody', 'season', 'bag', 'well', 'hope', 'Hunter Fleming', 'pressure', 'Hancock', 'itself', 'stay', 'relationship', 1155.0, 1163.5, 1171.5, 'Erik', 'Ruiz', 'michelle45@example.net', 'Tara', 'Rodriguez', 'michaeljones@example.net', 'Richard', 'Bentley', 'steven73@example.net', '1978-09-11');
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('site', 'chair', 'sit', 'Closed', 'wait', 'knowledge', 'discover', '192 Frank Light Suite 835
East Lydiamouth, MO 35594', '809 Burns Creek
Natashaport, IA 08093', 'West Allison', '71187', 'Illinois', 'adrianzimmerman@example.org', 'esanchez@example.com', 'jamesherrera@example.org', 'housemelinda@example.org', 'smoore@example.org', '6794911838', 'authority', 'https://whitehead-mathis.com/', '1970-01-04', '1974-05-08', 1142.0, 'factor', 'spend', 'color', 'late', 'you', 'church', 'pass', 'Heather Castro', 'so', 'Cherry', 'country', 'word', 'treat', 1230.0, 1240.5, 1250.5, 'Jacqueline', 'Gonzalez', 'ifrazier@example.com', 'Gregory', 'Hamilton', 'cindy14@example.net', 'Kenneth', 'Byrd', 'yleon@example.net', '1978-09-12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT County, School, ClosedDate FROM schools WHERE County = (SELECT County FROM schools WHERE StatusType = 'Closed' GROUP BY County ORDER BY COUNT(School) DESC, County NULLS LAST LIMIT 1) AND StatusType = 'Closed' AND NOT school IS NULL;

/*
Gold Result:
('wait', 'almost', '1974-05-05')
('wait', 'all', '1974-05-06')
('wait', 'better', '1974-05-07')
('wait', 'discover', '1974-05-08')
*/

-- Prediction Query
SELECT County, School, ClosedDate FROM schools WHERE StatusType = 'Closed' AND NOT School IS NULL AND NOT ClosedDate IS NULL AND County = (SELECT County FROM schools WHERE StatusType = 'Closed' GROUP BY County ORDER BY COUNT(CDSCode) DESC, County NULLS LAST LIMIT 1) ORDER BY School, schools.cdscode NULLS LAST;

/*
Prediction Result:
('wait', 'all', '1974-05-06')
('wait', 'almost', '1974-05-05')
('wait', 'better', '1974-05-07')
('wait', 'discover', '1974-05-08')
*/