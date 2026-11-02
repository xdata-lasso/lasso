-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'Zack', 'Taylor', 'R', '1990-05-12', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'Alice', 'Brown', 'L', '1992-08-20', 'GBR');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'Alice', 'Green', 'R', '1995-01-15', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (4, 'Bob', 'White', 'R', '1988-11-03', 'CAN');
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-01-06', 50, 100, 12);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-01-13', 48, 100, 13);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (2, '2020-01-06', 30, 250, 15);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (3, '2020-01-06', 20, 350, 18);
INSERT INTO matches (winner_id, loser_id, best_of, draw_size, loser_age, loser_entry, loser_hand, loser_ht, loser_ioc, loser_name, loser_rank, loser_rank_points, loser_seed, match_num, minutes, round, score, surface, tourney_date, tourney_id, tourney_level, tourney_name, winner_age, winner_entry, winner_hand, winner_ht, winner_ioc, winner_name, winner_rank, winner_rank_points, winner_seed, year) VALUES (4, 1, 3, 32, 29.6, 'WC', 'R', 185, 'USA', 'Zack Taylor', 50, 100, 5, 1, 95, 'R32', '6-4 6-4', 'Hard', '2020-01-07', '2020-001', 'A', 'Open', 31.1, 'Q', 'R', 188, 'CAN', 'Bob White', 10, 999, 1, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumranking_points AS sum_ranking_points_, first_name FROM (SELECT first_name, SUM(ranking_points) AS sumranking_points FROM (SELECT LHS.player_id AS player_id, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.hand AS hand, LHS.birth_date AS birth_date, LHS.country_code AS country_code, RHS.ranking_date AS ranking_date, RHS.ranking AS ranking, RHS.ranking_points AS ranking_points, RHS.tours AS tours FROM players AS LHS INNER JOIN rankings AS RHS ON (LHS.player_id = RHS.player_id)) GROUP BY first_name) ORDER BY sum_ranking_points_, first_name NULLS LAST;

/*
Gold Result:
(200, 'Zack')
(600, 'Alice')
*/

-- Prediction Query
SELECT SUM(ranking_points), T1.first_name FROM players AS T1 JOIN rankings AS T2 ON T1.player_id = T2.player_id GROUP BY T1.first_name;

/*
Prediction Result:
(600, 'Alice')
(200, 'Zack')
*/