-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (1, 'Alpha Arena', 10, 25000.0, 250000.0, 85.5);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (2, 'Beta Park', 12, 30000.0, 360000.0, 90.0);
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (3, 'Gamma Field', 8, 15000.0, 120000.0, 75.2);
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (1, 3, 2021, '2021-09-10', 'Rovers', 'United', '2-1', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (2, 3, 2019, '2019-12-01', 'Team M', 'Team Z', '1-0', 'Cup');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (5, 2, 2019, '2019-05-01', 'Team Z', 'Team A', '3-3', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (10, 1, 2019, '2019-01-01', 'Team A', 'Team M', '0-2', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (11, 1, 2018, '2018-04-15', 'City', 'Wanderers', '4-0', 'League');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (1, 1, 'John Doe', 'Hamstring', '3', 'Official');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (2, 1, 'Jane Roe', 'Ankle', '5', 'Press');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (3, 5, 'Max Mustermann', 'Knee', '2', 'Club');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT season, home_team, away_team FROM game ORDER BY season, game.id NULLS LAST;

/*
Gold Result:
(2018, 'City', 'Wanderers')
(2019, 'Team M', 'Team Z')
(2019, 'Team Z', 'Team A')
(2019, 'Team A', 'Team M')
(2021, 'Rovers', 'United')
*/

-- Prediction Query
SELECT season, home_team, away_team FROM game;

/*
Prediction Result:
(2021, 'Rovers', 'United')
(2019, 'Team M', 'Team Z')
(2019, 'Team Z', 'Team A')
(2019, 'Team A', 'Team M')
(2018, 'City', 'Wanderers')
*/