-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Student" ("StuID", "LName") VALUES (1, 'B');
INSERT INTO "Student" ("StuID", "LName") VALUES (2, 'A');
INSERT INTO "Student" ("StuID", "LName") VALUES (3, NULL);
INSERT INTO "SportsInfo" ("StuID", "OnScholarship") VALUES (1, 'Y');
INSERT INTO "SportsInfo" ("StuID", "OnScholarship") VALUES (2, 'Y');
INSERT INTO "SportsInfo" ("StuID", "OnScholarship") VALUES (3, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."sportname" AS "sportname", "RHS"."hoursperweek" AS "hoursperweek", "RHS"."gamesplayed" AS "gamesplayed", "RHS"."onscholarship" AS "onscholarship" FROM "student" AS "LHS" INNER JOIN (SELECT * FROM "sportsinfo" WHERE ("onscholarship" = 'Y')) AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY lname, "lname" NULLS LAST;

/*
Gold Result:
(None,)
('A',)
('B',)
*/

-- Prediction Query
SELECT T2.Lname FROM Sportsinfo AS T1 JOIN Student AS T2 ON T1.StuID = T2.StuID WHERE T1.onscholarship = 'Y';

/*
Prediction Result:
('B',)
('A',)
(None,)
*/