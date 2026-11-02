-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: video_games --
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1, 'vid_3e0192', 'vid_6daa6e');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (-2147483647, 'vid_3e0192', 'vid_6daa6e');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (-2147483646, 'vid_3e0192', 'q_2_63a1f7');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (-2147483645, 'vid_3e0192', 'q_2_63a1f7');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (4, 'vid_3e0192', 'vid_a2d390');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (5, 'vid_3e0192', 'vid_a2d390');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (-2147483649, 'vid_3e0192', 'vid_a2d390');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (-2147483648, 'vid_3e0192', 'vid_a2d390');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gtype FROM (SELECT * FROM (SELECT * FROM (SELECT gameid, gtype, COUNT(*) AS n FROM video_games GROUP BY gameid, gtype) ORDER BY gameid) LIMIT 1);

/*
Gold Result:
('vid_a2d390',)
*/

-- Prediction Query
SELECT gtype FROM Video_games GROUP BY gtype ORDER BY COUNT(*), gtype NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_2_63a1f7',)
*/