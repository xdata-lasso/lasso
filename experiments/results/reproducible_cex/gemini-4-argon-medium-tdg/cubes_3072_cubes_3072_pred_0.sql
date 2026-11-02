-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (1, 'Uni A', 'Loc 1', 1900.0, 'Public', 20000.0, 'Nick A', 'Conf 1');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (2, 'Uni B', 'Loc 2', 1910.0, 'Public', 20000.0, 'Nick B', 'Conf 1');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (3, 'Uni C', 'Loc 3', 1920.0, 'Public', 19999.9, 'Nick C', 'Conf 1');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (4, 'Uni D', 'Loc 4', 1930.0, 'Private', 25000.0, 'Nick D', 'Conf 2');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (5, 'Uni E', 'Loc 5', 1940.0, 'Private', 30000.0, 'Nick E', 'Conf 2');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (6, 'Uni F', 'Loc 6', 1950.0, 'Religious', 15000.0, 'Nick F', 'Conf 3');
INSERT INTO "basketball_match" ("Team_ID", "School_ID", "Team_Name", "ACC_Regular_Season", "ACC_Percent", "ACC_Home", "ACC_Road", "All_Games", "All_Games_Percent", "All_Home", "All_Road", "All_Neutral") VALUES (1, 1, 'Team A1', '10-2', '0.833', '6-0', '4-2', '20-5', 80, '12-1', '6-3', '2-1');
INSERT INTO "basketball_match" ("Team_ID", "School_ID", "Team_Name", "ACC_Regular_Season", "ACC_Percent", "ACC_Home", "ACC_Road", "All_Games", "All_Games_Percent", "All_Home", "All_Road", "All_Neutral") VALUES (2, 1, 'Team A2', '8-4', '0.667', '5-1', '3-3', '18-7', 72, '10-2', '6-4', '2-1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___, affiliation FROM (SELECT affiliation, COUNT(DISTINCT enrollment) AS n_distinct FROM (SELECT * FROM university WHERE (enrollment >= 20000.0)) GROUP BY affiliation) ORDER BY count___, affiliation NULLS LAST;

/*
Gold Result:
(1, 'Public')
(2, 'Private')
*/

-- Prediction Query
SELECT COUNT(*), affiliation FROM university WHERE enrollment > 20000 GROUP BY affiliation;

/*
Prediction Result:
(2, 'Private')
*/