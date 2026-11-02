-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty result set for target group ('Football', 'Y') when other groups exist. Distinguishes GROUP BY + WHERE from ungrouped WHERE SELECT SUM(...) which would return a single row with NULL instead of 0 rows.
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Adams', 'Tom', 20, 'M', 100, 10, 'SFO');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (1, 'Football', 10, 15, 'N');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (1, 'Basketball', 12, 20, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "sumgamesplayed" AS "sum_gamesplayed_" FROM (SELECT "onscholarship", "sportname", SUM("gamesplayed") AS "sumgamesplayed" FROM "sportsinfo" GROUP BY "onscholarship", "sportname") WHERE ("sportname" = 'Football' AND "onscholarship" = 'Y') ORDER BY sum_gamesplayed_;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(gamesplayed) FROM Sportsinfo WHERE sportname = 'Football' AND onscholarship = 'Y';

/*
Prediction Result:
(None,)
*/