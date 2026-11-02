-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Season ASC, then game.id ASC, and ensures Home_team and Away_team are not swapped or confused with other columns.
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (1, 'MetLife Stadium', 10, 50000.0, 500000.0, 95.5);
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (10, 1, 2022, '2022-09-01', 'Alpha', 'Beta', '2-1', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (5, 1, 2022, '2022-09-02', 'Gamma', 'Delta', '0-0', 'Cup');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (1, 1, 2023, '2023-01-15', 'Epsilon', 'Zeta', '1-3', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (20, 1, 2021, '2021-05-10', 'Eta', 'Theta', '4-2', 'Friendly');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT season, home_team, away_team FROM game ORDER BY season, game.id NULLS LAST;

/*
Gold Result:
(2021, 'Eta', 'Theta')
(2022, 'Gamma', 'Delta')
(2022, 'Alpha', 'Beta')
(2023, 'Epsilon', 'Zeta')
*/

-- Prediction Query
SELECT season, home_team, away_team FROM game;

/*
Prediction Result:
(2023, 'Epsilon', 'Zeta')
(2022, 'Gamma', 'Delta')
(2022, 'Alpha', 'Beta')
(2021, 'Eta', 'Theta')
*/