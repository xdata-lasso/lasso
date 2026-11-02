-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1002, 'Noah Rhodes', 'wait');
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1003, 'Noah Rhodes', 'wait');
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1004, 'Noah Rhodes', 'wait');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count___" FROM (SELECT "gtype", COUNT(DISTINCT "gtype") AS "n_distinct" FROM (SELECT * FROM "video_games" WHERE ("gtype" = 'Massively multiplayer online game')) GROUP BY gtype) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Video_games WHERE gtype = 'Massively multiplayer online game';

/*
Prediction Result:
(0,)
*/