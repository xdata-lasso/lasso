-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'John', 'Smith', 'R', '1990-05-10', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'John', 'Doe', 'L', '1992-08-15', 'GBR');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'Zack', 'Brown', 'R', '1995-01-20', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (4, 'Adam', 'White', 'L', '1988-11-30', 'CAN');
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2022-01-01', 10, 2000, 15);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2022-02-01', 10, 2000, 16);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (2, '2022-01-01', 25, 1200, 18);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (3, '2022-01-01', 2, 5000, 12);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (3, '2022-02-01', 5, 4200, 14);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (4, '2022-01-01', 30, 900, 20);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (4, '2022-02-01', 50, 600, 22);
INSERT INTO matches (winner_id, loser_id, best_of, draw_size, loser_age, loser_entry, loser_hand, loser_ht, loser_ioc, loser_name, loser_rank, loser_rank_points, loser_seed, match_num, minutes, round, score, surface, tourney_date, tourney_id, tourney_level, tourney_name, winner_age, winner_entry, winner_hand, winner_ht, winner_ioc, winner_name, winner_rank, winner_rank_points, winner_seed, year) VALUES (4, 3, 3, 32, 27.0, 'WC', 'R', 185, 'AUS', 'Zack', 100, 100, 8, 1, 90, 'F', '6-4 6-4', 'Hard', '2022-03-01', 'T1', 'A', 'Open', 33.0, 'Q', 'L', 190, 'CAN', 'Adam', 1, 9000, 1, 2022);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanranking AS avg_ranking_, first_name FROM (SELECT first_name, AVG(ranking) AS meanranking FROM (SELECT LHS.ranking_date AS ranking_date, LHS.ranking AS ranking, LHS.player_id AS player_id, LHS.ranking_points AS ranking_points, LHS.tours AS tours, RHS.first_name AS first_name, RHS.last_name AS last_name, RHS.hand AS hand, RHS.birth_date AS birth_date, RHS.country_code AS country_code FROM rankings AS LHS INNER JOIN players AS RHS ON (LHS.player_id = RHS.player_id)) GROUP BY first_name) ORDER BY avg_ranking_, first_name NULLS LAST;

/*
Gold Result:
(3.5, 'Zack')
(15.0, 'John')
(40.0, 'Adam')
*/

-- Prediction Query
SELECT AVG(ranking), T1.first_name FROM players AS T1 JOIN rankings AS T2 ON T1.player_id = T2.player_id GROUP BY T1.first_name;

/*
Prediction Result:
(40.0, 'Adam')
(15.0, 'John')
(3.5, 'Zack')
*/