-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic INNER JOIN, GROUP BY first_name (distinct from player_id or last_name), SUM(ranking_points) (including duplicate points), and primary/secondary ORDER BY.
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'John', 'Doe', 'R', '1990-01-01', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'John', 'Smith', 'L', '1992-05-05', 'GBR');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'Alex', 'Doe', 'R', '1988-08-08', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (4, 'Zack', 'Brown', 'R', '1995-12-12', 'CAN');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (5, 'Unranked', 'Player', 'L', '2000-01-01', 'FRA');
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-01-01', 10, 100, 5);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-01-08', 8, 100, 6);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (2, '2020-01-01', 5, 250, 10);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (3, '2020-01-01', 1, 500, 15);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (4, '2020-01-01', 2, 450, 12);
INSERT INTO matches (winner_id, loser_id, winner_name, loser_name, winner_rank_points, loser_rank_points) VALUES (5, 1, 'Unranked Player', 'John Doe', 1000, 2000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumranking_points AS sum_ranking_points_, first_name FROM (SELECT first_name, SUM(ranking_points) AS sumranking_points FROM (SELECT LHS.player_id AS player_id, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.hand AS hand, LHS.birth_date AS birth_date, LHS.country_code AS country_code, RHS.ranking_date AS ranking_date, RHS.ranking AS ranking, RHS.ranking_points AS ranking_points, RHS.tours AS tours FROM players AS LHS INNER JOIN rankings AS RHS ON (LHS.player_id = RHS.player_id)) GROUP BY first_name) ORDER BY sum_ranking_points_, first_name NULLS LAST;

/*
Gold Result:
(450, 'John')
(450, 'Zack')
(500, 'Alex')
*/

-- Prediction Query
SELECT SUM(ranking_points), T1.first_name FROM players AS T1 JOIN rankings AS T2 ON T1.player_id = T2.player_id GROUP BY T1.first_name;

/*
Prediction Result:
(500, 'Alex')
(450, 'John')
(450, 'Zack')
*/