-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'Roger', 'Federer', 'R', '1981-08-08', 'SUI');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'Rafael', 'Nadal', 'L', '1986-06-03', 'ESP');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'Novak', 'Djokovic', 'R', '1987-05-22', 'SRB');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (4, 'Andy', 'Murray', 'R', '1987-05-15', 'GBR');
INSERT INTO matches (winner_id, loser_id, best_of, draw_size, match_num, surface, tourney_date, tourney_id, tourney_level, tourney_name, year) VALUES (1, 2, 3, 32, 1, 'Hard', '2023-01-01', 'T1', 'A', 'Open A', 2023);
INSERT INTO matches (winner_id, loser_id, best_of, draw_size, match_num, surface, tourney_date, tourney_id, tourney_level, tourney_name, year) VALUES (1, 3, 3, 32, 2, 'Hard', '2023-01-02', 'T1', 'A', 'Open A', 2023);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2023-01-01', 5, 500, 10);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (2, '2023-01-01', 6, 400, 10);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (3, '2023-01-01', 7, 300, 15);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2023-02-01', 100, 50, 8);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (2, '2023-02-01', 200, 40, 12);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (3, '2023-03-01', 50, 1000, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumtours AS sum_tours_, ranking_date FROM (SELECT ranking_date, SUM(tours) AS sumtours FROM rankings GROUP BY ranking_date) ORDER BY sum_tours_, ranking_date NULLS LAST;

/*
Gold Result:
(5, '2023-03-01')
(20, '2023-02-01')
(35, '2023-01-01')
*/

-- Prediction Query
SELECT SUM(tours), ranking_date FROM rankings GROUP BY ranking_date;

/*
Prediction Result:
(35, '2023-01-01')
(20, '2023-02-01')
(5, '2023-03-01')
*/