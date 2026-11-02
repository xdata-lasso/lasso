-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests COUNT(*) vs COUNT(country_code), NULLS LAST vs NULLS FIRST, and primary/secondary sorting orders (ASC vs DESC)
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'John', 'Doe', 'R', '1990-01-01', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'Jane', 'Smith', 'L', '1992-05-15', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'Carlos', 'Gomez', 'R', '1988-03-20', 'ESP');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (4, 'Rafael', 'Nadal', 'L', '1986-06-03', 'ESP');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (5, 'Unknown', 'One', 'U', '1995-07-07', NULL);
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (6, 'Unknown', 'Two', 'R', '1996-08-08', NULL);
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (7, 'Pierre', 'Dupont', 'R', '1991-11-11', 'FRA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, country_code FROM (SELECT country_code, COUNT(*) AS n FROM players GROUP BY country_code) ORDER BY count___, country_code NULLS LAST;

/*
Gold Result:
(1, 'FRA')
(2, 'ESP')
(2, 'USA')
(2, None)
*/

-- Prediction Query
SELECT COUNT(*), country_code FROM players GROUP BY country_code;

/*
Prediction Result:
(2, None)
(2, 'ESP')
(1, 'FRA')
(2, 'USA')
*/