-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: stadium --
INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (-2147483648, '5k5swwqcgs', 1, 171.746906, 557.512061, 1.0);

INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (-2147483647, '8c4pgu7vfe', 1, 483.665643, 818.685402, 1.0);

INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (-2147483646, 'ri', 1, 710.998147, 945.642658, 1.0);

INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (-2147483645, 'ypuzhsrw', NULL, 944.247544, 994.117864, 749.826493);

INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (-2147483644, 'luhvdltti', NULL, 182.319045, 998.421621, 1.0);

INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (-2147483643, 'prmd', NULL, 792.223623, 938.037625, 1.0);

INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (-2147483642, 'posiie5unw6k', NULL, 768.216462, 83.204633, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT home_games AS max_home_games_, minhome_games AS min_home_games_, AVG(home_games) OVER () AS avg_home_games_ FROM (SELECT capacity_percentage, MAX(home_games) OVER () AS home_games, minhome_games FROM (SELECT capacity_percentage, home_games, MIN(home_games) AS minhome_games FROM stadium GROUP BY capacity_percentage, home_games)) ORDER BY max_home_games_, min_home_games_ NULLS LAST, avg_home_games_ NULLS LAST;

/*
Gold Result:
(1, 1, 1.0)
(1, None, 1.0)
*/

-- Prediction Query
SELECT MAX(home_games), MIN(home_games), AVG(home_games) FROM stadium;

/*
Prediction Result:
(1, 1, 1.0)
*/