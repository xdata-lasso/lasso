-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("id", "name", "Home_Games", "Average_Attendance", "Total_Attendance", "Capacity_Percentage") VALUES (1, 'Stadium A', 10, 5000.0, 50000.0, 80.0);
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (1, 1, 2020, '2020-01-01', 'Team A', 'Team B', '1-0', 'League');
INSERT INTO "game" ("id", "stadium_id", "Season", "Date", "Home_team", "Away_team", "Score", "Competition") VALUES (2, 1, 2021, '2021-01-01', 'Team C', 'Team D', '2-1', 'League');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (1, 1, 'Player Z', 'Knee', '2', 'Report');
INSERT INTO "injury_accident" ("id", "game_id", "Player", "Injury", "Number_of_matches", "Source") VALUES (2, 2, 'Player A', 'Ankle', '1', 'Report');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, player FROM (SELECT LHS.stadium_id AS stadium_id, LHS.id AS id, LHS.season AS season, LHS.date AS date, LHS.home_team AS home_team, LHS.away_team AS away_team, LHS.score AS score, LHS.competition AS competition, RHS.id AS id_other, RHS.player AS player, RHS.injury AS injury, RHS.number_of_matches AS number_of_matches, RHS.source AS SOURCE FROM game AS LHS INNER JOIN injury_accident AS RHS ON (LHS.id = RHS.game_id)) ORDER BY date, player NULLS LAST;

/*
Gold Result:
('2020-01-01', 'Player Z')
('2021-01-01', 'Player A')
*/

-- Prediction Query
SELECT T1.date, T2.player FROM game AS T1 JOIN injury_accident AS T2 ON T1.id = T2.game_id ORDER BY T1.season DESC, T1.id NULLS LAST, T2.id NULLS LAST;

/*
Prediction Result:
('2021-01-01', 'Player A')
('2020-01-01', 'Player Z')
*/