-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "stadium" ("id", "name", "Home_Games", "Average_Attendance", "Total_Attendance", "Capacity_Percentage") VALUES (1, 'Olympic Stadium', 10, 50000.0, 500000.0, 85.5);
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (3, 1, 2021, '2021-05-10', 'Team A', 'Team B', '2-1', 'League');
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (1, 1, 2021, '2021-05-10', 'Team C', 'Team D', '0-0', 'League');
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (2, 1, 2021, '2021-01-15', 'Team E', 'Team F', '1-3', 'Cup');
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (4, 1, 2021, '2021-11-20', 'Team G', 'Team H', '4-2', 'League');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM game ORDER BY date, game.id NULLS LAST;

/*
Gold Result:
('2021-01-15',)
('2021-05-10',)
('2021-05-10',)
('2021-11-20',)
*/

-- Prediction Query
SELECT Date FROM game ORDER BY home_team DESC, game.id NULLS LAST;

/*
Prediction Result:
('2021-11-20',)
('2021-01-15',)
('2021-05-10',)
('2021-05-10',)
*/