-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: stadium --
INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (-2147483648, '5k5swwqcgs', 247012447, 868.436572, 537.136345, 38.937207);

-- Inserting into table: game --
INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (1, -2147483648, 2011, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (3, -2147483648, 2011, '9000t5c4ec', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (4, -2147483648, -1822992503, 'liqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr');

INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (8, -2147483648, 2011, '5sw', 'qcgsk9', '8c4p', 'u7', 'fe4hri');

INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (6, -2147483648, 2011, 'ypuzhsrw', 'b', 'p6luhvdlttil', 'n', 'rmdp');

-- Inserting into table: injury_accident --
INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483648, 1, 'bnp', 'mdpos', 'ie5', 'nw6klf');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483647, 4, '13pyu', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483646, 4, 'z0f8jegd21vy', '9uxj4hwbdvl', 'h2gn', 'q');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483645, 4, 'qcx5', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483644, 4, 'k3zbily', 'kn6vc', '6ah', 'f8jswwl');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (2, 1, 'xb72fxa7r', 'fdrz16n', 'jja', '5dh');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (3, 1, 'ogrgjd8y', 't1afgog', 'itsj3', 'y');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483641, 1, '4301jh3den8', 'c68x8vacx7', 'f', '5w1of7');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (-2147483640, 1, '72ct', 'c', 'mfg62', '0v');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (5, 8, 'siie', 't1__96ec11', 'unw6klfa', '9000t5c4ec');

INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (7, 3, 'gce376nium52', 't1__96ec11', 'zbuo4nrqrof', 'qyp5s5bbp0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count_distinct_t1_injury_ FROM (SELECT injury, COUNT(DISTINCT injury) AS n_distinct FROM (SELECT * FROM injury_accident AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT * FROM game WHERE (season > 2010)) AS RHS WHERE (LHS.id = RHS.id))) GROUP BY injury) ORDER BY count_distinct_t1_injury_;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.injury) FROM injury_accident AS T1 JOIN game AS T2 ON T1.game_id = T2.id WHERE T2.season > 2010;

/*
Prediction Result:
(6,)
*/