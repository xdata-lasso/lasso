-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1007, 'Gardner', 'Linda', 1008, 'Smith', 1009, 1010, 'Johnsonland');
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1011, 'Jonathan Johnson', 'decide');
INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (1007, 1011, 1012);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "gname" FROM (SELECT "LHS"."gameid" AS "gameid", "LHS"."gname" AS "gname", "LHS"."gtype" AS "gtype", "LHS"."stuid" AS "stuid", "LHS"."hours_played" AS "hours_played", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM (SELECT "LHS"."gameid" AS "gameid", "LHS"."gname" AS "gname", "LHS"."gtype" AS "gtype", "RHS"."stuid" AS "stuid", "RHS"."hours_played" AS "hours_played" FROM "video_games" AS "LHS" INNER JOIN "plays_games" AS "RHS" ON ("LHS"."gameid" = "RHS"."gameid")) AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("lname" = 'Smith' OR "fname" = 'Linda')) AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY gname, "gname" NULLS LAST;

/*
Gold Result:
('Jonathan Johnson',)
*/

-- Prediction Query
SELECT Gname FROM Plays_games AS T1 JOIN Video_games AS T2 ON T1.gameid = T2.gameid JOIN Student AS T3 ON T3.Stuid = T1.Stuid WHERE T3.Lname = 'Smith' AND T3.Fname = 'Linda';

/*
Prediction Result:
*/