-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1084, 'Wilkerson', 'Dawn', 1085, 'character', 1086, 1087, 'Donaldside');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1094, 'Wilkerson', 'Dawn', 1085, 'character', 1086, 1087, 'Donaldside');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1095, 'Burgess', 'Ross', 1096, 'past', 1097, 1098, 'Coxberg');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1105, 'Burgess', 'Ross', 1096, 'past', 1097, 1098, 'Coxberg');
INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1084, 'Football', 1089, 1091, 'nothing');
INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1084, 'Lacrosse', 1096.0, 1100.0, 'everyone');
INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1095, 'Football', 1100, 1102, 'Mr');
INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1095, 'Lacrosse', 1107.0, 1111.0, 'minute');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lname", "fname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."sportname" AS "sportname", "LHS"."hoursperweek" AS "hoursperweek", "LHS"."gamesplayed" AS "gamesplayed", "LHS"."onscholarship" AS "onscholarship", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM (SELECT * FROM "sportsinfo" WHERE ("sportname" = 'Football' OR "sportname" = 'Lacrosse')) AS LHS LEFT JOIN student AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY lname, "lname" NULLS LAST, "fname" NULLS LAST;

/*
Gold Result:
('Burgess', 'Ross')
('Burgess', 'Ross')
('Wilkerson', 'Dawn')
('Wilkerson', 'Dawn')
*/

-- Prediction Query
SELECT T2.lname, T2.fname FROM SportsInfo AS T1 JOIN Student AS T2 ON T1.StuID = T2.StuID WHERE T1.SportName = 'Football' OR T1.SportName = 'Lacrosse';

/*
Prediction Result:
('Wilkerson', 'Dawn')
('Wilkerson', 'Dawn')
('Burgess', 'Ross')
('Burgess', 'Ross')
*/