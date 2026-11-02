-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (20, 'Zeta University', 'Zeta City', 2000.0, 'Private', 50000.0, 'Zebras', 'SEC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (15, 'Midway College', 'Midtown', 1950.0, 'Public', 25000.0, 'Mustangs', 'Big Ten');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (10, 'Alpha Institute', 'Alpha Town', 1850.0, 'Catholic', 5000.0, 'Aces', 'AAC');
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (1, 20, 'Zeta', '10-6', '.625', '6-2', '4-4', '20-10', 67, '12-2', '6-6', '2-2');
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (2, 10, 'Alpha', '8-8', '.500', '5-3', '3-5', '15-15', 50, '10-5', '4-8', '1-2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT enrollment, primary_conference FROM (SELECT * FROM (SELECT * FROM university ORDER BY affiliation DESC, university.school_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(25000.0, 'Big Ten')
*/

-- Prediction Query
SELECT enrollment, primary_conference FROM university ORDER BY founded, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(5000.0, 'AAC')
*/