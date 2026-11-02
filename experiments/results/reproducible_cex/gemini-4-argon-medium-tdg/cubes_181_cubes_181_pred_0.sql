-- Schema DDL
CREATE TABLE "players" ("player_id" INTEGER PRIMARY KEY, "first_name" TEXT, "last_name" TEXT, "hand" TEXT, "birth_date" DATE, "country_code" TEXT);

CREATE TABLE "matches" ("winner_id" INTEGER, "loser_id" INTEGER, "best_of" INTEGER, "draw_size" INTEGER, "loser_age" REAL, "loser_entry" TEXT, "loser_hand" TEXT, "loser_ht" INTEGER, "loser_ioc" TEXT, "loser_name" TEXT, "loser_rank" INTEGER, "loser_rank_points" INTEGER, "loser_seed" INTEGER, "match_num" INTEGER, "minutes" INTEGER, "round" TEXT, "score" TEXT, "surface" TEXT, "tourney_date" DATE, "tourney_id" TEXT, "tourney_level" TEXT, "tourney_name" TEXT, "winner_age" REAL, "winner_entry" TEXT, "winner_hand" TEXT, "winner_ht" INTEGER, "winner_ioc" TEXT, "winner_name" TEXT, "winner_rank" INTEGER, "winner_rank_points" INTEGER, "winner_seed" INTEGER, "year" INTEGER, FOREIGN KEY ("winner_id") REFERENCES "players" ("player_id"), FOREIGN KEY ("loser_id") REFERENCES "players" ("player_id"));

CREATE TABLE "rankings" ("player_id" INTEGER, "ranking_date" DATE, "ranking" INTEGER, "ranking_points" INTEGER, "tours" INTEGER, FOREIGN KEY ("player_id") REFERENCES "players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (1, 'Serena', 'Williams', 'R', '1981-09-26', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (2, 'Andre', 'Agassi', 'R', '1970-04-29', 'USA');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (3, 'Roger', 'Federer', 'R', '1981-08-08', 'SUI');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (4, 'Rafael', 'Nadal', 'L', '1986-06-03', NULL);
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (5, 'Pete', 'Sampras', 'R', '1971-08-12', 'usa');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (6, 'Andy', 'Roddick', 'R', '1982-08-30', 'USA ');
INSERT INTO players (player_id, first_name, last_name, hand, birth_date, country_code) VALUES (7, 'Venus', 'Williams', 'R', '1980-06-17', 'US');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_name", "birth_date" FROM "players" WHERE ("country_code" = 'USA') ORDER BY first_name, players.player_id NULLS LAST;

/*
Gold Result:
('Andre', '1970-04-29')
('Serena', '1981-09-26')
*/

-- Prediction Query
SELECT first_name, birth_date FROM players WHERE country_code = 'USA';

/*
Prediction Result:
('Serena', '1981-09-26')
('Andre', '1970-04-29')
*/