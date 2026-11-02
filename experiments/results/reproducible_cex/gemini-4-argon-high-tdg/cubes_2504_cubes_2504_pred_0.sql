-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1001, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (12, 'OmegaGame', 'Z_Simulation');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (5, 'AlphaGame', 'Action');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (2, 'MidGame', 'Strategy Game');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (10, 'SimOne', 'Z_Simulation');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (8, 'StratTwo', 'Strategy Game');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (11, 'SimTwo', 'Z_Simulation');
INSERT INTO Plays_Games (StuID, GameID, Hours_Played) VALUES (1001, 5, 10);
INSERT INTO Plays_Games (StuID, GameID, Hours_Played) VALUES (1001, 10, 50);
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (1001, 'Soccer', 10, 5, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gtype FROM (SELECT * FROM (SELECT * FROM (SELECT gameid, gtype, COUNT(*) AS n FROM video_games GROUP BY gameid, gtype) ORDER BY gameid) LIMIT 1);

/*
Gold Result:
('Strategy Game',)
*/

-- Prediction Query
SELECT gtype FROM Video_games GROUP BY gtype ORDER BY COUNT(*), gtype NULLS LAST LIMIT 1;

/*
Prediction Result:
('Action',)
*/