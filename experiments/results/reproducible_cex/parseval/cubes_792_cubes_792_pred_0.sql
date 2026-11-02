-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: stadium --
INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (-2147483648, '5k5swwqcgs', 247012447, 868.436572, 537.136345, 38.937207);

-- Inserting into table: game --
INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (-2147483648, -2147483648, -734455130, '4h', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos');

-- Inserting into table: injury_accident --
INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483648, -2147483648, 'ie5', 'nw6klf', 'inj_8ec12d', 'a9000t5c4eci');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483647, -2147483648, 'e', '76nium52', 'inj_8ec12d', 'zbuo4nrqrof');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483646, -2147483648, 'p5s5bbp', '02eutliqa11r', 'inj_8ec12d', 'ytoo3o9');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483645, -2147483648, '72k', 'ex1', 'inj_8ec12d', 'ji7zwau2');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483644, -2147483648, 'yrq13p', 'u78d99r', 'inj_8ec12d', 'jsl');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483643, -2147483648, '4', 'p5qi2rk', 'inj_8ec12d', '9v');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483642, -2147483648, 'x58pz0f8je', 'd2', NULL, 'vy9uxj4');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483641, -2147483648, 'bdvlph', 'gndqwnqc', NULL, 'x5hncprjtu0');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483640, -2147483648, '79fjgq8', 'n2f3dqv0gcb9', NULL, 'ozk3zbily');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483639, -2147483648, 'kn6vck6ah0f8', 'sww', NULL, 'q7x');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483638, -2147483648, '72fxa7ryfd', 'z16ni', NULL, 'jai');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483637, -2147483648, 'h', 'ogrgjd8y', 'inj_8ec12d', 't1afgog');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483636, -2147483648, 'tsj', 'ayxp1q43', 'inj_8ec12d', '1jh3den');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483635, -2147483648, '68x8vacx7a', 'u5', 'inj_8ec12d', '1of77p');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483634, -2147483648, '72ct', 'c', 'inj_8ec12d', 'mfg62');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483633, -2147483648, 'v5q8qdj', 'e1io', 'inj_8ec12d', '278507cv');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483632, -2147483648, 'ptt', '6b', 'inj_8ec12d', 'ou5z');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count_distinct_source_ FROM (SELECT number_of_matches, COUNT(DISTINCT SOURCE) AS n_distinct FROM injury_accident GROUP BY number_of_matches) ORDER BY count_distinct_source_;

/*
Gold Result:
(5,)
(12,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT SOURCE) FROM injury_accident;

/*
Prediction Result:
(17,)
*/