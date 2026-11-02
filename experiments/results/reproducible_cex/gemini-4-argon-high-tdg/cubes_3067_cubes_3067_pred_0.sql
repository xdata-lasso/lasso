-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (1, 'State Univ A', 'City A', 1900.0, 'Public', 10000.0, 'Eagles', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (2, 'State Univ B', 'City B', 1910.0, 'Public', 10000.0, 'Hawks', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (3, 'Tech Institute', 'City C', 1950.0, 'Private', 2000.0, 'Tigers', 'Big Ten');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (4, 'Liberal Arts Coll', 'City D', 1880.0, 'Private', 3000.0, 'Bears', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (5, 'Science Academy', 'City E', 1920.0, 'Private', 4000.0, 'Lions', 'SEC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (6, 'Wesleyan Univ', 'City F', 1850.0, 'Methodist', 15000.0, 'Owls', 'Pac-12');
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (101, 1, 'Eagles', '10-6', '.625', '6-2', '4-4', '20-10', 67, '12-3', '6-5', '2-2');
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (102, 3, 'Tigers A', '8-8', '.500', '5-3', '3-5', '15-15', 50, '10-5', '4-8', '1-2');
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (103, 3, 'Tigers B', '12-4', '.750', '7-1', '5-3', '24-6', 80, '14-1', '8-4', '2-1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumenrollment AS sum_enrollment_, affiliation FROM (SELECT affiliation, SUM(enrollment) AS sumenrollment FROM university GROUP BY affiliation) ORDER BY sum_enrollment_, affiliation NULLS LAST;

/*
Gold Result:
(9000.0, 'Private')
(15000.0, 'Methodist')
(20000.0, 'Public')
*/

-- Prediction Query
SELECT SUM(enrollment), affiliation FROM university GROUP BY affiliation;

/*
Prediction Result:
(15000.0, 'Methodist')
(9000.0, 'Private')
(20000.0, 'Public')
*/