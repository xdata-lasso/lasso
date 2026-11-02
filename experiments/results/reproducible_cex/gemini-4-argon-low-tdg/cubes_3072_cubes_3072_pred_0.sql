-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary condition (enrollment = 20000.0 vs < 20000.0 vs > 20000.0),
-- COUNT(DISTINCT enrollment) vs COUNT(*), and ordering by count___ then affiliation.
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (1, 'Uni A', 'Loc A', 1900.0, 'Public', 19999.9, 'Nick A', 'Conf A');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (2, 'Uni B', 'Loc B', 1900.0, 'Public', 20000.0, 'Nick B', 'Conf A');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (3, 'Uni C', 'Loc C', 1900.0, 'Public', 20000.0, 'Nick C', 'Conf A');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (4, 'Uni D', 'Loc D', 1900.0, 'Public', 25000.0, 'Nick D', 'Conf A');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (5, 'Uni E', 'Loc E', 1900.0, 'Private', 22000.0, 'Nick E', 'Conf B');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (6, 'Uni F', 'Loc F', 1900.0, 'Private', 22000.0, 'Nick F', 'Conf B');
INSERT INTO university (School_ID, School, Location, Founded, Affiliation, Enrollment, Nickname, Primary_conference) VALUES (7, 'Uni G', 'Loc G', 1900.0, 'Private', 22000.0, 'Nick G', 'Conf B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___, affiliation FROM (SELECT affiliation, COUNT(DISTINCT enrollment) AS n_distinct FROM (SELECT * FROM university WHERE (enrollment >= 20000.0)) GROUP BY affiliation) ORDER BY count___, affiliation NULLS LAST;

/*
Gold Result:
(1, 'Private')
(2, 'Public')
*/

-- Prediction Query
SELECT COUNT(*), affiliation FROM university WHERE enrollment > 20000 GROUP BY affiliation;

/*
Prediction Result:
(3, 'Private')
(1, 'Public')
*/