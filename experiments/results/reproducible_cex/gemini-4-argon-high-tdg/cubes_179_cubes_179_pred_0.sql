-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, NULL, 'Smith', NULL, NULL, 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, NULL, 'Smith', NULL, NULL, 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, NULL, 'Smith', NULL, NULL, 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (4, 'John', 'Doe', 'R', '1990-01-01', NULL);
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (5, 'Jane', 'Roe', 'L', '1992-05-10', NULL);
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (6, 'Andy', 'Murray', 'R', '1987-05-15', 'GBR');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (7, 'Tim', 'Henman', 'L', '1974-09-06', 'GBR');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (8, 'Lleyton', 'Hewitt', 'R', '1981-02-24', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (9, 'Pat', 'Rafter', 'R', '1972-12-28', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (10, 'Rafael', 'Nadal', 'L', '1986-06-03', 'ESP');
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-01-01', 1, 5000, 15);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (1, '2020-02-01', 2, 4800, 15);
INSERT INTO rankings (player_id, ranking_date, ranking, ranking_points, tours) VALUES (8, '2020-01-01', 10, 2000, 12);
INSERT INTO matches (winner_id, loser_id, best_of, draw_size, loser_age, loser_entry, loser_hand, loser_ht, loser_ioc, loser_name, loser_rank, loser_rank_points, loser_seed, match_num, minutes, round, score, surface, tourney_date, tourney_id, tourney_level, tourney_name, winner_age, winner_entry, winner_hand, winner_ht, winner_ioc, winner_name, winner_rank, winner_rank_points, winner_seed, year) VALUES (1, 8, 3, 32, 28.0, 'WC', 'R', 180, 'SUI', 'Lleyton Hewitt', 10, 2000, 2, 1, 90, 'F', '6-4 6-4', 'Hard', '2020-01-15', 'T1', 'A', 'Open', 30.0, 'Q', 'R', 185, 'SUI', 'Smith', 1, 5000, 1, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, country_code FROM (SELECT country_code, COUNT(*) AS n FROM players GROUP BY country_code) ORDER BY count___, country_code NULLS LAST;

/*
Gold Result:
(1, 'ESP')
(2, 'AUS')
(2, 'GBR')
(2, None)
(3, 'USA')
*/

-- Prediction Query
SELECT COUNT(*), country_code FROM players GROUP BY country_code;

/*
Prediction Result:
(2, None)
(2, 'AUS')
(1, 'ESP')
(2, 'GBR')
(3, 'USA')
*/