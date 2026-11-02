-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: video_games --
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1, 'vid_3e0192', 'vid_a2d390');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (2, 'vid_3e0192', 'vid_a2d390');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (3, 'vid_3e0192', 'vid_a2d390');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (4, 'vid_3e0192', 'vid_a2d390');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (5, 'vid_3e0192', 'vid_a2d390');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (6, 'vid_3e0192', 'vid_a2d390');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (7, 'vid_3e0192', 'vid_a2d390');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (8, 'vid_3e0192', 'vid_a2d390');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (9, 'vid_3e0192', 'vid_a2d390');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count_distinct_gtype_ FROM video_games ORDER BY count_distinct_gtype_;

/*
Gold Result:
(9,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT gtype) FROM Video_games;

/*
Prediction Result:
(1,)
*/