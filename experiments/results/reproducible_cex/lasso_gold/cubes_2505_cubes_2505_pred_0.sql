-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1013, 'Call of Destiny', 'rate');
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1014, 'Call of Destiny', 'offer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "gtype" FROM "video_games" WHERE ("gname" = 'Call of Destiny') ORDER BY gtype, video_games.gameid NULLS LAST;

/*
Gold Result:
('offer',)
('rate',)
*/

-- Prediction Query
SELECT gtype FROM Video_games WHERE gname = 'Call of Destiny';

/*
Prediction Result:
('rate',)
('offer',)
*/