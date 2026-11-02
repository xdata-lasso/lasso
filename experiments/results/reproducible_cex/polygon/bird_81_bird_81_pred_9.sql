-- Schema DDL
CREATE TABLE frpm (CDSCode TEXT NOT NULL PRIMARY KEY, "Academic Year" TEXT NULL, "County Code" TEXT NULL, "District Code" INTEGER NULL, "School Code" TEXT NULL, "County Name" TEXT NULL, "District Name" TEXT NULL, "School Name" TEXT NULL, "District Type" TEXT NULL, "School Type" TEXT NULL, "Educational Option Type" TEXT NULL, "NSLP Provision Status" TEXT NULL, "Charter School (Y/N)" INTEGER NULL, "Charter School Number" TEXT NULL, "Charter Funding Type" TEXT NULL, IRC INTEGER NULL, "Low Grade" TEXT NULL, "High Grade" TEXT NULL, "Enrollment (K-12)" REAL NULL, "Free Meal Count (K-12)" REAL NULL, "Percent (%) Eligible Free (K-12)" REAL NULL, "FRPM Count (K-12)" REAL NULL, "Percent (%) Eligible FRPM (K-12)" REAL NULL, "Enrollment (Ages 5-17)" REAL NULL, "Free Meal Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible Free (Ages 5-17)" REAL NULL, "FRPM Count (Ages 5-17)" REAL NULL, "Percent (%) Eligible FRPM (Ages 5-17)" REAL NULL, "2013-14 CALPADS Fall 1 Certification Status" INTEGER NULL, FOREIGN KEY (CDSCode) REFERENCES schools (CDSCode));

CREATE TABLE satscores (cds TEXT NOT NULL PRIMARY KEY, rtype TEXT NOT NULL, sname TEXT NULL, dname TEXT NULL, cname TEXT NULL, enroll12 INTEGER NOT NULL, NumTstTakr INTEGER NOT NULL, AvgScrRead INTEGER NULL, AvgScrMath INTEGER NULL, AvgScrWrite INTEGER NULL, NumGE1500 INTEGER NULL, FOREIGN KEY (cds) REFERENCES schools (CDSCode));

CREATE TABLE schools (CDSCode TEXT NOT NULL PRIMARY KEY, NCESDist TEXT NULL, NCESSchool TEXT NULL, StatusType TEXT NOT NULL, County TEXT NOT NULL, District TEXT NOT NULL, School TEXT NULL, Street TEXT NULL, StreetAbr TEXT NULL, City TEXT NULL, Zip TEXT NULL, State TEXT NULL, MailStreet TEXT NULL, MailStrAbr TEXT NULL, MailCity TEXT NULL, MailZip TEXT NULL, MailState TEXT NULL, Phone TEXT NULL, Ext TEXT NULL, Website TEXT NULL, OpenDate DATE NULL, ClosedDate DATE NULL, Charter INTEGER NULL, CharterNum TEXT NULL, FundingType TEXT NULL, DOC TEXT NOT NULL, DOCType TEXT NOT NULL, SOC TEXT NULL, SOCType TEXT NULL, EdOpsCode TEXT NULL, EdOpsName TEXT NULL, EILCode TEXT NULL, EILName TEXT NULL, GSoffered TEXT NULL, GSserved TEXT NULL, Virtual TEXT NULL, Magnet INTEGER NULL, Latitude REAL NULL, Longitude REAL NULL, AdmFName1 TEXT NULL, AdmLName1 TEXT NULL, AdmEmail1 TEXT NULL, AdmFName2 TEXT NULL, AdmLName2 TEXT NULL, AdmEmail2 TEXT NULL, AdmFName3 TEXT NULL, AdmLName3 TEXT NULL, AdmEmail3 TEXT NULL, LastUpdate DATE NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "frpm" ("cdscode", "academic year", "county code", "district code", "school code", "county name", "district name", "school name", "district type", "school type", "educational option type", "nslp provision status", "charter school (y/n)", "charter school number", "charter funding type", "irc", "low grade", "high grade", "enrollment (k-12)", "free meal count (k-12)", "percent (%) eligible free (k-12)", "frpm count (k-12)", "percent (%) eligible frpm (k-12)", "enrollment (ages 5-17)", "free meal count (ages 5-17)", "percent (%) eligible free (ages 5-17)", "frpm count (ages 5-17)", "percent (%) eligible frpm (ages 5-17)", "2013-14 calpads fall 1 certification status") VALUES ('CA128', 'CA129', 'CA130', 131, 'CA132', 'CA133', 'CA134', 'CA135', 'CA136', 'CA137', 'CA138', 'CA139', 140, 'CA141', 'CA142', 143, NULL, 'CA144', 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155);
INSERT INTO "schools" ("cdscode", "ncesdist", "ncesschool", "statustype", "county", "district", "school", "street", "streetabr", "city", "zip", "state", "mailstreet", "mailstrabr", "mailcity", "mailzip", "mailstate", "phone", "ext", "website", "opendate", "closeddate", "charter", "charternum", "fundingtype", "doc", "doctype", "soc", "soctype", "edopscode", "edopsname", "eilcode", "eilname", "gsoffered", "gsserved", "virtual", "magnet", "latitude", "longitude", "admfname1", "admlname1", "admemail1", "admfname2", "admlname2", "admemail2", "admfname3", "admlname3", "admemail3", "lastupdate") VALUES ('CA128', 'CA83', 'CA84', 'CA85', 'CA86', 'CA87', NULL, 'CA88', 'CA89', NULL, 'CA90', 'CA', 'CA91', 'CA92', 'CA93', 'CA94', 'CA95', 'CA96', 'CA97', 'CA98', '1000-04-10', '1000-04-11', 101, 'CA102', 'CA103', 'CA104', 'CA105', 'CA106', 'CA107', 'CA108', 'CA109', 'CA110', 'CA111', 'CA112', 'CA113', 'CA114', 115, 116, 117, 'CA118', 'CA119', 'CA120', 'CA121', 'CA122', 'CA123', 'CA124', 'CA125', 'CA126', '1000-05-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.City, T1."Low Grade", T1."School Name" FROM frpm AS T1 INNER JOIN schools AS T2 ON T1.CDSCode = T2.CDSCode WHERE T2.State = 'CA' ORDER BY T2.Latitude ASC, T1.cdscode NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Gold Result:
(None, None, 'CA135')
*/

-- Prediction Query
SELECT "schools"."city", "schools"."school", "frpm"."low grade" FROM "schools" INNER JOIN "frpm" ON "schools"."cdscode" = "frpm"."cdscode" WHERE "schools"."state" = 'CA' ORDER BY "schools"."latitude" ASC, schools.cdscode NULLS LAST, frpm.cdscode NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, None, None)
*/