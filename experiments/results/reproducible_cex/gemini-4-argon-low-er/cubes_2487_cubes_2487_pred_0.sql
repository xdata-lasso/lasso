-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (NULL, 'Soccer', 5, 10, 'Y');
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (NULL, NULL, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT stuid FROM (SELECT LHS.stuid AS stuid, LHS.sportname AS sportname, LHS.hoursperweek AS hoursperweek, LHS.gamesplayed AS gamesplayed, LHS.onscholarship AS onscholarship, RHS.gameid AS gameid, RHS.hours_played AS hours_played FROM sportsinfo AS LHS INNER JOIN plays_games AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY stuid;

/*
Gold Result:
*/

-- Prediction Query
SELECT StuID FROM Sportsinfo INTERSECT SELECT StuID FROM Plays_games;

/*
Prediction Result:
(None,)
*/