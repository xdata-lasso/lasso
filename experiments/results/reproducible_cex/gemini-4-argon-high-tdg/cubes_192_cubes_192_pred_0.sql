-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'Novak', 'Djokovic', 'U', '1987-05-22', 'SRB');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'Rafael', 'Nadal', 'L', '1986-06-03', 'ESP');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'Rafael', 'Nadal', 'L', NULL, 'ESP');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (4, 'Roger', 'Federer', 'R', '1981-08-08', 'SUI');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (5, NULL, NULL, 'R', NULL, NULL);
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (6, 'Andy', 'Murray', NULL, '1987-05-15', 'GBR');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (7, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-01-01', 1, 9000, 18);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-02-01', 1, 9500, 19);
INSERT INTO matches (winner_id, loser_id, best_of, draw_size, loser_age, loser_entry, loser_hand, loser_ht, loser_ioc, loser_name, loser_rank, loser_rank_points, loser_seed, match_num, minutes, round, score, surface, tourney_date, tourney_id, tourney_level, tourney_name, winner_age, winner_entry, winner_hand, winner_ht, winner_ioc, winner_name, winner_rank, winner_rank_points, winner_seed, year) VALUES (1, 2, 3, 32, 33.5, NULL, 'L', 185, 'ESP', 'Rafael Nadal', 2, 8000, 2, 1, 120, 'F', '6-4 6-4', 'Hard', '2020-01-15', '2020-001', 'A', 'ATP Cup', 32.6, NULL, 'R', 188, 'SRB', 'Novak Djokovic', 1, 9000, 1, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, hand FROM (SELECT hand, COUNT(*) AS n FROM players GROUP BY hand) ORDER BY count___, hand NULLS LAST;

/*
Gold Result:
(1, 'U')
(2, 'L')
(2, 'R')
(2, None)
*/

-- Prediction Query
SELECT COUNT(*), hand FROM players GROUP BY hand;

/*
Prediction Result:
(2, None)
(2, 'L')
(2, 'R')
(1, 'U')
*/