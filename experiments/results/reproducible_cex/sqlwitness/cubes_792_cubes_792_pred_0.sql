-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO game (id, stadium_id, season, date, home_team, away_team, score, competition) VALUES (1, NULL, 0, NULL, NULL, 'default1', NULL, NULL), (0, NULL, NULL, 'default1', 'default1', 'default2', NULL, 'default2'), (2, NULL, NULL, 'default1', NULL, 'default2', 'default2', 'default2'), (3, NULL, 0, 'default2', 'default2', NULL, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count_distinct_source_ FROM (SELECT number_of_matches, COUNT(DISTINCT SOURCE) AS n_distinct FROM injury_accident GROUP BY number_of_matches) ORDER BY count_distinct_source_;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(DISTINCT SOURCE) FROM injury_accident;

/*
Prediction Result:
(0,)
*/