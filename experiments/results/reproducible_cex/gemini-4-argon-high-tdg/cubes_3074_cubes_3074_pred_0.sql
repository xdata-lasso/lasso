-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (30, 'Wake Forest', 'Winston-Salem, NC', 1834.0, 'Private', 8495.0, 'Demon Deacons', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (10, 'Clemson', 'Clemson, SC', 1889.0, 'Public', 25822.0, 'Tigers', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (25, 'Duke', 'Durham, NC', 1838.0, 'Private', 15892.0, 'Blue Devils', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (15, 'Duke', 'Durham, NC', 1838.0, 'Private', 15892.0, 'Zebras', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (40, 'Clemson', 'Clemson, SC', 1889.0, 'Public', 25822.0, 'Tigers', 'ACC');
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (1, 10, 'Clemson Squad A', '10-6', '.625', '6-2', '4-4', '21-11', 65, '13-3', '5-6', '3-2');
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (2, 10, 'Clemson Squad B', '12-4', '.750', '7-1', '5-3', '25-7', 78, '15-1', '7-4', '3-2');
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (3, 25, 'Duke Varsity', '14-2', '.875', '8-0', '6-2', '29-5', 85, '16-0', '8-3', '5-2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school, nickname FROM university ORDER BY school, university.school_id NULLS LAST;

/*
Gold Result:
('Clemson', 'Tigers')
('Clemson', 'Tigers')
('Duke', 'Zebras')
('Duke', 'Blue Devils')
('Wake Forest', 'Demon Deacons')
*/

-- Prediction Query
SELECT school, nickname FROM university ORDER BY founded, university.school_id NULLS LAST;

/*
Prediction Result:
('Wake Forest', 'Demon Deacons')
('Duke', 'Zebras')
('Duke', 'Blue Devils')
('Clemson', 'Tigers')
('Clemson', 'Tigers')
*/