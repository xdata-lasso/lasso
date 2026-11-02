-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (1, 'Stadium A', 10, 5000.0, 50000.0, 80.5);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (2, 'Stadium B', 20, 6000.0, 120000.0, 80.5);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (3, 'Stadium C', 20, 7000.0, 140000.0, 90.0);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (4, 'Stadium D', 30, 8000.0, 240000.0, 90.0);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (5, 'Stadium E', 30, 8500.0, 255000.0, 90.0);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (6, 'Stadium F', NULL, 4000.0, 0.0, 70.0);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (7, 'Stadium G', 15, 4500.0, 67500.0, NULL);
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (1, 1, 2023, '2023-05-01', 'Team A', 'Team B', '2-1', 'League');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (1, 1, 'John Doe', 'Sprain', '2', 'Official');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT home_games AS max_home_games_, minhome_games AS min_home_games_, AVG(home_games) OVER () AS avg_home_games_ FROM (SELECT capacity_percentage, MAX(home_games) OVER () AS home_games, minhome_games FROM (SELECT capacity_percentage, home_games, MIN(home_games) AS minhome_games FROM stadium GROUP BY capacity_percentage, home_games)) ORDER BY max_home_games_, min_home_games_ NULLS LAST, avg_home_games_ NULLS LAST;

/*
Gold Result:
(30, 10, 30.0)
(30, 15, 30.0)
(30, 20, 30.0)
(30, 30, 30.0)
(30, None, 30.0)
*/

-- Prediction Query
SELECT MAX(home_games), MIN(home_games), AVG(home_games) FROM stadium;

/*
Prediction Result:
(30, 10, 20.833333333333332)
*/