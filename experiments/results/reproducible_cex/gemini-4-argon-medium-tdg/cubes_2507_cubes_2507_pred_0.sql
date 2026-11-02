-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (10, 'Smith', 'John', 20, 'M', 100, 1, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (20, 'Doe', 'Jane', 21, 'F', 100, 1, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (30, 'Brown', 'Bob', 22, 'M', 200, 2, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (40, 'White', 'Alex', 19, NULL, 200, 2, 'CHI');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (10, 'Football', 10, 5, 'Y');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (20, 'Football', 8, 4, 'N');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (30, 'Basketball', 12, 10, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "stuid" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."sportname" AS "sportname", "RHS"."hoursperweek" AS "hoursperweek", "RHS"."gamesplayed" AS "gamesplayed", "RHS"."onscholarship" AS "onscholarship" FROM (SELECT * FROM "student" WHERE ("sex" = 'M')) AS "LHS" LEFT JOIN (SELECT * FROM "sportsinfo" WHERE ("sportname" = 'Football')) AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY stuid, "stuid" NULLS LAST;

/*
Gold Result:
(10,)
(30,)
*/

-- Prediction Query
SELECT StuID FROM Student WHERE sex = 'M' EXCEPT SELECT StuID FROM Sportsinfo WHERE sportname = 'Football';

/*
Prediction Result:
(30,)
*/