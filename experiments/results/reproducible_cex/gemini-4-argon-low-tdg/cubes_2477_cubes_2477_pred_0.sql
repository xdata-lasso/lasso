-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (1, 'Hearthstone', 'Collectible card game');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (2, 'Gwent', 'Collectible card game');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (3, 'Artifact', 'Collectible card game');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (4, 'Magic: The Gathering', 'Collectible card game');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (5, 'Halo', 'First-person shooter');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (6, 'World of Warcraft', 'MMORPG');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "gname" FROM "video_games" WHERE ("gtype" = 'Collectible card game') ORDER BY gname, video_games.gameid NULLS LAST;

/*
Gold Result:
('Artifact',)
('Gwent',)
('Hearthstone',)
('Magic: The Gathering',)
*/

-- Prediction Query
SELECT gname FROM Video_games WHERE gtype = 'Collectible card game';

/*
Prediction Result:
('Hearthstone',)
('Gwent',)
('Artifact',)
('Magic: The Gathering',)
*/