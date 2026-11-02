-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary condition (Hours_Played = 1000 vs 999 vs 1001) and WHERE vs HAVING (multiple rows < 1000 summing to >= 1000).
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'John', 20, 'M', 100, 200, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Doe', 'Jane', 21, 'F', 101, 201, 'LAX');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (10, 'AlphaGame', 'RPG');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (20, 'BetaGame', 'FPS');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (30, 'GammaGame', 'RTS');
INSERT INTO Video_Games (GameID, GName, GType) VALUES (40, 'DeltaGame', 'MMO');
INSERT INTO Plays_Games (StuID, GameID, Hours_Played) VALUES (1, 10, 1000);
INSERT INTO Plays_Games (StuID, GameID, Hours_Played) VALUES (1, 20, 999);
INSERT INTO Plays_Games (StuID, GameID, Hours_Played) VALUES (1, 30, 600);
INSERT INTO Plays_Games (StuID, GameID, Hours_Played) VALUES (2, 30, 600);
INSERT INTO Plays_Games (StuID, GameID, Hours_Played) VALUES (1, 40, 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gname FROM (SELECT gname, SUM(hours_played) AS sumhours_played FROM (SELECT * FROM (SELECT LHS.gameid AS gameid, LHS.gname AS gname, LHS.gtype AS gtype, RHS.stuid AS stuid, RHS.hours_played AS hours_played FROM video_games AS LHS INNER JOIN plays_games AS RHS ON (LHS.gameid = RHS.gameid)) WHERE (hours_played >= 1000)) GROUP BY gname) ORDER BY gname;

/*
Gold Result:
('AlphaGame',)
('DeltaGame',)
*/

-- Prediction Query
SELECT gname FROM Plays_games AS T1 JOIN Video_games AS T2 ON T1.gameid = T2.gameid GROUP BY T1.gameid HAVING SUM(hours_played) >= 1000;

/*
Prediction Result:
('AlphaGame',)
('GammaGame',)
('DeltaGame',)
*/