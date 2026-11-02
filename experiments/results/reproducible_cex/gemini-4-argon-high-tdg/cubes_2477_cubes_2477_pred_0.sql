-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 100, 10, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Jane', 21, 'F', 100, 11, 'LAX');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (1, 'Zeta Card', 'Collectible card game');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (2, 'Alpha Card', 'Collectible card game');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (3, 'Beta RPG', 'Role-playing game');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (4, 'Alpha Card', 'Collectible card game');
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (1, 1, 15);
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (2, 1, 25);
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (1, 3, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "gname" FROM "video_games" WHERE ("gtype" = 'Collectible card game') ORDER BY gname, video_games.gameid NULLS LAST;

/*
Gold Result:
('Alpha Card',)
('Alpha Card',)
('Zeta Card',)
*/

-- Prediction Query
SELECT gname FROM Video_games WHERE gtype = 'Collectible card game';

/*
Prediction Result:
('Zeta Card',)
('Alpha Card',)
('Alpha Card',)
*/