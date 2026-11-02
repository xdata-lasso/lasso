-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering ('Y' vs 'N', 'y', NULL), duplicate StuIDs (SELECT vs SELECT DISTINCT), and basic ordering.
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 101, 1001, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Jane', 21, 'F', 102, 1002, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Brown', 'Bob', 22, 'M', 103, 1003, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'White', 'Alice', 19, 'F', 104, 1004, 'BOS');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (2, 'Basketball', 10, 5, 'Y');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (1, 'Soccer', 12, 8, 'Y');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (1, 'Tennis', 8, 4, 'Y');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (3, 'Baseball', 15, 10, 'N');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (3, 'Swimming', 5, 2, 'y');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (3, 'Golf', 6, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "stuid" FROM "sportsinfo" WHERE ("onscholarship" = 'Y') ORDER BY stuid, sportsinfo.sportname NULLS LAST, sportsinfo.hoursperweek NULLS LAST, sportsinfo.gamesplayed NULLS LAST, sportsinfo.onscholarship NULLS LAST;

/*
Gold Result:
(1,)
(1,)
(2,)
*/

-- Prediction Query
SELECT StuID FROM Sportsinfo WHERE onscholarship = 'Y';

/*
Prediction Result:
(2,)
(1,)
(1,)
*/