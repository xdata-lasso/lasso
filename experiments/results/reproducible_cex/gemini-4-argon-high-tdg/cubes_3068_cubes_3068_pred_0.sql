-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (1, 'Duke University', 'Durham, NC', 1838.0, 'Private/Methodist', 15000.0, 'Blue Devils', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (2, 'Wake Forest University', 'Winston-Salem, NC', 1834.0, 'Private', 8000.0, 'Demon Deacons', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (3, 'UNC Chapel Hill', 'Chapel Hill, NC', 1789.0, 'Public', 30000.0, 'Tar Heels', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (4, 'Boston College', 'Chestnut Hill, MA', 1838.0, 'Private/Jesuit', 14000.0, 'Eagles', 'ACC');
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (101, 1, 'Duke A', '15-3', '.833', '8-1', '7-2', '28-6', 82, '15-1', '8-3', '5-2');
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (102, 1, 'Duke B', '12-6', '.667', '7-2', '5-4', '22-10', 69, '13-3', '6-5', '3-2');
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (103, 3, 'North Carolina', '14-4', '.778', '8-1', '6-3', '26-8', 76, '14-2', '7-4', '5-2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "founded" FROM "university" WHERE ("affiliation" <> 'Public') ORDER BY founded, university.school_id NULLS LAST;

/*
Gold Result:
(1834.0,)
(1838.0,)
(1838.0,)
*/

-- Prediction Query
SELECT founded FROM university WHERE affiliation <> 'Public' ORDER BY founded DESC, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1838.0,)
*/