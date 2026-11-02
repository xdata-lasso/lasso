-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1102, 'Zimmerman', 'Brian', 1103, 'author', 1104, 1105, 'Port Markhaven');
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1106, 'Michael Lewis', 'cause');
INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (NULL, 1106, 1107);
INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (NULL, 'Sonya Johnston', 1108, 1109, 'eight');
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