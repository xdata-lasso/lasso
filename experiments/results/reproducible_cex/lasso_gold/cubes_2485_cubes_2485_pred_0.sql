-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1016, 'Garcia', 'Noah', 1017, 'her', 1018, 1019, 'Cassandraton');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1021, 'Miller', 'Kelly', 1022, 'production', 1023, 1024, 'Barbaraland');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1026, 'Wyatt', 'Michelle', 1027, 'husband', 1028, 1029, 'Shawnstad');
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1020, 'Kimberly Dudley', 'human');
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1025, 'Darren Roberts', 'base');
INSERT INTO "video_games" ("gameid", "gname", "gtype") VALUES (1030, 'Darren Roberts', 'commercial');
INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (1016, 1020, 1001);
INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (1021, 1025, NULL);
INSERT INTO "plays_games" ("stuid", "gameid", "hours_played") VALUES (1026, 1030, 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gname FROM (SELECT gname, SUM(hours_played) AS sumhours_played FROM (SELECT * FROM (SELECT LHS.gameid AS gameid, LHS.gname AS gname, LHS.gtype AS gtype, RHS.stuid AS stuid, RHS.hours_played AS hours_played FROM video_games AS LHS INNER JOIN plays_games AS RHS ON (LHS.gameid = RHS.gameid)) WHERE (hours_played >= 1000)) GROUP BY gname) ORDER BY gname;

/*
Gold Result:
('Darren Roberts',)
('Kimberly Dudley',)
*/

-- Prediction Query
SELECT gname FROM Plays_games AS T1 JOIN Video_games AS T2 ON T1.gameid = T2.gameid GROUP BY T1.gameid HAVING SUM(hours_played) >= 1000;

/*
Prediction Result:
('Kimberly Dudley',)
('Darren Roberts',)
*/