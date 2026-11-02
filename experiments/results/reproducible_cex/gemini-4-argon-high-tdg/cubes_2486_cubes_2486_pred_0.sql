-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Zane', 'Alice', 19, 'F', 101, 1001, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Adams', 'Charlie', 22, 'M', 102, 1002, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Baker', 'Bob', 20, 'M', 101, 1003, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'evans', 'David', 21, 'M', 103, 1001, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'King', 'Eve', 18, 'F', 104, 1004, 'SEA');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (10, 'Chess Master', 'Strategy');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (20, 'Space Racer', 'Racing');
INSERT INTO Plays_Games (StuID, GameID, Hours_Played) VALUES (4, 10, 15);
INSERT INTO Plays_Games (StuID, GameID, Hours_Played) VALUES (5, 20, 30);
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (1, 'Basketball', 15, 10, 'Y');
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (2, 'Tennis', 8, 4, 'Y');
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (3, 'Soccer', 12, 8, 'Y');
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (4, 'Swimming', 10, 6, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."sportname" AS "sportname", "RHS"."hoursperweek" AS "hoursperweek", "RHS"."gamesplayed" AS "gamesplayed", "RHS"."onscholarship" AS "onscholarship" FROM "student" AS "LHS" INNER JOIN (SELECT * FROM "sportsinfo" WHERE ("onscholarship" = 'Y')) AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY lname, "lname" NULLS LAST;

/*
Gold Result:
('Adams',)
('Baker',)
('Zane',)
*/

-- Prediction Query
SELECT T2.Lname FROM Sportsinfo AS T1 JOIN Student AS T2 ON T1.StuID = T2.StuID WHERE T1.onscholarship = 'Y';

/*
Prediction Result:
('Zane',)
('Adams',)
('Baker',)
*/