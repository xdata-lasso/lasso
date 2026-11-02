-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (8, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (7, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Video_Games" ("gameid", "gname", "gtype") VALUES (10, NULL, NULL);
INSERT INTO "Video_Games" ("gameid", "gname", "gtype") VALUES (9, NULL, NULL);
INSERT INTO "Plays_Games" ("stuid", "gameid", "hours_played") VALUES (7, NULL, NULL);
INSERT INTO "Plays_Games" ("stuid", "gameid", "hours_played") VALUES (7, NULL, NULL);
INSERT INTO "SportsInfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (8, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gtype FROM video_games ORDER BY gtype, video_games.gameid NULLS LAST;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT gtype FROM Video_games;

/*
Prediction Result:
(None,)
*/