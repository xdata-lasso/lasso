-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (1, 'Alpha Arena', 18, 15000.0, 270000.0, 75.0);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (2, 'Beta Bowl', 12, 12000.0, 144000.0, 80.0);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (3, 'Gamma Ground', 25, 20000.0, 500000.0, 80.0);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (4, 'Delta Dome', 18, 18000.0, 324000.0, 90.0);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (5, 'Epsilon Park', 30, 25000.0, 750000.0, 85.0);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (6, 'Zeta Field', 30, 24000.0, 720000.0, 85.0);
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (1, 1, 2022, '2022-05-01', 'Lions', 'Tigers', '2-1', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (2, 1, 2022, '2022-05-08', 'Lions', 'Bears', '1-1', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (3, 2, 2022, '2022-06-10', 'Eagles', 'Hawks', '0-3', 'Cup');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (1, 1, 'John Doe', 'Hamstring', '3', 'Official Report');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (2, 3, 'Alex Smith', 'Ankle Sprain', '2', 'Club News');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT home_games AS max_home_games_, minhome_games AS min_home_games_, AVG(home_games) OVER () AS avg_home_games_ FROM (SELECT capacity_percentage, MAX(home_games) OVER () AS home_games, minhome_games FROM (SELECT capacity_percentage, home_games, MIN(home_games) AS minhome_games FROM stadium GROUP BY capacity_percentage, home_games)) ORDER BY max_home_games_, min_home_games_ NULLS LAST, avg_home_games_ NULLS LAST;

/*
Gold Result:
(30, 12, 30.0)
(30, 18, 30.0)
(30, 25, 30.0)
(30, 30, 30.0)
*/

-- Prediction Query
SELECT MAX(home_games), MIN(home_games), AVG(home_games) FROM stadium;

/*
Prediction Result:
(30, 12, 22.166666666666668)
*/