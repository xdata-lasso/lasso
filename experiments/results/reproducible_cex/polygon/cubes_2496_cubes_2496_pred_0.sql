-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (10, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (9, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Video_Games" ("gameid", "gname", "gtype") VALUES (11, NULL, NULL);
INSERT INTO "Plays_Games" ("stuid", "gameid", "hours_played") VALUES (9, 11, NULL);
INSERT INTO "SportsInfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (NULL, 'Y15', NULL, NULL, NULL);
INSERT INTO "SportsInfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (NULL, 'Football14', NULL, NULL, NULL);
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