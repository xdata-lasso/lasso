-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests COUNT(*) vs COUNT(hand), NULL group handling, and tie-breaking with NULLS LAST when counts are equal (count=2 for 'R', 'L', and NULL; count=1 for 'U').
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'Roger', 'Federer', 'R', '1981-08-08', 'SUI');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'Novak', 'Djokovic', 'R', '1987-05-22', 'SRB');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'Rafael', 'Nadal', 'L', '1986-06-03', 'ESP');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (4, 'Rod', 'Laver', 'L', '1938-08-09', 'AUS');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (5, 'John', 'Doe', NULL, '1990-01-01', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (6, 'Jane', 'Smith', NULL, '1992-02-02', 'GBR');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (7, 'Alex', 'Unknown', 'U', '1995-05-05', 'FRA');
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