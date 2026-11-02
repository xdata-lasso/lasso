-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard grouping, varying counts, tie-breaking by country_code, and NULL country_code handling (COUNT(*) vs COUNT(country_code), NULLS LAST vs NULLS FIRST).
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'John', 'Doe', 'R', '1990-01-01', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'Jane', 'Doe', 'L', '1992-02-02', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'Jim', 'Beam', 'R', '1988-03-03', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (4, 'Pierre', 'Dupont', 'R', '1995-04-04', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (5, 'Marie', 'Curie', 'L', '1991-05-05', 'FRA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (6, 'Carlos', 'Sainz', 'R', '1994-06-06', 'ESP');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (7, 'Rafael', 'Nadal', 'L', '1986-06-03', 'ESP');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (8, 'Novak', 'Djokovic', 'R', '1987-05-22', 'SRB');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (9, 'Unknown', 'One', 'R', '2000-01-01', NULL);
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (10, 'Unknown', 'Two', 'U', '2001-01-01', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, country_code FROM (SELECT country_code, COUNT(*) AS n FROM players GROUP BY country_code) ORDER BY count___, country_code NULLS LAST;

/*
Gold Result:
(1, 'SRB')
(2, 'ESP')
(2, 'FRA')
(2, None)
(3, 'USA')
*/

-- Prediction Query
SELECT COUNT(*), country_code FROM players GROUP BY country_code;

/*
Prediction Result:
(2, None)
(2, 'ESP')
(2, 'FRA')
(1, 'SRB')
(3, 'USA')
*/