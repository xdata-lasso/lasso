-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT home_games AS max_home_games_, minhome_games AS min_home_games_, AVG(home_games) OVER () AS avg_home_games_ FROM (SELECT capacity_percentage, MAX(home_games) OVER () AS home_games, minhome_games FROM (SELECT capacity_percentage, home_games, MIN(home_games) AS minhome_games FROM stadium GROUP BY capacity_percentage, home_games)) ORDER BY max_home_games_, min_home_games_ NULLS LAST, avg_home_games_ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT MAX(home_games), MIN(home_games), AVG(home_games) FROM stadium;

/*
Prediction Result:
(None, None, None)
*/