-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, first_name) VALUES (1, 'A');
INSERT INTO players (player_id, first_name) VALUES (2, 'B');
INSERT INTO rankings (player_id, ranking) VALUES (1, 10);
INSERT INTO rankings (player_id, ranking) VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanranking AS avg_ranking_, first_name FROM (SELECT first_name, AVG(ranking) AS meanranking FROM (SELECT LHS.ranking_date AS ranking_date, LHS.ranking AS ranking, LHS.player_id AS player_id, LHS.ranking_points AS ranking_points, LHS.tours AS tours, RHS.first_name AS first_name, RHS.last_name AS last_name, RHS.hand AS hand, RHS.birth_date AS birth_date, RHS.country_code AS country_code FROM rankings AS LHS INNER JOIN players AS RHS ON (LHS.player_id = RHS.player_id)) GROUP BY first_name) ORDER BY avg_ranking_, first_name NULLS LAST;

/*
Gold Result:
(1.0, 'B')
(10.0, 'A')
*/

-- Prediction Query
SELECT AVG(ranking), T1.first_name FROM players AS T1 JOIN rankings AS T2 ON T1.player_id = T2.player_id GROUP BY T1.first_name;

/*
Prediction Result:
(10.0, 'A')
(1.0, 'B')
*/