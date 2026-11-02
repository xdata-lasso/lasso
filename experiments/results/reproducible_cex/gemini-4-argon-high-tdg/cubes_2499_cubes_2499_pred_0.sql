-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (10, 'Zimmer', 'Alice', 20, 'F', 100, 1, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (20, 'Adams', 'Bob', 21, 'M', 200, 2, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (30, 'Clark', 'Charlie', 19, 'M', 100, 1, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (40, 'Davis', 'Diana', 22, 'F', 300, 3, 'BOS');
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (10, 'Football', 15, 10, 'Y');
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (20, 'Lacrosse', 12, 8, 'N');
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (30, 'Basketball', 10, 14, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lname", "fname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."sportname" AS "sportname", "LHS"."hoursperweek" AS "hoursperweek", "LHS"."gamesplayed" AS "gamesplayed", "LHS"."onscholarship" AS "onscholarship", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM (SELECT * FROM "sportsinfo" WHERE ("sportname" = 'Football' OR "sportname" = 'Lacrosse')) AS LHS LEFT JOIN student AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY lname, "lname" NULLS LAST, "fname" NULLS LAST;

/*
Gold Result:
('Adams', 'Bob')
('Zimmer', 'Alice')
*/

-- Prediction Query
SELECT T2.lname, T2.fname FROM SportsInfo AS T1 JOIN Student AS T2 ON T1.StuID = T2.StuID WHERE T1.SportName = 'Football' OR T1.SportName = 'Lacrosse';

/*
Prediction Result:
('Zimmer', 'Alice')
('Adams', 'Bob')
*/