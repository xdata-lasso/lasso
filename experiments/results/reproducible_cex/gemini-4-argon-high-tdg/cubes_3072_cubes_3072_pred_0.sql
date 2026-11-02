-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (1, 'Exact Boundary Univ', 'Austin, TX', 1883.0, 'Public', 20000.0, 'Longhorns', 'Big 12');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (2, 'Just Below Univ', 'Durham, NC', 1838.0, 'Private', 19999.9, 'Blue Devils', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (3, 'Mixed High Univ', 'Raleigh, NC', 1887.0, 'State', 25000.0, 'Wolfpack', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (4, 'Mixed Low Univ', 'Boone, NC', 1899.0, 'State', 15000.0, 'Mountaineers', 'Sun Belt');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (5, 'Small Univ One', 'Wake Forest, NC', 1834.0, 'Baptist', 12000.0, 'Demon Deacons', 'ACC');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (6, 'Small Univ Two', 'Macon, GA', 1833.0, 'Baptist', 11000.0, 'Bears', 'SoCon');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (7, 'Null Enrollment Univ', 'Unknown, NA', 1900.0, 'Public', NULL, 'Ghosts', 'None');
INSERT INTO basketball_match (Team_ID, School_ID, Team_Name, ACC_Regular_Season, ACC_Percent, ACC_Home, ACC_Road, All_Games, All_Games_Percent, All_Home, All_Road, All_Neutral) VALUES (1, 1, 'Texas', '12-4', '.750', '7-1', '5-3', '24-8', 75, '14-2', '7-4', '3-2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___, affiliation FROM (SELECT affiliation, COUNT(DISTINCT enrollment) AS n_distinct FROM (SELECT * FROM university WHERE (enrollment >= 20000.0)) GROUP BY affiliation) ORDER BY count___, affiliation NULLS LAST;

/*
Gold Result:
(1, 'Public')
(1, 'State')
*/

-- Prediction Query
SELECT COUNT(*), affiliation FROM university WHERE enrollment > 20000 GROUP BY affiliation;

/*
Prediction Result:
(1, 'State')
*/