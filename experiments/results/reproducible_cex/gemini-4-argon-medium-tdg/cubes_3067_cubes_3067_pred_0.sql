-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (1, 'Uni A', 'Loc A', 1900.0, 'Public', 1000.0, 'Eagles', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (2, 'Uni B', 'Loc B', 1920.0, 'Public', 1000.0, 'Tigers', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (3, 'Uni C', 'Loc C', 1950.0, 'Private', 1500.0, 'Bears', 'Big Ten');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (4, 'Uni D', 'Loc D', 1980.0, 'Private', 2500.0, 'Lions', 'SEC');
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (1, 1, 'Team A1', '10-6', '.625', '6-2', '4-4', '20-10', 67, '12-3', '6-5', '2-2');
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (2, 1, 'Team A2', '8-8', '.500', '5-3', '3-5', '15-15', 50, '10-5', '4-8', '1-2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumenrollment AS sum_enrollment_, affiliation FROM (SELECT affiliation, SUM(enrollment) AS sumenrollment FROM university GROUP BY affiliation) ORDER BY sum_enrollment_, affiliation NULLS LAST;

/*
Gold Result:
(2000.0, 'Public')
(4000.0, 'Private')
*/

-- Prediction Query
SELECT SUM(enrollment), affiliation FROM university GROUP BY affiliation;

/*
Prediction Result:
(4000.0, 'Private')
(2000.0, 'Public')
*/