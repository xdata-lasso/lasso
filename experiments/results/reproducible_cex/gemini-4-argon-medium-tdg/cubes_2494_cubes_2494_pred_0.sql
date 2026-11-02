-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 600, 1001, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Jones', 'Linda', 21, 'F', 600, 1002, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Smith', 'Linda', 22, 'F', 500, 1001, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Brown', 'Bob', 19, 'M', 400, 1003, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Linda', 'Smith', 23, 'F', 600, 1004, 'SEA');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (10, 'Zelda', 'Adventure');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (20, 'Mario', 'Platformer');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (30, 'Halo', 'Shooter');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (40, 'Tetris', 'Puzzle');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (50, 'Doom', 'Shooter');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (60, 'UnplayedGame', 'RPG');
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (1, 10, 50);
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (2, 20, 30);
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (3, 30, 100);
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (4, 40, 20);
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (5, 50, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "gname" FROM (SELECT "LHS"."gameid" AS "gameid", "LHS"."gname" AS "gname", "LHS"."gtype" AS "gtype", "LHS"."stuid" AS "stuid", "LHS"."hours_played" AS "hours_played", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM (SELECT "LHS"."gameid" AS "gameid", "LHS"."gname" AS "gname", "LHS"."gtype" AS "gtype", "RHS"."stuid" AS "stuid", "RHS"."hours_played" AS "hours_played" FROM "video_games" AS "LHS" INNER JOIN "plays_games" AS "RHS" ON ("LHS"."gameid" = "RHS"."gameid")) AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("lname" = 'Smith' OR "fname" = 'Linda')) AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY gname, "gname" NULLS LAST;

/*
Gold Result:
('Halo',)
('Mario',)
('Zelda',)
*/

-- Prediction Query
SELECT Gname FROM Plays_games AS T1 JOIN Video_games AS T2 ON T1.gameid = T2.gameid JOIN Student AS T3 ON T3.Stuid = T1.Stuid WHERE T3.Lname = 'Smith' AND T3.Fname = 'Linda';

/*
Prediction Result:
('Halo',)
*/