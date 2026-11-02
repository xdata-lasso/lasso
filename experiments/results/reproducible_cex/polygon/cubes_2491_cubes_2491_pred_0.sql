-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (7, '7', '7', 7, '7', 7, 7, '7');
INSERT INTO "Video_Games" ("gameid", "gname", "gtype") VALUES (9, '7', '11');
INSERT INTO "Video_Games" ("gameid", "gname", "gtype") VALUES (8, '7', '11');
INSERT INTO "Plays_Games" ("stuid", "gameid", "hours_played") VALUES (7, 8, 7);
INSERT INTO "Plays_Games" ("stuid", "gameid", "hours_played") VALUES (7, 8, 7);
INSERT INTO "SportsInfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (7, '7', 7, 7, '7');
INSERT INTO "SportsInfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (7, '7', 7, 7, '7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count_distinct_gtype_ FROM video_games ORDER BY count_distinct_gtype_;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT gtype) FROM Video_games;

/*
Prediction Result:
(1,)
*/