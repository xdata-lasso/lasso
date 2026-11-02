-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (1, 'MetLife Stadium', 8, 75000.0, 600000.0, 92.5);
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (10, 1, 2022, '2022-09-11', 'Giants', 'Titans', '21-20', 'Regular');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (20, NULL, 2020, '2020-10-04', 'Jets', 'Broncos', '28-37', 'Regular');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (5, 1, 2021, '2021-11-07', 'Giants', 'Raiders', '23-16', 'Regular');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (1, 10, 'Sterling Shepard', 'Knee', '15', 'Official');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (2, 10, 'WanDale Robinson', 'Knee', '6', 'Official');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT season, home_team, away_team FROM game ORDER BY season, game.id NULLS LAST;

/*
Gold Result:
(2020, 'Jets', 'Broncos')
(2021, 'Giants', 'Raiders')
(2022, 'Giants', 'Titans')
*/

-- Prediction Query
SELECT season, home_team, away_team FROM game;

/*
Prediction Result:
(2021, 'Giants', 'Raiders')
(2022, 'Giants', 'Titans')
(2020, 'Jets', 'Broncos')
*/