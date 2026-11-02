-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (1, 'MetLife Stadium', 8, 75000.0, 600000.0, 92.5);
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (1, 1, 2022, '2022-09-11', 'Giants', 'Titans', '21-20', 'Regular Season');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (1, 1, 'Player A', 'Knee', '3', 'ESPN');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (2, 1, 'Player B', 'Ankle', '3', 'BBC');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (3, 1, 'Player C', 'Shoulder', '3', 'Sky');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (4, 1, 'Player D', 'Hamstring', '1', 'ESPN');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (5, 1, 'Player E', 'Concussion', '2', 'ESPN');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (6, 1, 'Player F', 'Back', '2', 'ESPN');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (7, 1, 'Player G', 'Wrist', '2', 'Fox');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (8, 1, 'Player H', 'Calf', '5', 'BBC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count_distinct_source_ FROM (SELECT number_of_matches, COUNT(DISTINCT SOURCE) AS n_distinct FROM injury_accident GROUP BY number_of_matches) ORDER BY count_distinct_source_;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT SOURCE) FROM injury_accident;

/*
Prediction Result:
(4,)
*/