-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests negative and zero GameIDs, and tests when the minimum GameID has a NULL GType
-- (catches mutants adding WHERE GType IS NOT NULL or using COUNT(GType) > 0 filters).
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (-5, 'NegativeIDGame', NULL);
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (0, 'ZeroIDGame', 'RPG');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (5, 'PositiveIDGame', 'Simulation');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gtype FROM (SELECT * FROM (SELECT * FROM (SELECT gameid, gtype, COUNT(*) AS n FROM video_games GROUP BY gameid, gtype) ORDER BY gameid) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT gtype FROM Video_games GROUP BY gtype ORDER BY COUNT(*), gtype NULLS LAST LIMIT 1;

/*
Prediction Result:
('RPG',)
*/