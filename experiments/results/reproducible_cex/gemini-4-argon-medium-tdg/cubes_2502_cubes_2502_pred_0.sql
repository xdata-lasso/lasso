-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (1, 'World of Warcraft', 'Massively multiplayer online game');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (2, 'Final Fantasy XIV', 'Massively multiplayer online game');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (3, 'Guild Wars 2', 'Massively multiplayer online game');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (4, 'Call of Duty', 'First-person shooter');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (5, 'Halo', 'First-person shooter');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (6, 'Civilization VI', 'Turn-based strategy');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (7, 'Mystery Game', NULL);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (101, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (101, 1, 100);
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (101, 4, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count___" FROM (SELECT "gtype", COUNT(DISTINCT "gtype") AS "n_distinct" FROM (SELECT * FROM "video_games" WHERE ("gtype" = 'Massively multiplayer online game')) GROUP BY gtype) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Video_games WHERE gtype = 'Massively multiplayer online game';

/*
Prediction Result:
(3,)
*/