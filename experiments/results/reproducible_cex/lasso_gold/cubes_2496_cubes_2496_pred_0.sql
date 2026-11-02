-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1043, 'Galloway', 'Melissa', 1044, 'trial', 1045, 1046, 'South Joshuastad');
INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1043, 'Football_z', 1047, 1048, 'Y');
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