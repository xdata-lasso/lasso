-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (1, 'Stadium A', 10, 1000.0, 10000.0, 50.0);
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (1, 1, 2020, '2020-01-01', 'Team A', 'Team B', '1-0', 'League');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (1, 1, 'B', 'Foot injury', '2', 'Source 1');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (2, 1, 'A', 'Foot injury', '3', 'Source 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "player", "number_of_matches", "source" FROM "injury_accident" WHERE ("injury" <> 'Knee problem') ORDER BY player, injury_accident.id NULLS LAST;

/*
Gold Result:
('A', '3', 'Source 2')
('B', '2', 'Source 1')
*/

-- Prediction Query
SELECT player, number_of_matches, SOURCE FROM injury_accident WHERE injury <> 'Knee problem';

/*
Prediction Result:
('B', '2', 'Source 1')
('A', '3', 'Source 2')
*/