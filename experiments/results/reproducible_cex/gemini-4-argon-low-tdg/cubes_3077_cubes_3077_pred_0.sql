-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (1, 'Uni A', 'Loc A', 1900.0, 'Public', 15000.0, 'Bears', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (2, 'Uni B', 'Loc B', 1920.0, 'Private', 8000.0, 'Tigers', 'SEC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (3, 'Uni C', 'Loc C', 1850.0, 'Public', 25000.0, 'Eagles', 'Big Ten');
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (10, 2, 'Tigers Team', '10-2', '.833', '6-0', '4-2', '20-5', 80, '12-1', '8-4', '0-0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT enrollment, primary_conference FROM (SELECT * FROM (SELECT * FROM university ORDER BY affiliation DESC, university.school_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(15000.0, 'ACC')
*/

-- Prediction Query
SELECT enrollment, primary_conference FROM university ORDER BY founded, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(25000.0, 'Big Ten')
*/