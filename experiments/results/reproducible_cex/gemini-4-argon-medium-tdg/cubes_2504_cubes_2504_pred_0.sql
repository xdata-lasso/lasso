-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (101, 'Smith', 'John', 20, 'M', 600, 1121, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (102, 'Doe', 'Jane', 22, 'F', 600, 1121, 'LAX');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (5, 'Zelda', 'RPG');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (2, 'Alpha', 'Action');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (1, 'Chrono', 'RPG');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (3, 'Madden', 'Sports');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (4, 'FinalFantasy', 'RPG');
INSERT INTO "Video_Games" ("GameID", "GName", "GType") VALUES (6, 'FIFA', 'Sports');
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (101, 2, 50);
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (102, 2, 30);
INSERT INTO "Plays_Games" ("StuID", "GameID", "Hours_Played") VALUES (101, 3, 10);
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (101, 'Soccer', 10, 5, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gtype FROM (SELECT * FROM (SELECT * FROM (SELECT gameid, gtype, COUNT(*) AS n FROM video_games GROUP BY gameid, gtype) ORDER BY gameid) LIMIT 1);

/*
Gold Result:
('RPG',)
*/

-- Prediction Query
SELECT gtype FROM Video_games GROUP BY gtype ORDER BY COUNT(*), gtype NULLS LAST LIMIT 1;

/*
Prediction Result:
('Action',)
*/