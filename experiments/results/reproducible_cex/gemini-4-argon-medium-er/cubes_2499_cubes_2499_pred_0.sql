-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (NULL, 'Football', 10, 5, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lname", "fname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."sportname" AS "sportname", "LHS"."hoursperweek" AS "hoursperweek", "LHS"."gamesplayed" AS "gamesplayed", "LHS"."onscholarship" AS "onscholarship", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM (SELECT * FROM "sportsinfo" WHERE ("sportname" = 'Football' OR "sportname" = 'Lacrosse')) AS LHS LEFT JOIN student AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY lname, "lname" NULLS LAST, "fname" NULLS LAST;

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT T2.lname, T2.fname FROM SportsInfo AS T1 JOIN Student AS T2 ON T1.StuID = T2.StuID WHERE T1.SportName = 'Football' OR T1.SportName = 'Lacrosse';

/*
Prediction Result:
*/