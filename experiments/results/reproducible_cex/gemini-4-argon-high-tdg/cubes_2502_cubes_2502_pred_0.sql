-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1001, 'Smith', 'Linda', 18, 'F', 600, 1121, 'BAL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1002, 'Kim', 'Tracy', 19, 'F', 600, 7712, 'HKG');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1003, 'Jones', 'Shiela', 21, 'F', 600, 7792, 'WAS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1004, 'Kumar', 'Apoorv', 20, 'M', 520, 8423, 'NYC');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (1, 'World of Warcraft', 'Massively multiplayer online game');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (2, 'Guild Wars', 'Massively multiplayer online game');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (3, 'World of Warcraft', 'Massively multiplayer online game');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (4, 'StarCraft', 'Real-time strategy');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (5, 'Hearthstone', 'Collectible card game');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (6, 'Mystery Game', NULL);
INSERT INTO Plays_Games (StuID, GameID, Hours_Played) VALUES (1001, 1, 50);
INSERT INTO Plays_Games (StuID, GameID, Hours_Played) VALUES (1002, 1, 120);
INSERT INTO Plays_Games (StuID, GameID, Hours_Played) VALUES (1003, 1, 80);
INSERT INTO Plays_Games (StuID, GameID, Hours_Played) VALUES (1004, 1, 30);
INSERT INTO Plays_Games (StuID, GameID, Hours_Played) VALUES (1001, 4, 15);
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (1001, 'Swimming', 10, 5, 'Y');
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