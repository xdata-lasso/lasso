-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC), duplicates (DISTINCT vs ALL), NULL handling in GType, and column selection (GType vs GName).
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (2, 'Zelda', 'Action');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (1, 'Mario', 'Action');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (3, 'Halo', 'RPG');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (4, 'Tetris', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gtype FROM video_games ORDER BY gtype, video_games.gameid NULLS LAST;

/*
Gold Result:
(None,)
('Action',)
('Action',)
('RPG',)
*/

-- Prediction Query
SELECT DISTINCT gtype FROM Video_games;

/*
Prediction Result:
('Action',)
('RPG',)
(None,)
*/