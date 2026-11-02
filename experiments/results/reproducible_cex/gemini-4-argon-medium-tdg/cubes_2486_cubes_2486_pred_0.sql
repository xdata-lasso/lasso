-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2: Tests duplicate preservation (SELECT vs SELECT DISTINCT) via both multiple scholarships for one student and identical LNames across different students
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (10, 'Smith', 'John', 20, 'M', 100, 200, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (20, 'Smith', 'Jane', 22, 'F', 100, 200, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (30, 'Aaron', 'Zack', 19, 'M', 101, 201, 'CHI');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (10, 'Football', 20, 10, 'Y');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (10, 'Track', 10, 5, 'Y');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (10, 'Baseball', 5, 2, 'N');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (20, 'Volleyball', 12, 8, 'Y');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (30, 'Hockey', 15, 12, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."sportname" AS "sportname", "RHS"."hoursperweek" AS "hoursperweek", "RHS"."gamesplayed" AS "gamesplayed", "RHS"."onscholarship" AS "onscholarship" FROM "student" AS "LHS" INNER JOIN (SELECT * FROM "sportsinfo" WHERE ("onscholarship" = 'Y')) AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY lname, "lname" NULLS LAST;

/*
Gold Result:
('Aaron',)
('Smith',)
('Smith',)
('Smith',)
*/

-- Prediction Query
SELECT T2.Lname FROM Sportsinfo AS T1 JOIN Student AS T2 ON T1.StuID = T2.StuID WHERE T1.onscholarship = 'Y';

/*
Prediction Result:
('Smith',)
('Smith',)
('Smith',)
('Aaron',)
*/