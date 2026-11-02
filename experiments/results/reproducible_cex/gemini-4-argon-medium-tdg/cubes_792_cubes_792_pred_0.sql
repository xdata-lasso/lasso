-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (1, 'Olympic Stadium', 10, 50000.0, 500000.0, 85.5);
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (1, 1, 2023, '2023-05-01', 'Team A', 'Team B', '2-1', 'League');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (1, 1, 'Player 1', 'Knee', '5', 'BBC');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (2, 1, 'Player 2', 'Ankle', '5', 'BBC');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (3, 1, 'Player 3', 'Hamstring', '5', 'ESPN');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (4, 1, 'Player 4', 'Concussion', '2', 'Sky');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (5, 1, 'Player 5', 'Shoulder', '3', 'BBC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count_distinct_source_ FROM (SELECT number_of_matches, COUNT(DISTINCT SOURCE) AS n_distinct FROM injury_accident GROUP BY number_of_matches) ORDER BY count_distinct_source_;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT SOURCE) FROM injury_accident;

/*
Prediction Result:
(3,)
*/