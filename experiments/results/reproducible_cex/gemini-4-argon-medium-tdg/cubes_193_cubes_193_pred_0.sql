-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1: Core grouping, INNER JOIN vs OUTER JOIN, AVG vs AVG(DISTINCT), and ties in ORDER BY with NULLS LAST
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'John', 'Doe', 'R', '1990-01-01', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'John', 'Smith', 'L', '1992-05-12', 'GBR');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'Alice', 'Brown', 'R', '1995-03-20', 'CAN');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (4, NULL, 'NoFirstName', 'R', '1988-07-07', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (5, 'Unranked', 'Player', 'L', '1999-09-09', 'FRA');
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-01-01', 10, 1000, 15);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-01-08', 10, 1000, 15);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (2, '2020-01-01', 25, 500, 12);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (3, '2020-01-01', 15, 800, 10);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (4, '2020-01-01', 15, 800, 10);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (NULL, '2020-01-01', 1, 5000, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanranking AS avg_ranking_, first_name FROM (SELECT first_name, AVG(ranking) AS meanranking FROM (SELECT LHS.ranking_date AS ranking_date, LHS.ranking AS ranking, LHS.player_id AS player_id, LHS.ranking_points AS ranking_points, LHS.tours AS tours, RHS.first_name AS first_name, RHS.last_name AS last_name, RHS.hand AS hand, RHS.birth_date AS birth_date, RHS.country_code AS country_code FROM rankings AS LHS INNER JOIN players AS RHS ON (LHS.player_id = RHS.player_id)) GROUP BY first_name) ORDER BY avg_ranking_, first_name NULLS LAST;

/*
Gold Result:
(15.0, 'Alice')
(15.0, 'John')
(15.0, None)
*/

-- Prediction Query
SELECT AVG(ranking), T1.first_name FROM players AS T1 JOIN rankings AS T2 ON T1.player_id = T2.player_id GROUP BY T1.first_name;

/*
Prediction Result:
(15.0, None)
(15.0, 'Alice')
(15.0, 'John')
*/