-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 100, 10, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Brown', 'Linda', 21, 'F', 200, 20, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Smith', 'Linda', 22, 'F', 300, 30, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Linda', 'Smith', 19, 'M', 100, 10, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Jones', 'Bob', 23, 'M', 400, 40, 'SFO');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (10, 'Halo', 'Shooter');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (20, 'Zelda', 'Adventure');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (30, 'Doom', 'Action');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (40, 'FIFA', 'Sports');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (50, 'Sims', 'Simulation');
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (1, 10, 15);
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (2, 20, 25);
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (3, 30, 35);
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (4, 40, 45);
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (5, 50, 55);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "gname" FROM (SELECT "LHS"."gameid" AS "gameid", "LHS"."gname" AS "gname", "LHS"."gtype" AS "gtype", "LHS"."stuid" AS "stuid", "LHS"."hours_played" AS "hours_played", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM (SELECT "LHS"."gameid" AS "gameid", "LHS"."gname" AS "gname", "LHS"."gtype" AS "gtype", "RHS"."stuid" AS "stuid", "RHS"."hours_played" AS "hours_played" FROM "video_games" AS "LHS" INNER JOIN "plays_games" AS "RHS" ON ("LHS"."gameid" = "RHS"."gameid")) AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("lname" = 'Smith' OR "fname" = 'Linda')) AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY gname, "gname" NULLS LAST;

/*
Gold Result:
('Doom',)
('Halo',)
('Zelda',)
*/

-- Prediction Query
SELECT Gname FROM Plays_games AS T1 JOIN Video_games AS T2 ON T1.gameid = T2.gameid JOIN Student AS T3 ON T3.Stuid = T1.Stuid WHERE T3.Lname = 'Smith' AND T3.Fname = 'Linda';

/*
Prediction Result:
('Doom',)
*/