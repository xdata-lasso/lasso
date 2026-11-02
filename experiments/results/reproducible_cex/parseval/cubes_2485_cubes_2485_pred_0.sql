-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483648, 'stu_5554fd', 'stu_ebb0d7', -55602865, 'f', -59984348, -664303813, 'db6');

-- Inserting into table: video_games --
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1, 't2__421fe9', 'vid_a2d390');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (2, 't2__421fe9', 'vid_a2d390');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (-2147483647, 't2__421fe9', 'vid_a2d390');

INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (5, 't2__421fe9', 'vid_a2d390');

-- Inserting into table: plays_games --
INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, 21652);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 2, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 2, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 2, 21652);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 2, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 2, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 2, 21652);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 2, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 2, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 2, 21652);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 2, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 2, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 2, 21652);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 2, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 2, -12470);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 2, 32285);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, -12470);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, 32285);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, 21652);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, 21652);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, 0);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, 21652);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, NULL);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, NULL);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, NULL);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, NULL);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, NULL);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, NULL);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, NULL);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, NULL);

INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (-2147483648, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gname FROM (SELECT gname, SUM(hours_played) AS sumhours_played FROM (SELECT * FROM (SELECT LHS.gameid AS gameid, LHS.gname AS gname, LHS.gtype AS gtype, RHS.stuid AS stuid, RHS.hours_played AS hours_played FROM video_games AS LHS INNER JOIN plays_games AS RHS ON (LHS.gameid = RHS.gameid)) WHERE (hours_played >= 1000)) GROUP BY gname) ORDER BY gname;

/*
Gold Result:
('t2__421fe9',)
*/

-- Prediction Query
SELECT gname FROM Plays_games AS T1 JOIN Video_games AS T2 ON T1.gameid = T2.gameid GROUP BY T1.gameid HAVING SUM(hours_played) >= 1000;

/*
Prediction Result:
('t2__421fe9',)
('t2__421fe9',)
*/