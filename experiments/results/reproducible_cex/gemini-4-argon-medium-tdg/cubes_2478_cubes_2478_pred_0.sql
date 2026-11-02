-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests DISTINCT vs ALL (duplicate matching rows in SportsInfo for the same student),
-- INNER JOIN vs LEFT/RIGHT OUTER JOIN (students without sports, and NULL StuID in SportsInfo),
-- and ensures queries joining Plays_Games or filtering on OnScholarship/HoursPerWeek fail.
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Taylor', 'mia', 18, 'F', 100, 10, 'SFO');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Jordan', 'Zoe', 25, 'F', 200, 20, 'DAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'lee', 'Anna', 19, 'F', 100, 10, 'HOU');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (2, 'Football', 10, 5, 'Y');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (2, 'Football', 20, 10, 'N');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (1, 'Football', 0, 0, NULL);
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (NULL, 'Football', 15, 8, 'Y');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (10, 'FIFA', 'Sports');
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (3, 10, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "stuid" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."sportname" AS "sportname", "RHS"."hoursperweek" AS "hoursperweek", "RHS"."gamesplayed" AS "gamesplayed", "RHS"."onscholarship" AS "onscholarship" FROM "student" AS "LHS" INNER JOIN "sportsinfo" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) WHERE ("sex" = 'F' AND "sportname" = 'Football') ORDER BY stuid, "stuid" NULLS LAST;

/*
Gold Result:
(1,)
(2,)
(2,)
*/

-- Prediction Query
SELECT StuID FROM Student WHERE sex = 'F' INTERSECT SELECT StuID FROM Sportsinfo WHERE sportname = 'Football';

/*
Prediction Result:
(1,)
(2,)
*/