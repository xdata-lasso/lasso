-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO university (School_ID, Affiliation, Founded, Enrollment, Primary_conference) VALUES (1, 'Public', 1900.0, 10000.0, 'ConfA');
INSERT INTO university (School_ID, Affiliation, Founded, Enrollment, Primary_conference) VALUES (2, 'Private', 1800.0, 20000.0, 'ConfB');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT enrollment, primary_conference FROM (SELECT * FROM (SELECT * FROM university ORDER BY affiliation DESC, university.school_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(10000.0, 'ConfA')
*/

-- Prediction Query
SELECT enrollment, primary_conference FROM university ORDER BY founded, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(20000.0, 'ConfB')
*/