-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1008, 'James Howard', 'value');
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1009, 'Dennis Williams', 'value');
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1010, 'Calvin Nielsen', 'value');
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1011, 'Edward Fuller', 'value');
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1012, 'Laura Bush', 'hospital');
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1013, 'Darren Roberts', 'hospital');
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1014, 'David Garcia', 'hospital');
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1015, 'Mark Diaz', 'hospital');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gtype FROM (SELECT * FROM (SELECT * FROM (SELECT gameid, gtype, COUNT(*) AS n FROM video_games GROUP BY gameid, gtype) ORDER BY gtype DESC) LIMIT 1);

/*
Gold Result:
('value',)
*/

-- Prediction Query
SELECT gtype FROM Video_games GROUP BY gtype ORDER BY COUNT(*) DESC, gtype NULLS LAST LIMIT 1;

/*
Prediction Result:
('hospital',)
*/